/*
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	~~~~~~~~~~~~~~~~~~~~~~dIE v1.0b~~~~~~~~~~~~~~~~~~~~~~~
	~~~~~~~~~~~~~~Copyright Qweex 2012-2015~~~~~~~~~~~~~~~
	~~~Distributed under the GNU General Public License~~~
	~~~~~~~~~~~~~~~~~http://www.qweex.com~~~~~~~~~~~~~~~~~
	~~~~~~~~~~~~~~~~~~~~~jon@qweex.com~~~~~~~~~~~~~~~~~~~~
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
#notrayicon
Win_W = 580
Win_H = 400
Pic_DIM=128
IE_Version = ∞
Win_Title = Windows Internet Explorer %IE_Version%
LV_W = 358
LV_H = 128
Dl_W = 116

BrowserList = Mozilla Firefox|Google Chrome|Opera|Safari|Chromium|Lunascape|Maxthon|Avant|RockMeIt|Pale Moon|Qupzilla x32|Qupzilla x64|SWare Iron|Arora|Midori|Conquerer|K-Meleon|Ghostzilla|Mozilla Firefox Aurora|Mozilla Firefox Beta|Mozilla Firefox Nightly x32|Mozilla Firefox Nightly x64|Google Chrome Beta|Google Chrome Canary

Gui, -MinimizeBox -MaximizeBox +OwnDialogs
Gui, color, white
FileInstall, IE.png, %A_Temp%\IE.png
Gui, add, picture, x20 y20 w%Pic_DIM% h%Pic_DIM%, %A_Temp%\IE.png
Gui, font, s10, Tahoma
Gui, add, text,% "xp+" . Pic_DIM+20 . " yp+" . Pic_DIM/4, Welcome to the
Gui, font, s30 c65b9ec
Gui, add, text, xp yp+20, Internet Explorer %IE_Version%
Gui, font
Gui, font, s10
Gui, add, text, xp yp+90, Which browser do you want to download?
Gui, add, Listview, -hdr +Checked xp yp+25 w%LV_W% h%LV_H%,1|
Gui, add, Button,% "vDL xp+" . (LV_W-Dl_W) . " yp+" . (LV_H+15) . " w" . Dl_w, Download
LV_ModifyCol(1,LV_W-30)
LV_ModifyCol(2,0)

gui, show, w%Win_W% h%Win_H%, %Win_Title%
Loop, Parse, BrowserList, |
	LV_Add("",A_LoopField)
Gui, Add, StatusBar, Hidden vDownloadStatus
SB_SetParts(Win_W/2)
return

;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!END OF AUTOEXECUTION!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

guiclose:
if(Downloading)
{
	msgbox, 4, Quit?, You are in the middle of downloading some setup files. Are you sure you'd like to quit?
	ifmsgbox, no
		return
}
exitapp

ButtonDownload:
	if(LV_GetNext(0, "Checked")==0)
		return
	Guicontrol, +disabled, DL
	GuiControl, Show, DownloadStatus
	prevID=0
	Downloading=1
	Loop
	{
		prevID:=LV_GetNext(prevID, "Checked")
		if(prevID=0)
			break
		LV_GetText(TempVar, prevID)
		_TempVar:="_" . RemoveSpaces(TempVar)
		SB_SetText("Preparing to download " . TempVar,1)
		SB_SetText("",2)
		gosub, %_TempVar%
	}
	Downloading=0
	GuiControl, Hide, DownloadStatus
	Guicontrol, -disabled, DL
	Msgbox,,Finished Downloading, All downloads are complete!
	Run, %A_WorkingDir%\setup
return


;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Browser Download labels~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

_MozillaFirefox:
	URLDownloadToFile, http://releases.mozilla.org/pub/mozilla.org/firefox/releases/latest/win32/en-US, Temp.html
	FileRead, TempVar, Temp.html
	FileDelete, Temp.html
	StringReplace, TempVar, TempVar, Firefox Setup, ``
	StringReplace, TempVar, TempVar, .exe, ``, all
	StringSplit, array, Tempvar,``
	MozillaFirefox_v=%array3%
	Download("http://releases.mozilla.org/pub/mozilla.org/firefox/releases/latest/win32/en-US/Firefox Setup " . MozillaFirefox_v . ".exe", "setup/Firefox Setup " . MozillaFirefox_v . ".exe", "Mozilla Firefox")
	;UrlDownloadToFile, http://releases.mozilla.org/pub/mozilla.org/firefox/releases/latest/win32/en-US/Firefox Setup %MozillaFirefox_v%.exe, setup/Firefox Setup %MozillaFirefox_v%.exe
return

_GoogleChrome:
	FileInstall, setup/ChromeSetup.exe, setup/ChromeSetup.exe,1
	;msgbox, Extracted Google Chrome
return

_Opera:
	URLDownloadToFile, http://www.opera.com/download/, Temp.html
	FileRead, TempVar, Temp.html
	FileDelete, Temp.html
	StringReplace, TempVar, TempVar, <p class="download">, ``
	StringSplit, array, TempVar, ``
	TempVar:=array2
	StringReplace, TempVar, TempVar, </p>, ``
	StringSplit, array, TempVar, ``
	TempVar:=array1
	StringSplit, array, TempVar, "
	StringReplace, TempVar, array2, &amp;, &, all
	URLDownloadToFile, http://www.opera.com%TempVar%, Temp.html
	FileRead, TempVar, Temp.html
	FileDelete, Temp.html
	StringReplace, TempVar, TempVar, click here, ``
	StringReplace, TempVar, Tempvar, does not start automatically, ``
	StringSplit, array, TempVar, ``
	StringSplit, array, array2, "
	StringReplace, Opera_a, array2, &amp;, &, all
	Opera_a=http://www.opera.com%Opera_a%
	Download(Opera_a, "setup/OperaSetup.exe", "Opera")
	;UrlDownloadToFile, %Opera_a%, setup/OperaSetup.exe
	;msgbox, Downloaded Opera
return

_Safari:
	URLDownloadToFile, http://www.filehippo.com/download_safari/, Temp.html
	FileRead, TempVar, Temp.html
	FileDelete, Temp.html
	StringReplace, TempVar, TempVar, Latest Version, ``
	StringReplace, TempVar, TempVar, <div id="dlbox">, ``
	StringSplit, array, TempVar, ``
	StringSplit, array, array2, "
	URLDownloadToFile, http://www.filehippo.com/download_safari%array2%, Temp.html
	FileRead, TempVar, Temp.html
	FileDelete, Temp.html
	StringReplace, TempVar, TempVar, /">If not then please click this link, ``
	StringSplit, array, TempVar,``
	TempVar:=array1
	StringSplit, array, TempVar, "
	TempVar:=array%array0%
	Safari_a=http://www.filehippo.com%tempvar%
	Download(Safari_a, "setup/SafariSetup.exe", "Safari")
	;URLDownloadToFile, %Safari_a%, setup/SafariSetup.exe
	;msgbox, Downloaded Safari
return

_Chromium:
	URLDownloadToFile, http://build.chromium.org/f/chromium/snapshots.old/Win_Webkit_Latest/LATEST, Temp.html
	FileRead, TempVar, Temp.html
	FileDelete, Temp.html
	Download("http://build.chromium.org/f/chromium/snapshots.old/Win_Webkit_Latest/" . TempVar . "/mini_installer.exe", "setup/Chromium_mini_installer.exe", "Chromium")
	;URLDownloadToFile, http://build.chromium.org/f/chromium/snapshots.old/Win_Webkit_Latest/%TempVar%/mini_installer.exe, setup/Chromium_mini_installer.exe
	;msgbox, Downloaded Chromium
return

_Lunascape:
	URLDownloadToFile, http://www.lunascape.tv/Products/tabid/111/Default.aspx, Temp.html
	FileRead, TempVar, Temp.html
	FileDelete, Temp.html
	StringReplace, TempVar, TempVar, English (US), ``
	StringReplace, TempVar, TempVar, Download</a>, ``
	StringSplit, array, tempvar, ``
	TempVar:=array2
	Stringreplace, TempVar, Tempvar, <a href=", ``
	StringSplit, array, TempVar, ``
	TempVar:=array2
	StringSplit, array, TempVar, "
	Lunascape_a:=array1
	Download(Lunascape_a, "setup/Lunascape.exe", "Lunascape")
	;URLDownloadToFile, %Lunascape_a%, setup/Lunascape.exe
	;msgbox, Downloaded Lunascape
return


_Maxthon:
	UrlDownloadToFile, http://dl.maxthon.com/mx3/, Temp.html
	FileRead, TempVar, Temp.html
	FileDelete, Temp.html
	StringSplit, array, TempVar, `n
	i:=array0
	loop, %array0%
	{
		if(!InStr(array%i%,".exe") || InStr(array%i%,"beta"))
		{
			i--
			continue
		}
		TempVar:=array%i%
		break
	}
	StringSplit, array, TempVar, "
	Maxthon_f:=array2
	Download("http://dl.maxthon.com/mx3/" . Maxthon_f, "setup/" . Maxthon_f, "Maxthon")
	;UrlDownloadToFile, http://dl.maxthon.com/mx3/%Maxthon_f%, setup/%Maxthon_f%
	;msgbox, Downloaded Maxthon
return

_Avant:
	Download("http://www.avantbrowser.cn/release/absetup.exe", "setup/absetup.exe", "Avant")
	;URLDownloadToFile, http://www.avantbrowser.cn/release/absetup.exe, setup/absetup.exe
	;msgbox, Downloaded Avant
return

_RockMeIt:
	FileInstall, setup/RockMeltSetup.exe, setup/RockMeltSetup.exe,1
	msgbox, Extracted RockMeIt
return

_Qupzillax32:
	Download("http://www.qupzilla.com/down.php?version=windows32", "setup/qupzilla_x32setup.exe", "Qupzilla x32")
return

_Qupzillax64:
	Download("http://www.qupzilla.com/down.php?version=windows64", "setup/qupzilla_x64setup.exe", "Qupzilla x64")
return

_PaleMoon:
	Download("http://storage.sity.nl/palemoon/palemoon-websetup.exe", "setup/palemoon-websetup.exe", "Pale Moon")
	;URLDownloadToFile, http://storage.sity.nl/palemoon/palemoon-websetup.exe, setup/palemoon-websetup.exe
	;msgbox, Downloaded Pale Moon
return

_SWareIron:
	Download("http://www.srware.net/downloads/srware_iron.exe", "setup/srware_iron.exe", "SWare Iron")
	;URLDownloadToFile, http://www.srware.net/downloads/srware_iron.exe, setup/srware_iron.exe
	;msgbox, Downloaded SWare Iron
return

_Arora:
	URLDownloadToFile, http://code.google.com/p/arora/, Temp.html
	FileRead, TempVar, Temp.html
	FileDelete, Temp.html
	StringReplace, TempVar, TempVar, OpSys-Windows, ``, All
	StringReplace, TempVar, Tempvar, title=, ``, All
	StringSplit, array, TempVar, ``
	StringSplit, array, array2, "
	StringReplace, array4, array4, `%20, %A_Space%, All
	Arora_a=http:%array4%
	StringSplit, array, array4, /
	Arora_f:=Array%array0%
	Download(Arora_a, "setup/" . Arora_f, "Arora")
	;URLDownloadToFile, %Arora_a%, setup/%Arora_f%
	;msgbox, Downloaded Arora
return

_Midori:
	URLDownloadToFile, http://www.twotoasts.de/index.php?/pages/midori_summary.html, Temp.html
	FileRead, TempVar, Temp.html
	FileDelete, Temp.html
	StringReplace, tempvar, tempvar, Win32 Archive, ``
	StringSplit, array, tempvar, ``
	TempVar:=array1
	StringReplace, tempvar, tempvar, <p>, ``, All
	StringSplit, array, tempvar, ``
	TempVar:=array%array0%
	StringReplace, tempvar, tempvar, #, "
	StringSplit, array, TempVar, "
	Midori_a:=array2
	StringSplit, array, Midori_a, /
	i:=array0
	Midori_f:=array%i%
	Download(Midori_a, "setup/" . Midori_f, "Midori")
	;URLDownloadToFile, %Midori_a%, setup/%Midori_f%
	;msgbox, Downloaded Midori
return


_K-Meleon:
	Download("http://sourceforge.net/projects/kmeleon/files/k-meleon/1.5.4/K-Meleon1.5.4en-US.exe/download", "setup/K-Meleon1.5.4en-US.exe", "K-Meleon")
	;URLDownloadToFile, http://sourceforge.net/projects/kmeleon/files/k-meleon/1.5.4/K-Meleon1.5.4en-US.exe/download, setup/K-Meleon1.5.4en-US.exe
	;msgbox, Downloaded K-Meleon
return

_Conquerer:
	URLDownloadToFile, http://sourceforge.net/api/file/index/project-id/378893/mtime/desc/limit/20/rss, Temp.html
	FileRead, TempVar, Temp.html
	FileDelete, Temp.html
	StringReplace, tempvar, Tempvar, <link>, ``, ALL
	StringReplace, tempvar, Tempvar, </link>, ``, ALL
	i=2
	StringSplit, array, TempVar, ``
	loop,
	{
		if(!(InStr(array%i%,".exe") || InStr(array%i%,".zip"))) ; || InStr(array%i%, "/Source")
		{
			i+=2
			continue
		}
		break
	}
	Conquerer_a:=array%i%
	StringReplace, Conquerer_a, Conquerer_a, `%20, %A_Space%, ALL
	StringSplit, array, Conquerer_a, /
	i:=array0-1
	Conquerer_f:=array%i%
	Download(Conquerer_a, "setup/" . Conquerer_f, "Conquerer")
	;URLDownloadToFile, %Conquerer_a%, setup/%Conquerer_f%
	;msgbox, Downloaded Conquerer
return

_Ghostzilla:
	Download("http://www.portablefreeware.com/download.php?id=681", "setup/ghostzilla.zip", "GhostZilla")
	;URLDownloadToFile, http://www.portablefreeware.com/download.php?id=681, setup/ghostzilla.zip
	;msgbox, Downloaded Ghostzilla
return


_MozillaFirefoxNightlyx32:
	URLDownloadToFile, http://ftp.mozilla.org/pub/mozilla.org/firefox/nightly/latest-trunk/, Temp.html
	FileRead, TempVar, Temp.html
	FileDelete, Temp.html
	StringReplace, Tempvar, Tempvar, win32.installer.exe">, ``, ALL
	stringsplit, array, tempvar, ``
	TempVar:=array%array0%
	StringReplace, TempVar, TempVar, </a>, ``, ALL
	StringSplit, array, Tempvar, ``
	MozillaFirefoxNightlyx32_f:=array1
	Download("http://ftp.mozilla.org/pub/mozilla.org/firefox/nightly/latest-trunk/" . MozillaFirefoxNightlyx32_f, "setup/" . MozillaFirefoxNightlyx32_f, "Mozilla Firefox Nightly x32")
	;URLDownloadToFile,http://ftp.mozilla.org/pub/mozilla.org/firefox/nightly/latest-trunk/%MozillaFirefoxNightlyx32_f%, setup/%MozillaFirefoxNightlyx32_f%
	;msgbox, Downloaded Nightly x32
return

_MozillaFirefoxNightlyx64:
	URLDownloadToFile, http://ftp.mozilla.org/pub/mozilla.org/firefox/nightly/latest-trunk/, Temp.html
	FileRead, TempVar, Temp.html
	FileDelete, Temp.html
	StringReplace, Tempvar, Tempvar, win64-x86_64.installer.exe">, ``, ALL
	stringsplit, array, tempvar, ``
	TempVar:=array%array0%
	StringReplace, TempVar, TempVar, </a>, ``, ALL
	StringSplit, array, Tempvar, ``
	MozillaFirefoxNightlyx64_f:=array1
	Download("http://ftp.mozilla.org/pub/mozilla.org/firefox/nightly/latest-trunk/" . MozillaFirefoxNightlyx64_f, "setup/" . MozillaFirefoxNightlyx64_f, "Mozilla Firefox Nightly x64")
	;URLDownloadToFile,http://ftp.mozilla.org/pub/mozilla.org/firefox/nightly/latest-trunk/%MozillaFirefoxNightlyx64_f%, setup/%MozillaFirefoxNightlyx64_f%
	;msgbox, Downloaded Nightly x64
return

_MozillaFirefoxBeta:
	URLDownloadToFile, http://pv-mirror01.mozilla.org/pub/mozilla.org/firefox/releases/, Temp.html
	FileRead, TempVar, Temp.html
	FileDelete, Temp.html
	StringSplit, array, TempVar, `n
	i:=array0
	loop, %array0%
	{
		if(!InStr(array%i%,"[DIR]") || InStr(array%i%,"latest"))
		{
			i--
			continue
		}
		TempVar:=array%i%
		break
	}
	StringReplace, tempvar, tempvar, /">, ``
	StringReplace, tempvar, tempvar, /<, ``
	StringSplit, array, TempVar, ``
	MozillaFirefoxNightly_v:=array2
	Download("http://pv-mirror01.mozilla.org/pub/mozilla.org/firefox/releases/" . MozillaFirefoxNightly_v . "/win32/en-US/Firefox Setup " . MozillaFirefoxNightly_v . ".exe", "setup/Firefox Setup " . MozillaFirefoxNightly_v . ".exe", "Mozilla Firefox Nightly")
	;UrlDownloadToFile, http://pv-mirror01.mozilla.org/pub/mozilla.org/firefox/releases/%MozillaFirefoxNightly_v%/win32/en-US/Firefox Setup %MozillaFirefoxNightly_v%.exe, setup/Firefox Setup %MozillaFirefoxNightly_v%.exe
	;msgbox, Downloaded Firefox Nightly
return

_MozillaFirefoxAurora:
	URLDownloadToFile, http://ftp.mozilla.org/pub/mozilla.org/firefox/nightly/latest-mozilla-aurora, Temp.html
	FileRead, TempVar, Temp.html
	FileDelete, Temp.html
	StringReplace, Tempvar, Tempvar, win32.installer.exe">, ``, ALL
	stringsplit, array, tempvar, ``
	TempVar:=array%array0%
	StringReplace, TempVar, TempVar, </a>, ``, ALL
	StringSplit, array, Tempvar, ``
	MozillaFirefoxAurora_f:=array1
	Download("http://ftp.mozilla.org/pub/mozilla.org/firefox/nightly/latest-mozilla-aurora/" . MozillaFirefoxAurora_f, "setup/" . MozillaFirefoxAurora_f, "Mozilla Firefox Aurora")
	;URLDownloadToFile, http://ftp.mozilla.org/pub/mozilla.org/firefox/nightly/latest-mozilla-aurora/%MozillaFirefoxAurora_f%, setup/%MozillaFirefoxAurora_f%
	;msgbox, Downloaded Aurora
return

_GoogleChromeBeta:
	FileInstall, setup/ChromeSetup_Beta.exe, setup/ChromeSetup_Beta.exe,1
	;msgbox, Extracted Google Chrome Beta
return

_GoogleChromeCanary:
	FileInstall, setup/ChromeSetup_Canary.exe, setup/ChromeSetup_Canary.exe,1
	;msgbox, Extracted Google Chrome Canary
return



;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Utility Functions~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
RemoveSpaces(var)
{
	stringreplace, var, var, %A_Space%,,All
	return var
}

;The following two functions are modifications of those written by SKAN
;www.autohotkey.com/forum/viewtopic.php?t=19475&postdays=0&postorder=asc&start=15#184468
Download( url, file, name="")
{
	static _init
	global _cu
	Splitpath,file, _dFile
	if ! init
	{
		VarSetCapacity(vt,4*11)
		nPar:="31132253353"
		Loop, Parse, nPar
			NumPut(RegisterCallback("DL_Progress","Fast",A_LoopField,A_Index-1),vt,4*(A_Index-1))
	}
	
	SB_SetText("Downloading " . name,1)
	re:=DllCall("urlmon\URLDownloadToFile" . (A_IsUnicode ? "" : "A"), Uint,0, Str,url,Str,file,Uint,0,UintP,&vt)
	Return re=0 ? 1 : 0
}
DL_Progress( pthis, nP=0, nPMax=0, nSC=0, pST=0 ) {
	global _cu
	If (A_EventInfo=6)
	{
		Progress, Show
		P:=100*nP//nPMax
		SB_SetText(Round(np/1024,1) . " Kb / " . Round(npmax/1024) . " Kb    [ " . p . "`% ]", 2)
	}
	Return 0
}