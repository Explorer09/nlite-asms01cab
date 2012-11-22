REM The character encoding of this file should be SHIFT_JIS or CP932.
REM Please don't change the encoding, as cmd.exe is not aware of the foreign
REM encodings in the batch scripts.

REM This script is designed to be called from write_entries_ini.cmd and NOT
REM from set_global_vars.cmd.

IF NOT "%LANG%"=="JPN" GOTO :EOF

REM Localized strings. Grab these from the ini files.
REM Please DO include quotation marks in the strings. They are not only needed
REM in the INI output, but they also prevent parsing error due to character 
REM encoding bugs (which is also a security vulnerability).
SET SP_TITLE_WS03="Windows Server 2003 セキュリティの更新: サポート技術情報 (KB) %SP_SHORT_TITLE:KB=%"
SET PARENT_DISPLAY_NAME="Windows Server 2003 - ソフトウェアの更新"
SET SP_TITLE_XP="Windows XP セキュリティの更新: サポート技術情報 (KB) %SP_SHORT_TITLE:KB=%"
SET PARENT_DISPLAY_NAME_XP="Windows XP - ソフトウェアの更新"

REM The "prompt" value of the registry subkey "Codebases\U_%SP_SHORT_TITLE%"
SET REG_CODEBASE_PROMPT_VALUE="%OS_STRING_REGKEY% %SP_SHORT_TITLE% コピー元ファイル"
