# Variables for customization
$videoUrl = "https://www.youtube.com/watch?v=H4Y73nQ3sNk" # YouTube video URL
$startTime = "65.1"  
$endTime = "69.2"                                     # Start time for the audio clip (in seconds)
$clipDuration = ([double]$endTime - [double]$startTime).ToString("F1") # Duration of the audio clip (in seconds)

# --- Script ---
Write-Host "Starting video processing..."

# Extract video ID from URL
$videoId = $null
try {
    Add-Type -AssemblyName System.Web # Load the System.Web assembly
    $uri = [System.Uri]$videoUrl
    $query = $uri.Query
    if ([string]::IsNullOrWhiteSpace($query)) {
        # Handle URLs like youtu.be/VIDEO_ID
        $videoId = $uri.Segments[-1]
    } else {
        # Handle URLs like youtube.com/watch?v=VIDEO_ID
        $queryParams = [System.Web.HttpUtility]::ParseQueryString($query)
        $videoId = $queryParams['v']
    }

    if ([string]::IsNullOrWhiteSpace($videoId)) {
        Write-Error "Could not extract video ID from URL: $videoUrl"
        exit 1
    }
}
catch {
    Write-Error "Invalid URL or error parsing URL: $videoUrl. $($_.Exception.Message)"
    exit 1
}

# Define filenames
$tempVideoFile = "$($PSScriptRoot)\${videoId}.webm"
$outputAudioFile = "$($PSScriptRoot)\audio-${startTime}-${clipDuration}-${videoId}.mp3"
$ytDlpExecutable = "$($PSScriptRoot)\yt-dlp.exe" # Assumes yt-dlp.exe is in the same directory as the script

# Check if yt-dlp.exe exists
if (-not (Test-Path $ytDlpExecutable)) {
    Write-Error "yt-dlp.exe not found at $ytDlpExecutable. Please ensure it's in the script's directory or update the path."
    exit 1
}

# Step 1: Download the video
Write-Host "Downloading video: $videoUrl"
$ytDlpArgs = @(
    $videoUrl,
    "-o",
    $tempVideoFile
)
& "$ytDlpExecutable" $ytDlpArgs

if ($LASTEXITCODE -ne 0) {
    Write-Error "yt-dlp failed to download the video. Exit code: $LASTEXITCODE"
    exit 1
}
Write-Host "Video downloaded successfully: $tempVideoFile"

# Step 2: Extract the audio segment using ffmpegWrite-Host "Extracting audio segment..."
# ffmpeg -ss <start_time> -t <duration> -i <input_video> -y -vn -acodec libmp3lame <output_audio.mp3>
$ffmpegArgs = @(
    "-ss", $startTime,
    "-t", $clipDuration,
    "-i", $tempVideoFile,
    "-y",
    "-vn",
    "-acodec", "libmp3lame",
    $outputAudioFile
)

try {
    & ffmpeg $ffmpegArgs # Assumes ffmpeg is in PATH
    if ($LASTEXITCODE -ne 0) {
        Write-Error "ffmpeg failed to extract audio. Exit code: $LASTEXITCODE"
        # Optionally, you might not want to exit if ffmpeg fails, to allow cleanup
    } else {
        Write-Host "Audio extracted successfully: $outputAudioFile"
    }
}
catch {
    Write-Error "Error running ffmpeg: $($_.Exception.Message)"
    Write-Warning "Ensure ffmpeg is installed and in your system's PATH."
    # Optionally, you might not want to exit if ffmpeg fails, to allow cleanup
}

# Step 3: Clean up the downloaded video file
if (Test-Path $tempVideoFile) {
    Write-Host "Cleaning up temporary video file: $tempVideoFile"
    Remove-Item -Path $tempVideoFile -Force -ErrorAction SilentlyContinue
}

Write-Host "Processing complete."