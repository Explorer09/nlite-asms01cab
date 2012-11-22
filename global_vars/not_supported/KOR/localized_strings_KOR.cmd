REM The character encoding of this file is EUC-KR or CP949.
REM Please don't change the encoding, as cmd.exe is not aware of the foreign
REM encodings in the batch scripts.

REM This script is designed to be called from write_entries_ini.cmd and NOT
REM from set_global_vars.cmd.

IF NOT "%LANG%"=="KOR" GOTO :EOF

REM Localized strings. Grab these from the ini files.
REM Please DO include quotation marks in the strings. They are not only needed
REM in the INI output, but they also prevent parsing error due to character 
REM encoding bugs (which is also a security vulnerability).
SET SP_TITLE_WS03="Windows Server 2003 보안 업데이트(%SP_SHORT_TITLE%)"
SET PARENT_DISPLAY_NAME="Windows Server 2003 - 소프트웨어 업데이트"
SET SP_TITLE_XP="Windows XP 보안 업데이트(%SP_SHORT_TITLE%)"
SET PARENT_DISPLAY_NAME_XP="Windows XP - 소프트웨어 업데이트"

REM The "prompt" value of the registry subkey "Codebases\U_%SP_SHORT_TITLE%"
SET REG_CODEBASE_PROMPT_VALUE="%OS_STRING_REGKEY% %SP_SHORT_TITLE% 원본 파일"
