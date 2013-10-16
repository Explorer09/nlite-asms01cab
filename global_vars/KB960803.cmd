IF NOT "%WINHTTP_UPDATE_ID%"=="KB960803" GOTO :EOF

REM The directory names of the updated WinSxS components (i.e. DLLs).
SET WINHTTP_MSFT_X64=amd64_Microsoft.Windows.WinHTTP_6595b64144ccf1df_5.1.3790.4427_x-ww_2FBA28DC
SET WINHTTP_MSFT_X86=x86_Microsoft.Windows.WinHTTP_6595b64144ccf1df_5.1.3790.4427_x-ww_FDB042FC

REM The file version of the updated components.
SET WINHTTP_VERSION=5.1.3790.4427

REM The registry key names of the policy files.
SET WINHTTP_POLICY_X64_KEY=amd64_policy.5.1.Microsoft.Windows.WinHTTP_6595b64144ccf1df_5.1.3790.4427_x-ww_AE8AC7C1
SET WINHTTP_POLICY_X86_KEY=x86_policy.5.1.Microsoft.Windows.WinHTTP_6595b64144ccf1df_5.1.3790.4427_x-ww_7C80E1E1

REM The list of updates that this one supersedes, separated by spaces.
REM Except for COMCTL, Windows Update will still offer the obsolete updates,
REM because they don't admit the replacement.
SET WINHTTP_REPLACED_UPDATES=none
