IF NOT "%LANG%"=="XXX" GOTO :EOF
IF NOT "%COMCTL_UPDATE_ID%"=="KB2296011" GOTO :EOF

REM These SHA-1 hashes are to be written in the file entries_KB[xxxxxx].ini
REM for the nLite addon. Please read the code of ini_maker\addreg_comctl.cmd
REM for details.

REM The values of SHA1_COMCTL[x]_MSFT_[arch]_MAN and
REM SHA1_COMCTL[x]_POLICY_[arch] can be directly obtained by calculating the 
REM hash of the respective controls.man file.
REM However, you have to install the update and read the values of the
REM SHA1_COMCTL[x]_MSFT_[arch]_FILE from the registry entries directly, because
REM I cannot find another way to obtain these values.
SET SHA1_COMCTL5_MSFT_X64_MAN=00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
SET SHA1_COMCTL5_MSFT_X64_FILE=00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
SET SHA1_COMCTL6_MSFT_X64_MAN=00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
SET SHA1_COMCTL6_MSFT_X64_FILE=00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
SET SHA1_COMCTL5_POLICY_X64=b0,eb,14,62,d9,cb,bc,38,ff,d3,70,80,f4,0d,ce,99,3b,a6,72,4d
SET SHA1_COMCTL6_POLICY_X64=78,a6,7a,17,5b,5a,7b,14,85,d5,05,a9,26,e2,0f,0e,a6,02,7b,13

SET SHA1_COMCTL6_MSFT_X86_MAN=00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
SET SHA1_COMCTL6_MSFT_X86_FILE=00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
SET SHA1_COMCTL6_POLICY_X86=0f,0a,39,39,94,22,af,97,a1,37,26,96,c1,c1,0e,27,56,d3,3b,89

SET SHA1_COMCTL5_MSFT_X86_MAN=00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
SET SHA1_COMCTL5_MSFT_X86_FILE=00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
SET SHA1_COMCTL5_POLICY_X86=6f,0c,ed,3f,c5,c0,86,34,c8,30,67,aa,cf,fc,e8,2c,1e,cb,22,a7
