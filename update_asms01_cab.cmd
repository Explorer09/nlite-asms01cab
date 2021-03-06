@ECHO OFF
SETLOCAL EnableExtensions EnableDelayedExpansion

REM ---------------------------------------------------------------------------
REM Copyright (C) 2012-2013 Kang-Che Sung <explorer09 @ gmail.com>

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

PUSHD global_vars
CALL set_global_vars.cmd
POPD

SET hasErrors=false

:intro
    IF "!LANG!"=="NOT_SET_YET" (
        ECHO ERROR: LANG variable is not set!
        ECHO Please edit set_global_vars.cmd and set the variable.
        SET hasErrors=true
    )
    IF "!OS_TAG!"=="NOT_SET_YET" (
        ECHO ERROR: OS_TAG variable is not set!
        ECHO Please edit set_global_vars.cmd and set the variable.
        SET hasErrors=true
    )
    IF "!hasErrors!"=="true" (
        GOTO error
    )
    ECHO ASMS01.cab update script for !OS_STRING_NLITE!
    ECHO Language: !LANGUAGE!
    ECHO.
    ECHO Supported updates:
    ECHO - !COMCTL_UPDATE_ID! (Common Controls)
    ECHO - !GDIPLUS_UPDATE_ID! (GDIPlus)
    ECHO - !WINHTTP_UPDATE_ID! (WinHTTP)
    ECHO ----
    ECHO.

:fileCheck
    FOR %%f IN (
        cabarc.exe
        filelists\!LANG!\asms01.txt
        filelists\comctl.txt
        filelists\gdiplus.txt
        filelists\winhttp.txt
        global_vars\!LANG!\!COMCTL_UPDATE_ID!_!LANG!.cmd
        global_vars\!LANG!\!GDIPLUS_UPDATE_ID!_!LANG!.cmd
        global_vars\!LANG!\!WINHTTP_UPDATE_ID!_!LANG!.cmd
        global_vars\!LANG!\localized_strings_!LANG!.cmd
        ini_maker\addreg_comctl.cmd
        ini_maker\addreg_gdiplus.cmd
        ini_maker\addreg_winhttp.cmd
        ini_maker\write_entries_ini.cmd
    ) DO (
        IF NOT EXIST "%%f" (
            ECHO ERROR: This script requires the file "%%f".
            SET hasErrors=true
        )
    )
    IF NOT EXIST "ASMS01.CAB" (
        IF EXIST "ASMS01_old.cab" (
            MOVE ASMS01_old.cab ASMS01.CAB
        ) ELSE (
            ECHO ERROR: This script requires the file "ASMS01.CAB".
            SET hasErrors=true
        )
    )
    FOR %%f IN (
        work_dir
        ASMS01_new.cab
        addon_!COMCTL_UPDATE_ID!.cab
        addon_!GDIPLUS_UPDATE_ID!.cab
        addon_!WINHTTP_UPDATE_ID!.cab
    ) DO (
        IF EXIST "%%f" (
            ECHO ERROR: Please delete the file "%%f" or move it away.
            SET hasErrors=true
        )
    )
    IF "!hasErrors!"=="true" (
        GOTO error
    )

:codePageCheck
    REM Command substitution in cmd.exe
    FOR /F "delims=" %%n IN ('chcp') DO (
        SET activeCodePage=%%n
    )
    SET activeCodePage=!activeCodePage:~-3,3!
    IF NOT "!activeCodePage!"=="!DOS_CODEPAGE!" (
        ECHO WARNING: Your active code page ^(!activeCodePage!^) does not match the recommended code page
        ECHO for your language ^(!DOS_CODEPAGE!^).
        ECHO.
        ECHO This means that your current locale setting might not be suitable for
        ECHO slipstreaming a !LANGUAGE! version of Windows.
        ECHO Please go to "Control Panel" -^> "Regional and Language Options", click the
        ECHO "Advanced" tab, and use the drop-down in "Language for non-Unicode programs"
        ECHO to adjust the system locale.
        ECHO.
        ECHO If you continue, there might be some localized strings in the nLite addons that
        ECHO are not written correctly, or contain invalid characters. ^(This will affect
        ECHO some registry entries in the target OS, but the OS will still work.^)
        ECHO.
        PAUSE
    )

:prompt
    SET /p prompt="Do you wish to keep the old files in ASMS01.CAB (recommended) [Y/n]? "
    SET keepOldFiles=YES
    IF /I "!prompt!"=="N" SET keepOldFiles=NO
    IF /I "!prompt!"=="NO" SET keepOldFiles=NO
    IF "!keepOldFiles!"=="YES" (
        ECHO Old files will be preserved.
    ) ELSE (
        ECHO Old files will be deleted.
    )
    SET /p prompt="Preserve the optional registry entries in the INI files (recommended) [Y/n]? "
    SET optionalEntries=keep
    IF /I "!prompt!"=="N" SET optionalEntries=remove
    IF /I "!prompt!"=="NO" SET optionalEntries=remove
    IF "!optionalEntries!"=="keep" (
        ECHO The optional registry entries will be preserved.
    ) ELSE (
        ECHO The optional registry entries will be stripped.
    )
    ECHO Press any key to start.
    PAUSE>NUL

:start
    MKDIR work_dir
    MKDIR work_dir\WinSxS

    IF NOT "!activeCodePage!"=="!DOS_CODEPAGE!" (
        ECHO WARNING: Your active code page ^(!activeCodePage!^) does not match the recommended code page
        ECHO for your language ^(!DOS_CODEPAGE!^).
    )>>work_dir\warnings.txt

    ECHO.
    ECHO Extracting updates...
    IF EXIST "!COMCTL_UPDATE_FILE!" (
        ECHO !COMCTL_UPDATE_FILE!
        SET hasComCtlUpdate=true
        START /wait !COMCTL_UPDATE_FILE! /extract:work_dir /passive
    )
    IF EXIST "!GDIPLUS_UPDATE_FILE!" (
        ECHO !GDIPLUS_UPDATE_FILE!
        SET hasGdiPlusUpdate=true
        START /wait !GDIPLUS_UPDATE_FILE! /extract:work_dir /passive
    )
    If EXIST "!WINHTTP_UPDATE_FILE!" (
        ECHO !WINHTTP_UPDATE_FILE!
        SET hasWinHttpUpdate=true
        START /wait !WINHTTP_UPDATE_FILE! /extract:work_dir /passive
    )

    ECHO.
    ECHO Extracting ASMS01.CAB...
    MOVE ASMS01.CAB work_dir\WinSxS
    CD work_dir\WinSxS
    ..\..\cabarc -p X ASMS01.CAB
    MOVE ASMS01.CAB ..\..\ASMS01_old.cab
    CD ..\..

    REM The processes below are all in work_dir.
    CD work_dir

    ECHO.
    ECHO Making directories...
    IF "!hasComCtlUpdate!"=="true" (
        FOR %%d IN (
            addon_!COMCTL_UPDATE_ID!
            addon_!COMCTL_UPDATE_ID!\x64_i386
            addon_!COMCTL_UPDATE_ID!\SVCPACK
            WinSxS\!COMCTL5_MSFT_X64!
            WinSxS\!COMCTL5_MSFT_X86!
            WinSxS\!COMCTL6_MSFT_X64!
            WinSxS\!COMCTL6_MSFT_X86!
            WinSxS\policies\!COMCTL5_POLICY_X64!
            WinSxS\policies\!COMCTL5_POLICY_X86!
            WinSxS\policies\!COMCTL6_POLICY_X64!
            WinSxS\policies\!COMCTL6_POLICY_X86!
            WinSxS\setuppolicies\!COMCTL5_POLICY_X64!
            WinSxS\setuppolicies\!COMCTL5_POLICY_X86!
            WinSxS\setuppolicies\!COMCTL6_POLICY_X64!
            WinSxS\setuppolicies\!COMCTL6_POLICY_X86!
        ) DO (
            IF NOT EXIST "%%d" MKDIR %%d
        )
    )
    IF "!hasGdiPlusUpdate!"=="true" (
        FOR %%d IN (
            addon_!GDIPLUS_UPDATE_ID!
            addon_!GDIPLUS_UPDATE_ID!\SVCPACK
            WinSxS\!GDIPLUS_MSFT_X64!
            WinSxS\!GDIPLUS_MSFT_X86!
            WinSxS\policies\!GDIPLUS_POLICY_X64!
            WinSxS\policies\!GDIPLUS_POLICY_X86!
            WinSxS\setuppolicies\!GDIPLUS_POLICY_X64!
            WinSxS\setuppolicies\!GDIPLUS_POLICY_X86!
        ) DO (
            IF NOT EXIST "%%d" MKDIR %%d
        )
    )
    IF "!hasWinHttpUpdate!"=="true" (
        FOR %%d IN (
            addon_!WINHTTP_UPDATE_ID!
            addon_!WINHTTP_UPDATE_ID!\SVCPACK
            WinSxS\!WINHTTP_MSFT_X64!
            WinSxS\!WINHTTP_MSFT_X86!
            WinSxS\policies\!WINHTTP_POLICY_X64!
            WinSxS\policies\!WINHTTP_POLICY_X86!
            WinSxS\setuppolicies\!WINHTTP_POLICY_X64!
            WinSxS\setuppolicies\!WINHTTP_POLICY_X86!
        ) DO (
            IF NOT EXIST "%%d" MKDIR %%d
        )
    )

    ECHO.
    ECHO Generating INI files for nLite addon...
    IF "!hasComCtlUpdate!"=="true" (
        PUSHD ..\ini_maker >NUL
        CALL write_entries_ini.cmd comctl !optionalEntries!
        POPD >NUL
    ) >entries_!COMCTL_UPDATE_ID!.ini
    IF "!hasGdiPlusUpdate!"=="true" (
        PUSHD ..\ini_maker >NUL
        CALL write_entries_ini.cmd gdiplus !optionalEntries!
        POPD >NUL
    ) >entries_!GDIPLUS_UPDATE_ID!.ini
    IF "!hasWinHttpUpdate!"=="true" (
        PUSHD ..\ini_maker >NUL
        CALL write_entries_ini.cmd winhttp !optionalEntries!
        POPD >NUL
    ) >entries_!WINHTTP_UPDATE_ID!.ini

    ECHO.
    ECHO Moving files...
    IF "!hasComCtlUpdate!"=="true" (
        SET midPath=msft\windows\common\controls
        MOVE SP2QFE\asms\582\!midPath!\comctl32.dll            WinSxS\!COMCTL5_MSFT_X64!\comctl32.dll
        MOVE SP2QFE\asms\582\!midPath!\controls.cat            WinSxS\manifests\!COMCTL5_MSFT_X64!.cat
        MOVE SP2QFE\asms\582\!midPath!\controls.man            WinSxS\manifests\!COMCTL5_MSFT_X64!.manifest
        MOVE SP2QFE\asms\60\!midPath!\comctl32.dll             WinSxS\!COMCTL6_MSFT_X64!\comctl32.dll
        MOVE SP2QFE\asms\60\!midPath!\controls.cat             WinSxS\manifests\!COMCTL6_MSFT_X64!.cat
        MOVE SP2QFE\asms\60\!midPath!\controls.man             WinSxS\manifests\!COMCTL6_MSFT_X64!.manifest
        MOVE SP2QFE\asms\x86\582\!midPath!\comctl32.dll        WinSxS\!COMCTL5_MSFT_X86!\comctl32.dll
        MOVE SP2QFE\asms\x86\582\!midPath!\controls.cat        WinSxS\manifests\!COMCTL5_MSFT_X86!.cat
        MOVE SP2QFE\asms\x86\582\!midPath!\controls.man        WinSxS\manifests\!COMCTL5_MSFT_X86!.manifest
        MOVE SP2QFE\asms\x86\60\!midPath!\comctl32.dll         WinSxS\!COMCTL6_MSFT_X86!\comctl32.dll
        MOVE SP2QFE\asms\x86\60\!midPath!\controls.cat         WinSxS\manifests\!COMCTL6_MSFT_X86!.cat
        MOVE SP2QFE\asms\x86\60\!midPath!\controls.man         WinSxS\manifests\!COMCTL6_MSFT_X86!.manifest
        COPY SP2QFE\asms\582\policy\!midPath!\controls.man     WinSxS\setuppolicies\!COMCTL5_POLICY_X64!\!COMCTL5_VERSION!.policy
        COPY SP2QFE\asms\60\policy\!midPath!\controls.man      WinSxS\setuppolicies\!COMCTL6_POLICY_X64!\!COMCTL6_VERSION!.policy
        COPY SP2QFE\asms\x86\582\policy\!midPath!\controls.man WinSxS\setuppolicies\!COMCTL5_POLICY_X86!\!COMCTL5_VERSION!.policy
        COPY SP2QFE\asms\x86\60\policy\!midPath!\controls.man  WinSxS\setuppolicies\!COMCTL6_POLICY_X86!\!COMCTL6_VERSION!.policy
        MOVE SP2QFE\asms\582\policy\!midPath!\controls.cat     WinSxS\policies\!COMCTL5_POLICY_X64!\!COMCTL5_VERSION!.cat
        MOVE SP2QFE\asms\582\policy\!midPath!\controls.man     WinSxS\policies\!COMCTL5_POLICY_X64!\!COMCTL5_VERSION!.policy
        MOVE SP2QFE\asms\60\policy\!midPath!\controls.cat      WinSxS\policies\!COMCTL6_POLICY_X64!\!COMCTL6_VERSION!.cat
        MOVE SP2QFE\asms\60\policy\!midPath!\controls.man      WinSxS\policies\!COMCTL6_POLICY_X64!\!COMCTL6_VERSION!.policy
        MOVE SP2QFE\asms\x86\582\policy\!midPath!\controls.cat WinSxS\policies\!COMCTL5_POLICY_X86!\!COMCTL5_VERSION!.cat
        MOVE SP2QFE\asms\x86\582\policy\!midPath!\controls.man WinSxS\policies\!COMCTL5_POLICY_X86!\!COMCTL5_VERSION!.policy
        MOVE SP2QFE\asms\x86\60\policy\!midPath!\controls.cat  WinSxS\policies\!COMCTL6_POLICY_X86!\!COMCTL6_VERSION!.cat
        MOVE SP2QFE\asms\x86\60\policy\!midPath!\controls.man  WinSxS\policies\!COMCTL6_POLICY_X86!\!COMCTL6_VERSION!.policy
        MOVE SP2QFE\wow\wcomctl32.dll                          addon_!COMCTL_UPDATE_ID!\x64_i386\wcomctl32.dll
        MOVE SP2QFE\comctl32.dll                               addon_!COMCTL_UPDATE_ID!\comctl32.dll
        MOVE update\!COMCTL_UPDATE_ID!.CAT                     addon_!COMCTL_UPDATE_ID!\SVCPACK\!COMCTL_UPDATE_ID!.cat
        MOVE entries_!COMCTL_UPDATE_ID!.ini                    addon_!COMCTL_UPDATE_ID!\entries_!COMCTL_UPDATE_ID!.ini
        SET midPath=
    )
    IF "!hasGdiPlusUpdate!"=="true" (
        SET midPath=msft\windows\gdiplus
        MOVE SP2QFE\asms\10\!midPath!\gdiplus.dll              WinSxS\!GDIPLUS_MSFT_X64!\GdiPlus.dll
        MOVE SP2QFE\asms\10\!midPath!\gdiplus.cat              WinSxS\manifests\!GDIPLUS_MSFT_X64!.cat
        MOVE SP2QFE\asms\10\!midPath!\gdiplus.man              WinSxS\manifests\!GDIPLUS_MSFT_X64!.manifest
        MOVE SP2QFE\asms\x86\10\!midPath!\gdiplus.dll          WinSxS\!GDIPLUS_MSFT_X86!\GdiPlus.dll
        MOVE SP2QFE\asms\x86\10\!midPath!\gdiplus.cat          WinSxS\manifests\!GDIPLUS_MSFT_X86!.cat
        MOVE SP2QFE\asms\x86\10\!midPath!\gdiplus.man          WinSxS\manifests\!GDIPLUS_MSFT_X86!.manifest
        COPY SP2QFE\asms\10\policy\!midPath!\gdiplus.man       WinSxS\setuppolicies\!GDIPLUS_POLICY_X64!\!GDIPLUS_VERSION!.policy
        COPY SP2QFE\asms\x86\10\policy\!midPath!\gdiplus.man   WinSxS\setuppolicies\!GDIPLUS_POLICY_X86!\!GDIPLUS_VERSION!.policy
        MOVE SP2QFE\asms\10\policy\!midPath!\gdiplus.cat       WinSxS\policies\!GDIPLUS_POLICY_X64!\!GDIPLUS_VERSION!.cat
        MOVE SP2QFE\asms\10\policy\!midPath!\gdiplus.man       WinSxS\policies\!GDIPLUS_POLICY_X64!\!GDIPLUS_VERSION!.policy
        MOVE SP2QFE\asms\x86\10\policy\!midPath!\gdiplus.cat   WinSxS\policies\!GDIPLUS_POLICY_X86!\!GDIPLUS_VERSION!.cat
        MOVE SP2QFE\asms\x86\10\policy\!midPath!\gdiplus.man   WinSxS\policies\!GDIPLUS_POLICY_X86!\!GDIPLUS_VERSION!.policy
        MOVE update\!GDIPLUS_UPDATE_ID!.CAT                    addon_!GDIPLUS_UPDATE_ID!\SVCPACK\!GDIPLUS_UPDATE_ID!.cat
        MOVE entries_!GDIPLUS_UPDATE_ID!.ini                   addon_!GDIPLUS_UPDATE_ID!\entries_!GDIPLUS_UPDATE_ID!.ini
        SET midPath=
    )
    IF "!hasWinHttpUpdate!"=="true" (
        SET midPath=msft\windows\winhttp
        MOVE SP2QFE\asms\51\!midPath!\winhttp.dll              WinSxS\!WINHTTP_MSFT_X64!\winhttp.dll
        MOVE SP2QFE\asms\51\!midPath!\winhttp.cat              WinSxS\manifests\!WINHTTP_MSFT_X64!.cat
        MOVE SP2QFE\asms\51\!midPath!\winhttp.man              WinSxS\manifests\!WINHTTP_MSFT_X64!.manifest
        MOVE SP2QFE\asms\x86\51\!midPath!\winhttp.dll          WinSxS\!WINHTTP_MSFT_X86!\winhttp.dll
        MOVE SP2QFE\asms\x86\51\!midPath!\winhttp.cat          WinSxS\manifests\!WINHTTP_MSFT_X86!.cat
        MOVE SP2QFE\asms\x86\51\!midPath!\winhttp.man          WinSxS\manifests\!WINHTTP_MSFT_X86!.manifest
        COPY SP2QFE\asms\51\policy\!midPath!\winhttp.man       WinSxS\setuppolicies\!WINHTTP_POLICY_X64!\!WINHTTP_VERSION!.policy
        COPY SP2QFE\asms\x86\51\policy\!midPath!\winhttp.man   WinSxS\setuppolicies\!WINHTTP_POLICY_X86!\!WINHTTP_VERSION!.policy
        MOVE SP2QFE\asms\51\policy\!midPath!\winhttp.cat       WinSxS\policies\!WINHTTP_POLICY_X64!\!WINHTTP_VERSION!.cat
        MOVE SP2QFE\asms\51\policy\!midPath!\winhttp.man       WinSxS\policies\!WINHTTP_POLICY_X64!\!WINHTTP_VERSION!.policy
        MOVE SP2QFE\asms\x86\51\policy\!midPath!\winhttp.cat   WinSxS\policies\!WINHTTP_POLICY_X86!\!WINHTTP_VERSION!.cat
        MOVE SP2QFE\asms\x86\51\policy\!midPath!\winhttp.man   WinSxS\policies\!WINHTTP_POLICY_X86!\!WINHTTP_VERSION!.policy
        MOVE update\!WINHTTP_UPDATE_ID!.CAT                    addon_!WINHTTP_UPDATE_ID!\SVCPACK\!WINHTTP_UPDATE_ID!.cat
        MOVE entries_!WINHTTP_UPDATE_ID!.ini                   addon_!WINHTTP_UPDATE_ID!\entries_!WINHTTP_UPDATE_ID!.ini
        SET midPath=
    )

    ECHO.
    ECHO Generating file lists...
    TYPE ..\filelists\!LANG!\asms01.txt >asms01.list

    IF "!hasComCtlUpdate!"=="true" (
        IF "!keepOldFiles!"=="YES" (
            TYPE ..\filelists\comctl.txt
        )>>asms01.list
        (
            ECHO !COMCTL5_MSFT_X64!\comctl32.dll
            ECHO manifests\!COMCTL5_MSFT_X64!.cat
            ECHO manifests\!COMCTL5_MSFT_X64!.manifest
            ECHO !COMCTL6_MSFT_X64!\comctl32.dll
            ECHO manifests\!COMCTL6_MSFT_X64!.cat
            ECHO manifests\!COMCTL6_MSFT_X64!.manifest
            ECHO !COMCTL5_MSFT_X86!\comctl32.dll
            ECHO manifests\!COMCTL5_MSFT_X86!.cat
            ECHO manifests\!COMCTL5_MSFT_X86!.manifest
            ECHO !COMCTL6_MSFT_X86!\comctl32.dll
            ECHO manifests\!COMCTL6_MSFT_X86!.cat
            ECHO manifests\!COMCTL6_MSFT_X86!.manifest
            ECHO setuppolicies\!COMCTL5_POLICY_X64!\!COMCTL5_VERSION!.policy
            ECHO setuppolicies\!COMCTL6_POLICY_X64!\!COMCTL6_VERSION!.policy
            ECHO setuppolicies\!COMCTL5_POLICY_X86!\!COMCTL5_VERSION!.policy
            ECHO setuppolicies\!COMCTL6_POLICY_X86!\!COMCTL6_VERSION!.policy
            ECHO policies\!COMCTL5_POLICY_X64!\!COMCTL5_VERSION!.cat
            ECHO policies\!COMCTL5_POLICY_X64!\!COMCTL5_VERSION!.policy
            ECHO policies\!COMCTL6_POLICY_X64!\!COMCTL6_VERSION!.cat
            ECHO policies\!COMCTL6_POLICY_X64!\!COMCTL6_VERSION!.policy
            ECHO policies\!COMCTL5_POLICY_X86!\!COMCTL5_VERSION!.cat
            ECHO policies\!COMCTL5_POLICY_X86!\!COMCTL5_VERSION!.policy
            ECHO policies\!COMCTL6_POLICY_X86!\!COMCTL6_VERSION!.cat
            ECHO policies\!COMCTL6_POLICY_X86!\!COMCTL6_VERSION!.policy
        )>>asms01.list
        (
            ECHO x64_i386\wcomctl32.dll
            ECHO comctl32.dll
            ECHO SVCPACK\!COMCTL_UPDATE_ID!.cat
            ECHO entries_!COMCTL_UPDATE_ID!.ini
        )>addon_!COMCTL_UPDATE_ID!.list
    ) ELSE (
        TYPE ..\filelists\comctl.txt >>asms01.list
    )
    IF "!hasGdiPlusUpdate!"=="true" (
        IF "!keepOldFiles!"=="YES" (
            TYPE ..\filelists\gdiplus.txt
        )>>asms01.list
        (
            ECHO !GDIPLUS_MSFT_X64!\GdiPlus.dll
            ECHO manifests\!GDIPLUS_MSFT_X64!.cat
            ECHO manifests\!GDIPLUS_MSFT_X64!.manifest
            ECHO !GDIPLUS_MSFT_X86!\GdiPlus.dll
            ECHO manifests\!GDIPLUS_MSFT_X86!.cat
            ECHO manifests\!GDIPLUS_MSFT_X86!.manifest
            ECHO setuppolicies\!GDIPLUS_POLICY_X64!\!GDIPLUS_VERSION!.policy
            ECHO setuppolicies\!GDIPLUS_POLICY_X86!\!GDIPLUS_VERSION!.policy
            ECHO policies\!GDIPLUS_POLICY_X64!\!GDIPLUS_VERSION!.cat
            ECHO policies\!GDIPLUS_POLICY_X64!\!GDIPLUS_VERSION!.policy
            ECHO policies\!GDIPLUS_POLICY_X86!\!GDIPLUS_VERSION!.cat
            ECHO policies\!GDIPLUS_POLICY_X86!\!GDIPLUS_VERSION!.policy
        )>>asms01.list
        (
            ECHO SVCPACK\!GDIPLUS_UPDATE_ID!.cat
            ECHO entries_!GDIPLUS_UPDATE_ID!.ini
        )>addon_!GDIPLUS_UPDATE_ID!.list
    ) ELSE (
        TYPE ..\filelists\gdiplus.txt >>asms01.list
    )
    IF "!hasWinHttpUpdate!"=="true" (
        IF "!keepOldFiles!"=="YES" (
            TYPE ..\filelists\winhttp.txt
        )>>asms01.list
        (
            ECHO !WINHTTP_MSFT_X64!\winhttp.dll
            ECHO manifests\!WINHTTP_MSFT_X64!.cat
            ECHO manifests\!WINHTTP_MSFT_X64!.manifest
            ECHO !WINHTTP_MSFT_X86!\winhttp.dll
            ECHO manifests\!WINHTTP_MSFT_X86!.cat
            ECHO manifests\!WINHTTP_MSFT_X86!.manifest
            ECHO setuppolicies\!WINHTTP_POLICY_X64!\!WINHTTP_VERSION!.policy
            ECHO setuppolicies\!WINHTTP_POLICY_X86!\!WINHTTP_VERSION!.policy
            ECHO policies\!WINHTTP_POLICY_X64!\!WINHTTP_VERSION!.cat
            ECHO policies\!WINHTTP_POLICY_X64!\!WINHTTP_VERSION!.policy
            ECHO policies\!WINHTTP_POLICY_X86!\!WINHTTP_VERSION!.cat
            ECHO policies\!WINHTTP_POLICY_X86!\!WINHTTP_VERSION!.policy
        )>>asms01.list
        (
            ECHO SVCPACK\!WINHTTP_UPDATE_ID!.cat
            ECHO entries_!WINHTTP_UPDATE_ID!.ini
        )>addon_!WINHTTP_UPDATE_ID!.list
    ) ELSE (
        TYPE ..\filelists\winhttp.txt >>asms01.list
    )
    REM Sort the file list before making ASMS01.CAB.
    sort asms01.list /O temp.list
    MOVE /Y temp.list asms01.list

    ECHO.
    ECHO Making cabinets...
    (
        CD WinSxS
        CALL :stripMissingFiles ..\asms01.list ..\temp.list ..\missing.list
        MOVE /Y ..\temp.list ..\asms01.list
        IF EXIST "..\missing.list" (
            CALL :missingFilesWarning ..\missing.list ASMS01.CAB
            CALL :missingFilesWarning ..\missing.list ASMS01.CAB >>..\warnings.txt
        )

        REM The compression method of ASMS01.CAB is MSZip, not LZX.
        ..\..\cabarc -p -m MSZip N ..\..\ASMS01_new.cab @..\asms01.list
        CD ..
    )
    IF "!hasComCtlUpdate!"=="true" (
        CALL :makeAddonCab addon_!COMCTL_UPDATE_ID!
    )
    IF "!hasGdiPlusUpdate!"=="true" (
        CALL :makeAddonCab addon_!GDIPLUS_UPDATE_ID!
    )
    IF "!hasWinHttpUpdate!"=="true" (
        CALL :makeAddonCab addon_!WINHTTP_UPDATE_ID!
    )

    REM The processes below are no longer in work_dir.
    CD ..

GOTO finished

:finished
    CLS
    IF EXIST "work_dir\warnings.txt" (
        ECHO.
        ECHO There are warnings during the process.
        ECHO.
        TYPE "work_dir\warnings.txt"
    )
    ECHO.
    ECHO Cleaning up...
    RMDIR /s /q work_dir

    ECHO.
    ECHO All done.
    ECHO.
    ECHO Here's what you should do next:
    ECHO 1. Replace the "AMD64\ASMS01.CAB" located in your !OS_STRING_NLITE!
    ECHO    disc with the new "ASMS01_new.cab". (Rename to ASMS01.CAB when needed.)
    ECHO 2. Open nLite, and integrate these addons:
    IF "!hasComCtlUpdate!"=="true" (
        ECHO    - addon_!COMCTL_UPDATE_ID!.cab
    )
    IF "!hasGdiPlusUpdate!"=="true" (
        ECHO    - addon_!GDIPLUS_UPDATE_ID!.cab
    )
    IF "!hasWinHttpUpdate!"=="true" (
        ECHO    - addon_!WINHTTP_UPDATE_ID!.cab
    )
    ECHO 3. Enjoy your slipstreamed disc.
    ECHO.
    ECHO Press any key to close this window.
    PAUSE>NUL
GOTO end

:error
    ECHO An error occurred. Aborting.
    PAUSE
GOTO end

:end
    ENDLOCAL
GOTO :EOF

REM /**
REM  * Strip the missing file name in the file list.
REM  *
REM  * Detect if every file in the list specified in %1 exists and output the
REM  * list of files that exist and the list that don't.
REM  * @param %1 Original list file.
REM  * @param %2 Output list with only file names that exist.
REM  * @param %3 Output list with file names that are missing.
REM  */
:stripMissingFiles
    DEL %2
    DEL %3
    FOR /F "delims=" %%f IN (%1) DO (
        IF EXIST "%%f" (
            ECHO>>%2 %%f
        ) ELSE (
            ECHO>>%3 %%f
        )
    )
GOTO :EOF

REM /**
REM  * Displays warning messages about missing files when making cabinets.
REM  * @param %1 List of files that are missing.
REM  * @param %2 In which cabinet file.
REM  */
:missingFilesWarning
    ECHO WARNING: The following files do not exist in %2:
    TYPE %1
    ECHO.
GOTO :EOF

REM /**
REM  * Create addon cabinet for nLite.
REM  *
REM  * This function is called when current directory is "work_dir".
REM  * Create a cabinet named "..\NAME.cab", with the files located in
REM  * "NAME" directory and whose names are listed in "work_dir\NAME.list".
REM  * Temporary files used by this function: temp.list missing.list
REM  * @param %1 Name of the addon cabinet file.
REM  */
:makeAddonCab
    CD %1
    CALL :stripMissingFiles ..\%1.list ..\temp.list ..\missing.list
    MOVE /Y ..\temp.list ..\%1.list
    IF EXIST "..\missing.list" (
        CALL :missingFilesWarning ..\missing.list %1.cab
        CALL :missingFilesWarning ..\missing.list %1.cab >>..\warnings.txt
    )
    ..\..\cabarc -p -m MSZip N ..\..\%1.cab @..\%1.list
    CD ..
GOTO :EOF
