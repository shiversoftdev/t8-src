// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1268b5fd7df90334;
#using script_1cf46b33555422b7;
#using script_20a30e3aaa7368c9;
#using script_2cc4bd7902c3f711;
#using script_2ceedb8f6f1237ee;
#using script_2dc48f46bfeac894;
#using script_3b7405881c081f6;
#using script_3fda550bc6e1089a;
#using script_446da318d52124e0;
#using script_5b092d41f1ecae8a;
#using script_5fece3526d2da5d4;
#using script_677f3ac857d46f22;
#using script_67c9a990c0db216c;
#using script_68d2ee1489345a1d;
#using script_6c8abe14025b47c4;
#using script_7434eebb984beca;
#using script_788472602edbe3b9;
#using script_7c4b080c0766fedc;
#using script_bb99a1f9be8d0a7;
#using script_d92b57cc5ff92a6;
#using script_ee56e8b680377b6;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\bots\bot_action.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\entityheadicons_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\music_shared.gsc;
#using scripts\core_common\oob.gsc;
#using scripts\core_common\perks.gsc;
#using scripts\core_common\potm_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\spawning_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\mp_common\gametypes\globallogic_score.gsc;
#using scripts\mp_common\gametypes\round.gsc;
#using scripts\mp_common\gametypes\spawning.gsc;

#namespace namespace_73e1c3e3;

/*
	Name: function_89f2df9
	Namespace: namespace_73e1c3e3
	Checksum: 0x9D5A2002
	Offset: 0x988
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_20a1ce944e108353", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_73e1c3e3
	Checksum: 0xF38C4A47
	Offset: 0x9D0
	Size: 0x4C4
	Parameters: 0
	Flags: None
*/
function __init__()
{
	clientfield::register("toplayer", "vision_pulse", 1, 1, "int");
	clientfield::register("toplayer", "screen_blur", 1, 1, "int");
	clientfield::register("world", "area_arrows", 1, 3, "int");
	clientfield::register("world", "area_arrows_specialist", 1, 3, "int");
	clientfield::register("scriptmover", "postfx_hitzone", 1, 1, "int");
	clientfield::register("scriptmover", "collisionbox_render", 1, 1, "int");
	level.var_a01c4e36 = spawn("script_model", (0, 0, 0));
	level.var_a01c4e36 setmodel("tag_origin");
	level.var_867e064b = spawn("script_model", (0, 0, 0));
	level.var_867e064b setmodel("tag_origin");
	clientfield::register("scriptmover", "highlight_sphere", 1, 1, "int");
	clientfield::register("scriptmover", "highlight_sphere_normal", 1, 1, "int");
	level.var_96fe26de = util::spawn_model("tag_origin", (0, 0, 0));
	clientfield::register("scriptmover", "highlight_ring", 1, 1, "int");
	level flag::init("times_up");
	level.var_9d6bdb3c = [];
	level.var_7dc28ceb = [];
	for(i = 0; i < 3; i++)
	{
		var_8299f344 = "ct_timer_mod_ticks" + i;
		level.var_7dc28ceb[i] = ct_timer_mod_ticks::register(var_8299f344);
	}
	callback::on_spawned(&namespace_64a487a9::on_bot_spawned);
	level.ct_shared_desc = ct_shared_desc::register("ct_shared_desc");
	lui::function_b95a3ba5("full_screen_movie", &full_screen_movie::register, "full_screen_movie");
	level.var_e92a00d3 = &function_e92a00d3;
	level.var_c3af52cc = &function_c3af52cc;
	level.var_aae00bf = &function_aae00bf;
	level.ct_shared_button_prompt = ct_shared_button_prompt::register("ct_shared_button_prompt");
	level.ct_shared_ingame_hint = ct_shared_ingame_hint::register("ct_shared_ingame_hint");
	level.ct_shared_ingame_objective = ct_shared_ingame_objective::register("ct_shared_ingame_objective");
	level.ct_shared_warning = ct_shared_warning::register("ct_shared_warning");
	level.ct_shared_objcounter = ct_shared_objcounter::register("ct_shared_objcounter");
	level.ct_progressbar_status = ct_progressbar_status::register("ct_progressbar_status");
	function_4f9718b6();
	level.var_4651eae8 = [];
	/#
		level thread function_dfd7add4();
	#/
}

/*
	Name: function_e92a00d3
	Namespace: namespace_73e1c3e3
	Checksum: 0xD7E2CCEA
	Offset: 0xEA0
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function function_e92a00d3()
{
	level.ct_shared_desc ct_shared_desc::open(self);
}

/*
	Name: function_c3af52cc
	Namespace: namespace_73e1c3e3
	Checksum: 0x175A1102
	Offset: 0xED0
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function function_c3af52cc()
{
	level.ct_shared_desc ct_shared_desc::close(self);
}

/*
	Name: function_aae00bf
	Namespace: namespace_73e1c3e3
	Checksum: 0xE287C600
	Offset: 0xF00
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function function_aae00bf(statename)
{
	level.ct_shared_desc ct_shared_desc::set_state(self, statename);
}

/*
	Name: function_281d799
	Namespace: namespace_73e1c3e3
	Checksum: 0xB82C1F7E
	Offset: 0xF38
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function function_281d799(var_6665bc9f = 1)
{
	level.ct_shared_button_prompt ct_shared_button_prompt::open(self, var_6665bc9f);
}

/*
	Name: function_6ebb33af
	Namespace: namespace_73e1c3e3
	Checksum: 0xF8BE274A
	Offset: 0xF80
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function function_6ebb33af()
{
	level.ct_shared_button_prompt ct_shared_button_prompt::close(self);
}

/*
	Name: function_27420756
	Namespace: namespace_73e1c3e3
	Checksum: 0x84B96D5E
	Offset: 0xFB0
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function function_27420756(statename)
{
	level.ct_shared_button_prompt ct_shared_button_prompt::set_state(self, statename);
}

/*
	Name: function_16e45856
	Namespace: namespace_73e1c3e3
	Checksum: 0xB8F0C0AF
	Offset: 0xFE8
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function function_16e45856(var_6665bc9f = 0)
{
	level.ct_shared_ingame_hint ct_shared_ingame_hint::open(self, var_6665bc9f);
}

/*
	Name: function_a7d0e0f3
	Namespace: namespace_73e1c3e3
	Checksum: 0x4C20073D
	Offset: 0x1030
	Size: 0x2E
	Parameters: 0
	Flags: None
*/
function function_a7d0e0f3()
{
	level.ct_shared_ingame_hint ct_shared_ingame_hint::close(self);
	self.var_32fc20b0 = undefined;
}

/*
	Name: function_f89bbe72
	Namespace: namespace_73e1c3e3
	Checksum: 0x61A09FBB
	Offset: 0x1068
	Size: 0x3A
	Parameters: 1
	Flags: None
*/
function function_f89bbe72(value)
{
	level.ct_shared_ingame_hint ct_shared_ingame_hint::function_f9868b51(self, value);
	self.var_32fc20b0 = value;
}

/*
	Name: function_119d3733
	Namespace: namespace_73e1c3e3
	Checksum: 0x623FCB0E
	Offset: 0x10B0
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function function_119d3733(str_state)
{
	level.ct_shared_ingame_hint ct_shared_ingame_hint::set_state(self, str_state);
}

/*
	Name: function_4d58fff0
	Namespace: namespace_73e1c3e3
	Checksum: 0xCC20E3FA
	Offset: 0x10E8
	Size: 0x6C
	Parameters: 1
	Flags: None
*/
function function_4d58fff0(str_color = "grey")
{
	var_af51f36 = hash(str_color + "_fadeout");
	level.ct_shared_ingame_hint ct_shared_ingame_hint::set_state(self, var_af51f36);
	wait(0.5);
}

/*
	Name: swampslashersounds
	Namespace: namespace_73e1c3e3
	Checksum: 0x4D3783AA
	Offset: 0x1160
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function swampslashersounds()
{
	level.ct_shared_ingame_objective ct_shared_ingame_objective::open(self, 1);
}

/*
	Name: function_853efded
	Namespace: namespace_73e1c3e3
	Checksum: 0xE8261D38
	Offset: 0x1190
	Size: 0x54
	Parameters: 1
	Flags: None
*/
function function_853efded(var_5b811c5d)
{
	level.ct_shared_ingame_objective ct_shared_ingame_objective::open(self, 1);
	function_ad40eac3(hash(var_5b811c5d));
}

/*
	Name: function_1bb93418
	Namespace: namespace_73e1c3e3
	Checksum: 0x63EAE14E
	Offset: 0x11F0
	Size: 0x2E
	Parameters: 0
	Flags: None
*/
function function_1bb93418()
{
	level.ct_shared_ingame_objective ct_shared_ingame_objective::close(self);
	self.var_c5598268 = undefined;
}

/*
	Name: function_a7540094
	Namespace: namespace_73e1c3e3
	Checksum: 0x62743852
	Offset: 0x1228
	Size: 0x22
	Parameters: 0
	Flags: None
*/
function function_a7540094()
{
	return level.ct_shared_ingame_objective ct_shared_ingame_objective::is_open(self);
}

/*
	Name: function_d09d6958
	Namespace: namespace_73e1c3e3
	Checksum: 0xA70959AB
	Offset: 0x1258
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function function_d09d6958(value)
{
	level.ct_shared_ingame_objective ct_shared_ingame_objective::function_eab3d36f(self, value);
}

/*
	Name: function_ad40eac3
	Namespace: namespace_73e1c3e3
	Checksum: 0xC9762973
	Offset: 0x1290
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function function_ad40eac3(statename)
{
	level.ct_shared_ingame_objective ct_shared_ingame_objective::set_state(self, statename);
}

/*
	Name: function_80bf685b
	Namespace: namespace_73e1c3e3
	Checksum: 0xFB40455
	Offset: 0x12C8
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function function_80bf685b(value)
{
	level.ct_shared_ingame_objective ct_shared_ingame_objective::function_54166b84(self, value);
}

/*
	Name: function_515c914e
	Namespace: namespace_73e1c3e3
	Checksum: 0xA0422914
	Offset: 0x1300
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function function_515c914e()
{
	level.ct_shared_warning ct_shared_warning::open(self, 1);
}

/*
	Name: function_f272fff4
	Namespace: namespace_73e1c3e3
	Checksum: 0x28B1293C
	Offset: 0x1330
	Size: 0x2E
	Parameters: 0
	Flags: None
*/
function function_f272fff4()
{
	level.ct_shared_warning ct_shared_ingame_objective::close(self);
	self.var_47ba8cb9 = undefined;
}

/*
	Name: function_f05e5477
	Namespace: namespace_73e1c3e3
	Checksum: 0xF4475E7A
	Offset: 0x1368
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function function_f05e5477(statename)
{
	level.ct_shared_warning ct_shared_warning::set_state(self, statename);
}

/*
	Name: function_8e34efd9
	Namespace: namespace_73e1c3e3
	Checksum: 0xB883FE78
	Offset: 0x13A0
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function function_8e34efd9()
{
	level.ct_shared_objcounter ct_shared_objcounter::open(self);
}

/*
	Name: function_8b7a2fdd
	Namespace: namespace_73e1c3e3
	Checksum: 0x8BBEDF0B
	Offset: 0x13D0
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function function_8b7a2fdd()
{
	level.ct_shared_objcounter ct_shared_objcounter::close(self);
}

/*
	Name: function_abf1af6e
	Namespace: namespace_73e1c3e3
	Checksum: 0x8D544020
	Offset: 0x1400
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function function_abf1af6e(value)
{
	level.ct_shared_objcounter ct_shared_objcounter::function_d9fa867a(self, value);
}

/*
	Name: function_9e1cea71
	Namespace: namespace_73e1c3e3
	Checksum: 0x18B7BB0C
	Offset: 0x1438
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function function_9e1cea71(value)
{
	level.ct_shared_objcounter ct_shared_objcounter::function_e23dcbb4(self, value);
}

/*
	Name: function_bf3a2a42
	Namespace: namespace_73e1c3e3
	Checksum: 0x1B02A276
	Offset: 0x1470
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function function_bf3a2a42(value)
{
	level.ct_shared_objcounter ct_shared_objcounter::function_871cdcb3(self, value);
}

/*
	Name: function_d6cbd165
	Namespace: namespace_73e1c3e3
	Checksum: 0x88CCAC94
	Offset: 0x14A8
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function function_d6cbd165(statename)
{
	level.ct_shared_objcounter ct_shared_objcounter::set_state(self, statename);
}

/*
	Name: function_be3a76b7
	Namespace: namespace_73e1c3e3
	Checksum: 0x3A654935
	Offset: 0x14E0
	Size: 0x24A
	Parameters: 1
	Flags: None
*/
function function_be3a76b7(var_7756eaf3)
{
	level.var_13ae9d89 = [];
	if(level.var_cd9d597c !== 0)
	{
		level.var_13ae9d89[#"desc"] = hash(var_7756eaf3 + "_desc");
		level.var_13ae9d89[#"fadeout"] = hash(var_7756eaf3 + "_fadeout");
	}
	else
	{
		level.var_13ae9d89[#"desc"] = hash(var_7756eaf3 + "_desc_training");
		level.var_13ae9d89[#"fadeout"] = hash(var_7756eaf3 + "_fadeout_training");
	}
	level.var_f4bbd9a8 = [];
	var_595f0d40 = #"hash_1077be9b5c6f2d9b" + var_7756eaf3 + "_MISSION_SUCCESS";
	level.var_f4bbd9a8[#"success"] = var_595f0d40;
	level.var_f4bbd9a8[#"hash_6aca9de9c415da07"] = #"hash_101aa27ea217ee3d";
	level.var_f4bbd9a8[#"hash_586014641b63b8f5"] = #"hash_55f0485560f0e4b3";
	var_37b94f55 = function_f0149e2f();
	level.var_8758a1cf = var_7756eaf3 + "_start";
	level thread function_6b71f442();
	level.var_f01ac782 = #"hash_1077be9b5c6f2d9b" + var_7756eaf3 + "_OBJCOUNTER_LABEL";
}

/*
	Name: function_1edf99df
	Namespace: namespace_73e1c3e3
	Checksum: 0x42DEB961
	Offset: 0x1738
	Size: 0x144
	Parameters: 0
	Flags: None
*/
function function_1edf99df()
{
	if(isdefined(level.var_d3aa2fd3))
	{
		self [[level.var_d3aa2fd3]]();
		return;
	}
	a_spawners = spawning::get_spawnpoint_array("mp_t8_spawn_point_allies");
	foreach(spawner in a_spawners)
	{
		if(isdefined(spawner.ct) && spawner.ct)
		{
			break;
		}
	}
	e_player = getplayers(#"allies")[0];
	if(isdefined(e_player))
	{
		e_player setorigin(spawner.origin);
		e_player setplayerangles(spawner.angles);
	}
}

/*
	Name: function_8963dae3
	Namespace: namespace_73e1c3e3
	Checksum: 0xEE36DEFC
	Offset: 0x1888
	Size: 0x100
	Parameters: 0
	Flags: None
*/
function function_8963dae3()
{
	self endon(#"death");
	self notify(#"hash_71db431c3e2ea07d");
	self endon(#"hash_71db431c3e2ea07d", #"hash_17559ffda18178a0");
	if(-1)
	{
		wait(0.5);
		self clientfield::set("enemy_keyline_render", 1);
	}
	else
	{
		while(true)
		{
			level waittill(#"hash_638cbd8ff39a4183");
			self clientfield::set("enemy_keyline_render", 1);
			level waittill(#"hash_930de0009fc6a96");
			self clientfield::set("enemy_keyline_render", 0);
		}
	}
}

/*
	Name: function_6c45e814
	Namespace: namespace_73e1c3e3
	Checksum: 0x71E17844
	Offset: 0x1990
	Size: 0x17E
	Parameters: 1
	Flags: None
*/
function function_6c45e814(n_range)
{
	self endon_callback(&function_c4f8317a, #"death", #"hash_17559ffda18178a0");
	self notify(#"hash_71db431c3e2ea07d");
	waitframe(1);
	self endon(#"hash_71db431c3e2ea07d");
	var_fa4ea12b = "actor_keyline_render";
	if(!isdefined(n_range))
	{
		wait(0.1);
		self clientfield::set(var_fa4ea12b, 1);
	}
	else
	{
		e_player = get_player();
		while(true)
		{
			dist_sq = distancesquared(e_player.origin, self.origin);
			if(dist_sq <= n_range_sq)
			{
				self clientfield::set(var_fa4ea12b, 1);
			}
			else
			{
				self clientfield::set(var_fa4ea12b, 0);
			}
			wait(1);
		}
	}
}

/*
	Name: function_c4f8317a
	Namespace: namespace_73e1c3e3
	Checksum: 0xB5AAC9B
	Offset: 0x1B18
	Size: 0x34
	Parameters: 1
	Flags: None
*/
function function_c4f8317a(var_5a5260d8)
{
	if(isdefined(self))
	{
		self clientfield::set("actor_keyline_render", 0);
	}
}

/*
	Name: minutesandsecondsstring
	Namespace: namespace_73e1c3e3
	Checksum: 0x485A3D82
	Offset: 0x1B58
	Size: 0xCE
	Parameters: 1
	Flags: None
*/
function minutesandsecondsstring(milliseconds)
{
	minutes = floor(float(milliseconds) / 60000);
	milliseconds = milliseconds - minutes * 60000;
	seconds = floor(float(milliseconds) / 1000);
	if(seconds < 10)
	{
		return minutes + ":0" + seconds;
	}
	return minutes + ":" + seconds;
}

/*
	Name: onscoreclosemusic
	Namespace: namespace_73e1c3e3
	Checksum: 0x5384ADFC
	Offset: 0x1C30
	Size: 0x1A4
	Parameters: 0
	Flags: None
*/
function onscoreclosemusic()
{
	while(!level.gameended)
	{
		scorelimit = level.scorelimit;
		scorethreshold = scorelimit * 0.1;
		scorethresholdstart = abs(scorelimit - scorethreshold);
		scorelimitcheck = scorelimit - 10;
		topscore = 0;
		runnerupscore = 0;
		foreach(team, _ in level.teams)
		{
			score = [[level._getteamscore]](team);
			if(score > topscore)
			{
				runnerupscore = topscore;
				topscore = score;
				continue;
			}
			if(score > runnerupscore)
			{
				runnerupscore = score;
			}
		}
		scoredif = topscore - runnerupscore;
		if(topscore >= scorelimit * 0.5)
		{
			level notify(#"sndmusichalfway");
			return;
		}
		wait(1);
	}
}

/*
	Name: hud_message
	Namespace: namespace_73e1c3e3
	Checksum: 0xEE44BA82
	Offset: 0x1DE0
	Size: 0x250
	Parameters: 6
	Flags: None
*/
function hud_message(var_4909a70, str_message, var_2dd80e01, n_y_pos, n_time, n_size = 1)
{
	a_players = util::get_players(#"allies");
	foreach(e_player in a_players)
	{
		var_4909a70 luielemtext::open(e_player, 1);
		var_4909a70 luielemtext::function_d5ea17f0(e_player, str_message);
		var_4909a70 luielemtext::function_f97e9049(e_player, var_2dd80e01, n_y_pos);
		var_4909a70 luielemtext::set_color(e_player, 1, 1, 1);
		var_4909a70 luielemtext::function_aa5c711d(e_player, 1);
		var_4909a70 luielemtext::function_1bd2bb26(e_player, 1);
		var_4909a70 luielemtext::function_5dbd7024(e_player, n_size);
	}
	wait(n_time);
	a_players = util::get_players(#"allies");
	foreach(e_player in a_players)
	{
		var_4909a70 luielemtext::close(e_player);
	}
}

/*
	Name: function_78469779
	Namespace: namespace_73e1c3e3
	Checksum: 0x128DD228
	Offset: 0x2038
	Size: 0x4E
	Parameters: 1
	Flags: None
*/
function function_78469779(ispredictedspawn)
{
	if(isdefined(self.var_6b6241ac) && isdefined(self.var_45cac770))
	{
		self.resurrect_origin = self.var_6b6241ac;
		self.resurrect_angles = self.var_45cac770;
		return 1;
	}
	return 0;
}

/*
	Name: function_ee4639dd
	Namespace: namespace_73e1c3e3
	Checksum: 0xE9954475
	Offset: 0x2090
	Size: 0xA2
	Parameters: 3
	Flags: None
*/
function function_ee4639dd(var_bbda5e06, var_bbe3381f = 1, var_6158669b)
{
	self endon(#"death");
	if(isdefined(level.var_5a623458) && level.var_5a623458)
	{
		return;
	}
	function_c314f6b1(var_bbda5e06);
	self function_2c01129b(var_bbda5e06, var_bbe3381f, var_6158669b);
	level.var_90180521 = 0;
}

/*
	Name: function_d471f8fa
	Namespace: namespace_73e1c3e3
	Checksum: 0xBCB605BF
	Offset: 0x2140
	Size: 0xCC
	Parameters: 4
	Flags: None
*/
function function_d471f8fa(var_75998dae, var_96829af4 = undefined, var_bbe3381f = 0, var_6158669b)
{
	if(isdefined(level.var_5a623458) && level.var_5a623458)
	{
		return;
	}
	if(var_75998dae > 15)
	{
		var_75998dae = 15;
	}
	function_c314f6b1(var_75998dae);
	if(isdefined(level.var_90180521) && level.var_90180521)
	{
		return;
	}
	self thread function_2c01129b(var_75998dae, var_bbe3381f, var_6158669b);
}

/*
	Name: function_2c01129b
	Namespace: namespace_73e1c3e3
	Checksum: 0x87E4051F
	Offset: 0x2218
	Size: 0x164
	Parameters: 3
	Flags: None
*/
function function_2c01129b(var_75998dae, var_35214535 = 1, var_6158669b)
{
	if(var_75998dae > 0)
	{
		var_dd646e5 = var_75998dae;
		str_state = "plus";
	}
	else
	{
		var_dd646e5 = int(abs(var_75998dae));
		str_state = "minus";
	}
	if(isdefined(var_6158669b))
	{
		str_state = str_state + var_6158669b;
	}
	var_a16d72cc = var_dd646e5 % 5;
	var_160345e1 = var_a16d72cc == 0;
	if(var_35214535 || !var_160345e1)
	{
		self thread function_c9ba88ba(str_state, var_dd646e5, 1);
	}
	else
	{
		var_c3183d51 = int(var_dd646e5 / 5);
		if(var_c3183d51 > 3)
		{
			var_c3183d51 = 3;
		}
		self thread function_c9ba88ba(str_state, 5, var_c3183d51);
	}
}

/*
	Name: function_c9ba88ba
	Namespace: namespace_73e1c3e3
	Checksum: 0x5BED8FCB
	Offset: 0x2388
	Size: 0x76
	Parameters: 3
	Flags: None
*/
function function_c9ba88ba(str_state, var_dd646e5, n_count = 1)
{
	for(i = 0; i < n_count; i++)
	{
		self function_b0b54bd5(str_state, var_dd646e5);
	}
}

/*
	Name: function_b0b54bd5
	Namespace: namespace_73e1c3e3
	Checksum: 0x13D12924
	Offset: 0x2408
	Size: 0x8C
	Parameters: 2
	Flags: None
*/
function function_b0b54bd5(var_92c8bf38, var_2cb0d724)
{
	level endon(#"hash_254db7b96984877b");
	self function_a6ee046();
	s_data = {#hash_dd646e5:var_2cb0d724, #str_state:var_92c8bf38};
	array::add(level.var_c48d861d, s_data);
}

/*
	Name: function_a6ee046
	Namespace: namespace_73e1c3e3
	Checksum: 0x4D70522B
	Offset: 0x24A0
	Size: 0x54
	Parameters: 0
	Flags: None
*/
function function_a6ee046()
{
	level endon(#"hash_254db7b96984877b");
	if(!isdefined(level.var_c48d861d))
	{
		level.var_c48d861d = [];
		waitframe(1);
		self thread function_662c2d7e();
	}
}

/*
	Name: function_662c2d7e
	Namespace: namespace_73e1c3e3
	Checksum: 0x503455F5
	Offset: 0x2500
	Size: 0x116
	Parameters: 0
	Flags: None
*/
function function_662c2d7e()
{
	level endon_callback(&function_1386d240, #"hash_254db7b96984877b");
	if(isdefined(level.var_c48d861d))
	{
		while(true)
		{
			if(level.var_c48d861d.size > 0)
			{
				while(var_1b788263 == -1)
				{
					var_1b788263 = function_f14d1a25();
					waitframe(1);
				}
				var_e5717b61 = level.var_c48d861d[0];
				self thread function_2914a896(var_e5717b61.str_state, var_e5717b61.var_dd646e5, var_1b788263);
				level.var_c48d861d = array::remove_index(level.var_c48d861d, 0, 0);
				wait(0.3);
			}
			else
			{
				waitframe(1);
			}
		}
	}
}

/*
	Name: function_1386d240
	Namespace: namespace_73e1c3e3
	Checksum: 0xD75B32C2
	Offset: 0x2620
	Size: 0x16
	Parameters: 1
	Flags: None
*/
function function_1386d240(var_5a5260d8)
{
	level.var_c48d861d = undefined;
}

/*
	Name: function_f14d1a25
	Namespace: namespace_73e1c3e3
	Checksum: 0xE5CD6B1A
	Offset: 0x2640
	Size: 0x62
	Parameters: 0
	Flags: None
*/
function function_f14d1a25()
{
	for(i = 0; i < level.var_7dc28ceb.size; i++)
	{
		if(!level.var_7dc28ceb[i] ct_timer_mod_ticks::is_open(self))
		{
			return i;
		}
	}
	return -1;
}

/*
	Name: function_2914a896
	Namespace: namespace_73e1c3e3
	Checksum: 0xD3224E01
	Offset: 0x26B0
	Size: 0x134
	Parameters: 3
	Flags: None
*/
function function_2914a896(str_state, var_dd646e5, var_e8ee1cd1 = 0)
{
	if(level.var_7dc28ceb[var_e8ee1cd1] ct_timer_mod_ticks::is_open(self))
	{
		return;
	}
	level.var_7dc28ceb[var_e8ee1cd1] ct_timer_mod_ticks::open(self);
	waitframe(1);
	level.var_7dc28ceb[var_e8ee1cd1] thread ct_timer_mod_ticks::function_ab409277(self, var_dd646e5);
	level.var_7dc28ceb[var_e8ee1cd1] ct_timer_mod_ticks::set_state(self, hash(str_state));
	if(str_state == "plus")
	{
		wait(1);
	}
	else
	{
		wait(2);
	}
	level.var_7dc28ceb[var_e8ee1cd1] ct_timer_mod_ticks::close(self);
}

/*
	Name: function_c314f6b1
	Namespace: namespace_73e1c3e3
	Checksum: 0xC76869F5
	Offset: 0x27F0
	Size: 0xAC
	Parameters: 1
	Flags: None
*/
function function_c314f6b1(n_seconds)
{
	var_f08fde43 = function_4c27be22("A");
	bombtimer = int(var_f08fde43 + int(n_seconds * 1000));
	setbombtimer("A", bombtimer);
	setmatchflag("bomb_timer_a", 1);
}

/*
	Name: function_1eef023d
	Namespace: namespace_73e1c3e3
	Checksum: 0x62D28F87
	Offset: 0x28A8
	Size: 0x12C
	Parameters: 0
	Flags: None
*/
function function_1eef023d()
{
	var_87288558 = getentarray("intelpiece", "targetname");
	level.var_76fdcc3e = var_87288558.size;
	/#
		if(isdefined(level.var_295e5d1d) && level.var_295e5d1d)
		{
			level.var_53c2effb setvalue(level.var_76fdcc3e);
		}
	#/
	for(index = 0; index < var_87288558.size; index++)
	{
		var_87288558[index] thread function_18696050();
	}
	/#
		if(isdefined(level.var_295e5d1d) && level.var_295e5d1d)
		{
			while(!level.gameended)
			{
				if(level.var_76fdcc3e <= 0)
				{
					level.var_53c2effb.color = level.green;
				}
				wait(1);
			}
		}
	#/
}

/*
	Name: function_18696050
	Namespace: namespace_73e1c3e3
	Checksum: 0x5F0A0F31
	Offset: 0x29E0
	Size: 0xFC
	Parameters: 0
	Flags: None
*/
function function_18696050()
{
	self endon(#"death");
	var_385703b7 = undefined;
	var_385703b7 = self waittill(#"trigger");
	player = var_385703b7.activator;
	level.var_76fdcc3e--;
	/#
		if(isdefined(level.var_295e5d1d) && level.var_295e5d1d)
		{
			level.var_53c2effb setvalue(level.var_76fdcc3e);
		}
	#/
	model = getent(self.target, "targetname");
	model hide();
	self delete();
}

/*
	Name: function_a8da260c
	Namespace: namespace_73e1c3e3
	Checksum: 0x713B6063
	Offset: 0x2AE8
	Size: 0xEC
	Parameters: 0
	Flags: None
*/
function function_a8da260c()
{
	foreach(team, _ in level.teams)
	{
		spawning::add_spawn_points(team, "mp_tdm_spawn");
		spawning::place_spawn_points(spawning::gettdmstartspawnname(team));
		spawning::add_start_spawn_points(team, spawning::gettdmstartspawnname(team));
	}
	spawning::updateallspawnpoints();
}

/*
	Name: function_bfa522d1
	Namespace: namespace_73e1c3e3
	Checksum: 0xDF16D9C1
	Offset: 0x2BE0
	Size: 0x1DE
	Parameters: 2
	Flags: None
*/
function function_bfa522d1(b_looping, n_cycles = 3)
{
	level endon_callback(&function_d017bdff, #"hash_197ba37b54253531");
	if(isdefined(level.var_5f96112c) && level.var_5f96112c)
	{
		return;
	}
	while(var_fb1ab1b7 > 0)
	{
		level.var_5f96112c = 1;
		level notify(#"hash_638cbd8ff39a4183");
		a_players = getplayers(#"allies");
		foreach(e_player in a_players)
		{
			e_player clientfield::set_to_player("vision_pulse", 1);
		}
		wait(1);
		function_d017bdff();
		level notify(#"hash_930de0009fc6a96");
		if(!(isdefined(b_looping) && b_looping))
		{
			var_fb1ab1b7--;
		}
		wait(2);
		if(level flag::get("combat_training_started") == 0)
		{
			break;
		}
	}
	level.var_5f96112c = 0;
}

/*
	Name: function_d017bdff
	Namespace: namespace_73e1c3e3
	Checksum: 0x285D6B1
	Offset: 0x2DC8
	Size: 0xB0
	Parameters: 1
	Flags: None
*/
function function_d017bdff(var_5a5260d8)
{
	a_players = getplayers(#"allies");
	foreach(e_player in a_players)
	{
		e_player clientfield::set_to_player("vision_pulse", 0);
	}
}

/*
	Name: timelimitclock_intermission
	Namespace: namespace_73e1c3e3
	Checksum: 0x36CC56E5
	Offset: 0x2E80
	Size: 0x17C
	Parameters: 0
	Flags: None
*/
function timelimitclock_intermission()
{
	level endon(#"hash_42057c28bd084d77", #"hash_19a2268f375ca51f");
	clockobject = spawn("script_origin", (0, 0, 0));
	while(n_time_left > 0)
	{
		n_end_time = function_4c27be22("A") / 1000;
		n_time = gettime() / 1000;
		n_time_left = n_end_time - n_time;
		n_delay = undefined;
		if(n_time_left < 5)
		{
			n_delay = 0.5;
		}
		else if(n_time_left < 10)
		{
			n_delay = 0.7;
		}
		else if(n_time_left < 25)
		{
			n_delay = 1;
		}
		else
		{
			n_delay = 2;
		}
		if(isdefined(n_delay))
		{
			clockobject playsound(#"mpl_ui_timer_countdown");
			wait(n_delay);
		}
		else
		{
			wait(1);
		}
	}
	clockobject delete();
}

/*
	Name: function_4adf5b5a
	Namespace: namespace_73e1c3e3
	Checksum: 0xE4A24416
	Offset: 0x3008
	Size: 0x4E
	Parameters: 1
	Flags: None
*/
function function_4adf5b5a(var_58d4bf93)
{
	for(i = 0; i < 10; i++)
	{
		level thread function_c94d8a8a(var_58d4bf93);
		wait(0.6);
	}
}

/*
	Name: function_c94d8a8a
	Namespace: namespace_73e1c3e3
	Checksum: 0x8984F426
	Offset: 0x3060
	Size: 0x254
	Parameters: 1
	Flags: None
*/
function function_c94d8a8a(var_58d4bf93)
{
	if(!isdefined(var_58d4bf93))
	{
		return;
	}
	s_loc = struct::get(var_58d4bf93, "path_struct");
	if(!isdefined(s_loc))
	{
		return;
	}
	e_fx = spawn("script_model", s_loc.origin);
	e_fx setmodel("tag_origin");
	e_fx clientfield::set("follow_path_fx", 1);
	n_dist = 1000;
	while(true)
	{
		while(n_dist > 90)
		{
			v_dir = vectornormalize(s_loc.origin - e_fx.origin);
			v_target_pos = e_fx.origin + v_dir * 80;
			e_fx moveto(v_target_pos, 0.05, 0.05);
			e_fx waittill(#"movedone");
			n_dist = distance(e_fx.origin, s_loc.origin);
		}
		if(!isdefined(s_loc.target))
		{
			break;
		}
		else
		{
			s_loc = struct::get(s_loc.target, "targetname");
		}
		n_dist = 1000;
	}
	e_fx clientfield::set("follow_path_fx", 0);
	wait(1);
	e_fx delete();
}

/*
	Name: function_d836c124
	Namespace: namespace_73e1c3e3
	Checksum: 0x69C406A1
	Offset: 0x32C0
	Size: 0x1D2
	Parameters: 0
	Flags: None
*/
function function_d836c124()
{
	level endon(#"hash_699329b4df616aed");
	while(true)
	{
		if(isdefined(level.var_39c7b92c) && level.var_39c7b92c)
		{
			a_weapons = self getweaponslist();
			foreach(weapon in a_weapons)
			{
				var_18e9a52f = killstreaks::is_killstreak_weapon(weapon);
				if(killstreaks::is_killstreak_weapon(weapon))
				{
					continue;
				}
				var_bcd1c2ff = self gadgetgetslot(weapon);
				n_ammo = self getweaponammoclip(weapon);
				var_71874939 = self getweaponammostock(weapon);
				var_f0ee4385 = self function_f09c133d(weapon);
				if(var_bcd1c2ff == -1 && n_ammo < var_f0ee4385 && var_71874939 < var_f0ee4385)
				{
					self setweaponammostock(weapon, var_f0ee4385 * 2);
				}
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_bd3fa3f4
	Namespace: namespace_73e1c3e3
	Checksum: 0xDBAD5810
	Offset: 0x34A0
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function function_bd3fa3f4(str_team, str_objective)
{
	self thread entityheadicons::setentityheadicon(str_team, self, str_objective);
}

/*
	Name: function_1aebd12f
	Namespace: namespace_73e1c3e3
	Checksum: 0xEF17841E
	Offset: 0x34E0
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function function_1aebd12f()
{
	self entityheadicons::destroyentityheadicons();
}

/*
	Name: function_7b70bd74
	Namespace: namespace_73e1c3e3
	Checksum: 0x2AB20042
	Offset: 0x3508
	Size: 0x104
	Parameters: 5
	Flags: None
*/
function function_7b70bd74(var_9620799e, var_c08433b6, var_8a119ef6, n_width, n_height)
{
	var_9620799e luielembar_ct::open(self);
	var_9620799e luielembar_ct::set_color(self, 1, 1, 1);
	var_9620799e luielembar_ct::function_aa5c711d(self, 1);
	var_9620799e luielembar_ct::function_8b0b5811(self, n_width);
	var_9620799e luielembar_ct::function_5dbd7024(self, n_height);
	var_9620799e luielembar_ct::function_f97e9049(self, var_c08433b6, var_8a119ef6);
	var_9620799e luielembar_ct::function_fd8c13fb(self, 1);
}

/*
	Name: function_5ccd53d5
	Namespace: namespace_73e1c3e3
	Checksum: 0x722FE7AD
	Offset: 0x3618
	Size: 0x328
	Parameters: 1
	Flags: None
*/
function function_5ccd53d5(var_9e2a4c29)
{
	self endon(#"death");
	self thread function_d032ee95();
	level.xpos = 720;
	if(function_9ff75262())
	{
		level.ypos = 320;
	}
	else
	{
		level.ypos = 270;
	}
	level.width = 60;
	level.height = 4;
	if(isdefined(level.var_f6c80c41))
	{
		level.var_f6c80c41 luielembar_ct::close(self);
		waitframe(1);
	}
	level.var_f6c80c41 = var_9e2a4c29;
	self function_7b70bd74(level.var_f6c80c41, level.xpos, level.ypos, level.width, level.height);
	level.var_f6c80c41 luielembar_ct::set_color(self, 0.94, 0.37, 0.07);
	level.var_a6d09364 = 1;
	while(level.var_33682199 < 1)
	{
		level.var_f6c80c41 luielembar_ct::function_fd8c13fb(self, level.var_33682199);
		if(isdefined(level.var_3711d636) && level.var_3711d636 || !isalive(self))
		{
			var_8a119ef6 = -100;
		}
		else
		{
			var_8a119ef6 = level.ypos;
		}
		level.var_f6c80c41 luielembar_ct::function_e5898fd7(self, level.xpos);
		level.var_f6c80c41 luielembar_ct::function_58a135d3(self, var_8a119ef6);
		level.var_f6c80c41 luielembar_ct::function_8b0b5811(self, level.width);
		level.var_f6c80c41 luielembar_ct::function_5dbd7024(self, level.height);
		level.var_f6c80c41 luielembar_ct::function_aa5c711d(self, 0.85);
		waitframe(1);
	}
	if(isdefined(level.var_f6c80c41))
	{
		level.var_f6c80c41 luielembar_ct::close(self);
	}
	level.var_f6c80c41 = undefined;
	level notify(#"hash_4b87ec9759e17f54");
}

/*
	Name: function_d032ee95
	Namespace: namespace_73e1c3e3
	Checksum: 0x6C4BFCAB
	Offset: 0x3948
	Size: 0x86
	Parameters: 0
	Flags: None
*/
function function_d032ee95()
{
	level endon(#"hash_4b87ec9759e17f54");
	self waittill(#"death");
	if(isdefined(level.var_f6c80c41) && level.var_f6c80c41 luielembar_ct::is_open(self))
	{
		level.var_f6c80c41 luielembar_ct::close(self);
		level.var_f6c80c41 = undefined;
	}
}

/*
	Name: function_1ca79c02
	Namespace: namespace_73e1c3e3
	Checksum: 0xC53B095A
	Offset: 0x39D8
	Size: 0x356
	Parameters: 4
	Flags: None
*/
function function_1ca79c02(str_volume, var_7a037bc3, var_224fccce, var_c088c2dd)
{
	level endon(#"hash_338c5bfa53fbbfe7");
	e_player = get_player();
	e_player thread function_5ccd53d5(var_c088c2dd);
	e_volume = getent(str_volume, "targetname");
	n_total = 0;
	while(true)
	{
		e_player = get_player();
		var_443af604 = 0;
		var_3f21ce47 = e_player namespace_64a487a9::function_dde6edbd();
		foreach(bot in var_3f21ce47)
		{
			if(bot istouching(e_volume))
			{
				var_443af604 = 1;
				break;
			}
		}
		if(e_player istouching(e_volume))
		{
			if(var_443af604)
			{
				if(n_mode != 3)
				{
					level clientfield::set("area_arrows", 4);
					n_mode = 3;
				}
			}
			else if(n_mode != 1)
			{
				level clientfield::set("area_arrows", 2);
				n_mode = 1;
			}
			if(!(isdefined(level.var_a1f83db8) && level.var_a1f83db8) && n_mode == 1)
			{
				n_total = n_total + var_7a037bc3;
			}
		}
		else if(var_443af604)
		{
			if(n_mode != 2)
			{
				level clientfield::set("area_arrows", 3);
				n_mode = 2;
			}
		}
		else if(n_mode != 0)
		{
			level clientfield::set("area_arrows", 1);
			n_mode = 0;
		}
		level.var_33682199 = n_total / var_224fccce;
		if(level.var_33682199 >= 1)
		{
			level.var_33682199 = 1;
			break;
		}
		waitframe(1);
	}
	level clientfield::set("area_arrows", 0);
	level notify(#"hash_4b87ec9759e17f54");
	level.var_a88d93f5 = 1;
}

/*
	Name: function_b42ce622
	Namespace: namespace_73e1c3e3
	Checksum: 0xAEDEA671
	Offset: 0x3D38
	Size: 0x2A2
	Parameters: 1
	Flags: None
*/
function function_b42ce622(var_4b3a6521)
{
	if(var_4b3a6521 !== self.var_f82509cd)
	{
		self notify(#"hash_44a6f99e0107f7cc");
		self endon(#"hash_44a6f99e0107f7cc");
		if(!level.ct_progressbar_status ct_progressbar_status::is_open(self))
		{
			level.ct_progressbar_status ct_progressbar_status::open(self, 1);
		}
		self.var_f82509cd = var_4b3a6521;
		self notify(#"hash_3cc1d9808679e79e");
		switch(var_4b3a6521)
		{
			case "hash_af852d7b85b0c03":
			{
				self thread function_7b72086e(#"hash_af852d7b85b0c03", #"hash_7f00f68e42b5b8f6", 1);
				break;
			}
			case "hash_4730cb5d57cb0f20":
			{
				self thread function_7b72086e(#"hash_4730cb5d57cb0f20", #"hash_42f8a09c2e0a99e3", 1);
				break;
			}
			case "hash_4082029e6e323467":
			{
				self thread function_7b72086e(#"hash_4082029e6e323467", #"hash_4f1ec9353f4eee22", 1);
				break;
			}
			case "hash_4a6df362dba78af9":
			{
				level.ct_progressbar_status ct_progressbar_status::set_state(self, #"hash_4a6df362dba78af9");
				wait(3);
				level.ct_progressbar_status ct_progressbar_status::close(self);
				self.var_4ee078d = undefined;
				break;
			}
			case "hash_a890619c656ded5":
			{
				self thread function_7b72086e(#"hash_a890619c656ded5", #"hash_3db441cc059cbd6c", 1);
				break;
			}
			case "hash_7185fe2194047325":
			{
				level.ct_progressbar_status ct_progressbar_status::set_state(self, #"hash_7185fe2194047325");
				wait(3);
				level.ct_progressbar_status ct_progressbar_status::close(self);
				self.var_4ee078d = undefined;
				break;
			}
		}
	}
}

/*
	Name: function_7b72086e
	Namespace: namespace_73e1c3e3
	Checksum: 0xA3A7E2E4
	Offset: 0x3FE8
	Size: 0x86
	Parameters: 3
	Flags: None
*/
function function_7b72086e(var_737e23a7, var_61cb4be0, n_period)
{
	self endon(#"hash_3cc1d9808679e79e");
	while(true)
	{
		level.ct_progressbar_status ct_progressbar_status::set_state(self, var_737e23a7);
		wait(n_period);
		level.ct_progressbar_status ct_progressbar_status::set_state(self, var_61cb4be0);
		wait(n_period);
	}
}

/*
	Name: function_25bd62bc
	Namespace: namespace_73e1c3e3
	Checksum: 0xC78451C1
	Offset: 0x4078
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function function_25bd62bc()
{
	self notify(#"hash_3cc1d9808679e79e");
	level.ct_progressbar_status ct_progressbar_status::close(self);
}

/*
	Name: function_4a23fd2b
	Namespace: namespace_73e1c3e3
	Checksum: 0x24914ACF
	Offset: 0x40B8
	Size: 0x12
	Parameters: 0
	Flags: None
*/
function function_4a23fd2b()
{
	return namespace_64a487a9::function_2a8fc6b2();
}

/*
	Name: create_waypoint
	Namespace: namespace_73e1c3e3
	Checksum: 0x20AAA253
	Offset: 0x40D8
	Size: 0x276
	Parameters: 7
	Flags: None
*/
function create_waypoint(var_1ce6b997, v_origin, v_normal, str_team, var_e9633e99 = game.defenders, var_9c8d914, var_9c57bbcf)
{
	if(isdefined(var_9c57bbcf))
	{
		s_loc = struct::get(var_9c57bbcf, "targetname");
		v_origin = s_loc.origin;
		v_normal = s_loc.angles;
	}
	waypoint = undefined;
	if(isdefined(var_1ce6b997))
	{
		waypoint = spawn("script_model", v_origin);
		waypoint.objectiveid = gameobjects::get_next_obj_id();
		waypoint.curorigin = v_origin;
		waypoint.ownerteam = var_e9633e99;
		waypoint.team = str_team;
		waypoint.type = "Waypoint";
		waypoint.targetname = "waypoint_model";
		if(!isbot(self) && !isactor(self) && !isvehicle(self))
		{
			objective_add(waypoint.objectiveid, "invisible", waypoint, var_1ce6b997);
		}
		else
		{
			objective_add(waypoint.objectiveid, "invisible", self, var_1ce6b997, self);
		}
		waypoint gameobjects::set_visible_team(str_team);
	}
	if(isdefined(var_9c8d914) && var_9c8d914 > 0)
	{
		level thread function_6e8ebcb8(v_origin, v_normal, var_9c8d914);
		if(isdefined(waypoint))
		{
			waypoint thread function_4837e06f(v_origin, v_normal, var_9c8d914);
			waypoint.var_6f8e529b = 1;
		}
	}
	return waypoint;
}

/*
	Name: function_4837e06f
	Namespace: namespace_73e1c3e3
	Checksum: 0x7F8CF3C1
	Offset: 0x4358
	Size: 0x126
	Parameters: 3
	Flags: None
*/
function function_4837e06f(var_c386a7d2, var_a97eacb3, var_9c8d914)
{
	self endon(#"death");
	level endon(#"combattraining_logic_finished");
	while(true)
	{
		e_player = getplayers()[0];
		if(!isalive(e_player))
		{
			level.var_867e064b clientfield::set("highlight_sphere_normal", 0);
			waitframe(1);
			level.var_a01c4e36 clientfield::set("highlight_sphere", 0);
			while(!isalive(e_player))
			{
				waitframe(1);
			}
			wait(0.1);
			level thread function_6e8ebcb8(var_c386a7d2, var_a97eacb3, var_9c8d914);
		}
		waitframe(1);
	}
}

/*
	Name: function_f9ed304d
	Namespace: namespace_73e1c3e3
	Checksum: 0x82F98CBB
	Offset: 0x4488
	Size: 0x10C
	Parameters: 0
	Flags: None
*/
function function_f9ed304d()
{
	self endon(#"death");
	if(isdefined(self))
	{
		if(isdefined(self.var_6f8e529b) && self.var_6f8e529b)
		{
			level notify(#"hash_22c18ee79baaf1a");
			function_47e517be();
			highlight_ring(0);
		}
		if(isdefined(self) && isdefined(self.objectiveid))
		{
			objective_setstate(self.objectiveid, "done");
			gameobjects::release_obj_id(self.objectiveid);
		}
		self delete();
	}
	else if(!isdefined(self))
	{
		/#
			iprintlnbold("");
		#/
	}
}

/*
	Name: function_289b4b9f
	Namespace: namespace_73e1c3e3
	Checksum: 0x3F9416CD
	Offset: 0x45A0
	Size: 0x18E
	Parameters: 5
	Flags: None
*/
function function_289b4b9f(str_message, var_520123e0, var_8e90b9b5, var_f031f5a, var_95690319)
{
	level endon(#"combattraining_logic_finished", #"stop_nag");
	if(isdefined(var_f031f5a))
	{
		level endon(var_f031f5a);
	}
	if(isdefined(var_520123e0))
	{
		wait(var_520123e0);
	}
	while(true)
	{
		if(level flag::get("mission_success") || level flag::get("mission_failed"))
		{
			break;
		}
		n_time = gettime() / 1000;
		if(isdefined(var_95690319))
		{
			if([[var_95690319]]())
			{
				var_6ee32682 = n_time;
			}
		}
		dt = n_time - var_6ee32682;
		if(dt > var_8e90b9b5)
		{
			e_player = getplayers(#"allies")[0];
			e_player thread function_329f9ba6(str_message, 3, "green");
			var_6ee32682 = n_time;
		}
		waitframe(1);
	}
}

/*
	Name: function_aa9c8fbf
	Namespace: namespace_73e1c3e3
	Checksum: 0x1EB5D53D
	Offset: 0x4738
	Size: 0x46
	Parameters: 0
	Flags: None
*/
function function_aa9c8fbf()
{
	var_1411e20e = namespace_64a487a9::function_dde6edbd();
	var_1411e20e = arraysort(var_1411e20e, self.origin, 1);
	return var_1411e20e[0];
}

/*
	Name: face_target
	Namespace: namespace_73e1c3e3
	Checksum: 0x212371
	Offset: 0x4788
	Size: 0x9C
	Parameters: 1
	Flags: None
*/
function face_target(target)
{
	targetangles = vectortoangles(target.origin + vectorscale((0, 0, 1), 32) - self geteye());
	targetangles = (absangleclamp360(targetangles[0]), targetangles[1], targetangles[2]);
	self setplayerangles(targetangles);
}

/*
	Name: function_77111f4b
	Namespace: namespace_73e1c3e3
	Checksum: 0x481C8390
	Offset: 0x4830
	Size: 0x88
	Parameters: 2
	Flags: None
*/
function function_77111f4b(target, settings)
{
	self endon(#"death");
	self notify(#"hash_527a7582f808ac9a");
	self endon(#"hash_527a7582f808ac9a");
	while(isalive(target))
	{
		self face_target(target);
		wait(0.1);
	}
}

/*
	Name: function_7a21ac57
	Namespace: namespace_73e1c3e3
	Checksum: 0xC476AF2B
	Offset: 0x48C0
	Size: 0x194
	Parameters: 6
	Flags: None
*/
function function_7a21ac57(n_type = 0, var_61ca8276, var_9d99d28, var_e25eca94, var_66c4c2c6, var_c7165970)
{
	var_b1cb18f1 = function_f0149e2f();
	str_character = level.var_820c5561;
	var_d0c7d280 = level.var_d0c7d280;
	if(!isdefined(level.var_b613db22))
	{
		level.var_b613db22 = [];
	}
	if(!isdefined(level.var_b613db22[var_b1cb18f1]))
	{
		level.var_b613db22[var_b1cb18f1] = [];
	}
	if(!isdefined(level.var_b613db22[var_b1cb18f1][str_character]))
	{
		level.var_b613db22[var_b1cb18f1][str_character] = [];
	}
	if(!isdefined(level.var_b613db22[var_b1cb18f1][str_character][var_d0c7d280]))
	{
		level.var_b613db22[var_b1cb18f1][str_character][var_d0c7d280] = {#hash_d775ff6a:n_type, #hash_d2b50dd9:var_61ca8276};
	}
	if(!isdefined(var_9d99d28))
	{
		var_9d99d28 = var_61ca8276;
	}
	function_af70d00(n_type, var_9d99d28, var_e25eca94, var_66c4c2c6, var_c7165970);
}

/*
	Name: function_af70d00
	Namespace: namespace_73e1c3e3
	Checksum: 0x87DB7EA3
	Offset: 0x4A60
	Size: 0x2F0
	Parameters: 5
	Flags: None
*/
function function_af70d00(n_type, var_9d99d28, var_e25eca94, var_66c4c2c6, var_c7165970)
{
	var_b1cb18f1 = function_f0149e2f();
	str_character = level.var_820c5561;
	var_d0c7d280 = level.var_d0c7d280;
	if(!isdefined(level.var_a76df030))
	{
		level.var_a76df030 = [];
	}
	if(!isdefined(level.var_a76df030[var_b1cb18f1]))
	{
		level.var_a76df030[var_b1cb18f1] = [];
	}
	if(!isdefined(level.var_a76df030[var_b1cb18f1][str_character]))
	{
		level.var_a76df030[var_b1cb18f1][str_character] = [];
	}
	var_1bc30c71 = [];
	switch(n_type)
	{
		case 0:
		{
			var_c78bd6e9[2] = 0.8888889;
			var_c78bd6e9[3] = 0.8;
			var_c78bd6e9[4] = 0.6666667;
			break;
		}
		case 1:
		{
			var_c78bd6e9[2] = 1.125;
			var_c78bd6e9[3] = 1.25;
			var_c78bd6e9[4] = 1.5;
			break;
		}
	}
	if(!isdefined(var_e25eca94))
	{
		var_e25eca94 = int(var_9d99d28 * var_c78bd6e9[2]);
	}
	if(!isdefined(var_66c4c2c6))
	{
		var_66c4c2c6 = int(var_9d99d28 * var_c78bd6e9[3]);
	}
	if(!isdefined(var_c7165970))
	{
		var_c7165970 = int(var_9d99d28 * var_c78bd6e9[4]);
	}
	if(!isdefined(level.var_a76df030[var_b1cb18f1][str_character][var_d0c7d280]))
	{
		level.var_a76df030[var_b1cb18f1][str_character][var_d0c7d280][1] = var_9d99d28;
		level.var_a76df030[var_b1cb18f1][str_character][var_d0c7d280][2] = var_e25eca94;
		level.var_a76df030[var_b1cb18f1][str_character][var_d0c7d280][3] = var_66c4c2c6;
		level.var_a76df030[var_b1cb18f1][str_character][var_d0c7d280][4] = var_c7165970;
	}
}

/*
	Name: function_d7db338d
	Namespace: namespace_73e1c3e3
	Checksum: 0x75A95BEF
	Offset: 0x4D58
	Size: 0x14
	Parameters: 2
	Flags: None
*/
function function_d7db338d(n_score, n_type)
{
}

/*
	Name: function_661bb2ee
	Namespace: namespace_73e1c3e3
	Checksum: 0x92A536F6
	Offset: 0x4D78
	Size: 0x76
	Parameters: 1
	Flags: None
*/
function function_661bb2ee(n_time)
{
	var_b1cb18f1 = function_f0149e2f();
	str_character = level.var_820c5561;
	var_d0c7d280 = level.var_d0c7d280;
	level.var_b613db22[var_b1cb18f1][str_character][var_d0c7d280].var_d2b50dd9 = n_time;
}

/*
	Name: function_d8c5c1f5
	Namespace: namespace_73e1c3e3
	Checksum: 0x4B69A5E
	Offset: 0x4DF8
	Size: 0x66
	Parameters: 0
	Flags: None
*/
function function_d8c5c1f5()
{
	var_b1cb18f1 = function_f0149e2f();
	str_character = level.var_820c5561;
	var_d0c7d280 = level.var_d0c7d280;
	return level.var_b613db22[var_b1cb18f1][str_character][var_d0c7d280].var_d775ff6a;
}

/*
	Name: function_c6669785
	Namespace: namespace_73e1c3e3
	Checksum: 0x23FF5074
	Offset: 0x4E68
	Size: 0x66
	Parameters: 0
	Flags: None
*/
function function_c6669785()
{
	var_b1cb18f1 = function_f0149e2f();
	str_character = level.var_820c5561;
	var_d0c7d280 = level.var_d0c7d280;
	return level.var_b613db22[var_b1cb18f1][str_character][var_d0c7d280].var_d2b50dd9;
}

/*
	Name: function_9d4708dc
	Namespace: namespace_73e1c3e3
	Checksum: 0xF4CDE601
	Offset: 0x4ED8
	Size: 0x1CA
	Parameters: 4
	Flags: None
*/
function function_9d4708dc(var_52487c6d, var_b1cb18f1 = function_f0149e2f(), str_character = level.var_820c5561, var_d0c7d280 = level.var_d0c7d280)
{
	var_3bb92d22 = function_c6669785();
	var_d775ff6a = function_d8c5c1f5();
	switch(var_d775ff6a)
	{
		case 0:
		{
			if(var_3bb92d22 > var_52487c6d)
			{
				function_661bb2ee(var_52487c6d);
				return {#hash_d2b50dd9:var_52487c6d, #hash_4a4d7e27:1};
			}
			else
			{
				return {#hash_d2b50dd9:var_52487c6d, #hash_4a4d7e27:0};
			}
			break;
		}
		case 1:
		{
			if(var_3bb92d22 < var_52487c6d)
			{
				function_661bb2ee(var_52487c6d);
				return {#hash_d2b50dd9:var_52487c6d, #hash_4a4d7e27:1};
			}
			else
			{
				return {#hash_d2b50dd9:var_52487c6d, #hash_4a4d7e27:0};
			}
			break;
		}
	}
}

/*
	Name: togglezoneeffects
	Namespace: namespace_73e1c3e3
	Checksum: 0xDE19BC69
	Offset: 0x50B0
	Size: 0x6C
	Parameters: 1
	Flags: None
*/
function togglezoneeffects(enabled)
{
	index = 0;
	if(enabled)
	{
		index = self.script_index;
	}
	level clientfield::set("grou", index);
	level clientfield::set("hardpointteam", 0);
}

/*
	Name: function_329f9ba6
	Namespace: namespace_73e1c3e3
	Checksum: 0xB7076F73
	Offset: 0x5128
	Size: 0x274
	Parameters: 7
	Flags: None
*/
function function_329f9ba6(str_hint, n_duration, str_color = "grey", var_2cb3b5d = 0, var_f1840b4a = 0, var_64ef1697, var_2ee3d6f5)
{
	level endon(#"combattraining_logic_finished");
	namespace_8c007aa6::function_731eb7ed();
	if(level.ct_shared_ingame_hint ct_shared_ingame_hint::is_open(self))
	{
		if(self.var_623984bc <= var_2cb3b5d)
		{
			self notify(#"hash_70c145f074995c0");
			self function_a7d0e0f3();
			wait(0.1);
		}
		else
		{
			return;
		}
	}
	if(isdefined(var_f1840b4a) && var_f1840b4a)
	{
		str_color = "red_paused";
	}
	self.var_623984bc = var_2cb3b5d;
	self.var_880571fa = str_color;
	str_state = hash(str_color);
	level.var_29c997df = 1;
	if(!level.ct_shared_ingame_hint ct_shared_ingame_hint::is_open(self))
	{
		if(var_f1840b4a)
		{
			self function_16e45856(1);
		}
		else
		{
			self function_16e45856(0);
		}
	}
	self function_f89bbe72(str_hint);
	level.ct_shared_ingame_hint ct_shared_ingame_hint::set_state(self, str_state);
	e_player = get_player();
	e_player playsound(#"hash_368302d5f70abeac");
	self function_415cd308(n_duration, str_color, var_2cb3b5d, var_f1840b4a, var_64ef1697, var_2ee3d6f5);
	level.var_29c997df = undefined;
	namespace_8c007aa6::function_731eb7ed();
}

/*
	Name: function_415cd308
	Namespace: namespace_73e1c3e3
	Checksum: 0xB355DD2
	Offset: 0x53A8
	Size: 0x176
	Parameters: 6
	Flags: None
*/
function function_415cd308(n_duration, str_color, var_2cb3b5d = 0, var_f1840b4a = 0, var_64ef1697 = "BUTTON_A", var_2ee3d6f5)
{
	level endon(#"combattraining_logic_finished");
	self.var_b4de2f93 = var_f1840b4a;
	if(!var_f1840b4a)
	{
		self endon_callback(&function_6885b9b7, #"death", #"hash_70c145f074995c0");
	}
	else
	{
		self endon_callback(&function_6885b9b7, #"hash_70c145f074995c0");
	}
	if(!(isdefined(var_f1840b4a) && var_f1840b4a))
	{
		wait(n_duration);
	}
	else
	{
		self function_80540e80(var_64ef1697, var_2ee3d6f5);
	}
	if(self.var_623984bc <= var_2cb3b5d)
	{
		self function_4d58fff0(str_color);
		self function_a7d0e0f3();
		wait(0.1);
	}
	self notify(#"hash_70c145f074995c0");
}

/*
	Name: function_6885b9b7
	Namespace: namespace_73e1c3e3
	Checksum: 0xB6544F1B
	Offset: 0x5528
	Size: 0x8E
	Parameters: 1
	Flags: None
*/
function function_6885b9b7(var_5a5260d8)
{
	if(isdefined(self.var_b4de2f93) && self.var_b4de2f93)
	{
		util::stop_magic_bullet_shield(self);
		function_13c4b855(0);
	}
	self function_a7d0e0f3();
	self function_6ebb33af();
	self.var_b4de2f93 = undefined;
}

/*
	Name: function_80540e80
	Namespace: namespace_73e1c3e3
	Checksum: 0x8D80862E
	Offset: 0x55C0
	Size: 0x1FC
	Parameters: 2
	Flags: None
*/
function function_80540e80(var_64ef1697 = "BUTTON_A", var_2ee3d6f5 = 0.5)
{
	level endon(#"combattraining_logic_finished");
	self function_281d799();
	var_c476d87a = [];
	var_c476d87a[#"button_a"] = #"hash_4df4fd56580d5967";
	var_c476d87a[#"hash_1c3ac64d5a66f457"] = #"hash_15620c895dcec00e";
	var_c476d87a[#"hash_24733ab82a65a3fd"] = #"hash_2cb5a2ce94a6ee6d";
	var_c476d87a[#"hash_35fefa934971a359"] = #"hash_72d4665454938ae";
	str_state = var_c476d87a[var_64ef1697];
	var_6976202f = str_state + "_off";
	self function_27420756(str_state);
	function_13c4b855(1);
	if(var_2ee3d6f5 > 0)
	{
		wait(var_2ee3d6f5);
	}
	do
	{
		waitframe(1);
		var_32452cfa = self function_244edbb9(var_64ef1697);
	}
	while(!var_32452cfa);
	function_13c4b855(0);
	self function_27420756(var_6976202f);
	wait(0.5);
	self function_6ebb33af();
}

/*
	Name: function_244edbb9
	Namespace: namespace_73e1c3e3
	Checksum: 0xCCB85D91
	Offset: 0x57C8
	Size: 0xF6
	Parameters: 1
	Flags: None
*/
function function_244edbb9(var_64ef1697 = "BUTTON_A")
{
	switch(var_64ef1697)
	{
		case "button_a":
		{
			b_check = self primarybuttonpressedlocal();
			break;
		}
		case "hash_1c3ac64d5a66f457":
		{
			b_check = self secondaryoffhandbuttonpressed();
			break;
		}
		case "hash_24733ab82a65a3fd":
		{
			b_check = self fragbuttonpressed();
			break;
		}
		case "hash_35fefa934971a359":
		{
			b_check = self reloadbuttonpressed();
			break;
		}
		default:
		{
			b_check = 0;
			break;
		}
	}
	return b_check;
}

/*
	Name: function_13c4b855
	Namespace: namespace_73e1c3e3
	Checksum: 0x8CB63CC2
	Offset: 0x58C8
	Size: 0x19C
	Parameters: 1
	Flags: None
*/
function function_13c4b855(b_pause = 1)
{
	e_player = get_player();
	e_player thread function_84181d75(b_pause, e_player.origin);
	a_e_enemies = e_player namespace_64a487a9::function_dde6edbd();
	foreach(e_enemy in a_e_enemies)
	{
		e_enemy thread function_84181d75(b_pause, e_enemy.origin);
		if(isdefined(b_pause) && b_pause)
		{
			e_enemy val::set("pause_ignoreall", "ignoreall", 1);
			continue;
		}
		e_enemy val::reset("pause_ignoreall", "ignoreall");
	}
	if(!(isdefined(b_pause) && b_pause))
	{
		setpauseworld(0);
	}
	else
	{
		setpauseworld(1);
	}
}

/*
	Name: function_61c3d59c
	Namespace: namespace_73e1c3e3
	Checksum: 0xCAC89FEF
	Offset: 0x5A70
	Size: 0x234
	Parameters: 4
	Flags: None
*/
function function_61c3d59c(str_text, var_3608d414, var_5b811c5d, var_23301438 = 0)
{
	level endon(#"combattraining_logic_finished");
	if(isdefined(level.var_820c5561))
	{
		var_c37c0c7d = isdefined(var_5b811c5d);
		if(isdefined(var_3608d414))
		{
			level thread namespace_8c007aa6::function_831e0584(var_3608d414);
		}
		if(level.ct_shared_ingame_objective ct_shared_ingame_objective::is_open(self))
		{
			self function_1bb93418();
			wait(0.1);
		}
		if(!(isdefined(var_c37c0c7d) && var_c37c0c7d))
		{
			if(isdefined(var_23301438) && var_23301438)
			{
				var_669c07e = #"hash_1ac63732ae333c4d";
				var_6c5a96b8 = #"hash_1ac63732ae333c4d";
			}
			else
			{
				var_669c07e = #"defaultstate";
				var_6c5a96b8 = "DefaultState";
			}
			self swampslashersounds();
			self function_ad40eac3(#"defaultstate");
			self function_d09d6958(str_text);
			self.var_c5598268 = str_text;
		}
		else
		{
			self function_853efded(var_5b811c5d);
		}
		if(function_9ff75262())
		{
			if(!(isdefined(var_c37c0c7d) && var_c37c0c7d))
			{
				self function_ad40eac3(#"defaultstate");
			}
			else
			{
				var_11dcc892 = var_5b811c5d;
				self function_ad40eac3(hash(var_11dcc892));
			}
		}
	}
}

/*
	Name: function_75c126af
	Namespace: namespace_73e1c3e3
	Checksum: 0xF8B8AC9D
	Offset: 0x5CB0
	Size: 0x118
	Parameters: 1
	Flags: None
*/
function function_75c126af(str_id)
{
	var_a41c8e18 = getlocalizedstringindex(str_id);
	a_str_tokens = strtok2(var_a41c8e18, " ");
	var_62de65a3 = 0;
	foreach(token in a_str_tokens)
	{
		if(strendswith(token, "\n") || strstartswith(token, "\n"))
		{
			var_d9c6aaa3 = 1;
		}
	}
	return var_62de65a3;
}

/*
	Name: function_c2a10fc
	Namespace: namespace_73e1c3e3
	Checksum: 0x30B27257
	Offset: 0x5DD0
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function function_c2a10fc()
{
	get_player() thread function_1bb93418();
}

/*
	Name: function_5dec7b34
	Namespace: namespace_73e1c3e3
	Checksum: 0x6E34CBC1
	Offset: 0x5E08
	Size: 0x25C
	Parameters: 2
	Flags: None
*/
function function_5dec7b34(str_warning, var_3608d414)
{
	level endon(#"combattraining_logic_finished", #"hash_5cf057e0a1d4eb77");
	self endon_callback(&function_4057f7fe, #"hash_5cf057e0a1d4eb77");
	if(isdefined(level.var_820c5561))
	{
		if(isdefined(var_3608d414))
		{
			level thread namespace_8c007aa6::function_831e0584(var_3608d414);
		}
		if(level.ct_shared_warning ct_shared_warning::is_open(self))
		{
			self function_f272fff4();
			wait(0.1);
		}
		var_fe0e3b3a = str_warning;
		if(function_9ff75262())
		{
			var_fe0e3b3a = str_warning + "_timer_on";
		}
		self.var_ef34d22c = [];
		self.var_ef34d22c[#"fadein"] = hash(var_fe0e3b3a);
		self.var_ef34d22c[#"hash_5aed5784ff6e4420"] = hash(var_fe0e3b3a + "_cycle1");
		self.var_ef34d22c[#"hash_5aed5a84ff6e4939"] = hash(var_fe0e3b3a + "_cycle2");
		self.var_ef34d22c[#"fadeout"] = hash(var_fe0e3b3a + "_fadeout");
		self function_515c914e();
		self function_f05e5477(hash(self.var_ef34d22c[#"fadein"]));
		self.var_47ba8cb9 = str_warning;
		wait(1);
		self thread function_3915e4f9();
	}
}

/*
	Name: function_3915e4f9
	Namespace: namespace_73e1c3e3
	Checksum: 0x1769AD0F
	Offset: 0x6070
	Size: 0x106
	Parameters: 0
	Flags: None
*/
function function_3915e4f9()
{
	self endon_callback(&function_4057f7fe, #"hash_5cf057e0a1d4eb77");
	self endon(#"hash_76ffabe3ed35bd68");
	while(true)
	{
		self function_f05e5477(hash(self.var_ef34d22c[#"hash_5aed5784ff6e4420"]));
		self playsound(#"mpl_ui_timer_countdown");
		wait(1);
		self function_f05e5477(hash(self.var_ef34d22c[#"hash_5aed5a84ff6e4939"]));
		self playsound(#"mpl_ui_timer_countdown");
		wait(1);
	}
}

/*
	Name: function_4057f7fe
	Namespace: namespace_73e1c3e3
	Checksum: 0xD155B05D
	Offset: 0x6180
	Size: 0x7C
	Parameters: 1
	Flags: None
*/
function function_4057f7fe(var_5a5260d8)
{
	e_player = get_player();
	e_player function_f05e5477(hash(self.var_ef34d22c[#"fadeout"]));
	wait(1);
	e_player function_f272fff4();
}

/*
	Name: function_514bda3b
	Namespace: namespace_73e1c3e3
	Checksum: 0x5DBC0FFC
	Offset: 0x6208
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function function_514bda3b()
{
	get_player() thread function_f272fff4();
}

/*
	Name: function_9ff75262
	Namespace: namespace_73e1c3e3
	Checksum: 0xF71B156F
	Offset: 0x6240
	Size: 0x3E
	Parameters: 0
	Flags: None
*/
function function_9ff75262()
{
	var_806acf86 = function_4c27be22("A");
	var_28047ab4 = var_806acf86 > gettime();
	return var_28047ab4;
}

/*
	Name: function_ebd7bf6a
	Namespace: namespace_73e1c3e3
	Checksum: 0xF3623F4E
	Offset: 0x6288
	Size: 0x158
	Parameters: 2
	Flags: None
*/
function function_ebd7bf6a(n_seconds = 60, var_f6dfeaa0 = "countdown_timer_done")
{
	level endon_callback(&function_18747fb7, #"hash_582be86269c7fecc");
	var_806acf86 = int(gettime() + int(n_seconds * 1000));
	setmatchflag("bomb_timer_a", 1);
	setbombtimer("A", var_806acf86);
	while(true)
	{
		var_f08fde43 = function_4c27be22("A");
		currenttime = gettime();
		if(currenttime > var_f08fde43)
		{
			level notify(var_f6dfeaa0);
			break;
		}
		waitframe(1);
	}
	level notify(#"countdown_timer_done");
	level notify(#"hash_582be86269c7fecc");
}

/*
	Name: function_18747fb7
	Namespace: namespace_73e1c3e3
	Checksum: 0xD145CFC
	Offset: 0x63E8
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function function_18747fb7(var_5a5260d8)
{
	setbombtimer("A", 0);
	setmatchflag("bomb_timer_a", 0);
}

/*
	Name: function_d3a4d2f8
	Namespace: namespace_73e1c3e3
	Checksum: 0x86DA31E
	Offset: 0x6430
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function function_d3a4d2f8()
{
	if(isdefined(self.var_c5598268))
	{
		self function_61c3d59c(self.var_c5598268, undefined);
	}
}

/*
	Name: function_4f9718b6
	Namespace: namespace_73e1c3e3
	Checksum: 0xEFA4828B
	Offset: 0x6468
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function function_4f9718b6()
{
	level function_4efa232a("ct_fail_timeover");
	level function_4efa232a("ct_fail_objective_killed");
	level function_4efa232a("ct_player_success");
}

/*
	Name: function_4efa232a
	Namespace: namespace_73e1c3e3
	Checksum: 0xF1429615
	Offset: 0x64D8
	Size: 0x54
	Parameters: 1
	Flags: None
*/
function function_4efa232a(str_flag)
{
	if(!level flag::exists(str_flag))
	{
		level flag::init(str_flag);
	}
	level flag::clear(str_flag);
}

/*
	Name: function_f03da80a
	Namespace: namespace_73e1c3e3
	Checksum: 0xE1A67D9D
	Offset: 0x6538
	Size: 0x14C
	Parameters: 0
	Flags: None
*/
function function_f03da80a()
{
	wait(0.25);
	if(level.var_cd9d597c === 0)
	{
		str_start = level.var_8758a1cf + "_tutorial";
		a_s_start = struct::get_array(str_start, "script_noteworthy");
		if(a_s_start.size > 0)
		{
			s_start = array::random(a_s_start);
			self setorigin(s_start.origin);
			self setplayerangles(s_start.angles);
			return;
		}
	}
	a_s_start = struct::get_array(level.var_8758a1cf, "script_noteworthy");
	if(a_s_start.size > 0)
	{
		s_start = array::random(a_s_start);
		self setorigin(s_start.origin);
		self setplayerangles(s_start.angles);
	}
}

/*
	Name: function_6b71f442
	Namespace: namespace_73e1c3e3
	Checksum: 0x55A90407
	Offset: 0x6690
	Size: 0x146
	Parameters: 0
	Flags: None
*/
function function_6b71f442()
{
	function_64f9f527();
	var_d00cf77 = struct::get_array("s_ct_obstacle", "targetname");
	var_23537161 = array::filter(var_d00cf77, 0, &function_e928f210);
	if(var_23537161.size > 0)
	{
		foreach(s_obj in var_23537161)
		{
			var_3b354f88 = util::spawn_model(s_obj.model, s_obj.origin, s_obj.angles);
			var_3b354f88 disconnectpaths();
			level.var_ab9d8cc4[level.var_ab9d8cc4.size] = var_3b354f88;
		}
	}
}

/*
	Name: function_e928f210
	Namespace: namespace_73e1c3e3
	Checksum: 0x7AF22AC
	Offset: 0x67E0
	Size: 0x20
	Parameters: 1
	Flags: None
*/
function function_e928f210(element)
{
	return element.script_string === level.var_820c5561;
}

/*
	Name: function_64f9f527
	Namespace: namespace_73e1c3e3
	Checksum: 0x8E5210D5
	Offset: 0x6808
	Size: 0xB6
	Parameters: 0
	Flags: None
*/
function function_64f9f527()
{
	if(isdefined(level.var_ab9d8cc4))
	{
		foreach(var_3b354f88 in level.var_ab9d8cc4)
		{
			var_3b354f88 connectpaths();
			var_3b354f88 delete();
		}
	}
	level.var_ab9d8cc4 = [];
}

/*
	Name: function_68e9fa9e
	Namespace: namespace_73e1c3e3
	Checksum: 0xD07C2E9
	Offset: 0x68C8
	Size: 0x284
	Parameters: 5
	Flags: None
*/
function function_68e9fa9e(str_label, var_8f1f8855, n_total, n_mode = 0, var_455d8dee = 1)
{
	if(isplayer(self))
	{
		if(!isdefined(str_label))
		{
			str_label = level.var_f01ac782;
		}
		if(!level.ct_shared_objcounter ct_shared_objcounter::is_open(self))
		{
			level.ct_shared_objcounter ct_shared_objcounter::open(self, 1);
		}
		self function_abf1af6e(str_label);
		self function_bf3a2a42(n_total);
		level.var_a3e856b1 = [];
		if(var_455d8dee)
		{
			level.var_a3e856b1[#"init"] = #"hash_2d31980bd7e27adc";
			level.var_a3e856b1[#"idle"] = #"total";
			level.var_a3e856b1[#"update"] = #"hash_3a90323ee061faef";
		}
		else
		{
			level.var_a3e856b1[#"init"] = #"hash_5edcadf19882d66f";
			level.var_a3e856b1[#"idle"] = #"hash_2da0af76542bf74";
			level.var_a3e856b1[#"update"] = #"hash_1895dd9cec027130";
		}
		self function_d6cbd165(level.var_a3e856b1[#"init"]);
		wait(0.25);
		level.ct_shared_objcounter.n_count = var_8f1f8855;
		level.ct_shared_objcounter.n_mode = n_mode;
		self function_9e1cea71(var_8f1f8855);
	}
}

/*
	Name: function_785eb2ca
	Namespace: namespace_73e1c3e3
	Checksum: 0x15746D51
	Offset: 0x6B58
	Size: 0x16C
	Parameters: 0
	Flags: None
*/
function function_785eb2ca()
{
	if(isplayer(self))
	{
		/#
			assert(isdefined(level.ct_shared_objcounter.n_count), "");
		#/
		switch(level.ct_shared_objcounter.n_mode)
		{
			case 0:
			{
				level.ct_shared_objcounter.n_count--;
				break;
			}
			case 1:
			{
				level.ct_shared_objcounter.n_count++;
				break;
			}
		}
		if(!level.ct_shared_objcounter ct_shared_objcounter::is_open(self))
		{
			self function_8e34efd9();
		}
		self function_d6cbd165(level.var_a3e856b1[#"update"]);
		wait(0.25);
		function_9e1cea71(level.ct_shared_objcounter.n_count);
		wait(0.25);
		self function_d6cbd165(level.var_a3e856b1[#"idle"]);
	}
}

/*
	Name: function_acfb4f94
	Namespace: namespace_73e1c3e3
	Checksum: 0xEB00EE43
	Offset: 0x6CD0
	Size: 0x16
	Parameters: 0
	Flags: None
*/
function function_acfb4f94()
{
	return level.ct_shared_objcounter.n_count;
}

/*
	Name: function_39e123a6
	Namespace: namespace_73e1c3e3
	Checksum: 0xB6FFB9A3
	Offset: 0x6CF0
	Size: 0x74
	Parameters: 2
	Flags: None
*/
function function_39e123a6(v_loc, var_16c01e01 = #"frag_grenade")
{
	var_12bdc323 = getweapon(var_16c01e01);
	self magicgrenademanualplayer(v_loc, (0, 0, 1), var_12bdc323, 0.05);
}

/*
	Name: is_facing
	Namespace: namespace_73e1c3e3
	Checksum: 0x447CB4EE
	Offset: 0x6D70
	Size: 0x1A0
	Parameters: 3
	Flags: None
*/
function is_facing(facee, requireddot = 0.5, b_2d = 1)
{
	if(isplayer(self))
	{
		orientation = self getplayerangles();
	}
	else if(isvehicle(self))
	{
		orientation = self.angles;
	}
	v_forward = anglestoforward(orientation);
	v_to_facee = facee.origin - self.origin;
	if(b_2d)
	{
		v_forward_computed = (v_forward[0], v_forward[1], 0);
		v_to_facee_computed = (v_to_facee[0], v_to_facee[1], 0);
	}
	else
	{
		v_forward_computed = v_forward;
		v_to_facee_computed = v_to_facee;
	}
	v_unit_forward_computed = vectornormalize(v_forward_computed);
	v_unit_to_facee_computed = vectornormalize(v_to_facee_computed);
	dotproduct = vectordot(v_unit_forward_computed, v_unit_to_facee_computed);
	return dotproduct > requireddot;
}

/*
	Name: function_63b6472b
	Namespace: namespace_73e1c3e3
	Checksum: 0x29583F
	Offset: 0x6F18
	Size: 0x118
	Parameters: 2
	Flags: None
*/
function function_63b6472b(v_origin, var_22068a81)
{
	v_check = self.origin;
	v_min = v_origin - var_22068a81;
	v_max = v_origin + var_22068a81;
	var_f33cbcc3 = v_min[0] <= v_check[0] && v_check[0] <= v_max[0];
	var_fdafd1a9 = v_min[1] <= v_check[1] && v_check[0] <= v_max[1];
	var_9e6ea17 = v_min[2] <= v_check[2] && v_check[0] <= v_max[2];
	return var_f33cbcc3 && var_fdafd1a9 && var_9e6ea17;
}

/*
	Name: get_player
	Namespace: namespace_73e1c3e3
	Checksum: 0x3F608C7E
	Offset: 0x7038
	Size: 0x46
	Parameters: 0
	Flags: None
*/
function get_player()
{
	var_f353312a = util::get_players(#"allies");
	if(var_f353312a.size > 0)
	{
		return var_f353312a[0];
	}
	return undefined;
}

/*
	Name: function_6d7f4ec6
	Namespace: namespace_73e1c3e3
	Checksum: 0x7FF0D011
	Offset: 0x7088
	Size: 0xB4
	Parameters: 1
	Flags: None
*/
function function_6d7f4ec6(var_cfc2603c)
{
	var_806acf86 = int(gettime() + 1000 + int(var_cfc2603c * 1000));
	setbombtimer("A", var_806acf86);
	setmatchflag("bomb_timer_a", 1);
	level.var_ebad4ea8 = gettime();
	level thread function_a3e6f3d();
}

/*
	Name: function_a3e6f3d
	Namespace: namespace_73e1c3e3
	Checksum: 0x141E874D
	Offset: 0x7148
	Size: 0xD2
	Parameters: 0
	Flags: None
*/
function function_a3e6f3d()
{
	level endon_callback(&function_292141a, #"combattraining_logic_finished", #"hash_52fa8babe8d8d2c9");
	level thread timelimitclock_intermission();
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

/*
	Name: function_292141a
	Namespace: namespace_73e1c3e3
	Checksum: 0x812640DE
	Offset: 0x7228
	Size: 0x4A
	Parameters: 1
	Flags: None
*/
function function_292141a(var_5a5260d8)
{
	setbombtimer("A", 0);
	setmatchflag("bomb_timer_a", 0);
	level.var_f3467dae = gettime();
}

/*
	Name: function_c3a6c010
	Namespace: namespace_73e1c3e3
	Checksum: 0x634089BC
	Offset: 0x7280
	Size: 0x13A
	Parameters: 0
	Flags: None
*/
function function_c3a6c010()
{
	setdvar(#"custom_killstreak_mode", 0);
	setdvar(#"hash_26de0c20bc979e24", "");
	setdvar(#"hash_26de0f20bc97a33d", "");
	setdvar(#"hash_26de0e20bc97a18a", "");
	setdvar(#"hash_3e06b14c41136e95", 0);
	setdvar(#"scr_scorestreaks", 1);
	level.usingscorestreaks = getdvarint(#"scr_scorestreaks", 0) != 0;
	level.var_64ce2685 = 0;
	level.disablemomentum = 0;
	level.usingmomentum = 1;
}

/*
	Name: function_c1699637
	Namespace: namespace_73e1c3e3
	Checksum: 0xB7DE5796
	Offset: 0x73C8
	Size: 0x7C
	Parameters: 0
	Flags: None
*/
function function_c1699637()
{
	function_64f9f527();
	function_c3a6c010();
	level.skipgameend = 1;
	level.var_8eb8847f = 1;
	round::function_d1e740f6(#"allies");
	globallogic::end_round(1);
}

/*
	Name: function_1a3c644e
	Namespace: namespace_73e1c3e3
	Checksum: 0x1C0FFF4
	Offset: 0x7450
	Size: 0x3C2
	Parameters: 6
	Flags: None
*/
function function_1a3c644e(loc, str_waypoint = #"hash_1f1deaa6bff12db8", var_a0b3876d = 64, var_55ce88ff, var_3b37a003 = "tutorial_goto_done", var_8fe28ab0 = 0)
{
	level endon_callback(&function_4542f02, #"combattraining_logic_finished", #"hash_56fb6ae4bbd573d9");
	if(isdefined(var_8fe28ab0) && var_8fe28ab0)
	{
		self endon_callback(&function_4542f02, #"death");
	}
	if(isvec(loc))
	{
		v_loc = loc;
	}
	else if(isentity(loc) || isstruct(loc))
	{
		s_loc = loc;
		v_loc = loc.origin;
	}
	else if(isstring(loc))
	{
		var_837a5de6 = getent(loc, "targetname");
		s_loc = struct::get(loc, "targetname");
		if(isdefined(var_837a5de6))
		{
			v_loc = var_837a5de6.origin;
			v_ang = var_837a5de6.angles;
		}
		else if(isdefined(s_loc))
		{
			v_loc = s_loc.origin;
			v_ang = s_loc.angles;
		}
	}
	e_player = get_player();
	if(!e_player function_e768df25(v_loc, var_a0b3876d))
	{
		level.var_d811d31a = create_waypoint(str_waypoint, v_loc, v_ang, #"any", undefined, var_a0b3876d);
		level.var_d811d31a clientfield::set("postfx_hitzone", 1);
		if(isdefined(var_55ce88ff))
		{
			self waittill(var_55ce88ff);
		}
		wait(0.5);
		if(isdefined(s_loc.radius))
		{
			var_a0b3876d = s_loc.radius;
		}
		function_d25bd3c9(v_loc, var_a0b3876d, 0);
		if(isdefined(level.var_d811d31a))
		{
			level.var_d811d31a clientfield::set("postfx_hitzone", 0);
			waitframe(1);
			level.var_d811d31a function_f9ed304d();
			level.var_d811d31a = undefined;
		}
		function_c2a10fc();
		get_player() playsound(#"uin_objective_updated");
		waitframe(1);
	}
	if(isdefined(var_3b37a003))
	{
		self notify(var_3b37a003);
	}
}

/*
	Name: function_4542f02
	Namespace: namespace_73e1c3e3
	Checksum: 0x71DD25BD
	Offset: 0x7820
	Size: 0x7E
	Parameters: 1
	Flags: None
*/
function function_4542f02(var_5a5260d8)
{
	level notify(#"hash_360fb35e8476aec5");
	if(isdefined(level.var_d811d31a))
	{
		level.var_d811d31a clientfield::set("postfx_hitzone", 0);
		waitframe(1);
		level.var_d811d31a function_f9ed304d();
		level.var_d811d31a = undefined;
	}
}

/*
	Name: function_2cc00dba
	Namespace: namespace_73e1c3e3
	Checksum: 0x8344C9CB
	Offset: 0x78A8
	Size: 0x264
	Parameters: 1
	Flags: None
*/
function function_2cc00dba(var_14fe1698)
{
	var_3f21ce47 = namespace_64a487a9::function_fbe3dcbb();
	a_locs = struct::get_array(var_14fe1698, "targetname");
	a_locs = array::randomize(a_locs);
	s_spawn_loc = undefined;
	foreach(s_loc in a_locs)
	{
		foreach(bot in var_3f21ce47)
		{
			n_dist = distance(s_loc.origin, bot.origin);
			if(n_dist < 500)
			{
				break;
			}
			v_dir = anglestoforward(s_loc.angles) * -1;
			var_44aeda1d = s_loc.origin + v_dir * 250;
			n_dist = distance(var_44aeda1d, bot.origin);
			if(n_dist < 500)
			{
				break;
			}
			s_spawn_loc = s_loc;
			break;
		}
		if(isdefined(s_spawn_loc))
		{
			break;
		}
	}
	if(!isdefined(s_spawn_loc))
	{
		s_spawn_loc = a_locs[0];
	}
	self setorigin(s_spawn_loc.origin);
	self setplayerangles(s_spawn_loc.angles);
}

/*
	Name: can_see
	Namespace: namespace_73e1c3e3
	Checksum: 0x66442E48
	Offset: 0x7B18
	Size: 0x106
	Parameters: 2
	Flags: None
*/
function can_see(v_pos, var_7b20e52b)
{
	v_forward = anglestoforward(self.angles);
	v_dir = vectornormalize(v_pos - self.origin);
	dp = vectordot(v_forward, v_dir);
	if(dp > 0.7)
	{
		if(isdefined(var_7b20e52b) && var_7b20e52b)
		{
			trace = bullettrace(self.origin + vectorscale((0, 0, 1), 40), v_pos, 0, undefined);
			if(trace[#"fraction"] < 1)
			{
				return 0;
			}
		}
		return 1;
	}
	return 0;
}

/*
	Name: function_b733ae0d
	Namespace: namespace_73e1c3e3
	Checksum: 0x24F1351E
	Offset: 0x7C28
	Size: 0xEE
	Parameters: 3
	Flags: None
*/
function function_b733ae0d(b_on = 1, var_b5d05353 = 0, var_967db01d = 0)
{
	self endon_callback(&function_a412a7d5, #"death", #"hash_142d4e17637a0c6a");
	if(b_on)
	{
		self val::set(#"hash_57e24fab2f40e24", "ignoreall", 1);
		self setlowready(1);
	}
	else
	{
		self setlowready(0);
		self notify(#"hash_47e34f9d2b99e35b");
	}
}

/*
	Name: function_a412a7d5
	Namespace: namespace_73e1c3e3
	Checksum: 0x843F68AC
	Offset: 0x7D20
	Size: 0x64
	Parameters: 1
	Flags: None
*/
function function_a412a7d5(var_5a5260d8)
{
	self val::reset(#"hash_57e24fab2f40e24", "ignoreall");
	self setlowready(0);
	self scene::stop();
}

/*
	Name: function_4660a5e9
	Namespace: namespace_73e1c3e3
	Checksum: 0xBF479978
	Offset: 0x7D90
	Size: 0x184
	Parameters: 0
	Flags: None
*/
function function_4660a5e9()
{
	level endon(#"combattraining_logic_finished");
	self endon_callback(&function_bcc0f2a2, #"death");
	while(self.health > 25)
	{
		self thread scene::play("scene_rifle_m_stand_idle_lowready", self);
		var_385703b7 = undefined;
		var_385703b7 = self waittill(#"damage");
		var_5fad16b2 = var_385703b7.weapon;
		e_attacker = var_385703b7.attacker;
		if(isalive(self))
		{
			self scene::stop("scene_rifle_m_stand_idle_lowready");
			self setgoal(self.origin, 1, 1);
			wait(1);
		}
	}
	if(isdefined(var_5fad16b2) && isalive(e_attacker))
	{
		self dodamage(self.health + 666, self.origin, e_attacker, e_attacker, 0, "MOD_BURNED", 1, var_5fad16b2);
	}
}

/*
	Name: function_bcc0f2a2
	Namespace: namespace_73e1c3e3
	Checksum: 0xE9D3474F
	Offset: 0x7F20
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function function_bcc0f2a2(var_5a5260d8)
{
	self scene::stop("scene_rifle_m_stand_idle_lowready");
}

/*
	Name: function_58bc60d5
	Namespace: namespace_73e1c3e3
	Checksum: 0xE25FF777
	Offset: 0x7F58
	Size: 0x76
	Parameters: 0
	Flags: None
*/
function function_58bc60d5()
{
	level endon(#"combattraining_logic_finished");
	self endon(#"death", #"hash_2f17e3b45d334fa4");
	while(true)
	{
		self setgoal(self.origin, 1, 1);
		waitframe(1);
	}
}

/*
	Name: function_5b59f3b7
	Namespace: namespace_73e1c3e3
	Checksum: 0x4FF3F6EE
	Offset: 0x7FD8
	Size: 0x144
	Parameters: 6
	Flags: None
*/
function function_5b59f3b7(var_9a79d89d, var_5ab7c19c, var_bab91f2, var_4c7240f1 = 1, var_b1fd680c = 0, var_b4bf5d7d = 1)
{
	self.var_ef59b90 = 4;
	self.var_bab91f2 = var_bab91f2;
	self.var_4c7240f1 = var_4c7240f1;
	self.var_1574ae06 = var_b1fd680c;
	self.var_59860ee1 = 1500;
	self.var_dd940df3 = 3000;
	self.var_9a79d89d = var_9a79d89d;
	self.var_5ab7c19c = var_5ab7c19c;
	self.var_daa4b90a = 1;
	self.var_fc5b0b7f = 4;
	if(isdefined(var_b4bf5d7d) && var_b4bf5d7d)
	{
		self notify(#"hash_795f82c293077362");
		self.navmeshpoint = undefined;
		self.var_86ba7e6d = 0;
		self thread function_22af9bfc();
		self thread function_34f0dd27();
	}
}

/*
	Name: function_9fe3c3f4
	Namespace: namespace_73e1c3e3
	Checksum: 0x506A41EA
	Offset: 0x8128
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function function_9fe3c3f4()
{
	self notify(#"hash_53dc7cff4c3c5f5c");
	self notify(#"hash_140ce23fccc7b0c");
	self.var_1574ae06 = 1;
}

/*
	Name: function_78545a05
	Namespace: namespace_73e1c3e3
	Checksum: 0x58B44F33
	Offset: 0x8168
	Size: 0x8C
	Parameters: 1
	Flags: None
*/
function function_78545a05(n_wait)
{
	self endon(#"death");
	self notify(#"hash_53dc7cff4c3c5f5c");
	self notify(#"hash_140ce23fccc7b0c");
	self.var_1574ae06 = 1;
	wait(n_wait);
	self.var_1574ae06 = 0;
	self thread function_22af9bfc();
	self thread function_34f0dd27();
}

/*
	Name: function_22af9bfc
	Namespace: namespace_73e1c3e3
	Checksum: 0x383538BF
	Offset: 0x8200
	Size: 0xB4
	Parameters: 0
	Flags: None
*/
function function_22af9bfc()
{
	self endon(#"death");
	self notify(#"hash_53dc7cff4c3c5f5c");
	self endon(#"hash_53dc7cff4c3c5f5c");
	while(true)
	{
		if(isdefined(level.var_67dc9530) && level.var_67dc9530)
		{
			self.var_1574ae06 = 1;
		}
		else if(self.var_bab91f2 <= 50)
		{
			self.var_1574ae06 = 1;
		}
		else
		{
			self.var_1574ae06 = 0;
		}
		waitframe(1);
	}
}

/*
	Name: function_34f0dd27
	Namespace: namespace_73e1c3e3
	Checksum: 0x2648DCD7
	Offset: 0x82C0
	Size: 0x96
	Parameters: 0
	Flags: None
*/
function function_34f0dd27()
{
	self endon(#"death");
	self notify(#"hash_140ce23fccc7b0c");
	self endon(#"hash_140ce23fccc7b0c");
	while(true)
	{
		wait(randomfloatrange(2, 5));
		self.var_daa4b90a = randomfloatrange(1, 3);
	}
}

/*
	Name: function_b05a86bc
	Namespace: namespace_73e1c3e3
	Checksum: 0xC38F597C
	Offset: 0x8360
	Size: 0x11A
	Parameters: 3
	Flags: None
*/
function function_b05a86bc(str_team, n_radius, var_b1fd680c)
{
	var_3f21ce47 = namespace_64a487a9::function_fbe3dcbb();
	foreach(bot in var_3f21ce47)
	{
		if(bot.team == str_team)
		{
			bot.var_bab91f2 = n_radius;
			bot.var_1574ae06 = var_b1fd680c;
			bot.var_59860ee1 = 1500;
			bot.var_dd940df3 = 3500;
			bot.var_daa4b90a = 1.5;
			bot.var_4c7240f1 = 1;
			bot.var_fc5b0b7f = 4;
		}
	}
}

/*
	Name: function_32e977f
	Namespace: namespace_73e1c3e3
	Checksum: 0x53BD6801
	Offset: 0x8488
	Size: 0x9C
	Parameters: 2
	Flags: None
*/
function function_32e977f(e_target, n_range)
{
	self endon(#"death");
	e_target endon(#"death");
	while(distancesquared(self.origin, e_target.origin) > n_range_sq)
	{
		waitframe(1);
	}
	self function_4caeacf6();
}

/*
	Name: function_4caeacf6
	Namespace: namespace_73e1c3e3
	Checksum: 0x7EB8A091
	Offset: 0x8530
	Size: 0x1A
	Parameters: 0
	Flags: None
*/
function function_4caeacf6()
{
	self.var_4c7240f1 = 0;
	self.var_ef59b90 = 3;
}

/*
	Name: function_b5e31ad
	Namespace: namespace_73e1c3e3
	Checksum: 0xCE2DC408
	Offset: 0x8558
	Size: 0x198
	Parameters: 3
	Flags: None
*/
function function_b5e31ad(e_target, n_min, n_max)
{
	self endon(#"death");
	e_target endon(#"death");
	while(true)
	{
		n_range = randomintrange(n_min, n_max);
		v_to_player = e_target.origin - self.origin;
		v_angles = vectortoangles(v_to_player);
		self thread function_5b59f3b7(e_target.origin, v_angles, n_range, 0);
		while(distance(self.origin, e_target.origin) > n_range)
		{
			waitframe(1);
		}
		if(math::cointoss())
		{
			self namespace_9c817acd::crouch();
		}
		self thread function_a7a72476();
		n_wait = randomfloatrange(2, 4);
		wait(n_wait);
		self namespace_9c817acd::stand();
	}
}

/*
	Name: function_1746776e
	Namespace: namespace_73e1c3e3
	Checksum: 0xC33F42C0
	Offset: 0x86F8
	Size: 0x74
	Parameters: 0
	Flags: None
*/
function function_1746776e()
{
	self endon(#"death");
	e_player = get_player();
	self.var_38b6161f = 1;
	while(true)
	{
		self.var_2925fedc = e_player.origin;
		waitframe(1);
	}
}

/*
	Name: function_1db91571
	Namespace: namespace_73e1c3e3
	Checksum: 0xD01A646E
	Offset: 0x8778
	Size: 0x14E
	Parameters: 0
	Flags: None
*/
function function_1db91571()
{
	while(true)
	{
		if(level flag::get("mission_success") || level flag::get("mission_failed"))
		{
			break;
		}
		var_881a9f68 = gettime();
		waitframe(1);
		n_time_ms = gettime();
		if(isdefined(level.var_cbcb0078) && level.var_cbcb0078)
		{
			var_79b7845d = function_4c27be22("A");
			setbombtimer("A", var_79b7845d + n_time_ms - var_881a9f68);
		}
		else
		{
			var_f08fde43 = function_4c27be22("A");
			currenttime = gettime();
			if(currenttime > var_f08fde43)
			{
				level flag::set("times_up");
				level.var_cbcb0078 = 1;
			}
		}
	}
}

/*
	Name: function_e768df25
	Namespace: namespace_73e1c3e3
	Checksum: 0x936AFBBA
	Offset: 0x88D0
	Size: 0xD2
	Parameters: 2
	Flags: None
*/
function function_e768df25(v_target, var_368c41b6)
{
	e_player = self;
	n_dist = distance(e_player.origin, v_target);
	if(n_dist <= var_368c41b6 - 10)
	{
		if(isdefined(level.var_29a4ccd4))
		{
			dz = abs(e_player.origin[2] - v_target[2]);
			if(dz <= level.var_29a4ccd4)
			{
				return 1;
			}
		}
		else
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_d25bd3c9
	Namespace: namespace_73e1c3e3
	Checksum: 0x7DDB5908
	Offset: 0x89B0
	Size: 0x140
	Parameters: 3
	Flags: None
*/
function function_d25bd3c9(v_target, var_368c41b6, var_7f71c337)
{
	level endon(#"combattraining_logic_finished", #"hash_360fb35e8476aec5");
	if(isdefined(level.var_5cb850c9))
	{
		var_368c41b6 = level.var_5cb850c9;
	}
	while(true)
	{
		e_player = get_player();
		if(isalive(e_player))
		{
			if(e_player function_e768df25(v_target, var_368c41b6) && !e_player isgrappling())
			{
				break;
			}
		}
		waitframe(1);
	}
	if(isdefined(var_7f71c337) && var_7f71c337)
	{
		e_player = get_player();
		e_player thread function_b375ee89(undefined, v_target, 0);
	}
	e_player notify(#"hash_8fb409411eae1b0");
}

/*
	Name: function_9f8be64a
	Namespace: namespace_73e1c3e3
	Checksum: 0x3B7E4984
	Offset: 0x8AF8
	Size: 0x13C
	Parameters: 0
	Flags: None
*/
function function_9f8be64a()
{
	e_player = get_player();
	e_player thread function_61c3d59c((function_8b1a219a() ? #"hash_2599a874a6af5e44" : #"hash_1f9e1f03abf80100"), undefined);
	e_player thread function_84181d75(1, e_player.origin);
	while(!e_player primarybuttonpressedlocal())
	{
		waitframe(1);
	}
	e_player thread function_a7d0e0f3();
	e_player thread function_1bb93418();
	e_player thread function_84181d75(0, e_player.origin);
	if(!util::function_8570168d())
	{
		function_c1699637();
	}
	else
	{
		function_9a022fbc("open");
	}
}

/*
	Name: function_9a022fbc
	Namespace: namespace_73e1c3e3
	Checksum: 0x2AF6D9F8
	Offset: 0x8C40
	Size: 0xFC
	Parameters: 1
	Flags: None
*/
function function_9a022fbc(str_state)
{
	player = getplayers()[0];
	lui_menu = lui::function_e810a527("FullScreenBlack");
	if(str_state == "open")
	{
		if(isdefined(lui_menu))
		{
			[[ lui_menu ]]->open(player);
			[[ lui_menu ]]->function_9cd54463(player, 1);
			[[ lui_menu ]]->function_331f9dd(player, 1);
			[[ lui_menu ]]->function_237ff433(player, int(2000));
		}
	}
	else if(isdefined(lui_menu))
	{
		[[ lui_menu ]]->close(player);
	}
}

/*
	Name: function_84181d75
	Namespace: namespace_73e1c3e3
	Checksum: 0x28FE29A0
	Offset: 0x8D48
	Size: 0xBE
	Parameters: 3
	Flags: None
*/
function function_84181d75(var_ccc9bda1, v_loc, var_b5023654)
{
	self endon_callback(&function_88c18aba, #"death");
	if(isdefined(var_ccc9bda1) && var_ccc9bda1)
	{
		self val::set(#"hash_5d3a6408f6507701", "freezecontrols", 1);
	}
	else
	{
		self val::reset(#"hash_5d3a6408f6507701", "freezecontrols");
		self notify(#"hash_38fed7706d29d264");
	}
}

/*
	Name: function_717d76f
	Namespace: namespace_73e1c3e3
	Checksum: 0x9806A23E
	Offset: 0x8E10
	Size: 0x78
	Parameters: 0
	Flags: None
*/
function function_717d76f()
{
	self endon(#"death", #"hash_38fed7706d29d264");
	while(true)
	{
		v_player_angles = self getplayerangles();
		self.var_3c8457d2.angles = (0, v_player_angles[1], 0);
		waitframe(1);
	}
}

/*
	Name: function_88c18aba
	Namespace: namespace_73e1c3e3
	Checksum: 0xD47712A9
	Offset: 0x8E90
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function function_88c18aba(var_5a5260d8)
{
	self unlink();
}

/*
	Name: function_93c86846
	Namespace: namespace_73e1c3e3
	Checksum: 0x7305BB7B
	Offset: 0x8EC0
	Size: 0x84
	Parameters: 6
	Flags: None
*/
function function_93c86846(var_3608d414, var_8a30c2bf, var_aa62f5bf, var_41bc026a, var_cf0cbd73, var_9c8d914)
{
	if(isdefined(var_3608d414))
	{
		level thread namespace_8c007aa6::function_831e0584(var_3608d414, 1);
	}
	function_e0d36a2c(undefined, var_8a30c2bf, var_aa62f5bf, var_41bc026a, var_cf0cbd73, var_9c8d914);
}

/*
	Name: function_e0d36a2c
	Namespace: namespace_73e1c3e3
	Checksum: 0x8FAF3AD4
	Offset: 0x8F50
	Size: 0x3FA
	Parameters: 6
	Flags: None
*/
function function_e0d36a2c(str_vo, var_8a30c2bf, var_aa62f5bf, var_41bc026a, var_cf0cbd73, var_9c8d914)
{
	e_player = get_player();
	e_player thread function_84181d75(0, undefined, undefined);
	if(isdefined(level.var_3e67eeea))
	{
		e_player thread function_61c3d59c(level.var_3e67eeea, undefined);
		level.var_3e67eeea = undefined;
	}
	else
	{
		e_player thread function_61c3d59c(#"hash_75a61367f89fc81a", undefined);
	}
	if(isdefined(str_vo))
	{
		e_player thread function_329f9ba6(str_vo, 5, "green", 2);
	}
	s_loc = struct::get(var_8a30c2bf, "targetname");
	waypoint = create_waypoint(#"hash_1f1deaa6bff12db8", s_loc.origin, s_loc.angles, #"any", undefined, var_9c8d914, s_loc.target);
	if(isdefined(s_loc.script_noteworthy) && s_loc.script_noteworthy == #"glow")
	{
		fwd = (0, 0, 1);
		right = (0, -1, 0);
		level.var_32ff41f7 = spawnfx("ui/fx8_ui_ct_marker_team_b90_yllw", s_loc.origin, fwd, right);
		wait(0.1);
		triggerfx(level.var_32ff41f7);
	}
	else
	{
		level.var_32ff41f7 = undefined;
	}
	trace = bullettrace(s_loc.origin, s_loc.origin + vectorscale((0, 0, -1), 500), 0, e_player);
	v_ground_pos = trace[#"position"];
	level.var_e72728b8 = var_aa62f5bf;
	if(isdefined(level.var_c06def85))
	{
		var_368c41b6 = level.var_c06def85;
	}
	else
	{
		var_368c41b6 = 60;
	}
	function_d25bd3c9(v_ground_pos, var_368c41b6, 0);
	if(isdefined(var_41bc026a) && var_41bc026a)
	{
		e_player = get_player();
		e_player thread function_b375ee89(undefined, v_ground_pos, 0);
	}
	waitframe(1);
	waypoint function_f9ed304d();
	function_c2a10fc();
	get_player() playsound(#"uin_objective_updated");
	if(isdefined(level.var_32ff41f7))
	{
		level.var_32ff41f7 delete();
	}
	waitframe(1);
	e_player playsound(#"uin_objective_updated");
	if(isdefined(var_cf0cbd73))
	{
		wait(var_cf0cbd73);
	}
}

/*
	Name: function_654280be
	Namespace: namespace_73e1c3e3
	Checksum: 0x7219B9A4
	Offset: 0x9358
	Size: 0x8E
	Parameters: 0
	Flags: None
*/
function function_654280be()
{
	level endon(#"combattraining_logic_finished");
	while(true)
	{
		var_3f21ce47 = e_player namespace_64a487a9::function_dde6edbd();
		if(var_3f21ce47.size == 0)
		{
			level notify(#"hash_342ec88b8ca82286");
			break;
		}
		waitframe(1);
	}
}

/*
	Name: function_fdfeb384
	Namespace: namespace_73e1c3e3
	Checksum: 0x8B88A72B
	Offset: 0x93F0
	Size: 0x74
	Parameters: 0
	Flags: None
*/
function function_fdfeb384()
{
	e_player = get_player();
	if(!e_player.hasspawned || !isalive(e_player) || !isdefined(e_player.var_560765bb))
	{
		e_player waittill(#"loadout_given");
	}
}

/*
	Name: function_300bb455
	Namespace: namespace_73e1c3e3
	Checksum: 0xCB68E129
	Offset: 0x9470
	Size: 0x98
	Parameters: 0
	Flags: None
*/
function function_300bb455()
{
	self endon(#"death");
	do
	{
		var_e2837c64 = self issliding();
		var_beb2bc56 = self is_jumping();
		var_65534973 = is_falling(self.origin);
		waitframe(1);
	}
	while(var_e2837c64 || var_beb2bc56 || var_65534973);
}

/*
	Name: is_jumping
	Namespace: namespace_73e1c3e3
	Checksum: 0x87B0067B
	Offset: 0x9510
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function is_jumping()
{
	ground_ent = self getgroundent();
	return !isdefined(ground_ent);
}

/*
	Name: function_56ae4d76
	Namespace: namespace_73e1c3e3
	Checksum: 0x9A7759E
	Offset: 0x9548
	Size: 0xAA
	Parameters: 2
	Flags: None
*/
function function_56ae4d76(old_position, new_position)
{
	size = 10;
	height = size * 2;
	mins = (-1 * size, -1 * size, 0);
	maxs = (size, size, height);
	trace = physicstrace(old_position, new_position, mins, maxs, self);
	return trace;
}

/*
	Name: function_b7f367ed
	Namespace: namespace_73e1c3e3
	Checksum: 0x5E844214
	Offset: 0x9600
	Size: 0x58
	Parameters: 2
	Flags: None
*/
function function_b7f367ed(old_position, new_position)
{
	trace = function_56ae4d76(old_position, new_position);
	if(trace[#"fraction"] < 1)
	{
		return 0;
	}
	return 1;
}

/*
	Name: is_falling
	Namespace: namespace_73e1c3e3
	Checksum: 0x1B6740E1
	Offset: 0x9660
	Size: 0x32
	Parameters: 1
	Flags: None
*/
function is_falling(position)
{
	return function_b7f367ed(position, position + vectorscale((0, 0, -1), 500));
}

/*
	Name: function_7a739ee3
	Namespace: namespace_73e1c3e3
	Checksum: 0x177BCCA7
	Offset: 0x96A0
	Size: 0x1EC
	Parameters: 2
	Flags: None
*/
function function_7a739ee3(var_c82bc161, var_17e78c4a = "mp_t8_spawn_point")
{
	e_player = get_player();
	e_player endon(#"death");
	a_e_enemies = e_player namespace_64a487a9::function_dde6edbd();
	var_476cdbd7 = spawning::get_spawnpoint_array(var_17e78c4a);
	if(isdefined(var_c82bc161))
	{
		foreach(var_7e5dc39d in var_c82bc161)
		{
			a_e_enemies[a_e_enemies.size] = var_7e5dc39d;
		}
	}
	if(a_e_enemies.size > 0)
	{
		var_30d6a1c5 = (0, 0, 0);
		foreach(e_enemy in a_e_enemies)
		{
			if(isdefined(e_enemy))
			{
				var_30d6a1c5 = var_30d6a1c5 + e_enemy.origin;
			}
		}
		var_30d6a1c5 = var_30d6a1c5 / a_e_enemies.size;
		v_spawnpt = arraygetfarthest(var_30d6a1c5, var_476cdbd7);
		e_player function_61d750d4(v_spawnpt);
	}
}

/*
	Name: function_61d750d4
	Namespace: namespace_73e1c3e3
	Checksum: 0xD0446EE3
	Offset: 0x9898
	Size: 0x21A
	Parameters: 2
	Flags: None
*/
function function_61d750d4(loc, v_angles)
{
	if(isstring(loc))
	{
		s_loc = struct::get(loc, "targetname");
		v_origin = s_loc.origin;
		if(!isdefined(v_angles))
		{
			v_angles = s_loc.angles;
		}
	}
	else if(isentity(loc) || isstruct(loc))
	{
		v_origin = loc.origin;
		if(!isdefined(v_angles))
		{
			v_angles = loc.angles;
		}
	}
	else if(isvec(loc))
	{
		v_origin = loc;
		if(!isdefined(v_angles))
		{
			v_angles = (0, 0, 0);
		}
	}
	e_player = getplayers()[0];
	if(isalive(e_player))
	{
		v_to_player = e_player.origin - v_origin;
		var_13bbc909 = vectortoangles(v_to_player);
		playfx("player/fx8_plyr_spawn_distortion", v_origin, anglestoforward(var_13bbc909), anglestoup(var_13bbc909));
		self setorigin(v_origin);
		self setplayerangles(v_angles);
		self playsound(#"hash_fc83e70c477029c");
	}
	waitframe(1);
}

/*
	Name: function_c7034b77
	Namespace: namespace_73e1c3e3
	Checksum: 0x35B00AC1
	Offset: 0x9AC0
	Size: 0x72
	Parameters: 1
	Flags: None
*/
function function_c7034b77(s_loc)
{
	v_origin = s_loc.origin;
	v_angles = s_loc.angles;
	playfx("player/fx8_plyr_spawn_distortion", v_origin, anglestoforward(v_angles));
	waitframe(1);
}

/*
	Name: function_96dda082
	Namespace: namespace_73e1c3e3
	Checksum: 0x8BF16B63
	Offset: 0x9B40
	Size: 0xB8
	Parameters: 2
	Flags: None
*/
function function_96dda082(n_time_min = 2, n_time_max = 4)
{
	self endon(#"death");
	while(true)
	{
		wait(randomintrange(n_time_min, n_time_max));
		if(randomint(100) > 50)
		{
			self namespace_9c817acd::crouch();
		}
		else
		{
			self namespace_9c817acd::stand();
		}
	}
}

/*
	Name: function_df8f80c4
	Namespace: namespace_73e1c3e3
	Checksum: 0xCD54FF8E
	Offset: 0x9C00
	Size: 0x148
	Parameters: 3
	Flags: None
*/
function function_df8f80c4(e_target, n_wait_min = 0.1, n_wait_max = 0.5)
{
	self endon(#"death", #"hash_624290b3f2248336");
	wpn_current = self getcurrentweapon();
	while(true)
	{
		if(isdefined(e_target))
		{
			var_add3ed29 = {#aimpoint:e_target.origin};
			self bot_action::aim_at_target(var_add3ed29);
		}
		self bottapbutton(0);
		wait(randomfloatrange(n_wait_min, n_wait_max));
		self setweaponammostock(wpn_current, var_2276fbea * 3);
	}
}

/*
	Name: function_49e0c5bc
	Namespace: namespace_73e1c3e3
	Checksum: 0xD206A0CA
	Offset: 0x9D50
	Size: 0x11C
	Parameters: 3
	Flags: None
*/
function function_49e0c5bc(var_a9a68bf = 0, var_aebae2c0, b_play_fx = 1)
{
	if(!(isdefined(var_a9a68bf) && var_a9a68bf))
	{
		var_1df95d6a = self namespace_64a487a9::function_dde6edbd();
	}
	else
	{
		var_1df95d6a = namespace_64a487a9::function_fbe3dcbb();
	}
	foreach(var_7fdf7b71 in var_1df95d6a)
	{
		var_7fdf7b71 thread function_3e0767e2(b_play_fx);
	}
	if(!isdefined(var_aebae2c0))
	{
		clearplayercorpses();
	}
}

/*
	Name: function_3e0767e2
	Namespace: namespace_73e1c3e3
	Checksum: 0xBAED26F1
	Offset: 0x9E78
	Size: 0x10C
	Parameters: 1
	Flags: None
*/
function function_3e0767e2(b_play_fx = 1)
{
	e_player = getplayers()[0];
	v_to_player = e_player.origin - self.origin;
	var_13bbc909 = vectortoangles(v_to_player);
	if(isdefined(b_play_fx) && b_play_fx)
	{
		playfx("player/fx8_plyr_spawn_distortion", self.origin, anglestoforward(var_13bbc909), anglestoup(var_13bbc909));
	}
	self setorigin(vectorscale((-1, -1, -1), 10000));
	self namespace_64a487a9::function_991ccf1a();
}

/*
	Name: function_b375ee89
	Namespace: namespace_73e1c3e3
	Checksum: 0x1321FB62
	Offset: 0x9F90
	Size: 0x53C
	Parameters: 3
	Flags: None
*/
function function_b375ee89(var_96065dae, var_8d3fbac4 = undefined, n_size = 0)
{
	if(isdefined(level.var_33bd6a8) && !isdefined(var_8d3fbac4) && isdefined(level.var_33bd6a8.var_96065dae) && level.var_33bd6a8.var_96065dae == var_96065dae)
	{
		level waittill(#"hash_4c9c5fbc89779e64");
		return;
	}
	if(isdefined(var_8d3fbac4))
	{
		var_f225da70 = var_8d3fbac4;
	}
	else
	{
		var_7b967c71 = struct::get(var_96065dae, "targetname");
		var_f225da70 = var_7b967c71.origin;
	}
	var_874f43c3 = spawn("trigger_radius_new", var_f225da70, 0, 60, 60);
	fwd = (0, 0, 1);
	right = (0, -1, 0);
	switch(n_size)
	{
		case 0:
		{
			level.var_87f7bbf = spawnfx("ui/fx8_ui_ct_marker_team_b90", var_874f43c3.origin, fwd, right);
			break;
		}
		case 1:
		{
			level.var_87f7bbf = spawnfx("ui/fx8_ui_ct_marker_team_b135", var_874f43c3.origin, fwd, right);
			break;
		}
		case 2:
		default:
		{
			level.var_87f7bbf = spawnfx("ui/fx8_ui_ct_marker_team_b180", var_874f43c3.origin, fwd, right);
			break;
		}
	}
	/#
		assert(!isdefined(level.var_33bd6a8));
	#/
	level.var_33bd6a8 = spawn("script_model", var_f225da70);
	level.var_33bd6a8.angles = (0, 0, 0);
	level.var_33bd6a8.var_96065dae = var_96065dae;
	switch(n_size)
	{
		case 0:
		{
			level.var_33bd6a8 setmodel(#"hash_413df540de077fc5");
			break;
		}
		case 1:
		{
			level.var_33bd6a8 setmodel(#"hash_413df540de077fc5");
			break;
		}
		case 2:
		{
			level.var_33bd6a8 setmodel(#"hash_1d86ea391eae27af");
			break;
		}
	}
	level.var_33bd6a8 ghost();
	level.var_33bd6a8 notsolid();
	level.var_33bd6a8 clientfield::set("collisionbox_render", 1);
	waitresult = undefined;
	waitresult = var_874f43c3 waittill(#"trigger");
	level.var_33bd6a8 solid();
	triggerfx(level.var_87f7bbf);
	e_player = getplayers()[0];
	e_player playsoundtoplayer(#"hash_4cc6bcab475eb688", e_player);
	level waittill(#"hash_4c9c5fbc89779e64");
	e_player = getplayers()[0];
	e_player playsoundtoplayer(#"hash_544d950a45d876e2", e_player);
	if(isdefined(level.var_33bd6a8))
	{
		level.var_33bd6a8 delete();
	}
	if(isdefined(level.var_87f7bbf))
	{
		level.var_87f7bbf delete();
	}
}

/*
	Name: function_6046a5e3
	Namespace: namespace_73e1c3e3
	Checksum: 0xB6106424
	Offset: 0xA4D8
	Size: 0x136
	Parameters: 2
	Flags: None
*/
function function_6046a5e3(str_weapon, attachments)
{
	setdvar(#"hash_4b0035c0038e0762", hash(str_weapon));
	var_c7239f6f = min((isdefined(attachments) ? attachments.size : 0), 6);
	for(i = 0; i < var_c7239f6f; i++)
	{
		setdvar(#"hash_721ee06404866532" + i, hash(attachments[i]));
	}
	while(i < 6)
	{
		setdvar(#"hash_721ee06404866532" + i, #"");
		i++;
	}
}

/*
	Name: function_c3e647e2
	Namespace: namespace_73e1c3e3
	Checksum: 0xDAC6CE17
	Offset: 0xA618
	Size: 0x136
	Parameters: 2
	Flags: None
*/
function function_c3e647e2(str_weapon, attachments)
{
	setdvar(#"hash_6dcfed2e90bdae6e", hash(str_weapon));
	var_c7239f6f = min((isdefined(attachments) ? attachments.size : 0), 6);
	for(i = 0; i < var_c7239f6f; i++)
	{
		setdvar(#"hash_c7f896e4dff882e" + i, hash(attachments[i]));
	}
	while(i < 6)
	{
		setdvar(#"hash_c7f896e4dff882e" + i, #"");
		i++;
	}
}

/*
	Name: function_84adcd1f
	Namespace: namespace_73e1c3e3
	Checksum: 0x643DEAC8
	Offset: 0xA758
	Size: 0x6A
	Parameters: 0
	Flags: None
*/
function function_84adcd1f()
{
	var_e6b5e0d7 = getdvar(#"hash_3fb2952874e511c2");
	var_f3e5b165 = getweapon((isdefined(var_e6b5e0d7) ? var_e6b5e0d7 : #"hash_286a30586a6aed12"));
	return var_f3e5b165;
}

/*
	Name: function_2daf1983
	Namespace: namespace_73e1c3e3
	Checksum: 0xE313618C
	Offset: 0xA7D0
	Size: 0x4C
	Parameters: 3
	Flags: None
*/
function function_2daf1983(str_weapon, b_immediate = 1, n_delay)
{
	wait(n_delay);
	give_weapon(str_weapon, b_immediate);
}

/*
	Name: give_weapon
	Namespace: namespace_73e1c3e3
	Checksum: 0x5B0917C7
	Offset: 0xA828
	Size: 0x15E
	Parameters: 3
	Flags: None
*/
function give_weapon(var_65ad93bb, b_immediate = 1, var_738b1542 = 0)
{
	if(isstring(var_65ad93bb) || function_7a600918(var_65ad93bb))
	{
		weapon = getweapon(var_65ad93bb);
	}
	else if(isweapon(var_65ad93bb))
	{
		weapon = var_65ad93bb;
	}
	self giveweapon(weapon);
	self givemaxammo(weapon);
	if(b_immediate)
	{
		self switchtoweaponimmediate(weapon);
	}
	else
	{
		self switchtoweapon(weapon);
	}
	self setspawnweapon(weapon);
	if(var_738b1542)
	{
		self takeweapon(function_84adcd1f());
	}
	level.var_41267e7d = undefined;
}

/*
	Name: function_e9ab1003
	Namespace: namespace_73e1c3e3
	Checksum: 0x4B60D8A5
	Offset: 0xA990
	Size: 0x10E
	Parameters: 1
	Flags: None
*/
function function_e9ab1003(var_5bdda9b3)
{
	e_player = get_player();
	if(!isdefined(e_player))
	{
		return;
	}
	var_20afd60d = 1;
	if(isdefined(var_5bdda9b3))
	{
		s_loc = struct::get(var_5bdda9b3, "targetname");
		if(isdefined(s_loc) && isdefined(s_loc.player_angles))
		{
			e_player.var_f2bdd0d8 = s_loc.origin;
			e_player.var_55ba89f7 = (s_loc.player_angles[0], s_loc.player_angles[1], 0);
			var_20afd60d = 0;
		}
	}
	if(var_20afd60d)
	{
		e_player.var_f2bdd0d8 = e_player.origin;
		e_player.var_55ba89f7 = e_player.angles;
	}
}

/*
	Name: function_79957328
	Namespace: namespace_73e1c3e3
	Checksum: 0xFA8BECBC
	Offset: 0xAAA8
	Size: 0x146
	Parameters: 2
	Flags: None
*/
function function_79957328(var_46fa8f90, var_5bdda9b3)
{
	level.var_43ac3b33 = 1;
	e_player = getplayers()[0];
	e_player val::set(#"fade", "freezecontrols");
	level lui::screen_fade_out(0.75);
	self notify(#"hash_6fb2ff47e3ed57eb");
	if(isdefined(var_46fa8f90))
	{
		wait(var_46fa8f90);
	}
	function_8f04870f(var_5bdda9b3);
	level notify(#"hash_603de7ab282bcda9");
	wait(0.75);
	level lui::screen_fade_in(0.75);
	self notify(#"hash_6ddc2eaf9b70e78c");
	e_player val::reset(#"fade", "freezecontrols");
	level.var_43ac3b33 = undefined;
}

/*
	Name: function_8f04870f
	Namespace: namespace_73e1c3e3
	Checksum: 0xF1D7D298
	Offset: 0xABF8
	Size: 0x12A
	Parameters: 1
	Flags: None
*/
function function_8f04870f(var_6988e659 = undefined)
{
	e_player = get_player();
	if(!isdefined(e_player))
	{
		return;
	}
	if(isdefined(var_6988e659))
	{
		s_loc = struct::get(var_6988e659, "targetname");
		e_player setorigin(s_loc.origin);
		e_player setplayerangles(s_loc.angles);
	}
	else if(isdefined(e_player.var_f2bdd0d8))
	{
		e_player setorigin(e_player.var_f2bdd0d8);
		e_player setplayerangles(e_player.var_55ba89f7);
	}
	e_player.health = 150;
	e_player.maxhealth = 150;
	e_player.var_66cb03ad = 150;
}

/*
	Name: function_15e01238
	Namespace: namespace_73e1c3e3
	Checksum: 0x90D5217A
	Offset: 0xAD30
	Size: 0x20E
	Parameters: 5
	Flags: None
*/
function function_15e01238(s_loc, n_max_dist, var_9c8d914, var_c9af632d, var_4df4f851)
{
	level thread function_c444a920(s_loc, var_9c8d914);
	function_821edb7e(undefined);
	if(isdefined(var_c9af632d))
	{
		foreach(str_notify in var_c9af632d)
		{
			level notify(str_notify);
		}
	}
	while(true)
	{
		level waittill(#"hash_48e959cf81e020f3");
		if(isdefined(level.var_8d109684) && level.var_8d109684)
		{
			level.var_8d109684 = undefined;
			break;
		}
		e_player = get_player();
		v_dir = anglestoforward(e_player.angles);
		v_loc = e_player.origin + v_dir * 100;
		n_dist = distance(v_loc, s_loc.origin);
		if(n_dist < n_max_dist)
		{
			b_success = 1;
			break;
		}
		else if(isdefined(var_4df4f851) && var_4df4f851)
		{
			break;
		}
	}
	level.var_20fb90aa = 1;
	return b_success;
}

/*
	Name: function_821edb7e
	Namespace: namespace_73e1c3e3
	Checksum: 0xC5624A1B
	Offset: 0xAF48
	Size: 0xAE
	Parameters: 1
	Flags: None
*/
function function_821edb7e(str_endon)
{
	if(isdefined(str_endon))
	{
		level endon(str_endon);
	}
	while(true)
	{
		e_player = get_player();
		if(e_player isgrappling())
		{
			level.var_7deb7684 = 1;
			break;
		}
		if(isdefined(level.var_8d109684) && level.var_8d109684)
		{
			break;
		}
		waitframe(1);
	}
}

/*
	Name: function_71a30a6e
	Namespace: namespace_73e1c3e3
	Checksum: 0xBF6C67BF
	Offset: 0xB000
	Size: 0x9C
	Parameters: 2
	Flags: None
*/
function function_71a30a6e(var_e3ab9b64, var_cf4097e6 = 1)
{
	e_player = get_player();
	if(isdefined(var_cf4097e6) && var_cf4097e6)
	{
		e_player potm::bookmark(var_e3ab9b64, gettime(), e_player);
	}
	level potm::function_b6a5e7fa();
	e_player potm::function_ede9fbc1();
}

/*
	Name: function_6ad0c151
	Namespace: namespace_73e1c3e3
	Checksum: 0x48F59D50
	Offset: 0xB0A8
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function function_6ad0c151()
{
	self namespace_64a487a9::function_26d45f32(1, 1, 1);
}

/*
	Name: function_6e8ebcb8
	Namespace: namespace_73e1c3e3
	Checksum: 0xEC800A2A
	Offset: 0xB0D8
	Size: 0x10C
	Parameters: 3
	Flags: None
*/
function function_6e8ebcb8(v_origin, v_normal, var_9c8d914)
{
	level endon(#"hash_22c18ee79baaf1a");
	level.var_a01c4e36.origin = v_origin;
	n_speed = -28;
	if(var_9c8d914 <= 30)
	{
		n_speed = -15;
	}
	level.var_a01c4e36.angles = (var_9c8d914, n_speed, 1);
	level.var_867e064b.origin = anglestoforward(v_normal);
	waitframe(1);
	waitframe(1);
	waitframe(1);
	waitframe(1);
	level.var_867e064b clientfield::set("highlight_sphere_normal", 1);
	waitframe(1);
	level.var_a01c4e36 clientfield::set("highlight_sphere", 1);
}

/*
	Name: function_47e517be
	Namespace: namespace_73e1c3e3
	Checksum: 0x6539C812
	Offset: 0xB1F0
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function function_47e517be()
{
	level.var_a01c4e36 clientfield::set("highlight_sphere", 0);
	level.var_867e064b clientfield::set("highlight_sphere_normal", 0);
}

/*
	Name: highlight_ring
	Namespace: namespace_73e1c3e3
	Checksum: 0xB1EEF8B3
	Offset: 0xB240
	Size: 0xA4
	Parameters: 3
	Flags: None
*/
function highlight_ring(b_on = 1, v_origin, v_normal)
{
	if(b_on)
	{
		level.var_96fe26de.origin = v_origin;
		level.var_96fe26de.angles = anglestoforward(v_normal) * -1;
	}
	waitframe(1);
	waitframe(1);
	waitframe(1);
	level.var_96fe26de clientfield::set("highlight_ring", b_on);
}

/*
	Name: function_eeb4cff6
	Namespace: namespace_73e1c3e3
	Checksum: 0x88E4E65A
	Offset: 0xB2F0
	Size: 0x170
	Parameters: 4
	Flags: None
*/
function function_eeb4cff6(var_9d4f2d1, var_f11dba7e, var_260aad25, var_3608d414)
{
	if(isdefined(var_9d4f2d1))
	{
		while(true)
		{
			e_player = get_player();
			n_dist = distance(e_player.origin, s_dest.origin);
			if(n_dist < var_f11dba7e)
			{
				break;
			}
			waitframe(1);
		}
	}
	level.var_7b46025 = struct::get_array(var_260aad25, "targetname");
	level.var_47cd3e56 = 0;
	level thread namespace_64a487a9::function_4d9cfd95(level.var_7b46025.size, #"axis");
	if(isdefined(var_3608d414))
	{
		level thread namespace_8c007aa6::function_831e0584(var_3608d414, 0);
	}
	wait(0.1);
	level notify(#"hash_5692c8f5563845e8");
}

/*
	Name: function_401b3a93
	Namespace: namespace_73e1c3e3
	Checksum: 0xF270F47
	Offset: 0xB468
	Size: 0xA4
	Parameters: 2
	Flags: None
*/
function function_401b3a93(var_260aad25, var_264ee2f5)
{
	level.var_7b46025 = struct::get_array(var_260aad25, "targetname");
	level.var_47cd3e56 = 0;
	for(i = 0; i < level.var_7b46025.size; i++)
	{
		level thread namespace_64a487a9::function_4d9cfd95(1, #"axis");
		wait(var_264ee2f5);
	}
}

/*
	Name: function_d3fd7ef7
	Namespace: namespace_73e1c3e3
	Checksum: 0x187868DA
	Offset: 0xB518
	Size: 0x182
	Parameters: 0
	Flags: None
*/
function function_d3fd7ef7()
{
	level notify(#"hash_549dee6330a31230");
	waitframe(1);
	level endon(#"combattraining_logic_finished", #"hash_549dee6330a31230");
	var_e870c98e = "warnHeal";
	if(!function_7d281f19(var_e870c98e))
	{
		while(true)
		{
			var_2a0a2872 = 0;
			do
			{
				self waittill(#"damage");
				if(isalive(self) && self.health <= n_health_threshold && !self isplayerswimming())
				{
					self thread function_5dec7b34(var_e870c98e);
					function_30e324a1(var_e870c98e);
					var_2a0a2872 = 1;
				}
				waitframe(1);
			}
			while(!var_2a0a2872);
			while(isalive(self) && self.health < n_health_threshold)
			{
				waitframe(1);
			}
			self notify(#"hash_5cf057e0a1d4eb77");
		}
	}
}

/*
	Name: function_7d281f19
	Namespace: namespace_73e1c3e3
	Checksum: 0x14D8B633
	Offset: 0xB6A8
	Size: 0x60
	Parameters: 1
	Flags: None
*/
function function_7d281f19(var_47b0bbb6)
{
	return isdefined(level.var_4651eae8) && (isdefined(level.var_4651eae8[hash(var_47b0bbb6)]) && level.var_4651eae8[hash(var_47b0bbb6)]);
}

/*
	Name: function_30e324a1
	Namespace: namespace_73e1c3e3
	Checksum: 0x9DECFF94
	Offset: 0xB710
	Size: 0x32
	Parameters: 1
	Flags: None
*/
function function_30e324a1(var_47b0bbb6)
{
	level.var_4651eae8[hash(var_47b0bbb6)] = 1;
}

/*
	Name: function_e96cc63f
	Namespace: namespace_73e1c3e3
	Checksum: 0x42FFEE78
	Offset: 0xB750
	Size: 0x3C6
	Parameters: 7
	Flags: None
*/
function function_e96cc63f(n_count = 3, var_d7172908, var_810b40e6 = 1, var_4837ee77 = 1, var_32df2a60 = 1, b_randomize = 0, str_targetname = "fillspawn_enemies")
{
	level endon(#"combattraining_logic_finished", #"hash_3ce5abc259d8b041");
	e_player = getplayers()[0];
	e_player endon(#"death");
	if(!isdefined(level.var_b6e6a025))
	{
		level.var_b6e6a025 = [];
	}
	level.var_b6e6a025[str_targetname] = 0;
	if(!isdefined(level.var_a76a5221))
	{
		level.var_a76a5221 = [];
	}
	if(isarray(var_d7172908))
	{
		a_s_targets = [];
		var_cf985323 = var_d7172908;
		foreach(var_17e78c4a in var_cf985323)
		{
			var_e47f1087 = struct::get_array(var_17e78c4a, "targetname");
			a_s_targets = arraycombine(a_s_targets, var_e47f1087, 0, 0);
		}
	}
	else
	{
		a_s_targets = struct::get_array(var_d7172908, "targetname");
	}
	if(isdefined(b_randomize) && b_randomize)
	{
		a_s_targets = array::randomize(a_s_targets);
	}
	while(true)
	{
		a_enemies = function_3dd59a93(str_targetname);
		var_d24d310 = 0;
		wait(var_4837ee77);
		while(a_enemies.size < n_count)
		{
			n_to_spawn = n_count - a_enemies.size;
			if(n_to_spawn > var_810b40e6)
			{
				n_to_spawn = var_810b40e6;
			}
			namespace_64a487a9::function_4d9cfd95(n_to_spawn, #"axis", str_targetname);
			var_d24d310 = var_d24d310 + n_to_spawn;
			/#
				var_1411e20e = e_player namespace_64a487a9::function_dde6edbd();
			#/
			wait(var_4837ee77);
			a_enemies = function_3dd59a93(str_targetname);
		}
		if(b_randomize && var_d24d310 >= n_count)
		{
			level.var_a76a5221[str_targetname] = array::randomize(level.var_a76a5221[str_targetname]);
			var_d24d310 = 0;
		}
		wait(var_32df2a60);
	}
}

/*
	Name: function_bc5adb93
	Namespace: namespace_73e1c3e3
	Checksum: 0x286B8D5A
	Offset: 0xBB20
	Size: 0x1A6
	Parameters: 7
	Flags: None
*/
function function_bc5adb93(n_spawn_count, n_dist_min = 800, n_dist_max = 1600, var_65c9209b = 1, var_e01def33 = 4, var_5e5dc085, str_targetname = "bot_surround_spawn")
{
	level endon(#"combattraining_logic_finished", #"hash_1c966d2b46abb009");
	self endon(#"death");
	while(true)
	{
		a_enemies = function_3dd59a93(str_targetname);
		n_to_spawn = n_spawn_count - a_enemies.size;
		if(n_to_spawn > 0)
		{
			level.var_e4db2e78 = self function_c655d719(n_dist_min, n_dist_max, var_5e5dc085);
			waitframe(1);
			if(level.var_e4db2e78.size > 0)
			{
				for(i = 0; i < n_to_spawn; i++)
				{
					namespace_64a487a9::function_4d9cfd95(1, #"axis", str_targetname);
					wait(var_65c9209b);
				}
			}
		}
		wait(var_e01def33);
	}
}

/*
	Name: function_c655d719
	Namespace: namespace_73e1c3e3
	Checksum: 0x6023CE2B
	Offset: 0xBCD0
	Size: 0x176
	Parameters: 3
	Flags: None
*/
function function_c655d719(n_dist_min = 800, n_dist_max = 1600, var_5e5dc085)
{
	if(!isdefined(var_5e5dc085))
	{
		var_476cdbd7 = spawning::get_spawnpoint_array("mp_t8_spawn_point");
	}
	else
	{
		var_476cdbd7 = struct::get_array(var_5e5dc085);
	}
	var_b4595860 = n_dist_min * n_dist_min;
	var_b8f62dbd = n_dist_max * n_dist_max;
	var_37fa3d92 = [];
	foreach(var_7b9b45ce in var_476cdbd7)
	{
		n_dist_sq = distancesquared(self.origin, var_7b9b45ce.origin);
		if(var_b4595860 <= n_dist_sq && n_dist_sq <= var_b8f62dbd)
		{
			var_37fa3d92[var_37fa3d92.size] = var_7b9b45ce;
		}
	}
	return var_37fa3d92;
}

/*
	Name: function_3dd59a93
	Namespace: namespace_73e1c3e3
	Checksum: 0x7FA4F7AA
	Offset: 0xBE50
	Size: 0xBE
	Parameters: 1
	Flags: None
*/
function function_3dd59a93(str_targetname)
{
	var_ca902c80 = namespace_64a487a9::function_fbe3dcbb();
	var_1df95d6a = [];
	foreach(var_f2703a3 in var_ca902c80)
	{
		if(var_f2703a3.targetname === str_targetname)
		{
			var_1df95d6a[var_1df95d6a.size] = var_f2703a3;
		}
	}
	return var_1df95d6a;
}

/*
	Name: function_ffb2833a
	Namespace: namespace_73e1c3e3
	Checksum: 0x3214C419
	Offset: 0xBF18
	Size: 0x110
	Parameters: 0
	Flags: None
*/
function function_ffb2833a()
{
	level.var_7303556f = "ct_oob_" + level.var_820c5561;
	var_e2a6292f = getentarray(level.var_7303556f, "script_noteworthy");
	if(var_e2a6292f.size > 0)
	{
		foreach(var_247c990 in var_e2a6292f)
		{
			if(!(isdefined(var_247c990.var_c037e962) && var_247c990.var_c037e962))
			{
				var_247c990.var_c037e962 = 1;
				var_247c990 triggerenable(0);
				var_247c990 thread oob::run_oob_trigger();
			}
		}
	}
}

/*
	Name: function_75d180e0
	Namespace: namespace_73e1c3e3
	Checksum: 0x51550D95
	Offset: 0xC030
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function function_75d180e0(b_enable = 1)
{
	function_b061b486(level.var_7303556f, "script_noteworthy", b_enable);
}

/*
	Name: function_1a477dd
	Namespace: namespace_73e1c3e3
	Checksum: 0x4664C587
	Offset: 0xC078
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function function_1a477dd()
{
	function_51d33352(level.var_7303556f, "script_noteworthy");
}

/*
	Name: function_b061b486
	Namespace: namespace_73e1c3e3
	Checksum: 0xBC920677
	Offset: 0xC0A8
	Size: 0xD8
	Parameters: 3
	Flags: None
*/
function function_b061b486(str_id, str_key = "targetname", b_enable = 1)
{
	var_e2a6292f = getentarray(str_id, str_key);
	foreach(var_247c990 in var_e2a6292f)
	{
		var_247c990 triggerenable(b_enable);
	}
}

/*
	Name: function_51d33352
	Namespace: namespace_73e1c3e3
	Checksum: 0x28B935EB
	Offset: 0xC188
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function function_51d33352(str_id, str_key = "targetname")
{
	function_b061b486(str_id, str_key, 0);
}

/*
	Name: function_d00e0eeb
	Namespace: namespace_73e1c3e3
	Checksum: 0x74AFCDB2
	Offset: 0xC1D8
	Size: 0xA4
	Parameters: 1
	Flags: None
*/
function function_d00e0eeb(n_left = 0)
{
	level endon(#"combattraining_logic_finished", #"hash_6ebe7e4ea0726f0b");
	while(true)
	{
		var_3f21ce47 = e_player namespace_64a487a9::function_dde6edbd();
		if(var_3f21ce47.size <= n_left)
		{
			break;
		}
		waitframe(1);
	}
}

/*
	Name: kill_bots
	Namespace: namespace_73e1c3e3
	Checksum: 0xED38FC49
	Offset: 0xC288
	Size: 0x272
	Parameters: 2
	Flags: None
*/
function kill_bots(str_team, var_4e15a2e9)
{
	var_fdd0b018 = namespace_64a487a9::function_fbe3dcbb();
	var_3f21ce47 = [];
	foreach(bot in var_fdd0b018)
	{
		if(bot.team == str_team)
		{
			var_3f21ce47[var_3f21ce47.size] = bot;
		}
	}
	while(var_4e15a2e9)
	{
		foreach(bot in var_3f21ce47)
		{
			if(!e_player can_see(bot.origin, 0))
			{
				bot dodamage(bot.health + 100, bot.origin);
				var_4e15a2e9--;
				if(var_4e15a2e9 == 0)
				{
					break;
				}
			}
		}
		waitframe(1);
		if(var_4e15a2e9)
		{
			foreach(bot in var_3f21ce47)
			{
				if(bot.health > 0)
				{
					bot dodamage(bot.health + 100, bot.origin);
					var_4e15a2e9--;
					if(var_4e15a2e9 == 0)
					{
						break;
					}
				}
			}
		}
	}
}

/*
	Name: function_6b5781eb
	Namespace: namespace_73e1c3e3
	Checksum: 0xB1EC6A5
	Offset: 0xC508
	Size: 0xF6
	Parameters: 0
	Flags: None
*/
function function_6b5781eb()
{
	self endon(#"death");
	level endon(#"hash_6d34a5dd0e177bb8");
	while(true)
	{
		e_player = get_player();
		n_dist = distance(e_player.origin, self.origin);
		if(n_dist > 250)
		{
			self thread function_5b59f3b7(e_player.origin, e_player.angles, 250);
		}
		else
		{
			self thread function_5b59f3b7(self.origin, self.angles, 32);
		}
		waitframe(1);
	}
}

/*
	Name: function_c008bffa
	Namespace: namespace_73e1c3e3
	Checksum: 0x74ECE047
	Offset: 0xC608
	Size: 0x134
	Parameters: 1
	Flags: None
*/
function function_c008bffa(var_f58e81b8)
{
	self endon(#"death");
	wait(1);
	while(true)
	{
		e_player = get_player();
		n_dist = distance(e_player.origin, self.origin);
		if(n_dist < var_f58e81b8)
		{
			break;
		}
		if(self can_see(e_player.origin, 1))
		{
			break;
		}
		if(n_start_health != self.health)
		{
			break;
		}
		wait(randomfloatrange(0.1, 0.3));
	}
	self thread function_5b59f3b7(self.origin, self.angles, 700);
}

/*
	Name: function_d3bbbf8a
	Namespace: namespace_73e1c3e3
	Checksum: 0xB5B84E59
	Offset: 0xC748
	Size: 0x224
	Parameters: 5
	Flags: None
*/
function function_d3bbbf8a(var_996160bc, var_308676f8, var_9c8d914, var_c9269d20, var_6e135d55)
{
	s_loc = struct::get(var_996160bc, "targetname");
	waypoint = create_waypoint(#"hash_43f27b76957da4d2", s_loc.origin, s_loc.angles, #"any", undefined, var_9c8d914, undefined);
	level.var_e72728b8 = var_c9269d20;
	level.var_1bf21bf2 = undefined;
	while(true)
	{
		if(isdefined(level.var_1bf21bf2))
		{
			n_dist = distance(level.var_1bf21bf2.origin, s_loc.origin);
			if(n_dist < 100)
			{
				break;
			}
			else if(!namespace_8c007aa6::function_5d127774())
			{
				level thread namespace_8c007aa6::function_831e0584(array(#"hash_628d31adb5e65260"), 0);
			}
			level.var_1bf21bf2 = undefined;
		}
		waitframe(1);
	}
	level.var_e72728b8 = var_6e135d55;
	function_c2a10fc();
	waypoint function_f9ed304d();
	waitframe(1);
	if(isdefined(var_308676f8) && var_308676f8)
	{
		e_player = get_player();
		e_player thread function_84181d75(0, undefined, undefined);
	}
	namespace_8c007aa6::function_3ca1b77d();
}

/*
	Name: function_ccd9180e
	Namespace: namespace_73e1c3e3
	Checksum: 0x2C0F331B
	Offset: 0xC978
	Size: 0x98
	Parameters: 0
	Flags: None
*/
function function_ccd9180e()
{
	level endon(#"combattraining_logic_finished");
	level.var_1bf21bf2 = undefined;
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"hash_70f03cfbb15356c0");
		e_dart = waitresult.dart;
		level.var_1bf21bf2 = e_dart;
		level thread death_watcher(e_dart);
	}
}

/*
	Name: death_watcher
	Namespace: namespace_73e1c3e3
	Checksum: 0x3D9DEB5D
	Offset: 0xCA18
	Size: 0x2A
	Parameters: 1
	Flags: None
*/
function death_watcher(e_dart)
{
	while(isdefined(e_dart))
	{
		waitframe(1);
	}
	level.var_1bf21bf2 = undefined;
}

/*
	Name: function_f0149e2f
	Namespace: namespace_73e1c3e3
	Checksum: 0x8AF438A2
	Offset: 0xCA50
	Size: 0x2A
	Parameters: 0
	Flags: None
*/
function function_f0149e2f()
{
	return hash(getrootmapname());
}

/*
	Name: function_9aca2fa0
	Namespace: namespace_73e1c3e3
	Checksum: 0x92F5D57
	Offset: 0xCA88
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function function_9aca2fa0(state)
{
	if(!isdefined(state))
	{
		return;
	}
	if(!(isdefined(level.var_903e2252) && level.var_903e2252))
	{
		return;
	}
	if(!isdefined(level.var_820c5561))
	{
		return;
	}
	music::setmusicstate(state + "_" + level.var_820c5561);
}

/*
	Name: function_9ab507a9
	Namespace: namespace_73e1c3e3
	Checksum: 0xB78982F9
	Offset: 0xCB08
	Size: 0x284
	Parameters: 6
	Flags: None
*/
function function_9ab507a9(var_76b15be0, var_8e92afbd, var_da2d40e, var_e380ff6c, var_40347291 = 1, var_314be19c = 0)
{
	level endon_callback(&function_e46a6ea7, #"hash_e96ef39e800ed76", #"combattraining_logic_finished");
	var_40347291 = 1;
	if(!isdefined(level.var_85697102))
	{
		level.var_85697102 = [];
	}
	level.var_85697102[var_76b15be0] = {#hash_314be19c:var_314be19c, #hash_40347291:var_40347291, #hash_e380ff6c:var_e380ff6c, #hash_a90a2d1:var_da2d40e, #hash_5d90b13a:var_8e92afbd, #hash_1585e0a4:[], #targetname:var_76b15be0};
	var_e62fe646 = getentarray(var_76b15be0, "targetname");
	/#
		assert(var_e62fe646.size > 0, "");
	#/
	while(true)
	{
		level thread colbounds_off(var_76b15be0, 1);
		var_385703b7 = undefined;
		var_385703b7 = level waittill(var_8e92afbd);
		level thread colbounds_on(var_76b15be0);
		do
		{
			var_385703b7 = undefined;
			var_385703b7 = level waittill(var_8e92afbd, var_da2d40e);
			if(var_385703b7._notify == var_8e92afbd)
			{
				level thread function_95f28639(var_76b15be0);
			}
			else
			{
				level thread colbounds_off(var_76b15be0);
			}
		}
		while(var_385703b7._notify != var_da2d40e);
	}
}

/*
	Name: function_e46a6ea7
	Namespace: namespace_73e1c3e3
	Checksum: 0xFC1A781E
	Offset: 0xCD98
	Size: 0x90
	Parameters: 1
	Flags: None
*/
function function_e46a6ea7(var_5a5260d8)
{
	foreach(var_56bb3698 in level.var_85697102)
	{
		colbounds_off(var_56bb3698.targetname, 1);
	}
}

/*
	Name: colbounds_on
	Namespace: namespace_73e1c3e3
	Checksum: 0xDC0C094E
	Offset: 0xCE30
	Size: 0x154
	Parameters: 1
	Flags: None
*/
function colbounds_on(str_id)
{
	/#
		assert(isdefined(level.var_85697102[str_id]), "");
	#/
	level.var_85697102[str_id].b_on = 1;
	var_e62fe646 = level.var_85697102[str_id].var_e62fe646;
	foreach(var_e50687db in var_e62fe646)
	{
		var_e50687db solid();
		if(isdefined(level.var_85697102[str_id].var_314be19c) && level.var_85697102[str_id].var_314be19c)
		{
			var_e50687db disconnectpaths();
		}
	}
	function_95f28639(str_id);
}

/*
	Name: colbounds_off
	Namespace: namespace_73e1c3e3
	Checksum: 0xEE106377
	Offset: 0xCF90
	Size: 0x17E
	Parameters: 2
	Flags: None
*/
function colbounds_off(str_id, var_c57d5cfe = 0)
{
	/#
		assert(isdefined(level.var_85697102[str_id]), "");
	#/
	var_e62fe646 = level.var_85697102[str_id].var_e62fe646;
	foreach(var_e50687db in var_e62fe646)
	{
		var_e50687db notsolid();
		var_e50687db connectpaths();
	}
	var_e380ff6c = level.var_85697102[str_id].var_e380ff6c;
	if(!(isdefined(var_c57d5cfe) && var_c57d5cfe) && (isdefined(var_e380ff6c) && var_e380ff6c > 0))
	{
		wait(var_e380ff6c);
	}
	function_a3f8ddfa(str_id);
	level.var_85697102[str_id].b_on = 0;
}

/*
	Name: function_95f28639
	Namespace: namespace_73e1c3e3
	Checksum: 0x76210B8
	Offset: 0xD118
	Size: 0x5B0
	Parameters: 1
	Flags: None
*/
function function_95f28639(str_id)
{
	/#
		assert(level.var_85697102[str_id].b_on == 1, "");
	#/
	if(level.var_85697102[str_id].var_1585e0a4.size === 0)
	{
		level.var_85697102[str_id].var_1585e0a4 = [];
		foreach(var_e50687db in level.var_85697102[str_id].var_e62fe646)
		{
			if(isdefined(var_e50687db.target))
			{
				s_loc = struct::get(var_e50687db.target, "targetname");
				fwd = anglestoforward(s_loc.angles);
				right = anglestoright(s_loc.angles);
				if(isdefined(var_e50687db.radius))
				{
					switch(var_e50687db.radius)
					{
						case 128:
						case "hash_456fbb181822b8f6":
						{
							str_effect = "ui/fx8_ui_ct_plane_marker_team_b128";
							break;
						}
						case 150:
						case "hash_455ec518181456c1":
						{
							str_effect = "ui/fx8_ui_ct_plane_marker_team_b150";
							break;
						}
						case 170:
						case "hash_45653118181979f3":
						{
							str_effect = "ui/fx8_ui_ct_plane_marker_team_b170";
							break;
						}
						case 180:
						case "hash_454dc7181805e6f4":
						{
							str_effect = "ui/fx8_ui_ct_plane_marker_team_b180";
							break;
						}
						case 500:
						case "hash_22c30b18047d0590":
						{
							str_effect = "ui/fx8_ui_ct_plane_marker_team_b500";
							break;
						}
						case 750:
						case "hash_34e4ef180efc808b":
						{
							str_effect = "ui/fx8_ui_ct_plane_marker_team_b750";
							break;
						}
						case 1000:
						case "hash_d8269f0f88e4a24":
						{
							str_effect = "ui/fx8_ui_ct_plane_marker_team_b1000";
							break;
						}
						case 350:
						case "hash_57398b1822579c1f":
						default:
						{
							str_effect = "ui/fx8_ui_ct_plane_marker_team_b350";
							break;
						}
					}
				}
				if(isdefined(s_loc.radius))
				{
					switch(s_loc.radius)
					{
						case 128:
						case "hash_456fbb181822b8f6":
						{
							str_effect = "ui/fx8_ui_ct_plane_marker_team_b128";
							break;
						}
						case 150:
						case "hash_455ec518181456c1":
						{
							str_effect = "ui/fx8_ui_ct_plane_marker_team_b150";
							break;
						}
						case 170:
						case "hash_45653118181979f3":
						{
							str_effect = "ui/fx8_ui_ct_plane_marker_team_b170";
							break;
						}
						case 180:
						case "hash_454dc7181805e6f4":
						{
							str_effect = "ui/fx8_ui_ct_plane_marker_team_b180";
							break;
						}
						case 500:
						case "hash_22c30b18047d0590":
						{
							str_effect = "ui/fx8_ui_ct_plane_marker_team_b500";
							break;
						}
						case 750:
						case "hash_34e4ef180efc808b":
						{
							str_effect = "ui/fx8_ui_ct_plane_marker_team_b750";
							break;
						}
						case 1000:
						case "hash_d8269f0f88e4a24":
						{
							str_effect = "ui/fx8_ui_ct_plane_marker_team_b1000";
							break;
						}
						case 350:
						case "hash_57398b1822579c1f":
						default:
						{
							str_effect = "ui/fx8_ui_ct_plane_marker_team_b350";
							break;
						}
					}
				}
				else
				{
					str_effect = "ui/fx8_ui_ct_plane_marker_team_b250";
				}
				level.var_85697102[str_id].var_1585e0a4[level.var_85697102[str_id].var_1585e0a4.size] = spawnfx(str_effect, s_loc.origin, fwd, right);
				triggerfx(level.var_85697102[str_id].var_1585e0a4[level.var_85697102[str_id].var_1585e0a4.size - 1]);
			}
		}
	}
}

/*
	Name: function_a3f8ddfa
	Namespace: namespace_73e1c3e3
	Checksum: 0x8F74AA8A
	Offset: 0xD6D0
	Size: 0x11A
	Parameters: 1
	Flags: None
*/
function function_a3f8ddfa(str_id)
{
	/#
		assert(isdefined(level.var_85697102[str_id]), "");
	#/
	if(isdefined(level.var_85697102[str_id].var_1585e0a4) && level.var_85697102[str_id].var_1585e0a4.size > 0)
	{
		foreach(effect in level.var_85697102[str_id].var_1585e0a4)
		{
			effect delete();
		}
		level.var_85697102[str_id].var_1585e0a4 = [];
	}
}

/*
	Name: function_9e33850b
	Namespace: namespace_73e1c3e3
	Checksum: 0x4E453FC
	Offset: 0xD7F8
	Size: 0x78
	Parameters: 0
	Flags: None
*/
function function_9e33850b()
{
	foreach(var_881eebdc in level.var_85697102)
	{
		level notify(var_881eebdc.var_a90a2d1);
	}
}

/*
	Name: function_26283961
	Namespace: namespace_73e1c3e3
	Checksum: 0xC785023E
	Offset: 0xD878
	Size: 0x28
	Parameters: 0
	Flags: None
*/
function function_26283961()
{
	function_9e33850b();
	level notify(#"hash_e96ef39e800ed76");
}

/*
	Name: function_6432dd9
	Namespace: namespace_73e1c3e3
	Checksum: 0x1A4679E8
	Offset: 0xD8A8
	Size: 0x112
	Parameters: 3
	Flags: None
*/
function function_6432dd9(nd_current, n_speed, n_accel)
{
	self endon(#"death");
	self helicopter::heli_reset();
	self notify(#"hash_6c89e93b924cbb7f");
	self setspeed(n_speed, n_accel);
	while(true)
	{
		self.goalradius = 100;
		self setgoal(nd_current.origin, 1, 0);
		self waittill(#"goal");
		if(isdefined(nd_current.target))
		{
			nd_current = getnode(nd_current.target, "targetname");
		}
		else
		{
			break;
		}
	}
}

/*
	Name: function_31a67d65
	Namespace: namespace_73e1c3e3
	Checksum: 0x42FFDEA
	Offset: 0xD9C8
	Size: 0x194
	Parameters: 2
	Flags: None
*/
function function_31a67d65(e_target, var_6ae0852b)
{
	self endon(#"death");
	e_target endon(#"death");
	var_1defcd75 = getweapon(#"cobra_20mm_comlink");
	while(isalive(e_target))
	{
		self setvehweapon(var_1defcd75);
		self turretsettarget(0, e_target);
		while(!self.turretontarget)
		{
			wait(0.1);
		}
		self fireweapon(0, e_target);
		wait(0.1);
		n_time = gettime() / 1000;
		dt = n_time - n_start_time;
		if(dt > var_6ae0852b)
		{
			if(isbot(e_target))
			{
				e_target namespace_64a487a9::function_991ccf1a();
			}
			else
			{
				e_target dodamage(e_target.health + 100, e_target.origin);
			}
			break;
		}
	}
}

/*
	Name: function_be7bc7b2
	Namespace: namespace_73e1c3e3
	Checksum: 0x80B32CAF
	Offset: 0xDB68
	Size: 0x41E
	Parameters: 4
	Flags: None
*/
function function_be7bc7b2(var_eb8df0c3, var_a8d88c43, var_2d222ffc, var_d69032e9)
{
	b_success = 0;
	n_start_time = gettime() / 1000;
	level.var_3a266460 = undefined;
	level.var_a600ce76 = 1;
	e_player = get_player();
	var_3f21ce47 = e_player namespace_64a487a9::function_dde6edbd();
	foreach(bot in var_3f21ce47)
	{
		bot.var_147223cf = undefined;
	}
	var_9bff2467 = var_3f21ce47.size;
	var_8e1da8f9 = 0;
	while(true)
	{
		e_player = get_player();
		var_3f21ce47 = e_player namespace_64a487a9::function_dde6edbd();
		if(var_3f21ce47.size != var_9bff2467)
		{
			if(!var_8e1da8f9)
			{
				b_success = 0;
			}
			else
			{
				b_success = 1;
			}
			break;
		}
		n_frac = function_ee33a140();
		if(n_frac == 0)
		{
			if(!isdefined(level.var_3a266460))
			{
				level.var_3a266460 = gettime() / 1000;
			}
			n_time = gettime() / 1000;
			dt = n_time - level.var_3a266460;
			if(dt > var_a8d88c43)
			{
				b_success = 0;
				break;
			}
		}
		else if(!(isdefined(var_8e1da8f9) && var_8e1da8f9) && isdefined(var_d69032e9))
		{
			e_player = getplayers()[0];
			e_player thread function_61c3d59c(var_d69032e9, undefined);
		}
		var_8e1da8f9 = 1;
		if(!(isdefined(var_8346a4d8) && var_8346a4d8) && isdefined(var_2d222ffc))
		{
			level thread namespace_8c007aa6::function_831e0584(var_2d222ffc);
			var_8346a4d8 = 1;
		}
		waitframe(1);
	}
	if(!b_success)
	{
		var_3f21ce47 = namespace_64a487a9::function_fbe3dcbb();
		foreach(bot in var_3f21ce47)
		{
			if(isdefined(bot.var_147223cf) && bot.var_147223cf > n_start_time)
			{
				b_success = 1;
			}
			bot.var_147223cf = undefined;
		}
	}
	if(!b_success && var_eb8df0c3)
	{
		var_3f21ce47 = namespace_64a487a9::function_fbe3dcbb();
		foreach(bot in var_3f21ce47)
		{
			bot thread function_3e0767e2(1);
		}
	}
	level.var_a600ce76 = undefined;
	return b_success;
}

/*
	Name: function_ee33a140
	Namespace: namespace_73e1c3e3
	Checksum: 0x2013078
	Offset: 0xDF90
	Size: 0xFC
	Parameters: 0
	Flags: None
*/
function function_ee33a140()
{
	e_player = get_player();
	var_3f21ce47 = e_player namespace_64a487a9::function_dde6edbd();
	var_fdc23b48 = var_3f21ce47.size;
	var_1b4ddeb6 = 0;
	foreach(bot in var_3f21ce47)
	{
		if(isdefined(bot.var_ef9b6f0b) && bot.var_ef9b6f0b)
		{
			var_1b4ddeb6++;
		}
	}
	if(var_fdc23b48 == 0)
	{
		return 0;
	}
	return var_1b4ddeb6 / var_fdc23b48;
}

/*
	Name: function_6434a9f
	Namespace: namespace_73e1c3e3
	Checksum: 0x5120D0A5
	Offset: 0xE098
	Size: 0x16C
	Parameters: 4
	Flags: None
*/
function function_6434a9f(n_start_scale = 0.01, var_a8de9b22 = 1, n_time = 1, n_steps = 5)
{
	self endon(#"death", #"hash_5e367f32a795be37");
	var_21cfaeb2 = var_a8de9b22 - n_start_scale / n_steps;
	n_time_delta = n_time / n_steps;
	n_scale = n_start_scale;
	if(n_start_scale <= var_a8de9b22)
	{
		while(n_scale < var_a8de9b22)
		{
			self setscale(n_scale);
			n_scale = n_scale + var_21cfaeb2;
			wait(n_time_delta);
		}
	}
	else
	{
		while(n_scale >= var_a8de9b22)
		{
			self setscale(n_scale);
			n_scale = n_scale + var_21cfaeb2;
			wait(n_time_delta);
		}
	}
	self setscale(var_a8de9b22);
}

/*
	Name: function_876eadbc
	Namespace: namespace_73e1c3e3
	Checksum: 0x80F724D1
	Offset: 0xE210
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function function_876eadbc()
{
}

/*
	Name: function_d099c6b7
	Namespace: namespace_73e1c3e3
	Checksum: 0xBA05D251
	Offset: 0xE220
	Size: 0x8C
	Parameters: 1
	Flags: None
*/
function function_d099c6b7(str_weapon)
{
	weapon = getweapon(str_weapon);
	self namespace_64a487a9::function_35e77034(weapon, 1);
	while(!self hasweapon(weapon))
	{
		waitframe(1);
	}
	wait(0.25);
	self namespace_87f62ea8::function_de6c5bcb();
}

/*
	Name: function_cac2512f
	Namespace: namespace_73e1c3e3
	Checksum: 0x3FA79DDA
	Offset: 0xE2B8
	Size: 0x8C
	Parameters: 1
	Flags: None
*/
function function_cac2512f(str_weapon)
{
	weapon = getweapon(str_weapon);
	self namespace_64a487a9::function_35e77034(weapon, 1);
	while(!self hasweapon(weapon))
	{
		waitframe(1);
	}
	wait(0.25);
	self namespace_87f62ea8::function_f1f5be0f();
}

/*
	Name: function_c561377e
	Namespace: namespace_73e1c3e3
	Checksum: 0x59486DF3
	Offset: 0xE350
	Size: 0x94
	Parameters: 3
	Flags: None
*/
function function_c561377e(n_delay, var_b1a0d102 = 0, b_play_fx = 1)
{
	if(isdefined(n_delay))
	{
		wait(n_delay);
	}
	function_49e0c5bc(1, 0, b_play_fx);
	wait(0.1);
	if(isdefined(var_b1a0d102) && var_b1a0d102)
	{
		delete_corpses();
	}
}

/*
	Name: delete_corpses
	Namespace: namespace_73e1c3e3
	Checksum: 0x239C7B7B
	Offset: 0xE3F0
	Size: 0x90
	Parameters: 0
	Flags: None
*/
function delete_corpses()
{
	corpses = getcorpsearray();
	foreach(corpse in corpses)
	{
		corpse delete();
	}
}

/*
	Name: function_d153452e
	Namespace: namespace_73e1c3e3
	Checksum: 0x3D6AE6E4
	Offset: 0xE488
	Size: 0xA6
	Parameters: 1
	Flags: None
*/
function function_d153452e(name)
{
	sessionmode = currentsessionmode();
	playerroletemplatecount = getplayerroletemplatecount(sessionmode);
	for(i = 0; i < playerroletemplatecount; i++)
	{
		var_3c6fd4f7 = function_b14806c6(i, sessionmode);
		if(var_3c6fd4f7 == name)
		{
			return i;
		}
	}
	return undefined;
}

/*
	Name: function_e44c5b8e
	Namespace: namespace_73e1c3e3
	Checksum: 0xBDFBD574
	Offset: 0xE538
	Size: 0x20C
	Parameters: 3
	Flags: None
*/
function function_e44c5b8e(var_68945a8a, var_88d2d0b2 = 10, var_baf3556b = 0)
{
	level.usingscorestreaks = 1;
	level.var_64ce2685 = 1;
	level.disablemomentum = 0;
	level.usingmomentum = 1;
	level.var_de284b17 = 0;
	level.var_dd8875fe = var_88d2d0b2;
	e_player = get_player();
	if(e_player.killstreak.size == 0)
	{
		level.var_b4a06c5b = var_68945a8a;
		setdvar(#"custom_killstreak_mode", 2);
		setdvar(#"hash_26de0c20bc979e24", level.killstreakindices[var_68945a8a]);
		setdvar(#"hash_26de0f20bc97a33d", 0);
		setdvar(#"hash_26de0e20bc97a18a", 0);
		self.pers[#"killstreak_quantity"] = [];
		self.pers[#"held_killstreak_ammo_count"] = [];
		self.pers[#"held_killstreak_clip_count"] = [];
		e_player loadout::function_51dceab7();
	}
	setdvar(#"hash_3e06b14c41136e95", !var_baf3556b);
	if(!var_88d2d0b2)
	{
		level thread function_5160be8c();
	}
}

/*
	Name: function_5160be8c
	Namespace: namespace_73e1c3e3
	Checksum: 0xF5DEFB3E
	Offset: 0xE750
	Size: 0x134
	Parameters: 0
	Flags: None
*/
function function_5160be8c()
{
	wait(0.1);
	e_player = getplayers()[0];
	if(isdefined(e_player))
	{
		cost = killstreaks::get_killstreak_momentum_cost(e_player, level.var_b4a06c5b);
		event = #"ekia";
		/#
			assert(isdefined(level.scoreinfo));
		#/
		if(isdefined(level.scoreinfo) && isdefined(level.scoreinfo[event]))
		{
			eventindex = level.scoreinfo[event][#"row"];
			if(isdefined(eventindex))
			{
				e_player globallogic_score::giveplayermomentumnotification(cost, #"hash_480234a872bd64ac", undefined, 0, undefined, 0, eventindex, event, undefined);
			}
		}
	}
}

/*
	Name: function_daa27144
	Namespace: namespace_73e1c3e3
	Checksum: 0xFF9B879B
	Offset: 0xE890
	Size: 0x1E
	Parameters: 0
	Flags: None
*/
function function_daa27144()
{
	level.disablemomentum = 1;
	level.usingmomentum = 0;
}

/*
	Name: function_8881abec
	Namespace: namespace_73e1c3e3
	Checksum: 0xFE29E4D3
	Offset: 0xE8B8
	Size: 0xCE
	Parameters: 0
	Flags: None
*/
function function_8881abec()
{
	weaponslist = self getweaponslist();
	for(idx = 0; idx < weaponslist.size; idx++)
	{
		weapon = weaponslist[idx];
		if(killstreaks::is_killstreak_weapon(weapon))
		{
			quantity = killstreaks::get_killstreak_quantity(weapon);
			if(isdefined(quantity) && quantity > 0)
			{
				self killstreaks::change_killstreak_quantity(weapon, quantity * -1);
			}
		}
	}
}

/*
	Name: function_944e4110
	Namespace: namespace_73e1c3e3
	Checksum: 0x355FE664
	Offset: 0xE990
	Size: 0x1BC
	Parameters: 1
	Flags: None
*/
function function_944e4110(params)
{
	if(isdefined(level.var_dd8875fe) && level.var_dd8875fe == 0)
	{
		return;
	}
	eattacker = params.eattacker;
	weapon = params.weapon;
	if(isplayer(eattacker) && !isbot(eattacker) && eattacker != self)
	{
		cost = killstreaks::get_killstreak_momentum_cost(eattacker, level.var_b4a06c5b);
		level.var_78a31a59 = cost;
		var_595e41ee = int(cost / level.var_dd8875fe + 0.5);
		if(isdefined(level.var_28cfc859))
		{
			var_595e41ee = level.var_28cfc859;
		}
		level.var_de284b17 = level.var_de284b17 + var_595e41ee;
		event = #"ekia";
		eventindex = level.scoreinfo[event][#"row"];
		eattacker globallogic_score::giveplayermomentumnotification(var_595e41ee, #"hash_480234a872bd64ac", undefined, 0, weapon, 0, eventindex, event, undefined);
	}
}

/*
	Name: function_b3b2c91e
	Namespace: namespace_73e1c3e3
	Checksum: 0x4B39A8BF
	Offset: 0xEB58
	Size: 0x154
	Parameters: 0
	Flags: None
*/
function function_b3b2c91e()
{
	if(isdefined(level.var_dd8875fe) && level.var_dd8875fe == 0)
	{
		return;
	}
	e_player = getplayers()[0];
	cost = killstreaks::get_killstreak_momentum_cost(e_player, level.var_b4a06c5b);
	var_595e41ee = int(cost / level.var_dd8875fe + 0.5);
	if(isdefined(level.var_28cfc859))
	{
		var_595e41ee = level.var_28cfc859;
	}
	level.var_de284b17 = level.var_de284b17 + var_595e41ee;
	event = #"ekia";
	eventindex = level.scoreinfo[event][#"row"];
	e_player globallogic_score::giveplayermomentumnotification(var_595e41ee, #"hash_480234a872bd64ac", undefined, 0, undefined, 0, eventindex, event, undefined);
}

/*
	Name: function_68848e5
	Namespace: namespace_73e1c3e3
	Checksum: 0xAA809357
	Offset: 0xECB8
	Size: 0x5E
	Parameters: 1
	Flags: None
*/
function function_68848e5(var_4c911967)
{
	self endon(#"death");
	self.var_d5d10814 = 0;
	str_notify = "killstreak_ready_" + var_4c911967;
	self waittill(str_notify);
	self.var_d5d10814 = 1;
}

/*
	Name: function_5149c890
	Namespace: namespace_73e1c3e3
	Checksum: 0xE5DDFD49
	Offset: 0xED20
	Size: 0xCC
	Parameters: 2
	Flags: None
*/
function function_5149c890(b_on = 1, n_wait = 0.1)
{
	self endon(#"death");
	if(b_on)
	{
		if(isdefined(n_wait))
		{
			wait(n_wait);
		}
		var_6587a92b = self perks::function_be94fe26(#"hash_3a09b1d7eaa88087");
		self perks::function_7637bafa(#"hash_3a09b1d7eaa88087");
	}
	else
	{
		self perks::function_45d12554(#"hash_3a09b1d7eaa88087");
	}
}

/*
	Name: function_9a283f84
	Namespace: namespace_73e1c3e3
	Checksum: 0xD1DC9B8A
	Offset: 0xEDF8
	Size: 0x88
	Parameters: 2
	Flags: None
*/
function function_9a283f84(s_loc, str_model_name)
{
	e_model = util::spawn_model(str_model_name, s_loc.origin, s_loc.angles);
	waitframe(1);
	e_model clientfield::set("objective_glow", 1);
	e_model notsolid();
	return e_model;
}

/*
	Name: function_1e7b75f2
	Namespace: namespace_73e1c3e3
	Checksum: 0xCDDAC0AD
	Offset: 0xEE88
	Size: 0x218
	Parameters: 1
	Flags: None
*/
function function_1e7b75f2(s_loc)
{
	self endon(#"death");
	while(true)
	{
		var_94c758f2 = struct::get_array(s_loc.target, "targetname");
		if(var_94c758f2.size > 1)
		{
			s_loc = array::random(var_94c758f2);
		}
		else
		{
			s_loc = var_94c758f2[0];
		}
		self thread function_5b59f3b7(s_loc.origin, s_loc.angles, 32);
		while(true)
		{
			n_dist = distance(s_loc.origin, self.origin);
			if(n_dist < 50)
			{
				break;
			}
			waitframe(1);
		}
		self notify(#"reached_goal");
		var_c481f7e6 = randomfloatrange(0, 100);
		if(isdefined(s_loc.script_noteworthy) && s_loc.script_noteworthy == #"crouch")
		{
			self namespace_9c817acd::crouch();
		}
		else if(var_c481f7e6 < 50)
		{
			self namespace_9c817acd::crouch();
		}
		self thread function_a7a72476();
		n_wait = randomfloatrange(2, 4);
		wait(n_wait);
		self namespace_9c817acd::stand();
	}
}

/*
	Name: function_f3b02850
	Namespace: namespace_73e1c3e3
	Checksum: 0xB4E88954
	Offset: 0xF0A8
	Size: 0x1D6
	Parameters: 2
	Flags: None
*/
function function_f3b02850(s_loc, var_9806a7cc)
{
	self endon(#"death", #"hash_6874a1e812989791");
	self.var_59943abb = undefined;
	while(true)
	{
		while(true)
		{
			if(!isdefined(s_loc))
			{
				return;
			}
			self thread function_5b59f3b7(s_loc.origin, s_loc.angles, 32);
			n_dist = distance(s_loc.origin, self.origin);
			if(n_dist < 50)
			{
				if(isdefined(s_loc.script_notify))
				{
					level notify(s_loc.script_notify);
				}
				break;
			}
			waitframe(1);
		}
		if(isdefined(s_loc.target))
		{
			var_94c758f2 = struct::get_array(s_loc.target, "targetname");
			if(var_94c758f2.size > 1)
			{
				var_72cf8101 = randomint(var_94c758f2.size);
				s_loc = var_94c758f2[var_72cf8101];
			}
			else
			{
				s_loc = var_94c758f2[0];
			}
		}
		else
		{
			break;
		}
	}
	self thread function_5b59f3b7(self.origin, self.angles, var_9806a7cc);
	self.var_59943abb = 1;
	self.var_310c107 = s_loc;
}

/*
	Name: function_a7a72476
	Namespace: namespace_73e1c3e3
	Checksum: 0x38BFAAC1
	Offset: 0xF288
	Size: 0x8A
	Parameters: 0
	Flags: None
*/
function function_a7a72476()
{
	self endon(#"death");
	if(!(isdefined(self.var_5a8f690) && self.var_5a8f690))
	{
		e_player = getplayers()[0];
		if(isalive(e_player))
		{
			self.var_2925fedc = e_player.origin;
		}
		wait(2);
		self.var_2925fedc = undefined;
	}
}

/*
	Name: function_9a4e412e
	Namespace: namespace_73e1c3e3
	Checksum: 0x8DA39617
	Offset: 0xF320
	Size: 0xD8
	Parameters: 2
	Flags: None
*/
function function_9a4e412e(s_loc, str_notify)
{
	while(true)
	{
		e_player = get_player();
		v_dir = vectornormalize(s_loc.origin - e_player.origin);
		dp = vectordot(v_forward, v_dir);
		if(dp < 0)
		{
			break;
		}
		waitframe(1);
	}
	level notify(str_notify);
}

/*
	Name: function_c444a920
	Namespace: namespace_73e1c3e3
	Checksum: 0x8B38F2FC
	Offset: 0xF400
	Size: 0x196
	Parameters: 2
	Flags: None
*/
function function_c444a920(s_loc, var_9c8d914)
{
	while(!(isdefined(level.var_20fb90aa) && level.var_20fb90aa))
	{
		e_player = get_player();
		if(!isalive(e_player))
		{
			waypoint function_f9ed304d();
			while(true)
			{
				e_player = get_player();
				if(isalive(e_player))
				{
					waitframe(1);
					waypoint = create_waypoint(#"hash_43f27b76957da4d2", s_loc.origin, s_loc.angles, #"any", undefined, var_9c8d914);
					break;
				}
				waitframe(1);
			}
		}
		waitframe(1);
	}
	waypoint function_f9ed304d();
	level.var_20fb90aa = undefined;
}

/*
	Name: function_9d1fc273
	Namespace: namespace_73e1c3e3
	Checksum: 0x92B93340
	Offset: 0xF5A0
	Size: 0x1D2
	Parameters: 4
	Flags: None
*/
function function_9d1fc273(e_obj, var_41bd0b0d, str_objective, var_484df237)
{
	e_obj.trigger = spawn("trigger_radius_use", e_obj.origin + vectorscale((0, 0, 1), 15), 0, 120, 100);
	e_obj.trigger setcursorhint("HINT_INTERACTIVE_PROMPT");
	e_obj.trigger triggerignoreteam();
	e_obj.gameobject = gameobjects::create_use_object(#"neutral", e_obj.trigger, [], vectorscale((0, 0, 1), 60), str_objective);
	e_obj.gameobject gameobjects::set_objective_entity(e_obj.gameobject);
	e_obj.gameobject gameobjects::set_visible_team(#"any");
	e_obj.gameobject gameobjects::allow_use(#"any");
	e_obj.gameobject gameobjects::set_use_time(var_484df237);
	e_obj.gameobject.usecount = 0;
	e_obj.gameobject.var_5ecd70 = e_obj;
	e_obj.gameobject.onuse = var_41bd0b0d;
}

/*
	Name: function_402c2175
	Namespace: namespace_73e1c3e3
	Checksum: 0x1595F85B
	Offset: 0xF780
	Size: 0x58
	Parameters: 0
	Flags: None
*/
function function_402c2175()
{
	self endon(#"death");
	while(true)
	{
		self val::reset(#"hash_7d4096844efc64ea", "ignoreall");
		wait(0.1);
	}
}

/*
	Name: function_2b52aef5
	Namespace: namespace_73e1c3e3
	Checksum: 0xC2456354
	Offset: 0xF7E0
	Size: 0x10C
	Parameters: 1
	Flags: None
*/
function function_2b52aef5(n_delay = 5)
{
	e_player = get_player();
	wait(n_delay);
	a_e_enemies = e_player namespace_64a487a9::function_dde6edbd();
	var_a378f27e = a_e_enemies[a_e_enemies.size - 1];
	util::magic_bullet_shield(var_a378f27e);
	var_a378f27e swat_team::function_87bf6422(#"swat_team");
	util::stop_magic_bullet_shield(var_a378f27e);
	wait(2);
	namespace_8c007aa6::function_831e0584(array(#"hash_192b21887f0cf61"), 1);
}

/*
	Name: function_89cd182c
	Namespace: namespace_73e1c3e3
	Checksum: 0xB7D954D9
	Offset: 0xF8F8
	Size: 0x8A
	Parameters: 1
	Flags: None
*/
function function_89cd182c(s_loc)
{
	self endon(#"death");
	v_dir = anglestoforward(s_loc.angles);
	var_c657828f = s_loc.origin + v_dir * 100;
	self.var_2925fedc = var_c657828f;
	wait(2);
	self.var_2925fedc = undefined;
}

/*
	Name: function_51c89e00
	Namespace: namespace_73e1c3e3
	Checksum: 0x92AFA6FE
	Offset: 0xF990
	Size: 0x110
	Parameters: 2
	Flags: None
*/
function function_51c89e00(var_2f3964e3, str_team)
{
	var_3f21ce47 = namespace_64a487a9::function_fbe3dcbb();
	foreach(bot in var_3f21ce47)
	{
		if(bot.team == str_team)
		{
			if(isdefined(var_2f3964e3) && var_2f3964e3)
			{
				bot val::set(#"hash_2a2460ac6d0dc272", "ignoreall", 1);
				continue;
			}
			bot val::reset(#"hash_2a2460ac6d0dc272", "ignoreall");
		}
	}
}

/*
	Name: function_a61ebb46
	Namespace: namespace_73e1c3e3
	Checksum: 0xAB2D6814
	Offset: 0xFAA8
	Size: 0x196
	Parameters: 1
	Flags: None
*/
function function_a61ebb46(str_hint)
{
	level endon(#"combattraining_logic_finished");
	level.var_43ac3b33 = 1;
	level.var_97aaa7c6 = 1;
	level.var_29c997df = 1;
	function_13c4b855(1);
	e_player = getplayers()[0];
	e_player thread function_61c3d59c(str_hint, undefined);
	var_10a60547 = 0;
	while(true)
	{
		e_player = getplayers()[0];
		if(!e_player gamepadusedlast() && !var_10a60547)
		{
			if(!e_player primarybuttonpressedlocal())
			{
				var_10a60547 = 1;
			}
			waitframe(1);
			continue;
		}
		if(e_player primarybuttonpressedlocal())
		{
			break;
		}
		waitframe(1);
	}
	function_13c4b855(0);
	function_c2a10fc();
	level.var_29c997df = undefined;
	level.var_97aaa7c6 = undefined;
	level.var_43ac3b33 = undefined;
}

/*
	Name: function_dfd7add4
	Namespace: namespace_73e1c3e3
	Checksum: 0x8622BEE8
	Offset: 0xFC48
	Size: 0x420
	Parameters: 0
	Flags: None
*/
function function_dfd7add4()
{
	/#
		sessionmode = currentsessionmode();
		setdvar(#"hash_149e449b33813387", "");
		if(sessionmode != 4)
		{
			adddebugcommand("");
			adddebugcommand("");
			adddebugcommand("");
			adddebugcommand("");
			adddebugcommand("");
			adddebugcommand("");
			adddebugcommand("");
			adddebugcommand("");
			adddebugcommand("");
		}
		while(true)
		{
			wait(0.25);
			cmd = getdvarstring(#"hash_149e449b33813387", "");
			if(cmd == "")
			{
				continue;
			}
			e_player = level.players[0];
			switch(cmd)
			{
				case "hash_1c8ad6210820416d":
				{
					e_player function_c314f6b1(60);
					break;
				}
				case "hash_476db23e31dd540a":
				{
					e_player function_c314f6b1(-60);
					break;
				}
				case "hash_7c58a6c0f16e8d5a":
				{
					e_player function_5149c890(0);
					break;
				}
				case "hash_51931fabb2df3ec0":
				{
					e_player function_5149c890(1);
					break;
				}
				case "hash_3d0ce2b96d797378":
				{
					level thread function_efee6ca7();
					break;
				}
				case "hash_444db11283eecad3":
				{
					level notify(#"hash_36a14c776cf91baa");
					break;
				}
				case "hash_7582b4c6519810f":
				{
					e_player function_1bb93418();
					break;
				}
				case "hash_19bcb7c1479154ad":
				{
					e_player swampslashersounds();
					break;
				}
				case "kill_player":
				{
					e_player dodamage(1000, e_player.origin);
					break;
				}
				case "hash_11689149cd7381a5":
				{
					level.var_5d40bf7e = 0;
					break;
				}
				case "hash_84bd3681b5c97a1":
				{
					level.var_5d40bf7e = 1;
					break;
				}
				case "hash_535c50e942322f33":
				{
					e_player thread function_bb58b6f4();
					break;
				}
				case "hash_5827c15b7b5d19f7":
				{
					e_player notify(#"hash_665982d72456ad87");
					break;
				}
			}
			setdvar(#"hash_149e449b33813387", "");
		}
	#/
}

/*
	Name: function_efee6ca7
	Namespace: namespace_73e1c3e3
	Checksum: 0xC86AB719
	Offset: 0x10070
	Size: 0x46
	Parameters: 0
	Flags: None
*/
function function_efee6ca7()
{
	/#
		level endon(#"hash_36a14c776cf91baa");
		while(true)
		{
			self function_c314f6b1(1);
			wait(1);
		}
	#/
}

/*
	Name: function_bb58b6f4
	Namespace: namespace_73e1c3e3
	Checksum: 0x1C1C9881
	Offset: 0x100C0
	Size: 0xDE
	Parameters: 0
	Flags: None
*/
function function_bb58b6f4()
{
	/#
		self endon(#"death", #"hash_665982d72456ad87");
		while(true)
		{
			wpn_current = self getcurrentweapon();
			var_842a40b6 = self getweaponammoclip(wpn_current);
			var_1f2dbaf4 = self function_f09c133d(wpn_current);
			var_a6e01ccb = self getweaponammofuel(wpn_current);
			if(var_842a40b6 == 1)
			{
				self setweaponammoclip(wpn_current, var_1f2dbaf4);
			}
			waitframe(1);
		}
	#/
}

