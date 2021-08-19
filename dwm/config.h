static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int gappx     = 15;        /* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int user_bh            = 21;       /* 0 means that dwm will calculate bar height, >= 1 means dwm will user_bh as bar height */
static const int swallowfloating    = 0;        /* 1 means swallow floating windows by default */
static const unsigned int systraypinning = 2;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayspacing = 6;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 0;     /* 0 means no systray */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "FantasqueSansMono Nerd Font:size=11", "Noto Color Emoji:size=11" };
static const char dmenufont[]       = "FantasqueSansMono Nerd Font:size=10";
static const char col_gray1[]       = "#282828";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_green[]        = "#689d6a";
static const char col_yellow[]        = "#fabd2f";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_green,  col_green },
	[SchemeHid]  = { col_yellow,  col_gray1, col_green  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9"};

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class                          instance     title       tags mask  isfloating   isterminal   noswallow  monitor */
	{ NULL,                             NULL,  "Event Tester",     0,         0,          0,           1,        -1 }, /* xev */
	{ "St",                             NULL,      NULL,           0,         0,          1,           0,        -1 },
	{ "kitty",                          NULL,      NULL,           0,         0,          1,           0,        -1 },
	{ "Alacritty",                      NULL,      NULL,           0,         0,          1,           0,        -1 },
	{ "LibreWolf",                      NULL,      NULL,           1 << 1,	  0,          0,           0,        -1 },
	{ "Chromium",                       NULL,      NULL,           1 << 1,	  0,          0,           0,        -1 },
	{ "Brave-browser",                  NULL,      NULL,           1 << 1,    0,          0,           0,        -1 },
	{ "Microsoft Teams - Preview",      NULL,      NULL,           0,/*1 << 6,*/    0,          0,           0,         0 },
	{ "discord",                        NULL,      NULL,           0,/*1 << 6,*/    0,          0,           0,        -1 },
	{ "Steam",                          NULL,      NULL,           0,/*1 << 5,*/    0,          0,           0,         1 },
	{ "Steam",                          NULL,  "Friends List",     0,/*1 << 5,*/    1,          0,           0,         1 },
	{ "Gpick",                          NULL,      NULL,           0,         1,          0,           0,        -1 },
	{ "Timeshift-gtk",                  NULL,      NULL,           0,         1,          0,           0,        -1 },
	{ "Lightdm-gtk-greeter-settings",   NULL,      NULL,           0,         1,          0,           0,        -1 },
	{ "Pavucontrol",                    NULL,      NULL,           0,         1,          0,           0,        -1 },
	{ "Lxappearance",                   NULL,      NULL,           0,         1,          0,           0,        -1 },
	{ "Grub-customizer",                NULL,      NULL,           0,         1,          0,           0,        -1 },
	{ "flameshot",                      NULL,      NULL,           0,         1,          0,           0,        -1 },
	{ "GParted",                        NULL,      NULL,           0,         1,          0,           0,        -1 },
	{ "PacketTracer",                   NULL,      NULL,           0,         1,          0,           0,        -1 },
	{ "Galculator",                     NULL,      NULL,           0,         1,          0,           0,        -1 },
	{ "Blueberry.py",                   NULL,      NULL,           0,         1,          0,           0,        -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[ ]",      monocle },
	{ "TTT",      bstack },
	{ "===",      bstackhoriz },
	{ "|M|",      centeredmaster },
	{ ">M>",      centeredfloatingmaster },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run" };
static const char *termcmd[]  = { "kitty", NULL };

#include <X11/XF86keysym.h>
#include "movestack.c"
static Key keys[] = {
	/* modifier                     key			function			argument */
	{ MODKEY|ShiftMask,             XK_j,       movestack,           {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,       movestack,           {.i = -1 } },
	{ MODKEY,                       XK_s,      	focusmon,           {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_s,      	tagmon,             {.i = +1 } },
	{ MODKEY,                       XK_j,      	focusstackvis,		{.i = +1 } },
	{ MODKEY,                       XK_k,      	focusstackvis,  	{.i = -1 } },
	{ MODKEY|ControlMask,           XK_j,      	focusstackhid,  	{.i = +1 } },
	{ MODKEY|ControlMask,           XK_k,      	focusstackhid,  	{.i = -1 } },
	{ MODKEY,                       XK_i,      	incnmaster,     	{.i = +1 } },
	{ MODKEY,                       XK_u,      	incnmaster,     	{.i = -1 } },
	{ MODKEY,                       XK_h,      	setmfact,       	{.f = -0.05} },
	{ MODKEY,                       XK_l,      	setmfact,       	{.f = +0.05} },
	{ MODKEY,						XK_q,      	killclient,     	{0} },
	{ MODKEY,                       XK_t,      	setlayout,          {.v = &layouts[0]} },
	{ MODKEY,                       XK_m,      	setlayout,          {.v = &layouts[2]} },
	{ MODKEY,                       XK_n,      	setlayout,          {.v = &layouts[3]} },
	{ MODKEY,                       XK_o,      	setlayout,          {.v = &layouts[4]} },
	{ MODKEY,                       XK_c,      	setlayout,          {.v = &layouts[5]} },
	{ MODKEY,                       XK_z,      	setlayout,          {.v = &layouts[6]} },
	{ MODKEY,                       XK_f,      	togglefloating,     {0} },
	{ MODKEY,                       XK_0,      	view,				{.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      	tag,            	{.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_b,      	show,           	{0} },
	{ MODKEY,                       XK_b,      	hide,           	{0} },
	{ MODKEY,                       XK_equal,  	setgaps,            {.i = +2 } },
	{ MODKEY,                       XK_minus,  	setgaps,            {.i = -2 } },

/* Tags */
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)

/* Hot Keys */
	{ 0,                            XF86XK_AudioRaiseVolume,   spawn,   SHCMD("amixer set Master 5%+ && pkill -RTMIN+5 dwmblocks") },
 	{ 0,                            XF86XK_AudioLowerVolume,   spawn,   SHCMD("amixer set Master 5%- && pkill -RTMIN+5 dwmblocks") },
	{ 0,                            XF86XK_AudioMute,          spawn,   SHCMD("amixer -D default set Master 1+ toggle && pkill -RTMIN+5 dwmblocks") },
	{ 0,                            XF86XK_AudioPrev,		   spawn,	SHCMD("mpc prev && ~/Docs/Scripts/notifications/music.sh") },
	{ 0,                            XF86XK_AudioNext,		   spawn,	SHCMD("mpc next && ~/Docs/Scripts/notifications/music.sh") },
	{ 0,                            XF86XK_AudioPlay,		   spawn,	SHCMD("mpc toggle && ~/Docs/Scripts/notifications/play-pause.sh") },
    { 0,				            XK_Print,                  spawn,	SHCMD("flameshot full -p ~/Pictures && notify-send -u normal 'Print Screen Taken' '' --icon='~/.config/dunst/icons/print.png'") },
    { MODKEY,                       XK_Print,                  spawn,   SHCMD("flameshot gui") },

/* Utils */
	{ MODKEY|ControlMask,           XK_F1,     quit,          {0} },
	{ MODKEY,                       XK_y,      togglebar,     {0} },
    { MODKEY,                       XK_p,      spawn,         SHCMD("$TERMINAL -e ~/Docs/Scripts/s") },
    { MODKEY,                       XK_space,  spawn,         SHCMD("rofi -show drun") },
    { Mod1Mask,                     XK_space,  spawn,         SHCMD("layout && pkill -RTMIN+2 dwmblocks") },
    { Mod1Mask,                     XK_Tab,    spawn,         SHCMD("rofi -show window -location 2 -lines 2 -columns 4 -width 100") },
    { MODKEY,                       XK_x,      spawn,         SHCMD("betterlockscreen -l") },
    { MODKEY|ShiftMask,             XK_space,  spawn,         SHCMD("clipmenu") },
    { MODKEY|ControlMask,           XK_space,  spawn,         SHCMD("mount_drive") },
    { MODKEY|ControlMask|ShiftMask, XK_space,  spawn,         SHCMD("unmount_drive") },
    { MODKEY,						XK_g,	   spawn,         SHCMD("picom-toggle") },

/* Power Menu */
    { MODKEY|ControlMask,           XK_F5,     spawn,         SHCMD("shutdown now") },
    { MODKEY|ControlMask,           XK_F6,     spawn,         SHCMD("reboot") },
    { MODKEY|ControlMask,           XK_F7,     spawn,         SHCMD("systemctl suspend && betterlockscreen -l") },
    { MODKEY|ControlMask,           XK_F8,     spawn,         SHCMD("systemctl hibernate && betterlockscreen -l") },

/* Programs */
	{ MODKEY,                       XK_d,      spawn,         {.v = dmenucmd } },
	{ MODKEY,                       XK_Return, spawn,         {.v = termcmd } },
    { MODKEY|Mod1Mask,              XK_w,      spawn,         SHCMD("librewolf") },
    { MODKEY|Mod1Mask,              XK_f,      spawn,         SHCMD("pcmanfm") },
    { MODKEY|ShiftMask,             XK_Return, spawn,         SHCMD("$TERMINAL -e ~/.config/vifm/scripts/vifmrun") },
    { MODKEY|Mod1Mask,              XK_m,      spawn,         SHCMD("$TERMINAL -e ncmpcpp") },
    { MODKEY|Mod1Mask,              XK_s,      spawn,         SHCMD("pavucontrol") },
    { MODKEY|Mod1Mask,              XK_v,      spawn,         SHCMD("veracrypt") },
    { MODKEY|Mod1Mask,              XK_k,      spawn,         SHCMD("keepassxc") },
    { MODKEY|Mod1Mask,              XK_p,      spawn,         SHCMD("gpick") },
    { MODKEY|Mod1Mask,              XK_t,      spawn,         SHCMD("telegram-desktop") },
    { MODKEY|Mod1Mask,              XK_d,      spawn,         SHCMD("dbeaver") },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button1,        togglewin,      {0} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
