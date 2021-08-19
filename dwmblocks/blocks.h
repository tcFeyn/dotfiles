//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/		/*Command*/				/*Update Interval*/	/*Update Signal*/
	{"",	"s-network_traffic",					2,					7},
	{"",	"s-mpc",								0,					6},
	{"",	"s-packages",							0,					4},
	{"",	"s-system_usage",						2,					3},
	{"",	"s-volume",								0,					5},
	{"",	"s-keylayout",							0,					2},
	{"",	"s-date",								1,					1},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
