$url = "https://centralflasbackofc1.netlify.app"
$images = @(
"/flashback-cover.jpg",
"/michael-jackson-cover.jpg",
"/back-to-80s.jpg",
"/back-to-90s.jpg",
"/scorpions-cover.jpg",
"/testimonials/carlos-real.jpg",
"/testimonials/maria-v2.jpg",
"/testimonials/joao-real.jpg",
"/testimonials/woman-uploaded.jpg",
"/testimonials/roberto-real.jpg"
)

foreach ($path in $images) {
    $fullUrl = $url + $path
    $localPath = ".$path"
    
    $localDir = [System.IO.Path]::GetDirectoryName($localPath)
    if (-not (Test-Path $localDir)) {
        New-Item -ItemType Directory -Force -Path $localDir | Out-Null
    }
    
    if (-not (Test-Path $localPath)) {
        Write-Host "Downloading $fullUrl to $localPath"
        try {
            Invoke-WebRequest -Uri $fullUrl -OutFile $localPath
        } catch {
            Write-Host "Failed to download $fullUrl"
        }
    }
}
Write-Host "Image download complete."
