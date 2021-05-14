// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_266240d702093827;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_9d301ad2;

/*
	Name: init
	Namespace: namespace_9d301ad2
	Checksum: 0x76F7D142
	Offset: 0x2C8
	Size: 0x2A4
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level flag::init(#"hash_26c0c05d0a3e382f");
	level flag::init(#"hash_549663968279d569");
	level flag::init(#"hash_6205682540170b8");
	level._effect[#"hash_3ecc995bb97331ac"] = #"hash_37631c88b85a74ec";
	level.var_c1549bc8 = spawnstruct();
	level.var_c1549bc8.var_25f5a473 = struct::get_array("s_pyre");
	foreach(s_stub in level.var_c1549bc8.var_25f5a473)
	{
		mdl = getent(s_stub.target, "targetname");
		mdl hide();
	}
	if(!zm_utility::function_e51dc2d8())
	{
		return;
	}
	level.var_c1549bc8.var_3e762bf6 = 0;
	level.var_c1549bc8.var_f06465e0 = getent("t_pyre_on", "targetname");
	level.var_c1549bc8.var_a1d1197d = 0;
	callback::on_connect(&function_4ff8ad95);
	callback::on_ai_killed(&function_aee836e9);
	level thread function_125dfe69();
	level thread function_fb74fc5f();
	level thread function_1e32e900();
	level thread arena_rock();
	level thread function_1eddbf9e();
}

/*
	Name: function_4ff8ad95
	Namespace: namespace_9d301ad2
	Checksum: 0xA3C592A5
	Offset: 0x578
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_4ff8ad95()
{
	self endon(#"disconnect");
	while(!isdefined(level.var_c1549bc8.var_a1d1197d))
	{
		waitframe(1);
	}
	if(level.var_c1549bc8.var_a1d1197d < 3)
	{
		level.var_c1549bc8.var_f06465e0 setinvisibletoplayer(self);
	}
	self flag::init(#"hash_381b60178f34f12");
	self thread function_def71ac3();
}

/*
	Name: function_aee836e9
	Namespace: namespace_9d301ad2
	Checksum: 0xB7DA5FB0
	Offset: 0x630
	Size: 0x50
	Parameters: 0
	Flags: Linked
*/
function function_aee836e9()
{
	str_zone = zm_zonemgr::get_zone_from_position(self.origin);
	if(str_zone === "zone_zeus_basement")
	{
		level notify(#"hash_4ee1ab78c1a0dadb");
	}
}

/*
	Name: function_125dfe69
	Namespace: namespace_9d301ad2
	Checksum: 0x662759B2
	Offset: 0x688
	Size: 0xC0
	Parameters: 0
	Flags: Linked
*/
function function_125dfe69()
{
	level endon(#"end_game", #"hash_26c0c05d0a3e382f");
	while(true)
	{
		level waittill(#"hash_4ee1ab78c1a0dadb");
		level.var_c1549bc8.var_3e762bf6++;
		if(level.var_c1549bc8.var_3e762bf6 >= 831)
		{
			level flag::set(#"hash_26c0c05d0a3e382f");
			callback::remove_on_ai_killed(&function_aee836e9);
		}
	}
}

/*
	Name: function_fb74fc5f
	Namespace: namespace_9d301ad2
	Checksum: 0xC431673
	Offset: 0x750
	Size: 0x52C
	Parameters: 0
	Flags: Linked
*/
function function_fb74fc5f()
{
	level.var_c1549bc8.var_37676611 = [];
	if(!isdefined(level.var_c1549bc8.var_37676611))
	{
		level.var_c1549bc8.var_37676611 = [];
	}
	else if(!isarray(level.var_c1549bc8.var_37676611))
	{
		level.var_c1549bc8.var_37676611 = array(level.var_c1549bc8.var_37676611);
	}
	level.var_c1549bc8.var_37676611[level.var_c1549bc8.var_37676611.size] = getent("mdl_toothpick", "targetname");
	if(!isdefined(level.var_c1549bc8.var_37676611))
	{
		level.var_c1549bc8.var_37676611 = [];
	}
	else if(!isarray(level.var_c1549bc8.var_37676611))
	{
		level.var_c1549bc8.var_37676611 = array(level.var_c1549bc8.var_37676611);
	}
	level.var_c1549bc8.var_37676611[level.var_c1549bc8.var_37676611.size] = getent("mdl_feathers", "targetname");
	if(!isdefined(level.var_c1549bc8.var_37676611))
	{
		level.var_c1549bc8.var_37676611 = [];
	}
	else if(!isarray(level.var_c1549bc8.var_37676611))
	{
		level.var_c1549bc8.var_37676611 = array(level.var_c1549bc8.var_37676611);
	}
	level.var_c1549bc8.var_37676611[level.var_c1549bc8.var_37676611.size] = getent("mdl_tankard", "targetname");
	foreach(mdl in level.var_c1549bc8.var_37676611)
	{
		level flag::init(mdl.model + "_picked_up");
		level flag::init(mdl.model + "_placed");
		mdl thread function_6cfb44f0();
	}
	array::thread_all(level.var_c1549bc8.var_25f5a473, &function_3a6ce932);
	level flag::wait_till("all_players_spawned");
	while(level.var_c1549bc8.var_a1d1197d < 3)
	{
		waitframe(1);
	}
	playsoundatposition(#"hash_7f8f5a20e4b87aac", (0, 0, 0));
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = level waittill(#"hash_3042a9bf2f57ea0a");
		v_origin = var_be17187b.var_814c9389;
		if(isplayer(var_be17187b.attacker))
		{
			str_player_zone = var_be17187b.attacker.zone_name;
		}
		if(istouching(v_origin, level.var_c1549bc8.var_f06465e0) && str_player_zone === "zone_zeus_top_floor")
		{
			break;
		}
	}
	/#
		printtoprightln("");
	#/
	level flag::set(#"hash_549663968279d569");
	exploder::exploder("exp_blue_fire");
	level function_ad85b216();
}

/*
	Name: function_6cfb44f0
	Namespace: namespace_9d301ad2
	Checksum: 0x41006490
	Offset: 0xC88
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function function_6cfb44f0()
{
	level endon(#"end_game");
	self zm_unitrigger::function_fac87205(&function_77df7138);
	level flag::set(self.model + "_picked_up");
	self playsound(#"hash_3b838b7d3c19fd0a");
	self delete();
}

/*
	Name: function_77df7138
	Namespace: namespace_9d301ad2
	Checksum: 0xC20916C
	Offset: 0xD30
	Size: 0xFE
	Parameters: 1
	Flags: Linked
*/
function function_77df7138(e_player)
{
	if(!isdefined(e_player) || !isdefined(self) || !isdefined(self.stub) || !isdefined(self.stub.related_parent) || !isdefined(self.stub.related_parent.origin))
	{
		return 0;
	}
	var_5168e40f = e_player zm_utility::is_player_looking_at(self.stub.related_parent.origin, 0.96, 0);
	b_have = level flag::get(self.stub.related_parent.model + "_picked_up");
	return var_5168e40f && !b_have;
}

/*
	Name: function_3a6ce932
	Namespace: namespace_9d301ad2
	Checksum: 0xFDBF9998
	Offset: 0xE38
	Size: 0xD8
	Parameters: 0
	Flags: Linked
*/
function function_3a6ce932()
{
	level endon(#"end_game");
	zm_unitrigger::function_fac87205(&function_135e7d64);
	e_target = getent(self.target, "targetname");
	e_target show();
	e_target playsound(#"hash_27013ebd10f7b8c3");
	level flag::set(e_target.model + "_placed");
	level.var_c1549bc8.var_a1d1197d++;
}

/*
	Name: function_135e7d64
	Namespace: namespace_9d301ad2
	Checksum: 0x2287BE62
	Offset: 0xF18
	Size: 0x136
	Parameters: 1
	Flags: Linked
*/
function function_135e7d64(e_player)
{
	s_parent = self.stub.related_parent;
	var_d4c288fb = getent(s_parent.target, "targetname");
	b_have = level flag::get(var_d4c288fb.model + "_picked_up");
	b_placed = level flag::get(var_d4c288fb.model + "_placed");
	var_5168e40f = e_player zm_utility::is_player_looking_at(s_parent.origin, 0.96, 0);
	return isdefined(b_have) && b_have && (isdefined(var_5168e40f) && var_5168e40f) && (isdefined(b_placed) && !b_placed);
}

/*
	Name: function_ad85b216
	Namespace: namespace_9d301ad2
	Checksum: 0xE78B939D
	Offset: 0x1058
	Size: 0x172
	Parameters: 0
	Flags: Linked
*/
function function_ad85b216()
{
	if(getdvarint(#"hash_11ad6a9695943217", 0))
	{
		var_10cba649 = 1;
	}
	else
	{
		var_10cba649 = 7;
	}
	level.var_c1549bc8.var_782576f8 = level.round_number + var_10cba649;
	while(level.round_number < level.var_c1549bc8.var_782576f8)
	{
		level waittill(#"end_of_round");
	}
	playsoundatposition("zmb_ee_brewing_done", (0, 0, 0));
	s_loc = struct::get("s_perk_drop");
	perk = zm_powerups::specific_powerup_drop("free_perk", s_loc.origin, #"allies", undefined, undefined, 1, 1);
	while(!isdefined(perk))
	{
		waitframe(1);
		perk = zm_powerups::specific_powerup_drop("free_perk", s_loc.origin, #"allies", undefined, undefined, 1, 1);
	}
}

/*
	Name: function_1e32e900
	Namespace: namespace_9d301ad2
	Checksum: 0x6952F7A3
	Offset: 0x11D8
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_1e32e900()
{
	callback::on_connect(&function_e1a7f79c);
	array::thread_all(level.players, &function_e1a7f79c);
	level thread function_4b01369a();
	level thread function_51817689();
}

/*
	Name: function_e1a7f79c
	Namespace: namespace_9d301ad2
	Checksum: 0x96AA71C2
	Offset: 0x1260
	Size: 0x1D4
	Parameters: 0
	Flags: Linked
*/
function function_e1a7f79c()
{
	self notify("2c01316cfc198070");
	self endon("2c01316cfc198070");
	level endon(#"end_game");
	self endon(#"disconnect");
	self flag::init(#"hash_481ca29c700e04dd");
	self flag::init(#"hash_6db6c5251c9721d6");
	self flag::init(#"hash_69c9295a1129268f");
	self flag::init(#"hash_23e1b3b7f7f46cb8");
	self flag::init(#"hash_6757075afacfc1b4");
	self.var_ea819a71 = [];
	self thread function_a0cf9801();
	self thread function_acbff22d();
	self flag::wait_till_all(array(#"hash_481ca29c700e04dd", #"hash_6db6c5251c9721d6", #"hash_69c9295a1129268f"));
	self flag::wait_till(#"hash_23e1b3b7f7f46cb8");
	self flag::set(#"hash_6757075afacfc1b4");
	self playsoundtoplayer(#"hash_3f4d4c01f45d3fa6", self);
}

/*
	Name: function_a0cf9801
	Namespace: namespace_9d301ad2
	Checksum: 0xF4878C36
	Offset: 0x1440
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_a0cf9801()
{
	self notify("6b57f941604a9c43");
	self endon("6b57f941604a9c43");
	level endon(#"end_game");
	self endon(#"disconnect");
	self waittill(#"hash_731c84be18ae9fa3");
	self flag::set(#"hash_6db6c5251c9721d6");
}

/*
	Name: function_acbff22d
	Namespace: namespace_9d301ad2
	Checksum: 0x253236B8
	Offset: 0x14C8
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_acbff22d()
{
	self notify("4058048e430c1831");
	self endon("4058048e430c1831");
	level endon(#"end_game");
	self endon(#"disconnect");
	self waittill(#"hash_60f39c53ee3e0ec7");
	self flag::set(#"hash_69c9295a1129268f");
}

/*
	Name: function_4b01369a
	Namespace: namespace_9d301ad2
	Checksum: 0xA9148121
	Offset: 0x1550
	Size: 0xB0
	Parameters: 0
	Flags: Linked
*/
function function_4b01369a()
{
	level endon(#"end_game");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = level waittill(#"trap_activated");
		var_9bda8088 = var_be17187b.trap;
		var_d7a9a6d6 = var_9bda8088.var_a1aa5fa1;
		if(isdefined(var_d7a9a6d6))
		{
			array::thread_all(level.players, &function_294c9ea7, var_d7a9a6d6);
		}
	}
}

/*
	Name: function_294c9ea7
	Namespace: namespace_9d301ad2
	Checksum: 0x56A28E
	Offset: 0x1608
	Size: 0x13C
	Parameters: 1
	Flags: Linked
*/
function function_294c9ea7(var_d7a9a6d6)
{
	level endon(#"end_game", #"hash_189e686c493a2a23");
	self endon(#"disconnect");
	if(self flag::get(#"hash_481ca29c700e04dd"))
	{
		return;
	}
	var_3520f942 = trigger::wait_till(var_d7a9a6d6, "targetname", self);
	while(true)
	{
		t_exit = trigger::wait_till(var_d7a9a6d6, "targetname", self);
		if(t_exit != var_3520f942 && (!(isdefined(self.var_62b59590) && self.var_62b59590)) && zm_utility::is_player_valid(self, 0, 0))
		{
			self flag::set(#"hash_481ca29c700e04dd");
			break;
		}
	}
}

/*
	Name: function_51817689
	Namespace: namespace_9d301ad2
	Checksum: 0xB0F8F179
	Offset: 0x1750
	Size: 0x388
	Parameters: 0
	Flags: Linked
*/
function function_51817689()
{
	level endon(#"end_game");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = level waittill(#"trap_kill");
		ai_victim = var_be17187b.e_victim;
		e_trap = var_be17187b.e_trap;
		e_player = e_trap.activated_by_player;
		if(isplayer(e_player) && isactor(ai_victim))
		{
			str_archetype = ai_victim.archetype;
			var_1e137cec = ai_victim.var_9fde8624;
			switch(str_archetype)
			{
				case "zombie":
				{
					if(!isdefined(e_player.var_ea819a71))
					{
						e_player.var_ea819a71 = [];
					}
					else if(!isarray(e_player.var_ea819a71))
					{
						e_player.var_ea819a71 = array(e_player.var_ea819a71);
					}
					if(!isinarray(e_player.var_ea819a71, str_archetype))
					{
						e_player.var_ea819a71[e_player.var_ea819a71.size] = str_archetype;
					}
					break;
				}
				case "tiger":
				{
					if(!isdefined(e_player.var_ea819a71))
					{
						e_player.var_ea819a71 = [];
					}
					else if(!isarray(e_player.var_ea819a71))
					{
						e_player.var_ea819a71 = array(e_player.var_ea819a71);
					}
					if(!isinarray(e_player.var_ea819a71, str_archetype))
					{
						e_player.var_ea819a71[e_player.var_ea819a71.size] = str_archetype;
					}
					break;
				}
				case "catalyst":
				{
					if(!isdefined(e_player.var_ea819a71))
					{
						e_player.var_ea819a71 = [];
					}
					else if(!isarray(e_player.var_ea819a71))
					{
						e_player.var_ea819a71 = array(e_player.var_ea819a71);
					}
					if(!isinarray(e_player.var_ea819a71, var_1e137cec))
					{
						e_player.var_ea819a71[e_player.var_ea819a71.size] = var_1e137cec;
					}
					break;
				}
			}
			if(e_player.var_ea819a71.size >= 6)
			{
				e_player flag::set(#"hash_23e1b3b7f7f46cb8");
			}
		}
	}
}

/*
	Name: arena_rock
	Namespace: namespace_9d301ad2
	Checksum: 0xD51149B6
	Offset: 0x1AE0
	Size: 0x14C
	Parameters: 0
	Flags: Linked
*/
function arena_rock()
{
	level endon(#"end_game");
	level.var_c1549bc8.var_7d942960 = 0;
	level function_5ca13573();
	callback::on_ai_killed(&function_4670ef4d);
	level function_c846dfc3();
	callback::remove_on_ai_killed(&function_4670ef4d);
	var_c2b730ca = getent("viking_salute", "targetname");
	var_c2b730ca thread function_3ce07a2b();
	level waittill(#"hash_621a1d521509753e");
	level flag::set(#"hash_6205682540170b8");
	level clientfield::set("" + #"hash_39e6b14b9e5b0f3d", 1);
}

/*
	Name: function_5ca13573
	Namespace: namespace_9d301ad2
	Checksum: 0xFF821EB6
	Offset: 0x1C38
	Size: 0xF2
	Parameters: 0
	Flags: Linked
*/
function function_5ca13573()
{
	level endon(#"end_game");
	var_bbd88248 = getent("firestorm_detector", "targetname");
	while(true)
	{
		var_6aa0de02 = undefined;
		var_6aa0de02 = var_bbd88248 waittill(#"damage");
		if(!level flag::get("special_round"))
		{
			continue;
		}
		if(namespace_52d8d460::function_a57b8fca(var_6aa0de02.weapon, 0))
		{
			var_6aa0de02.attacker playsoundtoplayer("zmb_ee_gtr_sting_1", var_6aa0de02.attacker);
			return;
		}
	}
}

/*
	Name: function_4670ef4d
	Namespace: namespace_9d301ad2
	Checksum: 0x966919C9
	Offset: 0x1D38
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function function_4670ef4d()
{
	if(!(isdefined(isplayer(self.attacker)) && isplayer(self.attacker)))
	{
		return;
	}
	e_attacker = self.attacker;
	if(!isinarray(e_attacker.aat, #"zm_aat_kill_o_watt"))
	{
		return;
	}
	if(self.damagelocation === "helmet" || self.damagelocation === "head" || self.damagelocation === "neck")
	{
		level notify(#"hash_5a1a76d189cf6925");
		level.var_c1549bc8.var_7d942960++;
		self playsound("zmb_ee_gtr_sting_" + level.var_c1549bc8.var_7d942960);
	}
}

/*
	Name: function_c846dfc3
	Namespace: namespace_9d301ad2
	Checksum: 0x4F41779F
	Offset: 0x1E60
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function function_c846dfc3()
{
	level endon(#"end_game");
	while(true)
	{
		level waittill(#"hash_5a1a76d189cf6925");
		if(level.var_c1549bc8.var_7d942960 >= 8)
		{
			return;
		}
	}
}

/*
	Name: function_3ce07a2b
	Namespace: namespace_9d301ad2
	Checksum: 0xA723CAF2
	Offset: 0x1EC8
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function function_3ce07a2b()
{
	level endon(#"game_end", #"hash_621a1d521509753e");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"damage");
		e_attacker = var_be17187b.attacker;
		if(!isplayer(e_attacker))
		{
			continue;
		}
		if(namespace_52d8d460::function_a57b8fca(var_be17187b.weapon, 0) && e_attacker.var_c9d375dc.b_charged)
		{
			str_player_zone = var_be17187b.attacker.zone_name;
			if(str_player_zone == "zone_odin_top_floor")
			{
				e_attacker thread function_2ea36422();
				level notify(#"hash_621a1d521509753e");
			}
		}
	}
}

/*
	Name: function_2ea36422
	Namespace: namespace_9d301ad2
	Checksum: 0xF685DDBF
	Offset: 0x1FF0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_2ea36422()
{
	self endon(#"disconnect");
	for(i = 1; i > 8; i++)
	{
		self playsound("zmb_ee_gtr_sting_" + i);
		wait(2);
	}
}

/*
	Name: function_5d0d1807
	Namespace: namespace_9d301ad2
	Checksum: 0x8A299C6D
	Offset: 0x2060
	Size: 0x258
	Parameters: 0
	Flags: Linked
*/
function function_5d0d1807()
{
	var_9788a49a = getentarray("elevated_flames", "targetname");
	level thread scene::init("special_rounds_scene_alt", "targetname");
	foreach(model in var_9788a49a)
	{
		model clientfield::set("" + #"hash_5afda864f8b64f5c", 1);
	}
	level waittill(#"hash_7b9245ff51f3d4f7");
	a_scenes = struct::get_array("special_rounds_scene_alt", "targetname");
	foreach(s_scene in a_scenes)
	{
		playfx(level._effect[#"hash_3ecc995bb97331ac"], s_scene.origin);
		s_scene scene::stop(1);
	}
	foreach(model in var_9788a49a)
	{
		model clientfield::set("" + #"hash_5afda864f8b64f5c", 0);
	}
}

/*
	Name: function_1eddbf9e
	Namespace: namespace_9d301ad2
	Checksum: 0x9EDCB7F6
	Offset: 0x22C0
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function function_1eddbf9e()
{
	level endon(#"end_game", #"hash_205c15aeab8e14c4");
	var_c265cd7f = 0;
	while(true)
	{
		s_result = undefined;
		s_result = level waittill(#"hash_46267aa0f17a3c00");
		if(isdefined(s_result.var_8571ab76) && s_result.var_8571ab76)
		{
			var_c265cd7f++;
			if(var_c265cd7f == level.players.size)
			{
				level thread function_c74f4cf4();
			}
		}
		else
		{
			var_c265cd7f--;
			level notify(#"hash_5bc627cff03bad5");
		}
	}
}

/*
	Name: function_c74f4cf4
	Namespace: namespace_9d301ad2
	Checksum: 0x22782E73
	Offset: 0x23A8
	Size: 0xBA
	Parameters: 0
	Flags: Linked
*/
function function_c74f4cf4()
{
	level endon(#"end_game", #"hash_5bc627cff03bad5");
	var_22fbe1cc = 0;
	while(true)
	{
		level waittill(#"end_of_round");
		var_22fbe1cc++;
		if(var_22fbe1cc >= 7)
		{
			level notify(#"hash_205c15aeab8e14c4");
			level thread zm_audio::sndmusicsystem_stopandflush();
			waitframe(1);
			level thread zm_audio::sndmusicsystem_playstate("ee_song_2");
			return;
		}
	}
}

/*
	Name: function_def71ac3
	Namespace: namespace_9d301ad2
	Checksum: 0x38AE2860
	Offset: 0x2470
	Size: 0x114
	Parameters: 0
	Flags: Linked
*/
function function_def71ac3()
{
	self endon(#"disconnect");
	level endon(#"hash_205c15aeab8e14c4");
	while(true)
	{
		self waittill(#"hash_29bd5874900989d6");
		if(self.var_b3122c84 == #"hash_4a67009994e6a476" && (!(isdefined(self.var_a4ab5d88) && self.var_a4ab5d88)))
		{
			self.var_a4ab5d88 = 1;
			level notify(#"hash_46267aa0f17a3c00", {#hash_8571ab76:1});
		}
		else if(isdefined(self.var_a4ab5d88) && self.var_a4ab5d88)
		{
			self.var_a4ab5d88 = 0;
			level notify(#"hash_46267aa0f17a3c00", {#hash_8571ab76:0});
		}
	}
}

