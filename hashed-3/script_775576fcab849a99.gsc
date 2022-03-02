// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_64ac23dbb2d7d587;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace weaponobjects;

/*
	Name: function_89f2df9
	Namespace: weaponobjects
	Checksum: 0x5872329D
	Offset: 0x128
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"weaponobjects", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: weaponobjects
	Checksum: 0xF62DD5AA
	Offset: 0x170
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared((sessionmodeiscampaigngame() ? #"hash_461520942fd1154d" : #"rob_sonar_set_friendlyequip_mp"), #"rob_sonar_set_enemyequip");
	level setupscriptmovercompassicons();
	level setupmissilecompassicons();
}

/*
	Name: setupscriptmovercompassicons
	Namespace: weaponobjects
	Checksum: 0x2EE9978
	Offset: 0x200
	Size: 0x112
	Parameters: 0
	Flags: Linked
*/
function setupscriptmovercompassicons()
{
	if(!isdefined(level.scriptmovercompassicons))
	{
		level.scriptmovercompassicons = [];
	}
	level.scriptmovercompassicons[#"wpn_t7_turret_emp_core"] = "compass_empcore_white";
	level.scriptmovercompassicons[#"t6_wpn_turret_ads_world"] = "compass_guardian_white";
	level.scriptmovercompassicons[#"veh_t7_drone_uav_enemy_vista"] = "compass_uav";
	level.scriptmovercompassicons[#"veh_t7_mil_vtol_fighter_mp"] = "compass_lightningstrike";
	level.scriptmovercompassicons[#"veh_t7_drone_rolling_thunder"] = "compass_lodestar";
	level.scriptmovercompassicons[#"veh_t7_drone_srv_blimp"] = "t7_hud_minimap_hatr";
}

/*
	Name: setupmissilecompassicons
	Namespace: weaponobjects
	Checksum: 0x1B5CBCD0
	Offset: 0x320
	Size: 0x7A
	Parameters: 0
	Flags: Linked
*/
function setupmissilecompassicons()
{
	if(!isdefined(level.missilecompassicons))
	{
		level.missilecompassicons = [];
	}
	if(isdefined(getweapon(#"drone_strike")))
	{
		level.missilecompassicons[getweapon(#"drone_strike")] = "compass_lodestar";
	}
}

