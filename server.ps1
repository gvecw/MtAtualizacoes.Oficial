$port = 8082
$basePath = $PSScriptRoot

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")
$listener.Prefixes.Add("http://127.0.0.1:$port/")

try {
    $listener.Start()
    Write-Host "Servidor super rápido rodando em http://localhost:$port"
} catch {
    Write-Host "Falha ao iniciar: $($_.Exception.Message)"
    exit 1
}

while ($listener.IsListening) {
    try {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response
        
        $path = $request.Url.LocalPath.TrimStart('/')
        
        if ($path -eq '_next/image') {
            $urlParam = [regex]::Match($request.Url.Query, 'url=([^&]+)').Groups[1].Value
            if ($urlParam) {
                $decodedUrl = [System.Uri]::UnescapeDataString($urlParam)
                $path = $decodedUrl.TrimStart('/')
            }
        }
        
        if ($path -eq '' -or $path -eq '/') { $path = 'index.html' }
        $localPath = [IO.Path]::Combine($basePath, $path.Replace('/', '\'))
        
        $response.Headers.Add("Access-Control-Allow-Origin", "*")
        
        if ([IO.File]::Exists($localPath)) {
            $ext = [IO.Path]::GetExtension($localPath).ToLower()
            switch ($ext) {
                ".js"    { $response.ContentType = "application/javascript" }
                ".css"   { $response.ContentType = "text/css" }
                ".html"  { $response.ContentType = "text/html; charset=utf-8" }
                ".jpg"   { $response.ContentType = "image/jpeg" }
                ".jpeg"  { $response.ContentType = "image/jpeg" }
                ".png"   { $response.ContentType = "image/png" }
                ".gif"   { $response.ContentType = "image/gif" }
                ".svg"   { $response.ContentType = "image/svg+xml" }
                ".webp"  { $response.ContentType = "image/webp" }
                ".ico"   { $response.ContentType = "image/x-icon" }
                ".mp3"   { $response.ContentType = "audio/mpeg" }
                ".woff"  { $response.ContentType = "font/woff" }
                ".woff2" { $response.ContentType = "font/woff2" }
                ".ttf"   { $response.ContentType = "font/ttf" }
                default  { $response.ContentType = "application/octet-stream" }
            }
            
            $bytes = [IO.File]::ReadAllBytes($localPath)
            $response.ContentLength64 = $bytes.Length
            $response.StatusCode = 200
            $response.OutputStream.Write($bytes, 0, $bytes.Length)
            Write-Host "200 OK: $path"
        } else {
            $response.StatusCode = 404
            Write-Host "404 Not Found: $path"
        }
        $response.Close()
    } catch {
        Write-Host "Erro: $($_.Exception.Message)"
    }
}
