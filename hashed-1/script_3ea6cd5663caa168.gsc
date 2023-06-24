// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\teams\teamset.gsc;

#namespace namespace_6f4abfc0;

/*
	Name: main
	Namespace: namespace_6f4abfc0
	Checksum: 0xC0A0E8D
	Offset: 0x178
	Size: 0xC6
	Parameters: 0
	Flags: None
*/
function main()
{
	teamset::init();
	toggle = 0;
	foreach(team in level.teams)
	{
		if(toggle % 2)
		{
			init_axis(team);
		}
		else
		{
			init_allies(team);
		}
		toggle++;
	}
}

/*
	Name: init_allies
	Namespace: namespace_6f4abfc0
	Checksum: 0x8B2E4DCB
	Offset: 0x248
	Size: 0x102
	Parameters: 1
	Flags: None
*/
function init_allies(team)
{
	level.teamprefix[team] = "vox_st";
	level.teampostfix[team] = "st6";
	game.music["spawn_" + team] = "SPAWN_ST6";
	game.music["spawn_short" + team] = "SPAWN_SHORT_ST6";
	game.music["victory_" + team] = "VICTORY_ST6";
	game.voice[team] = "vox_st6_";
	game.flagmodels[team] = "mp_flag_allies_1";
	game.carry_flagmodels[team] = "mp_flag_allies_1_carry";
}

/*
	Name: init_axis
	Namespace: namespace_6f4abfc0
	Checksum: 0xABA8EAD2
	Offset: 0x358
	Size: 0x102
	Parameters: 1
	Flags: None
*/
function init_axis(team)
{
	level.teamprefix[team] = "vox_pm";
	level.teampostfix[team] = "init_axis";
	game.music["spawn_" + team] = "SPAWN_PMC";
	game.music["spawn_short" + team] = "SPAWN_SHORT_PMC";
	game.music["victory_" + team] = "VICTORY_PMC";
	game.voice[team] = "vox_pmc_";
	game.flagmodels[team] = "mp_flag_axis_1";
	game.carry_flagmodels[team] = "mp_flag_axis_1_carry";
}

