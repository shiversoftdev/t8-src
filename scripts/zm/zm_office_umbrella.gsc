// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_sq.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace zm_office_umbrella;

/*
	Name: __init__system__
	Namespace: zm_office_umbrella
	Checksum: 0x7AE1492F
	Offset: 0x140
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_office_umbrella", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_office_umbrella
	Checksum: 0x35DF94E6
	Offset: 0x190
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_clientfield();
	function_ec9e5cf2();
	init_objects();
}

/*
	Name: __main__
	Namespace: zm_office_umbrella
	Checksum: 0x7151D335
	Offset: 0x1D0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	level flag::wait_till(#"all_players_spawned");
	zm_sq::start(#"jump_scare");
	zm_sq::start(#"narrative_room");
}

/*
	Name: init_clientfield
	Namespace: zm_office_umbrella
	Checksum: 0x60FE506D
	Offset: 0x240
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function init_clientfield()
{
	clientfield::register("toplayer", "" + #"hash_f2d0b920043dbbd", 1, 1, "counter");
	clientfield::register("world", "" + #"narrative_room", 1, 1, "int");
}

/*
	Name: function_ec9e5cf2
	Namespace: zm_office_umbrella
	Checksum: 0x943A7C35
	Offset: 0x2D0
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function function_ec9e5cf2()
{
	zm_sq::register(#"jump_scare", #"step_1", #"hash_3203b932029a4e0b", &jump_scare, &function_e3a2a8ab);
	zm_sq::register(#"narrative_room", #"step_1", #"hash_64d6af5ddc324d26", &function_6f55d670, &function_13c87ace);
	zm_sq::register(#"narrative_room", #"step_2", #"hash_3f567f217222e5b2", &narrative_room, &function_4f6285d0);
}

/*
	Name: init_objects
	Namespace: zm_office_umbrella
	Checksum: 0x80C802B5
	Offset: 0x400
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function init_objects()
{
	level.ls_door = getent("ls_door", "targetname");
	level.ls_door disconnectpaths();
	level.var_ff3d8977 = getent(level.ls_door.target, "targetname");
	level.var_ff3d8977 disconnectpaths();
}

/*
	Name: on_player_connect
	Namespace: zm_office_umbrella
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
	Name: jump_scare
	Namespace: zm_office_umbrella
	Checksum: 0x6EBB116D
	Offset: 0x4D0
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function jump_scare(var_a276c861)
{
	foreach(player in level.players)
	{
		player thread track_player_eyes();
	}
	callback::on_connect(&on_player_connect);
}

/*
	Name: track_player_eyes
	Namespace: zm_office_umbrella
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
	Namespace: zm_office_umbrella
	Checksum: 0x20509E51
	Offset: 0x7A0
	Size: 0xC0
	Parameters: 1
	Flags: Linked, Private
*/
function private is_weapon_sniper(w_weapon)
{
	if(isdefined(w_weapon.issniperweapon) && w_weapon.issniperweapon)
	{
		if(weaponhasattachment(w_weapon, "elo") || weaponhasattachment(w_weapon, "reflex") || weaponhasattachment(w_weapon, "holo") || weaponhasattachment(w_weapon, "is"))
		{
			return false;
		}
		return true;
	}
	return false;
}

/*
	Name: function_e3a2a8ab
	Namespace: zm_office_umbrella
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
	Namespace: zm_office_umbrella
	Checksum: 0x1D95D8BA
	Offset: 0x888
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_6f55d670(var_a276c861)
{
	level waittill(#"fake_waittill");
}

/*
	Name: function_13c87ace
	Namespace: zm_office_umbrella
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
	Name: narrative_room
	Namespace: zm_office_umbrella
	Checksum: 0x1ACE13E5
	Offset: 0x8D8
	Size: 0xF4
	Parameters: 1
	Flags: Linked
*/
function narrative_room(var_a276c861)
{
	spawn_instant_revive = getent("ls_blocker", "targetname");
	spawn_instant_revive delete();
	level.var_ff3d8977 connectpaths();
	level.var_ff3d8977 delete();
	level.ls_door rotateyaw(90, 1.6);
	level.ls_door connectpaths();
	level clientfield::set("" + #"narrative_room", 1);
}

/*
	Name: function_4f6285d0
	Namespace: zm_office_umbrella
	Checksum: 0xE5DDD699
	Offset: 0x9D8
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function function_4f6285d0(var_a276c861, var_19e802fa)
{
}

