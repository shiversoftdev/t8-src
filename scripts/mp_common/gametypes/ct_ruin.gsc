// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\player\player_utils.gsc;
#using scripts\mp_common\player\player_loadout.gsc;
#using scripts\mp_common\gametypes\globallogic_spawn.gsc;
#using scripts\mp_common\gametypes\ct_utils.gsc;
#using scripts\mp_common\gametypes\ct_gadgets.gsc;
#using scripts\mp_common\gametypes\ct_ruin_tutorial.gsc;
#using scripts\mp_common\gametypes\ct_core.gsc;
#using scripts\mp_common\gametypes\ct_bots.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\spawning_shared.gsc;
#using scripts\core_common\potm_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace ct_ruin;

/*
	Name: main
	Namespace: ct_ruin
	Checksum: 0xF12B44D9
	Offset: 0x218
	Size: 0x2C4
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	ct_core::function_46e95cc7();
	level.select_character = ct_utils::get_roleindex(#"prt_mp_mercenary");
	level.var_820c5561 = "RUIN";
	ct_utils::function_be3a76b7(level.var_820c5561);
	ct_core::function_fa03fc55();
	clientfield::register("scriptmover", "follow_path_fx", 1, 1, "int");
	level.var_4c2ecc6f = &function_e8a7cae0;
	level.var_c01b7f8b = &function_872c9404;
	level.var_49240db3 = &function_7d779cf7;
	level.var_8b9d690e = &function_926fcb2f;
	level.onspawnplayer = &function_73c1ecd4;
	player::function_cf3aa03d(&function_39002b98);
	level.var_cdb8ae2c = &ct_utils::function_a8da260c;
	level.resurrect_override_spawn = &ct_utils::function_78469779;
	level.var_e31c5d7a = &ct_bots::function_e31c5d7a;
	callback::on_game_playing(&ct_core::function_1e84c767);
	globallogic_spawn::addsupportedspawnpointtype("ct");
	ct_utils::function_6046a5e3(#"ar_fastfire_t8", array(#"steadyaim", #"steadyaim2", #"stalker", #"uber"));
	ct_utils::function_c3e647e2(#"pistol_standard_t8");
	level.var_d6d98fbe = 0;
	level.var_9b517372 = 0;
	level.var_e6417b5b = 0;
	level flag::init("combat_training_started");
	if(level.ctdifficulty == 0)
	{
		level ct_ruin_tutorial::init();
	}
}

/*
	Name: function_73c1ecd4
	Namespace: ct_ruin
	Checksum: 0x784B21B2
	Offset: 0x4E8
	Size: 0x104
	Parameters: 1
	Flags: None
*/
function function_73c1ecd4(predictedspawn)
{
	if(level.ctdifficulty == 0)
	{
		self ct_ruin_tutorial::function_c9ff0dce();
		return;
	}
	self thread ct_core::function_d2845186();
	spawning::onspawnplayer(predictedspawn);
	self ct_core::function_45a4f027();
	if(isbot(self))
	{
		if(isdefined(level.var_e31c5d7a))
		{
			self [[level.var_e31c5d7a]]();
		}
		if(isdefined(self.var_9a79d89d))
		{
			self setorigin(self.var_9a79d89d);
			self setplayerangles(self.var_5ab7c19c);
		}
	}
}

/*
	Name: function_39002b98
	Namespace: ct_ruin
	Checksum: 0x840EBAE
	Offset: 0x5F8
	Size: 0x234
	Parameters: 9
	Flags: None
*/
function function_39002b98(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration)
{
	if(level.ctdifficulty == 0)
	{
		self ct_ruin_tutorial::function_72ba0df6(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
		return;
	}
	if(self.team == #"allies")
	{
		var_d0df641a = spawning::get_spawnpoint_array("mp_t8_spawn_point");
		spawn_pt = arraygetclosest(self.last_valid_position, var_d0df641a);
		self.var_6b6241ac = spawn_pt.origin;
		self.var_45cac770 = self.angles;
		level thread function_7898b91b();
	}
	if(level.var_9b517372 == 1)
	{
		if(self.team == #"axis")
		{
			if(isdefined(weapon) && weapon.name == #"eq_gravityslam")
			{
				if(!(isdefined(level.var_1aa75661) && level.var_1aa75661))
				{
					level.var_1aa75661 = 1;
					level thread function_d999dbe2(undefined);
					level.var_63f34167 = 1;
				}
				else
				{
					level.var_63f34167++;
				}
				level notify(#"hash_43f81887f2dadcb6");
			}
			else if(smeansofdeath != "MOD_TRIGGER_HURT")
			{
				function_d999dbe2(2);
			}
		}
	}
}

/*
	Name: function_e8a7cae0
	Namespace: ct_ruin
	Checksum: 0x15808416
	Offset: 0x838
	Size: 0x7E
	Parameters: 0
	Flags: None
*/
function function_e8a7cae0()
{
	if(level.ctdifficulty !== 0)
	{
		var_932b0566 = getentarray("destroysite", "targetname");
		for(index = 0; index < var_932b0566.size; index++)
		{
			var_932b0566[index] function_ecd8cc50();
		}
	}
}

/*
	Name: function_872c9404
	Namespace: ct_ruin
	Checksum: 0x37C6E004
	Offset: 0x8C0
	Size: 0x3E0
	Parameters: 1
	Flags: None
*/
function function_872c9404(mode)
{
	ct_bots::function_a64b7003(1);
	if(isdefined(level.var_1ecfe3a2))
	{
		self.var_71a70093 = level.var_1ecfe3a2;
	}
	self thread ct_gadgets::function_19181566();
	var_27875ecd = 55000;
	self thread function_9270ab93(0, var_27875ecd);
	self loadout::function_cdb86a18();
	var_932b0566 = getentarray("destroysite", "targetname");
	if(level.ctdifficulty !== 0)
	{
		level.var_b5529824 = var_932b0566.size;
		for(index = 0; index < var_932b0566.size; index++)
		{
			e_trigger = var_932b0566[index];
			e_model = getent(e_trigger.target, "targetname");
			var_d3b9972d = getent(e_model.target, "targetname");
			e_model show();
			var_d3b9972d hide();
			e_model clientfield::set("enemyobj_keyline_render", 0);
			if(isdefined(e_trigger.waypoint))
			{
				e_trigger.waypoint gameobjects::set_visible_team("none");
			}
		}
	}
	else
	{
		for(index = 0; index < var_932b0566.size; index++)
		{
			e_trigger = var_932b0566[index];
			e_model = getent(e_trigger.target, "targetname");
			var_d3b9972d = getent(e_model.target, "targetname");
			e_model ghost();
			e_model connectpaths();
			e_model notsolid();
			var_d3b9972d ghost();
			var_d3b9972d connectpaths();
			var_d3b9972d notsolid();
		}
		a_e_clips = getentarray("clip_destroysite", "targetname");
		foreach(e_clip in a_e_clips)
		{
			e_clip connectpaths();
			e_clip notsolid();
			e_clip ghost();
		}
	}
}

/*
	Name: function_9270ab93
	Namespace: ct_ruin
	Checksum: 0xC3B5F538
	Offset: 0xCA8
	Size: 0x21C
	Parameters: 2
	Flags: None
*/
function function_9270ab93(var_db89c655, var_27875ecd)
{
	var_e7cc5e43 = [];
	var_e7cc5e43[#"mp_frenetic"][1] = 55000;
	var_e7cc5e43[#"mp_frenetic"][2] = 48000;
	var_e7cc5e43[#"mp_frenetic"][3] = 42000;
	var_e7cc5e43[#"mp_offshore"][1] = 55000;
	var_e7cc5e43[#"mp_offshore"][2] = 48000;
	var_e7cc5e43[#"mp_offshore"][3] = 42000;
	var_e7cc5e43[#"mp_seaside"][1] = 52000;
	var_e7cc5e43[#"mp_seaside"][2] = 46000;
	var_e7cc5e43[#"mp_seaside"][3] = 40000;
	var_e7cc5e43[#"mp_silo"][1] = 55000;
	var_e7cc5e43[#"mp_silo"][2] = 48000;
	var_e7cc5e43[#"mp_silo"][3] = 42000;
	str_map = hash(getrootmapname());
	ct_utils::function_7a21ac57(0, var_27875ecd, var_e7cc5e43[str_map][1], var_e7cc5e43[str_map][2], var_e7cc5e43[str_map][3]);
}

/*
	Name: function_7d779cf7
	Namespace: ct_ruin
	Checksum: 0x4C621FFD
	Offset: 0xED0
	Size: 0xD8
	Parameters: 1
	Flags: None
*/
function function_7d779cf7(gamedifficulty)
{
	level endon(#"combattraining_logic_finished");
	level notify(#"hash_2a473e02881ca991");
	level.usingscorestreaks = 0;
	level.disablescoreevents = 1;
	level.disablemomentum = 1;
	if(gamedifficulty == 0)
	{
		level.var_ebad4ea8 = gettime();
		ct_ruin_tutorial::function_9b9525e9();
	}
	else
	{
		function_72e84e64();
	}
	level notify(#"combattraining_logic_finished", {#success:1});
}

/*
	Name: function_926fcb2f
	Namespace: ct_ruin
	Checksum: 0x39755B48
	Offset: 0xFB0
	Size: 0x266
	Parameters: 1
	Flags: None
*/
function function_926fcb2f(b_success)
{
	level endon(#"hash_42057c28bd084d77");
	if(level.ctdifficulty !== 0)
	{
		var_5d3ac5f0 = getentarray("destroysite", "targetname");
		foreach(var_2fdbe1a in var_5d3ac5f0)
		{
			var_2fdbe1a.waypoint gameobjects::set_visible_team("none");
			var_f86fc7a = getentarray(var_2fdbe1a.target, "targetname");
			foreach(var_4abf2290 in var_f86fc7a)
			{
				if(isdefined(var_4abf2290))
				{
					var_4abf2290 clientfield::set("enemyobj_keyline_render", 0);
				}
			}
		}
	}
	level.var_e6417b5b = 0;
	level.var_9b517372 = 0;
	setbombtimer("A", 0);
	setmatchflag("bomb_timer_a", 0);
	var_cd803a6b = gettime() - level.var_ebad4ea8;
	level notify(#"hash_1e387ee13c1e81a7");
	if(b_success)
	{
		level flag::set("ct_player_success");
	}
	else
	{
		level flag::set("ct_fail_timeover");
	}
	level.var_38c87b5 = b_success;
	return var_cd803a6b;
}

/*
	Name: function_ecd8cc50
	Namespace: ct_ruin
	Checksum: 0xE1599DB2
	Offset: 0x1220
	Size: 0x112
	Parameters: 0
	Flags: None
*/
function function_ecd8cc50()
{
	waypointname = #"hash_3489718f227fba3";
	var_69bc8821 = spawn("script_model", self.origin);
	var_69bc8821.objectiveid = gameobjects::get_next_obj_id();
	var_69bc8821.curorigin = self.origin;
	var_69bc8821.ownerteam = game.defenders;
	var_69bc8821.team = game.defenders;
	var_69bc8821.type = "Waypoint";
	objective_add(var_69bc8821.objectiveid, "invisible", var_69bc8821, waypointname);
	var_69bc8821 gameobjects::set_visible_team("none");
	self.waypoint = var_69bc8821;
}

/*
	Name: function_72e84e64
	Namespace: ct_ruin
	Checksum: 0xDDCC765D
	Offset: 0x1340
	Size: 0x21C
	Parameters: 0
	Flags: None
*/
function function_72e84e64()
{
	level endon(#"hash_19a2268f375ca51f");
	self ct_utils::objcounter_init(undefined, 0, level.var_b5529824, 1);
	var_932b0566 = getentarray("destroysite", "targetname");
	level.var_b5529824 = var_932b0566.size;
	var_5c9c3a6e = 1;
	level.var_ebad4ea8 = undefined;
	while(!level.gameended)
	{
		var_55d312bd = undefined;
		for(index = 0; index < var_932b0566.size; index++)
		{
			trigger = var_932b0566[index];
			if(isdefined(trigger) && trigger.script_int == var_5c9c3a6e)
			{
				var_55d312bd = trigger;
				break;
			}
		}
		e_player = ct_utils::get_player();
		if(isdefined(var_55d312bd))
		{
			var_55d312bd thread function_4b5c96a0();
			var_55d312bd waittill(#"target_destroyed");
			if(level.var_b5529824 == 1)
			{
				e_player thread ct_utils::function_329f9ba6(#"hash_1cf0b277aa9809e7", 3, "green", 2);
			}
			else if(level.var_b5529824 == 0)
			{
				e_player potm::bookmark(#"ct_ruin", gettime(), e_player);
			}
		}
		else
		{
			level notify(#"hash_19a2268f375ca51f");
			break;
		}
		var_5c9c3a6e++;
		waitframe(1);
	}
}

/*
	Name: function_4b5c96a0
	Namespace: ct_ruin
	Checksum: 0x503380BF
	Offset: 0x1568
	Size: 0x3C0
	Parameters: 0
	Flags: None
*/
function function_4b5c96a0()
{
	self endon(#"death", #"target_destroyed");
	level endon(#"hash_1e387ee13c1e81a7", #"hash_42057c28bd084d77");
	self.waypoint gameobjects::set_visible_team(#"any");
	b_keyline = 0;
	if(level.var_9b517372 == 0)
	{
		level notify(#"combat_training_started");
		n_bomb_timer = int((gettime() + 1000) + (int(40 * 1000)));
		setbombtimer("A", n_bomb_timer);
		setmatchflag("bomb_timer_a", 1);
		level thread ct_bots::activate_bots(15, #"axis");
		level.var_9b517372 = 1;
		level.var_ebad4ea8 = gettime();
		level thread function_a3e6f3d();
	}
	while(!level.gameended)
	{
		e_model = getent(self.target, "targetname");
		var_d3b9972d = getent(e_model.target, "targetname");
		if(!(isdefined(b_keyline) && b_keyline))
		{
			e_model clientfield::set("enemyobj_keyline_render", 1);
			b_keyline = 1;
		}
		s_notify = undefined;
		s_notify = self waittill(#"damage");
		e_attacker = s_notify.attacker;
		e_weapon = s_notify.weapon;
		if(isdefined(e_attacker) && isdefined(e_weapon) && e_weapon.name == #"eq_gravityslam")
		{
			level.var_b5529824--;
			e_attacker thread ct_utils::function_785eb2ca();
			level thread ct_utils::function_bfa522d1(0);
			e_model clientfield::set("enemyobj_keyline_render", 0);
			waitframe(1);
			e_model hide();
			e_model notsolid();
			var_d3b9972d show();
			var_d3b9972d notsolid();
			level thread function_3c522403();
			self.waypoint gameobjects::set_visible_team("none");
			self notify(#"target_destroyed");
		}
		waitframe(1);
	}
}

/*
	Name: function_7b738fd
	Namespace: ct_ruin
	Checksum: 0x1C8F149E
	Offset: 0x1930
	Size: 0x54
	Parameters: 0
	Flags: None
*/
function function_7b738fd()
{
	wait(1);
	self clientfield::set_to_player("vision_pulse", 1);
	wait(1.25);
	self clientfield::set_to_player("vision_pulse", 0);
}

/*
	Name: function_d999dbe2
	Namespace: ct_ruin
	Checksum: 0x418FF259
	Offset: 0x1990
	Size: 0xB2
	Parameters: 1
	Flags: None
*/
function function_d999dbe2(var_8e2567b1)
{
	if(!level.var_9b517372)
	{
		return;
	}
	if(!isdefined(var_8e2567b1))
	{
		waitframe(1);
	}
	if(isdefined(var_8e2567b1))
	{
		var_75998dae = var_8e2567b1;
	}
	else
	{
		var_75998dae = level.var_63f34167 * 5;
	}
	e_player = util::get_players(#"allies")[0];
	e_player ct_utils::function_d471f8fa(var_75998dae);
	level.var_1aa75661 = 0;
}

/*
	Name: function_7898b91b
	Namespace: ct_ruin
	Checksum: 0xD531E3D1
	Offset: 0x1A50
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function function_7898b91b()
{
	if(level.var_9b517372 == 0)
	{
		return;
	}
	e_player = util::get_players(#"allies")[0];
	e_player ct_utils::function_ee4639dd(-5, 1);
}

/*
	Name: function_3c522403
	Namespace: ct_ruin
	Checksum: 0xB2F4AD88
	Offset: 0x1AC0
	Size: 0x8C
	Parameters: 0
	Flags: None
*/
function function_3c522403()
{
	if(level.var_9b517372 == 0)
	{
		return;
	}
	e_player = util::get_players(#"allies")[0];
	e_player thread function_7b738fd();
	e_player ct_utils::function_329f9ba6(#"hash_4935d639dfe8e756", 2, "green", 1);
}

/*
	Name: function_a3e6f3d
	Namespace: ct_ruin
	Checksum: 0xCAFF9671
	Offset: 0x1B58
	Size: 0xB2
	Parameters: 0
	Flags: None
*/
function function_a3e6f3d()
{
	level endon(#"combattraining_logic_finished");
	level thread ct_utils::timelimitclock_intermission();
	while(!level.gameended)
	{
		var_f08fde43 = function_4c27be22("A");
		currenttime = gettime();
		if(currenttime > var_f08fde43)
		{
			level notify(#"combattraining_logic_finished", {#success:0});
		}
		waitframe(1);
	}
}

