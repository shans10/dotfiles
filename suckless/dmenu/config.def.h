/*  ____ _____  */
/* |  _ \_   _|  Derek Taylor (DistroTube) */
/* | | | || |  	http://www.youtube.com/c/DistroTube */
/* | |_| || |  	http://www.gitlab.com/dwt1/ */
/* |____/ |_|  	*/

/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */
/* Config was built with dmenu-flexipatch:             */
/* https://github.com/bakkeby/dmenu-flexipatch         */

/* The patches I have enabled are:   
* - alpha
* - border
* - center
* - fuzzyhighlight
* - fuzzymatch
* - grid
* - lineheight
* - morecolor
* - mousesupport
* - numbers
* - XYW  */

static int topbar = 1;            /* -b  option; if 0, dmenu appears at bottom */

#if ALPHA_PATCH
static int opacity = 0;           /* -o  option; if 0, then alpha is disabled */
#endif // ALPHA_PATCH

#if FUZZYMATCH_PATCH
static int fuzzy = 1;             /* -F  option; if 0, dmenu doesn't use fuzzy matching */
#endif // FUZZYMATCH_PATCH

#if INCREMENTAL_PATCH
static int incremental = 0;       /* -r  option; if 1, outputs text each time a key is pressed */
#endif // INCREMENTAL_PATCH

#if INSTANT_PATCH
static int instant = 0;           /* -n  option; if 1, selects matching item without the need to press enter */
#endif // INSTANT_PATCH

#if CENTER_PATCH
static int center = 0;            /* -c  option; if 0, dmenu won't be centered on the screen */
static int min_width = 680;       /* minimum width when centered */
#endif // CENTER_PATCH

#if RESTRICT_RETURN_PATCH
static int restrict_return = 0;   /* -1 option; if 1, disables shift-return and ctrl-return */
#endif // RESTRICT_RETURN_PATCH

/* -fn option overrides fonts[0]; default X11 font or font set */
#if PANGO_PATCH
static char font[] = "monospace 10";
#else
#if XRESOURCES_PATCH
static char *fonts[] =
#else
static const char *fonts[] = 
#endif // XRESOURCES_PATCH
{
	"JetBrainsMono Nerd Font:pixelsize=15:antialias=true:autohint=true",
};
#endif // PANGO_PATCH


#if MANAGED_PATCH
static char *prompt            = NULL;      /* -p  option; prompt to the left of input field */
#else
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
#endif // MANAGED_PATCH

#if DYNAMIC_OPTIONS_PATCH
static const char *dynamic     = NULL;      /* -dy option; dynamic command to run on input change */
#endif // DYNAMIC_OPTIONS_PATCH

#if SYMBOLS_PATCH
static const char *symbol_1 = "<";
static const char *symbol_2 = ">";
#endif // SYMBOLS_PATCH

#if ALPHA_PATCH
static const unsigned int baralpha = 0xd0;
static const unsigned int borderalpha = OPAQUE;
static const unsigned int alphas[][3]      = {
	/*               fg      bg        border     */
	[SchemeNorm] = { OPAQUE, baralpha, borderalpha },
	[SchemeSel]  = { OPAQUE, baralpha, borderalpha },
};

#endif // ALPHA_PATCH


/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 0;

/*
 * SELECT YOUR COLOR SCHEME
 * Available themes are:
 * 1. catppuccin.h
 * 2. tokyonight.h
 */
#include "colors/catppuccin.h"

#if GRID_PATCH
/* -g option; if nonzero, dmenu uses a grid comprised of columns and lines */
static unsigned int columns    = 0;
#endif // GRID_PATCH

#if LINE_HEIGHT_PATCH
static unsigned int lineheight = 22;         /* -h option; minimum height of a menu line     */
static unsigned int min_lineheight = 8;
#endif // LINE_HEIGHT_PATCH

#if NAVHISTORY_PATCH
static unsigned int maxhist    = 15;
static int histnodup           = 1;	/* if 0, record repeated histories */
#endif // NAVHISTORY_PATCH

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
#if PIPEOUT_PATCH
static const char startpipe[] = "#";
#endif // PIPEOUT_PATCH
static const char worddelimiters[] = " ";

#if BORDER_PATCH
/* Size of the window border */
static unsigned int border_width = 1;
#endif // BORDER_PATCH

#if PREFIXCOMPLETION_PATCH
/*
 * Use prefix matching by default; can be inverted with the -x flag.
 */
static int use_prefix = 1;
#endif // PREFIXCOMPLETION_PATCH
