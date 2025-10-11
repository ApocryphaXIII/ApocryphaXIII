/obj/effect/spawner/random/treasure/book
	name = "treasure"
	loot = list()


/*/obj/effect/spawner/random/treasure/book/Initialize()
	. = ..()
	create_random_books(1, src.loc)
	qdel(src)*/


/obj/effect/spawner/random/treasure/fossil
/obj/effect/spawner/random/treasure/sherd
/obj/effect/spawner/random/treasure/archeo
/obj/effect/spawner/random/treasure/supernatural
/obj/effect/spawner/random/treasure/supernatural/kindred
/obj/effect/spawner/random/treasure/supernatural/fera


/obj/effect/spawner/random/treasure/treasure_omni
	name = "treasure"
	loot = list(
		/obj/effect/spawner/random/treasure/book,
		/obj/effect/spawner/random/treasure/fossil,
		/obj/effect/spawner/random/treasure/sherd,
		/obj/effect/spawner/random/treasure/archeo,
		/obj/effect/spawner/random/treasure/supernatural,
		/obj/effect/spawner/random/treasure/supernatural/kindred,
		/obj/effect/spawner/random/treasure/supernatural/fera
		)
