/*
Defining accesses as hexadecimal values denoted by 4 values.
[Specific Access][Specific Access Overflow][Faction Index][Faction Index Overflow]

Values go up in order of hexadecimal. If you need to add a faction between two already
defined factions, change the number of the [Faction Index Overflow].
If you need to add a Specific Access between two already defined Accesses,
change the number of the [Specific Access Overflow].
Preferably you will choose a value with no already defined cousins.
(eg. suppose [x2000, x2400, x3000] are defined, you would want to pick something like
x2600, since x2500 and x2700 aren't taken.)

#define ACCESS_FACTIONNAME_TYPE hexadecimal_number
*/

#define ACCESS_BASIC x1000
#define ACCESS_ADMIN x2000
#define ACCESS_ALL x3000

#define ACCESS_CAMARILLA_BASIC x1010
#define ACCESS_CAMARILLA_PRIMOGEN x2010
#define ACCESS_CAMARILLA_HOUND x3010
#define ACCESS_CAMARILLA_SHERIFF x4010
#define ACCESS_CAMARILLA_PRINCE x5010

#define ACCESS_ANARCH_BASIC x1020
#define ACCESS_ANARCH_ARMORY x2020
#define ACCESS_ANARCH_BARON x3020

#define ACCESS_VOIVODATE_BASIC x1030
#define ACCESS_VOIVODATE_BASEMENT x2030
#define ACCESS_VOIVODATE_ZADRUGA x3030
#define ACCESS_VOIVODATE_BOGATYR x4030
#define ACCESS_VOIVODATE_VOIVODE x5030

#define ACCESS_LAW_STATION x1040
#define ACCESS_LAW_ARMORY x2040
#define ACCESS_LAW_CELLS x3040
#define ACCESS_LAW_SARGE x4040
#define ACCESS_LAW_FEDERAL x5040
#define ACCESS_LAW_DETECTIVE x6040
#define ACCESS_LAW_EVIDENCE x6040

#define ACCESS_SEVENTYSIX_BASIC x1050
#define ACCESS_SEVENTYSIX_ARMORY x2050
#define ACCESS_SEVENTYSIX_SPEAKER x3050

#define ACCESS_SUITS_BASIC x1060
#define ACCESS_SUITS_VAULT x2060
#define ACCESS_SUITS_ARMORY x3060
#define ACCESS_SUITS_DEALER x4060

#define ACCESS_FERA_ONE x1070
#define ACCESS_FERA_TWO x2070
#define ACCESS_FERA_THREE x3070
#define ACCESS_FERA_FOUR x4070
#define ACCESS_FERA_FIVE x5070

#define ACCESS_ARCANUM_BASIC x1080
#define ACCESS_ARCANUM_VAULT x2080
#define ACCESS_ARCANUM_SECURITY x3080
#define ACCESS_ARCANUM_DEAN x4080

#define ACCESS_YUMCO_BASIC x1090
#define ACCESS_YUMCO_ARMORY x2090
#define ACCESS_YUMCO_BASEMENT x3090
#define ACCESS_YUMCO_EXECUTIVE x4090
