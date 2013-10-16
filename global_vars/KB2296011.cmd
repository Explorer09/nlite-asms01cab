IF NOT "%COMCTL_UPDATE_ID%"=="KB2296011" GOTO :EOF

REM The directory names of the updated WinSxS components (i.e. DLLs).
SET COMCTL5_MSFT_X64=amd64_Microsoft.Windows.Common-Controls_6595b64144ccf1df_5.82.3790.4770_x-ww_D89390E2
SET COMCTL6_MSFT_X64=amd64_Microsoft.Windows.Common-Controls_6595b64144ccf1df_6.0.3790.4770_x-ww_3807D667
SET COMCTL6_MSFT_X86=wow64_Microsoft.Windows.Common-Controls_6595b64144ccf1df_6.0.3790.4770_x-ww_8D2E3180
SET COMCTL5_MSFT_X86=x86_Microsoft.Windows.Common-Controls_6595b64144ccf1df_5.82.3790.4770_x-ww_A689AB02

REM The file version of the updated components.
SET COMCTL5_VERSION=5.82.3790.4770
SET COMCTL6_VERSION=6.0.3790.4770

REM The registry key names of the policy files.
SET COMCTL5_POLICY_X64_KEY=amd64_policy.5.82.Microsoft.Windows.Common-Controls_6595b64144ccf1df_5.82.3790.4770_x-ww_A163007A
SET COMCTL6_POLICY_X64_KEY=amd64_policy.6.0.Microsoft.Windows.Common-Controls_6595b64144ccf1df_6.0.3790.4770_x-ww_7B3D68CC
SET COMCTL6_POLICY_X86_KEY=wow64_policy.6.0.Microsoft.Windows.Common-Controls_6595b64144ccf1df_6.0.3790.4770_x-ww_D063C3E5
SET COMCTL5_POLICY_X86_KEY=x86_policy.5.82.Microsoft.Windows.Common-Controls_6595b64144ccf1df_5.82.3790.4770_x-ww_6F591A9A

REM The list of updates that this one supersedes, separated by spaces.
REM Except for COMCTL, Windows Update will still offer the obsolete updates,
REM because they don't admit the replacement.
SET COMCTL_REPLACED_UPDATES=none
