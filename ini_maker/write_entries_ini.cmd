@ECHO OFF
SETLOCAL EnableExtensions

REM ---------------------------------------------------------------------------
REM Copyright (C) 2012 Kang-Che Sung <explorer09 @ gmail.com>

REM This program is free software; you can redistribute it and/or
REM modify it under the terms of the GNU General Public License
REM as published by the Free Software Foundation; either version 2
REM of the License, or (at your option) any later version.

REM This program is distributed in the hope that it will be useful,
REM but WITHOUT ANY WARRANTY; without even the implied warranty of
REM MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
REM GNU General Public License for more details.

REM You should have received a copy of the GNU General Public License
REM along with this program; if not, write to the Free Software
REM Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, 
REM MA  02110-1301, USA.
REM ---------------------------------------------------------------------------

REM /**
REM  * write_entries_ini.cmd - Generates output of entries_KBxxxxxx.ini in stdout.
REM  *
REM  * The language, OS, and the update IDs are fetched from the global variables.
REM  *
REM  * @param %1 Component. The value must be "comctl", "gdiplus", or "winhttp" (without quotes)
REM  * @param %2 Set this to "yes" to strip the optional registry entries.
REM  */

SET buildDate=2012-11-22
SET component=%1
SET stripOptionalEntries=%2
IF /I "%stripOptionalEntries%"=="Y" SET stripOptionalEntries=YES
IF /I "%stripOptionalEntries%"=="YES" SET stripOptionalEntries=YES

PUSHD ..\global_vars
CALL set_global_vars.cmd
POPD
IF /I "%component%"=="comctl" (
    SET installedEntryIsOptional=true
    SET SP_SHORT_TITLE=%COMCTL_UPDATE_ID%
    SET REPLACED_UPDATES=%COMCTL_REPLACED_UPDATES%
) ELSE IF /I "%component%"=="gdiplus" (
    SET installedEntryIsOptional=false
    SET SP_SHORT_TITLE=%GDIPLUS_UPDATE_ID%
    SET REPLACED_UPDATES=%GDIPLUS_REPLACED_UPDATES%
) ELSE IF /I "%component%"=="winhttp" (
    SET installedEntryIsOptional=false
    SET SP_SHORT_TITLE=%WINHTTP_UPDATE_ID%
    SET REPLACED_UPDATES=%WINHTTP_REPLACED_UPDATES%
) ELSE (
    GOTO end
)

IF /I "%REPLACED_UPDATES%"=="none" SET REPLACED_UPDATES=

REM Note: The localized_strings.cmd requires the %SP_SHORT_TITLE% variable.
CALL ..\global_vars\%LANG%\localized_strings_%LANG%.cmd
CALL ..\global_vars\%LANG%\%SP_SHORT_TITLE%_%LANG%.cmd

IF NOT EXIST addreg_%component%.cmd GOTO end

:start
    ECHO [general]
    ECHO builddate=%buildDate%
    ECHO description=Security update %SP_SHORT_TITLE% for %OS_STRING_NLITE%
    ECHO language=%LANGUAGE%
    ECHO title=%SP_SHORT_TITLE%
    ECHO website=%SP_SHORT_TITLE:KB=http://support.microsoft.com/kb/%
    ECHO.
    ECHO [registry_addreg]

    CALL addreg_%component%.cmd

    IF NOT "%installedEntryIsOptional%"=="true" (
        ECHO.
        ECHO HKLM,SOFTWARE\Microsoft\Windows NT\CurrentVersion\Hotfix\%SP_SHORT_TITLE%,"Installed",0x10001,1
        FOR %%i IN (%REPLACED_UPDATES%) DO (
            ECHO.
            ECHO ; The %%i update is obsolete, but Windows Update will still offer to install it.
            ECHO ; Because Microsoft sometimes don't admit that %%i is superseded by %SP_SHORT_TITLE%.
            ECHO HKLM,SOFTWARE\Microsoft\Windows NT\CurrentVersion\Hotfix\%%i,"Installed",0x10001,1
        )
    )
    IF NOT "%stripOptionalEntries%"=="YES" (
        ECHO.
        ECHO ; The lines below can be removed if you want the minimum registry overhead.
        IF "%installedEntryIsOptional%"=="true" (
            FOR %%i IN (%REPLACED_UPDATES%) DO (
                ECHO ; The %%i update is replaced by %SP_SHORT_TITLE%.
                ECHO HKLM,SOFTWARE\Microsoft\Windows NT\CurrentVersion\Hotfix\%%i,"Installed",0x10001,1
            )
            ECHO HKLM,SOFTWARE\Microsoft\Windows NT\CurrentVersion\Hotfix\%SP_SHORT_TITLE%,"Installed",0x10001,1
        )
        ECHO HKLM,SOFTWARE\Microsoft\Windows NT\CurrentVersion\Hotfix\%SP_SHORT_TITLE%,"Backup Dir",0,""
        ECHO HKLM,SOFTWARE\Microsoft\Windows NT\CurrentVersion\Hotfix\%SP_SHORT_TITLE%,"Installed By",0,""
        ECHO HKLM,SOFTWARE\Microsoft\Windows NT\CurrentVersion\Hotfix\%SP_SHORT_TITLE%,"Installed On",0,""
        ECHO HKLM,SOFTWARE\Microsoft\Windows NT\CurrentVersion\Hotfix\%SP_SHORT_TITLE%,"Service Pack",0x10001,3
        ECHO HKLM,SOFTWARE\Microsoft\Windows NT\CurrentVersion\Hotfix\%SP_SHORT_TITLE%,"Valid",0x10001,1
        ECHO HKLM,SOFTWARE\Microsoft\Windows NT\CurrentVersion\Hotfix\%SP_SHORT_TITLE%\File 1\,"Flags",0,""
        ECHO HKLM,SOFTWARE\Microsoft\Windows NT\CurrentVersion\Hotfix\%SP_SHORT_TITLE%\File 1\,"New File",0,""
        ECHO HKLM,SOFTWARE\Microsoft\Windows NT\CurrentVersion\Hotfix\%SP_SHORT_TITLE%\File 1\,"New Link Date",0,""
        ECHO HKLM,SOFTWARE\Microsoft\Windows NT\CurrentVersion\Hotfix\%SP_SHORT_TITLE%\File 1\,"Old Link Date",0,""
        ECHO HKLM,SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\%SP_SHORT_TITLE%,"ReleaseType",0,"Security Update"
        ECHO HKLM,SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\%SP_SHORT_TITLE%,"ParentKeyName",0,"OperatingSystem"
        ECHO.
        IF "%OS_TAG%"=="XP" (
            ECHO HKLM,SOFTWARE\Microsoft\Windows NT\CurrentVersion\Hotfix\%SP_SHORT_TITLE%,"Comments",0,%SP_TITLE_XP%
            ECHO HKLM,SOFTWARE\Microsoft\Windows NT\CurrentVersion\Hotfix\%SP_SHORT_TITLE%,"Fix Description",0,%SP_TITLE_XP%
            ECHO HKLM,SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\%SP_SHORT_TITLE%,"RegistryLocation",0,"HKLM\SOFTWARE\Microsoft\Updates\Windows XP Version 2003\SP3\%SP_SHORT_TITLE%"
            ECHO HKLM,SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\%SP_SHORT_TITLE%,"ParentDisplayName",0,%PARENT_DISPLAY_NAME_XP%
            ECHO HKLM,SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\%SP_SHORT_TITLE%,"DisplayName",0,%SP_TITLE_XP%
            ECHO HKLM,SOFTWARE\Microsoft\Updates\Windows XP Version 2003\SP3\%SP_SHORT_TITLE%,"Description",,%SP_TITLE_XP%
        ) ELSE (
            ECHO HKLM,SOFTWARE\Microsoft\Windows NT\CurrentVersion\Hotfix\%SP_SHORT_TITLE%,"Comments",0,%SP_TITLE_WS03%
            ECHO HKLM,SOFTWARE\Microsoft\Windows NT\CurrentVersion\Hotfix\%SP_SHORT_TITLE%,"Fix Description",0,%SP_TITLE_WS03%
            ECHO HKLM,SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\%SP_SHORT_TITLE%,"RegistryLocation",0,"HKLM\SOFTWARE\Microsoft\Updates\Windows Server 2003\SP3\%SP_SHORT_TITLE%"
            ECHO HKLM,SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\%SP_SHORT_TITLE%,"ParentDisplayName",0,%PARENT_DISPLAY_NAME%
            ECHO HKLM,SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\%SP_SHORT_TITLE%,"DisplayName",0,%SP_TITLE_WS03%
            ECHO HKLM,SOFTWARE\Microsoft\Updates\Windows Server 2003\SP3\%SP_SHORT_TITLE%,"Description",,%SP_TITLE_WS03%
        )
        ECHO ; The lines above can be removed.
    )

:end
    ENDLOCAL
