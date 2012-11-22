IF NOT "%LANG%"=="XXX" GOTO :EOF
IF NOT "%GDIPLUS_UPDATE_ID%"=="KB2659262" GOTO :EOF

REM These SHA-1 hashes are to be written in the file entries_KB[xxxxxx].ini
REM for the nLite addon. Please read the code of ini_maker\addreg_gdiplus.cmd
REM for details.

REM The values of SHA1_GDIPLUS_MSFT_[arch]_MAN and SHA1_GDIPLUS_POLICY_[arch]
REM can be directly obtained by calculating the hash of the respective
REM gdiplus.man file.
REM However, you have to install the update and read the values of the
REM SHA1_GDIPLUS_MSFT_[arch]_FILE from the registry entries directly, because
REM I cannot find another way to obtain these values.
SET SHA1_GDIPLUS_MSFT_X64_MAN=00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
SET SHA1_GDIPLUS_MSFT_X64_FILE=00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
SET SHA1_GDIPLUS_POLICY_X64=36,f3,47,b6,2d,ad,ab,20,ce,72,63,af,2f,6a,39,d5,47,ef,6c,ec

SET SHA1_GDIPLUS_MSFT_X86_MAN=00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
SET SHA1_GDIPLUS_MSFT_X86_FILE=00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
SET SHA1_GDIPLUS_POLICY_X86=96,20,13,91,2e,ca,13,96,8d,a7,32,90,fb,4e,c6,b1,84,aa,68,5d
