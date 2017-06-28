IF NOT "%GDIPLUS_UPDATE_ID%"=="KB4012583" GOTO :EOF

REM The directory names of the updated WinSxS components (i.e. DLLs).
SET GDIPLUS_MSFT_X64=amd64_Microsoft.Windows.GdiPlus_6595b64144ccf1df_1.0.6002.24064_x-ww_54820B71
SET GDIPLUS_MSFT_X86=x86_Microsoft.Windows.GdiPlus_6595b64144ccf1df_1.0.6002.24064_x-ww_22782591

REM The file version of the updated components.
SET GDIPLUS_VERSION=1.0.6002.24064

REM The registry key names of the policy files.
SET GDIPLUS_POLICY_X64_KEY=amd64_policy.1.0.Microsoft.Windows.GdiPlus_6595b64144ccf1df_1.0.6002.24064_x-ww_6249A1D1
SET GDIPLUS_POLICY_X86_KEY=x86_policy.1.0.Microsoft.Windows.GdiPlus_6595b64144ccf1df_1.0.6002.24064_x-ww_303FBBF1

REM The list of updates that this one supersedes, separated by spaces.
REM Except for COMCTL, Windows Update will still offer the obsolete updates,
REM because they don't admit the replacement.
SET GDIPLUS_REPLACED_UPDATES=KB2659262 KB2834886
