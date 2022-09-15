<# 
C - Width of interpolation band in degrees, must be smaller or equal than FOV "try from 6 to 11 for smoother stitch edge" 
H - Half of the image width = height of input image after cropping
FOV - field of view of the fisheye lenses in degrees, "try to play with it from 190 to 199, Be sure to change all 7 of them!" 

For debuging edges use "bgr24" instad of "gray8"
#>

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
Write-Host "Gear 360 Stitching Script"
Write-Host "https://github.com/LogicBypass/Gear_360_Stitch"
Write-Host ""
Write-Host ""
Start-Sleep 4

$scriptpath = $MyInvocation.MyCommand.Definition 
[string]$dir = Split-Path $scriptpath  
set-location $dir

$files = Get-ChildItem "360*"
$nr = 1

foreach ($f in $files){
    $ext = [IO.Path]::GetExtension($f)
    $out=(Get-Item $f ).Basename
    if ($ext -eq ".jpg" ){
        <#                                H   H                                       C      FOV    H               H       H                                                  FOV        FOV #>       
        ffmpeg -f lavfi -i nullsrc=size=2896x2896 -vf "format=gray8,geq='clip(128-128/8*(180-195/(2896/2)*hypot(X-2896/2,Y-2896/2)),0,255)',v360=input=fisheye:output=e:ih_fov=195:iv_fov=194" -frames 1 -y mergePmap.png
        ffmpeg -i $f -i mergePmap.png -lavfi "[0]crop=h=2896:y=0,format=rgb24,split[L][R];
        [L]crop=ih:iw/2:0:0,v360=input=fisheye:output=e:ih_fov=195:iv_fov=194[L_fov];
        [R]crop=ih:iw/2:iw/2:0,v360=input=fisheye:output=e:yaw=180:ih_fov=195:iv_fov=194[R_fov];[1]format=gbrp[fmt];
        [L_fov][R_fov][fmt]maskedmerge" -y $out'_STITCHED'.jpg
        $nr++}
    else {
        ffmpeg -f lavfi -i nullsrc=size=2048x2048 -vf "format=gray8,geq='clip(128-128/8*(180-195/(2048/2)*hypot(X-2048/2,Y-2048/2)),0,255)',v360=input=fisheye:output=e:ih_fov=195:iv_fov=194" -frames 1 -y mergeVmap.png
        ffmpeg -hwaccel auto -i $f -i mergeVmap.png  -f lavfi -i color=black:s=2x2 -lavfi "[0]format=rgb24,split[L][R];
        [L]crop=ih:iw/2:0:0,v360=input=fisheye:output=e:ih_fov=195:iv_fov=194.2[L_fov];
        [R]crop=ih:iw/2:iw/2:0,v360=fisheye:e:yaw=180:ih_fov=195:iv_fov=194.2[R_fov];
        [1]format=gbrp[fmt];[L_fov][R_fov][fmt]maskedmerge,overlay=shortest=1" -qp 13 -b:v 30M -b:a 192k -r 24 -y $out'_STITCHED'.MP4
        $nr++}
    }
