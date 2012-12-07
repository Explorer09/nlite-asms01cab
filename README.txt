Update_asms01_cab.cmd
The ASMS01.CAB slipstreamer for nLite'd Windows XP/2003 x64.

== How to Start ==

1. Open "global_vars\set_global_vars.cmd" in Notepad.
2. Edit these two lines and set the target operating system and its language:
     SET LANG=NOT_SET_YET
     SET OS_TAG=NOT_SET_YET
3. Save the file.
4. Find and copy these files from your Windows disc, or download them from
   the Internet:
   - ASMS01.cab (Must be SP2 version)
   - cabarc.exe (You can get this from Windows XP Support Tools, or just
                 Google it.)
   - WindowsServer2003.WindowsXP-KB2296011-x64-ENU.exe
   - WindowsServer2003.WindowsXP-KB2638806-x64-ENU.exe
   - WindowsServer2003.WindowsXP-KB2659262-x64-ENU.exe
5. Run update_asms01_cab.cmd. The script will tell you what to do next.

== About ==

Update_asms01_cab.cmd is a tool that can help you directly integrate the
three updates (KB2296011, KB2638806, and KB2659262) into the Windows XP/2003
x64 installaion disc. This tool is designed to be used with nLite. It simply
does what nLite fails to do, which is to integrate these updates.

Update_asms01_cab.cmd is written as a solution to this bug report:
http://www.msfn.org/board/topic/156867-files-in-asms-folder-are-not-integrated-by-nlite-winxp-x64/

== License ==

Copyright (C) 2012 Kang-Che "Explorer" Sung <explorer09 @ gmail.com>

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

Please see the file COPYING.txt for the license terms and conditions.
