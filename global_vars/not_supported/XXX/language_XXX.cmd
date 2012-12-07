IF NOT "%LANG%"=="XXX" GOTO :EOF

REM The LANGUAGE variable is the name of the language in English. It is shown
REM on nLite when the user includes the addons.
SET LANGUAGE=Unknown language

REM The code page used in DOS and Windows cmd.exe. It should be obtained via
REM the "chcp" command.
REM Note that the code page is DOS is usually different from the character
REM encoding used in text files. (For example, the English version of Windows
REM uses CP437 in cmd.exe while the text files are saved in CP1252.)
SET DOS_CODEPAGE=000
