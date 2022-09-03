<# 
C - Width of interpolation band in degrees, must be smaller or equal than FOV "try from 6 to 11 for smoother stitch edge" 
H - Half of the image width = height of input image after cropping
FOV - field of view of the fisheye lenses in degrees, "try to play with it from 190 to 199, Be sure to change all 7 of them!" 

For debuging edges use "bgr24" instad of "gray8"
#>

$scriptpath = $MyInvocation.MyCommand.Definition 
[string]$dir = Split-Path $scriptpath  
set-location $dir

$files = Get-ChildItem "360*.JPG"
$nr = 1

foreach ($f in $files){
    <#                                H   H                                       C      FOV    H               H       H                                                  FOV        FOV #>       
    ffmpeg -f lavfi -i nullsrc=size=2896x2896 -vf "format=gray8,geq='clip(128-128/8*(180-195/(2896/2)*hypot(X-2896/2,Y-2896/2)),0,255)',v360=input=fisheye:output=e:ih_fov=195:iv_fov=194" -frames 1 -y mergePmap.png
    ffmpeg -i $f -i mergePmap.png -lavfi "[0]crop=h=2896:y=0,format=rgb24,split[a][b];
    [a]crop=ih:iw/2:0:0,v360=input=fisheye:output=e:ih_fov=195:iv_fov=194[c];
    [b]crop=ih:iw/2:iw/2:0,v360=input=fisheye:output=e:yaw=180:ih_fov=195:iv_fov=194[d];[1]format=gbrp[e];[c][d]
    [e]maskedmerge" -y out$nr.jpg
    $nr++}
