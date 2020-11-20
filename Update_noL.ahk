/*
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	~~~~~~~~~~~~~~~~~~~~~~dIE v1.1~~~~~~~~~~~~~~~~~~~~~~~~
	~~~~~~~~~~~~~~~~Copyright Qweex 2012~~~~~~~~~~~~~~~~~~
	~~~Distributed under the GNU General Public License~~~
	~~~~~~~~~~~~~~~~~http://www.qweex.com~~~~~~~~~~~~~~~~~
	~~~~~~~~~~~~~~~~~~~MrQweex@qweex.com~~~~~~~~~~~~~~~~~~
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
	This file is a part of dIE.
	
	dIE is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    dIE is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with StartupSaver.  If not, see <http://www.gnu.org/licenses/>.
*/

UpdateURL=http://software.qweex.com/update.php

Update:
	if(A_ThisLabel=="Update")
	{
		URLDownloadToFile, %UpdateURL%?id=%About_Name%&v=%About_Version%, %A_Temp%\%About_Name%_Update.tmp
		if(ErrorLevel)
		{
			msgbox, 16, Error, Could not contact update server
			return
		}
		FileRead, TempVar, %A_Temp%\%About_Name%_Update.tmp
		if(TempVar=0)
		{
			msgbox,, Up to date,You are running the latest version of %About_Name%!
			return
		}
		msgbox,4,An update is available, There is a new version of %About_Name%!`n`nYour version:`t%About_Version%`nNew version:`t%TempVar%`n`nDownload it now?
		ifmsgbox, yes
			run, %ProjectURL%
		return
	}