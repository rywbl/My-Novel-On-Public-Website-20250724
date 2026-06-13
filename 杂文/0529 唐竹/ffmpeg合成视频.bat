@echo off
setlocal

:: 设置路径
set "IMG_DIR=C:\Users\hwua\Pictures\00"
set "FFMPEG=C:\ffmpeg\bin\ffmpeg.exe"
set "OUTPUT=%IMG_DIR%\output_2k_video.mp4"

:: 切换到图片目录
cd /d "%IMG_DIR%"

:: 检查 ffmpeg 是否存在
if not exist "%FFMPEG%" (
    echo 错误：找不到 FFmpeg！
    echo 请确认 E:\ffmpeg\bin\ffmpeg.exe 存在。
    pause
    exit /b
)

:: 检查是否有 0001.jpg 或 0001.png
if exist "0001.jpg" (
    set "INPUT_FMT=%%04d.jpg"
) else if exist "0001.png" (
    set "INPUT_FMT=%%04d.png"
) else (
    echo 错误：未找到 0001.jpg 或 0001.png！
    echo 请确保图片已重命名为 0001.jpg、0002.jpg... 格式。
    pause
    exit /b
)

:: 开始合成视频
echo 正在生成 2K 视频（每张图5秒，使用在线音频）...
"%FFMPEG%" -y -framerate 1/5 -i "%INPUT_FMT%" -i "https://lhttp.qtfm.cn/live/5022308/64k.mp3" -vf "scale=2560:1440:force_original_aspect_ratio=decrease:out_range=tv,pad=2560:1440:(ow-iw)/2:(oh-ih)/2,setsar=1" -c:v libx264 -crf 22 -pix_fmt yuv420p -r 30 -c:a aac -b:a 128k -shortest "%OUTPUT%"

if %errorlevel% equ 0 (
    echo.
    echo ? 视频已成功生成！
    echo 输出路径：%OUTPUT%
) else (
    echo.
    echo ? 视频生成失败！
)

pause