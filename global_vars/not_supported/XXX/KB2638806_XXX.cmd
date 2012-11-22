IF NOT "%LANG%"=="XXX" GOTO :EOF
IF NOT "%WINHTTP_UPDATE_ID%"=="KB2638806" GOTO :EOF

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
SET SHA1_WINHTTP_POLICY_X64=92,68,45,15,69,64,11,4e,df,e9,f9,d6,7d,7a,50,2b,17,66,f3,ab

SET SHA1_WINHTTP_MSFT_X86_MAN=00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
SET SHA1_WINHTTP_MSFT_X86_FILE=00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
SET SHA1_WINHTTP_POLICY_X86=41,1b,13,02,83,20,a0,92,f1,fa,3b,08,c7,ca,cc,44,7b,90,09,e3
