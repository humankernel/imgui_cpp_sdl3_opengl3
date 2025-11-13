@echo off
setlocal enabledelayedexpansion

call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" x64

:: ============ Configuration ============
@set SRC=src\main.cpp
@set OUT_DIR=build
@set OUT_EXE=main.exe

@set IMGUI=imgui
@set GLFW=C:\libs\glfw-3.4

cd /D "%~dp0"
if not exist "%OUT_DIR%" mkdir "%OUT_DIR%"

:: ============ Compile ============
cl /nologo /EHsc /std:c++17 /Zi /MD /utf-8 ^
    /I%IMGUI% ^
    /I%IMGUI%\backends ^
    /I%GLFW%\include ^
    %SRC% ^
    %IMGUI%\imgui.cpp ^
    %IMGUI%\imgui_draw.cpp ^
    %IMGUI%\imgui_widgets.cpp ^
    %IMGUI%\imgui_tables.cpp ^
    %IMGUI%\imgui_demo.cpp ^
    %IMGUI%\backends\imgui_impl_glfw.cpp ^
    %IMGUI%\backends\imgui_impl_opengl3.cpp ^
    /Fe%OUT_DIR%\%OUT_EXE% ^
    /Fd%OUT_DIR%\vc.pdb ^
    /Fo%OUT_DIR%\ ^
    /link ^
    /LIBPATH:%GLFW%\lib-vc2022 ^
    glfw3.lib opengl32.lib gdi32.lib shell32.lib


if %errorlevel% neq 0 (
    echo [ERROR] Build failed!
    exit /b %errorlevel%
)

echo [SUCCESS] Build completed: %OUT_DIR%\main.exe
exit /b 0
