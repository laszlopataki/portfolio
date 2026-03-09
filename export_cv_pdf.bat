@echo off
setlocal

rem Paths
set "HTML=%~dp0laszlo_cv_master.html"
set "PDF=%~dp0Laszlo_Pataki_CV.pdf"

rem Find Chrome
set "CHROME=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
if exist "%CHROME%" goto :run
set "CHROME=%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
if exist "%CHROME%" goto :run
set "CHROME=%LocalAppData%\Google\Chrome\Application\chrome.exe"
if exist "%CHROME%" goto :run

echo [ERROR] Google Chrome not found. Install Chrome or update CHROME path in export_cv_pdf.bat.
exit /b 1

:run
rem Build file:// URL with forward slashes
set "HTML_URL=file:///%HTML:\=/%"

echo Exporting "%HTML%" to "%PDF%" using "%CHROME%".
"%CHROME%" --headless=new --disable-gpu ^
  --print-to-pdf="%PDF%" --print-to-pdf-no-header ^
  --virtual-time-budget=10000 --run-all-compositor-stages-before-draw ^
  "%HTML_URL%"

if errorlevel 1 (
  echo [ERROR] PDF export failed.
  exit /b 1
)

echo [OK] PDF written to "%PDF%".
exit /b 0
