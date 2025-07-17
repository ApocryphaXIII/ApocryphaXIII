//aaaaa fill this with the datum for character menu circumstances
//circumstance should act like a class full of variables and functions that are stuck
//to the character preferences menu and save file
//a character is assigned a circumstance datum to hold values for instantiating
//special splat circumstances such as imbuement or ghouling

/datum/pref_circumstance

    var isImbued
    var isBystander

    var ghoul
    var bond

/*
    var kinfolk
    var kinain
*/


//imbued
/datum/pref_circumstance/imbued

    var creed
    var message

/datum/pref_circumstance/imbued/proc/set_creed()
/datum/pref_circumstance/imbued/proc/set_message()


//ghoul
/datum/pref_circumstance/ghoul

    var bond_name
    var bond_level

/datum/pref_circumstance/ghoul/proc/get_bond_data()
    //scrape the data on the character the ghoul is bonded to
    //get disciplines, name, generation

/datum/pref_circumstance/ghoul/proc/bond_request()
    //this pushes a prompt to a person confirming they are ok with
    //bonding a character to them. needs to account for validity of
    //bonding with that character, and making sure that player
    //is actually online


/*todo
procs for the various interfaces needed to select blood bond details,
creed, message, etc.
start moving ghoul stuff to here
model the imbued stuff after how you decide to do the ghoul stuff
discipline picking and shit needs to be menus
need to make stuff for virtue and conviction values
need to look at how xp is handled
*/




