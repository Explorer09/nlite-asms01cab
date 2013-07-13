IF NOT "%LANG%"=="XXX" GOTO :EOF
IF NOT "%GDIPLUS_UPDATE_ID%"=="KB2834886" GOTO :EOF

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
SET SHA1_GDIPLUS_POLICY_X64=d2,68,e7,a5,f6,86,5e,40,7f,5c,f4,e1,dc,a6,e7,ad,1e,0f,c9,b2

SET SHA1_GDIPLUS_MSFT_X86_MAN=00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
SET SHA1_GDIPLUS_MSFT_X86_FILE=00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
SET SHA1_GDIPLUS_POLICY_X86=80,eb,0f,1e,aa,3f,00,6b,93,d5,d8,09,11,56,71,39,3c,46,23,5d
