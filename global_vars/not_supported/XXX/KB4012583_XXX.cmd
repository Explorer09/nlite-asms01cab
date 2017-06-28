IF NOT "%LANG%"=="XXX" GOTO :EOF
IF NOT "%GDIPLUS_UPDATE_ID%"=="KB4012583" GOTO :EOF

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
SET SHA1_GDIPLUS_POLICY_X64=ab,52,78,cf,12,38,21,ff,49,bd,4e,56,55,ee,56,d0,f0,2f,87,ae

SET SHA1_GDIPLUS_MSFT_X86_MAN=00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
SET SHA1_GDIPLUS_MSFT_X86_FILE=00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
SET SHA1_GDIPLUS_POLICY_X86=14,bc,09,6a,23,e7,62,c1,97,37,4a,2d,76,1f,19,68,ec,c7,23,e3
