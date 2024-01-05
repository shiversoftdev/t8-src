// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2595527427ea71eb;
#using scripts\zm\zm_towers_main_quest.gsc;
#using scripts\zm\zm_towers_crowd.gsc;
#using scripts\zm\zm_towers.gsc;
#using scripts\zm_common\bgbs\zm_bgb_anywhere_but_here.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;
#using scripts\zm_common\zm_vo.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\zm_common\zm_round_logic.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\status_effects\status_effect_util.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\animation_shared.gsc;

#namespace zm_trial_towers_boss;

/*
	Name: __init__system__
	Namespace: zm_trial_towers_boss
	Checksum: 0xCABCD533
	Offset: 0x428
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_trial_towers_boss", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_trial_towers_boss
	Checksum: 0x69A5ADE4
	Offset: 0x470
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!zm_trial::is_trial_mode())
	{
		return;
	}
	zm_trial::register_challenge(#"towers_boss", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: zm_trial_towers_boss
	Checksum: 0x61BBFDF6
	Offset: 0x4D8
	Size: 0xA4
	Parameters: 3
	Flags: Linked, Private
*/
function private on_begin(var_6325d314, var_52b8b3a2, n_time)
{
	level flag::clear(#"spawn_zombies");
	callback::on_spawned(&zm_towers_main_quest::function_d4e923e7);
	wait(10);
	level thread scene::play(#"p8_fxanim_zm_towers_boss_arena_gate_raise_bundle", "Shot 3");
	level thread function_353ea592();
}

/*
	Name: on_end
	Namespace: zm_trial_towers_boss
	Checksum: 0xE9288B6
	Offset: 0x588
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
function private on_end(round_reset)
{
	callback::remove_on_spawned(&zm_towers_main_quest::function_d4e923e7);
}

/*
	Name: function_353ea592
	Namespace: zm_trial_towers_boss
	Checksum: 0xFE562B74
	Offset: 0x5C0
	Size: 0x108
	Parameters: 0
	Flags: Linked, Private
*/
function private function_353ea592()
{
	self notify("6fdbe26c6aeb036");
	self endon("6fdbe26c6aeb036");
	level endon(#"end_of_round");
	level thread function_8318a404();
	level waittill(#"elephant_death");
	level flag::clear(#"infinite_round_spawning");
	level flag::clear(#"pause_round_timeout");
	level.zombie_total = 0;
	level thread zm_utility::function_9ad5aeb1(0, 1, 1, 0);
	wait(5);
	level notify(#"kill_round");
	level notify(#"kill_round_wait");
}

/*
	Name: function_8318a404
	Namespace: zm_trial_towers_boss
	Checksum: 0x4370CC8A
	Offset: 0x6D0
	Size: 0x2FC
	Parameters: 0
	Flags: Linked, Private
*/
function private function_8318a404()
{
	self notify("3eafbccd965262a6");
	self endon("3eafbccd965262a6");
	level endon(#"end_of_round");
	zm_zonemgr::enable_zone("zone_boss_battle");
	setclearanceceiling(142);
	level.boss_entry_tower_remains = getent("boss_entry_tower_remains", "targetname");
	if(isdefined(level.boss_entry_tower_remains))
	{
		level.boss_entry_tower_remains hide();
	}
	entrance_tower_collision = getent("entrance_tower_collision", "targetname");
	if(isdefined(entrance_tower_collision))
	{
		entrance_tower_collision disconnectpaths();
	}
	level scene::init("boss_battle_tempo", "targetname");
	a_corpses = getcorpsearray();
	foreach(corpse in a_corpses)
	{
		if(isactorcorpse(corpse))
		{
			corpse delete();
		}
	}
	level thread lui::screen_flash(0.5, 2, 1, 1, (1, 1, 1));
	level thread zm_utility::function_9ad5aeb1(0, 1, 1, 0);
	wait(1);
	var_ff91be3a = struct::get_array("s_zm_towers_port_to_boss", "targetname");
	var_a10268d3 = getplayers();
	for(i = 0; i < var_a10268d3.size; i++)
	{
		var_a10268d3[i] setorigin(var_ff91be3a[i].origin);
		var_a10268d3[i] setplayerangles(var_ff91be3a[i].angles);
	}
	level thread boss_fight();
}

/*
	Name: boss_fight
	Namespace: zm_trial_towers_boss
	Checksum: 0x75527E9D
	Offset: 0x9D8
	Size: 0x5B8
	Parameters: 0
	Flags: Linked, Private
*/
function private boss_fight()
{
	self notify("4b6131952d06894a");
	self endon("4b6131952d06894a");
	wait(5);
	zm_towers_crowd::function_5c1184e(0);
	zm_towers_crowd::function_aec5ec5a(1);
	level.var_9a992b09 = 1;
	array::thread_all(level.players, &zm_towers_crowd::function_51ea46f3, 0, 1);
	foreach(player in level.players)
	{
		player clientfield::set_to_player("snd_crowd_react", 11);
	}
	zm_bgb_anywhere_but_here::function_886fce8f(0);
	if(!(isdefined(level.var_27d781ea) && level.var_27d781ea))
	{
		level thread function_13576d14();
	}
	level clientfield::set("crowd_react_boss", 0);
	var_47312393 = struct::get(#"towers_boss_location_1", "script_noteworthy");
	sp_spawner = getent("zombie_towers_boss_spawner", "script_noteworthy");
	level thread function_4d682898();
	level thread function_92e1954c();
	level thread function_1a05e10c(#"hash_4b701378fdc308f", "m_quest", "spear_warn");
	level thread function_1a05e10c(#"hash_5c38f322b9e6a58d", "m_quest", "missle_warn");
	level thread function_1a05e10c(#"hash_1a3fb5566689f319", "m_quest", "missle_track");
	level thread function_1a05e10c(#"hash_1580cd3b2c801f46", "m_quest", "charge_warn");
	level thread function_1a05e10c(#"towers_boss_ground_attack", "m_quest", "shockwave_warn");
	level thread function_c64fc074();
	level thread function_95785950(125, level.var_49328379, "m_quest", "armor_nag");
	level thread function_95785950(187, level.var_8b66546e, "m_quest", "basket_nag");
	level thread function_95785950(211, level.var_49328379, "m_quest", "heart_nag");
	array::thread_all(level.players, &function_3d487e02);
	e_elephant = spawner::simple_spawn_single(sp_spawner, &function_f9da4403, var_47312393, #"hash_266f53fb994e6120");
	while(!isdefined(e_elephant.ai.riders) || e_elephant.ai.riders.size < 2)
	{
		wait(0.1);
	}
	level util::delay(2, undefined, &clientfield::set, "crowd_react_boss", 1);
	level.var_27d781ea = 1;
	level.var_3395fcab = 1;
	animation::add_global_notetrack_handler("tower_contact", &function_dd2db3df, 0);
	scene::play(#"hash_5e82fd01d9eb1519", array(e_elephant));
	e_elephant notify(#"entrace_done");
	level thread function_ae1cbf2e();
	level flag::set(#"spawn_zombies");
	level flag::set(#"infinite_round_spawning");
	level flag::set(#"pause_round_timeout");
	e_elephant waittill(#"death");
	level notify(#"elephant_death");
}

/*
	Name: function_13576d14
	Namespace: zm_trial_towers_boss
	Checksum: 0xE6DE4D8B
	Offset: 0xF98
	Size: 0x184
	Parameters: 0
	Flags: Linked, Private
*/
function private function_13576d14()
{
	var_bfd0a84a = getentarray("towers_boss_tower_trigger", "targetname");
	var_6848389e = 0;
	var_a406cb50 = 40;
	foreach(var_e220a902 in var_bfd0a84a)
	{
		var_e220a902 thread function_33935d5f();
		/#
			recordent(var_e220a902);
		#/
		var_d7267ad9 = "towers_boss_tower_badplace_" + var_6848389e;
		var_e220a902.badplace_name = var_d7267ad9;
		badplace_box(var_d7267ad9, 0, groundtrace(var_e220a902.origin + vectorscale((0, 0, 1), 8), var_e220a902.origin + (vectorscale((0, 0, -1), 100000)), 0, var_e220a902)[#"position"], var_a406cb50, "all");
		var_6848389e++;
		waitframe(1);
	}
}

/*
	Name: function_33935d5f
	Namespace: zm_trial_towers_boss
	Checksum: 0xCCC9DDFD
	Offset: 0x1128
	Size: 0x1B4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_33935d5f()
{
	self notify("51b1374f19c0864a");
	self endon("51b1374f19c0864a");
	self.b_exploded = 0;
	e_clip = getent(self.target, "targetname");
	while(!self.b_exploded)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger", #"tower_boss_scripted_trigger_tower");
		shouldexplode = isdefined(waitresult.activator) && isdefined(waitresult.activator.archetype) && waitresult.activator.archetype === #"elephant";
		if(shouldexplode || waitresult._notify == "tower_boss_scripted_trigger_tower")
		{
			if(isdefined(e_clip))
			{
				e_clip delete();
			}
			fx_tower = struct::get(self.target, "targetname");
			fx_tower scene::play();
			self.b_exploded = 1;
			if(isdefined(self.badplace_name))
			{
				badplace_delete(self.badplace_name);
			}
			break;
		}
	}
}

/*
	Name: function_92e1954c
	Namespace: zm_trial_towers_boss
	Checksum: 0x26220DE6
	Offset: 0x12E8
	Size: 0x8A
	Parameters: 0
	Flags: Linked, Private
*/
function private function_92e1954c()
{
	self notify("602480c649d8e17f");
	self endon("602480c649d8e17f");
	level endon(#"end_game", #"boss_battle_done");
	while(true)
	{
		level waittill(#"hash_3aa3137f1bf70773");
		level.var_49328379 = 1;
		wait(30);
		level.var_49328379 = 0;
	}
}

/*
	Name: function_4d682898
	Namespace: zm_trial_towers_boss
	Checksum: 0x2B782397
	Offset: 0x1380
	Size: 0x8A
	Parameters: 0
	Flags: Linked, Private
*/
function private function_4d682898()
{
	self notify("1d04cafdc26414eb");
	self endon("1d04cafdc26414eb");
	level endon(#"end_game", #"boss_battle_done");
	while(true)
	{
		level waittill(#"basket_hit");
		level.var_8b66546e = 1;
		wait(30);
		level.var_8b66546e = 0;
	}
}

/*
	Name: function_3d487e02
	Namespace: zm_trial_towers_boss
	Checksum: 0xAFB527A3
	Offset: 0x1418
	Size: 0x1AA
	Parameters: 0
	Flags: Linked, Private
*/
function private function_3d487e02()
{
	self notify("72b45c7bc8c76fc3");
	self endon("72b45c7bc8c76fc3");
	level endon(#"end_game", #"boss_battle_done");
	self endon(#"disconnect");
	b_success = 0;
	params = getstatuseffect(#"hash_12a64221f4d27f9b");
	weapon = getweapon(#"eq_molotov");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"aoe_damage");
		if(waitresult.var_159100b7 == "zm_aoe_spear" || waitresult.var_159100b7 == "zm_aoe_spear_small" || waitresult.var_159100b7 == "zm_aoe_spear_big")
		{
			self status_effect::status_effect_apply(params, weapon, undefined, 0, 3000, undefined, waitresult.origin);
			if(!(isdefined(b_success) && b_success))
			{
				b_success = self zm_audio::create_and_play_dialog(#"m_quest", #"spear_warn");
			}
		}
	}
}

/*
	Name: function_f9da4403
	Namespace: zm_trial_towers_boss
	Checksum: 0xD1451732
	Offset: 0x15D0
	Size: 0x8A
	Parameters: 2
	Flags: Linked
*/
function function_f9da4403(s_spawn, phase)
{
	self endon(#"death");
	self.ai.phase = phase;
	self forceteleport(s_spawn.origin, s_spawn.angles);
	level.e_elephant = self;
	self.instakill_func = &zm_powerups::function_16c2586a;
}

/*
	Name: function_dd2db3df
	Namespace: zm_trial_towers_boss
	Checksum: 0xD86A2E1A
	Offset: 0x1668
	Size: 0xF4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_dd2db3df()
{
	tower = struct::get("entrance_tower", "targetname");
	entrance_tower_collision = getent("entrance_tower_collision", "targetname");
	if(isdefined(entrance_tower_collision))
	{
		entrance_tower_collision connectpaths();
		entrance_tower_collision delete();
	}
	if(isdefined(tower))
	{
		tower thread scene::play();
		wait(scene::function_12479eba(#"p8_fxanim_zm_towers_boss_arena_tower_entrance_bundle"));
		if(isdefined(level.boss_entry_tower_remains))
		{
			level.boss_entry_tower_remains show();
		}
	}
}

/*
	Name: function_95785950
	Namespace: zm_trial_towers_boss
	Checksum: 0xB548E59A
	Offset: 0x1768
	Size: 0xA8
	Parameters: 4
	Flags: Linked, Private
*/
function private function_95785950(var_c625106d, var_86163b89, n_stage, var_39acfdda)
{
	self notify("683195b7da79b6b9");
	self endon("683195b7da79b6b9");
	level endon(#"end_game", #"boss_battle_done");
	while(true)
	{
		wait(var_c625106d);
		if(isdefined(var_86163b89) && var_86163b89)
		{
			continue;
		}
		else
		{
			zm_audio::function_bca32e49("m_quest", var_39acfdda);
		}
	}
}

/*
	Name: function_ae1cbf2e
	Namespace: zm_trial_towers_boss
	Checksum: 0x509372FA
	Offset: 0x1818
	Size: 0x9C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_ae1cbf2e()
{
	self notify("6a1dc39ab115329");
	self endon("6a1dc39ab115329");
	level zm_audio::sndannouncerplayvox(#"hash_c8182d04e7f43c9");
	level zm_audio::function_bca32e49("m_quest", "fury_arrive");
	zm_vo::function_3c173d37();
	zm_vo::function_7e4562d7(#"hash_1a458ffc30e9306d");
}

/*
	Name: function_1a05e10c
	Namespace: zm_trial_towers_boss
	Checksum: 0x788CA10D
	Offset: 0x18C0
	Size: 0x9A
	Parameters: 3
	Flags: Linked, Private
*/
function private function_1a05e10c(str_notify, var_f13787ad, var_ca8a3a53)
{
	self notify("588886ce796505cd");
	self endon("588886ce796505cd");
	level endon(#"end_game", #"boss_battle_done");
	b_success = 0;
	while(!b_success)
	{
		level waittill(str_notify);
		b_success = zm_audio::function_bca32e49(var_f13787ad, var_ca8a3a53);
	}
}

/*
	Name: function_c64fc074
	Namespace: zm_trial_towers_boss
	Checksum: 0x29F4926C
	Offset: 0x1968
	Size: 0x64
	Parameters: 0
	Flags: Linked, Private
*/
function private function_c64fc074()
{
	self notify("7d5d5c98ec5ee437");
	self endon("7d5d5c98ec5ee437");
	level waittill(#"hash_634700dd42db02d8");
	zm_vo::function_3c173d37();
	zm_vo::function_7e4562d7(#"hash_6e1019732c1a9fc4");
}

