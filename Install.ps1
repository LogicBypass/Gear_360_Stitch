#https://www.gyan.dev/ffmpeg/builds/ffmpeg-git-full.7z
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    exit;
}
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
