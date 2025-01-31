@echo off
start "" "C:\Program Files\Google\Chrome\Application\chrome.exe" "file:///%cd:/=/%/index.html"

:: Start the loop to accept user input
:search_loop

:: Prompt user for input
set /p userInput=

:: Debugging: Show user input
echo DEBUG: User input: "%userInput%"

:: Trim leading and trailing spaces from the user input
for /f "tokens=* delims=" %%a in ("%userInput%") do set userInput=%%a

:: Check if the user typed "clear"
if /i "%userInput%"=="clear" (
    cls
)

:: Check if the user typed "search" followed by a keyword
if /i "%userInput%"=="search" (
    echo Please enter a search keyword after "search".
    goto search_loop
)

:: Extract keyword after "search " (skip the first 7 characters of "search ")
if /i "%userInput:~0,7%"=="search " (
    set keyword=%userInput:~7%
) else (
    goto search_loop
)

:: Trim any spaces from the keyword
for /f "tokens=* delims=" %%b in ("%keyword%") do set keyword=%%b

:: Check if the keyword is empty
if "%keyword%"=="" (
    echo Please enter a search keyword after "search".
    goto search_loop
)

:: Perform the search and display results
echo Searching for "%keyword%" in text-based files...
echo.

:: Enable delayed expansion for dynamic variables
setlocal enabledelayedexpansion

:: Search all relevant files for the keyword
for /r %%f in (*.html *.css *.js *.txt *.php *.py *.json) do (
    findstr /n /i "%keyword%" "%%f" > nul
    if not errorlevel 1 (
        :: Get the filename only (remove path)
        set "filename=%%~nxf"
        for /f "tokens=1,2 delims=:" %%i in ('findstr /n /i "%keyword%" "%%f"') do (
            set "lineNumber=%%i"
            set "lineContent=%%j"
            call :center_line "!filename!" "!lineNumber!" "!lineContent!"
        )
        echo.
    )
)

:: Wait for the user to enter a new search or exit
goto search_loop

:center_line
:: Center the line with the file name, line number, and code
setlocal enabledelayedexpansion
set "filename=%~1"
set "lineNumber=%~2"
set "lineContent=%~3"

:: Remove any extra spaces from the filename, line number, and line content
set "filename=!filename: =!"
set "lineNumber=!lineNumber: =!"
set "lineContent=!lineContent: =!"

:: Ensure there are exactly 3 spaces between the file name, line number, and content
:: Pad filename and line number to ensure proper spacing
set "filename=!filename!"
set "lineNumber=!lineNumber!"

:: Output the result with exactly 3 spaces between each part
echo !filename!   !lineNumber!   !lineContent!

endlocal
