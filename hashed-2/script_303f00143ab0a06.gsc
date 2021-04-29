// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_135d37089bbde4f2;
#using script_2c49ae69cd8ce30c;
#using script_366b8782ff72bb1d;
#using script_490759cf62a1abc8;
#using script_557a707073a952db;
#using script_61826ca279ffa0;
#using script_788472602edbe3b9;
#using script_bb99a1f9be8d0a7;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\oob.gsc;
#using scripts\core_common\potm_shared.gsc;
#using scripts\core_common\spawning_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\mp_common\gametypes\globallogic_spawn.gsc;

#namespace namespace_28cc2b2e;

/*
	Name: main
	Namespace: namespace_28cc2b2e
	Checksum: 0xCFE0EB1B
	Offset: 0x238
	Size: 0x2BC
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	namespace_13777bae::function_46e95cc7();
	level.var_d6d98fbe = 0;
	level.select_character = namespace_73e1c3e3::function_d153452e(#"hash_77bb98ae1ba6c32b");
	level.var_820c5561 = "FIREBREAK";
	namespace_73e1c3e3::function_be3a76b7(level.var_820c5561);
	namespace_13777bae::function_fa03fc55();
	level.var_4c2ecc6f = &function_6db6572b;
	level.var_c01b7f8b = &function_ba542258;
	level.var_49240db3 = &function_b89106ad;
	level.var_8b9d690e = &function_cf3224fe;
	level.onspawnplayer = &function_7c4ef26b;
	player::function_cf3aa03d(&function_9d65db70);
	level.var_cdb8ae2c = &namespace_73e1c3e3::function_a8da260c;
	level.resurrect_override_spawn = &namespace_73e1c3e3::function_78469779;
	level.var_e31c5d7a = &namespace_64a487a9::function_e31c5d7a;
	callback::function_98a0917d(&namespace_13777bae::function_1e84c767);
	globallogic_spawn::addsupportedspawnpointtype("ct");
	namespace_73e1c3e3::function_6046a5e3(#"ar_modular_t8", array("rf", "steadyanim", "mixclip"));
	namespace_73e1c3e3::function_c3e647e2(#"pistol_standard_t8");
	level.ct_firebreak_multi_kill = ct_firebreak_multi_kill::register("ct_firebreak_multi_kill");
	level.var_8eac6c9c = struct::get_array("s_beacon", "targetname");
	level.var_2392bd18 = level.var_8eac6c9c.size;
	if(level.var_cd9d597c == 0)
	{
		level namespace_154e6230::init();
	}
	level flag::init("combat_training_started");
}

/*
	Name: function_7c4ef26b
	Namespace: namespace_28cc2b2e
	Checksum: 0xFC3977A1
	Offset: 0x500
	Size: 0xE4
	Parameters: 1
	Flags: None
*/
function function_7c4ef26b(predictedspawn)
{
	self thread namespace_13777bae::function_d2845186();
	spawning::onspawnplayer(predictedspawn);
	if(level.var_cd9d597c == 0)
	{
		self namespace_154e6230::function_c9ff0dce();
		return;
	}
	if(self.team == #"allies")
	{
		self thread function_d6c7161f();
	}
	if(isbot(self))
	{
		if(isdefined(level.var_e31c5d7a))
		{
			self [[level.var_e31c5d7a]]();
		}
		self thread function_db31e447();
	}
}

/*
	Name: function_db31e447
	Namespace: namespace_28cc2b2e
	Checksum: 0x70AF2378
	Offset: 0x5F0
	Size: 0x1AE
	Parameters: 0
	Flags: None
*/
function function_db31e447()
{
	self endon(#"death");
	s_beacon = function_3192c7f3();
	self setorigin(s_beacon.origin);
	self setplayerangles(s_beacon.angles);
	if(!isdefined(s_beacon.guard1))
	{
		self.var_ef59b90 = 4;
		self.var_59860ee1 = 1000;
		self.var_dd940df3 = 5000;
		self.var_bab91f2 = 800;
		self.var_4c7240f1 = 1;
		self.var_b1fd680c = 1;
		self.var_9a79d89d = s_beacon.origin;
		self.var_5ab7c19c = s_beacon.angles;
		s_beacon.guard1 = self;
		self.beacon = s_beacon;
	}
	else if(!isdefined(s_beacon.guard2))
	{
		self.var_ef59b90 = 4;
		self.var_59860ee1 = 1000;
		self.var_dd940df3 = 5000;
		self.var_bab91f2 = 800;
		self.var_4c7240f1 = 1;
		self.var_b1fd680c = 1;
		self.var_9a79d89d = s_beacon.origin;
		self.var_5ab7c19c = s_beacon.angles;
		s_beacon.guard2 = self;
		self.beacon = s_beacon;
	}
}

/*
	Name: function_9d65db70
	Namespace: namespace_28cc2b2e
	Checksum: 0x772F2A9C
	Offset: 0x7A8
	Size: 0x2CC
	Parameters: 9
	Flags: None
*/
function function_9d65db70(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration)
{
	if(level.var_cd9d597c == 0)
	{
		self namespace_154e6230::function_72ba0df6(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
		return;
	}
	if(self.team == #"allies")
	{
		if(!isdefined(level.var_20361ed4))
		{
			level.var_20361ed4 = -1;
		}
		self thread namespace_73e1c3e3::function_ee4639dd(10 * level.var_20361ed4);
		if(level.var_20361ed4 > -6)
		{
			level.var_20361ed4--;
		}
	}
	else if(isdefined(weapon))
	{
		if(weapon.name == #"hero_flamethrower")
		{
			level.var_6bac32f8++;
		}
		if(weapon.name == #"gadget_radiation_field")
		{
			e_player = getplayers()[0];
			trace = bullettrace(e_player.origin + vectorscale((0, 0, 1), 40), self.origin + vectorscale((0, 0, 1), 40), 0, self);
			if(trace[#"fraction"] < 1)
			{
				e_player thread namespace_73e1c3e3::function_d471f8fa(15, undefined, 1);
				level thread function_db3dc2c2();
			}
		}
	}
	if(isdefined(self.beacon))
	{
		s_beacon = self.beacon;
		self.beacon = undefined;
		if(s_beacon.guard1 === self)
		{
			s_beacon.guard1 = undefined;
		}
		if(s_beacon.guard2 === self)
		{
			s_beacon.guard2 = undefined;
		}
	}
	if(isdefined(level.var_a2cbd584) && level.var_a2cbd584)
	{
		attacker namespace_73e1c3e3::function_785eb2ca();
	}
}

/*
	Name: function_6db6572b
	Namespace: namespace_28cc2b2e
	Checksum: 0xE6A2E7E4
	Offset: 0xA80
	Size: 0xE0
	Parameters: 0
	Flags: None
*/
function function_6db6572b()
{
	level flag::init("mission_success");
	level flag::init("mission_failed");
	level flag::init("gamemode_started");
	foreach(s_beacon in level.var_8eac6c9c)
	{
		s_beacon function_ca63e908();
	}
}

/*
	Name: function_ba542258
	Namespace: namespace_28cc2b2e
	Checksum: 0xEF064796
	Offset: 0xB68
	Size: 0x1CE
	Parameters: 1
	Flags: None
*/
function function_ba542258(mode)
{
	level flag::clear("mission_success");
	level flag::clear("mission_failed");
	level flag::clear("gamemode_started");
	if(isdefined(level.var_1ecfe3a2))
	{
		self.var_71a70093 = level.var_1ecfe3a2;
	}
	self thread namespace_d82263d5::function_19181566();
	var_61ca8276 = 420000;
	self function_9270ab93(0, var_61ca8276);
	self loadout::function_cdb86a18();
	if(level.var_cd9d597c == 0)
	{
		level namespace_154e6230::setup();
	}
	else
	{
		level.var_20361ed4 = -1;
		level.var_f3bb2d59 = 0;
		level.var_8eac6c9c = struct::get_array("s_beacon", "targetname");
		foreach(s_beacon in level.var_8eac6c9c)
		{
			s_beacon.guard1 = undefined;
			s_beacon.guard2 = undefined;
		}
	}
}

/*
	Name: function_9270ab93
	Namespace: namespace_28cc2b2e
	Checksum: 0xD6A11952
	Offset: 0xD40
	Size: 0x224
	Parameters: 2
	Flags: None
*/
function function_9270ab93(var_db89c655, var_27875ecd)
{
	var_e7cc5e43 = [];
	var_e7cc5e43[#"hash_6b9fd25bcf5649cb"][1] = 240000;
	var_e7cc5e43[#"hash_6b9fd25bcf5649cb"][2] = 180000;
	var_e7cc5e43[#"hash_6b9fd25bcf5649cb"][3] = 120000;
	var_e7cc5e43[#"hash_28913deffdfcddf"][1] = 240000;
	var_e7cc5e43[#"hash_28913deffdfcddf"][2] = 180000;
	var_e7cc5e43[#"hash_28913deffdfcddf"][3] = 120000;
	var_e7cc5e43[#"hash_31d29891e0259e47"][1] = 240000;
	var_e7cc5e43[#"hash_31d29891e0259e47"][2] = 180000;
	var_e7cc5e43[#"hash_31d29891e0259e47"][3] = 120000;
	var_e7cc5e43[#"hash_6ccddb822640b098"][1] = 240000;
	var_e7cc5e43[#"hash_6ccddb822640b098"][2] = 180000;
	var_e7cc5e43[#"hash_6ccddb822640b098"][3] = 120000;
	var_b1cb18f1 = hash(getrootmapname());
	namespace_73e1c3e3::function_7a21ac57(var_db89c655, var_27875ecd, var_e7cc5e43[var_b1cb18f1][1], var_e7cc5e43[var_b1cb18f1][2], var_e7cc5e43[var_b1cb18f1][3]);
}

/*
	Name: function_b89106ad
	Namespace: namespace_28cc2b2e
	Checksum: 0xB215657C
	Offset: 0xF70
	Size: 0x11E
	Parameters: 1
	Flags: None
*/
function function_b89106ad(gamedifficulty)
{
	level endon(#"combattraining_logic_finished");
	level notify(#"hash_2a473e02881ca991");
	level.usingscorestreaks = 0;
	level.var_64ce2685 = 1;
	level.disablemomentum = 1;
	if(gamedifficulty == 0)
	{
		namespace_154e6230::function_9b9525e9();
	}
	else
	{
		function_72e84e64();
	}
	if(level flag::get("mission_failed"))
	{
		level notify(#"combattraining_logic_finished", {#success:0});
	}
	else
	{
		level notify(#"combattraining_logic_finished", {#success:1});
	}
	waitframe(1);
}

/*
	Name: function_cf3224fe
	Namespace: namespace_28cc2b2e
	Checksum: 0xC35255C8
	Offset: 0x1098
	Size: 0xD8
	Parameters: 1
	Flags: None
*/
function function_cf3224fe(b_success)
{
	setbombtimer("A", 0);
	setmatchflag("bomb_timer_a", 0);
	namespace_73e1c3e3::get_player() namespace_73e1c3e3::function_8b7a2fdd();
	if(level.var_cd9d597c === 0)
	{
		level.var_38c87b5 = 0;
		var_cd803a6b = gettime();
	}
	else
	{
		level.var_38c87b5 = b_success && level.var_bd8b567a;
		var_cd803a6b = gettime() - level.var_ebad4ea8;
	}
	namespace_73e1c3e3::function_1a477dd();
	return var_cd803a6b;
}

/*
	Name: function_72e84e64
	Namespace: namespace_28cc2b2e
	Checksum: 0x7D13D9AF
	Offset: 0x1178
	Size: 0x2D4
	Parameters: 0
	Flags: None
*/
function function_72e84e64()
{
	level endon(#"combattraining_logic_finished");
	level thread function_5c713990();
	self thread namespace_73e1c3e3::function_68e9fa9e(undefined, 0, level.var_8eac6c9c.size, 1);
	level.var_ebad4ea8 = gettime();
	level.var_bd8b567a = 0;
	level flag::set("gamemode_started");
	level thread function_d2ae88f1();
	level thread namespace_73e1c3e3::function_289b4b9f(#"hash_29f6daee1e40b3af", undefined, 50, "stop_nag", &function_ce452e0);
	level thread namespace_64a487a9::function_4d9cfd95(12, #"axis");
	level thread function_95f8a9b5();
	var_806acf86 = int(gettime() + 1000 + int(480 * 1000));
	setmatchflag("bomb_timer_a", 1);
	setbombtimer("A", var_806acf86);
	while(true)
	{
		var_e8d6f89 = namespace_64a487a9::function_2a8fc6b2();
		if(var_e8d6f89 == 0 && level.var_f3bb2d59 >= level.var_2392bd18)
		{
			level flag::set("mission_success");
			break;
		}
		if(level flag::get("mission_failed"))
		{
			break;
		}
		var_f08fde43 = function_4c27be22("A");
		currenttime = gettime();
		if(currenttime > var_f08fde43)
		{
			level flag::set("mission_failed");
			break;
		}
		waitframe(1);
	}
	setbombtimer("A", 0);
	setmatchflag("bomb_timer_a", 0);
	wait(0.1);
}

/*
	Name: function_ca63e908
	Namespace: namespace_28cc2b2e
	Checksum: 0x1108AA1
	Offset: 0x1458
	Size: 0x112
	Parameters: 0
	Flags: None
*/
function function_ca63e908()
{
	var_3fdd816d = #"hash_2ec158c9943b9697";
	var_90cfcf43 = spawn("script_model", self.origin);
	var_90cfcf43.objectiveid = gameobjects::get_next_obj_id();
	var_90cfcf43.curorigin = self.origin;
	var_90cfcf43.ownerteam = game.defenders;
	var_90cfcf43.team = game.defenders;
	var_90cfcf43.type = "Waypoint";
	objective_add(var_90cfcf43.objectiveid, "invisible", var_90cfcf43, var_3fdd816d);
	var_90cfcf43 gameobjects::set_visible_team("none");
	self.waypoint = var_90cfcf43;
}

/*
	Name: function_5c713990
	Namespace: namespace_28cc2b2e
	Checksum: 0x6566FA6A
	Offset: 0x1578
	Size: 0x19A
	Parameters: 0
	Flags: None
*/
function function_5c713990()
{
	foreach(s_beacon in level.var_8eac6c9c)
	{
		s_beacon.waypoint gameobjects::set_visible_team(#"any");
		s_beacon.e_beacon = spawn("script_model", s_beacon.origin);
		s_beacon.e_beacon setmodel("wpn_t8_eqp_spawnbeacon_world");
		s_beacon.e_beacon clientfield::set("animate_spawn_beacon", 1);
	}
	while(level.var_8eac6c9c.size > 0)
	{
		level waittill(#"hash_7637af9764ebdb0d");
		if(level.var_8eac6c9c.size > 0)
		{
			level thread function_965614a5();
		}
		else
		{
			level thread function_2add9e5f();
			level notify(#"stop_nag");
		}
	}
	level.var_e6db911d = 1;
}

/*
	Name: function_3192c7f3
	Namespace: namespace_28cc2b2e
	Checksum: 0x17D2B5F
	Offset: 0x1720
	Size: 0x8C
	Parameters: 0
	Flags: None
*/
function function_3192c7f3()
{
	if(level.var_8eac6c9c.size == 0)
	{
		return undefined;
	}
	if(!isdefined(level.var_24593a52))
	{
		level.var_24593a52 = 0;
	}
	if(level.var_24593a52 >= level.var_8eac6c9c.size)
	{
		level.var_24593a52 = 0;
	}
	s_beacon = level.var_8eac6c9c[level.var_24593a52];
	level.var_24593a52++;
	return s_beacon;
}

/*
	Name: function_d6c7161f
	Namespace: namespace_28cc2b2e
	Checksum: 0x1CD3B336
	Offset: 0x17B8
	Size: 0x33C
	Parameters: 0
	Flags: None
*/
function function_d6c7161f()
{
	self endon(#"death");
	level endon(#"combattraining_logic_finished");
	while(true)
	{
		self waittill(#"hash_477083bb681cce64");
		var_326df4eb = undefined;
		foreach(s_beacon in level.var_8eac6c9c)
		{
			n_dist = distance(s_beacon.origin, self.origin);
			if(n_dist < 500)
			{
				s_beacon thread function_66a805d4(self);
				var_326df4eb = s_beacon;
				break;
			}
		}
		if(isdefined(var_326df4eb))
		{
			var_583c5a3b = 1.75 + 0.6 * level.var_f3bb2d59;
			n_start_time = gettime() / 1000;
			self waittill_timeout(var_583c5a3b, #"hash_4aaf6d6479e7cf20");
			dt = gettime() / 1000 - n_start_time;
			if(dt >= 1.75)
			{
				arrayremovevalue(level.var_8eac6c9c, s_beacon);
				s_beacon.e_beacon clientfield::set("animate_spawn_beacon", 0);
				level.var_d4722aa0 = 1;
				s_beacon.waypoint gameobjects::set_visible_team("none");
				if(isdefined(s_beacon.guard1))
				{
					s_beacon.guard1.beacon = undefined;
					s_beacon.guard1.var_ef59b90 = 1;
					s_beacon.guard1 = undefined;
				}
				if(isdefined(s_beacon.guard2))
				{
					s_beacon.guard2.beacon = undefined;
					s_beacon.guard2.var_ef59b90 = 1;
					s_beacon.guard2 = undefined;
				}
				level notify(#"hash_7637af9764ebdb0d");
				e_player = getplayers()[0];
				e_player thread namespace_73e1c3e3::function_785eb2ca();
				wait(0.1);
				s_beacon.e_beacon delete();
				wait(1);
				level thread namespace_73e1c3e3::function_bfa522d1(0);
				level.var_f3bb2d59++;
			}
		}
	}
}

/*
	Name: function_66a805d4
	Namespace: namespace_28cc2b2e
	Checksum: 0xC28462CF
	Offset: 0x1B00
	Size: 0xF8
	Parameters: 1
	Flags: None
*/
function function_66a805d4(e_player)
{
	e_player endon(#"death", #"hash_4aaf6d6479e7cf20");
	while(true)
	{
		n_wait = randomfloatrange(0.1, 0.4);
		wait(n_wait);
		n_offset = randomfloatrange(0.2, 60);
		v_pos = (self.origin[0], self.origin[1], self.origin[2] + n_offset);
		playfx(#"explosions/fx_exp_robot_stage3_evb", v_pos);
	}
}

/*
	Name: function_95f8a9b5
	Namespace: namespace_28cc2b2e
	Checksum: 0xFF98B716
	Offset: 0x1C00
	Size: 0x15C
	Parameters: 0
	Flags: None
*/
function function_95f8a9b5()
{
	level endon(#"combattraining_logic_finished");
	level.var_6bac32f8 = 0;
	while(true)
	{
		if(level.var_6bac32f8 >= 2)
		{
			e_player = namespace_73e1c3e3::get_player();
			e_player thread namespace_73e1c3e3::function_d471f8fa(10, undefined, 0);
			level.players[0] potm::bookmark(#"hash_4c22c7ece9ef3e06", gettime(), level.players[0]);
			level.var_bd8b567a = 1;
			level thread function_d6cd1a2d();
			wait(4);
			level.var_6bac32f8 = 0;
		}
		n_time = gettime() / 1000;
		dt = n_time - var_b01b427f;
		if(dt > 2)
		{
			var_b01b427f = n_time;
			level.var_6bac32f8 = 0;
		}
		waitframe(1);
	}
}

/*
	Name: function_ce452e0
	Namespace: namespace_28cc2b2e
	Checksum: 0x108D2BF8
	Offset: 0x1D68
	Size: 0xBA
	Parameters: 0
	Flags: None
*/
function function_ce452e0()
{
	n_time = gettime() / 1000;
	if(!isdefined(level.var_9e5d6c86))
	{
		level.var_9e5d6c86 = n_time;
	}
	if(isdefined(level.var_d4722aa0) && level.var_d4722aa0)
	{
		level.var_d4722aa0 = 0;
		level.var_9e5d6c86 = n_time;
		return 1;
	}
	dt = n_time - level.var_9e5d6c86;
	if(dt < 50.1)
	{
		return 0;
	}
	level.var_9e5d6c86 = n_time;
	return 1;
}

/*
	Name: function_d6cd1a2d
	Namespace: namespace_28cc2b2e
	Checksum: 0x3FCF3E04
	Offset: 0x1E30
	Size: 0x6C
	Parameters: 0
	Flags: None
*/
function function_d6cd1a2d()
{
	e_player = getplayers(#"allies")[0];
	e_player endon(#"death");
	e_player namespace_73e1c3e3::function_329f9ba6(#"hash_543a5a1c6eed9669", 3, "green");
}

/*
	Name: function_965614a5
	Namespace: namespace_28cc2b2e
	Checksum: 0x19E3EDCA
	Offset: 0x1EA8
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function function_965614a5()
{
	e_player = getplayers(#"allies")[0];
	e_player namespace_73e1c3e3::function_329f9ba6(#"hash_1b301c864ab49c7a", 3, "green");
}

/*
	Name: function_2add9e5f
	Namespace: namespace_28cc2b2e
	Checksum: 0xD9A0E35F
	Offset: 0x1F10
	Size: 0xD4
	Parameters: 0
	Flags: None
*/
function function_2add9e5f()
{
	e_player = getplayers(#"allies")[0];
	e_player namespace_73e1c3e3::function_329f9ba6(#"hash_49da6342b2ffd978", 3, "green");
	level.var_a2cbd584 = 1;
	var_39aa8dc8 = util::get_active_players(#"axis");
	var_73968f4d = var_39aa8dc8.size;
	e_player namespace_73e1c3e3::function_68e9fa9e(#"hash_6ad369658d92591d", var_73968f4d, var_73968f4d, 0, 0);
}

/*
	Name: function_db3dc2c2
	Namespace: namespace_28cc2b2e
	Checksum: 0xAB6BC646
	Offset: 0x1FF0
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function function_db3dc2c2()
{
	e_player = getplayers(#"allies")[0];
	e_player namespace_73e1c3e3::function_329f9ba6(#"hash_1e1ef1194ce5ad64", 1.5, "green");
}

/*
	Name: function_d2ae88f1
	Namespace: namespace_28cc2b2e
	Checksum: 0x96007DF6
	Offset: 0x2060
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function function_d2ae88f1()
{
	e_player = getplayers(#"allies")[0];
	e_player thread namespace_73e1c3e3::function_329f9ba6(#"hash_c95709abcf47cdb", 5, "green");
}

