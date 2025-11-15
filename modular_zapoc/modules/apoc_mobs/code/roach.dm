/mob/living/simple_animal/hostile/cockroach/apoc
	name = "cockroach"
	desc = "This city is just crawling with bugs." // APOC EDIT CHANGE
	icon = 'code/modules/wod13/mobs.dmi'
	icon_state = "cockroach"
	icon_dead = "cockroach_dead"
	del_on_death = FALSE
	faction = list("rat")
	squish_chance = 50

/mob/living/simple_animal/hostile/cockroach/apoc/unsquishable
	squish_chance = 0
