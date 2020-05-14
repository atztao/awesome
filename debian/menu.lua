-- automatically generated file. Do not edit (see /usr/share/doc/menu/html)

module("debian.menu")

Debian_menu = {}

Debian_menu["Debian_CrossOver"] = {
	{"CrossOver","/opt/cxoffice/bin/crossover","/opt/cxoffice/share/icons/32x32/crossover.png"},
	{"Uninstall CrossOver Linux","/opt/cxoffice/bin/cxuninstall","/opt/cxoffice/share/icons/32x32/cxuninstall.png"},
}
Debian_menu["Debian_Windows_Applications_Evernote"] = {
	{"Evernote","\"/home/zhangtao/.cxoffice/印象笔记_(Evernote)_6.X/desktopdata/cxmenu/StartMenu.C^5E3A_users_crossover_Start^2BMenu/Programs/Evernote/Evernote.lnk\"","/home/zhangtao/.cxoffice/印象笔记_(Evernote)_6.X/windata/cxmenu/icons/hicolor/32x32/apps/254A_Evernote.0.png"},
}
Debian_menu["Debian_Windows_Applications"] = {
	{ "Evernote", Debian_menu["Debian_Windows_Applications_Evernote"] },
	{"腾讯QQ","\"/home/zhangtao/.cxoffice/腾讯_QQ_8.9/desktopdata/cxmenu/StartMenu.C^5E3A_users_crossover_Start^2BMenu/Programs/腾讯QQ.lnk\"","/home/zhangtao/.cxoffice/腾讯_QQ_8.9/windata/cxmenu/icons/hicolor/32x32/apps/977B_QQ.0.png"},
}
Debian_menu["Debian_帮助"] = {
	{"Info", "x-terminal-emulator -e ".."info"},
	{"Xman","xman"},
}
Debian_menu["Debian_屏幕_屏保"] = {
	{"Activate ScreenSaver (Next)","/usr/bin/xscreensaver-command -next"},
	{"Activate ScreenSaver (Previous)","/usr/bin/xscreensaver-command -prev"},
	{"Activate ScreenSaver (Random)","/usr/bin/xscreensaver-command -activate"},
	{"Console Matrix (Text)", "x-terminal-emulator -e ".."/usr/bin/cmatrix"},
	{"Console Matrix (Virtual Console)", "x-terminal-emulator -e ".."/usr/bin/cmatrix -l"},
	{"Console Matrix (X11)","/usr/bin/cmatrix -x"},
	{"Demo Screen Hacks","/usr/bin/xscreensaver-command -demo"},
	{"Disable XScreenSaver","/usr/bin/xscreensaver-command -exit"},
	{"Enable XScreenSaver","/usr/bin/xscreensaver"},
	{"Reinitialize XScreenSaver","/usr/bin/xscreensaver-command -restart"},
	{"ScreenSaver Preferences","/usr/bin/xscreensaver-command -prefs"},
}
Debian_menu["Debian_屏幕_锁定"] = {
	{"Lock Screen (XScreenSaver)","/usr/bin/xscreensaver-command -lock"},
}
Debian_menu["Debian_屏幕"] = {
	{ "屏保", Debian_menu["Debian_屏幕_屏保"] },
	{ "锁定", Debian_menu["Debian_屏幕_锁定"] },
}
Debian_menu["Debian_应用程序_Shell"] = {
	{"Bash", "x-terminal-emulator -e ".."/bin/bash --login"},
	{"Dash", "x-terminal-emulator -e ".."/bin/dash -i"},
	{"Sh", "x-terminal-emulator -e ".."/bin/sh --login"},
	{"Zsh", "x-terminal-emulator -e ".."/bin/zsh"},
}
Debian_menu["Debian_应用程序_办公"] = {
	{"GoldenDict","/usr/bin/goldendict","/usr/share/pixmaps/goldendict.png"},
}
Debian_menu["Debian_应用程序_编程"] = {
	{"Tclsh8.6", "x-terminal-emulator -e ".."/usr/bin/tclsh8.6"},
	{"TkWish8.6","x-terminal-emulator -e /usr/bin/wish8.6"},
}
Debian_menu["Debian_应用程序_编辑器"] = {
	{"prerex", "x-terminal-emulator -e ".."/usr/bin/prerex"},
	{"vprerex","/usr/bin/vprerex"},
	{"Xedit","xedit"},
}
Debian_menu["Debian_应用程序_查看器"] = {
	{"Wordview","/usr/bin/wordview"},
	{"Xditview","xditview"},
}
Debian_menu["Debian_应用程序_辅助工具"] = {
	{"Xmag","xmag"},
}
Debian_menu["Debian_应用程序_科学_数学"] = {
	{"sympy (Python3)", "x-terminal-emulator -e ".."python3 /usr/bin/isympy","/usr/share/pixmaps/isympy.xpm"},
	{"Xcalc","xcalc"},
}
Debian_menu["Debian_应用程序_科学"] = {
	{ "数学", Debian_menu["Debian_应用程序_科学_数学"] },
}
Debian_menu["Debian_应用程序_声音"] = {
	{"pavucontrol","/usr/bin/pavucontrol"},
	{"volumeicon","/usr/bin/volumeicon"},
}
Debian_menu["Debian_应用程序_图形"] = {
	{"dotty","/usr/bin/dotty"},
	{"lefty","/usr/bin/lefty"},
	{"The GIMP","/usr/bin/gimp","/usr/share/pixmaps/gimp.xpm"},
	{"X Window Snapshot","xwd | xwud"},
}
Debian_menu["Debian_应用程序_网络_通信"] = {
	{"Telnet", "x-terminal-emulator -e ".."/usr/bin/telnet.netkit"},
	{"Xbiff","xbiff"},
}
Debian_menu["Debian_应用程序_网络_网络浏览"] = {
	{"Google Chrome","/opt/google/chrome/google-chrome","/opt/google/chrome/product_logo_32.xpm"},
	{"w3m", "x-terminal-emulator -e ".."/usr/bin/w3m /usr/share/doc/w3m/MANUAL.html"},
}
Debian_menu["Debian_应用程序_网络"] = {
	{ "通信", Debian_menu["Debian_应用程序_网络_通信"] },
	{ "网络浏览", Debian_menu["Debian_应用程序_网络_网络浏览"] },
}
Debian_menu["Debian_应用程序_文本"] = {
	{"Fortune","sh -c 'while /usr/games/fortune | col -x | xmessage -center -buttons OK:1,Another:0 -default OK -file - ; do :; done'"},
}
Debian_menu["Debian_应用程序_文件管理"] = {
	{"catfish","catfish"},
	{"Xfdesktop","xfdesktop"},
}
Debian_menu["Debian_应用程序_系统_管理"] = {
	{"Debian Task selector", "x-terminal-emulator -e ".."su-to-root -c tasksel"},
	{"Editres","editres"},
	{"GNOME partition editor","su-to-root -X -c /usr/sbin/gparted","/usr/share/pixmaps/gparted.xpm"},
	{"UNetbootin","/usr/bin/unetbootin","/usr/share/pixmaps/unetbootin.xpm"},
	{"Xclipboard","xclipboard"},
	{"Xfce Application Finder","xfce4-appfinder","/usr/share/pixmaps/xfce4-appfinder.xpm"},
	{"Xfontsel","xfontsel"},
	{"Xkill","xkill"},
	{"Xrefresh","xrefresh"},
}
Debian_menu["Debian_应用程序_系统_软件包管理"] = {
	{"Aptitude Package Manager (text)", "x-terminal-emulator -e ".."/usr/bin/aptitude-curses"},
}
Debian_menu["Debian_应用程序_系统_系统监控"] = {
	{"Pstree", "x-terminal-emulator -e ".."/usr/bin/pstree.x11","/usr/share/pixmaps/pstree16.xpm"},
	{"Top", "x-terminal-emulator -e ".."/usr/bin/top"},
	{"Xconsole","xconsole -file /dev/xconsole"},
	{"Xev","x-terminal-emulator -e xev"},
	{"Xload","xload"},
}
Debian_menu["Debian_应用程序_系统_硬件"] = {
	{"Xvidtune","xvidtune"},
}
Debian_menu["Debian_应用程序_系统"] = {
	{ "管理", Debian_menu["Debian_应用程序_系统_管理"] },
	{ "软件包管理", Debian_menu["Debian_应用程序_系统_软件包管理"] },
	{ "系统监控", Debian_menu["Debian_应用程序_系统_系统监控"] },
	{ "硬件", Debian_menu["Debian_应用程序_系统_硬件"] },
}
Debian_menu["Debian_应用程序_终端"] = {
	{"X-Terminal as root (GKsu)","/usr/bin/gksu -u root /usr/bin/x-terminal-emulator","/usr/share/pixmaps/gksu-debian.xpm"},
}
Debian_menu["Debian_应用程序"] = {
	{ "Shell", Debian_menu["Debian_应用程序_Shell"] },
	{ "办公", Debian_menu["Debian_应用程序_办公"] },
	{ "编程", Debian_menu["Debian_应用程序_编程"] },
	{ "编辑器", Debian_menu["Debian_应用程序_编辑器"] },
	{ "查看器", Debian_menu["Debian_应用程序_查看器"] },
	{ "辅助工具", Debian_menu["Debian_应用程序_辅助工具"] },
	{ "科学", Debian_menu["Debian_应用程序_科学"] },
	{ "声音", Debian_menu["Debian_应用程序_声音"] },
	{ "图形", Debian_menu["Debian_应用程序_图形"] },
	{ "网络", Debian_menu["Debian_应用程序_网络"] },
	{ "文本", Debian_menu["Debian_应用程序_文本"] },
	{ "文件管理", Debian_menu["Debian_应用程序_文件管理"] },
	{ "系统", Debian_menu["Debian_应用程序_系统"] },
	{ "终端", Debian_menu["Debian_应用程序_终端"] },
}
Debian_menu["Debian_游戏_玩具类"] = {
	{"Oclock","oclock"},
	{"Xclock (analog)","xclock -analog"},
	{"Xclock (digital)","xclock -digital -update 1"},
	{"Xeyes","xeyes"},
	{"Xlogo","xlogo"},
}
Debian_menu["Debian_游戏"] = {
	{ "玩具类", Debian_menu["Debian_游戏_玩具类"] },
}
Debian_menu["Debian"] = {
	{ "CrossOver", Debian_menu["Debian_CrossOver"] },
	{ "Windows Applications", Debian_menu["Debian_Windows_Applications"] },
	{ "帮助", Debian_menu["Debian_帮助"] },
	{ "屏幕", Debian_menu["Debian_屏幕"] },
	{ "应用程序", Debian_menu["Debian_应用程序"] },
	{ "游戏", Debian_menu["Debian_游戏"] },
}
