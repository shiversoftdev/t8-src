// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_3cebb48c37fc271;
#using script_3f9e0dc8454d98e1;
#using script_4d000493c57bb851;
#using script_4d19f534445a8ad;
#using script_6c5b51f98cd04fa3;
#using script_6e3c826b1814cab6;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\fx_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\zm\zm_zodt8.gsc;
#using scripts\zm\zm_zodt8_pap_quest.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_magicbox.gsc;
#using scripts\zm_common\zm_melee_weapon.gsc;
#using scripts\zm_common\zm_pack_a_punch_util.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_b45e3f05;

/*
	Name: init
	Namespace: namespace_b45e3f05
	Checksum: 0x562462F6
	Offset: 0x5F0
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function init()
{
	init_fx();
	init_clientfields();
	init_flags();
	function_ec9e5cf2();
	level thread function_c62198dc();
	getent("portal_block", "targetname") hide();
	if(zm_utility::function_e51dc2d8())
	{
		level.var_932a1afb = &function_9693e041;
	}
	level thread function_5beff312();
	level thread function_4f4e423f();
	level thread function_b9b8f31d();
}

/*
	Name: init_fx
	Namespace: namespace_b45e3f05
	Checksum: 0x80F724D1
	Offset: 0x6F8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function init_fx()
{
}

/*
	Name: init_clientfields
	Namespace: namespace_b45e3f05
	Checksum: 0x1E29FFA7
	Offset: 0x708
	Size: 0x384
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("allplayers", "" + #"hash_2c387ea19f228b5d", 1, 1, "int");
	clientfield::register("allplayers", "" + #"hash_794e5d0769b1d497", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_7876f33937c8a764", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_586ccfc5deedc573", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"flare_fx", 1, 2, "int");
	clientfield::register("scriptmover", "" + #"hash_2042191a7fc75994", 1, 2, "int");
	clientfield::register("scriptmover", "" + #"hash_2ec182fecae80e80", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_520fa96bf5c8055", 1, 2, "int");
	clientfield::register("scriptmover", "" + #"hash_1cf8b9339139c50d", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_22414550f1988f04", 1, 1, "int");
	clientfield::register("world", "" + #"hash_1166237b92466ac9", 1, 1, "int");
	clientfield::register("world", "" + #"hash_5df3db201b5f6ae0", 1, 2, "counter");
	clientfield::register("world", "" + #"hash_6fdd80bc96ddfb93", 1, 1, "int");
	clientfield::register("world", "" + #"hash_4f672a8a7ae530e5", 1, 1, "int");
}

/*
	Name: init_flags
	Namespace: namespace_b45e3f05
	Checksum: 0x1E0917F3
	Offset: 0xA98
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function init_flags()
{
	level flag::init(#"hash_2aaea7cd22f44712");
	level flag::init(#"hash_3799c8bb28e2f2f");
	level flag::init(#"hash_7c5a0573f12750a8");
	level flag::init(#"hash_480b6b675a3076ec");
	level flag::init(#"hash_525ff2b2a2f7d97a");
	level flag::init(#"hash_f244999377a9081");
	level flag::init(#"hash_598d4e6af1cf4c39");
	level flag::init(#"hash_5721fa890b4af81a");
}

/*
	Name: function_ec9e5cf2
	Namespace: namespace_b45e3f05
	Checksum: 0xF9EB81E2
	Offset: 0xBA8
	Size: 0x6CC
	Parameters: 0
	Flags: Linked
*/
function function_ec9e5cf2()
{
	namespace_ee206246::register(#"hash_634eee6c99fa32d6", #"step_1", #"hash_33e48ffbaa9e7729", &function_5afcaeb7, &function_86a8ce54);
	namespace_ee206246::register(#"hash_634eee6c99fa32d6", #"step_2", #"hash_33e48cfbaa9e7210", &function_b941922b, &function_2eabbbf5);
	namespace_ee206246::register(#"hash_634eee6c99fa32d6", #"step_3", #"hash_33e48dfbaa9e73c3", &function_e9104d6d, &function_2ff57042);
	namespace_ee206246::register(#"hash_634eee6c99fa32d6", #"step_4", #"hash_33e492fbaa9e7c42", &function_1a1d203a, &function_127efb37);
	namespace_ee206246::register(#"hash_2a94ed57942ab290", #"step_1", #"hash_5b0258bdf17964bb", &function_5b9fca53, &function_ada9b74c);
	namespace_ee206246::register(#"hash_1b2ce27a742dce1", #"step_1", #"hash_3f11a01a6c8f925c", &function_a7669bbf, &function_8e6ceabd);
	namespace_ee206246::register(#"hash_6ec9bcc25b22e601", #"step_1", #"hash_189536bc9c5850f1", &function_143dcc81, &function_16d4b0d1);
	namespace_ee206246::register(#"hash_6ec9bcc25b22e601", #"step_2", #"hash_189533bc9c584bd8", &function_282743a6, &function_15a4011a);
	namespace_ee206246::register(#"hash_520fa96bf5c8055", #"step_1", #"hash_2220bd5951e8be08", &function_25e241c9, &function_7bc71597);
	namespace_ee206246::register(#"hash_520fa96bf5c8055", #"step_2", #"hash_2220c05951e8c321", &function_a30b39c3, &function_16dff790);
	namespace_ee206246::register(#"hash_68677a02650cad00", #"step_1", #"hash_4ba91dee7d31240b", &function_b87c71d7, &function_46a445cd);
	namespace_ee206246::register(#"hash_68677a02650cad00", #"step_2", #"hash_4ba91eee7d3125be", &function_9a209775, &function_2ae7b2a6);
	namespace_ee206246::register(#"hash_61a8ff6c7866b2d4", #"step_1", #"hash_15cc42cdb337607", &function_422a07e8, &function_3ce98642);
	namespace_ee206246::register(#"hash_61a8ff6c7866b2d4", #"step_2", #"hash_15cc52cdb3377ba", &function_3435c03, &function_4514c7b5);
	namespace_ee206246::register(#"hash_61a8ff6c7866b2d4", #"step_3", #"hash_15cc62cdb33796d", &function_c8919eef, &function_f1979a);
	callback::on_disconnect(&on_disconnect);
	if(zm_utility::function_e51dc2d8())
	{
		level thread function_62c5099d();
	}
	namespace_ee206246::start(#"hash_634eee6c99fa32d6");
	namespace_ee206246::start(#"hash_2a94ed57942ab290");
	namespace_ee206246::start(#"hash_1b2ce27a742dce1");
	namespace_ee206246::start(#"hash_6ec9bcc25b22e601");
	namespace_ee206246::start(#"hash_520fa96bf5c8055");
	namespace_ee206246::start(#"hash_68677a02650cad00");
	namespace_ee206246::start(#"hash_61a8ff6c7866b2d4");
}

/*
	Name: function_422a07e8
	Namespace: namespace_b45e3f05
	Checksum: 0x881A54C9
	Offset: 0x1280
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_422a07e8(var_a276c861)
{
	if(!getdvarint(#"hash_11ad6a9695943217", 0))
	{
		level waittill(#"pap_quest_complete");
	}
	else
	{
		level waittill(#"start_zombie_round_logic");
	}
	if(!var_a276c861)
	{
		function_b156b71();
	}
}

/*
	Name: function_3ce98642
	Namespace: namespace_b45e3f05
	Checksum: 0x3E1B86F
	Offset: 0x1300
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_3ce98642(var_a276c861, var_19e802fa)
{
	if(var_a276c861 || var_19e802fa)
	{
		level thread function_9e34f29();
	}
}

/*
	Name: function_b156b71
	Namespace: namespace_b45e3f05
	Checksum: 0xB73CE625
	Offset: 0x1348
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function function_b156b71()
{
	a_triggers = getentarray("ship_damage_watcher", "targetname");
	array::thread_all(a_triggers, &function_4e186966);
	array::wait_till(a_triggers, "trigger");
	level thread function_9e34f29();
	/#
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			iprintlnbold("");
			println("");
		}
	#/
}

/*
	Name: function_4e186966
	Namespace: namespace_b45e3f05
	Checksum: 0xF752769F
	Offset: 0x1430
	Size: 0x134
	Parameters: 0
	Flags: Linked
*/
function function_4e186966()
{
	s_fx = struct::get(self.target);
	self waittill(#"trigger", #"death");
	mdl_fx = util::spawn_model("tag_origin", s_fx.origin, (300, 180, 0));
	mdl_fx clientfield::set("" + #"hash_1cf8b9339139c50d", 1);
	level thread util::delete_on_death_or_notify(mdl_fx, #"hash_3a873ffa3efcd0cb", "" + #"hash_1cf8b9339139c50d");
	s_fx struct::delete();
	if(isdefined(self))
	{
		self delete();
	}
}

/*
	Name: function_3435c03
	Namespace: namespace_b45e3f05
	Checksum: 0x8458B93D
	Offset: 0x1570
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_3435c03(var_a276c861)
{
	if(!var_a276c861)
	{
		level thread function_977835f8();
		level flag::wait_till(#"hash_f244999377a9081");
	}
	else
	{
		level flag::set(#"hash_f244999377a9081");
	}
}

/*
	Name: function_4514c7b5
	Namespace: namespace_b45e3f05
	Checksum: 0x5A7E9123
	Offset: 0x15F0
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function function_4514c7b5(var_a276c861, var_19e802fa)
{
	if(var_a276c861 || var_19e802fa)
	{
		level flag::set(#"hash_f244999377a9081");
	}
}

/*
	Name: function_977835f8
	Namespace: namespace_b45e3f05
	Checksum: 0x61106EC8
	Offset: 0x1640
	Size: 0x326
	Parameters: 0
	Flags: Linked
*/
function function_977835f8()
{
	level endon(#"hash_3a873ffa3efcd0cb");
	var_d66b8108 = array::randomize(struct::get_array(#"hash_7d0aef696381d47a"));
	var_810703d4 = [];
	foreach(var_86a2fb89 in var_d66b8108)
	{
		if(!isdefined(var_86a2fb89.script_int))
		{
			arrayremovevalue(var_d66b8108, var_86a2fb89, 1);
		}
	}
	var_d66b8108 = array::remove_undefined(var_d66b8108, 0);
	for(i = 0; i < 6; i++)
	{
		var_810703d4[i] = var_d66b8108[i];
		exploder::exploder("exp_engine_warning_light_" + var_d66b8108[i].script_int);
		/#
			if(getdvarint(#"hash_7919e37cd5d57659", 0))
			{
				debugstar(var_d66b8108[i].origin, 9999);
			}
		#/
	}
	while(true)
	{
		b_complete = 1;
		foreach(var_86a2fb89 in var_d66b8108)
		{
			if(isinarray(var_810703d4, var_86a2fb89))
			{
				if(!(isdefined(var_86a2fb89.var_ba0e0085.var_e3945e9a) && var_86a2fb89.var_ba0e0085.var_e3945e9a))
				{
					b_complete = 0;
					break;
				}
				continue;
			}
			if(isdefined(var_86a2fb89.var_ba0e0085.var_e3945e9a) && var_86a2fb89.var_ba0e0085.var_e3945e9a)
			{
				b_complete = 0;
				break;
			}
		}
		if(b_complete)
		{
			level flag::set(#"hash_f244999377a9081");
		}
		else
		{
			level flag::clear(#"hash_f244999377a9081");
		}
		wait(1);
	}
}

/*
	Name: function_c8919eef
	Namespace: namespace_b45e3f05
	Checksum: 0xF08624C1
	Offset: 0x1970
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_c8919eef(var_a276c861)
{
	if(!var_a276c861)
	{
		level flag::wait_till(#"hash_598d4e6af1cf4c39");
	}
}

/*
	Name: function_f1979a
	Namespace: namespace_b45e3f05
	Checksum: 0xD9798FDB
	Offset: 0x19B0
	Size: 0x54
	Parameters: 2
	Flags: Linked
*/
function function_f1979a(var_a276c861, var_19e802fa)
{
	level flag::set(#"hash_f244999377a9081");
	level flag::set(#"hash_598d4e6af1cf4c39");
}

/*
	Name: function_a0f5819b
	Namespace: namespace_b45e3f05
	Checksum: 0xBBEB4A08
	Offset: 0x1A10
	Size: 0x1DE
	Parameters: 1
	Flags: Linked
*/
function function_a0f5819b(b_on = 1)
{
	level notify(#"hash_14c80c5abb28b07b");
	n_current = level.var_7759c77d.var_4ee2e2ab;
	for(i = 0; i < level.var_7759c77d.var_e770eb55.size; i++)
	{
		level.var_7759c77d.var_4ee2e2ab = i;
		level.pap_machine = level.var_7759c77d.var_e770eb55[i].unitrigger_stub.pap_machine;
		level.pap_machine.var_b64e889a = b_on;
		if(b_on)
		{
			level.var_bceee222 = 5000;
			if(i !== n_current)
			{
				namespace_e80d0291::function_9e015223();
			}
			continue;
		}
		level.var_bceee222 = undefined;
		level.var_7759c77d.var_69e563d = level.var_7759c77d.var_e770eb55[i];
		namespace_e80d0291::function_ef3c219a();
	}
	if(!b_on)
	{
		level.var_efaaea43 = 1;
		level.var_7759c77d.var_4ee2e2ab = randomint(level.var_7759c77d.var_e770eb55.size - 1);
		namespace_e80d0291::function_9e015223();
		level.var_efaaea43 = 0;
		level.var_fea7bdae = 0;
	}
}

/*
	Name: function_4f4e423f
	Namespace: namespace_b45e3f05
	Checksum: 0x54590AB7
	Offset: 0x1BF8
	Size: 0x29C
	Parameters: 0
	Flags: Linked
*/
function function_4f4e423f()
{
	var_ad0c3ba3 = getent("break_the_glass", "targetname");
	s_trigger = spawnstruct();
	s_trigger.origin = var_ad0c3ba3.origin - vectorscale((0, 0, 1), 16);
	s_trigger zm_unitrigger::create();
	while(true)
	{
		waitresult = undefined;
		waitresult = s_trigger waittill(#"trigger_activated");
		e_player = waitresult.e_who;
		var_ad0c3ba3 rotatepitch(-120, 0.5);
		var_ad0c3ba3 playsound(#"hash_3cd844a784afd0f");
		var_ad0c3ba3 waittill(#"rotatedone");
		if(level flag::get(#"hash_f244999377a9081"))
		{
			level flag::set(#"hash_598d4e6af1cf4c39");
			var_ad0c3ba3 playsound(#"hash_3088af4bb5209a73");
			if(isdefined(e_player))
			{
				wait(1.5);
				e_player zm_audio::create_and_play_dialog(#"engine_room", #"alarm");
			}
			break;
		}
		else
		{
			wait(5);
			var_ad0c3ba3 rotatepitch(120, 3);
			var_ad0c3ba3 playsound(#"hash_3cd844a784afd0f");
			var_ad0c3ba3 waittill(#"rotatedone");
		}
	}
	zm_unitrigger::unregister_unitrigger(s_trigger);
	s_trigger struct::delete();
	level clientfield::set("" + #"hash_1166237b92466ac9", 1);
}

/*
	Name: function_9e34f29
	Namespace: namespace_b45e3f05
	Checksum: 0x41A4D339
	Offset: 0x1EA0
	Size: 0x5C4
	Parameters: 0
	Flags: Linked
*/
function function_9e34f29()
{
	var_f3b42d73 = scene::get_active_scenes(#"p8_fxanim_zm_zod_engine_pistons_idle_01_bundle");
	if(var_f3b42d73.size)
	{
		var_d8b371d4 = var_f3b42d73[getfirstarraykey(var_f3b42d73)].scene_ents;
	}
	var_4cd65fb6 = scene::get_active_scenes(#"p8_fxanim_zm_zod_engine_pistons_idle_02_bundle");
	if(var_4cd65fb6.size)
	{
		var_1198639d = var_4cd65fb6[getfirstarraykey(var_4cd65fb6)].scene_ents;
	}
	var_5b572ef1 = scene::get_active_scenes(#"p8_fxanim_zm_zod_engine_propeller_shafts_01_idle_bundle");
	if(var_5b572ef1.size)
	{
		var_f1d8c9e3 = var_5b572ef1[getfirstarraykey(var_5b572ef1)].scene_ents;
	}
	var_6997cb72 = scene::get_active_scenes(#"p8_fxanim_zm_zod_engine_propeller_shafts_02_idle_bundle");
	if(var_6997cb72.size)
	{
		var_ff6de50d = var_6997cb72[getfirstarraykey(var_6997cb72)].scene_ents;
	}
	level thread scene::play(#"p8_fxanim_zm_zod_engine_pistons_idle_01_bundle", "stop");
	level thread scene::play(#"p8_fxanim_zm_zod_engine_pistons_idle_02_bundle", "stop");
	level thread scene::play(#"p8_fxanim_zm_zod_engine_propeller_shafts_01_idle_bundle", "stop");
	level thread scene::play(#"p8_fxanim_zm_zod_engine_propeller_shafts_02_idle_bundle", "stop");
	level thread scene::play(#"p8_fxanim_zm_zod_skybox_bundle", "event_impact");
	level flag::wait_till(#"hash_598d4e6af1cf4c39");
	level thread function_ec3ffba();
	level.var_25e38adf = level.round_number + randomintrange(3, 5);
	for(i = 1; i <= 12; i++)
	{
		exploder::stop_exploder("exp_engine_warning_light_" + i);
	}
	exploder::exploder("exp_lgt_switchboard_gameplay");
	exploder::exploder("exp_lgt_switchboard_warning_redflash");
	exploder::exploder("exp_lgt_engine_warning_redflash");
	wait(1.5);
	level thread scene::play(#"p8_fxanim_zm_zod_engine_pistons_full_speed_01_bundle", var_d8b371d4);
	level thread scene::play(#"p8_fxanim_zm_zod_engine_pistons_full_speed_02_bundle", var_1198639d);
	level thread scene::play(#"p8_fxanim_zm_zod_engine_propeller_shafts_01_fullspeed_bundle", var_f1d8c9e3);
	level thread scene::play(#"p8_fxanim_zm_zod_engine_propeller_shafts_02_fullspeed_bundle", var_ff6de50d);
	level thread scene::play(#"p8_fxanim_zm_zod_skybox_bundle", "event_impact");
	level thread function_a0f5819b();
	wait(30);
	level waittill(#"end_of_round");
	level waittill(#"start_of_round");
	exploder::stop_exploder("exp_lgt_switchboard_gameplay");
	exploder::stop_exploder("exp_lgt_switchboard_warning_redflash");
	exploder::stop_exploder("exp_lgt_engine_warning_redflash");
	scene::stop(#"p8_fxanim_zm_zod_engine_pistons_full_speed_01_bundle");
	scene::stop(#"p8_fxanim_zm_zod_engine_pistons_full_speed_02_bundle");
	scene::stop(#"p8_fxanim_zm_zod_engine_propeller_shafts_01_fullspeed_bundle");
	scene::stop(#"p8_fxanim_zm_zod_engine_propeller_shafts_02_fullspeed_bundle");
	level thread scene::play(#"p8_fxanim_zm_zod_engine_pistons_idle_01_bundle", var_d8b371d4);
	level thread scene::play(#"p8_fxanim_zm_zod_engine_pistons_idle_02_bundle", var_1198639d);
	level thread scene::play(#"p8_fxanim_zm_zod_engine_propeller_shafts_01_idle_bundle", var_f1d8c9e3);
	level thread scene::play(#"p8_fxanim_zm_zod_engine_propeller_shafts_02_idle_bundle", var_ff6de50d);
	level flag::clear(#"hash_598d4e6af1cf4c39");
	level thread function_a0f5819b(0);
}

/*
	Name: function_ec3ffba
	Namespace: namespace_b45e3f05
	Checksum: 0xCE741871
	Offset: 0x2470
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_ec3ffba()
{
	var_ad0c3ba3 = getent("break_the_glass", "targetname");
	var_ad0c3ba3 playloopsound(#"hash_7df918bfc36f9f8");
	level flag::wait_till_clear(#"hash_598d4e6af1cf4c39");
	var_ad0c3ba3 stoploopsound(0.1);
}

/*
	Name: function_5beff312
	Namespace: namespace_b45e3f05
	Checksum: 0xDE0B8C9F
	Offset: 0x2508
	Size: 0x138
	Parameters: 0
	Flags: Linked
*/
function function_5beff312()
{
	level waittill(#"start_zombie_round_logic");
	var_eb8e056b = getentarray("cowboy_ghost", "targetname");
	a_s_locs = struct::get_array(#"hash_7d0aef696381d47a");
	foreach(s_loc in a_s_locs)
	{
		s_loc.in_zone = #"zone_engine";
		s_loc.var_ba0e0085 = arraygetclosest(s_loc.origin, var_eb8e056b);
		s_loc zm_unitrigger::create("", 64, &function_8fd1207a);
	}
}

/*
	Name: function_8fd1207a
	Namespace: namespace_b45e3f05
	Checksum: 0x5F612ADA
	Offset: 0x2648
	Size: 0x196
	Parameters: 0
	Flags: Linked
*/
function function_8fd1207a()
{
	self endon(#"death");
	function_dae4ab9b(self, 0.3);
	var_2a21fe27 = self.stub.related_parent;
	var_ba0e0085 = var_2a21fe27.var_ba0e0085;
	if(isdefined(var_ba0e0085.var_e3945e9a) && var_ba0e0085.var_e3945e9a)
	{
		n_mod = -1;
	}
	else
	{
		n_mod = 1;
	}
	if(var_2a21fe27.script_int === 7 && (!(isdefined(var_2a21fe27.var_ff23b30d) && var_2a21fe27.var_ff23b30d)))
	{
		self thread function_3702ff38();
	}
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		e_player = waitresult.activator;
		if(!zm_utility::can_use(e_player))
		{
			continue;
		}
		var_ba0e0085 thread function_49200079(n_mod);
		var_ba0e0085 waittill(#"hash_21146570fad885f3");
		n_mod = n_mod * -1;
	}
}

/*
	Name: function_49200079
	Namespace: namespace_b45e3f05
	Checksum: 0xC00194F4
	Offset: 0x27E8
	Size: 0x106
	Parameters: 1
	Flags: Linked
*/
function function_49200079(n_mod)
{
	self playsound(#"hash_527c79383c046fab");
	self rotatevelocity((20 * n_mod, 180 * n_mod, -20), 0.5);
	self waittill(#"rotatedone");
	self rotatevelocity((20 * n_mod, 180 * n_mod, 20), 0.5);
	self waittill(#"rotatedone");
	if(isdefined(self.var_e3945e9a) && self.var_e3945e9a)
	{
		self.var_e3945e9a = 0;
	}
	else
	{
		self.var_e3945e9a = 1;
	}
	self notify(#"hash_21146570fad885f3");
}

/*
	Name: function_3702ff38
	Namespace: namespace_b45e3f05
	Checksum: 0x97D22F73
	Offset: 0x28F8
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function function_3702ff38()
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		e_player = waitresult.activator;
		if(!zm_utility::can_use(e_player))
		{
			continue;
		}
		self.stub.related_parent.var_ff23b30d = 1;
		e_hand = getent("engine_room_arm", "targetname");
		if(isdefined(e_hand))
		{
			e_hand physicslaunch(e_hand.origin, (0, 0, 1));
			wait(2);
			e_hand delete();
		}
		break;
	}
}

/*
	Name: function_25e241c9
	Namespace: namespace_b45e3f05
	Checksum: 0x48C8DA0C
	Offset: 0x2A08
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function function_25e241c9(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level flag::wait_till(#"pap_quest_complete");
		level.var_92dc9c0d = array::random(struct::get_array(#"hash_6e83252a55036eb5"));
		function_7071d9b0();
	}
}

/*
	Name: function_7bc71597
	Namespace: namespace_b45e3f05
	Checksum: 0x1DB4EB12
	Offset: 0x2A98
	Size: 0x7C
	Parameters: 2
	Flags: Linked
*/
function function_7bc71597(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level.var_92dc9c0d = array::random(struct::get_array(#"hash_6e83252a55036eb5"));
		level thread function_9be06570();
	}
}

/*
	Name: function_7071d9b0
	Namespace: namespace_b45e3f05
	Checksum: 0xAC129415
	Offset: 0x2B20
	Size: 0x1C4
	Parameters: 0
	Flags: Linked
*/
function function_7071d9b0()
{
	trigger = spawn("trigger_damage", level.var_92dc9c0d.origin, 0, 16, 16);
	/#
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			debugstar(level.var_92dc9c0d.origin, 50000, (1, 0.5, 0));
		}
	#/
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = trigger waittill(#"damage");
		if(isdefined(var_88706ea7.attacker) && var_88706ea7.attacker aat::function_c5abc232(var_88706ea7.weapon))
		{
			level.var_33918b88 = var_88706ea7.attacker;
			break;
		}
	}
	trigger delete();
	/#
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			iprintlnbold("");
			println("");
		}
	#/
	level thread function_9be06570();
}

/*
	Name: function_a30b39c3
	Namespace: namespace_b45e3f05
	Checksum: 0xBCFD5A34
	Offset: 0x2CF0
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_a30b39c3(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level waittill(#"hash_3fe51713857b3c4");
	}
}

/*
	Name: function_16dff790
	Namespace: namespace_b45e3f05
	Checksum: 0x118F09CA
	Offset: 0x2D28
	Size: 0x42
	Parameters: 2
	Flags: Linked
*/
function function_16dff790(var_5ea5c94d, ended_early)
{
	if(ended_early)
	{
		function_cbee939b();
	}
	level.var_92dc9c0d = undefined;
	level.var_33918b88 = undefined;
}

/*
	Name: function_9be06570
	Namespace: namespace_b45e3f05
	Checksum: 0xEBE71F7A
	Offset: 0x2D78
	Size: 0x574
	Parameters: 0
	Flags: Linked
*/
function function_9be06570()
{
	if(!isdefined(level.var_33918b88))
	{
		level.var_33918b88 = util::get_active_players()[0];
	}
	var_a3b04877 = util::spawn_model("tag_origin", level.var_92dc9c0d.origin + (0, 12, -2), level.var_92dc9c0d.angles);
	var_a3b04877 clientfield::set("" + #"hash_520fa96bf5c8055", 1);
	var_93048467 = struct::get(level.var_92dc9c0d.target);
	wait(3);
	while(isdefined(var_93048467))
	{
		if(!isdefined(var_93048467.n_time))
		{
			var_93048467.n_time = 2;
		}
		var_a3b04877 moveto(var_93048467.origin, var_93048467.n_time);
		var_a3b04877 waittill(#"movedone");
		if(isdefined(var_93048467.script_teleport) && isalive(level.var_33918b88))
		{
			var_93048467 = struct::get(var_93048467.script_teleport);
			if(var_93048467.targetname === #"hash_a7644632e1952ad")
			{
				v_offset = (128, 0, 64);
				var_dfb12a4a = 1;
			}
			else
			{
				v_offset = (17.5, 0, 60);
				var_a3b04877 clientfield::set("" + #"hash_520fa96bf5c8055", 2);
			}
			var_a3b04877 hide();
			var_88706ea7 = undefined;
			var_88706ea7 = level.var_33918b88 waittill_timeout(3.5, #"hash_e66663be8ba322f", #"disconnect");
			var_a3b04877 show();
			if(var_88706ea7._notify === #"hash_e66663be8ba322f" && isalive(level.var_33918b88))
			{
				var_a3b04877 linkto(level.var_33918b88, "tag_origin", v_offset, vectorscale((0, 1, 0), 90));
				level.var_33918b88 waittill(#"fasttravel_over", #"disconnect");
				if(isdefined(var_dfb12a4a) && var_dfb12a4a)
				{
					var_a3b04877 clientfield::set("" + #"hash_520fa96bf5c8055", 0);
				}
				util::wait_network_frame();
				var_a3b04877 unlink();
				var_a3b04877.origin = level.var_33918b88.origin + vectorscale((0, 0, 1), 32);
				var_a3b04877 clientfield::set("" + #"hash_520fa96bf5c8055", 1);
				var_a3b04877 moveto(var_93048467.origin, 0.75);
				var_a3b04877 waittill(#"movedone");
			}
			else
			{
				function_9f2f0210(var_a3b04877);
				return;
			}
		}
		if(var_93048467.b_no_wait !== 1)
		{
			wait(randomfloatrange(1, 2));
			if(!isalive(level.var_33918b88) || (isdefined(level.var_33918b88) && distancesquared(level.var_33918b88.origin, var_a3b04877.origin) > 65536))
			{
				function_9f2f0210(var_a3b04877);
				return;
			}
		}
		var_93048467 = struct::get(var_93048467.target);
	}
	level notify(#"hash_3fe51713857b3c4");
	function_cbee939b(var_a3b04877);
}

/*
	Name: function_9f2f0210
	Namespace: namespace_b45e3f05
	Checksum: 0x402AC08B
	Offset: 0x32F8
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_9f2f0210(var_a3b04877)
{
	var_a3b04877 delete();
	level.var_33918b88 = undefined;
	/#
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			iprintlnbold("");
			println("");
		}
	#/
	level waittill(#"end_of_round", #"start_of_round");
	level thread function_7071d9b0();
}

/*
	Name: function_cbee939b
	Namespace: namespace_b45e3f05
	Checksum: 0x1690DCC1
	Offset: 0x33C8
	Size: 0x27C
	Parameters: 1
	Flags: Linked
*/
function function_cbee939b(var_a9e11cb7)
{
	self notify("142674eccecae6a");
	self endon("142674eccecae6a");
	s_loc = struct::get(#"hash_2b406c6248d8f47b");
	if(!isdefined(var_a9e11cb7))
	{
		var_a9e11cb7 = util::spawn_model("tag_origin", s_loc.origin, s_loc.angles);
		var_a9e11cb7 clientfield::set("" + #"hash_520fa96bf5c8055", 1);
	}
	var_a9e11cb7 clientfield::set("" + #"hash_520fa96bf5c8055", 2);
	s_loc zm_unitrigger::function_fac87205();
	playsoundatposition(#"hash_1ae92639674c0896", var_a9e11cb7.origin);
	var_a9e11cb7 clientfield::set("" + #"hash_520fa96bf5c8055", 0);
	foreach(player in util::get_active_players())
	{
		player thread function_76351c42();
	}
	callback::on_connect(&function_76351c42);
	/#
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			iprintlnbold("");
			println("");
		}
	#/
	wait(5);
	var_a9e11cb7 delete();
}

/*
	Name: function_76351c42
	Namespace: namespace_b45e3f05
	Checksum: 0xF35E24FB
	Offset: 0x3650
	Size: 0xF6
	Parameters: 0
	Flags: Linked
*/
function function_76351c42()
{
	self endon(#"disconnect");
	self.var_d883eecd = 0;
	var_f3ca036b = 0;
	var_680128c2 = level.round_number;
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = level waittill(#"hash_e66663be8ba322f");
		if(var_88706ea7.player === self)
		{
			var_f3ca036b++;
			if(var_f3ca036b < 3)
			{
				continue;
			}
			else
			{
				self.var_d883eecd = undefined;
			}
		}
		else
		{
			continue;
		}
		level waittill(#"end_of_round");
		self.var_d883eecd = 0;
		var_f3ca036b = 0;
		var_680128c2 = level.round_number;
	}
}

/*
	Name: function_143dcc81
	Namespace: namespace_b45e3f05
	Checksum: 0x5920E3D3
	Offset: 0x3750
	Size: 0x4A0
	Parameters: 1
	Flags: Linked
*/
function function_143dcc81(var_5ea5c94d)
{
	a_spots = array::randomize(struct::get_array(#"hash_152bb6bdedef598a"));
	var_3adcbaed = getent("dead_offering", "targetname");
	var_3adcbaed val::set(#"hash_6ec9bcc25b22e601", "takedamage", 1);
	var_3adcbaed val::set(#"hash_6ec9bcc25b22e601", "allowdeath", 0);
	foreach(spot in a_spots)
	{
		var_3adcbaed.origin = spot.origin;
		var_3adcbaed.angles = spot.angles;
		wait(1);
		var_3adcbaed show();
		while(true)
		{
			var_88706ea7 = undefined;
			var_88706ea7 = var_3adcbaed waittill(#"damage");
			if(isplayer(var_88706ea7.attacker) && (util::getweaponclass(var_88706ea7.weapon) === #"weapon_sniper" || util::getweaponclass(var_88706ea7.weapon) === #"weapon_tactical"))
			{
				var_88706ea7.attacker util::show_hit_marker();
				s_landing = struct::get(spot.target);
				var_7a19681c = 360 / s_landing.n_move_time;
				var_bbf325e3 = 270 / s_landing.n_move_time;
				var_3adcbaed moveto(s_landing.origin, s_landing.n_move_time, s_landing.n_move_time * 0.5, 0.1);
				var_3adcbaed rotatevelocity((var_7a19681c, var_7a19681c, var_bbf325e3), s_landing.n_move_time);
				var_3adcbaed waittill(#"movedone");
				var_3adcbaed playsound(#"hash_7c391343ab3a2c17");
				if(s_landing.var_cdcee58e === 1 && level flag::get(#"water_drained_aft"))
				{
					fx::play(#"hash_708765aa3f48456d", s_landing.origin + vectorscale((0, 0, 1), 20), (270, 180, 180));
				}
				s_landing.origin = s_landing.origin + vectorscale((0, 0, 1), 48);
				var_64c09f7f = s_landing zm_unitrigger::function_fac87205();
				var_3adcbaed playsound(#"hash_62d7c979858b9326");
				var_64c09f7f zm_audio::create_and_play_dialog(#"fish", #"hash_63e5849a59bb45a8");
				s_landing struct::delete();
				var_3adcbaed hide();
				break;
			}
		}
	}
}

/*
	Name: function_16d4b0d1
	Namespace: namespace_b45e3f05
	Checksum: 0xA6EF69EA
	Offset: 0x3BF8
	Size: 0x5C
	Parameters: 2
	Flags: Linked
*/
function function_16d4b0d1(var_5ea5c94d, ended_early)
{
	var_3adcbaed = getent("dead_offering", "targetname");
	if(isdefined(var_3adcbaed))
	{
		var_3adcbaed delete();
	}
}

/*
	Name: function_282743a6
	Namespace: namespace_b45e3f05
	Checksum: 0xEF28EC7C
	Offset: 0x3C60
	Size: 0x224
	Parameters: 1
	Flags: Linked
*/
function function_282743a6(var_5ea5c94d)
{
	array::run_all(util::get_players(), &forcestreambundle, #"p8_fxanim_zm_zod_tentacle_bundle");
	s_trigger = struct::get(#"hash_693bda099c0710af");
	var_64c09f7f = s_trigger zm_unitrigger::function_fac87205();
	playsoundatposition(#"hash_42f8105535463377", s_trigger.origin);
	/#
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			iprintlnbold("");
			println("");
		}
	#/
	showmiscmodels("dead_offering");
	s_scene = struct::get(s_trigger.target);
	scene::add_scene_func(#"p8_fxanim_zm_zod_tentacle_bundle", &function_a343f892);
	s_scene scene::play();
	array::run_all(util::get_players(), &function_66b6e720, #"p8_fxanim_zm_zod_tentacle_bundle");
	if(isalive(var_64c09f7f))
	{
		var_64c09f7f zm_audio::create_and_play_dialog(#"fish", #"hash_567e7f4586f90cfc");
	}
}

/*
	Name: function_15a4011a
	Namespace: namespace_b45e3f05
	Checksum: 0x2A9A8051
	Offset: 0x3E90
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function function_15a4011a(var_5ea5c94d, ended_early)
{
}

/*
	Name: function_a343f892
	Namespace: namespace_b45e3f05
	Checksum: 0x1E613DE
	Offset: 0x3EB0
	Size: 0x14C
	Parameters: 1
	Flags: Linked
*/
function function_a343f892(a_ents)
{
	if(self.targetname === #"hash_d57edbfd2d86a0c")
	{
		scene::remove_scene_func(#"p8_fxanim_zm_zod_tentacle_bundle", &function_a343f892);
		var_d636c7a5 = a_ents[#"hash_3712f07fe0e1166c"];
		var_d636c7a5 hide();
		wait(1.5);
		zm_powerups::specific_powerup_drop(#"free_perk", struct::get(#"hash_693bda099c0710af").origin + vectorscale((0, 0, 1), 16), undefined, undefined, undefined, 1, 1);
		if(isdefined(var_d636c7a5))
		{
			var_d636c7a5 delete();
		}
		function_c62198dc();
		hidemiscmodels("dead_start");
	}
}

/*
	Name: function_c62198dc
	Namespace: namespace_b45e3f05
	Checksum: 0x2ACA6112
	Offset: 0x4008
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_c62198dc()
{
	level flag::wait_till(#"hash_29cfd2a7a3f9f175");
	hidemiscmodels("dead_offering");
}

/*
	Name: function_5b9fca53
	Namespace: namespace_b45e3f05
	Checksum: 0x6305215
	Offset: 0x4050
	Size: 0x12C
	Parameters: 1
	Flags: Linked
*/
function function_5b9fca53(var_5ea5c94d)
{
	level.var_f02a5fea = [];
	var_e47aabc9 = getentarray("underwater_objects", "script_noteworthy");
	foreach(mdl in var_e47aabc9)
	{
		mdl thread function_bf250d60();
	}
	level waittill(#"power_on");
	struct::get(#"hash_7de555271928a1f4") zm_unitrigger::create(undefined, undefined, &function_ebb2139);
	level flag::wait_till(#"hash_7c5a0573f12750a8");
}

/*
	Name: function_ada9b74c
	Namespace: namespace_b45e3f05
	Checksum: 0x4075064A
	Offset: 0x4188
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function function_ada9b74c(var_5ea5c94d, ended_early)
{
}

/*
	Name: function_bf250d60
	Namespace: namespace_b45e3f05
	Checksum: 0x24D6CD25
	Offset: 0x41A8
	Size: 0x572
	Parameters: 0
	Flags: Linked
*/
function function_bf250d60()
{
	self val::set(#"hash_2a94ed57942ab290", "takedamage", 1);
	self val::set(#"hash_2a94ed57942ab290", "allowdeath", 1);
	s_landing = struct::get(self.target);
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"damage");
		if(isplayer(var_88706ea7.attacker))
		{
			var_88706ea7.attacker util::show_hit_marker();
			var_1c07e390 = s_landing.angles[0] - self.angles[0] + 360 / s_landing.n_move_time;
			var_a046aba8 = s_landing.angles[1] - self.angles[1] + 360 / s_landing.n_move_time;
			var_b9372e0e = s_landing.angles[2] - self.angles[2] + 360 / s_landing.n_move_time;
			if(s_landing.targetname === #"hash_7287eca610c2a92d")
			{
				var_a046aba8 = s_landing.angles[1] - self.angles[1] / s_landing.n_move_time;
				var_b9372e0e = s_landing.angles[2] - self.angles[2] / s_landing.n_move_time;
			}
			self moveto(s_landing.origin, s_landing.n_move_time, s_landing.n_move_time * 0.5, 0.1);
			self rotatevelocity((var_1c07e390, var_a046aba8, var_b9372e0e), s_landing.n_move_time);
			self waittill(#"movedone");
			if(isdefined(self.targetname))
			{
				if(self.targetname == #"hash_7520bcc94fba7d50")
				{
					playsoundatposition(#"hash_54fc1ee5be2ddd61", self.origin);
				}
				if(self.targetname == #"hash_3ba201ef2230be8a")
				{
					playsoundatposition(#"hash_123df27d58070a48", self.origin);
				}
			}
			if(isdefined(s_landing.target))
			{
				str_targetname = s_landing.target;
				s_landing struct::delete();
				s_landing = struct::get(str_targetname);
				self.angles = self.angles - vectorscale((1, 1, 1), 360);
				continue;
			}
			s_landing.origin = s_landing.origin + vectorscale((0, 0, 1), 32);
			e_who = s_landing zm_unitrigger::function_fac87205();
			e_who zm_audio::create_and_play_dialog(#"hash_44b4edd3d705820d", #"generic");
			playsoundatposition(#"hash_47aa0fa4a084903b", self.origin);
			s_loc = struct::get(self.targetname + "_final");
			if(!isdefined(level.var_f02a5fea))
			{
				level.var_f02a5fea = [];
			}
			else if(!isarray(level.var_f02a5fea))
			{
				level.var_f02a5fea = array(level.var_f02a5fea);
			}
			level.var_f02a5fea[level.var_f02a5fea.size] = self;
			self hide();
			self.origin = s_loc.origin;
			self.angles = s_loc.angles;
			s_landing struct::delete();
			s_loc struct::delete();
			return;
		}
	}
}

/*
	Name: function_ebb2139
	Namespace: namespace_b45e3f05
	Checksum: 0x1E3CE8A6
	Offset: 0x4728
	Size: 0x218
	Parameters: 0
	Flags: Linked
*/
function function_ebb2139()
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		e_player = waitresult.activator;
		if(!zm_utility::can_use(e_player) || level flag::get(#"hash_480b6b675a3076ec"))
		{
			continue;
		}
		foreach(var_a89972df in level.var_f02a5fea)
		{
			var_a89972df show();
			playsoundatposition(#"hash_6cea60c7eda4bc0a", var_a89972df.origin);
		}
		if(level flag::get(#"boss_fight_started") && !level flag::get(#"hash_25d8c88ff3f91ee5"))
		{
			continue;
		}
		if(level.var_f02a5fea.size >= 3 && (!isdefined(level.var_d889fbd9) || level.var_d889fbd9 + 9 <= level.round_number))
		{
			level thread function_5daf1bb7();
			playsoundatposition(#"hash_33065f8e09911175", var_a89972df.origin);
		}
	}
}

/*
	Name: function_5daf1bb7
	Namespace: namespace_b45e3f05
	Checksum: 0xD6B13BCA
	Offset: 0x4948
	Size: 0x134
	Parameters: 0
	Flags: Linked
*/
function function_5daf1bb7()
{
	level flag::set(#"hash_480b6b675a3076ec");
	var_fcec724a = struct::get(#"hash_7c87c2ef44080fe");
	playrumbleonposition("grenade_rumble", var_fcec724a.origin);
	level waittill(#"start_of_round");
	level flag::set(#"hash_7c5a0573f12750a8");
	exploder::exploder("exp_eye_glow");
	level.var_d889fbd9 = level.round_number;
	level waittill(#"end_of_round");
	level flag::clear(#"hash_7c5a0573f12750a8");
	level flag::clear(#"hash_480b6b675a3076ec");
}

/*
	Name: function_5afcaeb7
	Namespace: namespace_b45e3f05
	Checksum: 0xE124D9CD
	Offset: 0x4A88
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function function_5afcaeb7(var_a276c861)
{
	level.var_8237e7d3 = getent("mdl_sf_cr", "targetname");
	function_40047f84();
	if(!var_a276c861)
	{
		var_e531b8b8 = struct::get(level.var_8237e7d3.target);
		var_f02fb354 = getent(level.var_8237e7d3.target, "targetname");
		level.var_8237e7d3 function_c0174de(var_f02fb354, var_e531b8b8);
	}
}

/*
	Name: function_86a8ce54
	Namespace: namespace_b45e3f05
	Checksum: 0x713BD4BB
	Offset: 0x4B60
	Size: 0x7A
	Parameters: 2
	Flags: Linked
*/
function function_86a8ce54(var_a276c861, var_19e802fa)
{
	if(var_19e802fa)
	{
		if(isdefined(level.var_8237e7d3.s_unitrigger))
		{
			zm_unitrigger::unregister_unitrigger(level.var_8237e7d3.s_unitrigger);
		}
		level.var_8237e7d3 hide();
		level.var_534a0586 = 1;
	}
}

/*
	Name: function_c0174de
	Namespace: namespace_b45e3f05
	Checksum: 0x4A93E880
	Offset: 0x4BE8
	Size: 0x25A
	Parameters: 2
	Flags: Linked
*/
function function_c0174de(var_f02fb354, var_e531b8b8)
{
	self endon(#"death");
	var_f02fb354 function_f6f230af();
	n_move_time = var_e531b8b8.var_fa3ab582;
	self unlink();
	self animation::stop();
	self moveto(var_e531b8b8.origin, n_move_time, n_move_time);
	self rotateto(var_e531b8b8.angles, n_move_time);
	self waittill(#"movedone");
	self playsound(#"hash_6df06ef021cd1a4");
	self thread scene::init(#"p8_fxanim_zm_zod_safe_cracker_ee_bundle", self);
	s_unitrigger = self zm_unitrigger::create();
	zm_unitrigger::function_47625e58(s_unitrigger, s_unitrigger.origin + vectorscale((0, 0, 1), 32), s_unitrigger.angles);
	var_88706ea7 = undefined;
	var_88706ea7 = self waittill(#"trigger_activated");
	if(isalive(var_88706ea7.e_who))
	{
		var_88706ea7.e_who zm_audio::create_and_play_dialog(#"hash_5afc9e48d1d21f89", #"pick_up");
	}
	self zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
	self hide();
	self playsound(#"hash_54d18476ea0d7d0d");
	level.var_534a0586 = 1;
}

/*
	Name: function_f6f230af
	Namespace: namespace_b45e3f05
	Checksum: 0x1A3A113
	Offset: 0x4E50
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function function_f6f230af()
{
	var_54cae2d8 = getweapon(#"zhield_dw");
	var_2bc04483 = 1;
	while(var_2bc04483)
	{
		waitresult = undefined;
		waitresult = self waittill(#"damage", #"death");
		if(waitresult._notify == "death")
		{
			return;
		}
		if(waitresult.weapon == var_54cae2d8 && waitresult.mod == #"mod_melee")
		{
			var_2bc04483 = 0;
		}
	}
}

/*
	Name: function_b941922b
	Namespace: namespace_b45e3f05
	Checksum: 0xE4228EE5
	Offset: 0x4F30
	Size: 0x278
	Parameters: 1
	Flags: Linked
*/
function function_b941922b(var_a276c861)
{
	if(!var_a276c861)
	{
		while(level flag::get(#"hash_2aaea7cd22f44712") == 0)
		{
			level.var_f39ad20a = 0;
			level.var_637aeeb8 = 0;
			foreach(var_96d7c567 in level.var_d3587a62)
			{
				var_96d7c567 thread function_ae4e9016();
			}
			level waittill(#"hash_543e0c29db385264");
			if(level.var_637aeeb8 == 4)
			{
				level flag::set(#"hash_2aaea7cd22f44712");
			}
			else
			{
				level waittill(#"start_of_round");
				foreach(var_d6249c56 in level.var_f1be1a60)
				{
					var_d6249c56.origin = var_d6249c56.original_origin;
					var_d6249c56.angles = var_d6249c56.original_angles;
					var_d6249c56.b_taken = 0;
				}
				foreach(var_96d7c567 in level.var_d3587a62)
				{
					var_96d7c567.var_6f7cfe6d clientfield::set("" + #"hash_586ccfc5deedc573", 0);
					var_96d7c567.var_d6249c56 = undefined;
				}
				function_b8048aaf();
			}
		}
	}
}

/*
	Name: function_2eabbbf5
	Namespace: namespace_b45e3f05
	Checksum: 0xD6370C6F
	Offset: 0x51B0
	Size: 0x120
	Parameters: 2
	Flags: Linked
*/
function function_2eabbbf5(var_a276c861, var_19e802fa)
{
	foreach(var_96d7c567 in level.var_d3587a62)
	{
		if(isdefined(var_96d7c567.var_f02fb354))
		{
			var_96d7c567.var_f02fb354 delete();
		}
	}
	foreach(var_d6249c56 in level.var_f1be1a60)
	{
		if(isdefined(var_d6249c56))
		{
			var_d6249c56 delete();
		}
	}
}

/*
	Name: function_40047f84
	Namespace: namespace_b45e3f05
	Checksum: 0xF50E6214
	Offset: 0x52D8
	Size: 0x1AA
	Parameters: 0
	Flags: Linked
*/
function function_40047f84()
{
	level.var_f1be1a60 = array::randomize(getentarray("mdl_bn_pu", "targetname"));
	foreach(var_d6249c56 in level.var_f1be1a60)
	{
		var_d6249c56 function_a4df9ae7();
		var_d6249c56 thread function_50f4cc80();
	}
	level.var_d3587a62 = array::randomize(struct::get_array(#"hash_137909c96f5438d9"));
	foreach(var_96d7c567 in level.var_d3587a62)
	{
		var_96d7c567 function_4a32663f();
	}
	function_b8048aaf();
	level.var_534a0586 = 0;
}

/*
	Name: function_b8048aaf
	Namespace: namespace_b45e3f05
	Checksum: 0x4E242E46
	Offset: 0x5490
	Size: 0x194
	Parameters: 0
	Flags: Linked
*/
function function_b8048aaf()
{
	var_d19e7d67 = array(4250, 2340, 1404, 1912);
	for(i = 0; i < 4; i++)
	{
		n_index = randomint(var_d19e7d67.size);
		var_83fad8a9 = var_d19e7d67[n_index];
		arrayremoveindex(var_d19e7d67, n_index);
		level.var_d3587a62[i].var_83fad8a9 = var_83fad8a9;
		level.var_f1be1a60[i].var_83fad8a9 = var_83fad8a9;
		foreach(var_aed8d635 in level.var_f1be1a60[i].var_3abff2c8)
		{
			if(var_aed8d635.script_string == var_83fad8a9)
			{
				var_aed8d635.mdl_number = util::spawn_model(var_aed8d635.model, var_aed8d635.origin, var_aed8d635.angles);
			}
		}
	}
}

/*
	Name: function_a4df9ae7
	Namespace: namespace_b45e3f05
	Checksum: 0x8EF12C14
	Offset: 0x5630
	Size: 0xC6
	Parameters: 0
	Flags: Linked
*/
function function_a4df9ae7()
{
	self.original_origin = self.origin;
	self.original_angles = self.angles;
	self.var_3abff2c8 = [];
	a_structs = struct::get_array(self.target);
	foreach(struct in a_structs)
	{
		self.var_3abff2c8[self.var_3abff2c8.size] = struct;
	}
}

/*
	Name: function_50f4cc80
	Namespace: namespace_b45e3f05
	Checksum: 0xF0A8D302
	Offset: 0x5700
	Size: 0x234
	Parameters: 0
	Flags: Linked
*/
function function_50f4cc80()
{
	s_unitrigger = self zm_unitrigger::create();
	zm_unitrigger::function_89380dda(s_unitrigger);
	self.b_taken = 0;
	while(level flag::get(#"hash_2aaea7cd22f44712") == 0)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger_activated", #"death");
		if(waitresult._notify == "death")
		{
			break;
		}
		e_player = waitresult.e_who;
		if(isdefined(e_player.var_d6249c56))
		{
			if(e_player.var_d6249c56 == self)
			{
				self.origin = self.original_origin;
				self.angles = self.original_angles;
				self show();
				e_player.var_d6249c56 = undefined;
				self.b_taken = 0;
			}
		}
		else if(!self.b_taken)
		{
			self hide();
			self playsound(#"hash_3c18e9f6d0adb140");
			e_player.var_d6249c56 = self;
			self.b_taken = 1;
			e_player zm_audio::create_and_play_dialog(#"hash_44b4edd3d705820d", #"generic");
			/#
				if(getdvarint(#"hash_7919e37cd5d57659", 0))
				{
					iprintlnbold(self.var_83fad8a9);
					println(self.var_83fad8a9);
				}
			#/
		}
	}
	zm_unitrigger::unregister_unitrigger(s_unitrigger);
}

/*
	Name: function_4a32663f
	Namespace: namespace_b45e3f05
	Checksum: 0x139019EF
	Offset: 0x5940
	Size: 0x1F6
	Parameters: 0
	Flags: Linked
*/
function function_4a32663f()
{
	self.var_3abff2c8 = [];
	a_structs = struct::get_array(self.target);
	foreach(struct in a_structs)
	{
		switch(struct.script_noteworthy)
		{
			case "hash_3e8f0dc79ba8ae20":
			{
				self.var_3abff2c8[self.var_3abff2c8.size] = struct;
				break;
			}
			case "hash_238372761f11df6b":
			{
				self.var_e531b8b8 = struct;
				break;
			}
			case "hash_39dd00cf30f3702f":
			{
				self.var_6f76e7b0 = struct;
				break;
			}
		}
	}
	a_ents = getentarray(self.target, "targetname");
	foreach(ent in a_ents)
	{
		if(ent getentitytype() == 6)
		{
			self.var_6f7cfe6d = ent;
			continue;
		}
		if(ent getentitytype() == 20)
		{
			self.var_f02fb354 = ent;
		}
	}
}

/*
	Name: function_ae4e9016
	Namespace: namespace_b45e3f05
	Checksum: 0x48574260
	Offset: 0x5B40
	Size: 0x824
	Parameters: 0
	Flags: Linked
*/
function function_ae4e9016()
{
	s_unitrigger = self zm_unitrigger::create();
	zm_unitrigger::function_47625e58(s_unitrigger, self.origin + vectorscale((0, 0, 1), 32));
	self.var_2aba91c4 = 1;
	while(!isdefined(self.var_d6249c56))
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger_activated");
		e_player = waitresult.e_who;
		if(self.var_2aba91c4)
		{
			if(level.var_534a0586)
			{
				level.var_8237e7d3.origin = self.origin;
				level.var_8237e7d3.angles = self.angles;
				level.var_8237e7d3 show();
				playsoundatposition(#"hash_674add1cacda8f0a", level.var_8237e7d3.origin);
				level.var_8237e7d3 playloopsound(#"hash_648b3ad720f4123", 0.1);
				level.var_8237e7d3 thread scene::play(#"p8_fxanim_zm_zod_safe_cracker_ee_bundle", "combo_" + self.var_83fad8a9, level.var_8237e7d3);
				wait(4);
				playsoundatposition(#"hash_d47a6b375de9091", level.var_8237e7d3.origin);
				level.var_8237e7d3 stoploopsound(0.05);
				wait(1);
				level.var_8237e7d3 scene::stop(#"p8_fxanim_zm_zod_safe_cracker_ee_bundle");
				level.var_8237e7d3 unlink();
				level.var_8237e7d3 linkto(self.var_6f7cfe6d);
				self.var_6f7cfe6d rotateyaw(90, 0.25, 0.25);
				self.var_6f7cfe6d playsound(#"zmb_safe_open");
				self.var_6f7cfe6d waittill(#"rotatedone");
				self.var_6f7cfe6d playloopsound(#"hash_11a6234e1396e816");
				level.var_534a0586 = 0;
				self.var_2aba91c4 = 0;
				if(isalive(e_player))
				{
					e_player zm_audio::create_and_play_dialog(#"safe", #"unlock");
				}
			}
		}
		else if(isdefined(e_player.var_d6249c56))
		{
			switch(e_player.var_d6249c56.script_noteworthy)
			{
				case "hash_1038ceaeafe155b3":
				case "hash_798f4232dfe03b8c":
				{
					v_dest = self.var_6f76e7b0.origin;
					e_player.var_d6249c56.angles = self.var_6f76e7b0.angles;
					break;
				}
				case "hash_516e96f51e5bb4b3":
				{
					v_dest = self.var_6f76e7b0.origin + vectorscale((0, 0, 1), 0.5);
					e_player.var_d6249c56.angles = self.var_6f76e7b0.angles;
					break;
				}
				case "hash_12aa5802889224df":
				{
					v_dest = self.var_6f76e7b0.origin + (0, 0, 1);
					e_player.var_d6249c56.angles = self.var_6f76e7b0.angles + (0, 75, -90);
					break;
				}
			}
			v_forward = anglestoforward(self.var_6f76e7b0.angles);
			e_player.var_d6249c56.origin = v_dest + v_forward * 16;
			e_player.var_d6249c56 show();
			e_player.var_d6249c56 moveto(v_dest, 1.5, 1);
			e_player.var_d6249c56 playsound(#"hash_383e684a50e2025f");
			e_player.var_d6249c56 waittill(#"movedone");
			wait(1);
			self.var_6f7cfe6d rotateyaw(-90, 0.25, 0.25);
			self.var_6f7cfe6d playsound(#"hash_1a6dadbf4537bb61");
			self.var_6f7cfe6d stoploopsound(0.5);
			self.var_6f7cfe6d waittill(#"rotatedone");
			level.var_8237e7d3 unlink();
			foreach(var_aed8d635 in self.var_3abff2c8)
			{
				if(isdefined(var_aed8d635.mdl_number))
				{
					var_aed8d635.mdl_number delete();
				}
			}
			self.var_d6249c56 = e_player.var_d6249c56;
			e_player.var_d6249c56 = undefined;
		}
	}
	zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
	self.var_6f7cfe6d clientfield::set("" + #"hash_586ccfc5deedc573", 1);
	level.var_f39ad20a++;
	if(level.var_f39ad20a == 4)
	{
		level notify(#"hash_543e0c29db385264");
	}
	if(self.var_d6249c56.var_83fad8a9 == self.var_83fad8a9)
	{
		level.var_637aeeb8++;
	}
	waitframe(1);
	if(level flag::get(#"hash_2aaea7cd22f44712") == 0)
	{
		level.var_8237e7d3 thread function_c0174de(self.var_f02fb354, self.var_e531b8b8);
	}
}

/*
	Name: on_disconnect
	Namespace: namespace_b45e3f05
	Checksum: 0x35BAEEF3
	Offset: 0x6370
	Size: 0x72
	Parameters: 0
	Flags: Linked
*/
function on_disconnect()
{
	var_d6249c56 = self.var_d6249c56;
	if(isdefined(var_d6249c56))
	{
		var_d6249c56.origin = var_d6249c56.original_origin;
		var_d6249c56.angles = var_d6249c56.original_angles;
		var_d6249c56 show();
		var_d6249c56.b_taken = 0;
	}
}

/*
	Name: function_e9104d6d
	Namespace: namespace_b45e3f05
	Checksum: 0x652E07CD
	Offset: 0x63F0
	Size: 0x14C
	Parameters: 1
	Flags: Linked
*/
function function_e9104d6d(var_a276c861)
{
	if(isdefined(level.var_8237e7d3))
	{
		level.var_8237e7d3 thread util::function_f9af3d43(30);
	}
	if(!var_a276c861)
	{
		while(!isdefined(level.var_5df2581a[#"zblueprint_shield_dual_wield"]) || level.var_5df2581a[#"zblueprint_shield_dual_wield"].completed !== 1)
		{
			/#
				if(getdvarint(#"hash_11ad6a9695943217", 0))
				{
					break;
				}
			#/
			wait(3);
		}
		s_loc = struct::get(#"hash_43dc57b8641ea004");
		s_loc zm_unitrigger::create(undefined, undefined, &zm_unitrigger::function_69168e61);
		s_loc thread function_7f18a333();
		level flag::wait_till(#"hash_3799c8bb28e2f2f");
	}
}

/*
	Name: function_2ff57042
	Namespace: namespace_b45e3f05
	Checksum: 0xA75FFC6E
	Offset: 0x6548
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function function_2ff57042(var_a276c861, var_19e802fa)
{
}

/*
	Name: function_7f18a333
	Namespace: namespace_b45e3f05
	Checksum: 0x4B7F9616
	Offset: 0x6568
	Size: 0x58E
	Parameters: 0
	Flags: Linked
*/
function function_7f18a333()
{
	var_ef1e7447 = getent("portal_block", "targetname");
	var_3bac6db4 = getent(self.target, "targetname");
	var_3bac6db4 val::set("boney_jones_car", "takedamage", 0);
	level.var_438aa88 = var_3bac6db4;
	v_origin = var_3bac6db4.origin;
	v_angles = var_3bac6db4.angles;
	var_3bac6db4 endon(#"death");
	var_ef1e7447 show();
	var_ef1e7447 playloopsound(#"hash_6ab30aa83cfad114", 0.1);
	exploder::exploder("exp_bubbles_sink");
	var_ef1e7447 moveto(var_ef1e7447.origin + vectorscale((0, 0, 1), 12), 1);
	var_ef1e7447 waittill(#"movedone");
	var_3bac6db4 moveto(var_3bac6db4.origin + (0, 0, -100), 9);
	var_3bac6db4 waittill(#"movedone");
	var_3bac6db4 thread scene::init(#"hash_322be85f9a112e9");
	var_3bac6db4 moveto(var_3bac6db4.origin + (0, 0, -100 * -1), 9);
	var_3bac6db4 waittill(#"movedone");
	var_ef1e7447 stoploopsound(1);
	exploder::stop_exploder("exp_bubbles_sink");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger_activated");
		e_player = waitresult.e_who;
		if(!zm_utility::can_use(e_player))
		{
			continue;
		}
		e_player util::delay(2, "death", &zm_audio::create_and_play_dialog, #"hash_16dd1d91375976f3", #"interact");
		exploder::exploder("exp_bubbles_sink");
		var_3bac6db4 moveto(var_3bac6db4.origin + (0, 0, -100), 9);
		var_3bac6db4 playsound(#"hash_3749463f3dab5c50");
		var_3bac6db4 playloopsound(#"hash_6ab30aa83cfad114", 0.1);
		var_3bac6db4 waittill(#"movedone");
		var_3bac6db4 stoploopsound(1);
		var_3bac6db4.angles = (0, 0, 0);
		exploder::stop_exploder("exp_bubbles_sink");
		wait(3);
		var_3bac6db4 thread scene::play(#"hash_322be85f9a112e9");
		function_75bdcb53(var_3bac6db4);
		if(!level flag::get(#"hash_3799c8bb28e2f2f"))
		{
			level waittill(#"end_of_round");
			var_3bac6db4.origin = v_origin + (0, 0, -100);
			var_3bac6db4.angles = v_angles;
			var_3bac6db4 thread scene::init(#"hash_322be85f9a112e9");
			exploder::exploder("exp_bubbles_sink");
			var_3bac6db4 playloopsound(#"hash_6ab30aa83cfad114", 0.1);
			var_3bac6db4 moveto(var_3bac6db4.origin + (0, 0, -100 * -1), 9);
			var_3bac6db4 waittill(#"movedone");
			var_3bac6db4 stoploopsound(1);
			exploder::stop_exploder("exp_bubbles_sink");
		}
		else
		{
			return;
		}
	}
}

/*
	Name: function_75bdcb53
	Namespace: namespace_b45e3f05
	Checksum: 0x895CE577
	Offset: 0x6B00
	Size: 0x374
	Parameters: 1
	Flags: Linked
*/
function function_75bdcb53(var_3bac6db4)
{
	n_start_round = level.round_number;
	veh_car = spawner::simple_spawn_single(getent("veh_fasttravel_cam", "targetname"));
	veh_car val::set("boney_jones_car", "takedamage", 0);
	var_3bac6db4.origin = veh_car.origin;
	var_3bac6db4 linkto(veh_car);
	nd_start = getvehiclenode("jones_start_node", "targetname");
	var_3bac6db4 clientfield::set("" + #"hash_22414550f1988f04", 1);
	while(n_start_round + 3 > level.round_number && !level flag::get(#"hash_3799c8bb28e2f2f"))
	{
		/#
			if(getdvarint(#"hash_7919e37cd5d57659", 0))
			{
				iprintlnbold("");
				println("");
			}
		#/
		var_3bac6db4 playsound(#"hash_785ac4e15d8585c4");
		var_3bac6db4.var_e7bd7062 = 1;
		var_3bac6db4 thread function_f48b1de4();
		var_3bac6db4 thread function_cd85b198();
		var_3bac6db4 playloopsound(#"hash_58eb809a42974bb0", 0.1);
		veh_car vehicle::get_on_and_go_path(nd_start);
		var_3bac6db4 stoploopsound(0.1);
		var_3bac6db4 notify(#"reached_end_node");
		var_3bac6db4.var_e7bd7062 = 0;
		level waittill(#"start_of_round");
	}
	var_3bac6db4 notify(#"hash_1c5829c4d999a17d");
	var_3bac6db4 clientfield::set("" + #"hash_22414550f1988f04", 0);
	var_3bac6db4 unlink();
	veh_car delete();
	/#
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			iprintlnbold("");
			println("");
		}
	#/
}

/*
	Name: function_cd85b198
	Namespace: namespace_b45e3f05
	Checksum: 0xA92E17B3
	Offset: 0x6E80
	Size: 0x2D4
	Parameters: 0
	Flags: Linked
*/
function function_cd85b198()
{
	var_2e1f34dd = util::spawn_model(#"p8_fxanim_zm_towers_crowd_jar_01_mod", self.origin, self.angles);
	var_2e1f34dd linkto(self);
	level waittill(#"hash_7faa53de48fa73b0");
	var_2e1f34dd unlink();
	var_2e1f34dd fx::play(#"hash_6d900123df67f4ce", var_2e1f34dd.origin, var_2e1f34dd.angles, #"hash_1c8b3202700d2fb4", 1);
	var_edbc66b6 = struct::get(#"hash_6cf786a7b61d7c70");
	n_time = var_2e1f34dd zm_utility::fake_physicslaunch(var_edbc66b6.origin, 600);
	var_2e1f34dd rotate((200, 90, 150));
	wait(n_time);
	fx::play(#"hash_43cec289a09441e9", var_edbc66b6.origin, var_edbc66b6.angles + vectorscale((1, 0, 0), 270));
	var_2e1f34dd notify(#"hash_1c8b3202700d2fb4");
	var_2e1f34dd.origin = var_edbc66b6.origin;
	var_edbc66b6 thread scene::play(#"p8_fxanim_zm_towers_crowd_jar_01_bundle", var_2e1f34dd);
	earthquake(0.3, 0.5, var_edbc66b6.origin, 256);
	str_powerup = array::random(array(#"double_points", #"full_ammo", #"insta_kill"));
	zm_powerups::specific_powerup_drop(str_powerup, var_edbc66b6.origin, undefined, undefined, undefined, 1);
	self zm_audio::function_ef9ba49c(#"hash_16dd1d91375976f3", 0, undefined, 1024);
}

/*
	Name: function_f48b1de4
	Namespace: namespace_b45e3f05
	Checksum: 0xBFF48827
	Offset: 0x7160
	Size: 0xD0
	Parameters: 0
	Flags: Linked
*/
function function_f48b1de4()
{
	self endon(#"death", #"hash_1c5829c4d999a17d", #"reached_end_node");
	while(true)
	{
		level waittill(#"hash_37576a3ecfecdb2e");
		wait(randomfloatrange(0.1, 1));
		self playsound(#"hash_5ae1f398279d453");
		wait(randomintrange(4, 7));
		self playsound(#"hash_2d1b8ed1a16ecfb1");
	}
}

/*
	Name: function_b9b8f31d
	Namespace: namespace_b45e3f05
	Checksum: 0xF6C12EF6
	Offset: 0x7238
	Size: 0x70
	Parameters: 0
	Flags: Linked
*/
function function_b9b8f31d()
{
	level waittill(#"power_on");
	while(true)
	{
		trigger = trigger::wait_till("berths_walk_start", "targetname");
		function_f80bde48(trigger.who);
	}
}

/*
	Name: function_f80bde48
	Namespace: namespace_b45e3f05
	Checksum: 0x67D51C06
	Offset: 0x72B0
	Size: 0x35A
	Parameters: 1
	Flags: Linked
*/
function function_f80bde48(player)
{
	if(isplayer(player) && player getstance() === #"crouch" && player usebuttonpressed())
	{
		player endon(#"death", #"weapon_fired", #"weapon_ads");
		e_path = getent("berths_walk", "targetname");
		while(player getstance() === #"crouch" && player usebuttonpressed() && player istouching(e_path))
		{
			wait(0.2);
		}
		s_end = struct::get(#"hash_13758f136c6ab4bf");
		if(distance2dsquared(player.origin, s_end.origin) < 1024)
		{
			player waittill(#"weapon_melee");
			player waittill(#"weapon_melee");
			player endon(#"weapon_melee");
			player waittill(#"weapon_change_complete");
			if(distance2dsquared(player.origin, s_end.origin) < 1024 && player getstance() !== #"crouch")
			{
				if(isdefined(level.var_438aa88) && (isdefined(level.var_438aa88.var_e7bd7062) && level.var_438aa88.var_e7bd7062))
				{
					player thread function_92b18f69();
					level waittill(#"hash_2f73fa7def66db4e");
				}
				else if(level.round_number === 9 && level flag::get(#"hash_2d1cd18f39ac5fa7"))
				{
					player giveweapon(getweapon(#"hash_5b8d1ff4b772bd85"));
					player giveweapon(getweapon(#"hash_10f614b278daaebc"));
				}
			}
		}
	}
	wait(1);
}

/*
	Name: function_92b18f69
	Namespace: namespace_b45e3f05
	Checksum: 0x86BBBE2B
	Offset: 0x7618
	Size: 0xD8
	Parameters: 0
	Flags: Linked
*/
function function_92b18f69()
{
	var_86a1a1a2 = self.origin;
	self function_f7038e44();
	self unlink();
	self setorigin(var_86a1a1a2);
	self show();
	self val::reset(#"hash_67fc98bb601e0da0", "ignoreme");
	self val::reset(#"hash_67fc98bb601e0da0", "takedamage");
	level notify(#"hash_2f73fa7def66db4e");
}

/*
	Name: function_f7038e44
	Namespace: namespace_b45e3f05
	Checksum: 0x271EDEA0
	Offset: 0x76F8
	Size: 0x130
	Parameters: 0
	Flags: Linked
*/
function function_f7038e44()
{
	self endon(#"death", #"weapon_melee", #"weapon_fired");
	level.var_438aa88 endon(#"death", #"hash_1c5829c4d999a17d", #"reached_end_node");
	var_86a1a1a2 = self.origin;
	self val::set(#"hash_67fc98bb601e0da0", "ignoreme", 1);
	self val::set(#"hash_67fc98bb601e0da0", "takedamage", 0);
	self ghost();
	self playerlinktodelta(level.var_438aa88, "tag_driver", 1);
	level waittill_timeout(60, #"hash_4c84b8326097daf6");
}

/*
	Name: function_1a1d203a
	Namespace: namespace_b45e3f05
	Checksum: 0x55B51CC3
	Offset: 0x7830
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function function_1a1d203a(var_a276c861)
{
	if(!var_a276c861)
	{
		function_23c7360a();
		level scene::play(#"p8_fxanim_zm_zod_table_icechunk_bundle");
		function_73bdaf30();
	}
}

/*
	Name: function_127efb37
	Namespace: namespace_b45e3f05
	Checksum: 0x451D3203
	Offset: 0x7890
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function function_127efb37(var_a276c861, var_19e802fa)
{
	getent("portal_block", "targetname") delete();
}

/*
	Name: function_98689e80
	Namespace: namespace_b45e3f05
	Checksum: 0x2BFE76F4
	Offset: 0x78E0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_98689e80()
{
	level waittill(#"hash_4c84b8326097daf6");
	wait(4);
	playsoundatposition(#"hash_5515ce05a0767859", (0, 0, 0));
}

/*
	Name: function_23c7360a
	Namespace: namespace_b45e3f05
	Checksum: 0x9DB846B9
	Offset: 0x7930
	Size: 0x1FC
	Parameters: 0
	Flags: Linked
*/
function function_23c7360a()
{
	level thread function_98689e80();
	var_3bac6db4 = level.var_438aa88;
	if(isdefined(var_3bac6db4) && (isdefined(var_3bac6db4.var_e7bd7062) && var_3bac6db4.var_e7bd7062))
	{
		var_3bac6db4 waittill(#"reached_end_node");
		var_3bac6db4 playsound(#"hash_7beb8c1c8eed903d");
	}
	level clientfield::set("" + #"hash_6fdd80bc96ddfb93", 1);
	wait(0.5);
	v_loc = struct::get(#"hash_27613769597daaf0").origin;
	foreach(player in util::get_active_players())
	{
		if(player util::is_looking_at(v_loc))
		{
			b_vo_played = player zm_audio::create_and_play_dialog(#"car", #"crash");
			if(isdefined(b_vo_played) && b_vo_played)
			{
				return;
			}
		}
	}
	wait(5);
	var_3bac6db4 delete();
}

/*
	Name: function_73bdaf30
	Namespace: namespace_b45e3f05
	Checksum: 0xCC67741B
	Offset: 0x7B38
	Size: 0x434
	Parameters: 0
	Flags: Linked
*/
function function_73bdaf30()
{
	exploder::exploder("exp_lgt_crafting_alt");
	var_e9e88745 = getent("shield_model", "targetname");
	if(isdefined(var_e9e88745))
	{
		var_e9e88745 playsound(#"hash_4e75eec96f7ea36a");
		var_e9e88745 setmodel(#"hash_7f061176170234d9");
		var_e9e88745 clientfield::set("" + #"hash_2ec182fecae80e80", 1);
		earthquake(0.5, 1.25, var_e9e88745.origin, 512);
		if(isdefined(level.ai[#"axis"]))
		{
			var_dce7716b = array::get_all_closest(var_e9e88745.origin, level.ai[#"axis"], undefined, undefined, 200);
			var_cd02461b = array::filter(var_dce7716b, 0, &namespace_eaaeba61::function_6c856fde);
			foreach(e_zombie in var_cd02461b)
			{
				e_zombie zombie_utility::setup_zombie_knockdown(var_e9e88745.origin);
			}
		}
	}
	var_425fb862 = level.var_4fe2f84d[#"zblueprint_shield_dual_wield"];
	foreach(struct in var_425fb862)
	{
		if(struct.script_noteworthy === #"hash_71013586ba8bd1d7")
		{
			var_f4e690cf = namespace_a1d9b01d::function_b18074d0(#"hash_332fbe57f2dd01f0");
			struct.craftfoundry = var_f4e690cf;
			struct.blueprint = var_f4e690cf;
			break;
		}
	}
	foreach(player in util::get_active_players())
	{
		player aat::acquire(getweapon(#"hash_62d7f56331878d18"), "zm_aat_frostbite");
		player zm_pap_util::function_18994aca(getweapon(#"hash_62d7f56331878d18"), 4);
		player thread function_bf9f03e1();
		player.var_5ba94c1e = 1;
	}
	callback::on_connect(&function_bd64f794);
	callback::on_spawned(&function_bf9f03e1);
}

/*
	Name: function_bf9f03e1
	Namespace: namespace_b45e3f05
	Checksum: 0x72E3F9F1
	Offset: 0x7F78
	Size: 0x10E
	Parameters: 0
	Flags: Linked
*/
function function_bf9f03e1()
{
	var_95f83c9 = getweapon(#"hash_62d7f56331878d18");
	self.var_5ba94c1e = 1;
	self thread function_a5214a8d(var_95f83c9);
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"hash_77d44943fb143b18", #"death");
		if(var_88706ea7._notify === #"hash_77d44943fb143b18" && var_88706ea7.weapon === var_95f83c9)
		{
			self aat::acquire(var_95f83c9, "zm_aat_frostbite");
			self zm_pap_util::function_18994aca(var_95f83c9, 4);
		}
		else
		{
			return;
		}
	}
}

/*
	Name: function_9693e041
	Namespace: namespace_b45e3f05
	Checksum: 0xF4AAC98C
	Offset: 0x8090
	Size: 0x102
	Parameters: 1
	Flags: Linked
*/
function function_9693e041(player)
{
	var_95f83c9 = getweapon(#"hash_62d7f56331878d18");
	if(player hasweapon(var_95f83c9))
	{
		if(isdefined(self.blueprint.var_54a97edd.isriotshield) && self.blueprint.var_54a97edd.isriotshield && isdefined(player.player_shield_reset_health) && (isdefined(player.var_d3345483) && player.var_d3345483))
		{
			self.hint_string = zm_utility::function_d6046228(#"hash_5c35bbb6c39ba19a", #"hash_3bf7b3dc87b1015e");
			var_5435aca = 1;
		}
	}
}

/*
	Name: function_a5214a8d
	Namespace: namespace_b45e3f05
	Checksum: 0x907DBBD5
	Offset: 0x81A0
	Size: 0x118
	Parameters: 1
	Flags: Linked
*/
function function_a5214a8d(var_95f83c9)
{
	self endon(#"disconnect");
	var_a8abef1d = getweapon(#"hash_5ce0422cff84b2b3");
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"weapon_change", #"death");
		if(var_88706ea7.weapon === var_95f83c9 || var_88706ea7.weapon === var_a8abef1d)
		{
			self clientfield::set("" + #"hash_794e5d0769b1d497", 1);
		}
		else
		{
			self clientfield::set("" + #"hash_794e5d0769b1d497", 0);
		}
	}
}

/*
	Name: function_bd64f794
	Namespace: namespace_b45e3f05
	Checksum: 0xDC329C2A
	Offset: 0x82C0
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_bd64f794()
{
	while(isdefined(self) && self util::function_bf5a8f5c())
	{
		wait(1);
	}
	if(isdefined(self))
	{
		self aat::acquire(getweapon(#"hash_62d7f56331878d18"), "zm_aat_frostbite");
		self zm_pap_util::function_18994aca(getweapon(#"hash_62d7f56331878d18"), 4);
	}
}

/*
	Name: function_62c5099d
	Namespace: namespace_b45e3f05
	Checksum: 0x33F0B7BD
	Offset: 0x8378
	Size: 0x2C4
	Parameters: 0
	Flags: Linked
*/
function function_62c5099d()
{
	level endon(#"end_game");
	level.var_d241eaa9 = struct::get_array(#"hash_4c7e3f796cc065cf");
	foreach(var_e5da245 in level.var_d241eaa9)
	{
		var_e5da245.var_f0bbde5 = struct::get(var_e5da245.target);
		var_e5da245 flag::init(#"hash_2078d5bf94139877");
		s_unitrigger = var_e5da245 zm_unitrigger::create(undefined, undefined, &function_acfd770e);
		zm_unitrigger::function_47625e58(s_unitrigger, s_unitrigger.origin + vectorscale((0, 0, 1), 32));
		zm_unitrigger::function_89380dda(s_unitrigger);
	}
	level.var_fd1d03ff = struct::get_array(#"hash_4f342e0539cf25df");
	level.var_252b49cc = struct::get_array(#"hash_499aa18783aee42a");
	level.var_ba8e1acf = array(#"red", #"green", #"blue");
	while(true)
	{
		level waittill(#"start_of_round");
		foreach(var_e5da245 in level.var_d241eaa9)
		{
			var_e5da245 flag::clear(#"hash_2078d5bf94139877");
		}
		while(level.var_ba8e1acf.size > 0)
		{
			function_a68ce358();
		}
	}
}

/*
	Name: function_a68ce358
	Namespace: namespace_b45e3f05
	Checksum: 0x6E0E5BDE
	Offset: 0x8648
	Size: 0x1D4
	Parameters: 0
	Flags: Linked
*/
function function_a68ce358()
{
	n_index = randomint(level.var_fd1d03ff.size);
	var_2cb1cbce = level.var_fd1d03ff[n_index];
	arrayremoveindex(level.var_fd1d03ff, n_index);
	n_index = randomint(level.var_ba8e1acf.size);
	str_color = level.var_ba8e1acf[n_index];
	arrayremoveindex(level.var_ba8e1acf, n_index);
	var_a4bb6a54 = function_80b485e9(var_2cb1cbce.origin + vectorscale((0, 0, -1), 8), var_2cb1cbce.angles, str_color);
	var_a4bb6a54 moveto(var_2cb1cbce.origin, 0.2);
	var_a4bb6a54 waittill(#"movedone");
	var_a4bb6a54 thread scene::play(#"p8_fxanim_zm_zod_pneumatic_tube_flare_bundle", var_a4bb6a54);
	n_index = randomint(level.var_252b49cc.size);
	var_46a3f206 = level.var_252b49cc[n_index];
	arrayremoveindex(level.var_252b49cc, n_index);
	var_a4bb6a54 thread function_e01b477f(var_2cb1cbce, var_46a3f206);
}

/*
	Name: function_80b485e9
	Namespace: namespace_b45e3f05
	Checksum: 0x57A21F71
	Offset: 0x8828
	Size: 0x178
	Parameters: 3
	Flags: Linked
*/
function function_80b485e9(v_origin, v_angles, str_color)
{
	switch(str_color)
	{
		case "green":
		{
			str_model = #"hash_182d806f8f8bd7bf";
			break;
		}
		case "blue":
		{
			str_model = #"hash_4f89af3e6c667d42";
			break;
		}
		default:
		{
			str_model = #"hash_1263e29ccfb2e70b";
			break;
		}
	}
	var_a4bb6a54 = util::spawn_model(str_model, v_origin, v_angles);
	var_a4bb6a54 setscale(0.8);
	var_a4bb6a54 val::set(#"hash_684469e9c9286767", "allowdeath", 0);
	var_a4bb6a54 val::set(#"hash_684469e9c9286767", "takedamage", 1);
	var_a4bb6a54.str_color = str_color;
	var_a4bb6a54 flag::init(#"hash_2078d5bf94139877");
	return var_a4bb6a54;
}

/*
	Name: give_flare
	Namespace: namespace_b45e3f05
	Checksum: 0xBBE3D727
	Offset: 0x89A8
	Size: 0x114
	Parameters: 1
	Flags: None
*/
function give_flare(str_color)
{
	/#
		foreach(player in util::get_active_players())
		{
			var_a4bb6a54 = function_80b485e9((0, 0, 0), (0, 0, 0), str_color);
			player.var_a4bb6a54 = var_a4bb6a54;
		}
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			iprintlnbold(str_color + "");
			println(str_color + "");
		}
	#/
}

/*
	Name: function_e01b477f
	Namespace: namespace_b45e3f05
	Checksum: 0xBAE53D32
	Offset: 0x8AC8
	Size: 0x4CA
	Parameters: 2
	Flags: Linked
*/
function function_e01b477f(var_2cb1cbce, var_46a3f206)
{
	level endon(#"end_game");
	self endon(#"death");
	waitresult = undefined;
	waitresult = self waittill(#"damage");
	if(isplayer(waitresult.attacker))
	{
		waitresult.attacker util::show_hit_marker();
	}
	self scene::stop(#"p8_fxanim_zm_zod_pneumatic_tube_flare_bundle");
	self moveto(self.origin + vectorscale((0, 0, 1), 8), 0.35);
	self playsound(#"hash_33fa1a9c8d819b09");
	self waittill(#"movedone");
	self hide();
	wait(randomintrange(5, 10));
	self.origin = var_46a3f206.origin;
	self.angles = var_46a3f206.angles;
	self show();
	s_dest = struct::get(var_46a3f206.target);
	self moveto(s_dest.origin, 0.35);
	self playsound(#"hash_43c5172452b852a5");
	self waittill(#"movedone");
	s_unitrigger = s_dest zm_unitrigger::create(&function_75caa23f, 128);
	zm_unitrigger::function_89380dda(s_unitrigger);
	waitresult = undefined;
	waitresult = s_dest waittill(#"trigger_activated");
	waitresult.e_who zm_audio::create_and_play_dialog(#"hash_44b4edd3d705820d", #"generic");
	zm_unitrigger::unregister_unitrigger(s_unitrigger);
	level.var_fd1d03ff[level.var_fd1d03ff.size] = var_2cb1cbce;
	level.var_252b49cc[level.var_252b49cc.size] = var_46a3f206;
	/#
		switch(self.str_color)
		{
			case "red":
			{
				if(getdvarint(#"hash_7919e37cd5d57659", 0))
				{
					iprintlnbold("");
					println("");
				}
				break;
			}
			case "green":
			{
				if(getdvarint(#"hash_7919e37cd5d57659", 0))
				{
					iprintlnbold("");
					println("");
				}
				break;
			}
			case "blue":
			{
				if(getdvarint(#"hash_7919e37cd5d57659", 0))
				{
					iprintlnbold("");
					println("");
				}
				break;
			}
		}
	#/
	self playsound(#"hash_bf7d2ff0e430576");
	self hide();
	waitresult.e_who.var_a4bb6a54 = self;
	level.var_ba8e1acf[level.var_ba8e1acf.size] = self.str_color;
}

/*
	Name: function_75caa23f
	Namespace: namespace_b45e3f05
	Checksum: 0x958588F9
	Offset: 0x8FA0
	Size: 0x46
	Parameters: 1
	Flags: Linked
*/
function function_75caa23f(e_player)
{
	if(!zm_utility::can_use(e_player) || isdefined(e_player.var_a4bb6a54))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_acfd770e
	Namespace: namespace_b45e3f05
	Checksum: 0x6751D5D1
	Offset: 0x8FF0
	Size: 0x1CA
	Parameters: 0
	Flags: Linked
*/
function function_acfd770e()
{
	level endon(#"end_game");
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		e_player = waitresult.activator;
		if(zm_utility::can_use(e_player) && isdefined(e_player.var_a4bb6a54))
		{
			var_a4bb6a54 = e_player.var_a4bb6a54;
			struct = self.stub.related_parent;
			var_a4bb6a54 setscale(1.1);
			var_a4bb6a54.origin = struct.origin;
			var_a4bb6a54.angles = struct.angles;
			var_a4bb6a54 show();
			if(isdefined(struct.var_a4bb6a54))
			{
				struct.var_a4bb6a54 delete();
			}
			struct.var_a4bb6a54 = var_a4bb6a54;
			var_a4bb6a54.var_e5da245 = struct;
			playsoundatposition(#"hash_1cedcfe708cf2627", var_a4bb6a54.var_e5da245.origin);
			var_a4bb6a54 thread function_7ae29395();
			e_player.var_a4bb6a54 = undefined;
		}
	}
}

/*
	Name: function_7ae29395
	Namespace: namespace_b45e3f05
	Checksum: 0xBBA51F2B
	Offset: 0x91C8
	Size: 0x2AA
	Parameters: 0
	Flags: Linked
*/
function function_7ae29395()
{
	level endon(#"end_game");
	self endon_callback(&function_a65045b6, #"death");
	v_offset = vectorscale((0, 0, -1), 8);
	self.trigger = spawn("trigger_damage", self.origin + v_offset, 0, 2.5, 24.5);
	while(true)
	{
		waitresult = undefined;
		waitresult = self.trigger waittill(#"trigger");
		if(isplayer(waitresult.activator))
		{
			self.var_e5da245 flag::set(#"hash_2078d5bf94139877");
			var_a3c52257 = 0;
			foreach(var_e5da245 in level.var_d241eaa9)
			{
				if(var_e5da245 flag::get(#"hash_2078d5bf94139877"))
				{
					var_a3c52257++;
				}
			}
			if(var_a3c52257 == 4 && level.var_8c1a6e03 !== 1)
			{
				level.var_8c1a6e03 = 1;
				foreach(var_e5da245 in level.var_d241eaa9)
				{
					level thread function_9fa09d36(var_e5da245.var_a4bb6a54);
				}
				level thread function_5f7192b8();
			}
			else
			{
				level thread function_9fa09d36(self);
			}
			self.trigger delete();
			return;
		}
	}
}

/*
	Name: function_a65045b6
	Namespace: namespace_b45e3f05
	Checksum: 0x977C7B30
	Offset: 0x9480
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_a65045b6(var_88706ea7)
{
	if(isdefined(self) && isdefined(self.trigger))
	{
		self.trigger delete();
	}
}

/*
	Name: function_9fa09d36
	Namespace: namespace_b45e3f05
	Checksum: 0x8D39C94C
	Offset: 0x94C8
	Size: 0x1FC
	Parameters: 1
	Flags: Linked
*/
function function_9fa09d36(var_a4bb6a54)
{
	var_a4bb6a54 endon(#"hash_714cd031b5f28ab8", #"death");
	var_45f93277 = function_80b485e9(var_a4bb6a54.origin, var_a4bb6a54.angles, var_a4bb6a54.str_color);
	var_a4bb6a54.var_e5da245.var_a4bb6a54 = var_45f93277;
	var_45f93277.var_e5da245 = var_a4bb6a54.var_e5da245;
	var_45f93277 setscale(1.1);
	var_45f93277 hide();
	var_45f93277 thread function_74ae705a();
	if(var_a4bb6a54 ishidden())
	{
		var_a4bb6a54 show();
	}
	var_a4bb6a54 moveto(var_a4bb6a54.var_e5da245.var_f0bbde5.origin, 1.5);
	var_a4bb6a54 playsound(#"hash_7cccfcd334265ea5");
	var_a4bb6a54 thread function_9a6d950f();
	var_a4bb6a54 flare_fx(var_a4bb6a54.str_color);
	var_a4bb6a54 playsound(#"hash_3abb70f0e8764ecc");
	var_a4bb6a54 ghost();
	wait(5);
	var_a4bb6a54 delete();
}

/*
	Name: function_9a6d950f
	Namespace: namespace_b45e3f05
	Checksum: 0x42C198AC
	Offset: 0x96D0
	Size: 0x244
	Parameters: 0
	Flags: Linked
*/
function function_9a6d950f()
{
	if(isdefined(level.var_438aa88))
	{
		var_3bac6db4 = level.var_438aa88;
	}
	else
	{
		return;
	}
	while(isdefined(self) && isdefined(var_3bac6db4))
	{
		if(self istouching(var_3bac6db4) || getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			self notify(#"hash_714cd031b5f28ab8");
			self.origin = var_3bac6db4.origin;
			self linkto(var_3bac6db4);
			switch(self.str_color)
			{
				case "red":
				{
					self clientfield::set("" + #"hash_2042191a7fc75994", 1);
					break;
				}
				case "green":
				{
					self clientfield::set("" + #"hash_2042191a7fc75994", 2);
					break;
				}
				case "blue":
				{
					self clientfield::set("" + #"hash_2042191a7fc75994", 3);
					break;
				}
			}
			self playsound(#"hash_5a8158d766d5258b");
			level flag::set(#"hash_3799c8bb28e2f2f");
			break;
		}
		waitframe(1);
	}
	if(isdefined(var_3bac6db4))
	{
		var_3bac6db4 waittill(#"hash_1c5829c4d999a17d", #"death");
	}
	if(isdefined(self))
	{
		self delete();
	}
}

/*
	Name: function_74ae705a
	Namespace: namespace_b45e3f05
	Checksum: 0x7068369A
	Offset: 0x9920
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_74ae705a()
{
	level endon(#"end_game");
	self endon(#"death");
	wait(30 - 1.5);
	self show();
	self function_7ae29395();
}

/*
	Name: flare_fx
	Namespace: namespace_b45e3f05
	Checksum: 0x15D2F7FB
	Offset: 0x99A0
	Size: 0x13C
	Parameters: 1
	Flags: Linked
*/
function flare_fx(str_color)
{
	level endon(#"end_game");
	switch(str_color)
	{
		case "red":
		{
			self clientfield::set("" + #"flare_fx", 1);
			break;
		}
		case "green":
		{
			self clientfield::set("" + #"flare_fx", 2);
			break;
		}
		case "blue":
		{
			self clientfield::set("" + #"flare_fx", 3);
			break;
		}
	}
	self waittill(#"movedone");
	self clientfield::set("" + #"flare_fx", 0);
}

/*
	Name: function_5f7192b8
	Namespace: namespace_b45e3f05
	Checksum: 0xF8C448E6
	Offset: 0x9AE8
	Size: 0x2AE
	Parameters: 0
	Flags: Linked
*/
function function_5f7192b8()
{
	level endon(#"end_game");
	if(!level flag::get(#"hash_5721fa890b4af81a"))
	{
		level flag::set(#"hash_5721fa890b4af81a");
		a_players = util::get_players();
		n_points = int(2000 / a_players.size);
		foreach(player in a_players)
		{
			player zm_score::add_to_player_score(n_points);
		}
	}
	wait(1.5);
	exploder::exploder("fx_exp_flare_vista_red_white_blue");
	var_2cf73102 = [];
	foreach(var_e5da245 in level.var_d241eaa9)
	{
		if(isdefined(var_e5da245.var_a4bb6a54))
		{
			var_2cf73102[var_2cf73102.size] = var_e5da245.var_a4bb6a54.str_color;
		}
	}
	level thread function_7e1d7d08();
	for(i = 0; i < 50; i++)
	{
		str_color = var_2cf73102[randomint(var_2cf73102.size)];
		function_79956200(str_color);
		wait(randomfloatrange(0.1, 0.25));
	}
	level waittill(#"start_of_round");
	level.var_8c1a6e03 = undefined;
}

/*
	Name: function_7e1d7d08
	Namespace: namespace_b45e3f05
	Checksum: 0x103817C3
	Offset: 0x9DA0
	Size: 0x178
	Parameters: 0
	Flags: Linked
*/
function function_7e1d7d08()
{
	a_players = util::get_active_players();
	a_zones = array("zone_forecastle_upper", "zone_forecastle_lower", "zone_fore_deck", "zone_poop_deck", "zone_poop_deck_lower", "zone_mid_deck", "zone_fore_deck", "zone_sun_deck_stbd", "zone_sun_deck_port", "zone_aft_deck_lower", "zone_aft_deck");
	foreach(player in a_players)
	{
		if(isdefined(player))
		{
			if(player zm_zonemgr::is_player_in_zone(a_zones))
			{
				b_result = player zm_audio::create_and_play_dialog(#"fireworks", #"react");
				if(isdefined(b_result) && b_result)
				{
					wait(randomintrange(3, 6));
				}
			}
		}
	}
}

/*
	Name: function_79956200
	Namespace: namespace_b45e3f05
	Checksum: 0x4039FB40
	Offset: 0x9F20
	Size: 0xFA
	Parameters: 1
	Flags: Linked
*/
function function_79956200(str_color)
{
	switch(str_color)
	{
		case "red":
		{
			level clientfield::increment("" + #"hash_5df3db201b5f6ae0", 1);
			break;
		}
		case "green":
		{
			level clientfield::increment("" + #"hash_5df3db201b5f6ae0", 2);
			break;
		}
		case "blue":
		{
			level clientfield::increment("" + #"hash_5df3db201b5f6ae0", 3);
			break;
		}
	}
}

/*
	Name: function_a7669bbf
	Namespace: namespace_b45e3f05
	Checksum: 0x5034872F
	Offset: 0xA028
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function function_a7669bbf(var_a276c861)
{
	zm_melee_weapon::init(#"hash_6a9069969e6fa287", #"bowie_flourish", undefined, "bowie_upgrade", undefined, "bowie", undefined);
	zm_melee_weapon::set_fallback_weapon(#"bowie_knife", "zombie_fists_bowie");
	namespace_2ba51478::register_melee_weapon_for_level(#"hash_6a9069969e6fa287");
	callback::on_ai_damage(&function_cc7214a9);
}

/*
	Name: function_8e6ceabd
	Namespace: namespace_b45e3f05
	Checksum: 0x4730450A
	Offset: 0xA0E8
	Size: 0xF8
	Parameters: 2
	Flags: Linked
*/
function function_8e6ceabd(var_a276c861, var_19e802fa)
{
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			level flag::set(#"hash_525ff2b2a2f7d97a");
			level flag::wait_till("");
			foreach(player in util::get_active_players())
			{
				player thread function_2c343fd8();
			}
		}
	#/
}

/*
	Name: function_500ea537
	Namespace: namespace_b45e3f05
	Checksum: 0x9D3508AD
	Offset: 0xA1E8
	Size: 0x3B4
	Parameters: 1
	Flags: Linked
*/
function function_500ea537(params)
{
	if(isalive(self) && self.archetype === #"zombie" && params.weapon === getweapon(#"hash_6a9069969e6fa287"))
	{
		player = params.eattacker;
		if(isalive(player) && isplayer(player))
		{
			var_fa26e2a9 = randomintrange(20000, 30000);
			n_time = gettime();
			if(isdefined(player.var_7db39d3c) && player.var_7db39d3c + var_fa26e2a9 > n_time)
			{
				return;
			}
			if(randomint(100) > 60)
			{
				player util::delay(0.5, "death", &zm_audio::create_and_play_dialog, #"hash_109466146108268a", #"attack");
			}
			player.var_7db39d3c = n_time;
			self ai::stun();
			v_origin = self gettagorigin("tag_eye");
			v_angles = self gettagangles("tag_eye");
			var_4095cc33 = anglestoup(v_angles);
			v_down = v_origin + var_4095cc33 * -4;
			mdl_fx = util::spawn_model("tag_origin", v_origin, v_angles);
			mdl_fx linkto(self, "tag_eye", v_down - v_origin, (60, 0, 90));
			mdl_fx clientfield::set("" + #"hash_7876f33937c8a764", 1);
			while(isdefined(self) && self ai::is_stunned())
			{
				waitframe(1);
			}
			if(isalive(self) && (isdefined(self.allowdeath) && self.allowdeath))
			{
				self.var_df7eee28 = 1;
				self dodamage(self.health, self.origin, player, player, "none", "MOD_MELEE", 0, getweapon(#"hash_6a9069969e6fa287"));
			}
			wait(1);
			mdl_fx delete();
		}
	}
}

/*
	Name: function_cc7214a9
	Namespace: namespace_b45e3f05
	Checksum: 0x27BC742F
	Offset: 0xA5A8
	Size: 0x452
	Parameters: 1
	Flags: Linked
*/
function function_cc7214a9(params)
{
	if(isdefined(self) && (isdefined(self.var_df7eee28) && self.var_df7eee28))
	{
		return;
	}
	if(level flag::get(#"hash_525ff2b2a2f7d97a"))
	{
		self thread function_500ea537(params);
	}
	if(params.weapon === getweapon(#"hash_6a9069969e6fa287"))
	{
		return;
	}
	if(isdefined(self) && self.archetype === #"blight_father")
	{
		player = params.eattacker;
		if(isalive(player) && isplayer(player))
		{
			var_a15cc07f = getweapon(#"bowie_knife");
			if(params.weapon === var_a15cc07f)
			{
				if(isalive(player) && isplayer(player))
				{
					if(isdefined(self.var_c87d40c5) && self.var_c87d40c5)
					{
						self.var_c87d40c5 = 0;
						foreach(player in util::get_players())
						{
							player.var_f8b767c9 = 0;
						}
					}
					if(!isdefined(player.var_f8b767c9))
					{
						player.var_f8b767c9 = 0;
					}
					player.var_f8b767c9++;
					if(player.var_f8b767c9 >= 9 && !player hasweapon(getweapon(#"hash_6a9069969e6fa287")))
					{
						/#
							if(getdvarint(#"hash_7919e37cd5d57659", 0))
							{
								iprintlnbold("");
								println("");
							}
						#/
						player.var_f8b767c9 = undefined;
						player thread function_2c343fd8();
						while(isdefined(player) && player laststand::player_is_in_laststand())
						{
							waitframe(1);
						}
						if(!isdefined(player))
						{
							return;
						}
						player zm_melee_weapon::award_melee_weapon(#"hash_6a9069969e6fa287");
						level flag::set(#"hash_525ff2b2a2f7d97a");
						player util::delay(0.5, "death", &zm_audio::create_and_play_dialog, #"hash_109466146108268a", #"hash_6df34402d1bd621b");
					}
				}
			}
			else
			{
				self.var_c87d40c5 = 1;
				foreach(player in util::get_players())
				{
					player.var_f8b767c9 = 0;
				}
			}
		}
	}
}

/*
	Name: function_2c343fd8
	Namespace: namespace_b45e3f05
	Checksum: 0x928E5FB3
	Offset: 0xAA08
	Size: 0x158
	Parameters: 0
	Flags: Linked
*/
function function_2c343fd8()
{
	self endon(#"disconnect");
	wait(1);
	self clientfield::set("" + #"hash_2c387ea19f228b5d", 1);
	wait(2);
	self clientfield::set("" + #"hash_2c387ea19f228b5d", 0);
	var_5912c181 = getweapon(#"hash_6a9069969e6fa287");
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"weapon_melee");
		if(var_88706ea7.weapon === var_5912c181)
		{
			self clientfield::set("" + #"hash_2c387ea19f228b5d", 1);
			self waittill(#"melee_end");
			self clientfield::set("" + #"hash_2c387ea19f228b5d", 0);
		}
	}
}

/*
	Name: function_b87c71d7
	Namespace: namespace_b45e3f05
	Checksum: 0x619ACE28
	Offset: 0xAB68
	Size: 0x1CC
	Parameters: 1
	Flags: Linked
*/
function function_b87c71d7(var_a276c861)
{
	var_365259de = struct::get_array(#"hash_238f2635f6e0454a");
	foreach(var_6bfbf04e in var_365259de)
	{
		var_6bfbf04e thread function_f003a04b();
	}
	var_309743ae = getentarray("sheet_sound_place", "targetname");
	foreach(var_2e8f6573 in var_309743ae)
	{
		var_2e8f6573 thread function_9dcc74cf();
	}
	level waittill(#"start_of_round");
	level thread function_9a209775();
	util::waittill_multiple_ents(var_365259de[0], #"hash_2de28171d87b35cf", var_365259de[1], #"hash_2de28171d87b35cf", var_365259de[2], #"hash_2de28171d87b35cf");
}

/*
	Name: function_9dcc74cf
	Namespace: namespace_b45e3f05
	Checksum: 0x35AEF6C6
	Offset: 0xAD40
	Size: 0x134
	Parameters: 0
	Flags: Linked
*/
function function_9dcc74cf()
{
	self endon(#"death");
	s_unitrigger = self zm_unitrigger::create(undefined, 48, &function_8c94faeb);
	if(isdefined(self.target))
	{
		s_trigger_pos = struct::get(self.target);
		zm_unitrigger::function_47625e58(s_unitrigger, s_trigger_pos.origin, s_unitrigger.angles);
	}
	zm_unitrigger::function_89380dda(s_unitrigger);
	self waittill(#"hash_3c52547927852e33");
	self playsound(#"hash_57989a591694c70b");
	self zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
	self delete();
}

/*
	Name: function_8c94faeb
	Namespace: namespace_b45e3f05
	Checksum: 0xD76098B2
	Offset: 0xAE80
	Size: 0x100
	Parameters: 0
	Flags: Linked
*/
function function_8c94faeb()
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		e_player = waitresult.activator;
		if(isdefined(e_player.var_32d36a7f))
		{
			continue;
		}
		e_player.var_32d36a7f = self.stub.related_parent.script_int;
		self.stub.related_parent notify(#"hash_3c52547927852e33", {#e_who:e_player});
		e_player zm_audio::create_and_play_dialog(#"hash_44b4edd3d705820d", #"generic");
	}
}

/*
	Name: function_f003a04b
	Namespace: namespace_b45e3f05
	Checksum: 0x75AF3D77
	Offset: 0xAF88
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_f003a04b()
{
	self.t_damage = getent(self.target, "targetname");
	self.var_1904a11d = getent(self.t_damage.target, "targetname");
	self.var_1904a11d hide();
	self.var_fd9d797f = 0;
	s_unitrigger = self zm_unitrigger::create(undefined, undefined, &function_41ee4286);
	zm_unitrigger::function_89380dda(s_unitrigger);
}

/*
	Name: function_41ee4286
	Namespace: namespace_b45e3f05
	Checksum: 0x6D0405AE
	Offset: 0xB058
	Size: 0x286
	Parameters: 0
	Flags: Linked
*/
function function_41ee4286()
{
	self endon(#"death");
	var_6bfbf04e = self.stub.related_parent;
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		e_player = waitresult.activator;
		var_1b79a086 = undefined;
		var_1bd4bb25 = 0;
		if(isdefined(var_6bfbf04e.var_32d36a7f))
		{
			var_6bfbf04e.var_1904a11d hide();
			playsoundatposition(#"hash_57989a591694c70b", var_6bfbf04e.origin);
			if(var_6bfbf04e.var_32d36a7f == var_6bfbf04e.script_int)
			{
				var_6bfbf04e.var_fd9d797f = 0;
			}
			var_1b79a086 = var_6bfbf04e.var_32d36a7f;
			var_6bfbf04e.var_32d36a7f = undefined;
			var_6bfbf04e notify(#"hash_44c21ffb9cd24f2f");
			if(isdefined(e_player.var_32d36a7f))
			{
				wait(0.3);
			}
			else
			{
				e_player.var_32d36a7f = var_1b79a086;
				var_1bd4bb25 = 1;
			}
		}
		if(!var_1bd4bb25 && !isdefined(var_6bfbf04e.var_32d36a7f) && isdefined(e_player.var_32d36a7f))
		{
			var_6bfbf04e.var_1904a11d function_1f7f2030(e_player.var_32d36a7f);
			var_6bfbf04e.var_1904a11d show();
			var_6bfbf04e notify(#"hash_2624818b23ab83dc");
			playsoundatposition(#"hash_6c070e9cd866f23a", var_6bfbf04e.origin);
			var_6bfbf04e.var_32d36a7f = e_player.var_32d36a7f;
			e_player.var_32d36a7f = (isdefined(var_1b79a086) ? var_1b79a086 : undefined);
			if(var_6bfbf04e.var_32d36a7f == var_6bfbf04e.script_int)
			{
				var_6bfbf04e.var_fd9d797f = 1;
			}
		}
	}
}

/*
	Name: function_1f7f2030
	Namespace: namespace_b45e3f05
	Checksum: 0x71B79618
	Offset: 0xB2E8
	Size: 0xC2
	Parameters: 1
	Flags: Linked
*/
function function_1f7f2030(var_2c2d042a)
{
	switch(var_2c2d042a)
	{
		case 0:
		{
			self setmodel(#"p8_zm_zod_music_sheet_03");
			break;
		}
		case 1:
		{
			self setmodel(#"p8_zm_zod_music_sheet_01");
			break;
		}
		case 2:
		{
			self setmodel(#"p8_zm_zod_music_sheet_04");
			break;
		}
	}
}

/*
	Name: function_6d5cf6b2
	Namespace: namespace_b45e3f05
	Checksum: 0x13FBE670
	Offset: 0xB3B8
	Size: 0xA0
	Parameters: 2
	Flags: None
*/
function function_6d5cf6b2(str_text, str_endon)
{
	/#
		level endon(#"end_of_round", #"start_of_round");
		if(isdefined(str_endon))
		{
			self endon(str_endon);
		}
		while(true)
		{
			print3d(self.origin, function_9e72a96(str_text), (1, 1, 0), 1, 1, 30);
			wait(0.5);
		}
	#/
}

/*
	Name: function_46a445cd
	Namespace: namespace_b45e3f05
	Checksum: 0xCDE53B35
	Offset: 0xB460
	Size: 0x1A8
	Parameters: 2
	Flags: Linked
*/
function function_46a445cd(var_a276c861, var_19e802fa)
{
	var_365259de = struct::get_array(#"hash_238f2635f6e0454a");
	foreach(var_6bfbf04e in var_365259de)
	{
		var_6bfbf04e.var_1904a11d show();
		var_6bfbf04e.var_fd9d797f = 1;
		var_6bfbf04e notify(#"hash_2624818b23ab83dc");
	}
	var_309743ae = getentarray("sheet_sound_place", "targetname");
	foreach(var_2e8f6573 in var_309743ae)
	{
		if(isdefined(var_2e8f6573.s_unitrigger))
		{
			zm_unitrigger::unregister_unitrigger(var_2e8f6573.s_unitrigger);
			var_2e8f6573 delete();
		}
	}
}

/*
	Name: function_9a209775
	Namespace: namespace_b45e3f05
	Checksum: 0xA790F218
	Offset: 0xB610
	Size: 0x110
	Parameters: 1
	Flags: Linked
*/
function function_9a209775(var_a276c861)
{
	if(!(isdefined(level.var_7812c982) && level.var_7812c982))
	{
		level.var_7812c982 = 1;
		var_365259de = struct::get_array(#"hash_238f2635f6e0454a");
		while(true)
		{
			foreach(var_6bfbf04e in var_365259de)
			{
				var_6bfbf04e thread function_ff05eb5();
			}
			level thread function_ac504c40();
			level waittill(#"end_of_round");
		}
	}
}

/*
	Name: function_ff05eb5
	Namespace: namespace_b45e3f05
	Checksum: 0x5ACF3E3B
	Offset: 0xB728
	Size: 0x470
	Parameters: 0
	Flags: Linked
*/
function function_ff05eb5()
{
	level endon(#"end_of_round", #"end_game");
	if(!isdefined(self.t_damage))
	{
		self.t_damage = getent(self.target, "targetname");
		self.t_damage makesentient();
	}
	exploder::stop_exploder(self.script_exploder);
	self.var_d6fff827 = 0;
	switch(self.script_int)
	{
		case 2:
		{
			str_bundle = #"p8_fxanim_zm_zod_piano_vintage_bundle";
			break;
		}
		case 1:
		{
			str_bundle = #"p8_fxanim_zm_zod_grand_piano_bundle";
			break;
		}
		case 0:
		{
			str_bundle = #"p8_fxanim_zm_zod_piano_victorian_bundle";
			break;
		}
	}
	if(!isdefined(self.var_32d36a7f))
	{
		self waittill(#"hash_2624818b23ab83dc");
	}
	self endon_callback(&function_ff05eb5, #"hash_44c21ffb9cd24f2f");
	while(true)
	{
		waitresult = undefined;
		waitresult = self.t_damage waittill(#"damage");
		if(waitresult.mod !== #"mod_melee" || !isplayer(waitresult.attacker))
		{
			continue;
		}
		if(isdefined(waitresult.weapon) && waitresult.weapon.gadget_type === 11)
		{
			playsoundatposition(#"hash_4b939760d149465a", self.origin);
			if(isdefined(self.var_fd9d797f) && self.var_fd9d797f)
			{
				/#
					iprintlnbold("");
				#/
				playsoundatposition(#"hash_5ef8e030b84ace08", self.origin);
				level thread scene::play(str_bundle, "sample");
				waitresult.attacker util::delay(3, "death", &zm_audio::create_and_play_dialog, #"hash_68677a02650cad00", #"hash_564e0caf8026cfc4");
				if(!(isdefined(self.var_d6fff827) && self.var_d6fff827))
				{
					self.var_d6fff827 = 1;
					self notify(#"hash_2de28171d87b35cf");
					level notify(#"hash_55934fc4dddbd12" + self.script_int + "_on");
					exploder::exploder(self.script_exploder);
					zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
				}
			}
			else
			{
				/#
					iprintlnbold("");
				#/
				playsoundatposition(#"hash_165a8e8934d64af5", self.origin);
				level thread scene::play(str_bundle, "fail");
				waitresult.attacker util::delay(3, "death", &zm_audio::create_and_play_dialog, #"hash_68677a02650cad00", #"hash_86b9a1fe920aa15");
			}
		}
	}
}

/*
	Name: function_ac504c40
	Namespace: namespace_b45e3f05
	Checksum: 0x8AE659C5
	Offset: 0xBBA0
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_ac504c40()
{
	level endon(#"end_of_round");
	level util::waittill_multiple(#"hash_78e09697a7953a96", #"hash_527cb89f45b995cb", #"hash_235cb6873829de38");
	level thread function_fd46b17e();
}

/*
	Name: function_fd46b17e
	Namespace: namespace_b45e3f05
	Checksum: 0x2F131987
	Offset: 0xBC20
	Size: 0x36C
	Parameters: 1
	Flags: Linked
*/
function function_fd46b17e(str_notify)
{
	level endon(#"end_of_round");
	if(str_notify === #"moving_chest_now")
	{
		level flag::wait_till_clear(#"moving_chest_now");
	}
	while(isdefined(level.var_2e1644f2) && level.var_2e1644f2)
	{
		wait(0.1);
	}
	level endon_callback(&function_fd46b17e, #"moving_chest_now");
	var_52a1ab19 = level.chests[level.chest_index].zbarrier;
	var_45fd85a3 = vectornormalize(anglestoright(var_52a1ab19.angles)) * -28;
	if(!isdefined(level.var_4eecfa09))
	{
		level.var_4eecfa09 = spawn("trigger_damage_new", var_52a1ab19.origin + var_45fd85a3 + vectorscale((0, 0, 1), 24), 0, 48, 48);
	}
	else
	{
		level.var_4eecfa09.origin = var_52a1ab19.origin + var_45fd85a3 + vectorscale((0, 0, 1), 24);
	}
	level thread util::delete_on_death_or_notify(level.var_4eecfa09, #"end_of_round");
	level.var_4eecfa09 usetriggerrequirelookat(1);
	while(isdefined(level.var_4eecfa09))
	{
		waitresult = undefined;
		waitresult = level.var_4eecfa09 waittill(#"damage");
		if(waitresult.mod !== #"mod_melee" || var_52a1ab19.state === "open" || !isplayer(waitresult.attacker))
		{
			continue;
		}
		if(isdefined(waitresult.weapon) && waitresult.weapon.gadget_type === 11)
		{
			if(!isdefined(level.var_f2001905) || level.round_number >= level.var_f2001905 + 9)
			{
				level.var_f2001905 = level.round_number;
				level thread zm_powerup_fire_sale::start_fire_sale();
				continue;
			}
			var_52a1ab19 thread function_8baed388();
			while(isdefined(level.var_2e1644f2) && level.var_2e1644f2)
			{
				wait(0.1);
			}
		}
	}
}

/*
	Name: function_8baed388
	Namespace: namespace_b45e3f05
	Checksum: 0xB0D7C209
	Offset: 0xBF98
	Size: 0x126
	Parameters: 0
	Flags: Linked
*/
function function_8baed388()
{
	level.var_2e1644f2 = 1;
	playsoundatposition(#"hash_4a5dc8d6ac26d880", self.origin);
	level.custom_magic_box_timer_til_despawn = &function_281b6803;
	level.customrandomweaponweights = &function_d684005e;
	self.owner.zombie_cost = 10;
	level waittill_timeout(30, #"moving_chest_now");
	while(isdefined(self.owner.weapon_out) && self.owner.weapon_out)
	{
		waitframe(1);
	}
	level.var_2e1644f2 = 0;
	level.customrandomweaponweights = undefined;
	level.custom_magic_box_timer_til_despawn = &zm_zodt8::function_d4fea86c;
	self.owner.zombie_cost = self.owner.old_cost;
}

/*
	Name: function_d684005e
	Namespace: namespace_b45e3f05
	Checksum: 0x63710ECF
	Offset: 0xC0C8
	Size: 0x308
	Parameters: 1
	Flags: Linked
*/
function function_d684005e(a_keys)
{
	switch(self.var_72d6f15d)
	{
		case 0:
		{
			var_fe12b033 = array(#"hero_chakram_lv1", #"hero_hammer_lv1", #"hash_50f35e4cfb775e02", #"hero_sword_pistol_lv1");
			break;
		}
		case 1:
		{
			var_fe12b033 = array(#"hero_chakram_lv2", #"hero_hammer_lv2", #"hash_50f35d4cfb775c4f", #"hero_sword_pistol_lv2");
			break;
		}
		case 2:
		{
			var_fe12b033 = array(#"hero_chakram_lv3", #"hero_hammer_lv3", #"hash_50f35c4cfb775a9c", #"hero_sword_pistol_lv3");
			break;
		}
		default:
		{
			var_fe12b033 = array(#"hero_chakram_lv1", #"hero_hammer_lv1", #"hash_50f35e4cfb775e02", #"hero_sword_pistol_lv1");
			break;
		}
	}
	var_fe12b033 = array::exclude(var_fe12b033, self.var_fd05e363.name);
	var_8e4297a8 = array::random(var_fe12b033);
	var_9fd301cd = getweapon(var_8e4297a8);
	zm_weapons::include_zombie_weapon(var_8e4297a8, 1);
	zm_weapons::add_zombie_weapon(var_8e4297a8, "", 0, 0, undefined, undefined, 0, "", "special", 0, undefined, 1);
	level clientfield::set("" + #"hash_4f672a8a7ae530e5", 1);
	level thread function_3fa7aef2(var_9fd301cd, self);
	arrayinsert(a_keys, var_9fd301cd, 0);
	return a_keys;
}

/*
	Name: function_281b6803
	Namespace: namespace_b45e3f05
	Checksum: 0xE2DEE2C1
	Offset: 0xC3D8
	Size: 0x304
	Parameters: 1
	Flags: Linked
*/
function function_281b6803(var_19aaca46)
{
	v_float = anglestoup(self.angles) * 40;
	switch(var_19aaca46.weapon.name)
	{
		case "hero_hammer_lv3":
		case "hero_hammer_lv2":
		case "hero_hammer_lv1":
		{
			self.origin = self.origin + vectornormalize(anglestoforward(var_19aaca46.angles)) * 8;
			self.angles = self.angles + vectorscale((1, 0, 0), 90);
			break;
		}
		case "hash_50f35c4cfb775a9c":
		case "hash_50f35d4cfb775c4f":
		case "hash_50f35e4cfb775e02":
		{
			self.origin = self.origin + vectornormalize(anglestoforward(var_19aaca46.angles)) * 24;
			break;
		}
		case "hero_sword_pistol_lv2":
		case "hero_sword_pistol_lv3":
		case "hero_sword_pistol_lv1":
		{
			if(self.model === #"hash_7ea144f04cd2c343" || self.model === #"hash_d22c09c0aec2fc6" || self.model === #"hash_52bb9dc078b64e29")
			{
				self.origin = self.origin + vectornormalize(anglestoforward(var_19aaca46.angles)) * 10;
				self.origin = self.origin + vectornormalize(anglestoup(var_19aaca46.angles)) * 4;
			}
			else
			{
				self.origin = self.origin + vectornormalize(anglestoforward(var_19aaca46.angles)) * 16;
				self.angles = self.angles + vectorscale((1, 0, 0), 90);
			}
			break;
		}
		default:
		{
			break;
		}
	}
	self thread zm_magicbox::timer_til_despawn(v_float);
}

/*
	Name: function_3fa7aef2
	Namespace: namespace_b45e3f05
	Checksum: 0x1B9447D5
	Offset: 0xC6E8
	Size: 0x104
	Parameters: 2
	Flags: Linked
*/
function function_3fa7aef2(var_8352fb8a, e_player)
{
	while(isdefined(level.chests[level.chest_index].weapon_out) && level.chests[level.chest_index].weapon_out)
	{
		waitframe(1);
	}
	zm_weapons::function_f1114209(var_8352fb8a);
	level clientfield::set("" + #"hash_4f672a8a7ae530e5", 0);
	if(isalive(e_player) && e_player.var_fd05e363 === var_8352fb8a)
	{
		e_player zm_audio::create_and_play_dialog(#"generic", #"response_positive");
	}
}

/*
	Name: function_2ae7b2a6
	Namespace: namespace_b45e3f05
	Checksum: 0x5AAD5632
	Offset: 0xC7F8
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function function_2ae7b2a6(var_a276c861, var_19e802fa)
{
}

