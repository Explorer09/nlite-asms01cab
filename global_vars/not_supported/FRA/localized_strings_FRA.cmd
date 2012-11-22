REM The character encoding of this file should be ISO-8859-1 or WINDOWS-1252.
REM Please don't change the encoding, as cmd.exe is not aware of the foreign
REM encodings in the batch scripts.

REM This script is designed to be called from write_entries_ini.cmd and NOT
REM from set_global_vars.cmd.

IF NOT "%LANG%"=="FRA" GOTO :EOF

REM Localized strings. Grab these from the ini files.
REM Please DO include quotation marks in the strings. They are not only needed
REM in the INI output, but they also prevent parsing error due to character 
REM encoding bugs (which is also a security vulnerability).
SET SP_TITLE_WS03="Mise à jour de sécurité pour Windows Server 2003 (article %SP_SHORT_TITLE%)"
SET PARENT_DISPLAY_NAME="Windows Server 2003 - Mises à jour logicielles"
SET SP_TITLE_XP="Mise à jour de sécurité pour Windows XP (article %SP_SHORT_TITLE%)"
SET PARENT_DISPLAY_NAME_XP="Windows XP - Mises à jour logicielles"

REM The "prompt" value of the registry subkey "Codebases\U_%SP_SHORT_TITLE%"
SET REG_CODEBASE_PROMPT_VALUE="Fichiers source du %SP_SHORT_TITLE% pour %OS_STRING_REGKEY%"
