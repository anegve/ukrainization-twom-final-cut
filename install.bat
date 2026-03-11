@echo off
chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion

echo ══════════════════════════════════════════════════════════
echo   This War of Mine: Final Cut — Українська локалізація
echo   Інсталятор v1.0
echo ══════════════════════════════════════════════════════════
echo.

:: ---- Detect game path ----
set "GAME_PATH="

:: Try common Xbox Game Pass locations
for %%D in (C D E F G) do (
    if exist "%%D:\XboxGames\This War of Mine- Final Cut\Content\Resources\localizations.dat" (
        set "GAME_PATH=%%D:\XboxGames\This War of Mine- Final Cut"
    )
)

:: Try WindowsApps (Microsoft Store)
for %%D in (C D E F G) do (
    if exist "%%D:\WindowsApps\11bitstudios*\Content\Resources\localizations.dat" (
        for /d %%F in ("%%D:\WindowsApps\11bitstudios*") do (
            set "GAME_PATH=%%F"
        )
    )
)

if defined GAME_PATH (
    echo   Знайдено гру: %GAME_PATH%
    echo.
    set /p "CONFIRM=  Це правильний шлях? [Y/n]: "
    if /i "!CONFIRM!"=="n" (
        set "GAME_PATH="
    )
)

if not defined GAME_PATH (
    echo   Автоматично гру не знайдено.
    echo   Введіть шлях до папки гри вручну.
    echo   Приклад: F:\XboxGames\This War of Mine- Final Cut
    echo.
    set /p "GAME_PATH=  Шлях: "
)

:: Validate path
if not exist "%GAME_PATH%\Content\Resources\localizations.dat" (
    echo.
    echo   ПОМИЛКА: Файл localizations.dat не знайдено за шляхом:
    echo   %GAME_PATH%
    echo   Перевірте шлях і спробуйте знову.
    pause
    exit /b 1
)

echo.
echo   Шлях до гри: %GAME_PATH%
echo.

:: ---- Menu ----
echo   Оберіть дію:
echo     1 - Встановити українську локалізацію
echo     2 - Видалити локалізацію (відновити оригінал)
echo     3 - Вийти
echo.
set /p "CHOICE=  Ваш вибір [1/2/3]: "

if "%CHOICE%"=="1" goto INSTALL
if "%CHOICE%"=="2" goto UNINSTALL
if "%CHOICE%"=="3" exit /b 0
echo   Невірний вибір.
pause
exit /b 1

:: ==================== INSTALL ====================
:INSTALL
echo.
echo   Встановлення української локалізації...
echo.

set "BACKUP=%GAME_PATH%\backup_original"
set "SRC=%~dp0files"

:: Create backup
if not exist "%BACKUP%" mkdir "%BACKUP%"
if not exist "%BACKUP%\LocalizationBinFonts" mkdir "%BACKUP%\LocalizationBinFonts"

echo   Створення резервних копій...

set "RES=%GAME_PATH%\Content\Resources"

if not exist "%BACKUP%\localizations.dat" (
    copy "%RES%\localizations.dat" "%BACKUP%\localizations.dat" >nul
    echo     localizations.dat — збережено
)
if not exist "%BACKUP%\localizations.idx" (
    copy "%RES%\localizations.idx" "%BACKUP%\localizations.idx" >nul
    echo     localizations.idx — збережено
)
if not exist "%BACKUP%\LocalizationBinFonts\Font.ConfigBin" (
    copy "%RES%\LocalizationBinFonts\Font.ConfigBin" "%BACKUP%\LocalizationBinFonts\Font.ConfigBin" >nul
    echo     Font.ConfigBin — збережено
)
if not exist "%BACKUP%\LocalizationBinFonts\_system.ttf.BinFont" (
    copy "%RES%\LocalizationBinFonts\_system.ttf.BinFont" "%BACKUP%\LocalizationBinFonts\_system.ttf.BinFont" >nul
    echo     _system.ttf.BinFont — збережено
)
if not exist "%BACKUP%\LocalizationBinFonts\Designosaur-Regular.ttf.BinFont" (
    copy "%RES%\LocalizationBinFonts\Designosaur-Regular.ttf.BinFont" "%BACKUP%\LocalizationBinFonts\Designosaur-Regular.ttf.BinFont" >nul
    echo     Designosaur-Regular.ttf.BinFont — збережено
)
if not exist "%BACKUP%\LocalizationBinFonts\gnyrwn971.ttf.BinFont" (
    copy "%RES%\LocalizationBinFonts\gnyrwn971.ttf.BinFont" "%BACKUP%\LocalizationBinFonts\gnyrwn971.ttf.BinFont" >nul
    echo     gnyrwn971.ttf.BinFont — збережено
)

echo.
echo   Копіювання файлів локалізації...

copy /y "%SRC%\Content\Resources\localizations.dat" "%RES%\localizations.dat" >nul
echo     localizations.dat — встановлено
copy /y "%SRC%\Content\Resources\localizations.idx" "%RES%\localizations.idx" >nul
echo     localizations.idx — встановлено
copy /y "%SRC%\Content\Resources\LocalizationBinFonts\Font.ConfigBin" "%RES%\LocalizationBinFonts\Font.ConfigBin" >nul
echo     Font.ConfigBin — встановлено
copy /y "%SRC%\Content\Resources\LocalizationBinFonts\_system.ttf.BinFont" "%RES%\LocalizationBinFonts\_system.ttf.BinFont" >nul
echo     _system.ttf.BinFont — встановлено
copy /y "%SRC%\Content\Resources\LocalizationBinFonts\Designosaur-Regular.ttf.BinFont" "%RES%\LocalizationBinFonts\Designosaur-Regular.ttf.BinFont" >nul
echo     Designosaur-Regular.ttf.BinFont — встановлено
copy /y "%SRC%\Content\Resources\LocalizationBinFonts\gnyrwn971.ttf.BinFont" "%RES%\LocalizationBinFonts\gnyrwn971.ttf.BinFont" >nul
echo     gnyrwn971.ttf.BinFont — встановлено

echo.
echo ══════════════════════════════════════════════════════════
echo   Українську локалізацію встановлено!
echo.
echo   В налаштуваннях гри оберіть мову: Russian
echo   (Текст буде відображатися українською)
echo.
echo   Резервні копії збережено в:
echo   %BACKUP%
echo ══════════════════════════════════════════════════════════
echo.
pause
exit /b 0

:: ==================== UNINSTALL ====================
:UNINSTALL
echo.

set "BACKUP=%GAME_PATH%\backup_original"
set "RES=%GAME_PATH%\Content\Resources"

if not exist "%BACKUP%\localizations.dat" (
    echo   ПОМИЛКА: Резервні копії не знайдено в:
    echo   %BACKUP%
    echo   Можливо, локалізацію не було встановлено через цей інсталятор.
    pause
    exit /b 1
)

echo   Відновлення оригінальних файлів...

copy /y "%BACKUP%\localizations.dat" "%RES%\localizations.dat" >nul
echo     localizations.dat — відновлено
copy /y "%BACKUP%\localizations.idx" "%RES%\localizations.idx" >nul
echo     localizations.idx — відновлено
copy /y "%BACKUP%\LocalizationBinFonts\Font.ConfigBin" "%RES%\LocalizationBinFonts\Font.ConfigBin" >nul
echo     Font.ConfigBin — відновлено
copy /y "%BACKUP%\LocalizationBinFonts\_system.ttf.BinFont" "%RES%\LocalizationBinFonts\_system.ttf.BinFont" >nul
echo     _system.ttf.BinFont — відновлено
copy /y "%BACKUP%\LocalizationBinFonts\Designosaur-Regular.ttf.BinFont" "%RES%\LocalizationBinFonts\Designosaur-Regular.ttf.BinFont" >nul
echo     Designosaur-Regular.ttf.BinFont — відновлено
copy /y "%BACKUP%\LocalizationBinFonts\gnyrwn971.ttf.BinFont" "%RES%\LocalizationBinFonts\gnyrwn971.ttf.BinFont" >nul
echo     gnyrwn971.ttf.BinFont — відновлено

echo.
echo ══════════════════════════════════════════════════════════
echo   Оригінальні файли відновлено!
echo   Локалізацію видалено.
echo ══════════════════════════════════════════════════════════
echo.
pause
exit /b 0
