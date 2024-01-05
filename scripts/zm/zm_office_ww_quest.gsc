// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_59a783d756554a80;
#using scripts\zm\zm_hms_util.gsc;
#using scripts\zm_common\zm_item_pickup.gsc;
#using scripts\zm_common\zm_vo.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_items.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\array_shared.gsc;

#namespace zm_office_ww_quest;

/*
	Name: __init__system__
	Namespace: zm_office_ww_quest
	Checksum: 0xD2354C88
	Offset: 0x5B0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_office_ww_quest", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_office_ww_quest
	Checksum: 0x77AF8494
	Offset: 0x5F8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_clientfields();
}

/*
	Name: init
	Namespace: zm_office_ww_quest
	Checksum: 0xDC6F8C15
	Offset: 0x618
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function init()
{
	function_1bfc7178();
	function_74c94af4();
	init_reward();
	function_73530998();
	function_d486a10();
	function_6ead7c1f();
	function_69d0da21();
}

/*
	Name: init_clientfields
	Namespace: zm_office_ww_quest
	Checksum: 0xBA83E67E
	Offset: 0x698
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("toplayer", "" + #"hash_61ff06b1f8850806", 1, 1, "int");
}

/*
	Name: function_1bfc7178
	Namespace: zm_office_ww_quest
	Checksum: 0x37517977
	Offset: 0x6E8
	Size: 0x192
	Parameters: 0
	Flags: Linked
*/
function function_1bfc7178()
{
	level._effect[#"hash_7c49a746639d8fb9"] = "maps/zm_office/fx8_fxanim_zm_office_code_paint_0";
	level._effect[#"hash_7c49a646639d8e06"] = "maps/zm_office/fx8_fxanim_zm_office_code_paint_1";
	level._effect[#"hash_7c49a546639d8c53"] = "maps/zm_office/fx8_fxanim_zm_office_code_paint_2";
	level._effect[#"hash_7c49a446639d8aa0"] = "maps/zm_office/fx8_fxanim_zm_office_code_paint_3";
	level._effect[#"hash_7c49ab46639d9685"] = "maps/zm_office/fx8_fxanim_zm_office_code_paint_4";
	level._effect[#"hash_7c49aa46639d94d2"] = "maps/zm_office/fx8_fxanim_zm_office_code_paint_5";
	level._effect[#"hash_7c49a946639d931f"] = "maps/zm_office/fx8_fxanim_zm_office_code_paint_6";
	level._effect[#"hash_7c49a846639d916c"] = "maps/zm_office/fx8_fxanim_zm_office_code_paint_7";
	level._effect[#"hash_7c49af46639d9d51"] = "maps/zm_office/fx8_fxanim_zm_office_code_paint_8";
	level._effect[#"hash_7c49ae46639d9b9e"] = "maps/zm_office/fx8_fxanim_zm_office_code_paint_9";
}

/*
	Name: function_65337201
	Namespace: zm_office_ww_quest
	Checksum: 0x2B15D24C
	Offset: 0x888
	Size: 0xFC
	Parameters: 3
	Flags: Linked
*/
function function_65337201(n_set, n_value, n_id)
{
	str_value = function_42fc9e9f(n_value);
	level thread function_282e13e0(n_set, 1, str_value[0], n_id + 10);
	level thread function_282e13e0(n_set, 2, str_value[1], n_id + 11);
	level thread function_282e13e0(n_set, 3, str_value[2], n_id + 12);
	level thread function_282e13e0(n_set, 4, str_value[3], n_id + 13);
}

/*
	Name: function_c010f073
	Namespace: zm_office_ww_quest
	Checksum: 0xA3059387
	Offset: 0x990
	Size: 0x8C
	Parameters: 3
	Flags: Linked
*/
function function_c010f073(n_set, n_digit, n_value)
{
	var_1be59246 = (("code_set" + n_set) + "_digit") + n_digit;
	s_scene = struct::get(var_1be59246, "script_noteworthy");
	s_scene scene::play("num" + n_value);
}

/*
	Name: function_282e13e0
	Namespace: zm_office_ww_quest
	Checksum: 0xEA051D75
	Offset: 0xA28
	Size: 0x1AC
	Parameters: 4
	Flags: Linked
*/
function function_282e13e0(n_set, n_digit, n_value, n_id)
{
	level.var_40361d9a[n_id] = (("code_set" + n_set) + "_digit") + n_digit;
	level.var_3bf3d61e[n_id] = getent(level.var_40361d9a[n_id], "script_noteworthy");
	waitframe(1);
	level.var_3bf3d61e[n_id].tagorigin = util::spawn_model("tag_origin", level.var_3bf3d61e[n_id].origin);
	level.var_3bf3d61e[n_id].tagorigin.angles = level.var_3bf3d61e[n_id].angles;
	waitframe(1);
	level.var_3bf3d61e[n_id].fx = playfxontag(level._effect["code_value_" + n_value], level.var_3bf3d61e[n_id].tagorigin, "tag_origin");
	waitframe(1);
	playsoundatposition(#"hash_146ecbfb7f5982b5", level.var_3bf3d61e[n_id].origin);
}

/*
	Name: function_74c94af4
	Namespace: zm_office_ww_quest
	Checksum: 0x633F46AA
	Offset: 0xBE0
	Size: 0x57C
	Parameters: 0
	Flags: Linked
*/
function function_74c94af4()
{
	level.s_code_machine = struct::get("code_machine");
	level.s_code_machine.var_ba4b2753 = [];
	level.s_code_machine.var_ba4b2753[0] = getent("code_set1_digit1", "script_noteworthy");
	level.s_code_machine.var_ba4b2753[0].n_set = 1;
	level.s_code_machine.var_ba4b2753[0].n_digit = 1;
	level.s_code_machine.var_ba4b2753[1] = getent("code_set1_digit2", "script_noteworthy");
	level.s_code_machine.var_ba4b2753[1].n_set = 1;
	level.s_code_machine.var_ba4b2753[1].n_digit = 2;
	level.s_code_machine.var_ba4b2753[2] = getent("code_set1_digit3", "script_noteworthy");
	level.s_code_machine.var_ba4b2753[2].n_set = 1;
	level.s_code_machine.var_ba4b2753[2].n_digit = 3;
	level.s_code_machine.var_ba4b2753[3] = getent("code_set1_digit4", "script_noteworthy");
	level.s_code_machine.var_ba4b2753[3].n_set = 1;
	level.s_code_machine.var_ba4b2753[3].n_digit = 4;
	array::run_all(level.s_code_machine.var_ba4b2753, &function_53fe0bbd);
	level.s_code_machine function_4ff138eb();
	s_unitrigger = level.s_code_machine zm_unitrigger::create(&function_469495ed, 64, &function_4bda6e6c, 1, 0);
	zm_unitrigger::function_89380dda(s_unitrigger);
	level.s_code_machine.a_n_codes = [];
	n_count = 0;
	while(n_count < 4)
	{
		n_code = function_4696e086();
		if(!array::contains(level.s_code_machine.a_n_codes, n_code))
		{
			if(!isdefined(level.s_code_machine.a_n_codes))
			{
				level.s_code_machine.a_n_codes = [];
			}
			else if(!isarray(level.s_code_machine.a_n_codes))
			{
				level.s_code_machine.a_n_codes = array(level.s_code_machine.a_n_codes);
			}
			level.s_code_machine.a_n_codes[level.s_code_machine.a_n_codes.size] = n_code;
			n_count++;
		}
	}
	level.s_code_machine.var_f8a3f316 = zm_hms_util::function_bffcedde("code_screen", "targetname", "script_int");
	array::run_all(level.s_code_machine.var_f8a3f316, &hide);
	level.s_code_machine.var_8e3c257e = 0;
	level.s_code_machine.n_attempt = 0;
	level.var_b6a4a602 = getent("ww_code_light_off", "targetname");
	level.var_b6a4a602 show();
	level.var_19d116bb = getent("ww_code_light_on_red", "targetname");
	level.var_19d116bb hide();
	level.var_3e0cca2a = getent("ww_code_light_on_green", "targetname");
	level.var_3e0cca2a hide();
}

/*
	Name: function_4ff138eb
	Namespace: zm_office_ww_quest
	Checksum: 0xB0587BEB
	Offset: 0x1168
	Size: 0x72
	Parameters: 0
	Flags: Linked
*/
function function_4ff138eb()
{
	self.n_value = (1000 * self.var_ba4b2753[0].n_value) + (100 * self.var_ba4b2753[1].n_value) + (10 * self.var_ba4b2753[2].n_value) + self.var_ba4b2753[3].n_value;
}

/*
	Name: function_53fe0bbd
	Namespace: zm_office_ww_quest
	Checksum: 0xFA2E5C3
	Offset: 0x11E8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_53fe0bbd()
{
	self.n_value = randomintrange(0, 10);
	level thread function_c010f073(self.n_set, self.n_digit, self.n_value);
	self thread function_ff891275();
}

/*
	Name: function_b5d4a59b
	Namespace: zm_office_ww_quest
	Checksum: 0xFC074D
	Offset: 0x1258
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_b5d4a59b(n_new_value)
{
	self.n_value = n_new_value;
	level thread function_c010f073(self.n_set, self.n_digit, self.n_value);
	level.s_code_machine function_4ff138eb();
}

/*
	Name: function_b128ee4f
	Namespace: zm_office_ww_quest
	Checksum: 0x113BBD28
	Offset: 0x12C0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_b128ee4f()
{
	n_new_value = self.n_value + 1;
	n_new_value = n_new_value % 10;
	self function_b5d4a59b(n_new_value);
}

/*
	Name: function_ff891275
	Namespace: zm_office_ww_quest
	Checksum: 0xE43B2660
	Offset: 0x1310
	Size: 0x50
	Parameters: 0
	Flags: Linked
*/
function function_ff891275()
{
	self endon(#"death");
	while(true)
	{
		self waittill(#"damage");
		self function_b128ee4f();
		wait(0.1);
	}
}

/*
	Name: function_469495ed
	Namespace: zm_office_ww_quest
	Checksum: 0x9FE3329F
	Offset: 0x1368
	Size: 0xB8
	Parameters: 1
	Flags: Linked
*/
function function_469495ed(e_player)
{
	if(level flag::get("power_on"))
	{
		if(function_8b1a219a())
		{
			self sethintstring(#"hash_2638278d162bb997");
		}
		else
		{
			self sethintstring(#"hash_43ea35c7ca629e09");
		}
	}
	else
	{
		self sethintstring(#"hash_71158766520dc432");
	}
	return true;
}

/*
	Name: function_4bda6e6c
	Namespace: zm_office_ww_quest
	Checksum: 0xC7EA63BD
	Offset: 0x1428
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function function_4bda6e6c()
{
	self endon(#"death");
	level flag::wait_till("power_on");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		playsoundatposition(#"hash_5321ac1dbb962d10", level.s_code_machine.origin);
		level.s_code_machine function_ddc86041(waitresult.activator);
	}
}

/*
	Name: function_ddc86041
	Namespace: zm_office_ww_quest
	Checksum: 0x6F98F17C
	Offset: 0x14E8
	Size: 0x1DE
	Parameters: 1
	Flags: Linked
*/
function function_ddc86041(e_player)
{
	n_index = undefined;
	for(i = 0; i < self.a_n_codes.size; i++)
	{
		if(self.n_value == self.a_n_codes[i])
		{
			n_index = i;
			break;
		}
	}
	if(isdefined(n_index))
	{
		function_1e50cd08(n_index);
		function_75e384bc("green");
	}
	else
	{
		function_1e50cd08(5);
		function_75e384bc("red");
	}
	if(n_index === self.var_8e3c257e)
	{
		playsoundatposition(#"hash_6e645a454ec49519", level.s_code_machine.origin);
		self.var_8e3c257e++;
		if(self.var_8e3c257e == 4)
		{
			self thread function_9257b202(e_player);
			playsoundatposition(#"hash_6f02282233234d2f", level.s_code_machine.origin);
			function_1c4908ff();
		}
	}
	else
	{
		playsoundatposition(#"hash_2ff8d043c3a03206", level.s_code_machine.origin);
		level thread namespace_8f53e87b::function_d7b93e68(e_player, n_index);
		self.var_8e3c257e = 0;
	}
}

/*
	Name: function_4696e086
	Namespace: zm_office_ww_quest
	Checksum: 0x9A285074
	Offset: 0x16D0
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function function_4696e086()
{
	return randomintrange(0, 10000);
}

/*
	Name: function_42fc9e9f
	Namespace: zm_office_ww_quest
	Checksum: 0x13CDD042
	Offset: 0x16F8
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_42fc9e9f(n_code)
{
	if(n_code < 10)
	{
		return "000" + n_code;
	}
	if(n_code < 100)
	{
		return "00" + n_code;
	}
	if(n_code < 1000)
	{
		return "0" + n_code;
	}
	return "" + n_code;
}

/*
	Name: function_1e50cd08
	Namespace: zm_office_ww_quest
	Checksum: 0x798CD01A
	Offset: 0x1770
	Size: 0xAA
	Parameters: 1
	Flags: Linked
*/
function function_1e50cd08(var_63eb3fcd)
{
	if(self.var_bec5b6d === var_63eb3fcd)
	{
		return;
	}
	self.var_f8a3f316[var_63eb3fcd] show();
	playsoundatposition(#"hash_1ab40245f7cae5d3", (-670, 1700, -451));
	if(isdefined(self.var_bec5b6d))
	{
		self.var_f8a3f316[self.var_bec5b6d] hide();
	}
	self.var_bec5b6d = var_63eb3fcd;
}

/*
	Name: function_9257b202
	Namespace: zm_office_ww_quest
	Checksum: 0xF6F57142
	Offset: 0x1828
	Size: 0xF4
	Parameters: 1
	Flags: Linked
*/
function function_9257b202(e_player)
{
	self endon(#"death");
	zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
	wait(5);
	self function_1e50cd08(4);
	level.s_ww_quest_reward function_68f68bb4();
	while(level.pentann_is_speaking === 1)
	{
		waitframe(1);
	}
	namespace_8f53e87b::play_pentagon_announcer_vox(#"hash_d846ade61fd0c15");
	if(zm_vo::is_player_valid(e_player))
	{
		e_player zm_vo::function_a2bd5a0c(#"hash_7fe91aa83c27c4b8", undefined, 1);
	}
}

/*
	Name: function_75e384bc
	Namespace: zm_office_ww_quest
	Checksum: 0xAF222F41
	Offset: 0x1928
	Size: 0xF4
	Parameters: 1
	Flags: Linked
*/
function function_75e384bc(color)
{
	if(color == "red" || color == "green")
	{
		if(color == "red")
		{
			var_1f1110b3 = level.var_19d116bb;
		}
		else if(color == "green")
		{
			var_1f1110b3 = level.var_3e0cca2a;
		}
		var_1f1110b3 show();
		level.var_b6a4a602 hide();
		wait(2);
		level.var_b6a4a602 show();
		var_1f1110b3 hide();
	}
	else
	{
		function_863b3a0();
	}
}

/*
	Name: function_1c4908ff
	Namespace: zm_office_ww_quest
	Checksum: 0x11949B98
	Offset: 0x1A28
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_1c4908ff()
{
	level.var_3e0cca2a show();
	level.var_b6a4a602 hide();
}

/*
	Name: function_b33c4cec
	Namespace: zm_office_ww_quest
	Checksum: 0x38D6059C
	Offset: 0x1A68
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function function_b33c4cec()
{
	level.var_19d116bb show();
	level.var_b6a4a602 hide();
}

/*
	Name: function_863b3a0
	Namespace: zm_office_ww_quest
	Checksum: 0x496D9F39
	Offset: 0x1AA8
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_863b3a0()
{
	level.var_b6a4a602 show();
	level.var_19d116bb hide();
	level.var_3e0cca2a hide();
}

/*
	Name: init_reward
	Namespace: zm_office_ww_quest
	Checksum: 0xE08B4AF3
	Offset: 0x1B00
	Size: 0x142
	Parameters: 0
	Flags: Linked
*/
function init_reward()
{
	level.s_ww_quest_reward = struct::get("ww_quest_reward");
	level.s_ww_quest_reward.var_8387846a = getentarray("ww_crate", "targetname");
	array::run_all(level.s_ww_quest_reward.var_8387846a, &hide);
	level.s_ww_quest_reward.var_6b49892a = getent("ww_crate_hinge", "targetname");
	level.s_ww_quest_reward.var_c2b00281 = getent("ww_reward_pickup", "targetname");
	level.s_ww_quest_reward.var_c2b00281 hide();
	level.s_ww_quest_reward.var_5e34c88c = 0;
	level.s_ww_quest_reward.w_freezegun = getweapon(#"ww_freezegun_t8");
}

/*
	Name: function_68f68bb4
	Namespace: zm_office_ww_quest
	Checksum: 0x8257AE6B
	Offset: 0x1C50
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_68f68bb4()
{
	array::run_all(self.var_8387846a, &show);
	self.var_c2b00281 show();
	exploder::exploder("fx_project_skadi_cold_mist");
	self zm_unitrigger::create(&function_2b049ee1, 64, &function_36664799, 1, 0);
}

/*
	Name: function_2b049ee1
	Namespace: zm_office_ww_quest
	Checksum: 0xE32FED59
	Offset: 0x1CF0
	Size: 0x130
	Parameters: 1
	Flags: Linked
*/
function function_2b049ee1(e_player)
{
	if(level.s_ww_quest_reward.var_5e34c88c)
	{
		if(e_player zm_weapons::has_weapon_or_upgrade(level.s_ww_quest_reward.w_freezegun))
		{
			self sethintstring(#"hash_1ee18bf56df7a29b");
		}
		else
		{
			if(function_8b1a219a())
			{
				self sethintstring(#"hash_400e202a91b7d4a4");
			}
			else
			{
				self sethintstring(#"hash_7f8e7919cffd4568");
			}
		}
	}
	else
	{
		if(function_8b1a219a())
		{
			self sethintstring(#"hash_4230a57b5ddc96b2");
		}
		else
		{
			self sethintstring(#"hash_67ddc0f0c16c1216");
		}
	}
	return true;
}

/*
	Name: function_36664799
	Namespace: zm_office_ww_quest
	Checksum: 0xCBD015C4
	Offset: 0x1E28
	Size: 0x246
	Parameters: 0
	Flags: Linked
*/
function function_36664799()
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		if(level.s_ww_quest_reward.var_5e34c88c)
		{
			e_player = waitresult.activator;
			w_freezegun = level.s_ww_quest_reward.w_freezegun;
			if(e_player zm_weapons::has_weapon_or_upgrade(w_freezegun))
			{
				if(e_player zm_weapons::has_upgrade(w_freezegun))
				{
					e_player zm_weapons::ammo_give(level.zombie_weapons[w_freezegun].upgrade);
				}
				else
				{
					e_player zm_weapons::ammo_give(w_freezegun);
				}
			}
			else
			{
				e_player zm_weapons::weapon_give(w_freezegun, 1);
			}
			level.s_ww_quest_reward.var_c2b00281 delete();
			e_player notify(#"hash_5a48f79b359c304");
			e_player thread zm_vo::function_a2bd5a0c(#"hash_71ef2a712e8d604e");
			zm_weapons::add_limited_weapon(w_freezegun.name, 2);
			exploder::stop_exploder("fx_project_skadi_cold_mist");
			zm_unitrigger::unregister_unitrigger(self.stub);
		}
		else
		{
			level.s_ww_quest_reward.var_6b49892a playsound(#"hash_49e33105c3290371");
			level.s_ww_quest_reward.var_6b49892a rotatepitch(110, 1);
			level.s_ww_quest_reward.var_5e34c88c = 1;
		}
	}
}

/*
	Name: function_73530998
	Namespace: zm_office_ww_quest
	Checksum: 0x2D4C4AD0
	Offset: 0x2078
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_73530998()
{
	level.var_6504d315 = spawnstruct();
	level.var_6504d315.n_next = 0;
	var_3181428e = getentarray("t_code1", "targetname");
	array::thread_all(var_3181428e, &function_1e479c72);
}

/*
	Name: function_1e479c72
	Namespace: zm_office_ww_quest
	Checksum: 0x1B1CB397
	Offset: 0x2100
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function function_1e479c72()
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		if(!zm_weapons::is_weapon_upgraded(waitresult.weapon))
		{
			continue;
		}
		if(self.script_int == level.var_6504d315.n_next)
		{
			level.var_6504d315.n_next++;
			if(level.var_6504d315.n_next > 2)
			{
				function_fa833e73();
				wait(0.1);
				break;
			}
		}
		else
		{
			level.var_6504d315.n_next = 0;
		}
		wait(0.5);
	}
}

/*
	Name: function_fa833e73
	Namespace: zm_office_ww_quest
	Checksum: 0xCE86195E
	Offset: 0x2200
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function function_fa833e73()
{
	function_65337201(2, level.s_code_machine.a_n_codes[0], 0);
	level thread function_f25bac74("t_code1_photo", #"hash_7467c8261ce4f7b5");
	function_2375274a();
}

/*
	Name: function_2375274a
	Namespace: zm_office_ww_quest
	Checksum: 0x8299502B
	Offset: 0x2278
	Size: 0x154
	Parameters: 0
	Flags: Linked
*/
function function_2375274a()
{
	level.plaque_door = struct::get("plaque_door", "targetname");
	level.plaque_door scene::play("init");
	level.var_a5f666cc = getentarray("plaque_nameplate", "targetname");
	foreach(plaque in level.var_a5f666cc)
	{
		plaque.v_start = plaque.origin;
		plaque moveto(plaque.v_start + vectorscale((0, 0, 1), 10), 0.5);
	}
	wait(0.3);
	level.plaque_door scene::play("fall");
}

/*
	Name: function_d486a10
	Namespace: zm_office_ww_quest
	Checksum: 0x6F847FB
	Offset: 0x23D8
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function function_d486a10()
{
	level.s_code_drawer = struct::get("code_drawer");
	level.s_code_drawer.e_drawer = getent("code_drawer", "targetname");
	key = getent("code2_key", "targetname");
	if(util::get_game_type() != #"zstandard")
	{
		key zm_item_pickup::function_e8661563(&function_b32c1898);
	}
}

/*
	Name: function_b32c1898
	Namespace: zm_office_ww_quest
	Checksum: 0xEA564B68
	Offset: 0x24B0
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_b32c1898(e_item)
{
	if(util::get_game_type() != #"zstandard")
	{
		level.s_code_drawer zm_unitrigger::create("", 64, &function_3410748f);
	}
}

/*
	Name: function_3410748f
	Namespace: zm_office_ww_quest
	Checksum: 0x7AD216D6
	Offset: 0x2520
	Size: 0x28C
	Parameters: 0
	Flags: Linked
*/
function function_3410748f()
{
	self endon(#"death");
	waitresult = undefined;
	waitresult = self waittill(#"trigger");
	function_a4121dfa();
	waitframe(1);
	level.s_code_drawer.e_drawer moveto(level.s_code_drawer.e_drawer.origin + (-3.5, 13, 0), 0.3);
	level.var_3bf3d61e[20].fx moveto(level.var_3bf3d61e[20].fx.origin + (-3.5, 13, 0), 0.3);
	level.var_3bf3d61e[21].fx moveto(level.var_3bf3d61e[21].fx.origin + (-3.5, 13, 0), 0.3);
	level.var_3bf3d61e[22].fx moveto(level.var_3bf3d61e[22].fx.origin + (-3.5, 13, 0), 0.3);
	level.var_3bf3d61e[23].fx moveto(level.var_3bf3d61e[23].fx.origin + (-3.5, 13, 0), 0.3);
	playsoundatposition(#"hash_7c109876c748f07c", level.s_code_drawer.e_drawer.origin);
	waitresult.activator clientfield::set_to_player("" + #"hash_61ff06b1f8850806", 1);
	zm_unitrigger::unregister_unitrigger(self.stub);
}

/*
	Name: function_a4121dfa
	Namespace: zm_office_ww_quest
	Checksum: 0x63AC99D5
	Offset: 0x27B8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_a4121dfa()
{
	function_65337201(3, level.s_code_machine.a_n_codes[1], 10);
	waitframe(1);
	level thread function_f25bac74("t_code2_photo", #"hash_279626d335505257");
}

/*
	Name: function_6ead7c1f
	Namespace: zm_office_ww_quest
	Checksum: 0x60CD1519
	Offset: 0x2828
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_6ead7c1f()
{
	t_code3 = getent("t_code3", "targetname");
	t_code3 thread function_63572ef0();
	t_code3.e_photo = getent("code3_photo", "targetname");
	t_code3.e_photo hide();
}

/*
	Name: function_63572ef0
	Namespace: zm_office_ww_quest
	Checksum: 0xE3F53839
	Offset: 0x28C0
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_63572ef0()
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		if(waitresult.mod === "MOD_GRENADE_SPLASH")
		{
			self function_4c07537f();
			wait(0.1);
			break;
		}
	}
}

/*
	Name: function_4c07537f
	Namespace: zm_office_ww_quest
	Checksum: 0x6D500029
	Offset: 0x2950
	Size: 0x174
	Parameters: 0
	Flags: Linked
*/
function function_4c07537f()
{
	level._effect[#"hash_609938034ce1dc5a"] = #"hash_1d6e6d988a3f243c";
	var_998a2c39 = level._effect[#"hash_609938034ce1dc5a"];
	self.e_photo.fx_ent = util::spawn_model("tag_origin", self.e_photo.origin);
	self.e_photo.fx_ent.angles = self.e_photo.angles;
	self.e_photo.fx = playfxontag(var_998a2c39, self.e_photo.fx_ent, "tag_origin");
	self.e_photo show();
	wait(0.1);
	function_65337201(4, level.s_code_machine.a_n_codes[2], 20);
	wait(0.1);
	level thread function_f25bac74("t_code3_photo", #"hash_19e148fcc7add789");
}

/*
	Name: function_69d0da21
	Namespace: zm_office_ww_quest
	Checksum: 0x3F3B5FF5
	Offset: 0x2AD0
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function function_69d0da21()
{
	level.s_code4 = struct::get("ww_code4");
	level.s_code4.var_263aa7ff = 0;
	level.s_code4 function_c9559668();
	level.s_code4 zm_unitrigger::create(&function_3db792dd, 64, &function_e0c5fd41, 1, 0);
	level.s_code4 thread function_28e65bfe();
	level.var_390ebc02 = getent("sadako_mover", "targetname");
	level.var_a585b402 = getent("sadako_screen", "targetname");
	level.var_a585b402 thread function_c056a0ad();
}

/*
	Name: function_3db792dd
	Namespace: zm_office_ww_quest
	Checksum: 0x140A6869
	Offset: 0x2BF8
	Size: 0x3E
	Parameters: 1
	Flags: Linked
*/
function function_3db792dd(e_player)
{
	self sethintstring("");
	return level.s_code4.var_263aa7ff;
}

/*
	Name: function_e0c5fd41
	Namespace: zm_office_ww_quest
	Checksum: 0x5D19D4A
	Offset: 0x2C40
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_e0c5fd41()
{
	self endon(#"death");
	waitresult = undefined;
	waitresult = self waittill(#"trigger");
	function_85bd10();
	waitframe(1);
	level.var_390ebc02 function_90489a6();
	zm_unitrigger::unregister_unitrigger(self.stub);
}

/*
	Name: function_85bd10
	Namespace: zm_office_ww_quest
	Checksum: 0xE889B128
	Offset: 0x2CD0
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_85bd10()
{
	function_65337201(5, level.s_code_machine.a_n_codes[3], 30);
	wait(1);
	level.s_code4 notify(#"code_revealed");
	level.s_code4.var_354f5b9b = 0;
	level thread function_f25bac74("t_code4_photo", #"hash_799f9af88bb20656");
}

/*
	Name: function_90489a6
	Namespace: zm_office_ww_quest
	Checksum: 0xB21B9AFF
	Offset: 0x2D68
	Size: 0x3A
	Parameters: 0
	Flags: Linked
*/
function function_90489a6()
{
	self movey(28, 1.5);
	self waittill(#"movedone");
}

/*
	Name: function_c056a0ad
	Namespace: zm_office_ww_quest
	Checksum: 0xEA7D4DC0
	Offset: 0x2DB0
	Size: 0xE6
	Parameters: 0
	Flags: Linked
*/
function function_c056a0ad()
{
	level.s_code4 endon(#"code_revealed", #"death");
	function_81ed41a8();
	while(true)
	{
		self hide();
		level.panic_room_monitor_light.fx delete();
		level.s_code4 waittill(#"code_available");
		self show();
		function_81ed41a8();
		level waittill(#"pack_room_reset");
		wait(1);
	}
}

/*
	Name: function_81ed41a8
	Namespace: zm_office_ww_quest
	Checksum: 0xF6329189
	Offset: 0x2EA0
	Size: 0x19C
	Parameters: 0
	Flags: Linked
*/
function function_81ed41a8()
{
	level._effect[#"panic_room_monitor_light"] = #"hash_10d93d34c24f01bd";
	level.var_c2f35c64 = level._effect[#"panic_room_monitor_light"];
	level.var_497a573d = getent("sadako_mover", "targetname");
	level.panic_room_monitor_light = getent("panic_room_monitor_light_origin", "targetname");
	level.panic_room_monitor_light.fx_ent = util::spawn_model("tag_origin", level.panic_room_monitor_light.origin);
	level.panic_room_monitor_light.fx_ent.angles = level.panic_room_monitor_light.angles;
	level.panic_room_monitor_light = getent("panic_room_monitor_light_origin", "targetname");
	level.panic_room_monitor_light.fx = playfxontag(level.var_c2f35c64, level.panic_room_monitor_light.fx_ent, "tag_origin");
	level.panic_room_monitor_light.fx linkto(level.var_497a573d);
}

/*
	Name: function_fec4fc26
	Namespace: zm_office_ww_quest
	Checksum: 0x1A5142BC
	Offset: 0x3048
	Size: 0xB2
	Parameters: 1
	Flags: Linked
*/
function function_fec4fc26(s_switch)
{
	if(!level.s_code4.var_354f5b9b)
	{
		return;
	}
	if(level.s_code4.var_32830f90 == s_switch.script_int)
	{
		level.s_code4.var_32830f90++;
		level.s_code4.var_263aa7ff = level.s_code4.var_32830f90 > 3;
		level.s_code4 notify(#"code_available");
	}
	else
	{
		level.s_code4.var_354f5b9b = 0;
	}
}

/*
	Name: function_c9559668
	Namespace: zm_office_ww_quest
	Checksum: 0xEC5E0A4D
	Offset: 0x3108
	Size: 0x26
	Parameters: 0
	Flags: Linked
*/
function function_c9559668()
{
	self.var_32830f90 = 0;
	self.var_354f5b9b = 1;
	self.var_263aa7ff = 0;
}

/*
	Name: function_28e65bfe
	Namespace: zm_office_ww_quest
	Checksum: 0xDF526665
	Offset: 0x3138
	Size: 0x60
	Parameters: 0
	Flags: Linked
*/
function function_28e65bfe()
{
	self endon(#"code_revealed", #"death");
	while(true)
	{
		level waittill(#"pack_room_reset");
		self function_c9559668();
	}
}

/*
	Name: function_f25bac74
	Namespace: zm_office_ww_quest
	Checksum: 0xF5891267
	Offset: 0x31A0
	Size: 0xDC
	Parameters: 2
	Flags: Linked
*/
function function_f25bac74(trigger, alias)
{
	self endon(#"death");
	if(isdefined(trigger) && isdefined(alias))
	{
		var_849ee9f4 = getent(trigger, "targetname");
		if(isdefined(var_849ee9f4))
		{
			level thread trigger::look_trigger(var_849ee9f4);
			waitresult = undefined;
			waitresult = var_849ee9f4 waittill(#"trigger_look");
			var_849ee9f4 delete();
			waitresult.activator thread zm_vo::function_a2bd5a0c(alias);
		}
	}
}

