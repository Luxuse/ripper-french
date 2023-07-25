@echo off

set GLOBAL_called_first_argument=%~1

REM Global variables
set VERSION=0.0.4
set PROJECT_NAME=rar-ripper

set AUTHOR_NAME=lucasbernardol
set AUTHOR_GITHUB_URL=github.com/lucasbernardol

set PROJECT_GITHUB_URL=%AUTHOR_GITHUB_URL%/%PROJECT_NAME%
set PROJECT_GITHUB_ISSUES_URL=%AUTHOR_GITHUB_URL%/%PROJECT_NAME%/issues

set BOT_NAME=Ripper BOT
set RESULT_BOT_NAME=Rar Ripper: BOT
set OFFICIAL_RAR_URL=www.winrarbrasil.com.br

setlocal ENABLEDELAYEDEXPANSION

:: A se��o abaixo � respons�vel pela delcara��o das vari�veis
:: globais. Como t�tulos, diret�rios, entre outros.
set /a rounds=0

REM As primeiras vari�veis abaixo utilizam aspas, pois o nome do usu�rio de
REM uma determinada m�quina pode conter espa�os, por exemplo, "Windows NT".

set current_directory="%cd%"
set temporary_directory=%temp%

set userprofile_directory="%userprofile%"
set desktop_directory=%userprofile_directory%\desktop
set documents_directory=%userprofile_directory%\documents

set program_files_directory=%programfiles%
set program_files_amd_directory=%programfiles(x86)%

set resources_directory=resources
set wordlists_directory=%resources_directory%\wordlists

set extracted_directory=%current_directory%\extracted

set extracted_alert_bot_filename=ripper.bot.vbs
set extracted_alert_bot_file_path=%temporary_directory%\%extracted_alert_bot_filename%

set command_prompt_exit_title=Terminal
set extracted_result_file_text=details.txt

set winrar_installed_alert_message_file=ripper-installed.vbs
set winrar_installed_alert_vbs_path=%temporary_directory%\%winrar_installed_alert_message_file%

set installed_winrar_message_file=ripper-installed-rar.vbs
set installed_winrar_file_path=%temporary_directory%\%installed_winrar_message_file%


REM Extensions
set wordlist_external_extension=.txt
set rar_file_extension=.rar


REM Log's
set logs_text_file_name="ripper.log-%date:~0,2%-%date:~3,2%-%date:~6,4%.txt"
set logs_custom_dir_name=ripper-logs

set logs_custom_dir=%documents_directory%\%logs_custom_dir_name%
set logs_file_dir=%logs_custom_dir%\%logs_text_file_name%


REM Winrar
set winrar_executable_file=rar.exe
 
:: Path c:\Program files\Winrar\rar.exe
set winrar_full_path=%program_files_directory%\winrar\%winrar_executable_file%

:: Path c:\Program files (x86)\Winrar\rar.exe
set winrar_AMD_full_path=%program_files_amd_directory%\winrar\%winrar_executable_file%


REM WordLists
set brazilian_names_wordlist=brazilian_names.rar
set common_passwords_wordlist=common_passwords.rar

set brazilian_names_extracted_filename=brazilian_names.txt
set common_passwords_extracted_filename=common_passwords.txt

set brazilian_names_wordlist_rar_path=%wordlists_directory%\%brazilian_names_wordlist%
set common_passwords_wordlist_rar_path=%wordlists_directory%\%common_passwords_wordlist%

set brazilian_names_wordlist_file_path=%wordlists_directory%\%brazilian_names_extracted_filename%
set common_passwords_wordlist_file_path=%wordlists_directory%\%common_passwords_extracted_filename%

set selected_wordlist=any
set selected_rar_file=any


REM File's variables
set megabytes_prefix=MB
set megabytes_wordlist_txt_file_max_size=200

set /a kilobytes_wordlist_txt_file_max_size=%megabytes_wordlist_txt_file_max_size%*1024
set /a bytes_wordlist_txt_file_max_size=%kilobytes_wordlist_txt_file_max_size%*1024


REM Boolean's variables (using numbers)
set allow_logs=1
set allow_clear_in_exit=1

set make_extracted_dir_on_load=1
set allow_rename_command_prompt_exit=1

set force_close=0


REM Colors
set command_prompt_color=07
set command_winrar_alert_color=0c

set command_ripper_amd_color=02
set command_ripper_amdx86_color=0a


REM Variables (time)
set brute_force_start_time=0
set brute_force_end_time=0

if "%GLOBAL_called_first_argument%" EQU "/?" ( 
  goto cli_syntax
)

REM Call "main" function!
goto main


:log_with_timestamp
  echo %time:~0,8% %date% - %~1 >>%logs_file_dir%
goto :eof


:down_line_in_text_files
  set private_down_line_argument=%~1
  
  :: (%~1) "down-logs" adicionar/pular uma linha arquivo de logs ou
  :: (%~1) "down-details" acrescentar linha no arquivo de detalhes (ambos .txt)
  if "%private_down_line_argument%" EQU "down-logs" (
    if exist %logs_file_dir% ( 
      echo. >>%logs_file_dir%
    )
  )

  if "%private_down_line_argument%" EQU "down-details" (
    if exist "%extracted_result_file_text%" (
      echo. >>%extracted_result_file_text%
    )
  )
 
goto :eof


:create_extracted_directory
  if not exist "%extracted_directory:"=%" (
    mkdir %extracted_directory%

    if !allow_logs! EQU 1 ( 
      call :log_with_timestamp "LOG: Extracted dir: '!extracted_directory:"=!'"
    )
  )

goto :eof


:main
  cls && color %command_prompt_color%
 
  :: Execus�o no modo CLI ou "call", onde o primeiro argumento, depois do
  :: nome do arquivo, identifica a exclus�o dos logs "hist�rico de instru��es".
  if defined GLOBAL_called_first_argument (
    if "%GLOBAL_called_first_argument%" EQU "clear-logs" (
      rmdir /s /q %logs_custom_dir%
      
      set allow_logs=0
    ) else ( 
      goto cli_syntax
    )
  ) else (
    REM Path: C:\users\root\documents\ripper-logs
    if not exist %logs_custom_dir% (
      mkdir %logs_custom_dir%
    )
  )
  
  if !allow_logs! EQU 1 (
    call :down_line_in_text_files "down-logs"
    call :log_with_timestamp "PRE LOG: CMD started..."
  )
  
  if %make_extracted_dir_on_load% EQU 1 ( 
    call :create_extracted_directory
    
    if !allow_logs! EQU 1 ( 
      call :log_with_timestamp "LOG: Called 'create_extracted_directory' function."
    )
  )
  
  if not exist "%installed_winrar_file_path%" ( goto winrar_installed_information )
  
goto application_menu


:winrar_installed_information
  setlocal
    :: Inicializa��o da aplica��o. Um c�digo em "VBscript" ser� respons�vel por exibir ao
    :: usu�rio uma mensagem de boas vindas, garantindo a instala��o do Wintar na sua m�quina.
    set private_vbs_winrar_body="Seja bem-vindo(a) ao Rar Ripper. Instalou o Winrar corretamente? Acesse: %OFFICIAL_RAR_URL% ou ignore."
    set private_vbs_context=vbinformation
    set private_title="%BOT_NAME%"
           
    echo Msgbox %private_vbs_winrar_body%, %private_vbs_context%, %private_title% >%installed_winrar_file_path%

    attrib +H +R %installed_winrar_file_path%
    
    if %allow_logs% EQU 1 ( 
      call :log_with_timestamp "LOG: Installed Winrar."
    )
  endlocal

goto start_ripper_information


:start_ripper_information
  if exist "%installed_winrar_file_path%" (
    start %installed_winrar_file_path%
    
    if !allow_logs! EQU 1 (
      call :log_with_timestamp "LOG: Execute: %installed_winrar_file_path%"
      
      call :log_with_timestamp "REALOD LOG: Restarting..."
    )
  )
  
goto main


:application_menu
  if %allow_logs% EQU 1 ( call :log_with_timestamp "LOG: MENU" )
  
  :application_menu_reload
    title Rar Ripper
    color %command_prompt_color% && cls
    echo.
    echo Rar Ripper - VERSION: %VERSION%
    echo Coded by: %AUTHOR_NAME%
    echo traduit by: luxuse
    echo Info: Pour plus de details, entrez "help" ou "c"!
    echo.
    echo   1) demarrer :by luxuse alpha trad;   2) partire
    echo.
    set /p "menu_selected_option=ton blabla:> "
    
    if "%menu_selected_option%" == "" ( goto application_menu )
    
    :: Op��es v�lidas a para se��o de "changelog" ou hist�rico de mudan�as
    if /i "%menu_selected_option%" == "c" ( goto changelog )
    if /i "%menu_selected_option%" == "changelog" ( goto changelog )
         
    :: Argumentos v�lidos para acessar a regi�o de ajuda
    if /i "%menu_selected_option%" == "h" ( goto application_help )
    if /i "%menu_selected_option%" == "help" ( goto application_help )
    
    if "%menu_selected_option%" == "1" ( goto section_winrar_file )
     
    if "%menu_selected_option%" == "2" ( 
      goto application_close 
    ) else (
      REM Redirecionar o fluxo para o menu inicial.
      goto application_menu_reload
    )


:reload_application_and_variables
   set /a rounds=0
   
   set selected_rar_file=any
   set selected_wordlist=any
   
   set brute_force_start_time=0
   set brute_force_end_time=0
   
   if %allow_logs% EQU 1 ( call :log_with_timestamp "LOG: Restarted!" )
   
goto application_menu


:section_winrar_file
  title Rar Ripper - version: %VERSION% (.RAR) && cls
  echo.
  echo Info: Entrer o "path"/doit etre en: ".rar"  en gros disque\dossier\tontruc.rar
  echo.
  echo HELP: Faites glisser le  ".rar"  vers linvite de commandes (cmd).
  echo.
  set /p "extract_rar_file_path=ton blabla>: "

  if exist "%extract_rar_file_path%" (
    for /d %%r in (%extract_rar_file_path%) do ( 
      set INPUT_RAR_FILE_EXTENSION=%%~xr
    )
   
    if /i "!INPUT_RAR_FILE_EXTENSION!" EQU "!rar_file_extension!" (
      set selected_rar_file=%extract_rar_file_path%
      
      goto section_wordlists_select
    ) else (
      :: Validation du fichier crypt�. L�extension du fichier s�lectionn�
       :: dese �tre �gal � ��.rar��, car le programme ne fonctionne pas avec d�autres types.
       :: En gros, ce n�est pas un fichier valide.
       call :function_not_supported_files "%rar_file_extension%" "extract_rar_file_path"
       
       goto section_winrar_file
    ) 
  ) else ( 
    goto section_winrar_file
  )


:section_wordlists_select
  title Rar Ripepr - version: %VERSION% (.TXT)
  color %command_prompt_color% && cls
  echo.
  echo Pour ajouter une liste de mots personnalisee, entrez le
  echo "chemin/absolu" dans le fichier ".txt" ou selectionnez-en un existant.
  echo.
  echo   2) Wordlist: "wordlists\common_passwords.rar"
  echo.
  echo HELP: As "wordlists" est en winrar elle
  echo  sera decompresse automatiquement.
  echo.
  set wordlist_selected_option_or_path=0
  set /p "wordlist_selected_option_or_path=Digite:> "
  
  if %wordlist_selected_option_or_path% EQU 0 ( goto section_wordlists_select )
  
  if "%wordlist_selected_option_or_path:"=%" == "1" ( 
    call :function_extract_wordlists %brazilian_names_wordlist_rar_path% %brazilian_names_extracted_filename%
    
    :: Path example: "c:\users\root\desktop\wordlists\brazilian_names.txt"
    set selected_wordlist=%brazilian_names_wordlist_file_path%
    
    goto select_winrar_by_processor_architecture
  )
  
  if "%wordlist_selected_option_or_path:"=%" == "2" (
    call :function_extract_wordlists %common_passwords_wordlist_rar_path% %common_passwords_extracted_filename%
    
    set selected_wordlist=%common_passwords_wordlist_file_path%
    
    goto select_winrar_by_processor_architecture
  )
  
  if exist "%wordlist_selected_option_or_path%" (
    for /d %%w in (%wordlist_selected_option_or_path%) do (
      set INPUT_WORDLIST_FILE_EXTENSION=%%~xw
    )
    
    if "!INPUT_WORDLIST_FILE_EXTENSION!" EQU "!wordlist_external_extension!" (
      set selected_wordlist=%wordlist_selected_option_or_path%
      
      goto select_winrar_by_processor_architecture
    ) else (
      :: Na instru��o abaixo, o fluxo do programa ser� redirecionado para a
      :: sele��o de um novo arquivo de "wordlist" ou lista de palavras.
      call :function_not_supported_files "%wordlist_external_extension%" "wordlist_selected_option_or_path"
      
      goto section_wordlists_select 
     )
  ) else ( 
    goto section_wordlists_select 
  )


:select_winrar_by_processor_architecture
  if "%selected_wordlist:"=%" EQU "any" ( goto section_wordlists_select )
    
  if "%selected_rar_file:"=%" EQU "any" ( goto section_winrar_file )

  if exist "%winrar_full_path%" (
    if !allow_logs! EQU 1 ( 
      call :log_with_timestamp "SELECT LOG: Winrar AMD"
    )
    
    :: Garantir a performance e padronizar o tamanho da wordlist.
    call :validate_and_guard_wordlist_sizing "selected_wordlist"
  
    goto brute_winrar_amd
  )
  
  if exist "%winrar_AMD_full_path%" (
    if !allow_logs! EQU 1 ( 
      call :log_with_timestamp "SELECT LOG: Winrar AMDX86"
    )
    
    call :validate_and_guard_wordlist_sizing "selected_wordlist"
  
    goto brute_winrar_amdx86
  ) else (
    :: O execut�vel do "Winrar" n�o foi encontrado e, por esse motivo, o fluxo
    :: ser� redirecionado para a exibi��o de um erro de instala��o.
    goto install_winrar_alert
  )


:validate_and_guard_wordlist_sizing
  set argument_variable_name=%~1

  set wordlist_parsed_file_path="!%argument_variable_name%:"=!"

  for /d %%e in (%wordlist_parsed_file_path%) do (
    set WORD_BYTES=%%~ze
  )

  if !WORD_BYTES! GTR !bytes_wordlist_txt_file_max_size! (
    if !allow_logs! EQU 1 (
      call :log_with_timestamp "LOG: Wordlist size: !WORD_BYTES! Bytes"

      call :log_with_timestamp "LOG: Wordlist file path: '!wordlist_parsed_file_path:"=!'"
    )

    call :displayed_wordlist_max_file_sizing_error "wordlist_parsed_file_path" "!WORD_BYTES!"
  )

goto :eof


:displayed_wordlist_max_file_sizing_error
  title Rar Ripper - version %VERSION% (.TXT ERROR)
  
  set size_error_file=%~1
  set size_error_current_bytes=%~2
  
  set /a wordlist_error_converted_bytes_to_mb=!size_error_current_bytes!/1024
  set /a wordlist_error_converted_bytes_to_mb=!wordlist_error_converted_bytes_to_mb!/1024
  
  color %command_winrar_alert_color% && cls
  echo.
  echo Info: A "wordlist" em seu tamanho, deve ser menor que "%megabytes_wordlist_txt_file_max_size%MB".
  echo.
  echo  Path: !%size_error_file%!
  echo. 
  echo  A lista selecionada possui aproximadamente: "!size_error_current_bytes!Bytes" ou "!wordlist_error_converted_bytes_to_mb!MB".
  echo.
  if %allow_logs% EQU 1 (
    call :log_with_timestamp "LOG: Show size error."
  )
  pause
  
  set force_close=1

goto section_wordlists_select


:brute_winrar_amd
  title Rar Ripper - version %VERSION% (AMD brute)
  color %command_ripper_amd_color% && cls

  set amd_winrar_select_private_file=%selected_rar_file%
  set amd_wordlist_selected_private_file=%selected_wordlist%
 
  set brute_force_start_time=!time:~0,8!
  
  for /f "usebackq tokens=*" %%l in (%amd_wordlist_selected_private_file%) do (
    set /a rounds=!rounds!+1
    
    REM Winrar CLI.
    REM O Winrar disponibiliza uma CLI ou interface de linha de comando para manipular arquivos, e essa CLI
    REM possui algumas flags dispon�veis, "e" - extrair, "-ad" para alterar o diret�rio de destino, "-y"
    REM pular todas as pergundas com "yes" e "-p" para fornecer a senha. Em geral, a linha abaixo � o "core" do script.
    "%winrar_full_path%" e -ad -y -p%%l %amd_winrar_select_private_file% %extracted_directory% >nul
    
    echo.
    echo Path: "%amd_wordlist_selected_private_file:"=%"
    echo [!rounds!] Senha: "%%l"
    echo.
    
    if !errorlevel! EQU 0 (
      set brute_force_end_time=!time:~0,8!
 
      if !allow_logs! EQU 1 ( 
        call :log_with_timestamp "AMD LOG: Winrar password found: %%l"
      )
    
      :: Uma alerta/informa��o "VScript" (".vbs") ser� invocado se existir a ocorr�ncia da senha.
      echo Msgbox "le mot de passe est: %%l", vbinformation, "%RESULT_BOT_NAME%">%extracted_alert_bot_file_path%

      call :down_line_in_text_files "down-details"

      echo Winrar ".rar": !amd_winrar_select_private_file! >>%extracted_result_file_text%
      echo Password: %%l >>%extracted_result_file_text%
      echo Rounds: !rounds! >>%extracted_result_file_text%
      echo Time: !brute_force_start_time! - !brute_force_end_time! >>%extracted_result_file_text%
      
      start /wait %extracted_alert_bot_file_path%

      goto reload_application_and_variables
    )
  )

goto ripper_close


:brute_winrar_amdx86
  title Rar Ripper - version %VERSION% (AMDX86 brute)
  color %command_ripper_amdx86_color% && cls

  set amdx_winrar_select_private_file=%selected_rar_file%
  set amdx_wordlist_selected_private_file=%selected_wordlist%

  set brute_force_start_time=!time:~0,8!
  
  for /f "usebackq tokens=*" %%l in (%amdx_wordlist_selected_private_file%) do (
    set /a rounds=!rounds!+1
    
    "%winrar_AMD_full_path%" e -ad -y -p%%l %amdx_winrar_select_private_file% %extracted_directory% >nul
    
    echo.
    echo Path: "%amdx_wordlist_selected_private_file:"=%"
    echo [!rounds!] Senha: "%%l"
    echo.
    
    if !errorlevel! EQU 0 (
      set brute_force_end_time=!time:~0,8!
            
      if !allow_logs! EQU 1 ( 
        call :log_with_timestamp "AMD LOG: Winrar password found: %%l"
      )
    
      echo Msgbox "le mot de passe est: %%l", vbinformation, "%RESULT_BOT_NAME%">%extracted_alert_bot_file_path%

      call :down_line_in_text_files "down-details"

      echo Winrar ".rar": !amdx_winrar_select_private_file! >>%extracted_result_file_text%
      echo Password: %%l >>%extracted_result_file_text%
      echo Rounds: !rounds! >>%extracted_result_file_text%
      echo Time: !brute_force_start_time! - !brute_force_end_time! >>%extracted_result_file_text%
      
      start /wait %extracted_alert_bot_file_path%
                    
      goto reload_application_and_variables
    )
  )

goto ripper_close


:function_extract_wordlists
  :: Entrada/captura de argumentos.
  :: O primeiro argumento/par�metro (%~1) deve conter o diret�rio do ".rar" compactado.
  :: Por outro lado, o segundo argumento armazena a sa�da desse arquivo rar (em .txt).
  set argument_rar_file=%~1
  set argument_text_file=%~2

  set from_extract_file=%current_directory%\%argument_rar_file%
  set to_extract_dir=%current_directory%\%wordlists_directory%
  
  :: C:\users\root\desktop\wordlists\brazilian_names.txt
  :: C:\users\root\desktop\wordlists\common_passwords.txt
  set to_extracted_file=%to_extract_dir%\%argument_text_file%
      
  if exist "%winrar_full_path%" (
    if not exist "%to_extracted_file%" (
      "%winrar_full_path%" x -y %from_extract_file% %to_extract_dir% && cls
    )
  ) else (
    if exist "%winrar_AMD_full_path%" (
      if not exist "%to_extracted_file%" (
        "%winrar_AMD_full_path%" x -y %from_extract_file% %to_extract_dir% && cls
      )
    ) else ( goto install_winrar_alert )
  )

goto :eof


:function_not_supported_files
  set supported_first_arg_file_extension=%~1
  set supported_second_arg_file_path=%~2
  
  set path_variable=!%supported_second_arg_file_path%!

  title Rar Ripper - version: %VERSION% (support "%supported_first_arg_file_extension%" files) && cls
  echo.
  echo Info: Somente arquivos "%supported_first_arg_file_extension%"^^!
  echo.
  echo  Path: %path_variable%
  echo.
  if %allow_logs% EQU 1 (
    call :log_with_timestamp "LOG: No support: '!path_variable:"=!'"
  )
  pause

goto :eof


REM changelog
:changelog
  cls && title Rar Ripper - version: %VERSION% (changelog) 
  color %command_color%
  echo.
  echo  Rar Ripper - current version: %VERSION%
  echo    changelog:
  echo      Version: 0.0.1
  echo        author: %AUTHOR_NAME% - %AUTHOR_GITHUB_URL%
  echo        release/date: 28/03/2022
  echo.
  echo      Version: 0.0.2
  echo        author: %AUTHOR_NAME% - %AUTHOR_GITHUB_URL%
  echo        release/date: 20/04/2022
  echo.
  echo      Version: 0.0.3
  echo        author: %AUTHOR_NAME% - %AUTHOR_GITHUB_URL%
  echo        release/data: 24/04/2022
  echo.
  echo      Version: 0.0.4
  echo        author: %AUTHOR_NAME% - %AUTHOR_GITHUB_URL%
  echo        release/date: 28/04/2022
  echo        description: Fix bugs...
  echo.
  echo Pressione qualquer tecla para voltar ao Menu...
  if %allow_logs% EQU 1 (
    call :log_with_timestamp "LOG: Changelog."
  )
  pause >nul
  
goto application_menu


:application_help
  title Rar Ripper - version: %VERSION% (@%AUTHOR_NAME% - Winrar BRUTE FORCE)
  color %command_prompt_color% && cls
  echo.  
  echo  1) Todos os direitos reservados
  echo.
  echo  2) Github: %PROJECT_GITHUB_URL%
  echo. 
  echo  3) Bugs/issues: %PROJECT_GITHUB_ISSUES_URL%
  echo.
  echo Pressione qualquer tecla para voltar ao Menu...
  if %allow_logs% EQU 1 ( 
    call :log_with_timestamp "LOG: Help."
  )
  pause >nul
  
goto application_menu


:ripper_close
  title Rar Ripper - version: %VERSION% (ALERT)
  color %command_prompt_color% && cls
  echo.
  echo Info: Senha inexistente. Tente novamente, usando
  echo  outra "wordlist" ou lista de palavras^^!
  echo.
  echo Rar: %selected_rar_file%
  echo.
  echo Text: %selected_wordlist%
  echo.
  if %allow_logs% EQU 1 ( 
    call :log_with_timestamp "LOG: Password not found."
  )
  pause

goto application_close


:install_winrar_alert
  title Rar Ripper - version: %VERSION% (Install Winrar)
  color %command_winrar_alert_color% && cls
  echo.
  echo Info: Instale o "Winrar"^^!
  echo.
  if %allow_logs% EQU 1 ( 
    call :log_with_timestamp "LOG: Install Winrar."
  )
  pause

goto application_close


:cli_syntax
  title Rar Ripper - CLI && cls
  color %command_prompt_color%
  
  echo Ripper.bat, version %VERSION% for Wondows 7, 8.x or later.
  echo This program crack Winrar passwords.
  echo.
  echo Info: Wordlist size: "%megabytes_wordlist_txt_file_max_size%MB".
  echo.
  echo Usage: Ripper [args]
  echo        Examples: .\Ripper.bat "clear-logs" (logs off)
  echo                  .\Ripper.bat (logs on)
  echo.
  echo Written by @lucasbernardol
  echo Github: github.com/lucasbernardol
  echo.
  pause
    
  if %allow_rename_command_prompt_exit% EQU 1 (
    title %command_prompt_exit_title%
  )
  
exit /b


:application_close
  REM Exit - Command Prompt (cmd.exe)!
  
  :: A inst�ncia do cmd (Command Prompt) ir� limpar a tela caso a vari�vel
  :: "allow_clear_in_exit" armazene o valor "1" (ou "true" em booleano).
  if %allow_clear_in_exit% EQU 1 ( cls )
  
  if %allow_rename_command_prompt_exit% EQU 1 (
    title %command_prompt_exit_title%
  )
    
  if %force_close% EQU 1 (
    if !allow_logs! EQU 1 (
      call :log_with_timestamp "LOG: Force closing... Goodbye."
    )
    
    exit
  )
  
  if %allow_logs% EQU 1 (
    call :log_with_timestamp "LOG: Goodbye."
  )

exit /b
