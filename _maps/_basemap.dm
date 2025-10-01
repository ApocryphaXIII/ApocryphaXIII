//#define LOWMEMORYMODE //uncomment this to load just titlescreen and runtime town
//#define SHOW_INVENTORY_ICONS //uncomment this to make mapping software use inventory icons rather then world icons

#ifdef LOWMEMORYMODE
#include "map_files\generic\titlescreen.dmm"
#else
#include "map_files\generic\admin_central.dmm"
#endif

// #include "map_files\Mining\Lavaland.dmm"

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		#include "map_files\Vampire\runtimetown.dmm"
		#include "map_files\Vampire\SanFrancisco.dmm"
		#ifdef CIBUILDING
			#include "templates.dm"
		#endif
	#endif
#endif
