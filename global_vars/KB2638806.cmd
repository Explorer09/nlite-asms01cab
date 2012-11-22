IF NOT "%WINHTTP_UPDATE_ID%"=="KB2638806" GOTO :EOF

REM The directory names of the updated WinSxS components (i.e. DLLs).
SET WINHTTP_MSFT_X64=amd64_Microsoft.Windows.WinHTTP_6595b64144ccf1df_5.1.3790.4929_x-ww_32307663
SET WINHTTP_MSFT_X86=x86_Microsoft.Windows.WinHTTP_6595b64144ccf1df_5.1.3790.4929_x-ww_00269083

REM The file version of the updated components.
SET WINHTTP_VERSION=5.1.3790.4929

REM The registry key names of the policy files.
SET WINHTTP_POLICY_X64_KEY=amd64_policy.5.1.Microsoft.Windows.WinHTTP_6595b64144ccf1df_5.1.3790.4929_x-ww_B1011548
SET WINHTTP_POLICY_X86_KEY=x86_policy.5.1.Microsoft.Windows.WinHTTP_6595b64144ccf1df_5.1.3790.4929_x-ww_7EF72F68
