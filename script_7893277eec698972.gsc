// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_681abc4248c2bc7d;
#using scripts\zm_common\trials\zm_trial_disable_buys.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_ui_inventory.gsc;
#using script_3e5ec44cfab7a201;
#using scripts\zm_common\zm_sq.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_lockdown_util.gsc;
#using scripts\zm_common\zm_items.gsc;
#using scripts\zm_common\zm_customgame.gsc;
#using scripts\zm_common\zm_crafting.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\aat_shared.gsc;

#namespace namespace_4a807bff;

/*
	Name: init
	Namespace: namespace_4a807bff
	Checksum: 0x75296E79
	Offset: 0x250
	Size: 0x714
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level.a_s_chests = struct::get_array(#"hash_396f65af88a25e7d");
	foreach(s_chest in level.a_s_chests)
	{
		s_chest chest_init();
		namespace_617a54f4::function_d8383812(s_chest.script_noteworthy, 1, s_chest, &function_62f0c1c, &function_32edfed);
	}
	if(zm_custom::function_901b751c(#"zmwonderweaponisenabled"))
	{
		zm_sq::register(#"hash_1222a3e832bad772", #"hash_2725edd09b4bb1b6", #"hash_13b316981d67e1ad", &step_1_setup, &step_1_cleanup);
		zm_sq::register(#"hash_1222a3e832bad772", #"hash_6cc4f52e0ed36f92", #"hash_13b313981d67dc94", &step_2_setup, &step_2_cleanup);
		zm_sq::register(#"hash_1222a3e832bad772", #"hash_575b4d3faca8bf2e", #"hash_13b314981d67de47", &step_3_setup, &step_3_cleanup);
		zm_sq::register(#"hash_1222a3e832bad772", #"hash_1d89a5560669ab60", #"hash_13b311981d67d92e", &step_4_setup, &step_4_cleanup);
		level flag::init(#"hash_1562cc6d96b2bc4");
		level flag::init(#"hash_635fa9d7a8be6607");
		level flag::init(#"hash_2889330d50a4cc38");
		level flag::init(#"hash_35ab49975b4cc894");
		level flag::init(#"hash_477e8ec5d0789334");
		callback::on_spawned(&function_58269323);
		level.var_1cf75f1d = getweapon(#"ww_tricannon_t8");
		zm_weapons::include_zombie_weapon(#"hash_41a492d8cc5893f9", 0);
		zm_weapons::add_zombie_weapon(#"hash_41a492d8cc5893f9", "", 0, 0, undefined, undefined, 0, "", "", 0, undefined, 0);
		level.n_kill_count = 0;
		level.var_3a67ac0e = array(#"hash_10d96c6e67b7604d", #"p7_compass_vintage", #"p7_world_globe_vintage_01", #"p7_ra2_tool_vintage_pincer_02", #"p7_zm_ori_scope_vintage");
		level.var_b26f906a = array(#"hash_6750f91495cec97a", #"hash_5cfcc1e6699e46b6", #"hash_6e6d2b3030f3d6c6", #"hash_6382fc1f3035ccb0", #"hash_76274c14299e46ca");
		level.var_e083ecbd = randomint(level.a_s_chests.size);
		level.var_f9f50915 = level.a_s_chests[level.var_e083ecbd];
		level.var_f9f50915 show_chest();
		level thread function_2c93a769();
		var_35da56ee = zm_crafting::function_b18074d0(#"hash_6f259b259997271a");
		if(isdefined(var_35da56ee))
		{
			var_35da56ee.var_99577dd3.var_62a98b13 = #"hash_4223e614aaaeb5be";
			var_35da56ee.var_670f9944.var_62a98b13 = #"condenser_coil";
			var_35da56ee.var_2e0a273a.var_62a98b13 = #"hash_d2d731e2804301b";
			var_35da56ee.var_99577dd3.var_25bb96cc = #"hash_604432f9a80a26e3";
			var_35da56ee.var_670f9944.var_25bb96cc = #"hash_604432f9a80a26e3";
			var_35da56ee.var_2e0a273a.var_25bb96cc = #"hash_604432f9a80a26e3";
		}
		util::delay("all_players_spawned", undefined, &function_d159d50e);
	}
	clientfield::register("scriptmover", "" + #"clue_fx", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"despawn_fx", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_1c8f8a5e03b36070", 1, 1, "int");
}

/*
	Name: function_d159d50e
	Namespace: namespace_4a807bff
	Checksum: 0x81B12203
	Offset: 0x970
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_d159d50e()
{
	zm_weapons::function_603af7a8(level.var_1cf75f1d);
	clientfield::set("" + #"hash_16cc25b3f87f06ad", 1);
}

/*
	Name: chest_init
	Namespace: namespace_4a807bff
	Checksum: 0x267BEBC
	Offset: 0x9C8
	Size: 0x52
	Parameters: 0
	Flags: Linked, Private
*/
function private chest_init()
{
	self.var_4f8a10d5 = getent(self.target, "targetname");
	self.s_chest = struct::get(self.target, "targetname");
}

/*
	Name: function_2c93a769
	Namespace: namespace_4a807bff
	Checksum: 0x5A048A2E
	Offset: 0xA28
	Size: 0x104
	Parameters: 0
	Flags: Linked, Private
*/
function private function_2c93a769()
{
	level waittill(#"all_players_spawned");
	a_e_players = getplayers();
	for(i = 0; i < a_e_players.size; i++)
	{
		level.var_a4674e38[i] = 0;
		a_e_players[i] thread function_707a3db7();
	}
	callback::on_connect(&function_707a3db7);
	zm_crafting::function_d1f16587(#"hash_6f259b259997271a", &function_8498110e);
	zm_sq::start(#"hash_1222a3e832bad772", 1);
}

/*
	Name: step_1_setup
	Namespace: namespace_4a807bff
	Checksum: 0xF65F1DBF
	Offset: 0xB38
	Size: 0x64
	Parameters: 1
	Flags: Linked, Private
*/
function private step_1_setup(var_a276c861)
{
	level endon(#"end_game");
	if(!var_a276c861)
	{
		callback::on_ai_spawned(&function_f7b0a02a);
		level waittill(#"hash_1562cc6d96b2bc4");
	}
}

/*
	Name: step_1_cleanup
	Namespace: namespace_4a807bff
	Checksum: 0x45054112
	Offset: 0xBA8
	Size: 0xCC
	Parameters: 2
	Flags: Linked, Private
*/
function private step_1_cleanup(var_a276c861, var_19e802fa)
{
	if(!var_a276c861)
	{
		callback::remove_on_ai_spawned(&function_f7b0a02a);
		if(var_19e802fa)
		{
			if(isdefined(level.var_86d6efbf))
			{
				level.var_86d6efbf delete();
				level.var_85a8dbba delete();
			}
			level flag::set(#"hash_1562cc6d96b2bc4");
		}
	}
	else
	{
		level flag::set(#"hash_1562cc6d96b2bc4");
	}
}

/*
	Name: function_f7b0a02a
	Namespace: namespace_4a807bff
	Checksum: 0xD822E86F
	Offset: 0xC80
	Size: 0x29C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_f7b0a02a()
{
	level endon(#"hash_1562cc6d96b2bc4", #"end_game");
	if(self.archetype == #"stoker")
	{
		waitresult = undefined;
		waitresult = self waittill(#"hash_4651621237a54fc7", #"death");
		if(waitresult._notify == #"hash_4651621237a54fc7")
		{
			if(!isdefined(level.var_86d6efbf))
			{
				level.var_86d6efbf = util::spawn_model(#"p8_zm_kraken_chest_key", self.origin + (0, 0, 32), self.angles);
				level.var_86d6efbf playsound(#"hash_1390af6222266716");
				level.var_86d6efbf playloopsound(#"hash_1f450c20e20a55c5", 2);
				level.var_85a8dbba = spawn("trigger_radius_use", level.var_86d6efbf.origin, 0, 72, 72);
				level.var_85a8dbba setcursorhint("HINT_NOICON");
				if(function_8b1a219a())
				{
					level.var_85a8dbba sethintstring(#"hash_448bba92cdb05ab3");
				}
				else
				{
					level.var_85a8dbba sethintstring(#"hash_6b3d148fe21d6acd");
				}
				level.var_85a8dbba triggerignoreteam();
				level.var_85a8dbba setvisibletoall();
				level thread function_a20e6e5d();
				level thread function_ca409b53();
			}
		}
	}
}

/*
	Name: function_a20e6e5d
	Namespace: namespace_4a807bff
	Checksum: 0xD4860428
	Offset: 0xF28
	Size: 0x144
	Parameters: 0
	Flags: Linked, Private
*/
function private function_a20e6e5d()
{
	level endon(#"hash_503e8bfd27a38f08", #"hash_1562cc6d96b2bc4", #"end_game");
	waitresult = undefined;
	waitresult = level.var_85a8dbba waittill(#"trigger");
	player = waitresult.activator;
	if(isdefined(player))
	{
		player playsound(#"hash_1560d47a810c72df");
		player util::delay(0.5, "death", &zm_audio::create_and_play_dialog, #"stoker_key", #"pick_up");
	}
	level.var_85a8dbba delete();
	level.var_86d6efbf delete();
	level flag::set(#"hash_1562cc6d96b2bc4");
}

/*
	Name: function_ca409b53
	Namespace: namespace_4a807bff
	Checksum: 0xCD2BB8E8
	Offset: 0x1078
	Size: 0x120
	Parameters: 0
	Flags: Linked, Private
*/
function private function_ca409b53()
{
	level endon(#"hash_1562cc6d96b2bc4", #"hash_1562cc6d96b2bc4", #"end_game");
	level.var_86d6efbf rotate((0, 360, 0));
	wait(15);
	level.var_86d6efbf zm_powerups::hide_and_show(&ghost, &show);
	level.var_86d6efbf playsound(#"hash_5a2daa895f64b2e2");
	level.var_85a8dbba delete();
	level.var_86d6efbf delete();
	level notify(#"hash_503e8bfd27a38f08");
}

/*
	Name: step_2_setup
	Namespace: namespace_4a807bff
	Checksum: 0xF0D97565
	Offset: 0x11A0
	Size: 0x114
	Parameters: 1
	Flags: Linked, Private
*/
function private step_2_setup(var_a276c861)
{
	level endon(#"end_game");
	if(!var_a276c861)
	{
		if(function_8b1a219a())
		{
			e_activator = level.var_f9f50915 zm_unitrigger::function_fac87205(#"hash_6895c9bbfcd8ff94", (64, 48, 72));
		}
		else
		{
			e_activator = level.var_f9f50915 zm_unitrigger::function_fac87205(#"hash_14651a427e1b9f98", (64, 48, 72));
		}
		if(isalive(e_activator))
		{
			e_activator zm_audio::create_and_play_dialog(#"treasure_chest", #"activate_1");
		}
	}
}

/*
	Name: step_2_cleanup
	Namespace: namespace_4a807bff
	Checksum: 0x82931BDC
	Offset: 0x12C0
	Size: 0x10C
	Parameters: 2
	Flags: Linked, Private
*/
function private step_2_cleanup(var_a276c861, var_19e802fa)
{
	if(!var_a276c861)
	{
		zm_unitrigger::unregister_unitrigger(level.var_f9f50915.s_unitrigger);
	}
	level.var_f9f50915.var_31919730 thread scene::play(#"p8_fxanim_zm_zod_kraken_chest_bundle", "open", level.var_f9f50915.var_31919730);
	level.var_f9f50915.var_31919730 playsound(#"hash_6fa6fc673cdcf645");
	level.var_f9f50915.var_31919730 playloopsound(#"hash_326fef81e2be51bb", 2);
	level flag::set(#"hash_635fa9d7a8be6607");
}

/*
	Name: step_3_setup
	Namespace: namespace_4a807bff
	Checksum: 0x3B5389B0
	Offset: 0x13D8
	Size: 0x304
	Parameters: 1
	Flags: Linked, Private
*/
function private step_3_setup(var_a276c861)
{
	level endon(#"end_game");
	if(!var_a276c861)
	{
		level.var_e2ce1fe1 = 0;
		while(level.var_e2ce1fe1 < 3)
		{
			function_887ad605();
			namespace_617a54f4::function_3f808d3d(level.var_f9f50915.script_noteworthy);
			level waittill(#"hash_17332cf9062484a6");
			namespace_617a54f4::function_2a94055d(level.var_f9f50915.script_noteworthy);
			wait(1);
			level.var_f9f50915.var_31919730 stoploopsound(1);
			level.var_f9f50915.var_31919730 thread scene::play(#"p8_fxanim_zm_zod_kraken_chest_bundle", "close", level.var_f9f50915.var_31919730);
			wait(3);
			playfx(#"hash_6c0eb029adb5f6c6", level.var_f9f50915.var_31919730.origin);
			if(level.var_e2ce1fe1 < 2)
			{
				level.var_f9f50915.var_31919730 delete();
				arrayremoveindex(level.a_s_chests, level.var_e083ecbd);
				level.var_e083ecbd = randomint(level.a_s_chests.size);
				level.var_f9f50915 = level.a_s_chests[level.var_e083ecbd];
				level.var_f9f50915 show_chest();
				level.var_f9f50915.var_31919730 thread scene::play(#"p8_fxanim_zm_zod_kraken_chest_bundle", "open", level.var_f9f50915.var_31919730);
				level.var_f9f50915.var_31919730 playsound(#"hash_6fa6fc673cdcf645");
				level.var_f9f50915.var_31919730 playloopsound(#"hash_326fef81e2be51bb", 2);
				/#
					iprintlnbold("");
				#/
			}
			level.var_e2ce1fe1++;
		}
	}
}

/*
	Name: step_3_cleanup
	Namespace: namespace_4a807bff
	Checksum: 0x423EB647
	Offset: 0x16E8
	Size: 0x1B0
	Parameters: 2
	Flags: Linked, Private
*/
function private step_3_cleanup(var_a276c861, var_19e802fa)
{
	if(var_19e802fa)
	{
		namespace_617a54f4::function_2a94055d(level.var_f9f50915.script_noteworthy);
	}
	level.var_2e2dab8d = randomint(level.var_b26f906a.size);
	level.var_f3abf34a = struct::get(level.var_b26f906a[level.var_2e2dab8d]);
	level.var_f9f50915 thread function_a8fff4b0();
	/#
		iprintlnbold("");
	#/
	var_31998302 = getentarray("kraken_cleanup", "script_noteworthy");
	var_24402eb8 = getent(level.var_f3abf34a.target, "targetname");
	foreach(ent in var_31998302)
	{
		if(ent !== var_24402eb8)
		{
			ent delete();
		}
	}
}

/*
	Name: function_887ad605
	Namespace: namespace_4a807bff
	Checksum: 0xE7A05F33
	Offset: 0x18A0
	Size: 0x142
	Parameters: 0
	Flags: Linked, Private
*/
function private function_887ad605()
{
	a_e_players = getplayers();
	switch(a_e_players.size)
	{
		case 1:
		{
			level.var_5c0c2f5a = 10;
			level.var_1626d02a = 20;
			level.var_e5afa71 = 30;
			break;
		}
		case 2:
		{
			level.var_5c0c2f5a = 11;
			level.var_1626d02a = 22;
			level.var_e5afa71 = 33;
			break;
		}
		case 3:
		{
			level.var_5c0c2f5a = 13;
			level.var_1626d02a = 26;
			level.var_e5afa71 = 40;
			break;
		}
		case 4:
		{
			level.var_5c0c2f5a = 15;
			level.var_1626d02a = 31;
			level.var_e5afa71 = 46;
			break;
		}
	}
}

/*
	Name: function_62f0c1c
	Namespace: namespace_4a807bff
	Checksum: 0x731B6A1E
	Offset: 0x19F0
	Size: 0x42
	Parameters: 2
	Flags: Linked, Private
*/
function private function_62f0c1c(s_struct, ai_killed)
{
	if(ai_killed istouching(s_struct.var_4f8a10d5))
	{
		return true;
	}
	return false;
}

/*
	Name: function_32edfed
	Namespace: namespace_4a807bff
	Checksum: 0xF2BE20B8
	Offset: 0x1A40
	Size: 0x16C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_32edfed(s_struct, ai_killed)
{
	level.n_kill_count++;
	if(level.var_e2ce1fe1 == 0 && level.n_kill_count >= level.var_5c0c2f5a || (level.var_e2ce1fe1 == 1 && level.n_kill_count >= level.var_1626d02a) || (level.var_e2ce1fe1 == 2 && level.n_kill_count >= level.var_e5afa71))
	{
		level.n_kill_count = 0;
		level notify(#"hash_17332cf9062484a6");
	}
	if(!(isdefined(level.var_f9f50915.b_vo_played) && level.var_f9f50915.b_vo_played))
	{
		if(level.var_e2ce1fe1 == 1)
		{
			var_39acfdda = #"activate_2";
		}
		else
		{
			if(level.var_e2ce1fe1 == 2)
			{
				var_39acfdda = #"activate_3";
			}
			else
			{
				return;
			}
		}
		level thread function_9eba13c0(var_39acfdda);
	}
}

/*
	Name: function_9eba13c0
	Namespace: namespace_4a807bff
	Checksum: 0xD357308
	Offset: 0x1BB8
	Size: 0xFE
	Parameters: 1
	Flags: Linked
*/
function function_9eba13c0(var_39acfdda)
{
	foreach(player in util::get_array_of_closest(level.var_f9f50915.origin, util::get_active_players(), undefined, undefined, 512))
	{
		b_result = player zm_audio::create_and_play_dialog(#"treasure_chest", var_39acfdda);
		if(isdefined(b_result) && b_result)
		{
			level.var_f9f50915.b_vo_played = 1;
			break;
		}
	}
}

/*
	Name: step_4_setup
	Namespace: namespace_4a807bff
	Checksum: 0xB4E5C2F3
	Offset: 0x1CC0
	Size: 0xC4
	Parameters: 1
	Flags: Linked, Private
*/
function private step_4_setup(var_a276c861)
{
	level endon(#"end_game");
	if(!var_a276c861)
	{
		array::run_all(util::get_active_players(), &forcestreambundle, #"p8_fxanim_zm_zod_tentacle_bundle");
		trigger::wait_till(level.var_f3abf34a.target);
		getent(level.var_f3abf34a.target, "targetname") delete();
	}
}

/*
	Name: step_4_cleanup
	Namespace: namespace_4a807bff
	Checksum: 0xA113C1E3
	Offset: 0x1D90
	Size: 0x13C
	Parameters: 2
	Flags: Linked, Private
*/
function private step_4_cleanup(var_a276c861, var_19e802fa)
{
	scene::add_scene_func(#"p8_fxanim_zm_zod_tentacle_bundle", &spawn_tricannon);
	scene::add_scene_func(#"p8_fxanim_zm_zod_tentacle_bundle", &function_d3351bf7, "done");
	level scene::play(level.var_f3abf34a.target, "targetname");
	scene::remove_scene_func(#"p8_fxanim_zm_zod_tentacle_bundle", &spawn_tricannon);
	level flag::set(#"hash_35ab49975b4cc894");
	array::run_all(util::get_active_players(), &function_66b6e720, #"p8_fxanim_zm_zod_tentacle_bundle");
}

/*
	Name: function_d3351bf7
	Namespace: namespace_4a807bff
	Checksum: 0x18940070
	Offset: 0x1ED8
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function function_d3351bf7(a_ents)
{
	wait(5);
	if(isdefined(a_ents[#"kraken_tentacle"]))
	{
		a_ents[#"kraken_tentacle"] delete();
	}
	scene::remove_scene_func(#"p8_fxanim_zm_zod_tentacle_bundle", &function_d3351bf7, "done");
}

/*
	Name: function_a8fff4b0
	Namespace: namespace_4a807bff
	Checksum: 0xDDC8D8FB
	Offset: 0x1F70
	Size: 0x2A4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_a8fff4b0()
{
	level endon(#"end_game");
	self.var_31919730 thread scene::play(#"p8_fxanim_zm_zod_kraken_chest_bundle", "close", self.var_31919730);
	wait(3);
	v_offset = anglestoup(self.var_31919730.angles) * 26;
	var_5792d83f = util::spawn_model(level.var_3a67ac0e[level.var_2e2dab8d], self.var_31919730.origin + v_offset, self.var_31919730.angles);
	if(level.var_3a67ac0e[level.var_2e2dab8d] == #"p7_compass_vintage")
	{
		var_5792d83f setscale(2);
	}
	var_5792d83f rotate(vectorscale((0, 1, 0), 22));
	var_5792d83f clientfield::set("" + #"clue_fx", 1);
	self.var_31919730 thread scene::play(#"p8_fxanim_zm_zod_kraken_chest_bundle", "open", self.var_31919730);
	level flag::wait_till(#"hash_2889330d50a4cc38");
	self.var_31919730 thread scene::play(#"p8_fxanim_zm_zod_kraken_chest_bundle", "close", self.var_31919730);
	wait(3);
	playfx(#"hash_6c0eb029adb5f6c6", level.var_f9f50915.var_31919730.origin);
	var_5792d83f delete();
	self.var_31919730 delete();
	self struct::delete();
}

/*
	Name: spawn_tricannon
	Namespace: namespace_4a807bff
	Checksum: 0x2217B79C
	Offset: 0x2220
	Size: 0x1E4
	Parameters: 1
	Flags: Linked, Private
*/
function private spawn_tricannon(a_ents)
{
	if(self.targetname !== #"offering_scene")
	{
		exploder::exploder(level.var_f3abf34a.str_exploder);
		var_c238080c = a_ents[#"hash_3712f07fe0e1166c"];
		var_c238080c clientfield::set("" + #"despawn_fx", 1);
		var_c238080c waittill(#"kraken_dropped");
		var_c238080c playsound(#"hash_70efc268d0becb47");
		var_c238080c playloopsound(#"hash_61486fb02b77eed8", 2);
		s_unitrigger = level.var_f3abf34a zm_unitrigger::create(&function_10d4ff8d, (64, 64, 72), &function_e0fe80db);
		level waittill(#"hash_2889330d50a4cc38");
		exploder::stop_exploder(level.var_f3abf34a.str_exploder);
		zm_unitrigger::unregister_unitrigger(s_unitrigger);
		var_c238080c stoploopsound(0.5);
		var_c238080c delete();
	}
}

/*
	Name: function_10d4ff8d
	Namespace: namespace_4a807bff
	Checksum: 0xAC135562
	Offset: 0x2410
	Size: 0xC6
	Parameters: 1
	Flags: Linked, Private
*/
function private function_10d4ff8d(e_player)
{
	level endon(#"hash_2889330d50a4cc38", #"end_game");
	if(function_e796525(e_player))
	{
		self setvisibletoplayer(e_player);
		self setcursorhint("HINT_WEAPON", level.var_1cf75f1d);
		self sethintstring(#"hash_6a4c5538a960189d");
		return true;
	}
	self setinvisibletoplayer(e_player);
	return false;
}

/*
	Name: function_e0fe80db
	Namespace: namespace_4a807bff
	Checksum: 0xD2CF6399
	Offset: 0x24E0
	Size: 0x13C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_e0fe80db()
{
	level endon(#"end_game", #"hash_2889330d50a4cc38");
	self endon(#"kill_trigger");
	waitresult = undefined;
	waitresult = self waittill(#"trigger");
	while(!function_557328cc(waitresult))
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
	}
	if(!level flag::get(#"hash_2889330d50a4cc38"))
	{
		waitresult.activator giveweapon(level.var_1cf75f1d);
		waitresult.activator zm_audio::create_and_play_dialog("magicbox", "wonder");
		level flag::set(#"hash_2889330d50a4cc38");
	}
}

/*
	Name: function_557328cc
	Namespace: namespace_4a807bff
	Checksum: 0xF15317E4
	Offset: 0x2628
	Size: 0x38
	Parameters: 1
	Flags: Linked, Private
*/
function private function_557328cc(waitresult)
{
	if(function_e796525(waitresult.activator))
	{
		return true;
	}
	waitframe(1);
	return false;
}

/*
	Name: function_e796525
	Namespace: namespace_4a807bff
	Checksum: 0x9D1CCE
	Offset: 0x2670
	Size: 0x74
	Parameters: 1
	Flags: Linked, Private
*/
function private function_e796525(e_player)
{
	if(!zm_utility::is_player_valid(e_player, 0, 1) || !zm_utility::can_use(e_player, 1) || e_player function_d37acf8a())
	{
		return false;
	}
	return true;
}

/*
	Name: function_707a3db7
	Namespace: namespace_4a807bff
	Checksum: 0x103AD4E9
	Offset: 0x26F0
	Size: 0x11C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_707a3db7()
{
	level endon(#"end_game", #"hash_477e8ec5d0789334");
	self endon(#"disconnect");
	waitresult = undefined;
	waitresult = self waittill(#"weapon_change");
	while(waitresult.weapon != level.var_1cf75f1d)
	{
		waitresult = undefined;
		waitresult = self waittill(#"weapon_change");
	}
	if(!isdefined(level.var_ab242e52))
	{
		level.var_ab242e52 = 0;
	}
	callback::on_ai_killed(&function_f4a7fd49);
	callback::remove_on_connect(&function_707a3db7);
	level flag::set(#"hash_477e8ec5d0789334");
}

/*
	Name: function_8498110e
	Namespace: namespace_4a807bff
	Checksum: 0x614EBF01
	Offset: 0x2818
	Size: 0x11C
	Parameters: 1
	Flags: Linked
*/
function function_8498110e(e_player)
{
	if(isalive(e_player))
	{
		e_player zm_audio::create_and_play_dialog(#"hash_26a9f2114c4dc662", #"build");
	}
	s_table = struct::get(#"hash_6b46b9c1dd7e1bb");
	s_unitrigger = s_table zm_unitrigger::create(&registerblinkingshouldshowpain, 64, &function_ae6c3cf2, 1);
	zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger, 1);
	zm_lockdown_util::function_d67bafb5(s_unitrigger, "lockdown_stub_type_crafting_tables");
	level thread zm_crafting::function_ca244624(#"hash_6f259b259997271a");
}

/*
	Name: registerblinkingshouldshowpain
	Namespace: namespace_4a807bff
	Checksum: 0x1FACCE61
	Offset: 0x2940
	Size: 0x966
	Parameters: 1
	Flags: Linked, Private
*/
function private registerblinkingshouldshowpain(e_player)
{
	if(zm_trial_disable_buys::is_active())
	{
		self sethintstring(#"hash_55d25caf8f7bbb2f");
		return true;
	}
	var_9102824b = e_player function_8f59b576();
	if(e_player zm_utility::is_player_looking_at(self.origin, 0.5, 0) && isdefined(e_player.var_b6ddf07f) && e_player.var_b6ddf07f != "" && isdefined(var_9102824b))
	{
		n_cost = function_9b8016f1(var_9102824b);
		switch(e_player.var_b6ddf07f)
		{
			case "decay":
			{
				if(var_9102824b.name == #"ww_tricannon_earth_t8" || var_9102824b.name == #"ww_tricannon_earth_t8_upgraded")
				{
					if(zm_utility::is_standard())
					{
						if(function_8b1a219a())
						{
							self sethintstring(#"hash_1349c5305046946d");
						}
						else
						{
							self sethintstring(#"hash_7a93670a32eaa8cf");
						}
					}
					else
					{
						if(function_8b1a219a())
						{
							self sethintstring(#"hash_7f12bb33e3e10d68", n_cost);
						}
						else
						{
							self sethintstring(#"hash_523a7a63472e8204", n_cost);
						}
					}
				}
				else
				{
					if(zm_utility::is_standard())
					{
						if(function_8b1a219a())
						{
							self sethintstring(#"hash_229651b097292334");
						}
						else
						{
							self sethintstring(#"hash_46ac72784c5bf3f8");
						}
					}
					else
					{
						if(function_8b1a219a())
						{
							self sethintstring(#"hash_8235259468a1297", n_cost);
						}
						else
						{
							self sethintstring(#"hash_353f3ec1f4fa0109", n_cost);
						}
					}
				}
				break;
			}
			case "plasma":
			{
				if(var_9102824b.name == #"ww_tricannon_fire_t8" || var_9102824b.name == #"ww_tricannon_fire_t8_upgraded")
				{
					if(zm_utility::is_standard())
					{
						if(function_8b1a219a())
						{
							self sethintstring(#"hash_641a4f757e565e1");
						}
						else
						{
							self sethintstring(#"hash_2b3bb217a51771eb");
						}
					}
					else
					{
						if(function_8b1a219a())
						{
							self sethintstring(#"hash_54eb3433c7a64784", n_cost);
						}
						else
						{
							self sethintstring(#"hash_eb05b70f6927e88", n_cost);
						}
					}
				}
				else
				{
					if(zm_utility::is_standard())
					{
						if(function_8b1a219a())
						{
							self sethintstring(#"hash_d2cd93392e5a52e");
						}
						else
						{
							self sethintstring(#"hash_537338a5d8fb2aea");
						}
					}
					else
					{
						if(function_8b1a219a())
						{
							self sethintstring(#"hash_43dec5d78cfbe549", n_cost);
						}
						else
						{
							self sethintstring(#"hash_739ddf7e1e7126a3", n_cost);
						}
					}
				}
				break;
			}
			case "purity":
			{
				if(var_9102824b.name == #"ww_tricannon_water_t8" || var_9102824b.name == #"ww_tricannon_water_t8_upgraded")
				{
					if(zm_utility::is_standard())
					{
						if(function_8b1a219a())
						{
							self sethintstring(#"hash_6734cd1a9daa86ee");
						}
						else
						{
							self sethintstring(#"hash_1d35ea46da22acaa");
						}
					}
					else
					{
						if(function_8b1a219a())
						{
							self sethintstring(#"hash_6ee35e51741fd209", n_cost);
						}
						else
						{
							self sethintstring(#"hash_34dfed25a796d563", n_cost);
						}
					}
				}
				else
				{
					if(zm_utility::is_standard())
					{
						if(function_8b1a219a())
						{
							self sethintstring(#"hash_12b10b6908407b3d");
						}
						else
						{
							self sethintstring(#"hash_7217a104b05f83df");
						}
					}
					else
					{
						if(function_8b1a219a())
						{
							self sethintstring(#"hash_51f6634f54cd9d8", n_cost);
						}
						else
						{
							self sethintstring(#"hash_126fd9abaad51c74", n_cost);
						}
					}
				}
				break;
			}
			case "radiance":
			{
				if(var_9102824b.name == #"ww_tricannon_air_t8" || var_9102824b.name == #"ww_tricannon_air_t8_upgraded")
				{
					if(zm_utility::is_standard())
					{
						if(function_8b1a219a())
						{
							self sethintstring(#"hash_609587f477ef819e");
						}
						else
						{
							self sethintstring(#"hash_2b4ea12debb30fda");
						}
					}
					else
					{
						if(function_8b1a219a())
						{
							self sethintstring(#"hash_5f150c9714252dd9", n_cost);
						}
						else
						{
							self sethintstring(#"hash_7028ec2236ab3e73", n_cost);
						}
					}
				}
				else
				{
					if(zm_utility::is_standard())
					{
						if(function_8b1a219a())
						{
							self sethintstring(#"hash_46d9122da1e5c931");
						}
						else
						{
							self sethintstring(#"hash_3427b86de4fb527b");
						}
					}
					else
					{
						if(function_8b1a219a())
						{
							self sethintstring(#"hash_4b7df23eb95b68f4", n_cost);
						}
						else
						{
							self sethintstring(#"hash_3576a4d9b2baf4b8", n_cost);
						}
					}
				}
				break;
			}
		}
		return true;
	}
	self sethintstring("");
	return false;
}

/*
	Name: function_9b8016f1
	Namespace: namespace_4a807bff
	Checksum: 0x40F4ABD3
	Offset: 0x32B0
	Size: 0x34
	Parameters: 1
	Flags: Linked, Private
*/
function private function_9b8016f1(var_9102824b)
{
	if(function_81d8403b(var_9102824b))
	{
		return 6000;
	}
	return 3000;
}

/*
	Name: function_ae6c3cf2
	Namespace: namespace_4a807bff
	Checksum: 0x77FEF66A
	Offset: 0x32F0
	Size: 0x130
	Parameters: 0
	Flags: Linked
*/
function function_ae6c3cf2()
{
	level endon(#"end_game");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		user = waitresult.activator;
		if(zm_trial_disable_buys::is_active())
		{
			continue;
		}
		if(!zm_utility::can_use(user))
		{
			continue;
		}
		if(!zm_utility::is_player_valid(user))
		{
			continue;
		}
		w_tricannon = user function_8f59b576();
		if(!isdefined(w_tricannon))
		{
			continue;
		}
		n_cost = function_9b8016f1(w_tricannon);
		if(user zm_score::can_player_purchase(n_cost))
		{
			level thread function_e00eae6(user);
			user zm_score::minus_to_player_score(n_cost);
		}
	}
}

/*
	Name: function_e00eae6
	Namespace: namespace_4a807bff
	Checksum: 0x259970A2
	Offset: 0x3428
	Size: 0x26E
	Parameters: 1
	Flags: Linked, Private
*/
function private function_e00eae6(e_player)
{
	var_9102824b = e_player function_8f59b576();
	if(isdefined(var_9102824b))
	{
		e_player takeweapon(var_9102824b);
		switch(e_player.var_b6ddf07f)
		{
			case "decay":
			{
				var_be9badbc = #"ww_tricannon_earth_t8";
				var_73d97896 = 2;
				break;
			}
			case "plasma":
			{
				var_be9badbc = #"ww_tricannon_fire_t8";
				var_73d97896 = 3;
				break;
			}
			case "purity":
			{
				var_be9badbc = #"ww_tricannon_water_t8";
				var_73d97896 = 1;
				break;
			}
			case "radiance":
			{
				var_be9badbc = #"ww_tricannon_air_t8";
				var_73d97896 = 4;
				break;
			}
			default:
			{
				/#
					assert(0, "");
				#/
				var_be9badbc = #"ww_tricannon_t8";
				break;
			}
		}
		if(function_81d8403b(var_9102824b))
		{
			var_be9badbc = var_be9badbc + "_upgraded";
		}
		w_weapon = getweapon(var_be9badbc);
		e_player giveweapon(w_weapon);
		e_player function_58269323();
		if(!isdefined(e_player.var_b01de37))
		{
			e_player.var_b01de37 = [];
		}
		else if(!isarray(e_player.var_b01de37))
		{
			e_player.var_b01de37 = array(e_player.var_b01de37);
		}
		e_player.var_b01de37[w_weapon] = var_73d97896;
	}
}

/*
	Name: function_f4a7fd49
	Namespace: namespace_4a807bff
	Checksum: 0x3F1BE715
	Offset: 0x36A0
	Size: 0x20A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_f4a7fd49(params)
{
	level endon(#"end_game");
	if(self.archetype == #"catalyst")
	{
		if(is_tricannon(params.weapon))
		{
			if(level.var_ab242e52 < 4 && randomint(100) <= 50)
			{
				level.var_ab242e52++;
				switch(self.catalyst_type)
				{
					case 1:
					{
						level function_4facba35(#"concentrated_decay", self.origin, self getcentroid());
						break;
					}
					case 3:
					{
						level function_4facba35(#"concentrated_radiance", self.origin, self getcentroid());
						break;
					}
					case 2:
					{
						level function_4facba35(#"concentrated_plasma", self.origin, self getcentroid());
						break;
					}
					case 4:
					{
						level function_4facba35(#"concentrated_purity", self.origin, self getcentroid());
						break;
					}
					default:
					{
						break;
					}
				}
			}
		}
	}
}

/*
	Name: function_4facba35
	Namespace: namespace_4a807bff
	Checksum: 0xD175B737
	Offset: 0x38B8
	Size: 0x38C
	Parameters: 3
	Flags: Linked, Private
*/
function private function_4facba35(var_ab02aaca, v_origin, v_spawn)
{
	var_abf1e2f7 = util::spawn_model("tag_origin", v_spawn);
	var_abf1e2f7 notsolid();
	var_a071ccba = spawn("trigger_radius_use", v_origin + vectorscale((0, 0, 1), 32), 0, 64, 72);
	var_a071ccba setcursorhint("HINT_NOICON");
	switch(var_ab02aaca)
	{
		case "concentrated_decay":
		{
			str_prompt = zm_utility::function_d6046228(#"hash_1fe854f6441b337e", #"hash_1b7e2d2bbc1de36a");
			var_a071ccba sethintstring(str_prompt);
			var_abf1e2f7 setmodel(#"c_t8_zmb_concentrated_catalyst_heart");
			v_origin = v_origin + vectorscale((0, 0, 1), 5);
			break;
		}
		case "concentrated_plasma":
		{
			str_prompt = zm_utility::function_d6046228(#"hash_1da4ec6fc5b6b9e6", #"hash_2eb14d935f8e39c2");
			var_a071ccba sethintstring(str_prompt);
			var_abf1e2f7 setmodel(#"c_t8_zmb_concentrated_catalyst_skull");
			break;
		}
		case "concentrated_purity":
		{
			str_prompt = zm_utility::function_d6046228(#"hash_7ee0d1946efa3d21", #"hash_669c0c5deaada19f");
			var_a071ccba sethintstring(str_prompt);
			var_abf1e2f7 setmodel(#"c_t8_zmb_concentrated_catalyst_foot");
			break;
		}
		case "concentrated_radiance":
		{
			str_prompt = zm_utility::function_d6046228(#"hash_1b1948d30c6b8ec9", #"hash_29b72f36c8ee8557");
			var_a071ccba sethintstring(str_prompt);
			var_abf1e2f7 setmodel(#"c_t8_zmb_concentrated_catalyst_hand");
			break;
		}
	}
	var_abf1e2f7 thread function_7edbaf3a(v_origin);
	var_a071ccba triggerignoreteam();
	var_a071ccba setvisibletoall();
	var_a071ccba.var_abf1e2f7 = var_abf1e2f7;
	var_a071ccba.var_ab02aaca = var_ab02aaca;
	level thread function_3ef485b1(var_a071ccba);
	level thread function_74df2b21(var_a071ccba);
}

/*
	Name: function_3ef485b1
	Namespace: namespace_4a807bff
	Checksum: 0x5A087A58
	Offset: 0x3C50
	Size: 0x18C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_3ef485b1(t_trig)
{
	level endon(#"end_game");
	t_trig endon(#"hash_cf18f85af2935e8");
	waitresult = undefined;
	waitresult = t_trig waittill(#"trigger");
	e_player = waitresult.activator;
	switch(t_trig.var_ab02aaca)
	{
		case "concentrated_decay":
		{
			function_ca37502d(e_player);
			break;
		}
		case "concentrated_plasma":
		{
			function_1b182e8c(e_player);
			break;
		}
		case "concentrated_purity":
		{
			function_b9b7b8c(e_player);
			break;
		}
		case "concentrated_radiance":
		{
			function_b3695700(e_player);
			break;
		}
	}
	level.var_ab242e52--;
	t_trig notify(#"picked_up");
	t_trig.var_abf1e2f7 delete();
	t_trig delete();
}

/*
	Name: function_74df2b21
	Namespace: namespace_4a807bff
	Checksum: 0x5DFB1215
	Offset: 0x3DE8
	Size: 0x9C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_74df2b21(t_trig)
{
	level endon(#"end_game");
	t_trig endon(#"picked_up");
	wait(30);
	level.var_ab242e52--;
	t_trig notify(#"hash_cf18f85af2935e8");
	t_trig.var_abf1e2f7 delete();
	t_trig delete();
}

/*
	Name: function_7edbaf3a
	Namespace: namespace_4a807bff
	Checksum: 0x4F6F73A8
	Offset: 0x3E90
	Size: 0x26A
	Parameters: 1
	Flags: Linked
*/
function function_7edbaf3a(v_origin)
{
	self endon(#"death");
	self moveto(v_origin + (0, 0, 1), 0.5, 0.4);
	self waittill(#"movedone");
	self clientfield::set("" + #"hash_1c8f8a5e03b36070", 1);
	wait(randomfloat(2));
	n_wait = 3;
	while(true)
	{
		wait(n_wait);
		n_move_x = randomfloatrange(0.1, 0.5);
		var_a6fa9fe7 = randomfloatrange(0.1, 0.5);
		var_ac28398c = randomintrange(-180, 180);
		self moveto(self.origin + (n_move_x, var_a6fa9fe7, 0), 0.15);
		self rotatevelocity((0, var_ac28398c, 0), 0.15);
		self waittill(#"movedone");
		wait(0.25);
		var_ac28398c = randomintrange(-180, 180);
		self moveto(self.origin - (n_move_x, var_a6fa9fe7, 0), 0.15);
		self rotatevelocity((0, var_ac28398c, 0), 0.15);
		self waittill(#"movedone");
		n_wait = max(0.25, n_wait - 0.25);
	}
}

/*
	Name: function_ca37502d
	Namespace: namespace_4a807bff
	Checksum: 0x5FA2DB31
	Offset: 0x4108
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_ca37502d(e_player)
{
	e_player zm_audio::create_and_play_dialog(#"pickup_catalyst", #"decay");
	e_player.var_b6ddf07f = #"decay";
	zm_ui_inventory::function_7df6bb60("zm_zodt8_conc_catalyst", 1, e_player);
}

/*
	Name: function_1b182e8c
	Namespace: namespace_4a807bff
	Checksum: 0xF3911AB3
	Offset: 0x4188
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_1b182e8c(e_player)
{
	e_player zm_audio::create_and_play_dialog(#"pickup_catalyst", #"plasma");
	e_player.var_b6ddf07f = #"plasma";
	zm_ui_inventory::function_7df6bb60("zm_zodt8_conc_catalyst", 2, e_player);
}

/*
	Name: function_b9b7b8c
	Namespace: namespace_4a807bff
	Checksum: 0xB7DDDBC0
	Offset: 0x4208
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_b9b7b8c(e_player)
{
	e_player zm_audio::create_and_play_dialog(#"pickup_catalyst", #"purity");
	e_player.var_b6ddf07f = #"purity";
	zm_ui_inventory::function_7df6bb60("zm_zodt8_conc_catalyst", 4, e_player);
}

/*
	Name: function_b3695700
	Namespace: namespace_4a807bff
	Checksum: 0x41EF8F34
	Offset: 0x4288
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_b3695700(e_player)
{
	e_player zm_audio::create_and_play_dialog(#"pickup_catalyst", #"radiance");
	e_player.var_b6ddf07f = #"radiance";
	zm_ui_inventory::function_7df6bb60("zm_zodt8_conc_catalyst", 3, e_player);
}

/*
	Name: function_58269323
	Namespace: namespace_4a807bff
	Checksum: 0x950476FA
	Offset: 0x4308
	Size: 0x2C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_58269323()
{
	self.var_b6ddf07f = "";
	zm_ui_inventory::function_7df6bb60("zm_zodt8_conc_catalyst", 0, self);
}

/*
	Name: show_chest
	Namespace: namespace_4a807bff
	Checksum: 0xFCADA2F3
	Offset: 0x4340
	Size: 0x74
	Parameters: 0
	Flags: Linked, Private
*/
function private show_chest()
{
	if(!isdefined(self.var_31919730))
	{
		self.var_31919730 = util::spawn_model(#"p8_fxanim_zm_zod_kraken_chest_mod", self.s_chest.origin, self.s_chest.angles);
	}
	else
	{
		self.var_31919730 show();
	}
}

/*
	Name: function_d37acf8a
	Namespace: namespace_4a807bff
	Checksum: 0xD7BE97E9
	Offset: 0x43C0
	Size: 0x148
	Parameters: 0
	Flags: Linked, Private
*/
function private function_d37acf8a()
{
	a_weapons = self getweaponslistprimaries();
	foreach(weapon in a_weapons)
	{
		switch(weapon.name)
		{
			case "ww_tricannon_fire_t8":
			case "ww_tricannon_earth_t8":
			case "ww_tricannon_t8_upgraded":
			case "ww_tricannon_air_t8_upgraded":
			case "ww_tricannon_earth_t8_upgraded":
			case "ww_tricannon_fire_t8_upgraded":
			case "ww_tricannon_water_t8_upgraded":
			case "ww_tricannon_water_t8":
			case "ww_tricannon_t8":
			case "ww_tricannon_air_t8":
			{
				return true;
			}
		}
	}
	return false;
}

/*
	Name: function_8f59b576
	Namespace: namespace_4a807bff
	Checksum: 0xC3879CD2
	Offset: 0x4510
	Size: 0x148
	Parameters: 0
	Flags: Linked, Private
*/
function private function_8f59b576()
{
	a_weapons = self getweaponslistprimaries();
	foreach(weapon in a_weapons)
	{
		switch(weapon.name)
		{
			case "ww_tricannon_fire_t8":
			case "ww_tricannon_earth_t8":
			case "ww_tricannon_t8_upgraded":
			case "ww_tricannon_air_t8_upgraded":
			case "ww_tricannon_earth_t8_upgraded":
			case "ww_tricannon_fire_t8_upgraded":
			case "ww_tricannon_water_t8_upgraded":
			case "ww_tricannon_water_t8":
			case "ww_tricannon_t8":
			case "ww_tricannon_air_t8":
			{
				return weapon;
			}
		}
	}
	return undefined;
}

/*
	Name: is_tricannon
	Namespace: namespace_4a807bff
	Checksum: 0x4CFE898D
	Offset: 0x4660
	Size: 0x102
	Parameters: 1
	Flags: Linked, Private
*/
function private is_tricannon(weapon)
{
	if(isdefined(weapon) && isdefined(weapon.name))
	{
		switch(weapon.name)
		{
			case "ww_tricannon_fire_t8":
			case "ww_tricannon_earth_t8":
			case "ww_tricannon_t8_upgraded":
			case "ww_tricannon_air_t8_upgraded":
			case "ww_tricannon_earth_t8_upgraded":
			case "ww_tricannon_fire_t8_upgraded":
			case "ww_tricannon_water_t8_upgraded":
			case "ww_tricannon_water_t8":
			case "ww_tricannon_t8":
			case "ww_tricannon_air_t8":
			{
				return true;
			}
			default:
			{
				return false;
			}
		}
	}
	else
	{
		return false;
	}
}

/*
	Name: function_81d8403b
	Namespace: namespace_4a807bff
	Checksum: 0x44E304E5
	Offset: 0x4770
	Size: 0xB2
	Parameters: 1
	Flags: Linked, Private
*/
function private function_81d8403b(weapon)
{
	if(isdefined(weapon) && isdefined(weapon.name))
	{
		switch(weapon.name)
		{
			case "ww_tricannon_t8_upgraded":
			case "ww_tricannon_air_t8_upgraded":
			case "ww_tricannon_earth_t8_upgraded":
			case "ww_tricannon_fire_t8_upgraded":
			case "ww_tricannon_water_t8_upgraded":
			{
				return true;
			}
			default:
			{
				return false;
			}
		}
	}
	else
	{
		return false;
	}
}

