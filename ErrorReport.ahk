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

gui 34: default

ErrorURL=http://www.software.qweex.com/error_report.php

Gui, +toolwindow
gui, font, w800
gui, add, progress, x-5 y-10 h65 w510 BackgroundWhite
gui, add, groupbox, x-5 y-10 h65 w510 -Background
gui, add, text, x23 y14 w430 BackgroundTrans, You chose to send a report thing or something........I guess. We are sorry for the inconvenience.
gui, font
gui, add, text, x23 y68 w430, Don't be deceived, I actually do give a crap about bugs in this program.
gui, font, w800
gui, add, text, x23 yp+20 w430, Please tell Qweex about this problem.
gui, font
gui, add, text, x23 yp+20 w430, Below you can select what browsers you had problems with and we will look into it. Your report is entirely anonymous but muchly appreciated.

gui, add, listview, grid checked x23 yp+40 w430 -hdr r3, 1|2
LV_ModifyCol(1,430-30)
LV_ModifyCol(2,0)


gui, add, button, x7 y220, De&bug
gui, add, button, x390 yp gFileReport, &Send Error Report

ErrorReport:
if(A_ThisLabel="ErrorReport")
{
	gui 34: show, w500 h250, Error Report
	return
}

FileReport:
if(A_ThisLabel="FileReport")
{
	gosub GetErrorString
	if(ErrorString)
	{
		msgbox, %errorURL%?id=%About_Name%&v=%About_Version%&err=%ErrorString%
		URLDownloadToFile, %errorURL%?id=%About_Name%&v=%About_Version%&err=%ErrorString%, %A_Temp%\%About_Name%_Err.tmp
		FileRead, TmpVar, %A_Temp%\%About_Name%_Err.tmp
		if(TmpVar=1)
			msgbox,,Thank you!, Your report has been submitted! Thanks so much and I will do my best to get right on it!
		else
			msgbox,,Uh oh!, There was a problem submitting your error report. That's ironic, isn't it?
	}
	gui 34: hide
	return
}