// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_52c6c2d1a2ef1b46;
#using script_6a3f43063dfd1bdc;
#using script_6c5b51f98cd04fa3;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm\zm_orange_util.gsc;
#using scripts\zm_common\bgbs\zm_bgb_anywhere_but_here.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_5449c7ba;

/*
	Name: init
	Namespace: namespace_5449c7ba
	Checksum: 0x9EDF59C3
	Offset: 0x2C8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function init()
{
	init_flags();
}

/*
	Name: init_flags
	Namespace: namespace_5449c7ba
	Checksum: 0xE44A77D7
	Offset: 0x2E8
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function init_flags()
{
	level flag::init(#"hash_7220fbbcfb27dbd4");
	level flag::init(#"hash_4119ce1986c28b9d");
	level flag::init(#"hash_5c6f1082ddbc7389");
	level flag::init(#"hash_50f159e379843d0c");
	level flag::init(#"hash_4839f3b910ec6b98");
	level flag::init(#"hash_4aab4794a755ce9d");
	level flag::init(#"hash_60c221c7e2c660c0");
	level flag::init(#"hash_475c24f631fab267");
}

/*
	Name: main
	Namespace: namespace_5449c7ba
	Checksum: 0xC8EA2284
	Offset: 0x3F8
	Size: 0x354
	Parameters: 0
	Flags: Linked
*/
function main()
{
	level.var_79260935 = spawnstruct();
	level.var_79260935.var_16a6820f = struct::get_array("s_vault_keyhole", "targetname");
	level.var_79260935.e_vault_defend_blocker = getent("e_vault_defend_blocker", "targetname");
	level.var_79260935.s_vault_reward = struct::get("s_vault_reward", "targetname");
	level.var_79260935.var_7ff5dbc4 = struct::get("facility_vault_door_bundle", "targetname");
	namespace_ee206246::register(#"hash_3a6788f4daed8c33", #"step_1", #"hash_6261200a332f0945", &function_88dec965, &function_3aa0b188);
	namespace_ee206246::register(#"hash_3a6788f4daed8c33", #"step_2", #"hash_62611d0a332f042c", &function_ac7f503f, &function_7f4e2be3);
	namespace_ee206246::register(#"hash_3a6788f4daed8c33", #"step_3", #"hash_62611e0a332f05df", &function_145d9203, &function_33b22107);
	namespace_ee206246::register(#"hash_3a6788f4daed8c33", #"step_4", #"hash_62611b0a332f00c6", &function_e7991e06, &function_441f41e9);
	namespace_ee206246::register(#"hash_3a6788f4daed8c33", #"step_5", #"hash_62611c0a332f0279", &function_bb9777b, &function_4b460950);
	namespace_ee206246::register(#"hash_3a6788f4daed8c33", #"step_6", #"hash_6261190a332efd60", &function_779b1320, &function_8a1848f8);
	namespace_ee206246::start(#"hash_3a6788f4daed8c33", !zm_utility::is_standard());
}

/*
	Name: function_88dec965
	Namespace: namespace_5449c7ba
	Checksum: 0xF2EB9B76
	Offset: 0x758
	Size: 0x244
	Parameters: 1
	Flags: Linked
*/
function function_88dec965(var_5ea5c94d)
{
	function_ee2edc25();
	level.var_79260935.var_c8b70e7e = 1;
	foreach(s_vault_keyhole in level.var_79260935.var_16a6820f)
	{
		s_vault_keyhole zm_unitrigger::create(&function_36db86a9, 64);
		s_vault_keyhole thread function_3590cb58();
	}
	level.var_79260935.s_keycard_machine = struct::get("keycard_machine", "targetname");
	if(!var_5ea5c94d)
	{
		foreach(s_keycard in level.var_79260935.var_9720ddfa)
		{
			s_keycard zm_unitrigger::create("", 64);
			s_keycard thread function_d332685();
		}
		level flag::wait_till("power_on3");
		level.var_79260935.s_keycard_machine zm_unitrigger::create("", 64);
		level.var_79260935.s_keycard_machine thread function_f83bfaa();
		level flag::wait_till(#"hash_7220fbbcfb27dbd4");
	}
}

/*
	Name: function_ee2edc25
	Namespace: namespace_5449c7ba
	Checksum: 0x6091EAB6
	Offset: 0x9A8
	Size: 0x4D0
	Parameters: 0
	Flags: Linked
*/
function function_ee2edc25()
{
	level.var_79260935.var_f4c36022 = 0;
	level.var_79260935.n_keys_placed = 0;
	var_9720ddfa = struct::get_array("sam_keycard", "targetname");
	var_88f6f50a = [];
	var_7ab3d884 = [];
	foreach(s_keycard in var_9720ddfa)
	{
		if(s_keycard.script_int === 0)
		{
			if(!isdefined(var_88f6f50a))
			{
				var_88f6f50a = [];
			}
			else if(!isarray(var_88f6f50a))
			{
				var_88f6f50a = array(var_88f6f50a);
			}
			var_88f6f50a[var_88f6f50a.size] = s_keycard;
			continue;
		}
		if(!isdefined(var_7ab3d884))
		{
			var_7ab3d884 = [];
		}
		else if(!isarray(var_7ab3d884))
		{
			var_7ab3d884 = array(var_7ab3d884);
		}
		var_7ab3d884[var_7ab3d884.size] = s_keycard;
	}
	level.var_79260935.var_9720ddfa = [];
	var_986b4af2 = array::random(var_88f6f50a);
	if(!isdefined(level.var_79260935.var_9720ddfa))
	{
		level.var_79260935.var_9720ddfa = [];
	}
	else if(!isarray(level.var_79260935.var_9720ddfa))
	{
		level.var_79260935.var_9720ddfa = array(level.var_79260935.var_9720ddfa);
	}
	level.var_79260935.var_9720ddfa[level.var_79260935.var_9720ddfa.size] = var_986b4af2;
	arrayremovevalue(var_88f6f50a, var_986b4af2);
	var_f3d781b9 = array::random(var_7ab3d884);
	if(!isdefined(level.var_79260935.var_9720ddfa))
	{
		level.var_79260935.var_9720ddfa = [];
	}
	else if(!isarray(level.var_79260935.var_9720ddfa))
	{
		level.var_79260935.var_9720ddfa = array(level.var_79260935.var_9720ddfa);
	}
	level.var_79260935.var_9720ddfa[level.var_79260935.var_9720ddfa.size] = var_f3d781b9;
	arrayremovevalue(var_7ab3d884, var_f3d781b9);
	foreach(s_keycard in level.var_79260935.var_9720ddfa)
	{
		s_keycard.var_cd0e32a2 = getent(s_keycard.target, "targetname");
	}
	var_5731429e = [];
	var_5731429e = arraycombine(var_88f6f50a, var_7ab3d884, 1, 0);
	foreach(s_keycard in var_5731429e)
	{
		var_b587be04 = getent(s_keycard.target, "targetname");
		var_b587be04 delete();
	}
}

/*
	Name: function_d332685
	Namespace: namespace_5449c7ba
	Checksum: 0x548B8603
	Offset: 0xE80
	Size: 0x1F4
	Parameters: 0
	Flags: Linked
*/
function function_d332685()
{
	level endon(#"end_game", #"hash_7220fbbcfb27dbd4");
	var_adea2587 = undefined;
	var_adea2587 = self waittill(#"trigger_activated");
	e_who = var_adea2587.e_who;
	playsoundatposition(#"hash_d8937c5c97f485e", self.var_cd0e32a2.origin);
	self.var_cd0e32a2 delete();
	if(level.var_79260935.var_f4c36022 === 0 && level.var_79260935.n_keys_placed === 0)
	{
		e_who thread namespace_3263198e::function_51b752a9(#"hash_18bc664341e86310");
		level namespace_6747c550::function_7df6bb60("zm_orange_zipquest_keycard_1", 1);
	}
	else
	{
		if(!isdefined(level.var_79260935.n_keys_placed) || level.var_79260935.n_keys_placed == 0)
		{
			e_who thread namespace_3263198e::function_51b752a9(#"hash_52378df470d0a88b");
		}
		else
		{
			e_who thread namespace_3263198e::function_51b752a9(#"hash_35c946ee7d89155d");
		}
		level namespace_6747c550::function_7df6bb60("zm_orange_zipquest_keycard_2", 1);
	}
	level.var_79260935.var_f4c36022++;
	self zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
}

/*
	Name: function_f83bfaa
	Namespace: namespace_5449c7ba
	Checksum: 0xB2EF78D6
	Offset: 0x1080
	Size: 0x1B0
	Parameters: 0
	Flags: Linked
*/
function function_f83bfaa()
{
	level endon(#"end_game", #"hash_7220fbbcfb27dbd4");
	while(true)
	{
		var_adea2587 = undefined;
		var_adea2587 = self waittill(#"trigger_activated");
		e_who = var_adea2587.e_who;
		if(level.var_79260935.var_f4c36022 === 0)
		{
			continue;
		}
		else
		{
			if(level.var_79260935.var_f4c36022 === 1)
			{
				if(level.var_79260935.n_keys_placed == 0)
				{
					e_who thread namespace_3263198e::function_51b752a9(#"hash_6997edb52b235dd9");
					self function_61298be5();
				}
				else
				{
					e_who thread namespace_3263198e::function_51b752a9(#"hash_6b8c87cc827523c2");
					self function_2ec6a1aa();
				}
			}
			else
			{
				e_who thread namespace_3263198e::function_51b752a9(#"hash_6997edb52b235dd9");
				self function_61298be5();
				e_who thread namespace_3263198e::function_51b752a9(#"hash_6b8c87cc827523c2");
				self function_2ec6a1aa();
			}
		}
	}
}

/*
	Name: function_61298be5
	Namespace: namespace_5449c7ba
	Checksum: 0x76E0EA90
	Offset: 0x1238
	Size: 0x128
	Parameters: 0
	Flags: Linked
*/
function function_61298be5()
{
	var_1a304a2f = struct::get(self.target, "targetname");
	self.var_b6aa4c4f = util::spawn_model("p8_zm_ora_keycard_0", var_1a304a2f.origin, var_1a304a2f.angles);
	playsoundatposition(#"hash_7b375cb6d6863713", self.var_b6aa4c4f.origin);
	level namespace_6747c550::function_7df6bb60("zm_orange_zipquest_keycard_1", 0);
	level.var_79260935.var_f4c36022--;
	level.var_79260935.n_keys_placed++;
	wait(0.5);
	self.var_b6aa4c4f namespace_509a75d1::function_dc4ab629(-8, 1.5);
	self.var_b6aa4c4f waittill(#"movedone");
}

/*
	Name: function_2ec6a1aa
	Namespace: namespace_5449c7ba
	Checksum: 0xB5246205
	Offset: 0x1368
	Size: 0x244
	Parameters: 0
	Flags: Linked
*/
function function_2ec6a1aa()
{
	var_1a304a2f = struct::get(self.target2, "targetname");
	self.var_a56fa9da = util::spawn_model("p8_zm_ora_keycard_0", var_1a304a2f.origin, var_1a304a2f.angles);
	playsoundatposition(#"hash_7b375cb6d6863713", self.var_a56fa9da.origin);
	level namespace_6747c550::function_7df6bb60("zm_orange_zipquest_keycard_2", 0);
	level.var_79260935.var_f4c36022--;
	level.var_79260935.n_keys_placed++;
	wait(0.5);
	self.var_a56fa9da namespace_509a75d1::function_dc4ab629(-8, 1.5);
	self.var_a56fa9da waittill(#"movedone");
	self zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
	playsoundatposition(#"hash_105229c7410bf423", self.origin);
	wait(4);
	self.var_b6aa4c4f setmodel("p8_zm_ora_keycard_1");
	self.var_a56fa9da setmodel("p8_zm_ora_keycard_2");
	self.var_b6aa4c4f namespace_509a75d1::function_dc4ab629(8, 1.5);
	self.var_a56fa9da namespace_509a75d1::function_dc4ab629(8, 1.5);
	self.var_a56fa9da waittill(#"movedone");
	level flag::set(#"hash_7220fbbcfb27dbd4");
}

/*
	Name: function_3aa0b188
	Namespace: namespace_5449c7ba
	Checksum: 0x10339883
	Offset: 0x15B8
	Size: 0x1BC
	Parameters: 2
	Flags: Linked
*/
function function_3aa0b188(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		foreach(s_keycard in level.var_79260935.var_9720ddfa)
		{
			if(isdefined(s_keycard.var_cd0e32a2))
			{
				s_keycard.var_cd0e32a2 delete();
				s_keycard zm_unitrigger::unregister_unitrigger(s_keycard.s_unitrigger);
			}
		}
		switch(level.var_79260935.n_keys_placed)
		{
			case 0:
			{
				level.var_79260935.s_keycard_machine function_61298be5();
				level.var_79260935.s_keycard_machine function_2ec6a1aa();
				break;
			}
			case 1:
			{
				level.var_79260935.s_keycard_machine function_2ec6a1aa();
				break;
			}
			default:
			{
				break;
			}
		}
		level flag::set(#"hash_7220fbbcfb27dbd4");
	}
}

/*
	Name: function_ac7f503f
	Namespace: namespace_5449c7ba
	Checksum: 0x2E49ABB9
	Offset: 0x1780
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function function_ac7f503f(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level.var_79260935.s_keycard_machine zm_unitrigger::create("", 64);
		level.var_79260935.s_keycard_machine thread function_6c5a5d32();
		level flag::wait_till(#"hash_4119ce1986c28b9d");
	}
}

/*
	Name: function_6c5a5d32
	Namespace: namespace_5449c7ba
	Checksum: 0x2DF289E5
	Offset: 0x1810
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function function_6c5a5d32()
{
	level endon(#"end_game", #"hash_4119ce1986c28b9d");
	self waittill(#"trigger_activated");
	level namespace_6747c550::function_7df6bb60("zm_orange_zipquest_keycard_1", 2);
	level namespace_6747c550::function_7df6bb60("zm_orange_zipquest_keycard_2", 2);
	playsoundatposition(#"hash_218d931e2eeaafc4", self.var_b6aa4c4f.origin);
	self.var_b6aa4c4f delete();
	self.var_a56fa9da delete();
	level flag::set(#"hash_4119ce1986c28b9d");
}

/*
	Name: function_7f4e2be3
	Namespace: namespace_5449c7ba
	Checksum: 0x7A9B8315
	Offset: 0x1920
	Size: 0x94
	Parameters: 2
	Flags: Linked
*/
function function_7f4e2be3(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		if(isdefined(self.var_b6aa4c4f))
		{
			self.var_b6aa4c4f delete();
		}
		if(isdefined(self.var_a56fa9da))
		{
			self.var_a56fa9da delete();
		}
		level flag::set(#"hash_4119ce1986c28b9d");
	}
}

/*
	Name: function_145d9203
	Namespace: namespace_5449c7ba
	Checksum: 0xA17F8FA9
	Offset: 0x19C0
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function function_145d9203(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level flag::set(#"hash_475c24f631fab267");
		level flag::wait_till(#"hash_50f159e379843d0c");
	}
}

/*
	Name: function_33b22107
	Namespace: namespace_5449c7ba
	Checksum: 0x88BB0640
	Offset: 0x1A20
	Size: 0x110
	Parameters: 2
	Flags: Linked
*/
function function_33b22107(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level flag::set(#"hash_5c6f1082ddbc7389");
		level flag::set(#"hash_50f159e379843d0c");
	}
	level flag::clear(#"hash_475c24f631fab267");
	foreach(s_vault_keyhole in level.var_79260935.var_16a6820f)
	{
		s_vault_keyhole zm_unitrigger::unregister_unitrigger(s_vault_keyhole.s_unitrigger);
	}
}

/*
	Name: function_36db86a9
	Namespace: namespace_5449c7ba
	Checksum: 0x3ADB0F5D
	Offset: 0x1B38
	Size: 0xA8
	Parameters: 1
	Flags: Linked
*/
function function_36db86a9(e_player)
{
	if(level flag::get(#"hash_475c24f631fab267"))
	{
		str_hint = zm_utility::function_d6046228(#"hash_3d7d3a56e292c6fa", #"hash_b6e409536fc91fe");
		self sethintstring(str_hint);
		return true;
	}
	self sethintstring("");
	return true;
}

/*
	Name: function_3590cb58
	Namespace: namespace_5449c7ba
	Checksum: 0xCAE7A694
	Offset: 0x1BF0
	Size: 0x2F8
	Parameters: 0
	Flags: Linked
*/
function function_3590cb58()
{
	level endon(#"end_game");
	self.var_1a304a2f = struct::get(self.target, "targetname");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"trigger_activated");
		e_who = s_result.e_who;
		if(level flag::get(#"hash_475c24f631fab267"))
		{
			self.var_896127a6 = util::spawn_model(self.var_1a304a2f.model, self.var_1a304a2f.origin, self.var_1a304a2f.angles);
			playsoundatposition(#"hash_7b375cb6d6863713", self.var_896127a6.origin);
			wait(1);
			self.var_896127a6 namespace_509a75d1::function_dc4ab629(-8, 1.5);
			self.var_896127a6 waittill(#"movedone");
			if(!level flag::get(#"hash_5c6f1082ddbc7389"))
			{
				e_who thread namespace_3263198e::function_51b752a9(#"vox_generic_responses_positive");
				level flag::set(#"hash_5c6f1082ddbc7389");
				self zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
				level namespace_6747c550::function_7df6bb60("zm_orange_zipquest_keycard_1", 0);
			}
			else
			{
				level flag::set(#"hash_50f159e379843d0c");
				level namespace_6747c550::function_7df6bb60("zm_orange_zipquest_keycard_2", 0);
				level namespace_6747c550::function_7df6bb60("zm_orange_zipquest_phase_num", 2);
				level namespace_6747c550::function_7df6bb60("zm_orange_zipquest_handle_final", 1);
				return;
			}
		}
		else if(isdefined(level.var_79260935.var_c8b70e7e) && level.var_79260935.var_c8b70e7e)
		{
			level.var_79260935.var_c8b70e7e = 0;
			e_who thread namespace_3263198e::function_51b752a9(#"vox_generic_responses_negative");
		}
	}
}

/*
	Name: function_e7991e06
	Namespace: namespace_5449c7ba
	Checksum: 0x879603E0
	Offset: 0x1EF0
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function function_e7991e06(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level.var_79260935.s_vault_reward zm_unitrigger::create(&function_bb5cf7f2, 128);
		level.var_79260935.s_vault_reward thread function_6b4a631b();
		level flag::wait_till(#"hash_4839f3b910ec6b98");
	}
}

/*
	Name: function_441f41e9
	Namespace: namespace_5449c7ba
	Checksum: 0x92C435AE
	Offset: 0x1F88
	Size: 0x7C
	Parameters: 2
	Flags: Linked
*/
function function_441f41e9(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level flag::set(#"hash_4839f3b910ec6b98");
	}
	level.var_79260935.s_vault_reward zm_unitrigger::unregister_unitrigger(level.var_79260935.s_vault_reward.s_unitrigger);
}

/*
	Name: function_bb5cf7f2
	Namespace: namespace_5449c7ba
	Checksum: 0x12311552
	Offset: 0x2010
	Size: 0x150
	Parameters: 1
	Flags: Linked
*/
function function_bb5cf7f2(e_player)
{
	var_cb24ec97 = namespace_509a75d1::function_9258efe1("human_infusion");
	if(zm_utility::is_classic() && level.var_45827161[level.round_number] !== undefined || (zm_utility::is_trials() && (level.round_number == 5 || level.round_number == 19)))
	{
		self sethintstring(#"hash_3c96e29876e85183");
		return true;
	}
	if(var_cb24ec97)
	{
		str_hint = zm_utility::function_d6046228(#"hash_56fc5ab8c0878d32", #"hash_17af2e2ebc75a206");
		self sethintstring(str_hint);
		return true;
	}
	self sethintstring(#"hash_3a0b70fac224c702");
	return true;
}

/*
	Name: function_6b4a631b
	Namespace: namespace_5449c7ba
	Checksum: 0x8AE58E8C
	Offset: 0x2170
	Size: 0x10A
	Parameters: 0
	Flags: Linked
*/
function function_6b4a631b()
{
	level endon(#"end_game");
	while(true)
	{
		self waittill(#"trigger_activated");
		var_cb24ec97 = namespace_509a75d1::function_9258efe1("human_infusion");
		if(zm_utility::is_classic() && level.var_45827161[level.round_number] !== undefined || (zm_utility::is_trials() && (level.round_number == 5 || level.round_number == 19)))
		{
			var_cb24ec97 = 0;
		}
		if(var_cb24ec97)
		{
			level flag::set(#"hash_4839f3b910ec6b98");
			return;
		}
	}
}

/*
	Name: function_bb9777b
	Namespace: namespace_5449c7ba
	Checksum: 0x153CE869
	Offset: 0x2288
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function function_bb9777b(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level thread function_1f269398();
		exploder::exploder("fxexp_vault_door_facility_steam");
		level.var_79260935.var_7ff5dbc4 scene::play("open");
		level flag::wait_till(#"hash_4aab4794a755ce9d");
	}
}

/*
	Name: function_4b460950
	Namespace: namespace_5449c7ba
	Checksum: 0xDDEADBB6
	Offset: 0x2320
	Size: 0x104
	Parameters: 2
	Flags: Linked
*/
function function_4b460950(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level.var_79260935.var_7ff5dbc4 scene::play("open_fast");
		level flag::clear(#"infinite_round_spawning");
		level flag::clear(#"pause_round_timeout");
		zm_bgb_anywhere_but_here::function_886fce8f(1);
		level.var_382a24b0 = undefined;
		level flag::set(#"hash_4aab4794a755ce9d");
	}
	exploder::stop_exploder("fxexp_forcefield_facility");
	level.var_79260935.e_vault_defend_blocker delete();
}

/*
	Name: function_1f269398
	Namespace: namespace_5449c7ba
	Checksum: 0x5C082DE4
	Offset: 0x2430
	Size: 0x1E4
	Parameters: 0
	Flags: Linked
*/
function function_1f269398()
{
	level endon(#"end_game");
	level.var_79260935.e_vault_defend_blocker movez(104, 0.1);
	exploder::exploder("fxexp_forcefield_facility");
	if(level.var_98138d6b > 1)
	{
		level.var_1c53964e thread namespace_509a75d1::function_6a0d675d(#"hash_4b68766a3d07f0da", 0);
	}
	level flag::set(#"infinite_round_spawning");
	level flag::set(#"pause_round_timeout");
	zm_bgb_anywhere_but_here::function_886fce8f(0);
	level.var_382a24b0 = 0;
	level thread function_b53212e5();
	wait(60);
	level flag::clear(#"infinite_round_spawning");
	level flag::clear(#"pause_round_timeout");
	zm_bgb_anywhere_but_here::function_886fce8f(1);
	level.var_382a24b0 = undefined;
	if(level.var_98138d6b > 1)
	{
		level.var_1c53964e namespace_509a75d1::function_6a0d675d(#"hash_4b68766a3d07f0da", 1);
	}
	level flag::set(#"hash_4aab4794a755ce9d");
}

/*
	Name: function_b53212e5
	Namespace: namespace_5449c7ba
	Checksum: 0x8DFEFF54
	Offset: 0x2620
	Size: 0x168
	Parameters: 0
	Flags: Linked
*/
function function_b53212e5()
{
	var_408fc16d = struct::get_array("vault_alarm", "targetname");
	wait(2);
	foreach(alarm in var_408fc16d)
	{
		alarm.var_29c7dbd6 = spawn("script_origin", alarm.origin);
		alarm.var_29c7dbd6 playloopsound(#"evt_vault_alarm");
		wait(0.05);
	}
	wait(60);
	foreach(alarm in var_408fc16d)
	{
		alarm.var_29c7dbd6 delete();
	}
}

/*
	Name: function_779b1320
	Namespace: namespace_5449c7ba
	Checksum: 0xE74A6B83
	Offset: 0x2790
	Size: 0xFC
	Parameters: 1
	Flags: Linked
*/
function function_779b1320(var_5ea5c94d)
{
	level.var_79260935.var_ff31c99 = getweapon(#"music_box");
	callback::function_33f0ddd3(&function_33f0ddd3);
	callback::on_disconnect(&on_disconnect);
	if(!var_5ea5c94d)
	{
		level.var_79260935.s_vault_reward zm_unitrigger::create(&function_c0510b69, 64);
		level.var_79260935.s_vault_reward thread function_be4c3b3e();
		level flag::wait_till(#"hash_60c221c7e2c660c0");
	}
}

/*
	Name: function_8a1848f8
	Namespace: namespace_5449c7ba
	Checksum: 0x3671DBA3
	Offset: 0x2898
	Size: 0x10C
	Parameters: 2
	Flags: Linked
*/
function function_8a1848f8(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		a_e_players = getplayers();
		foreach(e_player in a_e_players)
		{
			if(!e_player util::is_spectating())
			{
				e_player zm_weapons::weapon_give(level.var_79260935.var_ff31c99, 1);
			}
		}
		level flag::set(#"hash_60c221c7e2c660c0");
	}
}

/*
	Name: function_c0510b69
	Namespace: namespace_5449c7ba
	Checksum: 0x66B6B364
	Offset: 0x29B0
	Size: 0x60
	Parameters: 1
	Flags: Linked
*/
function function_c0510b69(e_player)
{
	str_hint = zm_utility::function_d6046228(#"hash_7976ce10c7043db7", #"hash_226401bfc284fb25");
	self sethintstring(str_hint);
	return true;
}

/*
	Name: function_be4c3b3e
	Namespace: namespace_5449c7ba
	Checksum: 0xE1DFF676
	Offset: 0x2A18
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function function_be4c3b3e()
{
	level endon(#"end_game");
	s_result = undefined;
	s_result = self waittill(#"trigger_activated");
	e_who = s_result.e_who;
	level thread function_7c831be0(e_who);
	e_who zm_weapons::weapon_give(level.var_79260935.var_ff31c99, 1);
	zm_weapons::function_603af7a8(level.var_79260935.var_ff31c99);
	var_b3362cd = getent(self.target, "targetname");
	var_b3362cd hide();
	self zm_unitrigger::unregister_unitrigger(level.var_79260935.s_vault_reward.s_unitrigger);
	level flag::set(#"hash_60c221c7e2c660c0");
}

/*
	Name: function_7c831be0
	Namespace: namespace_5449c7ba
	Checksum: 0x62B62458
	Offset: 0x2B68
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_7c831be0(e_player)
{
	e_player namespace_3263198e::function_51b752a9(#"hash_7809b2dff89ac8d0");
	wait(1);
	if(level.var_98138d6b > 1)
	{
		level.var_1c53964e thread namespace_509a75d1::function_6a0d675d(#"hash_7809b2dff89ac8d0");
	}
}

/*
	Name: function_89c75856
	Namespace: namespace_5449c7ba
	Checksum: 0x743D7FCC
	Offset: 0x2BE0
	Size: 0x84
	Parameters: 0
	Flags: Linked, Private
*/
function private function_89c75856()
{
	var_b3362cd = getent(self.target, "targetname");
	var_b3362cd show();
	self zm_unitrigger::create(&function_c0510b69, 64);
	self thread function_be4c3b3e();
}

/*
	Name: on_disconnect
	Namespace: namespace_5449c7ba
	Checksum: 0xB74B1AF8
	Offset: 0x2C70
	Size: 0x6C
	Parameters: 0
	Flags: Linked, Private
*/
function private on_disconnect()
{
	if(self hasweapon(level.var_79260935.var_ff31c99))
	{
		/#
			iprintln("");
		#/
		level.var_79260935.s_vault_reward function_89c75856();
	}
}

/*
	Name: function_33f0ddd3
	Namespace: namespace_5449c7ba
	Checksum: 0x488296A4
	Offset: 0x2CE8
	Size: 0xA4
	Parameters: 1
	Flags: Linked, Private
*/
function private function_33f0ddd3(s_event)
{
	if(s_event.event === "take_weapon" && s_event.weapon === level.var_79260935.var_ff31c99 && self.var_3b55baa1 !== level.var_79260935.var_ff31c99)
	{
		/#
			iprintln("");
		#/
		level.var_79260935.s_vault_reward function_89c75856();
	}
}

/*
	Name: function_96d95cf5
	Namespace: namespace_5449c7ba
	Checksum: 0x97F7D602
	Offset: 0x2D98
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_96d95cf5()
{
	level.var_79260935.s_vault_reward function_89c75856();
}

