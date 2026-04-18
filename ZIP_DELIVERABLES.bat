:: This script will archive project submission deliverables for CST8237, including:
:: - Folders: { Config, Content, Source }
:: - Files with extensions: { *.project }

@echo off
SETLOCAL EnableDelayedExpansion

:: [IMPORTANT] Modify this value to use the username of your student email (eg. 'jdoe1234')
set "studentCode=trin0071"

:: Use this to toggle whether to open the ZIP archive upon closing the script.
set "openZipOnScriptClosed=1"

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

ECHO .
ECHO ..
ECHO ...
ECHO ....
ECHO #=============[ ARCHIVE Script ]=============#
ECHO.
ECHO For "CST 8237 - Game Programming".
ECHO.

:CheckUnrealRunning
    set "UE4Editor=UE4Editor.exe"
    set "UE5Editor=UE5Editor.exe"
    set "UnrealEditor=UnrealEditor.exe"

    :: Check if Unreal Engine 4 Editor is running
    tasklist /fi "IMAGENAME eq %UE4Editor%" | find /i "%UE4Editor%" >nul
    if not errorlevel 1 (
        echo Unreal Engine 4 Editor is running. Please close it before running this script.
        goto OnConcluded
    )

    :: Check if Unreal Engine 5 Editor is running
    tasklist /fi "IMAGENAME eq %UE5Editor%" | find /i "%UE5Editor%" >nul
    if not errorlevel 1 (
        echo Unreal Engine 5 Editor is running. Please close it before running this script.
        goto OnConcluded
    )

    :: Check if "UnrealEditor" is running
    tasklist /fi "IMAGENAME eq %UnrealEditor%" | find /i "%UnrealEditor%" >nul
    if not errorlevel 1 (
        echo '%UnrealEditor%' is running. Please close it before running this script.
        goto OnConcluded
    )



:: Set the name of the ZIP file
set "zipName=Deliverables-%studentCode%.zip"
ECHO * Target archive name: '%zipName%'
ECHO.



:BeginValidation

    :: Initialize variables
    set "paths="
    set "missingItems="

    :: List of files & folders to include
    set "extensions=.uproject"
    set "folders=Config Content Source"

    :: Initialize newline variable
    set NL=^


    :: The above two empty lines are required for the newline variable


    :: Check for missing folders and add existing ones to paths
    for %%d in (%folders%) do (
        if exist "%%d\" (
            set "paths=!paths!,'%%d'"
        ) else (
            set "missingItems=!missingItems!... '%%d/' folder.!NL!"
        )
    )

    :: Check for .uproject files
    set "uprojectFound=false"
    for %%F in (*.uproject) do (
        set "uprojectFound=true"
        set "paths=!paths!,'%%F'"
    )

    if "%uprojectFound%"=="false" (
        set "missingItems=!missingItems!... '*.uproject' files.!NL!"
    )

    :: Check if any items are missing
    if defined missingItems (
        echo -- ERROR^^! The following items are missing:
        echo.
        echo !missingItems!
        echo.
        echo Please verify your project contents^^! ... Exiting script.
    )
    if NOT defined missingItems GOTO OnValidationSuccess

    :OnItemsNotFound
    :: If no items to archive, exit the script
        if "%paths%"=="" (
            echo No items to archive^^! ... Exiting script.
            echo.
        )
        GOTO OnConcluded



:OnValidationSuccess
    
    :: Check for any ZIP file using that name.
    if NOT exist %zipName% GOTO BeginProcessing

    :OnExistingFilenameFound
        :: Warn and prompt user to overwrite.
        ECHO WARNING: An archive already exists by that name. 
        ECHO.
        SET /P PROCEED="Overwrite? ('y' to proceed): "

        :: If response is other than 'Y/y', skip processing.
        ECHO.
        IF /I "%PROCEED%" NEQ "Y" ECHO Cancelling script ...
        ECHO.    
        IF /I "%PROCEED%" NEQ "Y" GOTO OnConcluded


    :BeginProcessing
        :: Remove leading comma
        set "paths=%paths:~1%"

        :: Delete existing ZIP file if it exists
        if exist "%zipName%" del "%zipName%"

        :: Use PowerShell to create the ZIP archive
        powershell -NoLogo -NoProfile -Command "Compress-Archive -Path @(%paths%) -DestinationPath '%zipName%' -Force"

        :: Report success.
        ECHO ...
        ECHO ...
        ECHO ... ZIP archive '%zipName%' created successfully^^!
        SET "zipCreated=1"
        ECHO.
        GOTO OnConcluded


:OnConcluded
    ECHO.
    ECHO #==========[ END OF SCRIPT ]===========#
    ECHO.
    PAUSE
    if defined openZipOnScriptClosed (
        if !openZipOnScriptClosed! == 1 (
            if DEFINED zipCreated (
                if exist %zipName% start "" "%zipName%"
            ) 
        )
    )
    ENDLOCAL
    GOTO EOF

:EOF