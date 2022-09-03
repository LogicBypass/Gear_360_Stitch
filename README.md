# Gear 360 2017 SM-R210
### Stitching options that I tried for Gear 360 2017(SM-R210)

## Video Editors with Stitch options:

[Corel Videostudio](https://www.videostudiopro.com)  ⭐⭐<sup>⭐</sup> </br>
[Pinnacle Studio](https://www.pinnaclesys.com) ⭐⭐⭐ </br>
[MAGIX Video Pro X](https://www.magix.com/us/video-editor/video-pro-x/functions/) ⭐⭐⭐<sup>⭐</sup> </br>
[MAGIX Movie Studio](https://www.magix.com/us/video-editor/movie-studio/) ⭐⭐⭐⭐</br>
</br>
Average settings that I used for that apps:</br>
```    FOV: 188
    L CENTER y: 0.5
    L CENTER x: 0.249
    R CENTER y: 0.5
    R CENTER x: 0.748
    RADIUS: 0.489
```
</br>

> Attention: None of these apps provided seamless stitching! Try the free trial version before buying! </br>
</br>


## My PowerShell Script:

### First install of FFmpeg:
To simplify the installation process of **FFmpeg** I created an Installation script.

1. Download the `Install` file.
2. `Right Click` on it and select `Run with PowerShell`.
3. Answer `[Y]Yes` to the installation questions.
4. Restart your PC to complete the installation process.

> ***The Installation only needs to be performed once***

### Usage:

1. Download the `PhotoStitch` file.
2. Drag and Drop this file `PhotoStitch` into the folder with your Photos.
3. `Right Click` on it and select `Run with PowerShell`.

> ***When the script will finish to stitch all photos it will automaticly exit, You will get aditional `mergemap` file remained from stitching process, you can delete it.***

### Advanced Script Modifications:
`PhotoStitch` script is set to work with Samsung Gear 360 (2017) with Photo Size settings: 5792x2896</br>
</br>
If your photo has a different size change in the script the **2896** string with the **Height** of your photo</br>
If you're getting bad edges after stitching change `gray8` to `bgr24` for a better view and try to play with `FOV` settings</br>
> Atention! When you're changing FOV settings be sure to change **all 7** of them </br>

</br>

## Best Preview app 
I recommend using GoPro VR Player V3 :
https://gopro.com/downloads/PC/GoProVRPlayer/latest
