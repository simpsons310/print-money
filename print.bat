@echo off
setlocal enabledelayedexpansion

:: Mặc định
set "denomination=500"
set "currency=VND"
set "path="
set "label="

:: --- Parse arguments ---
:parse_args
if "%~1"=="" goto validate_args
if "%~1"=="--denomination" (set "denomination=%~2" & shift & shift & goto parse_args)
if "%~1"=="-d" (set "denomination=%~2" & shift & shift & goto parse_args)
if "%~1"=="--currency" (set "currency=%~2" & shift & shift & goto parse_args)
if "%~1"=="-c" (set "currency=%~2" & shift & shift & goto parse_args)
if "%~1"=="--path" (set "path=%~2" & shift & shift & goto parse_args)
if "%~1"=="-p" (set "path=%~2" & shift & shift & goto parse_args)
if "%~1"=="--label" (set "label=%~2" & shift & shift & goto parse_args)
if "%~1"=="-l" (set "label=%~2" & shift & shift & goto parse_args)

:: total là tham số bắt buộc đầu tiên
if not defined total (
    set "total=%~1"
    shift
    goto parse_args
)

:: --- Kiểm tra hợp lệ ---
:validate_args
if not defined total (
    echo [ERR] Required total money to print
    exit /b 1
)

set /a check_mod=total %% 1000
if not "%check_mod%"=="0" (
    echo [ERR] The total amount of money must be divisible by 1000
    exit /b 1
)

if not "%denomination%"=="10" if not "%denomination%"=="20" if not "%denomination%"=="50" if not "%denomination%"=="100" if not "%denomination%"=="200" if not "%denomination%"=="500" (
    echo [ERR] Invalid denomination: %denomination%
    exit /b 1
)


if not "%currency%"=="VND" (
    echo [ERR] Only support currency: VND
    exit /b 1
)

:: Gán đường dẫn mặc định nếu chưa có
if not defined path (
    set "path=.\asset\%currency%"
)

:: Đường dẫn ảnh gốc
set "source=%path%\%denomination%.jpg"

if not exist "%source%" (
    echo [ERR] Cannot found denomination : %source%
    exit /b 1
)

:: Tính số lượng file cần copy
set /a count=total / denomination

:: Xác định tên thư mục output
if defined label (
    set "output=out\%label%"
) else (
    set "output=out\%total%"
)

if not exist "%output%" (
    mkdir "%output%"
)

:: Thực hiện sao chép
echo Copying %count% bills of %denomination% (%currency%) into "%output%" ...
for /L %%i in (1,1,%count%) do (
    copy /Y "%source%" "%output%\%%i.jpg" >nul
)

echo Printed %total% %currency% of %denomination%
exit /b 0
