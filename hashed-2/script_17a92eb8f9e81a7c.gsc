// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_6c5b51f98cd04fa3;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_d034654d;

/*
	Name: function_89f2df9
	Namespace: namespace_d034654d
	Checksum: 0x7AE1492F
	Offset: 0x140
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_73aa9f11a78d8d86", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_d034654d
	Checksum: 0x35DF94E6
	Offset: 0x190
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_842831cf();
	function_ec9e5cf2();
	function_ecf4f527();
}

/*
	Name: __main__
	Namespace: namespace_d034654d
	Checksum: 0x7151D335
	Offset: 0x1D0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	level flag::wait_till(#"all_players_spawned");
	namespace_ee206246::start(#"hash_306a7f142403b7c6");
	namespace_ee206246::start(#"hash_5474fbb93aebbb65");
}

/*
	Name: function_842831cf
	Namespace: namespace_d034654d
	Checksum: 0x60FE506D
	Offset: 0x240
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_842831cf()
{
	clientfield::register("toplayer", "" + #"hash_f2d0b920043dbbd", 1, 1, "counter");
	clientfield::register("world", "" + #"hash_5474fbb93aebbb65", 1, 1, "int");
}

/*
	Name: function_ec9e5cf2
	Namespace: namespace_d034654d
	Checksum: 0x943A7C35
	Offset: 0x2D0
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function function_ec9e5cf2()
{
	namespace_ee206246::register(#"hash_306a7f142403b7c6", #"step_1", #"hash_3203b932029a4e0b", &function_4d029800, &function_e3a2a8ab);
	namespace_ee206246::register(#"hash_5474fbb93aebbb65", #"step_1", #"hash_64d6af5ddc324d26", &function_6f55d670, &function_13c87ace);
	namespace_ee206246::register(#"hash_5474fbb93aebbb65", #"step_2", #"hash_3f567f217222e5b2", &function_e6ce9708, &function_4f6285d0);
}

/*
	Name: function_ecf4f527
	Namespace: namespace_d034654d
	Checksum: 0x80C802B5
	Offset: 0x400
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function function_ecf4f527()
{
	level.ls_door = getent("ls_door", "targetname");
	level.ls_door disconnectpaths();
	level.var_ff3d8977 = getent(level.ls_door.target, "targetname");
	level.var_ff3d8977 disconnectpaths();
}

/*
	Name: on_player_connect
	Namespace: namespace_d034654d
	Checksum: 0x18C4094
	Offset: 0x4A8
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	self thread track_player_eyes();
}

/*
	Name: function_4d029800
	Namespace: namespace_d034654d
	Checksum: 0x6EBB116D
	Offset: 0x4D0
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function function_4d029800(var_a276c861)
{
	foreach(player in level.players)
	{
		player thread track_player_eyes();
	}
	callback::on_connect(&on_player_connect);
}

/*
	Name: track_player_eyes
	Namespace: namespace_d034654d
	Checksum: 0x95F84A00
	Offset: 0x588
	Size: 0x210
	Parameters: 0
	Flags: Linked
*/
function track_player_eyes()
{
	self notify(#"track_player_eyes");
	self endon(#"disconnect", #"track_player_eyes");
	b_saw_the_wth = 0;
	var_616e76c5 = struct::get("sq_gl_scare", "targetname");
	while(!b_saw_the_wth)
	{
		for(n_time = 0; self adsbuttonpressed() && n_time < 25; n_time++)
		{
			waitframe(1);
		}
		if(n_time >= 25 && self adsbuttonpressed() && self zm_zonemgr::entity_in_zone("cage") && is_weapon_sniper(self getcurrentweapon()) && self zm_utility::is_player_looking_at(var_616e76c5.origin, 0.9975, 0, self))
		{
			self zm_utility::do_player_general_vox("general", "scare_react", undefined, 100);
			self clientfield::increment_to_player("" + #"hash_f2d0b920043dbbd", 1);
			for(j_time = 0; self adsbuttonpressed() && j_time < 5; j_time++)
			{
				waitframe(1);
			}
			b_saw_the_wth = 1;
		}
		waitframe(1);
	}
}

/*
	Name: is_weapon_sniper
	Namespace: namespace_d034654d
	Checksum: 0x20509E51
	Offset: 0x7A0
	Size: 0xC0
	Parameters: 1
	Flags: Linked, Private
*/
private function is_weapon_sniper(w_weapon)
{
	if(isdefined(w_weapon.issniperweapon) && w_weapon.issniperweapon)
	{
		if(weaponhasattachment(w_weapon, "elo") || weaponhasattachment(w_weapon, "reflex") || weaponhasattachment(w_weapon, "holo") || weaponhasattachment(w_weapon, "is"))
		{
			return 0;
		}
		return 1;
	}
	return 0;
}

/*
	Name: function_e3a2a8ab
	Namespace: namespace_d034654d
	Checksum: 0x7C45A83E
	Offset: 0x868
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function function_e3a2a8ab(var_a276c861, var_19e802fa)
{
}

/*
	Name: function_6f55d670
	Namespace: namespace_d034654d
	Checksum: 0x1D95D8BA
	Offset: 0x888
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_6f55d670(var_a276c861)
{
	level waittill(#"hash_2e0f22819e845463");
}

/*
	Name: function_13c87ace
	Namespace: namespace_d034654d
	Checksum: 0x5052A95E
	Offset: 0x8B8
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function function_13c87ace(var_a276c861, var_19e802fa)
{
}

/*
	Name: function_e6ce9708
	Namespace: namespace_d034654d
	Checksum: 0x1ACE13E5
	Offset: 0x8D8
	Size: 0xF4
	Parameters: 1
	Flags: Linked
*/
function function_e6ce9708(var_a276c861)
{
	spawn_instant_revive = getent("ls_blocker", "targetname");
	spawn_instant_revive delete();
	level.var_ff3d8977 connectpaths();
	level.var_ff3d8977 delete();
	level.ls_door rotateyaw(90, 1.6);
	level.ls_door connectpaths();
	level clientfield::set("" + #"hash_5474fbb93aebbb65", 1);
}

/*
	Name: function_4f6285d0
	Namespace: namespace_d034654d
	Checksum: 0xE5DDD699
	Offset: 0x9D8
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function function_4f6285d0(var_a276c861, var_19e802fa)
{
}

