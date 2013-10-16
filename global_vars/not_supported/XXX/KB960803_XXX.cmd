IF NOT "%LANG%"=="XXX" GOTO :EOF
IF NOT "%WINHTTP_UPDATE_ID%"=="KB960803" GOTO :EOF

REM These SHA-1 hashes are to be written in the file entries_KB[xxxxxx].ini
REM for the nLite addon. Please read the code of ini_maker\addreg_winhttp.cmd
REM for details.

REM The values of SHA1_WINHTTP_MSFT_[arch]_MAN and SHA1_WINHTTP_POLICY_[arch]
REM can be directly obtained by calculating the hash of the respective
REM winhttp.man file.
REM However, you have to install the update and read the values of the
REM SHA1_WINHTTP_MSFT_[arch]_FILE from the registry entries directly, because
REM I cannot find another way to obtain these values.
SET SHA1_WINHTTP_MSFT_X64_MAN=00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
SET SHA1_WINHTTP_MSFT_X64_FILE=00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
SET SHA1_WINHTTP_POLICY_X64=25,ee,7e,73,d3,ac,5b,38,94,11,70,f5,66,7a,62,c5,db,ec,b5,5c

SET SHA1_WINHTTP_MSFT_X86_MAN=00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
SET SHA1_WINHTTP_MSFT_X86_FILE=00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
SET SHA1_WINHTTP_POLICY_X86=98,45,27,a9,59,ac,95,a2,67,ff,dc,b7,cd,77,12,e1,cb,fd,4c,7b
