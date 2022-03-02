// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\teleport_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_2e6d0155;

/*
	Name: init
	Namespace: namespace_2e6d0155
	Checksum: 0x91A218EE
	Offset: 0x2F8
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level thread function_c91644e8();
	level thread function_e5f05a92();
	level thread function_b117d867();
	callback::on_connect(&function_c49fe830);
}

/*
	Name: function_c91644e8
	Namespace: namespace_2e6d0155
	Checksum: 0xFF52D74B
	Offset: 0x370
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_c91644e8()
{
	level endon(#"end_game");
	level flag::wait_till("begin_spawning");
	teleport::team("teleport_starting_tunnel");
}

/*
	Name: function_e5f05a92
	Namespace: namespace_2e6d0155
	Checksum: 0xA96B2ED5
	Offset: 0x3C8
	Size: 0x524
	Parameters: 0
	Flags: Linked
*/
function function_e5f05a92()
{
	level endon(#"end_game");
	mdl_clip = getent("arena_gate_east_clip", "targetname");
	mdl_gate = getent("arena_gate_east", "targetname");
	mdl_clip linkto(mdl_gate);
	level flag::wait_till("begin_spawning");
	wait(2.5);
	mdl_gate movez(100, 3);
	mdl_gate playsound(#"hash_2dfa3192317aab20");
	mdl_gate clientfield::set("entry_gate_dust", 1);
	wait(3);
	var_ac1242dd = 0;
	vol_spawn_area = getent("vol_spawn_area", "targetname");
	while(!var_ac1242dd)
	{
		var_5f98e272 = [];
		foreach(e_player in util::get_active_players())
		{
			if(e_player istouching(vol_spawn_area))
			{
				if(!isdefined(var_5f98e272))
				{
					var_5f98e272 = [];
				}
				else if(!isarray(var_5f98e272))
				{
					var_5f98e272 = array(var_5f98e272);
				}
				var_5f98e272[var_5f98e272.size] = e_player;
				continue;
			}
			if(e_player clientfield::get_to_player("snd_crowd_react") != 8)
			{
				e_player clientfield::set_to_player("snd_crowd_react", 8);
				if(level clientfield::get("crowd_react") != 3)
				{
					level clientfield::set("crowd_react", 3);
				}
			}
		}
		if(var_5f98e272.size == 0)
		{
			a_ai_zombies = getactorarray();
			foreach(ai_zombie in a_ai_zombies)
			{
				if(ai_zombie istouching(vol_spawn_area))
				{
					if(!isdefined(var_5f98e272))
					{
						var_5f98e272 = [];
					}
					else if(!isarray(var_5f98e272))
					{
						var_5f98e272 = array(var_5f98e272);
					}
					var_5f98e272[var_5f98e272.size] = ai_zombie;
				}
			}
			if(var_5f98e272.size == 0)
			{
				var_ac1242dd = 1;
				break;
			}
		}
		waitframe(1);
	}
	level notify(#"hash_576f1c2e68b31710");
	mdl_gate movez(100 * -1, 0.5);
	mdl_gate playsound(#"hash_7f2e66132114e68c");
	wait(0.5);
	zm_zonemgr::function_d68ef0f9("zone_starting_area_tunnel");
	exploder::exploder("exp_gate_slam");
	exploder::exploder("exp_lgt_player_start");
	level util::clientnotify("crowd_ducker_lvlstart");
	wait(10);
	if(level clientfield::get("crowd_react") == 3)
	{
		level clientfield::set("crowd_react", 0);
	}
}

/*
	Name: function_b117d867
	Namespace: namespace_2e6d0155
	Checksum: 0x65F55E99
	Offset: 0x8F8
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function function_b117d867()
{
	level endon(#"end_game");
	scene::init("p8_fxanim_zm_towers_center_platform_rails_bundle");
	level flag::wait_till("begin_spawning");
	t_trigger = getent("t_raise_center_platform_rails", "targetname");
	t_trigger waittilltimeout(6, #"trigger");
	scene::play("p8_fxanim_zm_towers_center_platform_rails_bundle");
	t_trigger delete();
}

/*
	Name: function_c49fe830
	Namespace: namespace_2e6d0155
	Checksum: 0xD00A7D5B
	Offset: 0x9D8
	Size: 0x242
	Parameters: 0
	Flags: Linked
*/
function function_c49fe830()
{
	level endon(#"end_game");
	self endon(#"disconnect");
	level.var_c9942395 = 0;
	var_7529ade9 = array("zone_starting_area_tunnel", "zone_starting_area_center", "zone_starting_area_danu", "zone_starting_area_ra", "zone_starting_area_odin", "zone_starting_area_zeus", "zone_danu_hallway", "zone_ra_hallway", "zone_odin_hallway", "zone_zeus_hallway");
	while(true)
	{
		str_zone = self zm_zonemgr::get_player_zone();
		if(!isinarray(var_7529ade9, str_zone))
		{
			wait(30);
			str_zone = self zm_zonemgr::get_player_zone();
			if(!isinarray(var_7529ade9, str_zone) && !level.var_c9942395)
			{
				break;
			}
		}
		wait(1);
	}
	var_d4061661 = array("zone_starting_area_center", "zone_starting_area_danu", "zone_starting_area_ra", "zone_starting_area_odin", "zone_starting_area_zeus");
	while(true)
	{
		str_zone = self zm_zonemgr::get_player_zone();
		if(zm_utility::is_player_valid(self, 0, 0) && isinarray(var_d4061661, str_zone) && !level.var_c9942395)
		{
			level thread function_a1379826();
			self thread zm_audio::create_and_play_dialog(#"hash_20b463357f4ae8f", #"arena");
			break;
		}
		wait(1);
	}
}

/*
	Name: function_a1379826
	Namespace: namespace_2e6d0155
	Checksum: 0x2B6963B0
	Offset: 0xC28
	Size: 0x42
	Parameters: 0
	Flags: Linked
*/
function function_a1379826()
{
	self notify("774a09e7ee8e5620");
	self endon("774a09e7ee8e5620");
	level.var_c9942395 = 1;
	wait(45);
	level.var_c9942395 = 0;
}

