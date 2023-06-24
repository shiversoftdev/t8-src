// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_transformation.gsc;
#using script_35598499769dbb3d;
#using script_387eab232fe22983;
#using script_3e5ec44cfab7a201;
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\zm_common\zm_ui_inventory.gsc;
#using scripts\zm_common\zm_vo.gsc;
#using scripts\zm_common\zm_sq.gsc;
#using scripts\zm_common\zm_customgame.gsc;
#using scripts\zm\zm_mansion_jordans.gsc;
#using scripts\zm\ai\zm_ai_nosferatu.gsc;
#using script_ab862743b3070a;
#using scripts\zm_common\zm_characters.gsc;
#using scripts\zm\zm_mansion_special_rounds.gsc;
#using scripts\zm\zm_mansion_silver_bullet.gsc;
#using script_db06eb511bd9b36;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\fx_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\serverfield_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\zm\zm_mansion_util.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_blockers.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_pack_a_punch.gsc;
#using scripts\zm_common\zm_power.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace mansion_storage;

/*
	Name: init
	Namespace: mansion_storage
	Checksum: 0x1D85D652
	Offset: 0x430
	Size: 0x2C4
	Parameters: 0
	Flags: Linked
*/
function init()
{
	clientfield::register("scriptmover", "" + #"hash_65a58403194ef1b4", 8000, 1, "int");
	clientfield::register("world", "" + #"start_billiards", 8000, 1, "int");
	serverfield::register("billiard_ball_sunk_sf", 8000, getminbitcountfornum(9), "int", &function_cf048af);
	clientfield::register("world", "" + #"hash_354bb8ac5de6640a", 8000, getminbitcountfornum(9), "int");
	clientfield::register("world", "" + #"hash_75594bca6b54706e", 8000, 1, "int");
	clientfield::register("world", "" + #"hash_2c115514da4cee51", 17000, 1, "int");
	clientfield::register("scriptmover", "" + #"barrel_drip", 8000, 1, "counter");
	clientfield::register("scriptmover", "" + #"barrel_spray", 8000, 1, "counter");
	function_c739f755();
	zm_sq::start(#"hash_4c0e5e4b34877996");
	zm_sq::start(#"hash_65636bbec86da22c");
	zm_sq::start(#"zm_storage_billiards", 1);
	level thread function_550d0bc6();
	level thread function_e63ede31();
}

/*
	Name: function_c739f755
	Namespace: mansion_storage
	Checksum: 0x10847E3B
	Offset: 0x700
	Size: 0x244
	Parameters: 0
	Flags: Linked
*/
function function_c739f755()
{
	zm_sq::register(#"hash_4c0e5e4b34877996", #"step_1", #"hash_5b60b951867b6b11", &function_63ceee4b, &function_a1ed8c28);
	zm_sq::register(#"hash_4c0e5e4b34877996", #"step_2", #"hash_5b60b651867b65f8", &function_4e14c2d7, &function_21e10c11);
	zm_sq::register(#"hash_65636bbec86da22c", #"step_1", #"hash_1551692125951197", &function_6c1be65c, &function_e4b6830d);
	zm_sq::register(#"hash_65636bbec86da22c", #"step_2", #"hash_15516a212595134a", &function_28995f54, &function_f5692472);
	zm_sq::register(#"zm_storage_billiards", #"step_1", #"hash_33b63d9ccbdb1e3e", &function_ffc4a06a, &function_a4daedbe);
	zm_sq::register(#"zm_storage_billiards", #"step_2", #"hash_33b63c9ccbdb1c8b", &function_f21f0537, &function_2ff803fa);
}

/*
	Name: function_550d0bc6
	Namespace: mansion_storage
	Checksum: 0xE1DA71C3
	Offset: 0x950
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_550d0bc6()
{
	level flagsys::wait_till("start_zombie_round_logic");
	if(!isdefined(level.var_969e8ac2))
	{
		level.var_969e8ac2 = spawnstruct();
		level thread function_ff726bbb(0);
	}
}

/*
	Name: function_e63ede31
	Namespace: mansion_storage
	Checksum: 0x839D6FB9
	Offset: 0x9C0
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_e63ede31()
{
	level flagsys::wait_till(#"connect_ground_floor_to_cellar");
	if(!level flag::exists(#"hash_63f87f83cf6cbc6a"))
	{
		level thread function_c63076b4(0);
	}
}

/*
	Name: function_63ceee4b
	Namespace: mansion_storage
	Checksum: 0x9CADA1C0
	Offset: 0xA28
	Size: 0xFE
	Parameters: 1
	Flags: Linked
*/
function function_63ceee4b(var_a276c861)
{
	level.var_969e8ac2 = spawnstruct();
	var_969e8ac2 = level.var_969e8ac2;
	level flagsys::wait_till("start_zombie_round_logic");
	level thread function_ff726bbb();
	var_be17187b = undefined;
	var_be17187b = var_969e8ac2 waittill(#"hash_35caca73b82a6707", #"hash_1184db7e6252576");
	if(var_be17187b._notify == #"hash_35caca73b82a6707")
	{
		var_969e8ac2.var_c0ceb69c = var_be17187b.var_537e3893;
	}
	else
	{
		var_969e8ac2.var_c0ceb69c = #"hash_1184db7e6252576";
	}
}

/*
	Name: function_a1ed8c28
	Namespace: mansion_storage
	Checksum: 0x179A74BA
	Offset: 0xB30
	Size: 0x102
	Parameters: 2
	Flags: Linked
*/
function function_a1ed8c28(var_a276c861, ended_early)
{
	zm_unitrigger::unregister_unitrigger(level.var_969e8ac2.var_22796fad[0].s_unitrigger_stub);
	zm_unitrigger::unregister_unitrigger(level.var_969e8ac2.var_22796fad[1].s_unitrigger_stub);
	zm_unitrigger::unregister_unitrigger(level.var_969e8ac2.var_22796fad[2].s_unitrigger_stub);
	zm_unitrigger::unregister_unitrigger(level.var_969e8ac2.var_22796fad[3].s_unitrigger_stub);
	if(var_a276c861 || ended_early)
	{
		level.var_969e8ac2.var_c0ceb69c = #"hash_2b73105e32379a57";
	}
}

/*
	Name: function_ff726bbb
	Namespace: mansion_storage
	Checksum: 0x82A0D07D
	Offset: 0xC40
	Size: 0x754
	Parameters: 1
	Flags: Linked
*/
function function_ff726bbb(var_2afee46 = 1)
{
	level.var_969e8ac2.var_22796fad = [];
	var_61243b5c = scene::get_active_scenes(#"p8_fxanim_zm_man_bookcase_01_bundle");
	var_b0db8553 = var_61243b5c[0];
	var_1d305e7f = var_b0db8553.scene_ents[#"prop 1"];
	var_19d968b8 = getent("e_secret_clip_left", "targetname");
	var_19d968b8 linkto(var_1d305e7f, "tag_origin");
	var_bad218e = var_b0db8553.scene_ents[#"prop 2"];
	var_d16a9f7c = getent("e_secret_clip_right", "targetname");
	var_d16a9f7c linkto(var_bad218e, "tag_origin");
	var_19d968b8 disconnectpaths();
	var_d16a9f7c disconnectpaths();
	var_befaf308 = scene::get_active_scenes(#"p8_fxanim_zm_man_bookcase_02_bundle");
	var_f6281a0 = var_befaf308[0];
	var_d3f97071 = var_f6281a0.scene_ents[#"prop 1"];
	var_84d63a77 = getent("w_secret_clip_left", "targetname");
	var_84d63a77 linkto(var_d3f97071, "tag_origin");
	var_db4a4ab3 = var_f6281a0.scene_ents[#"prop 2"];
	var_7b9ecc98 = getent("w_secret_clip_right", "targetname");
	var_7b9ecc98 linkto(var_db4a4ab3, "tag_origin");
	var_84d63a77 disconnectpaths();
	var_7b9ecc98 disconnectpaths();
	level.var_d1e98ce7 = util::spawn_model("tag_origin", (var_84d63a77.origin + var_7b9ecc98.origin) / 2);
	level.var_44c19f1a = util::spawn_model("tag_origin", (var_19d968b8.origin + var_d16a9f7c.origin) / 2);
	var_d6a83f7c = array(#"p8_zm_man_book_symbol_02", #"p8_zm_man_book_symbol_03", #"p8_zm_man_book_symbol_01", #"p8_zm_man_book_symbol_04");
	_plyr_exterior_gunner_front = array("w_secret_left_object", "e_secret_left_object", "w_secret_right_object", "e_secret_right_object");
	var_b4536237 = array(0, 1, 2, 3);
	if(var_2afee46)
	{
		var_b4536237 = array::randomize(var_b4536237);
	}
	for(i = 0; i < var_b4536237.size; i++)
	{
		var_a0639b8c = var_b4536237[i];
		var_aaa36da6 = struct::get(_plyr_exterior_gunner_front[i], "targetname");
		var_649b5da0 = util::spawn_model(var_d6a83f7c[var_a0639b8c], var_aaa36da6.origin, var_aaa36da6.angles);
		var_649b5da0.targetname = var_aaa36da6.targetname;
		var_649b5da0.var_a0639b8c = var_a0639b8c;
		if(var_2afee46)
		{
			var_649b5da0.s_unitrigger_stub = var_649b5da0 zm_unitrigger::create(undefined, var_aaa36da6.radius, &function_56c97aea, 1, 1);
		}
		var_649b5da0.var_60f4d369 = i;
		if(!isdefined(level.var_969e8ac2.var_22796fad))
		{
			level.var_969e8ac2.var_22796fad = [];
		}
		else if(!isarray(level.var_969e8ac2.var_22796fad))
		{
			level.var_969e8ac2.var_22796fad = array(level.var_969e8ac2.var_22796fad);
		}
		level.var_969e8ac2.var_22796fad[level.var_969e8ac2.var_22796fad.size] = var_649b5da0;
		switch(i)
		{
			case 0:
			{
				var_649b5da0 linkto(var_d3f97071, "tag_origin");
				var_649b5da0.script_noteworthy = "west";
				break;
			}
			case 1:
			{
				var_649b5da0 linkto(var_1d305e7f, "tag_origin");
				var_649b5da0.script_noteworthy = "east";
				break;
			}
			case 2:
			{
				var_649b5da0 linkto(var_db4a4ab3, "tag_origin");
				var_649b5da0.script_noteworthy = "west";
				break;
			}
			case 3:
			{
				var_649b5da0 linkto(var_bad218e, "tag_origin");
				var_649b5da0.script_noteworthy = "east";
				break;
			}
		}
	}
	if(var_2afee46)
	{
		level thread function_34f6d80a();
	}
}

/*
	Name: function_56c97aea
	Namespace: mansion_storage
	Checksum: 0xE18EA800
	Offset: 0x13A0
	Size: 0x100
	Parameters: 0
	Flags: Linked
*/
function function_56c97aea()
{
	self endon(#"death");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"trigger");
		if(isplayer(var_be17187b.activator))
		{
			var_649b5da0 = self.stub.related_parent;
			level.var_969e8ac2 notify(#"hash_59cef06ae393749f", {#activator:var_be17187b.activator, #hash_537e3893:var_649b5da0.script_noteworthy, #array_index:var_649b5da0.var_60f4d369, #hash_f9ba056c:var_649b5da0.var_a0639b8c});
		}
	}
}

/*
	Name: function_34f6d80a
	Namespace: mansion_storage
	Checksum: 0x9F51C950
	Offset: 0x14A8
	Size: 0x1E4
	Parameters: 0
	Flags: Linked
*/
function function_34f6d80a()
{
	level endon(#"game_ended");
	level.var_969e8ac2.var_dbba0608 = 0;
	b_failed = 0;
	while(!b_failed && level.var_969e8ac2.var_dbba0608 < level.var_969e8ac2.var_22796fad.size)
	{
		var_be17187b = undefined;
		var_be17187b = level.var_969e8ac2 waittill(#"hash_59cef06ae393749f");
		if(var_be17187b.var_f9ba056c == level.var_969e8ac2.var_dbba0608)
		{
			zm_unitrigger::unregister_unitrigger(level.var_969e8ac2.var_22796fad[var_be17187b.array_index].s_unitrigger_stub);
			if(!b_failed)
			{
				level.var_969e8ac2.var_22796fad[var_be17187b.array_index] clientfield::set("" + #"hash_65a58403194ef1b4", 1);
				level.var_969e8ac2.var_64c09f7f = var_be17187b.activator;
			}
			level.var_969e8ac2.var_dbba0608++;
		}
		else
		{
			b_failed = 1;
		}
	}
	wait(1.2);
	if(!b_failed)
	{
		level.var_969e8ac2 notify(#"hash_35caca73b82a6707", {#hash_537e3893:var_be17187b.var_537e3893});
	}
	else
	{
		level.var_969e8ac2 notify(#"hash_1184db7e6252576");
	}
}

/*
	Name: function_4e14c2d7
	Namespace: mansion_storage
	Checksum: 0xCCFA2B0B
	Offset: 0x1698
	Size: 0x15C
	Parameters: 1
	Flags: Linked
*/
function function_4e14c2d7(var_a276c861)
{
	switch(level.var_969e8ac2.var_c0ceb69c)
	{
		case "east":
		{
			level.var_969e8ac2 thread function_941b297c(#"east");
			level.var_25bdf5fd = level.var_44c19f1a;
			break;
		}
		case "west":
		{
			level.var_969e8ac2 thread function_941b297c(#"west");
			level.var_25bdf5fd = level.var_d1e98ce7;
			break;
		}
		case "hash_2b73105e32379a57":
		{
			level.var_969e8ac2 thread function_46348c75();
			level.var_25bdf5fd = level.var_d1e98ce7;
			break;
		}
		case "hash_1184db7e6252576":
		{
			return;
		}
		default:
		{
			break;
		}
	}
	level thread function_63c873d9(level.var_25bdf5fd);
}

/*
	Name: function_21e10c11
	Namespace: mansion_storage
	Checksum: 0x2BEBF255
	Offset: 0x1800
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function function_21e10c11(var_a276c861, ended_early)
{
}

/*
	Name: function_46348c75
	Namespace: mansion_storage
	Checksum: 0x6C5DB6A9
	Offset: 0x1820
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_46348c75()
{
	self function_941b297c(#"east");
	self thread function_941b297c(#"west");
}

/*
	Name: function_941b297c
	Namespace: mansion_storage
	Checksum: 0xC5FEC1E2
	Offset: 0x1870
	Size: 0x304
	Parameters: 1
	Flags: Linked
*/
function function_941b297c(var_22c00989)
{
	if(var_22c00989 == #"east")
	{
		self.var_872e2994 = struct::get("e_secret_reward_pos", "targetname");
		level thread util::delay(2, undefined, &scene::play, #"p8_fxanim_zm_man_bookcase_01_bundle");
	}
	else
	{
		self.var_872e2994 = struct::get("w_secret_reward_pos", "targetname");
		level thread util::delay(2, undefined, &scene::play, #"p8_fxanim_zm_man_bookcase_02_bundle");
	}
	n_rand = randomint(100);
	var_1c855a0d = undefined;
	if(n_rand < 10)
	{
		var_35259c8e = array(#"ar_modular_t8", #"ar_fastfire_t8", #"ar_stealth_t8", #"ar_accurate_t8");
		var_35259c8e = array::randomize(var_35259c8e);
		var_1c855a0d = array::random(var_35259c8e);
	}
	else if(n_rand < 40)
	{
		var_5bc3791b = array(#"smg_fastfire_t8", #"smg_handling_t8", #"smg_capacity_t8", #"smg_drum_pistol_t8", #"smg_standard_t8", #"smg_accurate_t8");
		var_5bc3791b = array::randomize(var_5bc3791b);
		var_1c855a0d = array::random(var_5bc3791b);
	}
	if(isdefined(var_1c855a0d))
	{
		self thread function_94a403a4(var_1c855a0d);
	}
	else
	{
		wait(3.4);
		var_9c0bf2db = zm_powerups::specific_powerup_drop("bonus_points_player", self.var_872e2994.origin, undefined, undefined, undefined, 1);
		/#
			if(!isdefined(var_9c0bf2db))
			{
				/#
					assert(0, "");
				#/
			}
		#/
	}
}

/*
	Name: function_94a403a4
	Namespace: mansion_storage
	Checksum: 0xAA2816F8
	Offset: 0x1B80
	Size: 0x16C
	Parameters: 1
	Flags: Linked
*/
function function_94a403a4(var_1c855a0d)
{
	wpn_reward = getweapon(var_1c855a0d);
	var_a76c9d75 = level.var_969e8ac2.var_64c09f7f;
	if(!isdefined(var_a76c9d75))
	{
		var_a76c9d75 = getplayers()[0];
	}
	mdl_weapon = zm_utility::spawn_buildkit_weapon_model(var_a76c9d75, wpn_reward, undefined, self.var_872e2994.origin + vectorscale((0, 0, 1), 16), self.var_872e2994.angles);
	if(isdefined(mdl_weapon))
	{
		mdl_weapon thread function_7b425c11();
		var_47323b73 = mdl_weapon zm_unitrigger::create(&function_2b75135a, 64, &function_907eba72);
		var_47323b73.mdl_weapon = mdl_weapon;
		var_47323b73.var_498a708 = getweapon(var_1c855a0d);
	}
	else
	{
		/#
			assert(0, "");
		#/
		/#
		#/
	}
}

/*
	Name: function_6c1be65c
	Namespace: mansion_storage
	Checksum: 0x14950615
	Offset: 0x1CF8
	Size: 0x1EC
	Parameters: 1
	Flags: Linked
*/
function function_6c1be65c(var_a276c861)
{
	level.a_s_barrels = [];
	level.var_8efe799b = [];
	level flagsys::wait_till(#"load_main_complete");
	level flag::init(#"hash_63f87f83cf6cbc6a");
	level flag::init(#"hash_521d6bb11da55099");
	if(!var_a276c861)
	{
		level flag::wait_till(#"connect_ground_floor_to_cellar");
		mdl_clip = getent("secret_rack_clip", "targetname");
		mdl_clip disconnectpaths();
		var_9890436b = scene::get_active_scenes(#"p8_fxanim_zm_man_wine_rack_bundle");
		var_7195997b = var_9890436b[0];
		var_c65c37fc = var_7195997b.scene_ents[#"prop 1"];
		mdl_clip enablelinkto();
		mdl_clip linkto(var_c65c37fc, "tag_animate");
		level.var_4918f183 = util::spawn_model("tag_origin", mdl_clip.origin);
		level thread function_c63076b4();
		level flag::wait_till(#"hash_521d6bb11da55099");
	}
}

/*
	Name: function_e4b6830d
	Namespace: mansion_storage
	Checksum: 0x6BBD9DC1
	Offset: 0x1EF0
	Size: 0xF0
	Parameters: 2
	Flags: Linked
*/
function function_e4b6830d(var_a276c861, ended_early)
{
	if(var_a276c861 || ended_early)
	{
		foreach(s_barrel in level.a_s_barrels)
		{
			s_barrel notify(#"busted");
			if(isdefined(s_barrel.var_b0fe1e03))
			{
				s_barrel.var_b0fe1e03 delete();
			}
			if(isdefined(s_barrel.var_80221a28))
			{
				s_barrel.var_80221a28 delete();
			}
		}
	}
}

/*
	Name: function_c63076b4
	Namespace: mansion_storage
	Checksum: 0xCE5B5CD1
	Offset: 0x1FE8
	Size: 0x2AE
	Parameters: 1
	Flags: Linked
*/
function function_c63076b4(var_2afee46 = 1)
{
	level.a_s_barrels = array::randomize(struct::get_array("leaker"));
	level.var_a54c0174 = 0;
	var_38376e1d = 0.25;
	for(i = 0; i < level.a_s_barrels.size; i++)
	{
		level.a_s_barrels[i].var_b0fe1e03 = util::spawn_model("tag_origin", level.a_s_barrels[i].origin, level.a_s_barrels[i].angles);
		level.a_s_barrels[i].var_80221a28 = util::spawn_model("tag_origin", level.a_s_barrels[i].origin, level.a_s_barrels[i].angles);
		wait(0.1);
		if(isdefined(level.a_s_barrels[i].var_b0fe1e03))
		{
			level.a_s_barrels[i].n_rate = var_38376e1d + (var_38376e1d * i);
			level.a_s_barrels[i].t_trig = getent(level.a_s_barrels[i].target, "targetname");
			level.a_s_barrels[i] thread function_3e37bb63();
			if(var_2afee46)
			{
				level.a_s_barrels[i] thread function_85e39c4d();
				level clientfield::set("" + #"hash_2c115514da4cee51", 1);
			}
		}
		/#
			if(var_2afee46)
			{
				level.a_s_barrels[i].var_b0fe1e03.script_int = i;
				level.a_s_barrels[i].var_b0fe1e03 thread mansion_jordans::function_95b6c945();
			}
		#/
	}
}

/*
	Name: function_3e37bb63
	Namespace: mansion_storage
	Checksum: 0xD35CB96B
	Offset: 0x22A0
	Size: 0x60
	Parameters: 0
	Flags: Linked
*/
function function_3e37bb63()
{
	self endon(#"busted");
	while(true)
	{
		self.var_b0fe1e03 clientfield::increment("" + #"barrel_drip");
		wait(self.n_rate);
	}
}

/*
	Name: function_85e39c4d
	Namespace: mansion_storage
	Checksum: 0xB21A0ECC
	Offset: 0x2308
	Size: 0x18A
	Parameters: 0
	Flags: Linked
*/
function function_85e39c4d()
{
	self endon(#"busted");
	while(true)
	{
		s_notify = undefined;
		s_notify = self.t_trig waittill(#"damage");
		if(isplayer(s_notify.attacker) && s_notify.mod === "MOD_MELEE")
		{
			level.var_8efe799b[level.var_8efe799b.size] = self;
			level.var_a54c0174++;
			if(level.var_a54c0174 > 5)
			{
				level flag::set(#"hash_521d6bb11da55099");
			}
			if(!level flag::get(#"hash_63f87f83cf6cbc6a") && self == (level.a_s_barrels[level.var_8efe799b.size - 1]))
			{
				self thread function_5e130882();
				self.e_attacker = s_notify.attacker;
			}
			else
			{
				level flag::set(#"hash_63f87f83cf6cbc6a");
			}
			self notify(#"busted");
		}
	}
}

/*
	Name: function_5e130882
	Namespace: mansion_storage
	Checksum: 0x4E3BD655
	Offset: 0x24A0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_5e130882()
{
	if(isdefined(self.var_80221a28))
	{
		self.var_80221a28 clientfield::increment("" + #"barrel_spray");
	}
}

/*
	Name: function_28995f54
	Namespace: mansion_storage
	Checksum: 0x1592A7C4
	Offset: 0x24F0
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function function_28995f54(var_a276c861)
{
	if(level flag::get(#"hash_63f87f83cf6cbc6a"))
	{
		level clientfield::set("" + #"hash_2c115514da4cee51", 0);
	}
	else
	{
		level thread function_e3a40726();
	}
}

/*
	Name: function_f5692472
	Namespace: mansion_storage
	Checksum: 0x16DA48D4
	Offset: 0x2578
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function function_f5692472(var_a276c861, ended_early)
{
}

/*
	Name: function_e3a40726
	Namespace: mansion_storage
	Checksum: 0xB053BCA5
	Offset: 0x2598
	Size: 0x174
	Parameters: 0
	Flags: Linked
*/
function function_e3a40726()
{
	s_pos = struct::get("drip_item");
	level thread util::delay(2, undefined, &scene::play, #"p8_fxanim_zm_man_wine_rack_bundle");
	level thread function_63c873d9(level.var_4918f183);
	n_rand = randomint(100);
	if(n_rand <= 9)
	{
		level thread function_f2ca3ec8(s_pos);
	}
	else
	{
		if(n_rand > 9 && n_rand <= 39)
		{
			var_36d56d5e = 1;
			level thread function_410dd5a6(s_pos);
		}
		else
		{
			level thread function_1cc03a23(s_pos);
		}
	}
	if(!(isdefined(var_36d56d5e) && var_36d56d5e))
	{
		level clientfield::set("" + #"hash_2c115514da4cee51", 0);
	}
}

/*
	Name: function_1cc03a23
	Namespace: mansion_storage
	Checksum: 0x3E9387E
	Offset: 0x2718
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_1cc03a23(s_pos)
{
	wait(4.5);
	zm_powerups::specific_powerup_drop(#"bonus_points_player", s_pos.origin + (8, -8, -20), undefined, undefined, undefined, 1);
}

/*
	Name: function_410dd5a6
	Namespace: mansion_storage
	Checksum: 0xB480881B
	Offset: 0x2780
	Size: 0xAE
	Parameters: 1
	Flags: Linked
*/
function function_410dd5a6(s_pos)
{
	var_e007f14b = util::spawn_model(#"p8_zm_silver_bullet_pile_01", s_pos.origin, s_pos.angles);
	if(isdefined(var_e007f14b))
	{
		var_47323b73 = var_e007f14b zm_unitrigger::create(&mansion_silver_bullet::function_252cf612, 64, &function_b601eebc);
		var_47323b73.var_e007f14b = var_e007f14b;
		var_47323b73.var_6646a22 = 1;
	}
}

/*
	Name: function_f2ca3ec8
	Namespace: mansion_storage
	Checksum: 0xB21B4101
	Offset: 0x2838
	Size: 0x1C6
	Parameters: 1
	Flags: Linked
*/
function function_f2ca3ec8(s_pos)
{
	var_9b6698a3 = array(#"lmg_double_t8", #"lmg_heavy_t8", #"lmg_spray_t8", #"lmg_standard_t8");
	str_weapon = array::random(var_9b6698a3);
	var_498a708 = getweapon(str_weapon);
	var_a76c9d75 = level.a_s_barrels[level.a_s_barrels.size - 1].e_attacker;
	if(!isdefined(var_a76c9d75))
	{
		var_a76c9d75 = getplayers()[0];
	}
	mdl_weapon = zm_utility::spawn_buildkit_weapon_model(var_a76c9d75, var_498a708, undefined, s_pos.origin + vectorscale((0, 0, 1), 8), s_pos.angles);
	if(isdefined(mdl_weapon))
	{
		mdl_weapon thread function_7b425c11();
		var_47323b73 = mdl_weapon zm_unitrigger::create(&function_2b75135a, 64, &function_907eba72);
		var_47323b73.mdl_weapon = mdl_weapon;
		var_47323b73.var_498a708 = getweapon(str_weapon);
	}
}

/*
	Name: function_b601eebc
	Namespace: mansion_storage
	Checksum: 0xB887C2F5
	Offset: 0x2A08
	Size: 0x110
	Parameters: 0
	Flags: Linked
*/
function function_b601eebc()
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		player = waitresult.activator;
		if(!zm_utility::can_use(player))
		{
			continue;
		}
		if(player mansion_silver_bullet::function_ec89dca9())
		{
			continue;
		}
		self.stub.var_e007f14b delete();
		level clientfield::set("" + #"hash_2c115514da4cee51", 0);
		player mansion_silver_bullet::function_4e849ab();
		zm_unitrigger::unregister_unitrigger(self.stub);
	}
}

/*
	Name: function_ffc4a06a
	Namespace: mansion_storage
	Checksum: 0xCB1091CE
	Offset: 0x2B20
	Size: 0x194
	Parameters: 1
	Flags: Linked
*/
function function_ffc4a06a(var_a276c861)
{
	level flag::init(#"hash_4207012c64662b4d");
	level thread function_68e49445();
	level flagsys::wait_till("start_zombie_round_logic");
	mdl_clip = getent("secret_furniture_clip", "targetname");
	mdl_clip disconnectpaths();
	if(!var_a276c861)
	{
		level flagsys::wait_till(#"load_main_complete");
		level.var_e967a159 = 0;
		level.var_691e2bc4 = undefined;
		level.var_a24c96c7 = array(1, 2, 3, 4, 5, 6, 7, 8, 9);
		level clientfield::set("" + #"start_billiards", 1);
		/#
			level thread function_e061d576();
		#/
		level flag::wait_till(#"hash_4207012c64662b4d");
	}
}

/*
	Name: function_a4daedbe
	Namespace: mansion_storage
	Checksum: 0x1662748E
	Offset: 0x2CC0
	Size: 0x36
	Parameters: 2
	Flags: Linked
*/
function function_a4daedbe(var_a276c861, ended_early)
{
	if(var_a276c861 || ended_early)
	{
		level.var_691e2bc4 = 1;
	}
}

/*
	Name: function_68e49445
	Namespace: mansion_storage
	Checksum: 0xBFD356B0
	Offset: 0x2D00
	Size: 0x290
	Parameters: 0
	Flags: Linked
*/
function function_68e49445()
{
	level endoncallback(&function_784a41d1, #"hash_4207012c64662b4d");
	level flagsys::wait_till(#"load_main_complete");
	var_f103be47 = 0;
	while(true)
	{
		if(var_f103be47)
		{
			if(!(isdefined(level.zones[#"zone_library_hallway_upper"].is_occupied) && level.zones[#"zone_library_hallway_upper"].is_occupied) && (!(isdefined(level.zones[#"zone_library_upper"].is_occupied) && level.zones[#"zone_library_upper"].is_occupied)) && (!(isdefined(level.zones[#"zone_foyer_westend"].is_occupied) && level.zones[#"zone_foyer_westend"].is_occupied)))
			{
				level clientfield::set("" + #"hash_75594bca6b54706e", 0);
				var_f103be47 = 0;
			}
		}
		else if(isdefined(level.zones[#"zone_library_hallway_upper"].is_occupied) && level.zones[#"zone_library_hallway_upper"].is_occupied || (isdefined(level.zones[#"zone_library_upper"].is_occupied) && level.zones[#"zone_library_upper"].is_occupied) || (isdefined(level.zones[#"zone_foyer_westend"].is_occupied) && level.zones[#"zone_foyer_westend"].is_occupied))
		{
			level clientfield::set("" + #"hash_75594bca6b54706e", 1);
			var_f103be47 = 1;
		}
		wait(0.2);
	}
}

/*
	Name: function_784a41d1
	Namespace: mansion_storage
	Checksum: 0xE05E7DE
	Offset: 0x2F98
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_784a41d1(s_notify)
{
	level clientfield::set("" + #"hash_75594bca6b54706e", 0);
}

/*
	Name: function_cf048af
	Namespace: mansion_storage
	Checksum: 0xC261C2B7
	Offset: 0x2FE0
	Size: 0x26C
	Parameters: 2
	Flags: Linked
*/
function function_cf048af(oldval, newval)
{
	if(!level flag::get(#"start_zombie_round_logic"))
	{
		return;
	}
	level clientfield::set("" + #"hash_354bb8ac5de6640a", newval);
	var_52fa3cae = (newval == 10 ? 8 : newval);
	if(isinarray(level.var_a24c96c7, var_52fa3cae))
	{
		level.var_a24c96c7 = array::exclude(level.var_a24c96c7, var_52fa3cae);
		level.var_e967a159++;
		level thread function_35ab22f4();
		if(var_52fa3cae != level.var_e967a159)
		{
			level.var_31a2dc50 = 1;
		}
		if(!(isdefined(level.var_31a2dc50) && level.var_31a2dc50) && newval == 10)
		{
			else
			{
			}
			if(level.var_e967a159 == 8)
			{
				level.var_f3047a76 = 1;
				/#
					iprintln("");
				#/
			}
		}
		if(level.var_e967a159 >= 9)
		{
			if(isdefined(level.var_31a2dc50) && level.var_31a2dc50)
			{
				level.var_691e2bc4 = 3;
			}
			else
			{
				if(isdefined(level.var_f3047a76) && level.var_f3047a76)
				{
					level.var_691e2bc4 = 1;
				}
				else
				{
					level.var_691e2bc4 = 2;
				}
			}
			level flag::set(#"hash_4207012c64662b4d");
		}
	}
	else
	{
		/#
			iprintln(("" + var_52fa3cae) + "");
		#/
	}
}

/*
	Name: function_35ab22f4
	Namespace: mansion_storage
	Checksum: 0x5AFFC0FB
	Offset: 0x3258
	Size: 0x148
	Parameters: 0
	Flags: Linked
*/
function function_35ab22f4()
{
	var_8997b0bc = struct::get("billiard_table_center", "targetname");
	var_6f868336 = array::get_all_closest(var_8997b0bc.origin, util::get_active_players(#"allies"), undefined, 4, 256);
	foreach(var_2cbc52e0 in var_6f868336)
	{
		if(!(isdefined(var_2cbc52e0.var_14466805) && var_2cbc52e0.var_14466805) && zm_utility::is_player_valid(var_2cbc52e0))
		{
			var_2cbc52e0 thread zm_vo::function_a2bd5a0c(#"hash_528e304a3656551c", 1);
			var_2cbc52e0.var_14466805 = 1;
			return;
		}
	}
}

/*
	Name: function_e061d576
	Namespace: mansion_storage
	Checksum: 0x30ECA3A2
	Offset: 0x33A8
	Size: 0x90
	Parameters: 0
	Flags: None
*/
function function_e061d576()
{
	/#
		level endon(#"hash_4207012c64662b4d");
		while(true)
		{
			if(getdvarint(#"hash_3dcf262f16faced0", 0))
			{
				print3d((-1440, -580, 120), "" + level.var_e967a159, (1, 1, 1), 1, 1, 6);
			}
			wait(0.1);
		}
	#/
}

/*
	Name: function_f21f0537
	Namespace: mansion_storage
	Checksum: 0x677E021E
	Offset: 0x3440
	Size: 0x242
	Parameters: 1
	Flags: Linked
*/
function function_f21f0537(var_a276c861)
{
	if(!isdefined(level.var_691e2bc4))
	{
		return;
	}
	s_pocket = array::random(struct::get_array("table_pocket"));
	switch(level.var_691e2bc4)
	{
		case 1:
		{
			n_rand = randomint(100);
			if(n_rand <= 39)
			{
				level thread function_fd9b3e16(0);
			}
			else
			{
				level thread function_fd9b3e16(function_21a3a673(1, 7));
			}
			break;
		}
		case 2:
		{
			zm_powerups::specific_powerup_drop("bonus_points_player", s_pocket.origin + (vectorscale((0, 0, -1), 8)), undefined, undefined, undefined, 1);
			break;
		}
		case 3:
		{
			a_players = array::get_all_closest(s_pocket.origin, getplayers());
			a_players[0] magicgrenadetype(getweapon(#"eq_frag_grenade"), s_pocket.origin + vectorscale((0, 0, 1), 12), vectorscale((0, 0, 1), 200));
			a_players[0] zm_audio::create_and_play_dialog(#"grenade", #"react", undefined, 1);
			break;
		}
		default:
		{
			break;
		}
	}
}

/*
	Name: function_2ff803fa
	Namespace: mansion_storage
	Checksum: 0xE6C2CA2D
	Offset: 0x3690
	Size: 0x26
	Parameters: 2
	Flags: Linked
*/
function function_2ff803fa(var_a276c861, ended_early)
{
}

/*
	Name: function_fd9b3e16
	Namespace: mansion_storage
	Checksum: 0x23921B8D
	Offset: 0x36C0
	Size: 0x1AC
	Parameters: 1
	Flags: Linked
*/
function function_fd9b3e16(n_reward)
{
	var_8997b0bc = struct::get("billiard_table_center", "targetname");
	mdl_clip = getent("secret_furniture_clip", "targetname");
	var_cef195d9 = scene::get_active_scenes(#"p8_fxanim_zm_man_bookcase_03_bundle");
	var_edd21e7e = var_cef195d9[0];
	var_89bf536b = var_edd21e7e.scene_ents[#"prop 1"];
	mdl_clip enablelinkto();
	mdl_clip linkto(var_89bf536b, "tag_animate");
	level.var_c218e707 = util::spawn_model("tag_origin", mdl_clip.origin);
	level thread function_63c873d9(level.var_c218e707);
	level thread util::delay(2, undefined, &scene::play, #"p8_fxanim_zm_man_bookcase_03_bundle");
	level thread function_cd9f1d74(n_reward);
	mdl_clip connectpaths();
}

/*
	Name: function_a7983bee
	Namespace: mansion_storage
	Checksum: 0xA1D3F85B
	Offset: 0x3878
	Size: 0x18E
	Parameters: 0
	Flags: Linked
*/
function function_a7983bee()
{
	s_shelf = struct::get("storage_shelf");
	wpn_reward = getweapon(#"shotgun_semiauto_t8");
	var_8997b0bc = struct::get("billiard_table_center", "targetname");
	a_players = array::get_all_closest(var_8997b0bc.origin, getplayers());
	mdl_weapon = zm_utility::spawn_buildkit_weapon_model(a_players[0], wpn_reward, undefined, s_shelf.origin + vectorscale((0, 0, 1), 10), s_shelf.angles);
	if(isdefined(mdl_weapon))
	{
		mdl_weapon thread function_7b425c11();
		var_47323b73 = mdl_weapon zm_unitrigger::create(&function_2b75135a, 64, &function_907eba72);
		var_47323b73.mdl_weapon = mdl_weapon;
		var_47323b73.var_498a708 = getweapon(#"shotgun_semiauto_t8");
	}
}

/*
	Name: function_cd9f1d74
	Namespace: mansion_storage
	Checksum: 0x6BDCADD6
	Offset: 0x3A10
	Size: 0x2F2
	Parameters: 1
	Flags: Linked
*/
function function_cd9f1d74(n_reward)
{
	s_shelf = struct::get("storage_shelf");
	switch(n_reward)
	{
		case 0:
		{
			function_a7983bee();
			return;
		}
		case 1:
		{
			var_b7a9df7c = #"p8_zm_elixir_ctrl_z_ui";
			var_ce5ed2e9 = #"zm_bgb_ctrl_z";
		}
		var_b7a9df7c = #"p8_zm_elixir_in_plain_sight_ui";
		var_ce5ed2e9 = #"zm_bgb_in_plain_sight";
		var_b7a9df7c = #"hash_65291a8ef0716ac6";
		var_ce5ed2e9 = #"zm_bgb_phantom_reload";
		var_b7a9df7c = #"p8_zm_elixir_sword_flay_ui";
		var_ce5ed2e9 = #"zm_bgb_sword_flay";
		var_f1ef5a23 = util::spawn_model(var_b7a9df7c, s_shelf.origin, s_shelf.angles);
		var_7b57e2cc = util::spawn_model(#"p8_zm_elixir_bottle_plain_sight_lid", s_shelf.origin + vectorscale((0, 0, 1), 6.75), s_shelf.angles);
		var_47323b73 = var_f1ef5a23 zm_unitrigger::create(&function_cc012e8d, 64);
		var_f1ef5a23 thread function_67c3a7dd();
		var_47323b73.var_f1ef5a23 = var_f1ef5a23;
		var_47323b73.var_7b57e2cc = var_7b57e2cc;
		var_47323b73.var_ce5ed2e9 = var_ce5ed2e9;
		return;
		case 5:
		{
			str_powerup = "nuke";
		}
		str_powerup = "carpenter";
		str_powerup = "double_points";
		wait(4);
		zm_powerups::specific_powerup_drop(str_powerup, s_shelf.origin + (vectorscale((0, 0, -1), 16)), undefined, undefined, undefined, 1);
		return;
	}
}

/*
	Name: function_67c3a7dd
	Namespace: mansion_storage
	Checksum: 0xBE9FD889
	Offset: 0x3D10
	Size: 0xEA
	Parameters: 0
	Flags: Linked
*/
function function_67c3a7dd()
{
	var_163c35fc = self.s_unitrigger;
	if(1)
	{
		for(;;)
		{
			s_result = undefined;
			s_result = self waittill(#"trigger_activated");
			player = s_result.e_who;
		}
		if(!zm_utility::can_use(player))
		{
		}
		self delete();
		var_163c35fc.var_7b57e2cc delete();
		str_bgb = var_163c35fc.var_ce5ed2e9;
		player thread function_7f4f9503(str_bgb);
		zm_unitrigger::unregister_unitrigger(var_163c35fc);
		return;
	}
}

/*
	Name: function_7f4f9503
	Namespace: mansion_storage
	Checksum: 0xB4A8793F
	Offset: 0x3E08
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function function_7f4f9503(str_bgb)
{
	self endon(#"death");
	self bgb::bgb_gumball_anim(str_bgb);
	if(level.bgb[str_bgb].limit_type == "activated")
	{
		self notify(#"hash_27b238d082f65849", str_bgb);
		self bgb::activation_start();
		self thread bgb::run_activation_func(str_bgb);
	}
}

/*
	Name: function_907eba72
	Namespace: mansion_storage
	Checksum: 0x82A2AB28
	Offset: 0x3EB0
	Size: 0xD8
	Parameters: 0
	Flags: Linked
*/
function function_907eba72()
{
	self endon(#"death");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"trigger");
		player = s_result.activator;
		if(!zm_utility::can_use(player))
		{
			continue;
		}
		player thread zm_weapons::weapon_give(self.stub.var_498a708, 1);
		self.stub.mdl_weapon delete();
		zm_unitrigger::unregister_unitrigger(self.stub);
	}
}

/*
	Name: function_2b75135a
	Namespace: mansion_storage
	Checksum: 0xA00EACF5
	Offset: 0x3F90
	Size: 0x96
	Parameters: 1
	Flags: Linked
*/
function function_2b75135a(player)
{
	if(player zm_weapons::has_weapon_or_upgrade(self.stub.var_498a708))
	{
		return false;
	}
	cursor_hint = "HINT_WEAPON";
	self setcursorhint(cursor_hint, self.stub.var_498a708);
	self.hint_string = #"hash_53005c8d5b45bca3";
	return true;
}

/*
	Name: function_cc012e8d
	Namespace: mansion_storage
	Checksum: 0xB7AB4C98
	Offset: 0x4030
	Size: 0x1D6
	Parameters: 1
	Flags: Linked
*/
function function_cc012e8d(player)
{
	switch(self.stub.var_ce5ed2e9)
	{
		case "zm_bgb_ctrl_z":
		{
			str_prompt = zm_utility::function_d6046228(#"hash_620d7c84d23fd049", #"hash_6daedc8fd5a061d7");
			self sethintstringforplayer(player, str_prompt);
			break;
		}
		case "zm_bgb_in_plain_sight":
		{
			str_prompt = zm_utility::function_d6046228(#"hash_1b7e7af38a69fb33", #"hash_47ec1221d6ee9799");
			self sethintstringforplayer(player, str_prompt);
			break;
		}
		case "zm_bgb_phantom_reload":
		{
			str_prompt = zm_utility::function_d6046228(#"hash_31c6885bdf2cb06", #"hash_6517a92891b8b0a2");
			self sethintstringforplayer(player, str_prompt);
			break;
		}
		case "zm_bgb_sword_flay":
		{
			str_prompt = zm_utility::function_d6046228(#"hash_39b5786a03c2d653", #"hash_ef90f6c4217d879");
			self sethintstringforplayer(player, str_prompt);
			break;
		}
	}
	return true;
}

/*
	Name: function_7b425c11
	Namespace: mansion_storage
	Checksum: 0xB01D1ECB
	Offset: 0x4210
	Size: 0x78
	Parameters: 0
	Flags: Linked
*/
function function_7b425c11()
{
	self endon(#"death");
	while(true)
	{
		self movez(-3, 2);
		wait(1.95);
		self movez(3, 2);
		wait(1.95);
	}
}

/*
	Name: function_63c873d9
	Namespace: mansion_storage
	Checksum: 0xD8E0F663
	Offset: 0x4290
	Size: 0x2D8
	Parameters: 1
	Flags: Linked
*/
function function_63c873d9(var_dc2ad9ce)
{
	level endon(#"end_game");
	self endon(#"death");
	var_dc2ad9ce endon(#"hash_2dd745b383eb50c8");
	wait(4);
	var_dc2ad9ce thread function_840d0d56();
	while(true)
	{
		a_e_players = util::get_active_players(#"allies");
		for(i = 0; i < a_e_players.size; i++)
		{
			if(!isdefined(a_e_players[i].var_d2822b91))
			{
				a_e_players[i].var_d2822b91 = 0;
			}
			if(a_e_players[i] mansion_util::is_valid())
			{
				n_index = a_e_players[i] zm_characters::function_d35e4c92();
				str_vo_alias = "vox_secret_chamber_enter_plr_" + n_index;
				var_a5e8d5c7 = zm_audio::get_valid_lines(str_vo_alias);
				if(a_e_players[i].var_d2822b91 < var_a5e8d5c7.size)
				{
					if(distancesquared(var_dc2ad9ce.origin, a_e_players[i].origin) < 65536 && !a_e_players[i] function_80d68e4d(var_dc2ad9ce, 0.766, 0) && bullettracepassed(a_e_players[i] geteye(), var_dc2ad9ce.origin, 0, undefined))
					{
						b_ret = a_e_players[i] zm_vo::vo_say(var_a5e8d5c7[a_e_players[i].var_d2822b91]);
						if(isdefined(b_ret) && b_ret)
						{
							if(isdefined(a_e_players[i]))
							{
								a_e_players[i].var_d2822b91++;
							}
							var_dc2ad9ce notify(#"hash_239e896260dae2d8");
							return;
						}
						i = a_e_players.size;
					}
				}
			}
		}
		wait(0.5);
	}
}

/*
	Name: function_840d0d56
	Namespace: mansion_storage
	Checksum: 0xF7FE7794
	Offset: 0x4570
	Size: 0x172
	Parameters: 0
	Flags: Linked
*/
function function_840d0d56()
{
	self endon(#"hash_239e896260dae2d8");
	var_e699d494 = zm_zonemgr::get_zone_from_position(self.origin, 1);
	/#
		assert(isdefined(var_e699d494), "" + self.origin);
	#/
	var_8259b1e9 = zm_cleanup::get_adjacencies_to_zone(var_e699d494);
	while(true)
	{
		n_players_in_zone = 0;
		foreach(str_zone in var_8259b1e9)
		{
			n_players_in_zone = n_players_in_zone + zm_zonemgr::get_players_in_zone(str_zone, 0);
		}
		if(!n_players_in_zone)
		{
			/#
				iprintln("" + var_e699d494);
			#/
			self notify(#"hash_2dd745b383eb50c8");
			return;
		}
		wait(1);
	}
}

