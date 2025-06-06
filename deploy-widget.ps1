param (
    [string]$WidgetName = "3DSwymReportGenerator",
    [switch]$ForceWrapper
)

$root = Get-Location
$widgetPath = ".\AIWIDGETS\$WidgetName"
$buildPath = "$widgetPath\dist"
$wrapperSrc = "$widgetPath\Wrapper"
$wrapperDst = ".\gh-pages\$($WidgetName)Wrapper"
$ghTarget = ".\gh-pages\$WidgetName"

Write-Host "🔧 Building Vue widget..."
Push-Location $widgetPath
npm run build
Pop-Location

# Verify build output exists
if (!(Test-Path $buildPath)) {
    Write-Host "❌ Build failed. No dist folder found."
    exit 1
}

# Recreate gh-pages target folder
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue $ghTarget
New-Item -ItemType Directory -Path $ghTarget | Out-Null

Copy-Item -Path "$buildPath\*" -Destination $ghTarget -Recurse
Write-Host "📦 Widget built and copied to $ghTarget"

# 🔄 Wrapper
if ($ForceWrapper -or !(Test-Path "$wrapperSrc\index.html")) {
    Write-Host "🧩 Generating wrapper files..."

    if (!(Test-Path $wrapperSrc)) {
        New-Item -ItemType Directory -Path $wrapperSrc | Out-Null
    }

    # Correct redirect path
    $redirectPath = "/AI4HT/$WidgetName/index.html"
    Set-Content -Path "$wrapperSrc\main.js" -Value "window.location.href = '$redirectPath';"

    Set-Content -Path "$wrapperSrc\index.html" -Value @"
<!DOCTYPE html>
<html>
<head><title>$WidgetName Wrapper</title></head>
<body>
  <script type='text/javascript' src='main.js'></script>
</body>
</html>
"@
}

# Copy wrapper to gh-pages
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue $wrapperDst
Copy-Item -Path "$wrapperSrc" -Destination $wrapperDst -Recurse
Write-Host "🧩 Wrapper deployed to $wrapperDst"

# Git stage + commit + push
git add $ghTarget
git add $wrapperDst
git commit -m "🚀 Deploy $WidgetName widget and wrapper to GitHub Pages"
git push origin main

Write-Host "✅ $WidgetName and wrapper deployed to gh-pages/"