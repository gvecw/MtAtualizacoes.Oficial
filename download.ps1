$url = "https://centralflasbackofc1.netlify.app"
$htmlPath = "index.html"
$htmlContent = Get-Content -Raw $htmlPath

# Find all hrefs and srcs
$regex = '(href|src)="(/[^"]+)"'
$matches = [regex]::Matches($htmlContent, $regex)

foreach ($match in $matches) {
    $path = $match.Groups[2].Value
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
Write-Host "Download complete."
