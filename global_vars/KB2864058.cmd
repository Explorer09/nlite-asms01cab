IF NOT "%COMCTL_UPDATE_ID%"=="KB2864058" GOTO :EOF

REM The directory names of the updated WinSxS components (i.e. DLLs).
SET COMCTL5_MSFT_X64=amd64_Microsoft.Windows.Common-Controls_6595b64144ccf1df_5.82.3790.5190_x-ww_04280519
SET COMCTL6_MSFT_X64=amd64_Microsoft.Windows.Common-Controls_6595b64144ccf1df_6.0.3790.5190_x-ww_639C4A9E
SET COMCTL6_MSFT_X86=wow64_Microsoft.Windows.Common-Controls_6595b64144ccf1df_6.0.3790.5190_x-ww_B8C2A5B7
SET COMCTL5_MSFT_X86=x86_Microsoft.Windows.Common-Controls_6595b64144ccf1df_5.82.3790.5190_x-ww_D21E1F39

REM The file version of the updated components.
SET COMCTL5_VERSION=5.82.3790.5190
SET COMCTL6_VERSION=6.0.3790.5190

REM The registry key names of the policy files.
SET COMCTL5_POLICY_X64_KEY=amd64_policy.5.82.Microsoft.Windows.Common-Controls_6595b64144ccf1df_5.82.3790.5190_x-ww_CCF774B1
SET COMCTL6_POLICY_X64_KEY=amd64_policy.6.0.Microsoft.Windows.Common-Controls_6595b64144ccf1df_6.0.3790.5190_x-ww_A6D1DD03
SET COMCTL6_POLICY_X86_KEY=wow64_policy.6.0.Microsoft.Windows.Common-Controls_6595b64144ccf1df_6.0.3790.5190_x-ww_FBF8381C
SET COMCTL5_POLICY_X86_KEY=x86_policy.5.82.Microsoft.Windows.Common-Controls_6595b64144ccf1df_5.82.3790.5190_x-ww_9AED8ED1

REM The list of updates that this one supersedes, separated by spaces.
REM Except for COMCTL, Windows Update will still offer the obsolete updates,
REM because they don't admit the replacement.
SET COMCTL_REPLACED_UPDATES=KB2296011
