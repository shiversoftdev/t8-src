// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_29b970364d23b9;
#using script_3f9e0dc8454d98e1;
#using script_52c6c2d1a2ef1b46;
#using script_6e3c826b1814cab6;
#using script_7c62f55ce3a557ff;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\fx_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm\zm_escape.gsc;
#using scripts\zm\zm_escape_util.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_pack_a_punch.gsc;
#using scripts\zm_common\zm_power.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace pap_quest;

/*
	Name: function_89f2df9
	Namespace: pap_quest
	Checksum: 0xE200B596
	Offset: 0x328
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"pap_quest", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: pap_quest
	Checksum: 0xE6F0BD49
	Offset: 0x378
	Size: 0x1F4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.pack_a_punch.custom_power_think = &function_124362b5;
	level._effect[#"lightning_near"] = "maps/zm_escape/fx8_pap_lightning_near";
	level._effect[#"lightning_bridge"] = "maps/zm_escape/fx8_pap_lightning_bridge";
	level flag::init(#"pap_quest_completed");
	scene::add_scene_func(#"hash_5220785f163cc4fc", &function_26cff57, "play");
	scene::add_scene_func(#"hash_55c695e9e345c653", &function_f7af87b9, "play");
	scene::add_scene_func(#"hash_4a8917199f6efb09", &function_cf48a8f2, "play");
	scene::add_scene_func(#"hash_41fada5e44b023a9", &function_86f1ed70, "play");
	scene::add_scene_func(#"hash_c09d814252d9522", &function_8d3078dc, "play");
	scene::add_scene_func(#"hash_7cc7d9f749a02418", &function_a340ee90, "play");
	function_842831cf();
}

/*
	Name: function_842831cf
	Namespace: pap_quest
	Checksum: 0xD927866A
	Offset: 0x578
	Size: 0x84
	Parameters: 0
	Flags: Linked, Private
*/
private function function_842831cf()
{
	clientfield::register("world", "" + #"hash_3fcd3bbe36f86e4b", 1, 1, "counter");
	clientfield::register("scriptmover", "" + #"lightning_near", 1, 1, "counter");
}

/*
	Name: __main__
	Namespace: pap_quest
	Checksum: 0x9A5BDA67
	Offset: 0x608
	Size: 0x17C
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	if(namespace_59ff1d6c::function_901b751c(#"hash_19d48a0d4490b0a2") == 1)
	{
		level thread function_1ab4e68();
	}
	else if(namespace_59ff1d6c::function_901b751c(#"hash_19d48a0d4490b0a2") == 0)
	{
		var_9aa0f846 = getentarray("zm_pack_a_punch", "targetname");
		foreach(var_532cdfcf in var_9aa0f846)
		{
			var_532cdfcf zm_pack_a_punch::set_state_initial();
			var_532cdfcf zm_pack_a_punch::set_state_hidden();
		}
	}
	level thread function_ccb1f009();
	if(namespace_59ff1d6c::function_901b751c(#"hash_19d48a0d4490b0a2") == 2)
	{
		level thread function_62933c32();
	}
}

/*
	Name: function_62933c32
	Namespace: pap_quest
	Checksum: 0xF56F4277
	Offset: 0x790
	Size: 0x12C
	Parameters: 0
	Flags: Linked
*/
function function_62933c32()
{
	level flag::wait_till("start_zombie_round_logic");
	var_9cb363eb = getentarray("zm_pack_a_punch", "targetname");
	foreach(var_ec37ff4e in var_9cb363eb)
	{
		var_ec37ff4e zm_pack_a_punch::function_bb629351(1);
		function_dc8a02bf(0, var_ec37ff4e.script_string);
	}
	level namespace_6747c550::function_7df6bb60(#"hash_7629706a5a9c7bf7", 1);
	level flag::set(#"pap_quest_completed");
}

/*
	Name: function_124362b5
	Namespace: pap_quest
	Checksum: 0xDDBD4BDA
	Offset: 0x8C8
	Size: 0x342
	Parameters: 1
	Flags: Linked
*/
function function_124362b5(var_634ce82e)
{
	level flag::wait_till("start_zombie_round_logic");
	switch(namespace_59ff1d6c::function_901b751c(#"hash_19d48a0d4490b0a2"))
	{
		case 1:
		{
			self zm_pack_a_punch::set_state_hidden();
			if(self.script_string == "roof")
			{
				level flag::wait_till("power_on1");
				var_a8d69fbd = getent("pap_shock_box", "script_string");
				var_24c740a5 = 0;
				while(!var_24c740a5)
				{
					var_88706ea7 = undefined;
					var_88706ea7 = var_a8d69fbd waittill(#"hash_7e1d78666f0be68b");
					if(isalive(var_88706ea7.e_player))
					{
						str_zone = var_88706ea7.e_player zm_zonemgr::get_player_zone();
						if(isdefined(str_zone) && (str_zone == "zone_roof" || str_zone == "zone_roof_infirmary"))
						{
							var_24c740a5 = 1;
						}
						else
						{
							var_a8d69fbd notify(#"turn_off");
						}
					}
					else
					{
						var_24c740a5 = 1;
					}
				}
				var_a8d69fbd playsound(#"hash_3a18ced95ae72103");
				var_a8d69fbd playloopsound(#"hash_3a1bb2d95ae92746");
				var_a8d69fbd notify(#"hash_7f8e7011812dff48");
				wait(2);
				e_player = zm_utility::get_closest_player(var_a8d69fbd.origin);
				e_player thread zm_audio::create_and_play_dialog(#"pap", #"build", undefined, 1);
				scene::play(#"hash_5220785f163cc4fc");
				self zm_pack_a_punch::function_bb629351(1);
				self thread function_c0bc0375();
				level namespace_6747c550::function_7df6bb60(#"hash_7629706a5a9c7bf7", 1);
				level flag::set(#"pap_quest_completed");
				util::delay(30, "game_over", &function_3357bedc);
			}
			break;
		}
	}
}

/*
	Name: function_3357bedc
	Namespace: pap_quest
	Checksum: 0xCA78879E
	Offset: 0xC18
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_3357bedc()
{
	level thread zm_audio::function_8557c25d(#"hash_676a058bfe70473", 1);
}

/*
	Name: function_26cff57
	Namespace: pap_quest
	Checksum: 0x7DBAA1D8
	Offset: 0xC50
	Size: 0x18C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_26cff57(a_ents)
{
	a_ents[#"pap"] thread function_59093304("roof", 1);
	if(!level flag::get(#"pap_quest_completed"))
	{
		var_c684828e = struct::get("lightning_bridge");
		level clientfield::increment("" + #"hash_3fcd3bbe36f86e4b");
		playsoundatposition(#"hash_7804a63a2ff82145", var_c684828e.origin);
		a_ents[#"pap"] waittill(#"fade_in_end");
		var_50083f49 = struct::get("lightning_near");
		wait(1);
		e_player = zm_utility::get_closest_player(var_50083f49.origin);
		e_player zm_audio::create_and_play_dialog(#"pap", #"react", undefined, 1);
	}
}

/*
	Name: function_f7af87b9
	Namespace: pap_quest
	Checksum: 0x932689D6
	Offset: 0xDE8
	Size: 0x3C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_f7af87b9(a_ents)
{
	a_ents[#"pap"] thread function_59093304("building_64");
}

/*
	Name: function_cf48a8f2
	Namespace: pap_quest
	Checksum: 0x7668665A
	Offset: 0xE30
	Size: 0x3C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_cf48a8f2(a_ents)
{
	a_ents[#"pap"] thread function_59093304("power_house");
}

/*
	Name: function_59093304
	Namespace: pap_quest
	Checksum: 0x945572CA
	Offset: 0xE78
	Size: 0x184
	Parameters: 2
	Flags: Linked, Private
*/
private function function_59093304(str_zone, var_e07ad59f = 0)
{
	self ghost();
	self waittill(#"fade_in_start");
	self show();
	self clientfield::set("" + #"hash_504d26c38b96651c", 1);
	if(var_e07ad59f)
	{
		var_50083f49 = struct::get("lightning_near");
		playsoundatposition(#"hash_6c4553b9c8847808", var_50083f49.origin);
	}
	else
	{
		playsoundatposition(#"hash_6c4553b9c8847808", self.origin);
	}
	self waittill(#"fade_in_end");
	self clientfield::increment("" + #"lightning_near");
	self waittill(#"hash_70a2c4514f6a6448");
	function_dc8a02bf(0, str_zone);
}

/*
	Name: function_86f1ed70
	Namespace: pap_quest
	Checksum: 0x91B7D130
	Offset: 0x1008
	Size: 0x94
	Parameters: 1
	Flags: Linked, Private
*/
private function function_86f1ed70(a_ents)
{
	a_ents[#"pap"] thread function_25adf2e0("roof", #"hash_79b5f8e539d36a49");
	a_ents[#"pap"] clientfield::set("" + #"hash_504d26c38b96651c", 1);
}

/*
	Name: function_8d3078dc
	Namespace: pap_quest
	Checksum: 0x302789F1
	Offset: 0x10A8
	Size: 0x94
	Parameters: 1
	Flags: Linked, Private
*/
private function function_8d3078dc(a_ents)
{
	a_ents[#"pap"] thread function_25adf2e0("building_64", #"hash_1fc69d74f13da62e");
	a_ents[#"pap"] clientfield::set("" + #"hash_504d26c38b96651c", 1);
}

/*
	Name: function_a340ee90
	Namespace: pap_quest
	Checksum: 0x9EDA8F36
	Offset: 0x1148
	Size: 0x94
	Parameters: 1
	Flags: Linked, Private
*/
private function function_a340ee90(a_ents)
{
	a_ents[#"pap"] thread function_25adf2e0("power_house", #"hash_6d668f3614ed2393");
	a_ents[#"pap"] clientfield::set("" + #"hash_504d26c38b96651c", 1);
}

/*
	Name: function_25adf2e0
	Namespace: pap_quest
	Checksum: 0x791515BA
	Offset: 0x11E8
	Size: 0xF4
	Parameters: 2
	Flags: Linked, Private
*/
private function function_25adf2e0(str_zone, var_410775ce)
{
	self ghost();
	self waittill(#"fade_in_start");
	self show();
	self clientfield::increment("" + #"lightning_near");
	playsoundatposition(#"hash_6c4553b9c8847808", self.origin);
	self waittill(#"hash_6e01c8802b774012");
	function_dc8a02bf(1, str_zone);
	level notify(var_410775ce);
	self ghost();
}

/*
	Name: function_dc8a02bf
	Namespace: pap_quest
	Checksum: 0x41EB4D63
	Offset: 0x12E8
	Size: 0x160
	Parameters: 2
	Flags: Linked
*/
function function_dc8a02bf(b_show, str_area)
{
	var_6f9dea08 = getentarray("debris_pap_" + str_area, "targetname");
	if(b_show)
	{
		foreach(var_e87b7ad1 in var_6f9dea08)
		{
			var_e87b7ad1 solid();
			var_e87b7ad1 show();
		}
	}
	else
	{
		foreach(var_e87b7ad1 in var_6f9dea08)
		{
			var_e87b7ad1 notsolid();
			var_e87b7ad1 hide();
		}
	}
}

/*
	Name: function_1ab4e68
	Namespace: pap_quest
	Checksum: 0xCBE06377
	Offset: 0x1450
	Size: 0x114
	Parameters: 0
	Flags: Linked
*/
function function_1ab4e68()
{
	if(namespace_59ff1d6c::function_901b751c(#"zmpowerstate") == 1)
	{
		level flag::wait_till("power_on1");
		if(!level flag::get("power_on"))
		{
			level thread namespace_961cf978::attempt_brutus_spawn(1, "zone_studio");
		}
	}
	level waittill(#"hash_222aa78f79091e7");
	if(namespace_59ff1d6c::function_901b751c(#"hash_19d48a0d4490b0a2") != 2 && (!(isdefined(level.var_af325495) && level.var_af325495)))
	{
		level thread namespace_961cf978::attempt_brutus_spawn(1, "zone_roof");
	}
}

/*
	Name: function_ccb1f009
	Namespace: pap_quest
	Checksum: 0xF34BDDD9
	Offset: 0x1570
	Size: 0x264
	Parameters: 0
	Flags: Linked
*/
function function_ccb1f009()
{
	level endon(#"power_on1");
	var_5ae7f356 = getentarray("building_64_switches", "script_noteworthy");
	var_bfcb0a68 = [];
	var_50684754 = randomintrange(0, var_5ae7f356.size) + 1;
	var_e60e71b7 = getentarray("building_64_switch_" + var_50684754, "script_string");
	foreach(var_9f5d5d73 in var_e60e71b7)
	{
		if(array::contains(var_5ae7f356, var_9f5d5d73))
		{
			var_bb6e9418 = var_9f5d5d73;
			var_bb6e9418 thread namespace_a0f5c7fc::function_350029c6();
		}
	}
	var_d40e1ced = 0.1;
	foreach(var_74afc0d5 in var_5ae7f356)
	{
		if(var_74afc0d5 != var_bb6e9418)
		{
			var_74afc0d5 thread function_1f54733b(var_d40e1ced);
			if(!isdefined(var_bfcb0a68))
			{
				var_bfcb0a68 = [];
			}
			else if(!isarray(var_bfcb0a68))
			{
				var_bfcb0a68 = array(var_bfcb0a68);
			}
			var_bfcb0a68[var_bfcb0a68.size] = var_74afc0d5;
		}
		var_d40e1ced = var_d40e1ced + 0.1;
	}
	level thread function_2d70fe2b(var_bfcb0a68);
}

/*
	Name: function_1f54733b
	Namespace: pap_quest
	Checksum: 0xA85F98A7
	Offset: 0x17E0
	Size: 0x11E
	Parameters: 1
	Flags: Linked
*/
function function_1f54733b(var_d40e1ced = 0)
{
	level endon(#"power_on1");
	self setinvisibletoall();
	a_e_parts = getentarray(self.target, "targetname");
	foreach(e_part in a_e_parts)
	{
		if(isdefined(e_part.script_noteworthy))
		{
			self thread function_1106e7e8(e_part, var_d40e1ced);
			var_d40e1ced = var_d40e1ced + 0.1;
		}
	}
	self notify(#"hash_21e36726a7f30458");
}

/*
	Name: function_1106e7e8
	Namespace: pap_quest
	Checksum: 0xEC71BD24
	Offset: 0x1908
	Size: 0x8C
	Parameters: 2
	Flags: Linked
*/
function function_1106e7e8(master_switch, n_delay = 0)
{
	level flag::wait_till("start_zombie_round_logic");
	wait(n_delay);
	zm_escape::function_9738dcda(master_switch);
	level flag::wait_till("power_on1");
	wait(n_delay);
	zm_escape::function_3fcd201d(master_switch);
}

/*
	Name: function_2d70fe2b
	Namespace: pap_quest
	Checksum: 0x1D823309
	Offset: 0x19A0
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_2d70fe2b(var_bfcb0a68)
{
	level flag::wait_till("power_on1");
	array::delete_all(var_bfcb0a68);
}

/*
	Name: function_c0bc0375
	Namespace: pap_quest
	Checksum: 0x87550BC0
	Offset: 0x19F0
	Size: 0x48A
	Parameters: 0
	Flags: Linked
*/
function function_c0bc0375()
{
	if(namespace_59ff1d6c::function_901b751c(#"hash_19d48a0d4490b0a2") == 2)
	{
		return 0;
	}
	self endon(#"hash_168e8f0e18a79cf8");
	switch(self.script_string)
	{
		case "roof":
		{
			var_45827936 = "lgtexp_pap_rooftops_on";
			break;
		}
		case "building_64":
		{
			var_45827936 = "lgtexp_pap_b64_on";
			break;
		}
		case "power_house":
		{
			var_45827936 = "lgtexp_pap_powerhouse_on";
			break;
		}
	}
	exploder::exploder(var_45827936);
	if(isdefined(level.var_a929ea7f) && level.var_a929ea7f)
	{
		level.var_2ba5b206 = level.round_number + 1;
	}
	else
	{
		level.var_2ba5b206 = level.round_number + function_21a3a673(2, 4);
	}
	while(true)
	{
		level waittill(#"end_of_round");
		if(level.round_number >= level.var_2ba5b206 && !zm_utility::is_standard())
		{
			exploder::stop_exploder(var_45827936);
			self zm_pack_a_punch::function_bb629351(0);
			switch(self.script_string)
			{
				case "roof":
				{
					level thread scene::play(#"hash_41fada5e44b023a9");
					break;
				}
				case "building_64":
				{
					level thread scene::play(#"hash_c09d814252d9522");
					break;
				}
				case "power_house":
				{
					level thread scene::play(#"hash_7cc7d9f749a02418");
					break;
				}
			}
			level waittill(#"hash_29eff9df29117312");
			self zm_pack_a_punch::function_bb629351(0, "hidden");
			self zm_pack_a_punch::set_state_hidden();
			level waittill(#"hash_79b5f8e539d36a49", #"hash_1fc69d74f13da62e", #"hash_6d668f3614ed2393");
			var_9cb363eb = getentarray("zm_pack_a_punch", "targetname");
			var_ec37ff4e = self;
			while(self == var_ec37ff4e)
			{
				var_ec37ff4e = array::random(var_9cb363eb);
			}
			wait(5);
			switch(var_ec37ff4e.script_string)
			{
				case "roof":
				{
					level scene::play(#"hash_5220785f163cc4fc");
					break;
				}
				case "building_64":
				{
					level scene::play(#"hash_55c695e9e345c653");
					break;
				}
				case "power_house":
				{
					level scene::play(#"hash_4a8917199f6efb09");
					break;
				}
			}
			var_ec37ff4e zm_pack_a_punch::function_bb629351(1);
			function_dc8a02bf(0, var_ec37ff4e.script_string);
			var_ec37ff4e thread function_c0bc0375();
			self notify(#"hash_168e8f0e18a79cf8");
		}
	}
}

