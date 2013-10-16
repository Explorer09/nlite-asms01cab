IF NOT "%GDIPLUS_UPDATE_ID%"=="KB2659262" GOTO :EOF

REM The directory names of the updated WinSxS components (i.e. DLLs).
SET GDIPLUS_MSFT_X64=amd64_Microsoft.Windows.GdiPlus_6595b64144ccf1df_1.0.6002.22791_x-ww_FAE9D734
SET GDIPLUS_MSFT_X86=x86_Microsoft.Windows.GdiPlus_6595b64144ccf1df_1.0.6002.22791_x-ww_C8DFF154

REM The file version of the updated components.
SET GDIPLUS_VERSION=5.1.6002.22791

REM The registry key names of the policy files.
SET GDIPLUS_POLICY_X64_KEY=amd64_policy.1.0.Microsoft.Windows.GdiPlus_6595b64144ccf1df_5.1.6002.22791_x-ww_DFCD8D4F
SET GDIPLUS_POLICY_X86_KEY=x86_policy.1.0.Microsoft.Windows.GdiPlus_6595b64144ccf1df_5.1.6002.22791_x-ww_ADC3A76F

REM The list of updates that this one supersedes, separated by spaces.
REM Except for COMCTL, Windows Update will still offer the obsolete updates,
REM because they don't admit the replacement.
SET GDIPLUS_REPLACED_UPDATES=none
