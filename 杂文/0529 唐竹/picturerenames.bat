@echo off
setlocal enabledelayedexpansion

:: =============== 配置区 ===============
set "INPUT_DIR=C:\Users\wangboliang\Downloads"

:: ======================================

cd /d "%INPUT_DIR%"

:: 检查是否有图片
for /f %%i in ('dir /b *.jpg *.jpeg *.png 2^>nul ^| find /v /c ""') do set COUNT=%%i
if "%COUNT%"=="0" (
    echo 错误：目录中没有找到 .jpg / .jpeg / .png 图片！
    pause
    exit /b
)

:: 步骤1：重命名所有图片为 0001.jpg, 0002.png ...

echo 正在重命名图片...
set IDX=10000
for %%f in (*.jpg *.jpeg *.png) do (
    if /i not "%%f"=="%OUTPUT_FILE%" (
        set "EXT=%%~xf"
        ren "%%f" "!IDX!!EXT!"
        set /a IDX+=1
    )
)
:: 再次重命名为 0001 起始（去掉前面的1）
set IDX=1
for %%f in (*.jpg *.jpeg *.png) do (
    if /i not "%%f"=="%OUTPUT_FILE%" (
        set "EXT=%%~xf"
        set "NEWNAME=000!IDX!!EXT!"
        set "NEWNAME=!NEWNAME:~-8!"
        ren "%%f" "!NEWNAME!"
        set /a IDX+=1
    )
)
echo 重命名完成！
