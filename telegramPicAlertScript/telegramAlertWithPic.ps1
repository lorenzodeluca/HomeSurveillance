# Telegram
$botToken = "123:asd"
$chatId = "123"
$basePath = "L:\Sorveglianza\.yawcam-ai\events"

# Path where Yawcam saves motion event images
$basePath = "L:\Sorveglianza\.yawcam-ai\events"

# Find the latest image based on LastWriteTime
$latestImage = Get-ChildItem -Path $basePath -Recurse -Filter "image-*.jpg" |
    Sort-Object LastWriteTime -Descending |
    Select-Object -First 1

# Exit if no image was found
if (-not $latestImage) {
    Write-Host "❌ No image found."
    exit
}

# Read the image file into bytes
$fileBytes = [System.IO.File]::ReadAllBytes($latestImage.FullName)
$fileName = [System.IO.Path]::GetFileName($latestImage.FullName)

# Generate a unique boundary string for multipart/form-data
$boundary = [System.Guid]::NewGuid().ToString()
$lineBreak = "`r`n"

# Build the multipart/form-data headers and body manually
$bodyStart = [System.Text.Encoding]::UTF8.GetBytes(
    "--$boundary$lineBreak" +
    "Content-Disposition: form-data; name=`"chat_id`"$lineBreak$lineBreak" +
    "$chatId$lineBreak" +
    "--$boundary$lineBreak" +
    "Content-Disposition: form-data; name=`"photo`"; filename=`"$fileName`"$lineBreak" +
    "Content-Type: image/jpeg$lineBreak$lineBreak"
)

$bodyEnd = [System.Text.Encoding]::UTF8.GetBytes("$lineBreak--$boundary--$lineBreak")

# Combine the parts: header + file content + closing boundary
$bodyStream = New-Object System.IO.MemoryStream
$bodyStream.Write($bodyStart, 0, $bodyStart.Length)
$bodyStream.Write($fileBytes, 0, $fileBytes.Length)
$bodyStream.Write($bodyEnd, 0, $bodyEnd.Length)
$bodyStream.Seek(0, 'Begin') | Out-Null

# Build the HTTP request using .NET WebRequest (compatible with PowerShell 5.1)
$webRequest = [System.Net.WebRequest]::Create("https://api.telegram.org/bot$botToken/sendPhoto")
$webRequest.Method = "POST"
$webRequest.ContentType = "multipart/form-data; boundary=$boundary"
$webRequest.ContentLength = $bodyStream.Length
$webRequest.AllowWriteStreamBuffering = $true

# Write the body to the request stream
$reqStream = $webRequest.GetRequestStream()
$bodyStream.WriteTo($reqStream)
$reqStream.Close()

# Send the request and get the response
try {
    $response = $webRequest.GetResponse()
    $reader = New-Object System.IO.StreamReader($response.GetResponseStream())
    $responseText = $reader.ReadToEnd()
    Write-Host "Telegram response: $responseText"
} catch {
    Write-Host "Failed to send image: $($_.Exception.Message)"
}