// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2efbf80b6e18c0ab;
#using scripts\core_common\system_shared.gsc;

#namespace teamset_axis;

/*
	Name: function_89f2df9
	Namespace: teamset_axis
	Checksum: 0xA426095F
	Offset: 0x130
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"teamset_axis", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: teamset_axis
	Checksum: 0xBD3F2A15
	Offset: 0x178
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init(level.teams[#"axis"]);
	teamset::customteam_init();
}

/*
	Name: init
	Namespace: teamset_axis
	Checksum: 0xAAE717F8
	Offset: 0x1C0
	Size: 0x13A
	Parameters: 1
	Flags: Linked
*/
function init(team)
{
	teamset::init();
	level.teamprefix[team] = "vox_pm";
	level.teampostfix[team] = "axis";
	game.music["spawn_" + team] = "SPAWN_PMC";
	game.music["spawn_short" + team] = "SPAWN_SHORT_PMC";
	game.music["victory_" + team] = "VICTORY_PMC";
	game.voice[team] = "vox_pmc_";
	game.flagmodels[team] = "p8_mp_flag_pole_1_mercs";
	game.carry_flagmodels[team] = "p8_mp_flag_carry_1_mercs";
	game.flagmodels[#"neutral"] = "p8_mp_flag_pole_1";
}

