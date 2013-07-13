REM -------------------------------------------------------------------------

REM The OS language. Should be either "ENU" or "JPN" (without quotes).
REM (The following languages are currently not supported:
REM     CHS, CHT, DEU, ESN, FRA, ITA, KOR, PTB, RUS)
SET LANG=NOT_SET_YET

REM The target operating system. Should be either "XP" or "WS03", which
REM mean Windows XP Pro x64 and Windows Server 2003 x64 respectively.
SET OS_TAG=NOT_SET_YET

REM The KB identifiers of the updates.
SET COMCTL_UPDATE_ID=KB2296011
SET GDIPLUS_UPDATE_ID=KB2834886
SET WINHTTP_UPDATE_ID=KB2638806

REM -------------------------------------------------------------------------

IF "%LANG%"=="NOT_SET_YET" GOTO :EOF
IF "%OS_TAG%"=="NOT_SET_YET" GOTO :EOF

REM The directory names of the policy files.
REM These directory names do not have versions on them, and are the same among
REM the updates.
SET COMCTL5_POLICY_X64=amd64_policy.5.82.Microsoft.Windows.Common-Controls_6595b64144ccf1df_x-ww_C5361FA2
SET COMCTL5_POLICY_X86=x86_policy.5.82.Microsoft.Windows.Common-Controls_6595b64144ccf1df_x-ww_65777D82
SET COMCTL6_POLICY_X64=amd64_policy.6.0.Microsoft.Windows.Common-Controls_6595b64144ccf1df_x-ww_BD997995
SET COMCTL6_POLICY_X86=wow64_policy.6.0.Microsoft.Windows.Common-Controls_6595b64144ccf1df_x-ww_5C2DC83C
SET GDIPLUS_POLICY_X64=amd64_policy.1.0.Microsoft.Windows.GdiPlus_6595b64144ccf1df_x-ww_AE43B2CC
SET GDIPLUS_POLICY_X86=x86_policy.1.0.Microsoft.Windows.GdiPlus_6595b64144ccf1df_x-ww_4E8510AC
SET WINHTTP_POLICY_X64=amd64_policy.5.1.Microsoft.Windows.WinHTTP_6595b64144ccf1df_x-ww_DD275069
SET WINHTTP_POLICY_X86=x86_policy.5.1.Microsoft.Windows.WinHTTP_6595b64144ccf1df_x-ww_7D68AE49

REM File names of the updates.
SET COMCTL_UPDATE_FILE=WindowsServer2003.WindowsXP-%COMCTL_UPDATE_ID%-x64-%LANG%.exe
SET GDIPLUS_UPDATE_FILE=WindowsServer2003.WindowsXP-%GDIPLUS_UPDATE_ID%-x64-%LANG%.exe
SET WINHTTP_UPDATE_FILE=WindowsServer2003.WindowsXP-%WINHTTP_UPDATE_ID%-x64-%LANG%.exe

IF "%OS_TAG%"=="XP" (
    SET OS_STRING_NLITE=Windows XP Pro x64 Edition
    SET OS_STRING_REGKEY=Windows XP Version 2003
) ELSE (
    SET OS_STRING_NLITE=Windows Server 2003 x64
    SET OS_STRING_REGKEY=Windows Server 2003
)

CALL .\%LANG%\language_%LANG%.cmd
CALL .\%COMCTL_UPDATE_ID%.cmd
CALL .\%GDIPLUS_UPDATE_ID%.cmd
CALL .\%WINHTTP_UPDATE_ID%.cmd
