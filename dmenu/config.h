static int topbar = 1;      /* -b  option; if 0, dmenu appears at bottom     */
static int fuzzy = 1;       /* -F  option; if 0, dmenu doesn't use fuzzy matching     */

/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = { "FantasqueSansMono Nerd Font:pixelsize=15", "Noto Color Emoji:pixelsize=15" };
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
	/*                 fg            bg       */
	[SchemeNorm] =  { "#ECEFF4", "#2E3440" },
	[SchemeSel]  =  { "#ECEFF4", "#81a1c1" },
	[SchemeOut]  =  { "#ECEFF4", "#ECEFF4" },
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 0;

/* -h option; minimum height of a menu line */
static unsigned int lineheight = 10;
static unsigned int min_lineheight = 0;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

/* Size of the window border */
static const unsigned int border_width = 2;
