#https://www.gyan.dev/ffmpeg/builds/ffmpeg-git-full.7z
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    exit;
}


Write-Host "888                       d8b               888888b.                                                "
Write-Host "888                       Y8P               888  .88b                                               "
Write-Host "888                                         888  .88P                                               "
Write-Host "888      .d88b.   .d88b.  888  .d8888b      8888888K.  888  888 88888b.   8888b.  .d8888b  .d8888b  "
Write-Host "888     d88..88b d88P.88b 888 d88P.         888  .Y88b 888  888 888 .88b     .88b 88K      88K      "
Write-Host "888     888  888 888  888 888 888           888    888 888  888 888  888 .d888888 -Y8888b. -Y8888b. "
Write-Host "888     Y88..88P Y88b 888 888 Y88b.         888   d88P Y88b 888 888 d88P 888  888      X88      X88 "
Write-Host "88888888 -Y88P-   *Y88888 888  *Y8888P      8888888P*   *Y88888 88888P*  *Y888888  88888P*  88888P* "
Write-Host "                      888                                   888 888                                 "
Write-Host "                 Y8b d88P                              Y8b d88P 888                                 "
Write-Host "                  *Y88P*                                *Y88P*  888                                 "
Write-Host ""
Write-Host ""
Write-Host "Gear 360 Instalation Script"
Write-Host "https://github.com/LogicBypass/Gear_360_Stitch"
Write-Host ""
Write-Host ""
Start-Sleep 3

New-Item -Type Directory -Path C:\ffmpeg ; Set-Location C:\ffmpeg
curl.exe -L 'https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.zip' -o 'ffmpeg.zip'
# Expand the Zip
Expand-Archive .\ffmpeg.zip -Force -Verbose
# Move the executable (*.exe) files to the top folder
Get-ChildItem -Recurse `
    -Path C:\ffmpeg\ffmpeg\ffmpeg-* -Filter *.* | ForEach-Object {Move-Item $_ -Destination C:\ffmpeg -Verbose}
# Clean up
Remove-Item .\ffmpeg\ffmpeg* -Recurse
Remove-Item .\ffmpeg.zip

setx /m PATH "C:\ffmpeg\bin;%PATH%"

Write-Host "Restart your PC to complete instalation"

while("y","n" -notcontains $YesOrNo ){
    $input = Read-Host "Restart computer now [Y/n]"
    switch($input){
              y{Restart-computer -Force -Confirm:$false}
              n{exit}
        default{write-warning "Invalid Input"}}
}
