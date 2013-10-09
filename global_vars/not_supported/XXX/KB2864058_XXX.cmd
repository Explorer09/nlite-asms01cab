IF NOT "%LANG%"=="XXX" GOTO :EOF
IF NOT "%COMCTL_UPDATE_ID%"=="KB2864058" GOTO :EOF

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
SET SHA1_COMCTL5_POLICY_X64=87,db,17,62,9a,00,90,ee,51,79,92,bc,ae,e3,db,0c,e0,fa,9e,30
SET SHA1_COMCTL6_POLICY_X64=df,4e,df,26,66,4b,96,a8,2e,0c,50,0a,6e,b0,7a,33,9b,3a,3d,42

SET SHA1_COMCTL6_MSFT_X86_MAN=00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
SET SHA1_COMCTL6_MSFT_X86_FILE=00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
SET SHA1_COMCTL6_POLICY_X86=d9,da,6c,d3,e0,24,4e,37,af,39,f9,f8,55,80,36,2a,16,fc,f8,47

SET SHA1_COMCTL5_MSFT_X86_MAN=00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
SET SHA1_COMCTL5_MSFT_X86_FILE=00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
SET SHA1_COMCTL5_POLICY_X86=4c,05,d5,23,16,59,83,95,e9,fe,a7,42,0a,8a,6e,3f,10,bc,55,47
