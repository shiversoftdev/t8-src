// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_1c72973fb240f263;
#using script_2c5e325003fa52e2;
#using script_421e0a3702e22de;
#using script_52c6c2d1a2ef1b46;
#using script_5bb072c3abf4652c;
#using script_6021ce59143452c3;
#using script_6a3f43063dfd1bdc;
#using script_9e4105ea1798ccc;
#using script_ab862743b3070a;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm\zm_orange_util.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_86eed980;

/*
	Name: init
	Namespace: namespace_86eed980
	Checksum: 0x1E65669A
	Offset: 0x588
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	init_clientfields();
	init_flags();
	namespace_ad4d960b::register(#"hash_35c87147e29f1708", 1);
}

/*
	Name: init_clientfields
	Namespace: namespace_86eed980
	Checksum: 0x5AC4DDD
	Offset: 0x5E0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("allplayers", "zm_orange_force_challenge_model", 24000, 1, "int");
}

/*
	Name: init_flags
	Namespace: namespace_86eed980
	Checksum: 0xBFC50376
	Offset: 0x620
	Size: 0x1C4
	Parameters: 0
	Flags: Linked
*/
function init_flags()
{
	level flag::init(#"all_challenges_complete");
	level flag::init(#"hash_4a8105909cc2603d");
	level flag::init(#"break_freeze_faster");
	level flag::init(#"hash_671b32b10654845d");
	level flag::init(#"hash_b544517e05d7175");
	level flag::init(#"extra_snowballs");
	level flag::init(#"hash_2a1215d8a3e31013");
	level flag::init(#"half_price_traps");
	level flag::init(#"hash_84593b9650c7abf");
	level flag::init(#"hash_2d3f1dd5445d3423");
	level flag::init(#"hash_4e33fc3d32735214");
	level flag::init(#"hash_701aa76674161d36");
	level flag::init(#"hash_616e0abddc034740");
	level flag::init(#"hash_5b3ea84b9db5af50");
}

/*
	Name: main
	Namespace: namespace_86eed980
	Checksum: 0x40FDCC2C
	Offset: 0x7F0
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function main()
{
	if(zm_utility::is_standard())
	{
		return;
	}
	level.var_9cb7f7de = 0;
	level.var_97a44fdd = undefined;
	level.var_a43a746d = 0;
	level thread function_980b1dc5();
}

/*
	Name: init_challenge
	Namespace: namespace_86eed980
	Checksum: 0x14A21049
	Offset: 0x850
	Size: 0xFA
	Parameters: 8
	Flags: Linked
*/
function init_challenge(n_index, var_db4802f2, var_be570367, str_notify, func_setup, var_383f77fa, var_53890456, str_vox)
{
	s_challenge = spawnstruct();
	s_challenge.n_index = n_index;
	s_challenge.var_db4802f2 = var_db4802f2;
	s_challenge.var_be570367 = var_be570367;
	s_challenge.str_notify = str_notify;
	s_challenge.func_setup = func_setup;
	s_challenge.var_383f77fa = var_383f77fa;
	s_challenge.var_53890456 = var_53890456;
	s_challenge.n_current_progress = 0;
	s_challenge.str_vox = str_vox;
	s_challenge.s_challenge_station = self;
	return s_challenge;
}

/*
	Name: function_980b1dc5
	Namespace: namespace_86eed980
	Checksum: 0xF2C1DB09
	Offset: 0x958
	Size: 0x198
	Parameters: 0
	Flags: Linked
*/
function function_980b1dc5()
{
	level.var_23b90682 = struct::get_array("s_challenge_station", "targetname");
	foreach(s_challenge_station in level.var_23b90682)
	{
		s_challenge_station.var_3c4b2051 = 0;
		s_challenge_station.var_6fb9ebb6 = 0;
		s_challenge_station.var_54cb6134 = 0;
		s_challenge_station.var_6c841cf = 1;
		s_challenge_station.var_53b4b2f6 = getent(s_challenge_station.target, "targetname");
		for(i = 1; i < 4; i++)
		{
			s_challenge_station.var_53b4b2f6 hidepart("tag_bulb_on_" + i);
		}
		s_challenge_station function_d3fc7131();
		s_challenge_station zm_unitrigger::create(&function_848a8225, 64);
		s_challenge_station thread function_af2eff2e();
	}
}

/*
	Name: function_d3fc7131
	Namespace: namespace_86eed980
	Checksum: 0x7046A9B8
	Offset: 0xAF8
	Size: 0x7CA
	Parameters: 0
	Flags: Linked
*/
function function_d3fc7131()
{
	self.var_12080390 = [];
	switch(self.script_location)
	{
		case "beach":
		{
			self.var_12080390[self.var_12080390.size] = init_challenge(1, 13, 25, #"hash_1eff75043dd3a914", &function_f0f0f5f3, &function_20f477f2, "bonus_points_team", #"hash_78a6b67ab7d98b2f");
			self.var_12080390[self.var_12080390.size] = init_challenge(2, 15, 30, #"hash_1eff78043dd3ae2d", &function_b1c46dce, &function_b0d19ce9, "insta_kill", #"hash_697d3cc07f8424da");
			self.var_12080390[self.var_12080390.size] = init_challenge(3, 3, 3, #"hash_1eff77043dd3ac7a", &function_e960fbf3, &function_35f6e838, "break_freeze_faster", #"hash_4394f0fdb2267af1");
			self function_33f591cf();
			break;
		}
		case "forecastle":
		{
			self.var_12080390[self.var_12080390.size] = init_challenge(4, 25, 50, #"hash_4e74f8eb1bd5b367", &function_63ed3839, &function_d9dffba1, "carpenter", #"hash_78a6b67ab7d98b2f");
			self.var_12080390[self.var_12080390.size] = init_challenge(5, 10, 20, #"hash_4e74f9eb1bd5b51a", &function_6d225067, &function_6d50f216, "fire_sale", #"hash_697d3cc07f8424da");
			self.var_12080390[self.var_12080390.size] = init_challenge(6, 3, 3, #"hash_4e74faeb1bd5b6cd", &function_2ae162bf, &function_1de4dc2b, "armor", #"hash_3192e2687f3a2667");
			self function_be80cd37();
			break;
		}
		case "frozen_crevasse":
		{
			self.var_12080390[self.var_12080390.size] = init_challenge(7, 20, 40, #"hash_d9f2cedb84b8d66", &function_658f9053, &function_5ba49bb9, "bonus_points_team", #"hash_78a6b67ab7d98b2f");
			self.var_12080390[self.var_12080390.size] = init_challenge(8, 6, 12, #"hash_d9f2bedb84b8bb3", &function_8885885d, &function_b0848cf7, "full_ammo", #"hash_697d3cc07f8424da");
			self.var_12080390[self.var_12080390.size] = init_challenge(9, 5, 5, #"hash_d9f2aedb84b8a00", &function_39ca7654, &function_a0ebbf07, "extra_snowballs", #"hash_607ea24c3576c5b2");
			self function_e12fb431();
			break;
		}
		case "lighthouse_station":
		{
			self.var_12080390[self.var_12080390.size] = init_challenge(10, 25, 50, #"hash_3f452857bdecf44e", &function_6384ebfd, &function_fd31e27b, "carpenter", #"hash_78a6b67ab7d98b2f");
			self.var_12080390[self.var_12080390.size] = init_challenge(11, 20, 40, #"hash_3f452757bdecf29b", &function_6639d547, &function_50961fa5, "hero_weapon_power", #"hash_697d3cc07f8424da");
			self.var_12080390[self.var_12080390.size] = init_challenge(12, 3, 5, #"hash_3f452657bdecf0e8", &function_bb6ca008, &function_a9598dd1, "self_revives", #"hash_72d97680741c869d");
			break;
		}
		case "specimen_storage":
		{
			self.var_12080390[self.var_12080390.size] = init_challenge(13, 15, 25, #"hash_6ded98ee1bc95925", &function_b40fed60, &function_a4b66a2b, "insta_kill", #"hash_78a6b67ab7d98b2f");
			self.var_12080390[self.var_12080390.size] = init_challenge(14, 10, 15, #"hash_6ded95ee1bc9540c", &function_5c8b1a9a, &function_7d030c3d, "hero_weapon_power", #"hash_697d3cc07f8424da");
			self.var_12080390[self.var_12080390.size] = init_challenge(15, 3, 3, #"hash_6ded96ee1bc955bf", &function_a36ace8b, &function_6884e5b8, "half_price_traps", #"hash_1374108085ffeb9d");
			break;
		}
	}
}

/*
	Name: function_848a8225
	Namespace: namespace_86eed980
	Checksum: 0xB9DE18A3
	Offset: 0x12D0
	Size: 0x2F8
	Parameters: 1
	Flags: Linked
*/
function function_848a8225(e_player)
{
	s_challenge_station = self.stub.related_parent;
	if(!level flag::get(#"hash_641f14d0b2fd57d7"))
	{
		self sethintstring(#"hash_3c96e29876e85183");
		return 1;
	}
	if(isdefined(s_challenge_station.var_6fb9ebb6) && s_challenge_station.var_6fb9ebb6)
	{
		self sethintstring(#"hash_ca361c0650153b4");
		return 1;
	}
	if(isdefined(s_challenge_station.var_54cb6134) && s_challenge_station.var_54cb6134)
	{
		var_98d32b71 = s_challenge_station function_9f2ab302();
		if(function_8b1a219a())
		{
			self sethintstring(#"hash_1fe11cd647262073", var_98d32b71);
			return 1;
		}
		self sethintstring(#"hash_124603508868b48d", var_98d32b71);
		return 1;
	}
	if(isdefined(s_challenge_station.var_3c4b2051) && s_challenge_station.var_3c4b2051)
	{
		if(isdefined(s_challenge_station.var_5ac3d786) && s_challenge_station.var_5ac3d786 && s_challenge_station.script_location === "frozen_crevasse" && s_challenge_station.var_d6578e1f.n_index === 9)
		{
			str_hint = zm_utility::function_d6046228(#"hash_286ff0974159fb7c", #"hash_6d101ea87a79ddf0");
			self sethintstring(str_hint);
			return 1;
		}
		self sethintstring(#"hash_6e0cbceab229716f");
		return 1;
	}
	if(level flag::get(#"hash_671b32b10654845d"))
	{
		self sethintstring(#"hash_eff579a2073f6b5");
		return 1;
	}
	str_hint = zm_utility::function_d6046228(#"hash_1ea67965f84fd306", #"hash_4ca32e791c5048a2");
	self sethintstring(str_hint);
	return 1;
}

/*
	Name: function_9f2ab302
	Namespace: namespace_86eed980
	Checksum: 0xC4E8BC5B
	Offset: 0x15D0
	Size: 0x1E2
	Parameters: 0
	Flags: Linked
*/
function function_9f2ab302()
{
	switch(self.var_d6578e1f.var_53890456)
	{
		case "bonus_points_team":
		{
			var_289d3f49 = #"hash_33e97cafe9a6ce11";
			return var_289d3f49;
		}
		case "insta_kill":
		{
			var_289d3f49 = #"hash_5f22e6bba160236";
			return var_289d3f49;
		}
		case "fire_sale":
		{
			var_289d3f49 = #"hash_5979dcb633c28888";
			return var_289d3f49;
		}
		case "hero_weapon_power":
		{
			var_289d3f49 = #"hash_649852d17720d7f9";
			return var_289d3f49;
		}
		case "carpenter":
		{
			var_289d3f49 = #"hash_3f3c0bdcb88cacfa";
			return var_289d3f49;
		}
		case "full_ammo":
		{
			var_289d3f49 = #"hash_1c356afe160c9b7a";
			return var_289d3f49;
		}
		case "self_revives":
		{
			var_289d3f49 = #"hash_189972b46e07775";
			return var_289d3f49;
		}
		case "extra_snowballs":
		{
			var_289d3f49 = #"hash_1c6212f5aff79380";
			return var_289d3f49;
		}
		case "half_price_traps":
		{
			var_289d3f49 = #"hash_6875903d42d6d8ba";
			return var_289d3f49;
		}
		case "break_freeze_faster":
		{
			var_289d3f49 = #"hash_1cc63d50dbd08da7";
			return var_289d3f49;
		}
		case "armor":
		{
			var_289d3f49 = #"hash_6c9edec0976eeca1";
			return var_289d3f49;
		}
	}
}

/*
	Name: function_af2eff2e
	Namespace: namespace_86eed980
	Checksum: 0x8E1193FA
	Offset: 0x17C0
	Size: 0x29E
	Parameters: 0
	Flags: Linked
*/
function function_af2eff2e()
{
	level endon(#"end_game", #"hash_9cfd45106ac760d", #"hash_198bc172b5af7f25");
	self endon(#"hash_7a82343959085c17");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"trigger_activated");
		if(!level flag::get(#"hash_641f14d0b2fd57d7"))
		{
			continue;
		}
		if(isdefined(self.var_5ac3d786) && self.var_5ac3d786 && (isdefined(self.var_3c4b2051) && self.var_3c4b2051) && self.script_location === "frozen_crevasse" && self.var_d6578e1f.n_index === 9)
		{
			self.var_5ac3d786 = 0;
			self thread function_2a4de81f();
			self.var_d6578e1f function_c40f1feb(self);
			continue;
		}
		if(level flag::get(#"hash_671b32b10654845d"))
		{
			continue;
		}
		self.var_3c4b2051 = 1;
		level flag::set(#"hash_671b32b10654845d");
		level.var_97a44fdd = self;
		self.var_a80cd5e8 = spawn("script_origin", self.origin);
		self.var_a80cd5e8.name = "herm";
		if(!level flag::get(#"hash_b544517e05d7175"))
		{
			level flag::set(#"hash_b544517e05d7175");
			level flag::set(#"hash_2a1215d8a3e31013");
		}
		callback::on_connect(&function_76007e28);
		self thread function_1525b94c();
		if(self.script_location != "frozen_crevasse")
		{
			return;
		}
	}
}

/*
	Name: function_2a4de81f
	Namespace: namespace_86eed980
	Checksum: 0x7F78F8B7
	Offset: 0x1A68
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function function_2a4de81f()
{
	level endon(#"end_game");
	wait(5);
	self.var_5ac3d786 = 1;
}

/*
	Name: function_1525b94c
	Namespace: namespace_86eed980
	Checksum: 0xCAB59CF7
	Offset: 0x1AA0
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function function_1525b94c()
{
	n_size = self.var_12080390.size;
	if(n_size > 0)
	{
		self.var_d6578e1f = array::pop_front(self.var_12080390);
		if(n_size == 3 && level flag::get(#"hash_2a1215d8a3e31013"))
		{
			self.var_a80cd5e8 namespace_509a75d1::function_6a0d675d(#"hash_3a42fc5b4bbe08c5");
			level flag::clear(#"hash_2a1215d8a3e31013");
		}
		self start_challenge();
	}
	else
	{
		self function_99698cd6();
	}
}

/*
	Name: function_99698cd6
	Namespace: namespace_86eed980
	Checksum: 0x28075A3A
	Offset: 0x1BA0
	Size: 0x114
	Parameters: 0
	Flags: Linked
*/
function function_99698cd6()
{
	self notify(#"hash_7a82343959085c17");
	self.var_6fb9ebb6 = 1;
	level.var_97a44fdd = undefined;
	level flag::clear(#"hash_671b32b10654845d");
	level.var_a43a746d++;
	level function_e7b5b4bc();
	callback::remove_on_connect(&function_76007e28);
	if(level.var_a43a746d == level.var_23b90682.size)
	{
		level thread all_challenges_completed();
	}
	while(isdefined(self.var_a80cd5e8.is_speaking) && self.var_a80cd5e8.is_speaking)
	{
		waitframe(1);
	}
	if(isdefined(self.var_a80cd5e8))
	{
		self.var_a80cd5e8 delete();
	}
}

/*
	Name: function_e7b5b4bc
	Namespace: namespace_86eed980
	Checksum: 0x2A643A7E
	Offset: 0x1CC0
	Size: 0x132
	Parameters: 0
	Flags: Linked
*/
function function_e7b5b4bc()
{
	switch(level.var_a43a746d)
	{
		case 1:
		{
			level flag::set(#"hash_2d3f1dd5445d3423");
			break;
		}
		case 2:
		{
			level flag::set(#"hash_4e33fc3d32735214");
			break;
		}
		case 3:
		{
			level flag::set(#"hash_701aa76674161d36");
			break;
		}
		case 4:
		{
			level flag::set(#"hash_616e0abddc034740");
			break;
		}
		case 5:
		{
			level flag::set(#"hash_5b3ea84b9db5af50");
			break;
		}
	}
}

/*
	Name: function_76007e28
	Namespace: namespace_86eed980
	Checksum: 0x1956ED61
	Offset: 0x1E00
	Size: 0x1A2
	Parameters: 0
	Flags: Linked
*/
function function_76007e28()
{
	self endon(#"disconnect");
	if(!isdefined(level.var_97a44fdd) || !isdefined(level.var_97a44fdd.var_d6578e1f))
	{
		return;
	}
	var_d6578e1f = level.var_97a44fdd.var_d6578e1f;
	n_current_progress = var_d6578e1f.n_current_progress;
	n_index = var_d6578e1f.n_index;
	n_goal = var_d6578e1f.n_goal;
	if(isdefined(var_d6578e1f) && isdefined(n_current_progress) && isdefined(n_index) && isdefined(n_goal))
	{
		level namespace_6747c550::function_7df6bb60(#"hash_380ef45b5b7d0888", n_current_progress, self);
		level namespace_6747c550::function_7df6bb60(#"hash_49e0a1059cfa201a", n_goal, self);
		level namespace_6747c550::function_7df6bb60(#"hash_56eb67699f4d5fd2", n_index, self);
		switch(n_index)
		{
			case 4:
			case 12:
			{
				self thread function_ffe9eab7(var_d6578e1f);
				break;
			}
			default:
			{
				break;
			}
		}
	}
}

/*
	Name: all_challenges_completed
	Namespace: namespace_86eed980
	Checksum: 0x10BCC49
	Offset: 0x1FB0
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function all_challenges_completed()
{
	level flag::set(#"all_challenges_complete");
	namespace_85e029d3::function_3f9e02b8(0, #"hash_3f668e62652456fd", #"hash_3e87176776a2b6e3", &function_561fda29);
	namespace_85e029d3::function_d83490c5(0);
}

/*
	Name: function_561fda29
	Namespace: namespace_86eed980
	Checksum: 0xA91FA99D
	Offset: 0x2038
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function function_561fda29()
{
	var_16c37c7f = struct::get("reward_crate_thunder", "targetname");
	var_16c37c7f.var_9dd10753 = getent(var_16c37c7f.var_c8166135, "targetname");
	var_16c37c7f.var_82e1ca26 = getent(var_16c37c7f.var_861b2304, "targetname");
	var_16c37c7f.e_weapon = getent(var_16c37c7f.target_weapon, "targetname");
	var_16c37c7f zm_unitrigger::create(&function_54e8826c, 64);
	var_16c37c7f thread function_400a7216();
}

/*
	Name: function_54e8826c
	Namespace: namespace_86eed980
	Checksum: 0xD1C8E324
	Offset: 0x2140
	Size: 0xB0
	Parameters: 1
	Flags: Linked
*/
function function_54e8826c(e_player)
{
	if(e_player.currentweapon.isheroweapon === 1 || e_player.currentweapon.name === #"hash_603fdd2e4ae5b2b0")
	{
		return 0;
	}
	str_hint = zm_utility::function_d6046228(#"hash_509dd10b32275ac6", #"hash_1fbdd38541c13a62");
	self sethintstring(str_hint);
	return 1;
}

/*
	Name: function_400a7216
	Namespace: namespace_86eed980
	Checksum: 0xBC724342
	Offset: 0x2200
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_400a7216()
{
	level endon(#"end_game");
	var_88706ea7 = undefined;
	var_88706ea7 = self waittill(#"trigger_activated");
	self zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
	self function_735037d4();
}

/*
	Name: function_735037d4
	Namespace: namespace_86eed980
	Checksum: 0xBE204375
	Offset: 0x2280
	Size: 0x13C
	Parameters: 0
	Flags: Linked
*/
function function_735037d4()
{
	level endon(#"end_game");
	if(isdefined(self.var_82e1ca26))
	{
		self.var_82e1ca26 delete();
	}
	wait(0.5);
	self.var_9dd10753 rotatepitch(-95, 2, 0, 0.6666667);
	self.var_9dd10753 playsound(#"hash_1cfa90c531f36b92");
	self.var_9dd10753 waittill(#"rotatedone");
	self.e_weapon movez(24, 2);
	self.e_weapon waittill(#"movedone");
	self.e_weapon namespace_3263198e::function_dfa12910(getweapon("thundergun"), &function_3e185177);
}

/*
	Name: function_3e185177
	Namespace: namespace_86eed980
	Checksum: 0xDEDB9ABA
	Offset: 0x23C8
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_3e185177(e_player, var_876ad064)
{
	if(var_876ad064)
	{
		e_player thread namespace_3263198e::function_51b752a9(#"hash_5de2e17b31c4f1fd");
	}
}

/*
	Name: start_challenge
	Namespace: namespace_86eed980
	Checksum: 0x677A7899
	Offset: 0x2410
	Size: 0x20C
	Parameters: 0
	Flags: Linked
*/
function start_challenge()
{
	level endon(#"end_game");
	level.var_b42f4f4b = self;
	var_d6578e1f = self.var_d6578e1f;
	while(level.pablo_npc.isspeaking)
	{
		waitframe(1);
	}
	self.var_a80cd5e8 namespace_509a75d1::function_6a0d675d(var_d6578e1f.str_vox);
	if(getplayers().size <= 2)
	{
		var_d6578e1f.n_goal = var_d6578e1f.var_db4802f2;
	}
	else
	{
		var_d6578e1f.n_goal = var_d6578e1f.var_be570367;
	}
	self function_bce7e59b(var_d6578e1f.n_index, var_d6578e1f.n_current_progress, var_d6578e1f.n_goal);
	playsoundatposition(#"hash_405121518503e4be", self.origin);
	self thread [[var_d6578e1f.func_setup]]();
	var_d6578e1f waittill(var_d6578e1f.str_notify);
	self [[var_d6578e1f.var_383f77fa]]();
	self function_616536b0();
	var_d6578e1f function_11001794();
	playsoundatposition(#"hash_466258346cb15bf5", self.origin);
	if(var_d6578e1f.var_f2e7f46a)
	{
		self function_9e87f32a();
	}
	else
	{
		self function_98233b53();
	}
	self function_1525b94c();
}

/*
	Name: function_616536b0
	Namespace: namespace_86eed980
	Checksum: 0x65233DE5
	Offset: 0x2628
	Size: 0x60
	Parameters: 0
	Flags: Linked
*/
function function_616536b0()
{
	self.var_53b4b2f6 showpart("tag_bulb_on_" + self.var_6c841cf);
	self.var_53b4b2f6 hidepart("tag_bulb_off_" + self.var_6c841cf);
	self.var_6c841cf++;
}

/*
	Name: function_658f9053
	Namespace: namespace_86eed980
	Checksum: 0x6EB16963
	Offset: 0x2690
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_658f9053()
{
	level endon(#"end_game");
	callback::on_ai_killed(&function_1fdda3c7);
}

/*
	Name: function_5ba49bb9
	Namespace: namespace_86eed980
	Checksum: 0xC8F1074F
	Offset: 0x26D8
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_5ba49bb9()
{
	level endon(#"end_game");
	callback::remove_on_ai_killed(&function_1fdda3c7);
}

/*
	Name: function_b1c46dce
	Namespace: namespace_86eed980
	Checksum: 0xC15728AC
	Offset: 0x2720
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_b1c46dce()
{
	level endon(#"end_game");
	self.var_d6578e1f thread function_abec537();
}

/*
	Name: function_b0d19ce9
	Namespace: namespace_86eed980
	Checksum: 0x53DBE2E1
	Offset: 0x2760
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function function_b0d19ce9()
{
	level endon(#"end_game");
}

/*
	Name: function_e960fbf3
	Namespace: namespace_86eed980
	Checksum: 0xC78B448C
	Offset: 0x2788
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_e960fbf3()
{
	level endon(#"end_game");
	var_d6578e1f = self.var_d6578e1f;
	var_3d297ffb = var_d6578e1f.var_3d297ffb;
	var_d6578e1f function_5ba54739(var_d6578e1f.var_1d3eddd0, var_3d297ffb);
	var_d6578e1f function_5ba54739(var_d6578e1f.var_4b11b975, var_3d297ffb);
	var_d6578e1f function_5ba54739(var_d6578e1f.var_f99e168f, var_3d297ffb);
}

/*
	Name: function_35f6e838
	Namespace: namespace_86eed980
	Checksum: 0xB166682F
	Offset: 0x2840
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function function_35f6e838()
{
	level endon(#"end_game");
}

/*
	Name: function_63ed3839
	Namespace: namespace_86eed980
	Checksum: 0x45A40EF6
	Offset: 0x2868
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function function_63ed3839()
{
	level endon(#"end_game");
	self.var_d6578e1f.var_4220f02a = array(getweapon(#"launcher_standard_t8"), getweapon(#"tundragun"));
	foreach(e_player in getplayers())
	{
		e_player thread function_ffe9eab7(self.var_d6578e1f);
	}
	callback::on_ai_killed(&function_1fdda3c7);
}

/*
	Name: function_d9dffba1
	Namespace: namespace_86eed980
	Checksum: 0xE8ACD9CD
	Offset: 0x2998
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_d9dffba1()
{
	level endon(#"end_game");
	callback::remove_on_ai_killed(&function_1fdda3c7);
}

/*
	Name: function_6d225067
	Namespace: namespace_86eed980
	Checksum: 0x8F625CBD
	Offset: 0x29E0
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_6d225067()
{
	level endon(#"end_game");
	callback::on_ai_killed(&function_1fdda3c7);
}

/*
	Name: function_6d50f216
	Namespace: namespace_86eed980
	Checksum: 0xA3628771
	Offset: 0x2A28
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_6d50f216()
{
	level endon(#"end_game");
	callback::remove_on_ai_killed(&function_1fdda3c7);
}

/*
	Name: function_2ae162bf
	Namespace: namespace_86eed980
	Checksum: 0xDE36E564
	Offset: 0x2A70
	Size: 0x1C4
	Parameters: 0
	Flags: Linked
*/
function function_2ae162bf()
{
	level endon(#"end_game");
	level flag::set(#"hash_84593b9650c7abf");
	var_d6578e1f = self.var_d6578e1f;
	foreach(var_aec444a in var_d6578e1f.var_607e76b3)
	{
		var_aec444a zm_unitrigger::create(&function_79884a9c, 64);
		var_aec444a thread function_2fc4d208(var_d6578e1f);
	}
	var_d6578e1f thread function_e845253b();
	var_d6578e1f.var_db24b7da = struct::get("soup_ingredient_dropoff", "targetname");
	var_d6578e1f.var_db24b7da zm_unitrigger::create(&function_7327ab9f, 64);
	var_d6578e1f.var_db24b7da thread function_4ab0f49a(var_d6578e1f);
	var_d6578e1f.var_735249ac = getent("soup_pot", "targetname");
	var_d6578e1f.var_735249ac thread function_48f86741(var_d6578e1f);
}

/*
	Name: function_1de4dc2b
	Namespace: namespace_86eed980
	Checksum: 0xA20D9AAE
	Offset: 0x2C40
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_1de4dc2b()
{
	level endon(#"end_game");
	var_d6578e1f = self.var_d6578e1f;
	var_db24b7da = var_d6578e1f.var_db24b7da;
	var_db24b7da zm_unitrigger::unregister_unitrigger(var_db24b7da.s_unitrigger);
	var_735249ac = var_d6578e1f.var_735249ac;
	var_735249ac setcandamage(0);
	var_735249ac val::reset("challenges", "allowdeath");
}

/*
	Name: function_f0f0f5f3
	Namespace: namespace_86eed980
	Checksum: 0x35C01C84
	Offset: 0x2D08
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_f0f0f5f3()
{
	level endon(#"end_game");
	callback::on_ai_killed(&function_1fdda3c7);
}

/*
	Name: function_20f477f2
	Namespace: namespace_86eed980
	Checksum: 0x7475D6A2
	Offset: 0x2D50
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_20f477f2()
{
	level endon(#"end_game");
	callback::remove_on_ai_killed(&function_1fdda3c7);
}

/*
	Name: function_8885885d
	Namespace: namespace_86eed980
	Checksum: 0x1970EB98
	Offset: 0x2D98
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_8885885d()
{
	level endon(#"end_game");
	self.var_d6578e1f function_f363530e();
}

/*
	Name: function_b0848cf7
	Namespace: namespace_86eed980
	Checksum: 0xF30B793A
	Offset: 0x2DD8
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function function_b0848cf7()
{
	level endon(#"end_game");
}

/*
	Name: function_39ca7654
	Namespace: namespace_86eed980
	Checksum: 0xEDB81750
	Offset: 0x2E00
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_39ca7654()
{
	level endon(#"end_game");
	self.var_5ac3d786 = 0;
	self.var_d6578e1f.var_2abe7ecb = getentarray("challenges_bell", "targetname");
	var_2abe7ecb = self.var_d6578e1f.var_2abe7ecb;
	self.var_d6578e1f function_3bb5cdd9(self);
	level flag::set(#"hash_4a8105909cc2603d");
}

/*
	Name: function_a0ebbf07
	Namespace: namespace_86eed980
	Checksum: 0x171C68C8
	Offset: 0x2EB8
	Size: 0xC8
	Parameters: 0
	Flags: Linked
*/
function function_a0ebbf07()
{
	level endon(#"end_game");
	level flag::clear(#"hash_4a8105909cc2603d");
	foreach(var_c3e20cb in self.var_d6578e1f.var_2abe7ecb)
	{
		var_c3e20cb val::reset("challenges", "allowdeath");
	}
}

/*
	Name: function_6384ebfd
	Namespace: namespace_86eed980
	Checksum: 0xB708B57E
	Offset: 0x2F88
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_6384ebfd()
{
	level endon(#"end_game");
	self.var_d6578e1f thread function_1417e75b();
	callback::on_ai_killed(&function_1fdda3c7);
}

/*
	Name: function_fd31e27b
	Namespace: namespace_86eed980
	Checksum: 0x120A6B30
	Offset: 0x2FE8
	Size: 0xD8
	Parameters: 0
	Flags: Linked
*/
function function_fd31e27b()
{
	level endon(#"end_game");
	callback::remove_on_ai_killed(&function_1fdda3c7);
	var_cbb3defa = getentarray("brain_item_drop", "targetname");
	foreach(var_1e43a31e in var_cbb3defa)
	{
		var_1e43a31e namespace_2e9c09b3::function_d6812b9d();
	}
}

/*
	Name: function_6639d547
	Namespace: namespace_86eed980
	Checksum: 0x39466E6B
	Offset: 0x30C8
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_6639d547()
{
	level endon(#"end_game");
	callback::on_ai_killed(&function_1fdda3c7);
}

/*
	Name: function_50961fa5
	Namespace: namespace_86eed980
	Checksum: 0x741C3D8
	Offset: 0x3110
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_50961fa5()
{
	level endon(#"end_game");
	callback::remove_on_ai_killed(&function_1fdda3c7);
}

/*
	Name: function_bb6ca008
	Namespace: namespace_86eed980
	Checksum: 0x59104406
	Offset: 0x3158
	Size: 0x2C8
	Parameters: 0
	Flags: Linked
*/
function function_bb6ca008()
{
	level endon(#"end_game");
	foreach(e_player in getplayers())
	{
		e_player thread function_ffe9eab7(self.var_d6578e1f);
	}
	self.var_d6578e1f.var_cfff7c87 = struct::get("piss_bottles_pickup", "targetname");
	var_cfff7c87 = self.var_d6578e1f.var_cfff7c87;
	var_cfff7c87 zm_unitrigger::create(&function_753b9012, 96);
	var_cfff7c87 thread function_c607ac40(self.var_d6578e1f);
	self.var_d6578e1f.var_c0620ae0 = struct::get_array("piss_bottles_dropoff", "targetname");
	var_c0620ae0 = self.var_d6578e1f.var_c0620ae0;
	if(var_c0620ae0.size > 1)
	{
		foreach(var_b5b189cd in var_c0620ae0)
		{
			var_b5b189cd zm_unitrigger::create(&function_88d98fce, 256);
			var_b5b189cd thread function_3fbb4390(self.var_d6578e1f);
		}
	}
	else
	{
		foreach(var_b5b189cd in var_c0620ae0)
		{
			var_b5b189cd zm_unitrigger::create("", 1256);
			var_b5b189cd thread function_3fbb4390(self.var_d6578e1f);
		}
	}
}

/*
	Name: function_a9598dd1
	Namespace: namespace_86eed980
	Checksum: 0xDC2135
	Offset: 0x3428
	Size: 0xE8
	Parameters: 0
	Flags: Linked
*/
function function_a9598dd1()
{
	level endon(#"end_game");
	var_cfff7c87 = self.var_d6578e1f.var_cfff7c87;
	var_cfff7c87 zm_unitrigger::unregister_unitrigger(var_cfff7c87.s_unitrigger);
	var_c0620ae0 = self.var_d6578e1f.var_c0620ae0;
	foreach(var_b5b189cd in var_c0620ae0)
	{
		var_b5b189cd zm_unitrigger::unregister_unitrigger(var_b5b189cd.s_unitrigger);
	}
}

/*
	Name: function_b40fed60
	Namespace: namespace_86eed980
	Checksum: 0xA2EF4E87
	Offset: 0x3518
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_b40fed60()
{
	level endon(#"end_game");
	self.var_d6578e1f thread function_ce8060cc();
}

/*
	Name: function_a4b66a2b
	Namespace: namespace_86eed980
	Checksum: 0x330CACA8
	Offset: 0x3558
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function function_a4b66a2b()
{
	level endon(#"end_game");
}

/*
	Name: function_5c8b1a9a
	Namespace: namespace_86eed980
	Checksum: 0xC38D5FF6
	Offset: 0x3580
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_5c8b1a9a()
{
	level endon(#"end_game");
	callback::on_ai_killed(&function_1fdda3c7);
}

/*
	Name: function_7d030c3d
	Namespace: namespace_86eed980
	Checksum: 0xE589E4F5
	Offset: 0x35C8
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_7d030c3d()
{
	level endon(#"end_game");
	callback::remove_on_ai_killed(&function_1fdda3c7);
}

/*
	Name: function_a36ace8b
	Namespace: namespace_86eed980
	Checksum: 0xCA0BF19
	Offset: 0x3610
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_a36ace8b()
{
	level endon(#"end_game");
	self.var_d6578e1f thread function_a0ce7b0f();
}

/*
	Name: function_6884e5b8
	Namespace: namespace_86eed980
	Checksum: 0x1DF99CFA
	Offset: 0x3650
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_6884e5b8()
{
	level endon(#"end_game");
	self.var_d6578e1f function_8288a87();
}

/*
	Name: function_a0ce7b0f
	Namespace: namespace_86eed980
	Checksum: 0x98D08DF6
	Offset: 0x3690
	Size: 0x184
	Parameters: 0
	Flags: Linked
*/
function function_a0ce7b0f()
{
	self.var_1ef4f1fa = getent("whack_a_mole_start", "targetname");
	var_1ef4f1fa = self.var_1ef4f1fa;
	self.var_975e7731 = getentarray("whack_a_mole_target", "targetname");
	foreach(var_deeb8287 in self.var_975e7731)
	{
		var_deeb8287.s_challenge = self;
		var_deeb8287.var_107ca298 = var_deeb8287.origin;
		var_deeb8287.var_5287d229 = var_deeb8287.angles;
		var_deeb8287.var_4e749208 = var_deeb8287.var_107ca298 + vectorscale((0, 0, 1), 56);
	}
	var_1ef4f1fa setcandamage(1);
	var_1ef4f1fa val::set("challenges", "allowdeath", 0);
	var_1ef4f1fa thread function_ac0ece26(self);
}

/*
	Name: function_ac0ece26
	Namespace: namespace_86eed980
	Checksum: 0xA5AB2538
	Offset: 0x3820
	Size: 0xFA
	Parameters: 1
	Flags: Linked
*/
function function_ac0ece26(var_d6578e1f)
{
	level endon(#"end_game");
	var_d6578e1f endon(var_d6578e1f.str_notify);
	self notify("1c28e592c6826d46");
	self endon("1c28e592c6826d46");
	while(true)
	{
		s_params = undefined;
		s_params = self waittill(#"damage");
		if(namespace_3263198e::function_fe8ee9f0(s_params.weapon, 0))
		{
			self setcandamage(0);
			self val::reset("challenges", "allowdeath");
			var_d6578e1f thread function_4ce023ff();
			return;
		}
	}
}

/*
	Name: function_4ce023ff
	Namespace: namespace_86eed980
	Checksum: 0xE0F1F5B7
	Offset: 0x3928
	Size: 0x184
	Parameters: 0
	Flags: Linked
*/
function function_4ce023ff()
{
	level endon(#"end_game");
	self endon(self.str_notify, #"hash_1a4fcb205b5695b5");
	self.var_49201a73 = 1;
	foreach(e_target in self.var_975e7731)
	{
		e_target setcandamage(1);
		e_target val::set("challenges", "allowdeath", 0);
	}
	if(self.n_current_progress === 0)
	{
		self function_1e4147b3(5, 3);
		wait(5);
	}
	if(self.n_current_progress === 1)
	{
		self function_1e4147b3(10, 2.75);
		wait(5);
	}
	if(self.n_current_progress === 2)
	{
		self function_1e4147b3(15, 2.5);
	}
}

/*
	Name: function_1e4147b3
	Namespace: namespace_86eed980
	Checksum: 0xBCF3E3B9
	Offset: 0x3AB8
	Size: 0x1D4
	Parameters: 2
	Flags: Linked
*/
function function_1e4147b3(var_a5d77ed0, var_a5bc211a)
{
	level endon(#"end_game");
	self endon(self.str_notify, #"hash_1a4fcb205b5695b5");
	if(getplayers().size <= 2)
	{
		self.var_8aa74ff0 = 6;
	}
	else
	{
		self.var_8aa74ff0 = 4;
	}
	var_77ba553d = 0;
	self.var_d71fc7c = 0;
	while(var_77ba553d < var_a5d77ed0)
	{
		b_success = 0;
		wait(var_a5bc211a);
		while(!b_success)
		{
			e_target = array::random(self.var_975e7731);
			if(!isdefined(e_target.var_ecea777a) || !e_target.var_ecea777a)
			{
				b_success = 1;
				e_target.var_ecea777a = 1;
				var_77ba553d++;
				e_target thread function_8645fbe7(self);
				e_target moveto(e_target.var_4e749208, 0.35);
				e_target waittill(#"movedone");
				e_target thread function_a80a048d(self);
			}
		}
	}
	while(self.var_d71fc7c < var_a5d77ed0)
	{
		waitframe(1);
	}
	self function_eaf6e39e();
}

/*
	Name: function_8288a87
	Namespace: namespace_86eed980
	Checksum: 0x38695F58
	Offset: 0x3C98
	Size: 0x108
	Parameters: 0
	Flags: Linked
*/
function function_8288a87()
{
	level endon(#"end_game");
	foreach(var_deeb8287 in self.var_975e7731)
	{
		if(var_deeb8287.var_ecea777a === 1)
		{
			var_deeb8287 moveto(var_deeb8287.var_107ca298, 0.1);
			var_deeb8287 rotateto(var_deeb8287.var_5287d229, 0.1);
			var_deeb8287.var_ecea777a = 0;
			var_deeb8287 waittill(#"movedone");
		}
	}
}

/*
	Name: function_a80a048d
	Namespace: namespace_86eed980
	Checksum: 0xC457B830
	Offset: 0x3DA8
	Size: 0x110
	Parameters: 1
	Flags: Linked
*/
function function_a80a048d(s_challenge)
{
	level endon(#"end_game");
	self endon(#"hash_759e710e575d89bb");
	s_challenge endon(#"hash_1a4fcb205b5695b5", s_challenge.str_notify);
	wait(0.5);
	self rotateyaw(360, s_challenge.var_8aa74ff0 - 1);
	self waittill(#"rotatedone");
	wait(0.5);
	if(isdefined(s_challenge.var_49201a73) && s_challenge.var_49201a73)
	{
		s_challenge.var_49201a73 = 0;
		s_challenge thread function_b0770e43();
	}
	self notify(#"hash_1a4fcb205b5695b5");
	s_challenge notify(#"hash_1a4fcb205b5695b5");
}

/*
	Name: function_b0770e43
	Namespace: namespace_86eed980
	Checksum: 0xDEBD28D6
	Offset: 0x3EC0
	Size: 0x16C
	Parameters: 0
	Flags: Linked
*/
function function_b0770e43()
{
	self thread function_8288a87();
	if(math::cointoss(50))
	{
		a_e_players = array::randomize(getplayers());
		foreach(e_player in a_e_players)
		{
			if(!e_player util::function_bf5a8f5c())
			{
				e_player thread namespace_3263198e::function_51b752a9(#"vox_generic_responses_negative");
				break;
			}
		}
	}
	var_1ef4f1fa = self.var_1ef4f1fa;
	var_1ef4f1fa setcandamage(1);
	var_1ef4f1fa val::set("challenges", "allowdeath", 0);
	var_1ef4f1fa thread function_ac0ece26(self);
}

/*
	Name: function_8645fbe7
	Namespace: namespace_86eed980
	Checksum: 0x6D34744D
	Offset: 0x4038
	Size: 0x12C
	Parameters: 1
	Flags: Linked
*/
function function_8645fbe7(s_challenge)
{
	level endon(#"end_game");
	self endon(#"hash_1a4fcb205b5695b5");
	s_challenge endon(s_challenge.str_notify);
	while(true)
	{
		s_params = undefined;
		s_params = self waittill(#"damage");
		if(namespace_3263198e::function_fe8ee9f0(s_params.weapon, 0))
		{
			self moveto(self.var_107ca298, 0.1);
			self rotateto(self.var_5287d229, 0.1);
			self.var_ecea777a = 0;
			s_challenge.var_d71fc7c++;
			self waittill(#"movedone");
			self notify(#"hash_759e710e575d89bb");
			return;
		}
	}
}

/*
	Name: function_33f591cf
	Namespace: namespace_86eed980
	Checksum: 0x59BDA882
	Offset: 0x4170
	Size: 0x3EC
	Parameters: 0
	Flags: Linked
*/
function function_33f591cf()
{
	s_challenge = self.var_12080390[2];
	var_dd80e9d = getentarray("sos_snowball", "targetname");
	s_challenge.var_1d3eddd0 = [];
	s_challenge.var_4b11b975 = [];
	s_challenge.var_f99e168f = [];
	foreach(var_a64b34d1 in var_dd80e9d)
	{
		if(var_a64b34d1.script_int === 0)
		{
			if(!isdefined(s_challenge.var_1d3eddd0))
			{
				s_challenge.var_1d3eddd0 = [];
			}
			else if(!isarray(s_challenge.var_1d3eddd0))
			{
				s_challenge.var_1d3eddd0 = array(s_challenge.var_1d3eddd0);
			}
			s_challenge.var_1d3eddd0[s_challenge.var_1d3eddd0.size] = var_a64b34d1;
			continue;
		}
		if(var_a64b34d1.script_int === 1)
		{
			if(!isdefined(s_challenge.var_4b11b975))
			{
				s_challenge.var_4b11b975 = [];
			}
			else if(!isarray(s_challenge.var_4b11b975))
			{
				s_challenge.var_4b11b975 = array(s_challenge.var_4b11b975);
			}
			s_challenge.var_4b11b975[s_challenge.var_4b11b975.size] = var_a64b34d1;
			continue;
		}
		if(!isdefined(s_challenge.var_f99e168f))
		{
			s_challenge.var_f99e168f = [];
		}
		else if(!isarray(s_challenge.var_f99e168f))
		{
			s_challenge.var_f99e168f = array(s_challenge.var_f99e168f);
		}
		s_challenge.var_f99e168f[s_challenge.var_f99e168f.size] = var_a64b34d1;
	}
	s_challenge.var_d9226626 = 0;
	s_challenge.var_f5b2caa6 = 0;
	s_challenge.var_1755f412 = 0;
	s_challenge.var_1d3eddd0 = array::randomize(s_challenge.var_1d3eddd0);
	s_challenge.var_4b11b975 = array::randomize(s_challenge.var_4b11b975);
	s_challenge.var_f99e168f = array::randomize(s_challenge.var_f99e168f);
	if(getplayers().size <= 2)
	{
		s_challenge.var_3d297ffb = 4;
	}
	else
	{
		s_challenge.var_3d297ffb = 6;
	}
	var_3d297ffb = s_challenge.var_3d297ffb;
	function_577eae5d(s_challenge.var_1d3eddd0, var_3d297ffb);
	function_577eae5d(s_challenge.var_4b11b975, var_3d297ffb);
	function_577eae5d(s_challenge.var_f99e168f, var_3d297ffb);
}

/*
	Name: function_577eae5d
	Namespace: namespace_86eed980
	Checksum: 0x228BED9
	Offset: 0x4568
	Size: 0xBA
	Parameters: 2
	Flags: Linked
*/
function function_577eae5d(var_dd80e9d, var_e205c5f3)
{
	var_588c71ce = 0;
	foreach(var_a64b34d1 in var_dd80e9d)
	{
		if(var_588c71ce < var_e205c5f3)
		{
			var_a64b34d1 hide();
			var_588c71ce++;
			continue;
		}
		var_a64b34d1.var_518da2ac = 1;
	}
}

/*
	Name: function_5ba54739
	Namespace: namespace_86eed980
	Checksum: 0x67FBDC53
	Offset: 0x4630
	Size: 0xE8
	Parameters: 2
	Flags: Linked
*/
function function_5ba54739(var_dd80e9d, var_e205c5f3)
{
	foreach(var_a64b34d1 in var_dd80e9d)
	{
		if(isdefined(var_a64b34d1) && !isdefined(var_a64b34d1.var_518da2ac))
		{
			var_a64b34d1 setcandamage(1);
			var_a64b34d1 val::set("challenges", "allowdeath", 0);
			var_a64b34d1 thread function_89754c19(self);
		}
	}
}

/*
	Name: function_89754c19
	Namespace: namespace_86eed980
	Checksum: 0x305DF385
	Offset: 0x4720
	Size: 0x1FE
	Parameters: 1
	Flags: Linked
*/
function function_89754c19(var_d6578e1f)
{
	level endon(#"end_game");
	self endon(#"death");
	var_d6578e1f endon(var_d6578e1f.str_notify);
	while(true)
	{
		s_params = undefined;
		s_params = self waittill(#"damage");
		if(namespace_3263198e::function_fe8ee9f0(s_params.weapon, 0))
		{
			self show();
			if(self.script_int === 0)
			{
				var_d6578e1f.var_d9226626++;
				if(var_d6578e1f.var_d9226626 >= var_d6578e1f.var_3d297ffb)
				{
					var_d6578e1f.n_current_progress++;
				}
			}
			else if(self.script_int === 1)
			{
				var_d6578e1f.var_f5b2caa6++;
				if(var_d6578e1f.var_f5b2caa6 >= var_d6578e1f.var_3d297ffb)
				{
					var_d6578e1f.n_current_progress++;
				}
			}
			else
			{
				var_d6578e1f.var_1755f412++;
				if(var_d6578e1f.var_1755f412 >= var_d6578e1f.var_3d297ffb)
				{
					var_d6578e1f.n_current_progress++;
				}
			}
			self setcandamage(0);
			self val::reset("challenges", "allowdeath");
			var_d6578e1f function_544b63c0(var_d6578e1f.n_current_progress);
			if(var_d6578e1f.n_current_progress >= var_d6578e1f.n_goal)
			{
				var_d6578e1f notify(var_d6578e1f.str_notify);
			}
			return;
		}
	}
}

/*
	Name: function_dfeb1c1b
	Namespace: namespace_86eed980
	Checksum: 0x8FFD931E
	Offset: 0x4928
	Size: 0x568
	Parameters: 0
	Flags: Linked
*/
function function_dfeb1c1b()
{
	var_7176f841 = struct::get_array("pablo_soup_ingredients", "targetname");
	var_6c4044e9 = [];
	var_1b3c29a5 = [];
	var_82471d54 = [];
	foreach(var_33e4d4f0 in var_7176f841)
	{
		if(var_33e4d4f0.script_string === "meats")
		{
			if(!isdefined(var_6c4044e9))
			{
				var_6c4044e9 = [];
			}
			else if(!isarray(var_6c4044e9))
			{
				var_6c4044e9 = array(var_6c4044e9);
			}
			var_6c4044e9[var_6c4044e9.size] = var_33e4d4f0;
			continue;
		}
		if(var_33e4d4f0.script_string === "spices")
		{
			if(!isdefined(var_1b3c29a5))
			{
				var_1b3c29a5 = [];
			}
			else if(!isarray(var_1b3c29a5))
			{
				var_1b3c29a5 = array(var_1b3c29a5);
			}
			var_1b3c29a5[var_1b3c29a5.size] = var_33e4d4f0;
			continue;
		}
		if(!isdefined(var_82471d54))
		{
			var_82471d54 = [];
		}
		else if(!isarray(var_82471d54))
		{
			var_82471d54 = array(var_82471d54);
		}
		var_82471d54[var_82471d54.size] = var_33e4d4f0;
	}
	self.var_607e76b3 = [];
	var_b6ab43e5 = array::random(var_6c4044e9);
	if(!isdefined(self.var_607e76b3))
	{
		self.var_607e76b3 = [];
	}
	else if(!isarray(self.var_607e76b3))
	{
		self.var_607e76b3 = array(self.var_607e76b3);
	}
	self.var_607e76b3[self.var_607e76b3.size] = var_b6ab43e5;
	arrayremovevalue(var_6c4044e9, var_b6ab43e5);
	var_53608130 = array::random(var_1b3c29a5);
	if(!isdefined(self.var_607e76b3))
	{
		self.var_607e76b3 = [];
	}
	else if(!isarray(self.var_607e76b3))
	{
		self.var_607e76b3 = array(self.var_607e76b3);
	}
	self.var_607e76b3[self.var_607e76b3.size] = var_53608130;
	arrayremovevalue(var_1b3c29a5, var_53608130);
	var_dfc450a7 = array::random(var_82471d54);
	if(!isdefined(self.var_607e76b3))
	{
		self.var_607e76b3 = [];
	}
	else if(!isarray(self.var_607e76b3))
	{
		self.var_607e76b3 = array(self.var_607e76b3);
	}
	self.var_607e76b3[self.var_607e76b3.size] = var_dfc450a7;
	arrayremovevalue(var_82471d54, var_dfc450a7);
	foreach(var_aec444a in self.var_607e76b3)
	{
		var_aec444a.var_12e6af58 = getent(var_aec444a.target, "targetname");
	}
	var_d74bb24 = [];
	var_d74bb24 = arraycombine(var_6c4044e9, var_1b3c29a5, 1, 0);
	var_d74bb24 = arraycombine(var_d74bb24, var_82471d54, 1, 0);
	foreach(var_aec444a in var_d74bb24)
	{
		var_12e6af58 = getent(var_aec444a.target, "targetname");
		var_12e6af58 delete();
	}
}

/*
	Name: function_79884a9c
	Namespace: namespace_86eed980
	Checksum: 0xF51A81FD
	Offset: 0x4E98
	Size: 0x60
	Parameters: 1
	Flags: Linked
*/
function function_79884a9c(e_player)
{
	str_hint = zm_utility::function_d6046228(#"hash_1b00229a5eb94332", #"hash_48b4d710bb0a2406");
	self sethintstring(str_hint);
	return 1;
}

/*
	Name: function_2fc4d208
	Namespace: namespace_86eed980
	Checksum: 0xE3D6CFD6
	Offset: 0x4F00
	Size: 0x12C
	Parameters: 1
	Flags: Linked
*/
function function_2fc4d208(s_challenge)
{
	level endon(#"end_game");
	s_challenge endon(s_challenge.str_notify);
	var_88706ea7 = undefined;
	var_88706ea7 = self waittill(#"trigger_activated");
	e_who = var_88706ea7.e_who;
	playsoundatposition(#"hash_4b33537532733659", self.origin);
	e_who thread zm_audio::create_and_play_dialog(#"challenge", #"pickup_generic");
	self.var_12e6af58 delete();
	if(!isdefined(s_challenge.var_e9a74caf))
	{
		s_challenge.var_e9a74caf = 0;
	}
	s_challenge.var_e9a74caf++;
	self zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
}

/*
	Name: function_e845253b
	Namespace: namespace_86eed980
	Checksum: 0xB67164C
	Offset: 0x5038
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_e845253b()
{
	level endon(#"end_game");
	self endon(self.str_notify);
	while(true)
	{
		if(isdefined(self.var_e9a74caf) && self.var_e9a74caf >= 3)
		{
			self.n_current_progress++;
			self function_544b63c0(self.n_current_progress);
			return;
		}
		wait(0.1);
	}
}

/*
	Name: function_7327ab9f
	Namespace: namespace_86eed980
	Checksum: 0x31E365C8
	Offset: 0x50C8
	Size: 0x138
	Parameters: 1
	Flags: Linked
*/
function function_7327ab9f(e_player)
{
	if(level flag::get(#"hash_743092bcb25effda"))
	{
		return 0;
	}
	if(isdefined(level.var_97a44fdd) && isdefined(level.var_97a44fdd.var_d6578e1f))
	{
		s_challenge = level.var_97a44fdd.var_d6578e1f;
	}
	else
	{
		self sethintstring("");
		return 1;
	}
	if(isdefined(s_challenge.var_e9a74caf) && s_challenge.var_e9a74caf >= 3)
	{
		str_hint = zm_utility::function_d6046228(#"hash_1d0e45476161abb0", #"hash_25488a48dddb319c");
		self sethintstring(str_hint);
		return 1;
	}
	self sethintstring("");
	return 1;
}

/*
	Name: function_4ab0f49a
	Namespace: namespace_86eed980
	Checksum: 0x6A02F1C3
	Offset: 0x5208
	Size: 0x192
	Parameters: 1
	Flags: Linked
*/
function function_4ab0f49a(var_d6578e1f)
{
	level endon(#"end_game");
	var_d6578e1f endon(var_d6578e1f.str_notify);
	while(true)
	{
		self waittill(#"trigger_activated");
		if(level flag::get(#"hash_743092bcb25effda"))
		{
			continue;
		}
		if(!isdefined(var_d6578e1f.var_e9a74caf))
		{
			var_d6578e1f.var_e9a74caf = 0;
		}
		if(var_d6578e1f.var_e9a74caf >= 3)
		{
			playsoundatposition(#"hash_45b15e2671c49618", self.origin);
			var_d6578e1f.n_current_progress++;
			var_d6578e1f function_544b63c0(var_d6578e1f.n_current_progress);
			var_d6578e1f.var_735249ac setmodel("p8_zm_ora_kitchenware_soup_pot");
			if(var_d6578e1f.n_current_progress >= var_d6578e1f.n_goal)
			{
				var_d6578e1f thread function_65a629f5();
				var_d6578e1f notify(var_d6578e1f.str_notify);
			}
			self zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
			return;
		}
	}
}

/*
	Name: function_65a629f5
	Namespace: namespace_86eed980
	Checksum: 0x1C65E5B9
	Offset: 0x53A8
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_65a629f5()
{
	level endon(#"end_game");
	while(zm_zonemgr::any_player_in_zone("forecastle"))
	{
		waitframe(1);
	}
	self.var_735249ac setmodel("p8_cas_kitchenware_soup_pot");
	level flag::clear(#"hash_84593b9650c7abf");
}

/*
	Name: function_48f86741
	Namespace: namespace_86eed980
	Checksum: 0xB537A42D
	Offset: 0x5438
	Size: 0x17A
	Parameters: 1
	Flags: Linked
*/
function function_48f86741(var_d6578e1f)
{
	var_d6578e1f endon(var_d6578e1f.str_notify);
	self endon(#"delete");
	self setcandamage(1);
	self val::set("challenges", "allowdeath", 0);
	while(true)
	{
		s_params = undefined;
		s_params = self waittill(#"damage");
		if(namespace_3263198e::function_fe8ee9f0(s_params.weapon) && !level flag::get(#"hash_743092bcb25effda"))
		{
			var_d6578e1f.n_current_progress++;
			var_d6578e1f function_544b63c0(var_d6578e1f.n_current_progress);
			if(var_d6578e1f.n_current_progress >= var_d6578e1f.n_goal)
			{
				var_d6578e1f.var_735249ac setmodel("p8_zm_ora_kitchenware_soup_pot");
				var_d6578e1f thread function_65a629f5();
				var_d6578e1f notify(var_d6578e1f.str_notify);
			}
			return;
		}
	}
}

/*
	Name: function_be80cd37
	Namespace: namespace_86eed980
	Checksum: 0xFD57408
	Offset: 0x55C0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_be80cd37()
{
	var_b9e7250b = self.var_12080390[2];
	var_b9e7250b function_dfeb1c1b();
}

/*
	Name: function_753b9012
	Namespace: namespace_86eed980
	Checksum: 0xAAA849BB
	Offset: 0x5600
	Size: 0x90
	Parameters: 1
	Flags: Linked
*/
function function_753b9012(e_player)
{
	if(!isdefined(e_player.var_77d7715a) || !e_player.var_77d7715a)
	{
		str_hint = zm_utility::function_d6046228(#"hash_2ce0613217a0bac4", #"hash_21b8b8c46271e228");
		self sethintstring(str_hint);
		return 1;
	}
	return 0;
}

/*
	Name: function_c607ac40
	Namespace: namespace_86eed980
	Checksum: 0x27B570F7
	Offset: 0x56A0
	Size: 0x138
	Parameters: 1
	Flags: Linked
*/
function function_c607ac40(var_d6578e1f)
{
	level endon(#"end_game");
	var_d6578e1f endon(var_d6578e1f.str_notify);
	self.var_5637fcf9 = 0;
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"trigger_activated");
		e_who = var_be17187b.e_who;
		if(!isdefined(e_who.var_77d7715a) || !e_who.var_77d7715a)
		{
			e_who playsound(#"hash_2814441619ec7760");
			if(!self.var_5637fcf9)
			{
				self.var_5637fcf9 = 1;
				e_who thread function_10e9c8b5();
			}
			e_who.var_77d7715a = 1;
			e_who thread function_f1da3c8(var_d6578e1f);
			e_who thread function_f6ccb39(var_d6578e1f);
		}
	}
}

/*
	Name: function_88d98fce
	Namespace: namespace_86eed980
	Checksum: 0xB57585B6
	Offset: 0x57E0
	Size: 0xEE
	Parameters: 1
	Flags: Linked
*/
function function_88d98fce(e_player)
{
	if(isdefined(e_player.var_77d7715a) && e_player.var_77d7715a && e_player zm_zonemgr::get_player_zone() === "beach" && (isdefined(e_player.var_3236cdc2) && e_player.var_3236cdc2))
	{
		str_hint = zm_utility::function_d6046228(#"hash_30d231a12332f5ca", #"hash_5ada8641cf6032ce");
		self sethintstring(str_hint);
		return 1;
	}
	self sethintstring("");
	return 0;
}

/*
	Name: function_3fbb4390
	Namespace: namespace_86eed980
	Checksum: 0x791AA52D
	Offset: 0x58D8
	Size: 0x168
	Parameters: 1
	Flags: Linked
*/
function function_3fbb4390(var_d6578e1f)
{
	level endon(#"end_game");
	var_d6578e1f endon(var_d6578e1f.str_notify);
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"trigger_activated");
		e_who = var_be17187b.e_who;
		if(isdefined(e_who.var_77d7715a) && e_who.var_77d7715a && e_who zm_zonemgr::get_player_zone() === "beach" && (isdefined(e_who.var_3236cdc2) && e_who.var_3236cdc2))
		{
			e_who playsound(#"hash_2ad99bf60d7fe42a");
			e_who notify(#"hash_1ae87f50e75564f3");
			e_who.var_77d7715a = 0;
			if(var_d6578e1f.n_current_progress === 0)
			{
				e_who thread function_77044d02();
			}
			var_d6578e1f function_eaf6e39e();
		}
	}
}

/*
	Name: function_77044d02
	Namespace: namespace_86eed980
	Checksum: 0x1F9FB433
	Offset: 0x5A48
	Size: 0x10A
	Parameters: 0
	Flags: Linked
*/
function function_77044d02()
{
	switch(self namespace_891c9bac::function_82f9bc9f())
	{
		case "marl":
		{
			self thread namespace_509a75d1::function_51b752a9(#"vox_oh_shit", 2);
			break;
		}
		case "mist":
		{
			self thread namespace_509a75d1::function_51b752a9(#"vox_generic_responses_positive", 8);
			break;
		}
		case "russ":
		{
			self thread namespace_509a75d1::function_51b752a9(#"hash_43bbef358d7a1d56", 4);
			break;
		}
		case "stuh":
		{
			self thread namespace_509a75d1::function_51b752a9(#"hash_6ca1deacc4f61926", 4);
			break;
		}
	}
}

/*
	Name: function_10e9c8b5
	Namespace: namespace_86eed980
	Checksum: 0xC9984F2E
	Offset: 0x5B60
	Size: 0x10A
	Parameters: 0
	Flags: Linked
*/
function function_10e9c8b5()
{
	switch(self namespace_891c9bac::function_82f9bc9f())
	{
		case "marl":
		{
			self thread namespace_509a75d1::function_51b752a9(#"hash_5a7e23f64d8bf2d0", 4);
			break;
		}
		case "mist":
		{
			self thread namespace_509a75d1::function_51b752a9(#"hash_43d252dd310e2faa", 4);
			break;
		}
		case "russ":
		{
			self thread namespace_509a75d1::function_51b752a9(#"hash_43d252dd310e2faa", 8);
			break;
		}
		case "stuh":
		{
			self thread namespace_509a75d1::function_51b752a9(#"vox_generic_responses_negative", 4);
			break;
		}
	}
}

/*
	Name: function_f6ccb39
	Namespace: namespace_86eed980
	Checksum: 0x10BFE04A
	Offset: 0x5C78
	Size: 0x150
	Parameters: 1
	Flags: Linked
*/
function function_f6ccb39(s_challenge)
{
	level endon(#"end_game");
	s_challenge endon(s_challenge.str_notify);
	self endon(#"death", #"hash_1ae87f50e75564f3", #"hash_279113df33d9d7fc");
	while(true)
	{
		if(self zm_utility::is_jumping() || self issliding() || self issprinting() || (isdefined(self.laststand) && self.laststand))
		{
			self playsound(#"hash_2fe344cda8a89a7a");
			if(math::cointoss(50))
			{
				self thread namespace_3263198e::function_51b752a9(#"vox_generic_responses_negative");
			}
			self.var_77d7715a = 0;
			self notify(#"hash_279113df33d9d7fc");
		}
		waitframe(1);
	}
}

/*
	Name: function_f1da3c8
	Namespace: namespace_86eed980
	Checksum: 0x2BA19AE6
	Offset: 0x5DD0
	Size: 0xB0
	Parameters: 1
	Flags: Linked
*/
function function_f1da3c8(s_challenge)
{
	level endon(#"end_game");
	s_challenge endon(s_challenge.str_notify);
	self endon(#"death", #"hash_1ae87f50e75564f3", #"hash_279113df33d9d7fc");
	while(true)
	{
		wait(1);
		if(isdefined(self.var_ab5095e1) && self.var_ab5095e1)
		{
			self playsound("zmb_pee_slosh");
		}
	}
}

/*
	Name: function_e12fb431
	Namespace: namespace_86eed980
	Checksum: 0xBA655FC4
	Offset: 0x5E88
	Size: 0x120
	Parameters: 0
	Flags: Linked
*/
function function_e12fb431()
{
	level endon(#"end_game");
	s_challenge = self.var_12080390[2];
	s_challenge.var_2abe7ecb = getentarray("challenges_bell", "targetname");
	foreach(var_c3e20cb in s_challenge.var_2abe7ecb)
	{
		var_c3e20cb setcandamage(1);
		var_c3e20cb val::set("challenges", "allowdeath", 0);
		var_c3e20cb thread function_472fa2ca(s_challenge);
	}
}

/*
	Name: function_3bb5cdd9
	Namespace: namespace_86eed980
	Checksum: 0xBFAA19B8
	Offset: 0x5FB0
	Size: 0x9A
	Parameters: 1
	Flags: Linked
*/
function function_3bb5cdd9(s_challenge_station)
{
	a_n_sequence = array(0, 0, 1, 1, 2, 2, 3, 3);
	a_n_sequence = array::randomize(a_n_sequence);
	self.a_n_sequence = a_n_sequence;
	self function_c40f1feb(s_challenge_station);
	wait(1);
	s_challenge_station.var_5ac3d786 = 1;
}

/*
	Name: function_c40f1feb
	Namespace: namespace_86eed980
	Checksum: 0x830C3541
	Offset: 0x6058
	Size: 0x184
	Parameters: 1
	Flags: Linked
*/
function function_c40f1feb(s_challenge_station)
{
	level endon(#"end_game");
	self endon(self.str_notify);
	a_n_sequence = self.a_n_sequence;
	var_a80cd5e8 = s_challenge_station.var_a80cd5e8;
	var_a80cd5e8.last_vo_played_time = 0;
	for(i = 0; i < 5; i++)
	{
		switch(a_n_sequence[i])
		{
			case 0:
			{
				var_a80cd5e8 zm_audio::do_player_or_npc_playvox(#"hash_2243128c47028806");
				break;
			}
			case 1:
			{
				var_a80cd5e8 zm_audio::do_player_or_npc_playvox(#"hash_60469dfb06e1b418");
				break;
			}
			case 2:
			{
				var_a80cd5e8 zm_audio::do_player_or_npc_playvox(#"hash_6358e1a146400a52");
				break;
			}
			case 3:
			{
				var_a80cd5e8 zm_audio::do_player_or_npc_playvox(#"hash_10d5f47609e63584");
				break;
			}
		}
	}
}

/*
	Name: function_472fa2ca
	Namespace: namespace_86eed980
	Checksum: 0x13185F55
	Offset: 0x61E8
	Size: 0x30E
	Parameters: 1
	Flags: Linked
*/
function function_472fa2ca(s_challenge)
{
	level endon(#"end_game");
	while(true)
	{
		self waittill(#"damage");
		switch(self.script_int)
		{
			case 0:
			{
				var_66bb9366 = #"hash_b2dd9a0b97705ad";
				playsoundatposition(#"hash_23c7abbf9d34bf4a", self.origin);
				break;
			}
			case 1:
			{
				var_66bb9366 = #"hash_53f014fab33492d8";
				playsoundatposition(#"hash_23c7a9bf9d34bbe4", self.origin);
				break;
			}
			case 2:
			{
				var_66bb9366 = #"hash_594894375473c7b";
				playsoundatposition(#"hash_23c7a7bf9d34b87e", self.origin);
				break;
			}
			case 3:
			{
				var_66bb9366 = #"hash_33ce9da949624fae";
				playsoundatposition(#"hash_23c7a5bf9d34b518", self.origin);
				break;
			}
		}
		foreach(e_player in getplayers())
		{
			if(distancesquared(e_player.origin, self.origin) < 6250000)
			{
				e_player thread zm_equipment::show_hint_text(var_66bb9366, 2);
			}
		}
		if(level flag::get(#"hash_4a8105909cc2603d"))
		{
			if(s_challenge.n_current_progress > s_challenge.a_n_sequence.size)
			{
				s_challenge.n_current_progress = s_challenge.a_n_sequence.size;
			}
			if(self.script_int === s_challenge.a_n_sequence[s_challenge.n_current_progress])
			{
				s_challenge function_eaf6e39e();
			}
			else
			{
				s_challenge.n_current_progress = 0;
				s_challenge function_544b63c0(s_challenge.n_current_progress);
			}
		}
		wait(1);
	}
}

/*
	Name: function_f363530e
	Namespace: namespace_86eed980
	Checksum: 0x77D2633E
	Offset: 0x6500
	Size: 0x70
	Parameters: 0
	Flags: Linked
*/
function function_f363530e()
{
	level endon(#"end_game");
	self endon(self.str_notify);
	while(true)
	{
		level waittill(#"hash_36bd057e4aa760bd", #"hash_4904b9ea745d6545");
		self function_eaf6e39e();
	}
}

/*
	Name: function_ce8060cc
	Namespace: namespace_86eed980
	Checksum: 0x16F0A6CF
	Offset: 0x6578
	Size: 0x78
	Parameters: 0
	Flags: Linked
*/
function function_ce8060cc()
{
	level endon(#"end_game");
	self endon(self.str_notify);
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = level waittill(#"hash_1ba786f1661e3817");
		self function_eaf6e39e(var_88706ea7.var_2ef2374);
	}
}

/*
	Name: function_abec537
	Namespace: namespace_86eed980
	Checksum: 0xA077C7F
	Offset: 0x65F8
	Size: 0x78
	Parameters: 0
	Flags: Linked
*/
function function_abec537()
{
	level endon(#"end_game");
	self endon(self.str_notify);
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = level waittill(#"hash_5e2619172b4487dd");
		self function_eaf6e39e(var_88706ea7.n_count);
	}
}

/*
	Name: function_1fdda3c7
	Namespace: namespace_86eed980
	Checksum: 0x6281C325
	Offset: 0x6678
	Size: 0x1C2
	Parameters: 1
	Flags: Linked
*/
function function_1fdda3c7(s_params)
{
	if(!isplayer(s_params.eattacker))
	{
		return;
	}
	var_d6578e1f = level.var_b42f4f4b.var_d6578e1f;
	switch(var_d6578e1f.n_index)
	{
		case 1:
		{
			var_d6578e1f function_a302ccda(s_params);
			break;
		}
		case 4:
		{
			var_d6578e1f function_d06cd5f9(s_params);
			break;
		}
		case 5:
		{
			var_d6578e1f function_d2403e6a(s_params);
			break;
		}
		case 7:
		{
			var_d6578e1f function_a741762f(s_params);
			break;
		}
		case 10:
		{
			var_d6578e1f function_55bd528c(s_params, self);
			break;
		}
		case 11:
		{
			var_d6578e1f function_2d23b317(s_params);
			break;
		}
		case 14:
		{
			var_d6578e1f function_eaf96378(s_params);
			break;
		}
		default:
		{
			break;
		}
	}
}

/*
	Name: function_2d23b317
	Namespace: namespace_86eed980
	Checksum: 0x3A6448CB
	Offset: 0x6848
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_2d23b317(s_params)
{
	if(s_params.weapon.isriotshield && (s_params.smeansofdeath === "MOD_IMPACT" || s_params.smeansofdeath === "MOD_MELEE"))
	{
		self function_eaf6e39e();
	}
}

/*
	Name: function_d06cd5f9
	Namespace: namespace_86eed980
	Checksum: 0xA4927FE
	Offset: 0x68C0
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function function_d06cd5f9(s_params)
{
	if(isdefined(s_params.eattacker.var_ab5095e1) && !s_params.eattacker.var_ab5095e1)
	{
		self function_eaf6e39e();
	}
}

/*
	Name: function_ffe9eab7
	Namespace: namespace_86eed980
	Checksum: 0x114EFF25
	Offset: 0x6920
	Size: 0x1A4
	Parameters: 1
	Flags: Linked
*/
function function_ffe9eab7(s_challenge)
{
	level endon(#"end_game");
	self endon(#"disconnect");
	s_challenge endon(s_challenge.str_notify);
	while(true)
	{
		var_197c85d1 = self getvelocity();
		var_9b7f7d9b = length(var_197c85d1);
		w_weapon = self getcurrentweapon();
		w_weapon = zm_weapons::get_base_weapon(w_weapon);
		var_f77522bb = self getnormalizedmovement();
		if(isalive(self) && var_9b7f7d9b === 0)
		{
			self.var_ab5095e1 = 0;
		}
		else if(isarray(s_challenge.var_4220f02a) && self isfiring() && isinarray(s_challenge.var_4220f02a, w_weapon) && var_f77522bb == (0, 0, 0))
		{
			self.var_ab5095e1 = 0;
		}
		else
		{
			self.var_ab5095e1 = 1;
		}
		waitframe(1);
	}
}

/*
	Name: function_eaf96378
	Namespace: namespace_86eed980
	Checksum: 0x46B26B10
	Offset: 0x6AD0
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function function_eaf96378(s_params)
{
	if(isdefined(s_params.eattacker.var_bf8dfaf4) && s_params.eattacker.var_bf8dfaf4)
	{
		self function_eaf6e39e();
	}
}

/*
	Name: function_a741762f
	Namespace: namespace_86eed980
	Checksum: 0xD9E34A5B
	Offset: 0x6B30
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function function_a741762f(s_params)
{
	if(isdefined(s_params.eattacker.var_3236cdc2) && s_params.eattacker.var_3236cdc2)
	{
		self function_eaf6e39e();
	}
}

/*
	Name: function_55bd528c
	Namespace: namespace_86eed980
	Checksum: 0xC6DCCA13
	Offset: 0x6B90
	Size: 0xCC
	Parameters: 2
	Flags: Linked
*/
function function_55bd528c(s_params, ai)
{
	if(zm_utility::is_headshot(s_params.weapon, s_params.shitloc, s_params.smeansofdeath) && (!isdefined(ai.var_bf8dfaf4) || !ai.var_bf8dfaf4))
	{
		if(level.var_9cb7f7de < 15)
		{
			var_25a548fa = self function_b0d64cce(ai.origin, ai.angles);
			if(var_25a548fa)
			{
				level.var_9cb7f7de++;
			}
		}
	}
}

/*
	Name: function_b0d64cce
	Namespace: namespace_86eed980
	Checksum: 0x2A8694CF
	Offset: 0x6C68
	Size: 0x204
	Parameters: 2
	Flags: Linked
*/
function function_b0d64cce(v_pos, v_angles)
{
	if(isdefined(v_pos))
	{
		var_b82ff340 = namespace_509a75d1::function_6d41bab8(v_pos, 360);
		if(!isdefined(var_b82ff340))
		{
			/#
				iprintlnbold("");
			#/
			var_b82ff340 = v_pos;
		}
		v_ground = groundtrace(var_b82ff340 + vectorscale((0, 0, 1), 64) + vectorscale((0, 0, 1), 8), var_b82ff340 + vectorscale((0, 0, 1), 64) + vectorscale((0, 0, -1), 100000), 0, self)[#"position"];
		v_ground = v_ground + vectorscale((0, 0, 1), 36);
		var_68101467 = util::spawn_model("p8_zm_esc_warden_organs_brain", v_ground);
		waitframe(1);
		s_unitrigger = var_68101467 namespace_2e9c09b3::function_f1827cc6(&function_4626ec3, &function_fde99ac6, undefined, 96);
		var_68101467.targetname = "brain_item_drop";
		var_68101467.var_8691c7d4 = 1;
		var_68101467 playsound(#"zmb_spawn_powerup");
		var_68101467 playloopsound(#"zmb_spawn_powerup_loop");
		var_68101467 thread function_f5f83516();
		zm_unitrigger::reregister_unitrigger_as_dynamic(s_unitrigger);
		return 1;
	}
	return 0;
}

/*
	Name: function_4626ec3
	Namespace: namespace_86eed980
	Checksum: 0x28769EA2
	Offset: 0x6E78
	Size: 0x8C
	Parameters: 2
	Flags: Linked
*/
function function_4626ec3(var_2e1f34dd, e_player)
{
	var_2e1f34dd zm_unitrigger::unregister_unitrigger(var_2e1f34dd.s_unitrigger);
	var_2e1f34dd stoploopsound();
	e_player playsound(#"zmb_powerup_grabbed");
	level notify(#"hash_3f9f63ddefc15247");
	level.var_9cb7f7de--;
}

/*
	Name: function_fde99ac6
	Namespace: namespace_86eed980
	Checksum: 0x61AE97DC
	Offset: 0x6F10
	Size: 0x60
	Parameters: 1
	Flags: Linked
*/
function function_fde99ac6(e_player)
{
	str_hint = zm_utility::function_d6046228(#"hash_74a5f9eca181602", #"hash_682f7d4cd40349d6");
	self sethintstring(str_hint);
	return 1;
}

/*
	Name: function_1417e75b
	Namespace: namespace_86eed980
	Checksum: 0xEAD70E3C
	Offset: 0x6F78
	Size: 0x60
	Parameters: 0
	Flags: Linked
*/
function function_1417e75b()
{
	level endon(#"end_game");
	self endon(self.str_notify);
	while(true)
	{
		level waittill(#"hash_3f9f63ddefc15247");
		self function_eaf6e39e();
	}
}

/*
	Name: function_a302ccda
	Namespace: namespace_86eed980
	Checksum: 0x14A80D5A
	Offset: 0x6FE0
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_a302ccda(s_params)
{
	if(namespace_3263198e::function_fe8ee9f0(s_params.weapon))
	{
		self function_eaf6e39e();
	}
}

/*
	Name: function_d2403e6a
	Namespace: namespace_86eed980
	Checksum: 0x54C7040D
	Offset: 0x7028
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_d2403e6a(s_params)
{
	if(s_params.smeansofdeath === "MOD_MELEE" || (s_params.smeansofdeath === "MOD_IMPACT" && s_params.weapon.isriotshield))
	{
		self function_eaf6e39e();
	}
}

/*
	Name: function_11001794
	Namespace: namespace_86eed980
	Checksum: 0xEF4DB543
	Offset: 0x70A0
	Size: 0x5B2
	Parameters: 0
	Flags: Linked
*/
function function_11001794()
{
	level endon(#"end_game");
	var_50ed6de = vectorscale((0, 1, 0), 90);
	self.var_f2e7f46a = 0;
	if(zm_utility::function_3bff983f() && self.var_53890456 == "self_revives")
	{
		self.var_53890456 = "full_ammo";
	}
	var_53890456 = self.var_53890456;
	switch(var_53890456)
	{
		case "self_revives":
		{
			self.var_f7d17867 = (0, 0, 0);
			self.var_14172483 = var_50ed6de;
			self.var_3ff570f3 = #"p8_zm_gla_heart_zombie";
			a_e_players = getplayers();
			a_e_players[0] clientfield::set("zm_orange_force_challenge_model", 1);
			break;
		}
		case "full_ammo":
		{
			self.var_f7d17867 = vectorscale((0, 0, 1), 6);
			self.var_14172483 = var_50ed6de;
			self.var_3ff570f3 = "p7_zm_power_up_max_ammo";
			break;
		}
		case "fire_sale":
		{
			self.var_f7d17867 = vectorscale((0, 0, 1), 6);
			self.var_14172483 = var_50ed6de;
			self.var_3ff570f3 = "p7_zm_power_up_firesale";
			break;
		}
		case "insta_kill":
		{
			self.var_f7d17867 = vectorscale((0, 0, 1), 12);
			self.var_14172483 = var_50ed6de;
			self.var_3ff570f3 = "p7_zm_power_up_insta_kill";
			break;
		}
		case "hero_weapon_power":
		{
			self.var_f7d17867 = vectorscale((0, 0, 1), 6);
			self.var_14172483 = var_50ed6de;
			self.var_3ff570f3 = "p8_zm_powerup_full_power";
			break;
		}
		case "bonus_points_team":
		{
			self.var_f7d17867 = vectorscale((0, 0, 1), 10);
			self.var_14172483 = var_50ed6de;
			self.var_3ff570f3 = "zombie_z_money_icon";
			break;
		}
		case "carpenter":
		{
			self.var_f7d17867 = vectorscale((0, 0, 1), 10);
			self.var_14172483 = var_50ed6de;
			self.var_3ff570f3 = "p7_zm_power_up_carpenter";
			break;
		}
		case "extra_snowballs":
		{
			self.var_f7d17867 = vectorscale((0, 0, 1), 10);
			self.var_14172483 = var_50ed6de;
			self.var_3ff570f3 = "p8_zm_ora_snowball_power_up";
			break;
		}
		case "armor":
		{
			self.var_f7d17867 = vectorscale((0, 0, 1), 10);
			self.var_14172483 = var_50ed6de;
			self.var_3ff570f3 = "p8_zm_ora_challenge_armor_power_up";
			break;
		}
		case "half_price_traps":
		{
			self.var_f7d17867 = vectorscale((0, 0, 1), 10);
			self.var_14172483 = var_50ed6de;
			self.var_3ff570f3 = "p8_zm_ora_trap_power_up";
			break;
		}
		case "break_freeze_faster":
		{
			self.var_f7d17867 = vectorscale((0, 0, 1), 10);
			self.var_14172483 = var_50ed6de;
			self.var_3ff570f3 = "p8_zm_ora_ice_picker_power_up";
			break;
		}
	}
	var_e18247ac = level.var_b42f4f4b.origin + self.var_f7d17867;
	var_9ac46b0e = level.var_b42f4f4b.angles + self.var_14172483;
	if(isdefined(self.var_f2e7f46a) && self.var_f2e7f46a)
	{
		self.var_4d0b3b87 = zm_utility::spawn_buildkit_weapon_model(self.e_player, getweapon(self.var_53890456), undefined, var_e18247ac, var_9ac46b0e);
		self.var_4d0b3b87.str_weapon_name = self.var_53890456;
		self.var_4d0b3b87 movez(5, 1);
	}
	else
	{
		self.var_4d0b3b87 = util::spawn_model(self.var_3ff570f3, var_e18247ac, var_9ac46b0e);
		self.var_4d0b3b87 movez(5, 1);
		self.var_4d0b3b87.var_c9837131 = 1;
		self.var_4d0b3b87 thread function_f5f83516();
		self.var_4d0b3b87 playsound(#"zmb_spawn_powerup");
		self.var_4d0b3b87 playloopsound(#"zmb_spawn_powerup_loop");
	}
	level.var_b42f4f4b.var_54cb6134 = 1;
}

/*
	Name: function_f5f83516
	Namespace: namespace_86eed980
	Checksum: 0x956B2419
	Offset: 0x7660
	Size: 0x1A0
	Parameters: 0
	Flags: Linked
*/
function function_f5f83516()
{
	self endon(#"death");
	self thread powerup_wobble_fx();
	while(isdefined(self))
	{
		waittime = randomfloatrange(2.5, 5);
		yaw = randomint(360);
		if(yaw > 300)
		{
			yaw = 300;
		}
		else if(yaw < 60)
		{
			yaw = 60;
		}
		yaw = self.angles[1] + yaw;
		new_angles = (-60 + randomint(120), yaw, -45 + randomint(90));
		self rotateto(new_angles, waittime, waittime * 0.5, waittime * 0.5);
		if(isdefined(self.worldgundw))
		{
			self.worldgundw rotateto(new_angles, waittime, waittime * 0.5, waittime * 0.5);
		}
		wait(randomfloat(waittime - 0.1));
	}
}

/*
	Name: powerup_wobble_fx
	Namespace: namespace_86eed980
	Checksum: 0xA7ABB262
	Offset: 0x7808
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function powerup_wobble_fx()
{
	self endon(#"death");
	if(!isdefined(self))
	{
		return;
	}
	if(isdefined(self.var_c9837131) && self.var_c9837131)
	{
		self clientfield::set("powerup_fx", 1);
	}
	else if(isdefined(self.var_8691c7d4) && self.var_8691c7d4)
	{
		self clientfield::set("powerup_fx", 4);
	}
	else
	{
		self clientfield::set("powerup_fx", 2);
	}
}

/*
	Name: function_9e87f32a
	Namespace: namespace_86eed980
	Checksum: 0xF1B79181
	Offset: 0x78D8
	Size: 0xE2
	Parameters: 0
	Flags: Linked
*/
function function_9e87f32a()
{
	level endon(#"end_game");
	self endon(#"hash_5d2057864469af2a", #"hash_4ac0558a94ba3fd7");
	self thread function_b49b8fc6();
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"trigger_activated");
		e_who = var_be17187b.e_who;
		if(zm_utility::can_use(e_who, 1))
		{
			self function_816f228f(e_who);
			self notify(#"hash_5d2057864469af2a");
		}
	}
}

/*
	Name: function_98233b53
	Namespace: namespace_86eed980
	Checksum: 0x935E3B8D
	Offset: 0x79C8
	Size: 0xBA
	Parameters: 0
	Flags: Linked
*/
function function_98233b53()
{
	level endon(#"end_game");
	self endon(#"hash_5d2057864469af2a");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"trigger_activated");
		e_who = var_be17187b.e_who;
		if(zm_utility::can_use(e_who, 0))
		{
			self function_816f228f(e_who);
			self notify(#"hash_5d2057864469af2a");
		}
	}
}

/*
	Name: function_b49b8fc6
	Namespace: namespace_86eed980
	Checksum: 0xE6BE2F76
	Offset: 0x7A90
	Size: 0x1B0
	Parameters: 0
	Flags: Linked
*/
function function_b49b8fc6()
{
	self.e_player endon(#"disconnect", #"hash_5d2057864469af2a", #"hash_4ac0558a94ba3fd7");
	self endon(#"hash_5d2057864469af2a", #"hash_4ac0558a94ba3fd7");
	self.var_561f7ea3 = 0;
	var_4d0b3b87 = self.var_d6578e1f.var_4d0b3b87;
	while(true)
	{
		if(isdefined(self.s_unitrigger.trigger) && (isdefined(self.var_54596501) && self.var_54596501) && isdefined(var_4d0b3b87))
		{
			self.var_561f7ea3 = 0;
			if(self.e_player util::is_looking_at(var_4d0b3b87))
			{
				self.var_561f7ea3 = 1;
			}
			if(self.e_player meleebuttonpressed() && self.var_561f7ea3 && self.e_player istouching(self.s_unitrigger.trigger))
			{
				self.var_54596501 = 0;
				if(isdefined(var_4d0b3b87))
				{
					var_4d0b3b87 delete();
					self.var_d6578e1f.var_4d0b3b87 = undefined;
				}
				self function_fd8a137e();
				self notify(#"hash_4ac0558a94ba3fd7");
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_816f228f
	Namespace: namespace_86eed980
	Checksum: 0x686E2C4B
	Offset: 0x7C48
	Size: 0x52C
	Parameters: 1
	Flags: Linked
*/
function function_816f228f(e_who)
{
	level endon(#"end_game");
	self.var_54cb6134 = 0;
	var_4d0b3b87 = self.var_d6578e1f.var_4d0b3b87;
	var_53890456 = self.var_d6578e1f.var_53890456;
	switch(var_53890456)
	{
		case "self_revives":
		{
			foreach(e_player in getplayers())
			{
				e_player zm_laststand::function_3a00302e();
			}
			a_e_players = getplayers();
			a_e_players[0] clientfield::set("zm_orange_force_challenge_model", 0);
			break;
		}
		case "carpenter":
		case "full_ammo":
		case "bonus_points_team":
		case "fire_sale":
		case "insta_kill":
		{
			self.var_59bf6fe2 = 1;
			level [[level._custom_powerups[var_53890456].grab_powerup]](e_who);
			break;
		}
		case "hero_weapon_power":
		{
			self.var_59bf6fe2 = 1;
			foreach(e_player in getplayers())
			{
				if(!e_player util::function_bf5a8f5c())
				{
					level [[level._custom_powerups[var_53890456].grab_powerup]](e_player);
				}
			}
			break;
		}
		case "extra_snowballs":
		{
			level flag::set(#"extra_snowballs");
			foreach(e_player in getplayers())
			{
				e_player thread function_f0c3ac7c();
			}
			break;
		}
		case "armor":
		{
			foreach(player in getplayers())
			{
				if(!player laststand::player_is_in_laststand() && isalive(player))
				{
					player namespace_ad4d960b::add(#"hash_35c87147e29f1708", 100, 100);
				}
			}
			break;
		}
		case "half_price_traps":
		{
			level flag::set(#"half_price_traps");
			break;
		}
		case "break_freeze_faster":
		{
			level flag::set(#"break_freeze_faster");
			break;
		}
	}
	self function_fd8a137e();
	e_who playsound(#"zmb_powerup_grabbed");
	if(isdefined(var_4d0b3b87))
	{
		var_4d0b3b87 stoploopsound();
		var_4d0b3b87 delete();
		self.var_d6578e1f.var_4d0b3b87 = undefined;
	}
	if(isdefined(self.var_59bf6fe2) && self.var_59bf6fe2)
	{
		level zm_audio::sndannouncerplayvox(var_53890456);
	}
}

/*
	Name: function_f0c3ac7c
	Namespace: namespace_86eed980
	Checksum: 0xF84C5E15
	Offset: 0x8180
	Size: 0x154
	Parameters: 0
	Flags: Linked
*/
function function_f0c3ac7c()
{
	var_d49d10b0 = self namespace_2ba51478::get_player_lethal_grenade();
	if(isdefined(var_d49d10b0) && var_d49d10b0 == level.var_ad5d43cf)
	{
		self zm_weapons::weapon_give(level.var_f8934665, 1, 0);
		var_bcd1c2ff = self gadgetgetslot(var_d49d10b0);
		self gadgetpowerreset(var_bcd1c2ff, 0);
		self thread namespace_f93d2fa1::function_76e94d52();
	}
	else if(isdefined(var_d49d10b0) && var_d49d10b0 == level.var_bf70d56c)
	{
		self zm_weapons::weapon_give(level.var_d879215, 1, 0);
		var_bcd1c2ff = self gadgetgetslot(var_d49d10b0);
		self gadgetpowerreset(var_bcd1c2ff, 0);
		self thread namespace_f93d2fa1::function_76e94d52();
	}
}

/*
	Name: swap_weapon
	Namespace: namespace_86eed980
	Checksum: 0xD69A45CE
	Offset: 0x82E0
	Size: 0xEC
	Parameters: 1
	Flags: None
*/
function swap_weapon(var_498a708)
{
	var_6822257f = self getweaponslist();
	foreach(var_f99a6771 in var_6822257f)
	{
		if(var_f99a6771.rootweapon === var_498a708)
		{
			self zm_weapons::function_7c5dd4bd(var_f99a6771);
			return;
		}
	}
	if(!self hasweapon(var_498a708, 1))
	{
		self function_e2a25377(var_498a708);
	}
}

/*
	Name: function_e2a25377
	Namespace: namespace_86eed980
	Checksum: 0x18CA9DA6
	Offset: 0x83D8
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function function_e2a25377(var_498a708)
{
	if(self hasweapon(zm_weapons::get_base_weapon(var_498a708), 1))
	{
		self takeweapon(zm_weapons::get_base_weapon(var_498a708), 1);
	}
	self zm_weapons::weapon_give(var_498a708, 1);
}

/*
	Name: function_eaf6e39e
	Namespace: namespace_86eed980
	Checksum: 0xE8FC0067
	Offset: 0x8468
	Size: 0x172
	Parameters: 1
	Flags: Linked
*/
function function_eaf6e39e(n_count = 1)
{
	self.n_current_progress = self.n_current_progress + n_count;
	if(self.n_current_progress >= self.n_goal)
	{
		self.n_current_progress = self.n_goal;
	}
	self function_544b63c0(self.n_current_progress);
	if(self.n_current_progress >= self.n_goal)
	{
		if(math::cointoss(50))
		{
			a_e_players = array::randomize(getplayers());
			foreach(e_player in a_e_players)
			{
				if(!e_player util::function_bf5a8f5c())
				{
					e_player thread namespace_3263198e::function_51b752a9(#"vox_generic_responses_positive");
					break;
				}
			}
		}
		self notify(self.str_notify);
	}
}

/*
	Name: function_bce7e59b
	Namespace: namespace_86eed980
	Checksum: 0xC8B92B0A
	Offset: 0x85E8
	Size: 0xF8
	Parameters: 3
	Flags: Linked
*/
function function_bce7e59b(n_index, n_current_progress, n_goal)
{
	foreach(e_player in getplayers())
	{
		level namespace_6747c550::function_7df6bb60(#"hash_380ef45b5b7d0888", n_current_progress, e_player);
		level namespace_6747c550::function_7df6bb60(#"hash_49e0a1059cfa201a", n_goal, e_player);
		level namespace_6747c550::function_7df6bb60(#"hash_56eb67699f4d5fd2", n_index, e_player);
	}
}

/*
	Name: function_544b63c0
	Namespace: namespace_86eed980
	Checksum: 0xB92E3B39
	Offset: 0x86E8
	Size: 0xB8
	Parameters: 1
	Flags: Linked, Private
*/
private function function_544b63c0(n_progress)
{
	if(n_progress > self.n_goal)
	{
		n_progress = self.n_goal;
	}
	foreach(e_player in getplayers())
	{
		level namespace_6747c550::function_7df6bb60(#"hash_380ef45b5b7d0888", n_progress, e_player);
	}
}

/*
	Name: function_fd8a137e
	Namespace: namespace_86eed980
	Checksum: 0xC6E86FF8
	Offset: 0x87A8
	Size: 0x118
	Parameters: 1
	Flags: Linked
*/
function function_fd8a137e(n_time = 0)
{
	self notify(#"hash_b296fe3ccb7d273");
	self endon(#"disconnect", #"hash_b296fe3ccb7d273");
	if(n_time > 0)
	{
		wait(n_time);
	}
	foreach(e_player in getplayers())
	{
		level namespace_6747c550::function_7df6bb60(#"hash_56eb67699f4d5fd2", 0, e_player);
		level namespace_6747c550::function_7df6bb60(#"hash_380ef45b5b7d0888", 0, e_player);
	}
}

/*
	Name: function_e4b04738
	Namespace: namespace_86eed980
	Checksum: 0xA1DF1DBB
	Offset: 0x88C8
	Size: 0xA4
	Parameters: 0
	Flags: None
*/
function function_e4b04738()
{
	/#
		if(level flag::get(#"hash_671b32b10654845d"))
		{
			if(isdefined(level.var_97a44fdd))
			{
				var_d6578e1f = level.var_97a44fdd.var_d6578e1f;
				var_d6578e1f.n_current_progress = var_d6578e1f.n_goal;
				var_d6578e1f function_544b63c0(var_d6578e1f.n_current_progress);
				var_d6578e1f notify(var_d6578e1f.str_notify);
			}
		}
	#/
}

