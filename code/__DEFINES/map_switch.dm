/// Uses the left operator when compiling, uses the right operator when not compiling.
// Currently uses the CBT macro, but if http://www.byond.com/forum/post/2831057 is ever added,
// or if map tools ever agree on a standard, this should switch to use that.
#ifdef CBT
#define MAP_SWITCH(compile_time, map_time) ##compile_time
#else
#define MAP_SWITCH(compile_time, map_time) ##map_time
#endif

#ifdef CBT
#define WHEN_MAP(map_time) // Not mapping, nothing here
#else
#define WHEN_MAP(map_time) ##map_time
#endif

#ifdef CBT
#define WHEN_COMPILE(compile_time) ##compile_time
#else
#define WHEN_COMPILE(compile_time) // Not compiling, nothing here
#endif

#ifdef CBT
#define ONFLOOR_ICON_HELPER(map_time) ##onflooricon = 'code/modules/wod13/onfloor.dmi'
#else
#define ONFLOOR_ICON_HELPER(map_time) // Not compiling, nothing here
#endif
