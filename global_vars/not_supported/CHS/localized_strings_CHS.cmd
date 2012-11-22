REM The character encoding of this file should be GB2312, GBK, or CP950.
REM Please don't change the encoding, as cmd.exe is not aware of the foreign
REM encodings in the batch scripts.

REM This script is designed to be called from write_entries_ini.cmd and NOT
REM from set_global_vars.cmd.

IF NOT "%LANG%"=="CHS" GOTO :EOF

REM Localized strings. Grab these from the ini files.
REM Please DO include quotation marks in the strings. They are not only needed
REM in the INI output, but they also prevent parsing error due to character 
REM encoding bugs (which is also a security vulnerability).
SET SP_TITLE_WS03="Windows Server 2003 ��ȫ���� (%SP_SHORT_TITLE%)"
SET PARENT_DISPLAY_NAME="Windows Server 2003 - �������"
SET SP_TITLE_XP="Windows XP ��ȫ���� (%SP_SHORT_TITLE%)"
SET PARENT_DISPLAY_NAME_XP="Windows XP - �������"

REM The "prompt" value of the registry subkey "Codebases\U_%SP_SHORT_TITLE%"
SET REG_CODEBASE_PROMPT_VALUE="%OS_STRING_REGKEY% %SP_SHORT_TITLE% Դ�ļ�"
