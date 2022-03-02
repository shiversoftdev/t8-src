// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2efbf80b6e18c0ab;
#using scripts\core_common\system_shared.gsc;

#namespace teamset_allies;

/*
	Name: function_89f2df9
	Namespace: teamset_allies
	Checksum: 0x7AD7AB16
	Offset: 0x138
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"teamset_allies", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: teamset_allies
	Checksum: 0xF8E78520
	Offset: 0x180
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init("free");
	foreach(team in level.teams)
	{
		if(team == #"axis")
		{
			continue;
		}
		init(team);
	}
	teamset::customteam_init();
}

/*
	Name: init
	Namespace: teamset_allies
	Checksum: 0x4A030325
	Offset: 0x250
	Size: 0x13A
	Parameters: 1
	Flags: Linked
*/
function init(team)
{
	teamset::init();
	level.teamprefix[team] = "vox_st";
	level.teampostfix[team] = "st6";
	game.music["spawn_" + team] = "SPAWN_ST6";
	game.music["spawn_short" + team] = "SPAWN_SHORT_ST6";
	game.music["victory_" + team] = "VICTORY_ST6";
	game.voice[team] = "vox_st6_";
	game.flagmodels[team] = "p8_mp_flag_pole_1_blackops";
	game.carry_flagmodels[team] = "p8_mp_flag_carry_1_blackops";
	game.flagmodels[#"neutral"] = "p8_mp_flag_pole_1";
}

