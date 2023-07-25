@echo off && cls

set GLOBAL_FIRST_ARGUMENT=%~1

:: Personal CMD config - Batch Script
::
:: Written by @lucasbernardol
:: CopyRight (c) - 2022-present, José Lucas B. Lira

setlocal ENABLEDELAYEDEXPANSION

REM Global variables
set userprofile_directory=%userprofile%
set desktop_directory=%userprofile_directory%\desktop

set allow_clear_on_exit=0
set command_prompt_color=07

REM Regedit variables
set COMMAND_PROCESSOR_KEYNAME_REG_PATH="HKCU\Software\Microsoft\Command Processor"
set REGEDIT_EXPORTED_FILE_PATH=%desktop_directory%\command.processor.reg


if not defined GLOBAL_FIRST_ARGUMENT (
  color %command_prompt_color% && cls
  echo.
  echo Error: Command/argument not defined^^!
  echo.
  echo Usage: .\personal-config.bat [args]
  echo        Examples: .\personal-config.bat "import"
  echo                  .\personal-config.bat "revert"
  echo.
  pause
  
  set allow_clear_on_exit=1
  goto program_exit
)


if exist "%REGEDIT_EXPORTED_FILE_PATH%" (
  if "%GLOBAL_FIRST_ARGUMENT%" NEQ "revert" (
    echo "Info: Created!" && goto program_exit
  )
)

if "%GLOBAL_FIRST_ARGUMENT%" EQU "import" ( goto func_personal_config )

if "%GLOBAL_FIRST_ARGUMENT%" EQU "revert" ( goto func_revert_personal_config ) else ( goto program_exit )


:func_personal_config
  call :func_backup_regedit
  
  set personal_data="cls && title Terminal && color 0a && prompt $p$g && echo. && echo CMD: Hi %username%"
  
  reg add %COMMAND_PROCESSOR_KEYNAME_REG_PATH% /v Autorun /t REG_SZ /d %personal_data% /f
  
goto program_exit


:func_revert_personal_config
  reg import %REGEDIT_EXPORTED_FILE_PATH% 1>NUL 2>&1
  
  if !errorlevel! EQU 1 (
    echo. && echo "Not found: %REGEDIT_EXPORTED_FILE_PATH%"
  ) else (
    echo. && echo "Reverted: OK"
  )

  call :func_del_bg
  
goto program_exit


:func_backup_regedit
  call :func_del_bg

  reg export %COMMAND_PROCESSOR_KEYNAME_REG_PATH% %REGEDIT_EXPORTED_FILE_PATH% /y
  
  if !errorlevel! EQU 0 (
    attrib +H +R %REGEDIT_EXPORTED_FILE_PATH%
  ) 

goto :eof


:func_del_bg
  if exist "%REGEDIT_EXPORTED_FILE_PATH%" (
    del /f /q /a %REGEDIT_EXPORTED_FILE_PATH%
  )
 
goto :eof


:program_exit
  if %allow_clear_on_exit% EQU 1 ( cls )
    
exit /b
