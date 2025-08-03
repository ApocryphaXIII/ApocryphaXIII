/// Checks if the given mob is a imbued
#define IS_IMBUED(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/imbued))

// Imbued trait source
#define IMBUED_TRAIT "imbued_trait"

#define VIRTUE_ZEAL "zeal"
#define VIRTUE_MERCY "mercy"
#define VIRTUE_VISION "vision"

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

//Refills whole bar
#define CONVICTION_REFILL_XP_COST 15
//Per dot
#define VIRTUE_XP_COST 20
//Per dot
#define EDGE_XP_COST 20

#define EDGES_PER_CREED 5

/// Imbued abilities with XP cost = this are innately given to all imbued
#define IMBUED_POWER_INNATE -1
