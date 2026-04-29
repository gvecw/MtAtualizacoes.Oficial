$url = "https://centralflasbackofc1.netlify.app"
$audios = @(
"/preview-retro.mp3",
"/preview-moonjack.mp3",
"/preview-flashback.mp3",
"/preview-eurodance.mp3",
"/preview-romanticas.mp3",
"/preview-rock.mp3"
)

foreach ($path in $audios) {
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
Write-Host "Audio download complete."
