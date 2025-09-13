#define isimbued(A) (is_species(A,/datum/species/human/imbued))

#define STATUS_EFFECT_SECOND_SIGHT /datum/status_effect/imbued/second_sight

// Imbued trait source
#define IMBUED_TRAIT "imbued_trait"

#define VIRTUE_NONE "virtueless"
#define VIRTUE_ZEAL "zeal"
#define VIRTUE_MERCY "mercy"
#define VIRTUE_VISION "vision"

// A virtueless creed with no abilties
#define CREED_BYSTANDER "bystander"

#define CREED_DEFENDER "defender"
#define CREED_JUDGE "judge"
#define CREED_AVENGER "avenger"
#define CREED_MARTYR "martyr"
#define CREED_INNOCENT "innocent"
#define CREED_REDEEMER "redeemer"
#define CREED_VISIONARY "visionary"
#define CREED_HERMIT "hermit"
#define CREED_WAYWARD "wayward"

#define MAX_DOT_TOTAL 15
#define MAX_DOT_PER_VIRTUE 10

#define DEFAULT_WILLPOWER 4
#define DEFAULT_CONVICTION 5
#define CONVICTION_REGAIN 2

//Refills whole bar
#define CONVICTION_REFILL_XP_COST 15
//Per dot
#define VIRTUE_XP_COST 20
//Per dot
#define EDGE_XP_COST 20

#define EDGES_PER_CREED 5

/// Imbued abilities with XP cost = this are innately given to all imbued
#define IMBUED_POWER_INNATE -1

GLOBAL_LIST_INIT(the_word_words, world.file2list("strings/the_word.txt"))
GLOBAL_LIST_INIT(the_word_valid_sprites, world.file2list("strings/the_word_sprites.txt"))

#define ALL_IMBUED_CREEDS list(CREED_BYSTANDER, CREED_DEFENDER, CREED_JUDGE, CREED_AVENGER, CREED_MARTYR, CREED_INNOCENT, CREED_REDEEMER, CREED_VISIONARY, CREED_HERMIT, CREED_WAYWARD)
