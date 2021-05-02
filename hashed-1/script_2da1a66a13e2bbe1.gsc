// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_24c32478acf44108;
#using script_28b18e98462a3c7c;
#using script_33fd053376f47476;
#using script_3cebb48c37fc271;
#using script_3f9e0dc8454d98e1;
#using script_43e752475599d64c;
#using script_48dd035d23bf8844;
#using script_50a21e465d6bb7a2;
#using script_510a7c58311cd7b5;
#using script_6a3f43063dfd1bdc;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\perks.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm\zm_white.gsc;
#using scripts\zm\zm_white_util.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_pack_a_punch.gsc;
#using scripts\zm_common\zm_pack_a_punch_util.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_fddd83bd;

/*
	Name: init
	Namespace: namespace_fddd83bd
	Checksum: 0x817A1DF2
	Offset: 0x3E8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function init()
{
	init_clientfields();
}

/*
	Name: init_clientfields
	Namespace: namespace_fddd83bd
	Checksum: 0xC11CE543
	Offset: 0x408
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("scriptmover", "" + #"hash_7876f33937c8a764", 20000, 1, "int");
}

/*
	Name: fall
	Namespace: namespace_fddd83bd
	Checksum: 0x2142E624
	Offset: 0x458
	Size: 0x174
	Parameters: 0
	Flags: Linked
*/
function fall()
{
	/#
		iprintlnbold("");
	#/
	level thread namespace_9cf755b::function_ec34b5ee(#"hash_2c4fa652fb89d231");
	n_end_time = gettime() + 300000;
	while(gettime() < n_end_time)
	{
		wait(randomfloatrange(2, 4));
		zombies = getaiarray();
		foreach(zombie in zombies)
		{
			if(math::cointoss(33))
			{
				zombie zombie_utility::setup_zombie_knockdown(zombie.var_93a62fe);
			}
		}
	}
	/#
		iprintlnbold("");
	#/
}

/*
	Name: grav
	Namespace: namespace_fddd83bd
	Checksum: 0x47CB1D1C
	Offset: 0x5D8
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function grav()
{
	/#
		iprintlnbold("");
	#/
	level thread namespace_9cf755b::function_ec34b5ee(#"hash_2c4fa652fb89d231");
	zm_bgb_newtonian_negation::function_8622e664(1);
	wait(60);
	zm_bgb_newtonian_negation::function_8622e664(0);
	/#
		iprintlnbold("");
	#/
}

/*
	Name: guns
	Namespace: namespace_fddd83bd
	Checksum: 0x9EB7130F
	Offset: 0x678
	Size: 0x754
	Parameters: 0
	Flags: Linked
*/
function guns()
{
	self endon(#"fake_death");
	level thread namespace_9cf755b::function_ec34b5ee(#"hash_2c4fa652fb89d231");
	if(isdefined(level.pack_a_punch) && level flag::get("pap_power_ready"))
	{
		/#
			iprintlnbold("");
		#/
		level.pack_a_punch.trigger_stubs[0].pap_machine flag::wait_till("pap_waiting_for_user");
	}
	level flag::clear("pap_power_ready");
	level exploder::stop_exploder("fxexp_script_pap_lgt");
	/#
		iprintlnbold("");
	#/
	level.var_7629d4e2 = 1;
	a_e_players = getplayers();
	foreach(e_player in a_e_players)
	{
		e_player.var_679c4d4e = e_player zm_weapons::player_get_loadout();
		var_dac0c546 = e_player getweaponslist();
		e_player switchtoweaponimmediate(var_dac0c546[0], 1);
		e_player disableweaponcycling();
		e_player perks::function_7637bafa("specialty_ammodrainsfromstockfirst");
		e_player thread function_9992bb68();
		e_player thread function_ad15a8b3();
	}
	wait(2);
	level thread function_e5e4c0f9();
	while(level.var_7629d4e2)
	{
		a_e_players = getplayers();
		foreach(e_player in a_e_players)
		{
			/#
				iprintlnbold("");
			#/
			if(isdefined(e_player.var_3be6d813) && e_player.var_3be6d813 || e_player laststand::player_is_in_laststand() || e_player.sessionstate == "spectator" || e_player.var_479965f7 === 1 || e_player.var_d6229296 === 1 || e_player zm_laststand::is_reviving_any() || self.reviving_a_player === 1)
			{
				continue;
			}
			var_4cd7f83c = e_player getweaponslistprimaries();
			for(i = 0; i < var_4cd7f83c.size; i++)
			{
				var_4cd7f83c[i] = zm_weapons::get_base_weapon(var_4cd7f83c[i]);
			}
			w_current = e_player getcurrentweapon();
			is_weapon_upgraded = e_player zm_weapons::is_weapon_upgraded(w_current);
			var_fe8af21d = e_player zm_pap_util::function_83c29ddb(w_current);
			e_player takeweapon(w_current);
			var_fb1db24c = zm_weapons::function_efd851e();
			do
			{
				var_e221c195 = array::random(var_fb1db24c);
			}
			while(var_e221c195 == level.weaponnone || isdefined(array::find(var_4cd7f83c, var_e221c195)));
			if(is_weapon_upgraded)
			{
				var_e221c195 = namespace_29f39efb::get_upgrade(var_e221c195);
			}
			if(var_fe8af21d > 0)
			{
				if(isdefined(level.aat_in_use) && level.aat_in_use && zm_weapons::weapon_supports_aat(var_e221c195))
				{
					e_player thread aat::acquire(var_e221c195);
					e_player zm_pap_util::function_18994aca(var_e221c195, var_fe8af21d);
				}
			}
			var_e221c195 = e_player zm_weapons::give_build_kit_weapon(var_e221c195);
			e_player shoulddoinitialweaponraise(var_e221c195, 0);
			e_player switchtoweaponimmediate(var_e221c195);
		}
		wait(10);
	}
	waitframe(1);
	a_e_players = getplayers();
	foreach(e_player in a_e_players)
	{
		e_player thread function_a9e83aa6();
		e_player enableweaponcycling();
		e_player perks::function_45d12554("specialty_ammodrainsfromstockfirst");
	}
	if(namespace_44cfe494::function_b6f53cd2())
	{
		level flag::set("pap_power_ready");
		level exploder::exploder("fxexp_script_pap_lgt");
	}
	/#
		iprintlnbold("");
	#/
}

/*
	Name: function_e5e4c0f9
	Namespace: namespace_fddd83bd
	Checksum: 0x6B4B26C0
	Offset: 0xDD8
	Size: 0x40
	Parameters: 0
	Flags: Linked
*/
function function_e5e4c0f9()
{
	level.var_7629d4e2 = 1;
	wait(301);
	level.var_7629d4e2 = 0;
	level notify(#"hash_29abc4b1d80a664c");
}

/*
	Name: function_9992bb68
	Namespace: namespace_fddd83bd
	Checksum: 0xD5E7D607
	Offset: 0xE20
	Size: 0x66
	Parameters: 0
	Flags: Linked
*/
function function_9992bb68()
{
	self endon(#"death");
	level endon(#"end_game", #"hash_29abc4b1d80a664c");
	while(level.var_7629d4e2)
	{
		self disableweaponcycling();
		waitframe(1);
	}
}

/*
	Name: function_ad15a8b3
	Namespace: namespace_fddd83bd
	Checksum: 0x85FCC15C
	Offset: 0xE90
	Size: 0xE2
	Parameters: 0
	Flags: Linked
*/
function function_ad15a8b3()
{
	self endon(#"death");
	level endon(#"end_game", #"hash_29abc4b1d80a664c");
	while(level.var_7629d4e2)
	{
		while(!isdefined(self.var_11b895b8))
		{
			wait(0.1);
		}
		while(isdefined(self.var_11b895b8))
		{
			wait(0.1);
		}
		self.var_3be6d813 = 1;
		wait(3);
		var_dac0c546 = self getweaponslist();
		self switchtoweaponimmediate(var_dac0c546[0], 1);
		wait(2);
		self.var_3be6d813 = 0;
	}
}

/*
	Name: function_a9e83aa6
	Namespace: namespace_fddd83bd
	Checksum: 0x1B2CA7DB
	Offset: 0xF80
	Size: 0x66
	Parameters: 0
	Flags: Linked
*/
function function_a9e83aa6()
{
	self endon(#"death");
	while(self.var_479965f7 === 1)
	{
		wait(1);
	}
	self zm_weapons::player_give_loadout(self.var_679c4d4e, 1, 1);
	self.var_679c4d4e = undefined;
}

/*
	Name: time
	Namespace: namespace_fddd83bd
	Checksum: 0xC4576C21
	Offset: 0xFF0
	Size: 0x218
	Parameters: 0
	Flags: Linked
*/
function time()
{
	/#
		iprintlnbold("");
	#/
	level thread namespace_9cf755b::function_ec34b5ee(#"hash_2c4fa652fb89d231");
	a_e_players = getplayers();
	var_2b198109 = getaiteamarray(level.zombie_team);
	foreach(e_zombie in var_2b198109)
	{
		e_zombie namespace_9ff9f642::freeze();
		e_zombie.var_e8920729 = 1;
		e_zombie clientfield::set("winters_wail_freeze", 1);
	}
	wait(30);
	/#
		iprintlnbold("");
	#/
	foreach(e_zombie in var_2b198109)
	{
		if(!isdefined(e_zombie) || !isalive(e_zombie))
		{
			continue;
		}
		e_zombie namespace_9ff9f642::unfreeze();
		e_zombie.var_e8920729 = 0;
		e_zombie clientfield::set("winters_wail_freeze", 0);
	}
}

/*
	Name: function_e0b95486
	Namespace: namespace_fddd83bd
	Checksum: 0x4A123102
	Offset: 0x1210
	Size: 0x9A
	Parameters: 0
	Flags: Linked
*/
function function_e0b95486()
{
	/#
		iprintlnbold("");
	#/
	level thread namespace_9cf755b::function_ec34b5ee(#"hash_2c4fa652fb89d231");
	level.var_1f3f3e7b = &function_28e2ddd5;
	level.var_1b64d570 = 0;
	level waittill(#"end_of_round");
	level.var_1f3f3e7b = undefined;
	level.var_1b64d570 = undefined;
}

/*
	Name: cola
	Namespace: namespace_fddd83bd
	Checksum: 0x9BEB511C
	Offset: 0x12B8
	Size: 0x9A
	Parameters: 0
	Flags: Linked
*/
function cola()
{
	/#
		iprintlnbold("");
	#/
	level thread namespace_9cf755b::function_ec34b5ee(#"hash_2c4fa652fb89d231");
	level.var_1f3f3e7b = &function_28e2ddd5;
	level.var_1b64d570 = 1;
	level waittill(#"end_of_round");
	level.var_1f3f3e7b = undefined;
	level.var_1b64d570 = undefined;
}

/*
	Name: soda
	Namespace: namespace_fddd83bd
	Checksum: 0x7E6561BF
	Offset: 0x1360
	Size: 0x9A
	Parameters: 0
	Flags: Linked
*/
function soda()
{
	/#
		iprintlnbold("");
	#/
	level thread namespace_9cf755b::function_ec34b5ee(#"hash_2c4fa652fb89d231");
	level.var_1f3f3e7b = &function_28e2ddd5;
	level.var_1b64d570 = 2;
	level waittill(#"end_of_round");
	level.var_1f3f3e7b = undefined;
	level.var_1b64d570 = undefined;
}

/*
	Name: function_28e2ddd5
	Namespace: namespace_fddd83bd
	Checksum: 0xCCBD3FBA
	Offset: 0x1408
	Size: 0x92
	Parameters: 2
	Flags: Linked
*/
function function_28e2ddd5(n_perk_cost, var_c6ce6ade)
{
	/#
		assert(isdefined(level.var_1b64d570), "");
	#/
	if(var_c6ce6ade == level.var_1b64d570)
	{
		n_perk_cost = n_perk_cost * 0.5;
	}
	return int(max(n_perk_cost, 0));
}

/*
	Name: noob
	Namespace: namespace_fddd83bd
	Checksum: 0xAF38D5AC
	Offset: 0x14A8
	Size: 0x1C8
	Parameters: 0
	Flags: Linked
*/
function noob()
{
	/#
		iprintlnbold("");
	#/
	level thread namespace_9cf755b::function_ec34b5ee(#"hash_2c4fa652fb89d231");
	level thread function_a3bdad03();
	while(isdefined(level.var_debefb5b) && level.var_debefb5b)
	{
		var_2b198109 = getaiarray();
		foreach(e_zombie in var_2b198109)
		{
			if(!isdefined(e_zombie.zombie_move_speed_override))
			{
				e_zombie zombie_utility::set_zombie_run_cycle_override_value("walk");
			}
		}
		wait(1);
	}
	/#
		iprintlnbold("");
	#/
	var_2b198109 = getaiarray();
	foreach(e_zombie in var_2b198109)
	{
		e_zombie zombie_utility::set_zombie_run_cycle_restore_from_override();
	}
}

/*
	Name: function_a3bdad03
	Namespace: namespace_fddd83bd
	Checksum: 0xED1CA552
	Offset: 0x1678
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function function_a3bdad03()
{
	level.var_debefb5b = 1;
	wait(301);
	level.var_debefb5b = 0;
}

/*
	Name: bank
	Namespace: namespace_fddd83bd
	Checksum: 0x897C23C6
	Offset: 0x16B0
	Size: 0xE0
	Parameters: 0
	Flags: Linked
*/
function bank()
{
	/#
		iprintlnbold("");
	#/
	level thread namespace_9cf755b::function_ec34b5ee(#"hash_2c4fa652fb89d231");
	wait(2);
	a_e_players = getplayers();
	foreach(e_player in a_e_players)
	{
		e_player zm_score::add_to_player_score(1000);
	}
}

/*
	Name: door
	Namespace: namespace_fddd83bd
	Checksum: 0xDA0A39E0
	Offset: 0x1798
	Size: 0x460
	Parameters: 0
	Flags: Linked
*/
function door()
{
	/#
		iprintlnbold("");
	#/
	level thread namespace_9cf755b::function_ec34b5ee(#"hash_2c4fa652fb89d231");
	var_df1533c0 = getentarray("zombie_door", "targetname");
	var_13a6b1a7 = getentarray("zombie_debris", "targetname");
	var_855b4271 = [];
	foreach(var_6620353d in var_df1533c0)
	{
		if(isdefined(var_6620353d.script_noteworthy) && var_6620353d.script_noteworthy == "electric_door")
		{
			continue;
		}
		if(!isdefined(var_855b4271))
		{
			var_855b4271 = [];
		}
		else if(!isarray(var_855b4271))
		{
			var_855b4271 = array(var_855b4271);
		}
		if(!isinarray(var_855b4271, var_6620353d.script_flag))
		{
			var_855b4271[var_855b4271.size] = var_6620353d.script_flag;
		}
	}
	foreach(var_dc373a8d in var_13a6b1a7)
	{
		if(!isdefined(var_855b4271))
		{
			var_855b4271 = [];
		}
		else if(!isarray(var_855b4271))
		{
			var_855b4271 = array(var_855b4271);
		}
		if(!isinarray(var_855b4271, var_dc373a8d.script_flag))
		{
			var_855b4271[var_855b4271.size] = var_dc373a8d.script_flag;
		}
	}
	var_5768ad3b = [];
	foreach(script_flag in var_855b4271)
	{
		if(!level flag::get(script_flag))
		{
			if(!isdefined(var_5768ad3b))
			{
				var_5768ad3b = [];
			}
			else if(!isarray(var_5768ad3b))
			{
				var_5768ad3b = array(var_5768ad3b);
			}
			if(!isinarray(var_5768ad3b, script_flag))
			{
				var_5768ad3b[var_5768ad3b.size] = script_flag;
			}
		}
	}
	if(var_5768ad3b.size > 0)
	{
		var_67a0af61 = array::random(var_5768ad3b);
		var_5ae32412 = getentarray(var_67a0af61, "script_flag");
		foreach(var_93a940cc in var_5ae32412)
		{
			var_93a940cc.zombie_cost = 0;
			var_93a940cc zm_utility::set_hint_string(var_93a940cc, "default_buy_door", var_93a940cc.zombie_cost);
		}
	}
}

/*
	Name: warp
	Namespace: namespace_fddd83bd
	Checksum: 0x16726A4B
	Offset: 0x1C00
	Size: 0x128
	Parameters: 0
	Flags: Linked
*/
function warp()
{
	/#
		iprintlnbold("");
	#/
	level thread namespace_9cf755b::function_ec34b5ee(#"hash_2c4fa652fb89d231");
	wait(1);
	a_e_players = getplayers();
	foreach(e_player in a_e_players)
	{
		if(isalive(e_player) && !e_player laststand::player_is_in_laststand() && e_player.sessionstate != "spectator")
		{
			e_player thread warp_player();
		}
	}
}

/*
	Name: warp_player
	Namespace: namespace_fddd83bd
	Checksum: 0x31E6099F
	Offset: 0x1D30
	Size: 0x1FC
	Parameters: 0
	Flags: Linked
*/
function warp_player()
{
	self clientfield::increment_to_player("teleporter_depart", 1);
	playfx(level._effect[#"hash_42067f50e6d7e946"], self.origin, (1, 0, 0), (0, 0, 1));
	playsoundatposition(#"evt_teleporter_out", self.origin);
	s_destination = self zm_bgb_anywhere_but_here::function_91a62549();
	self namespace_eaaeba61::function_66d020b0(undefined, undefined, undefined, undefined, s_destination, undefined, "warp");
	self clientfield::increment_to_player("teleporter_transition", 1);
	self thread namespace_1846c963::function_c234a5ce();
	self clientfield::increment_to_player("teleporter_arrive", 1);
	playfx(level._effect[#"hash_51e5effc17815d68"], self.origin, (1, 0, 0), (0, 0, 1));
	playsoundatposition(#"evt_teleporter_go", self.origin);
	self playsoundtoplayer(#"hash_39876bf613387fef", self);
	wait(0.5);
	self.teleporting = 0;
	util::setclientsysstate("levelNotify", "cool_fx", self);
	util::setclientsysstate("levelNotify", "ae1", self);
}

/*
	Name: shed
	Namespace: namespace_fddd83bd
	Checksum: 0x31F9237F
	Offset: 0x1F38
	Size: 0x270
	Parameters: 0
	Flags: Linked
*/
function shed()
{
	level thread namespace_9cf755b::function_ec34b5ee(#"hash_2c4fa652fb89d231");
	if(flag::get(#"magic_door_power_up_grabbed"))
	{
		level flag::clear("magic_door_power_up_grabbed");
		level flag::clear("population_count_step_complete");
		level thread namespace_456de992::perks_behind_door();
		if(!level flag::get(#"hash_a54ffd2751ba9de"))
		{
			level thread namespace_29f39efb::function_4bcfb4d9();
		}
		/#
			iprintlnbold("");
		#/
	}
	else
	{
		var_df1533c0 = getentarray("zombie_door", "targetname");
		foreach(var_6620353d in var_df1533c0)
		{
			if(isdefined(var_6620353d.script_flag) && var_6620353d.script_flag == "yellow_backyard_to_ammo_door")
			{
				if(!(isdefined(var_6620353d.has_been_opened) && var_6620353d.has_been_opened))
				{
					a_e_players = getplayers();
					var_6620353d notify(#"trigger", {#hash_3fc8547c:1, #activator:a_e_players[0]});
					/#
						iprintlnbold("");
					#/
					break;
					continue;
				}
				/#
					iprintlnbold("");
				#/
			}
		}
	}
}

/*
	Name: nuke
	Namespace: namespace_fddd83bd
	Checksum: 0x4176A981
	Offset: 0x21B0
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function nuke()
{
	/#
		iprintlnbold("");
	#/
	level thread namespace_9cf755b::function_ec34b5ee(#"hash_2c4fa652fb89d231");
	var_68b709a = struct::get("computer_system_powerup_drop");
	if(isdefined(var_68b709a))
	{
		zm_powerups::specific_powerup_drop("nuke", var_68b709a.origin);
	}
}

/*
	Name: hero
	Namespace: namespace_fddd83bd
	Checksum: 0x33343BA1
	Offset: 0x2250
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function hero()
{
	/#
		iprintlnbold("");
	#/
	a_e_players = getplayers();
	foreach(e_player in a_e_players)
	{
		e_player namespace_d2304f18::hero_weapon_power(e_player);
	}
}

/*
	Name: puke
	Namespace: namespace_fddd83bd
	Checksum: 0xD892B1D4
	Offset: 0x2310
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function puke()
{
	/#
		iprintlnbold("");
	#/
	level thread namespace_9cf755b::function_ec34b5ee(#"hash_2c4fa652fb89d231");
	callback::on_ai_damage(&function_80d5023d);
	wait(300);
	callback::remove_on_ai_damage(&function_80d5023d);
	/#
		iprintlnbold("");
	#/
}

/*
	Name: function_80d5023d
	Namespace: namespace_fddd83bd
	Checksum: 0x1EE5B8C9
	Offset: 0x23C8
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_80d5023d(params)
{
	self thread function_82457e35(params);
}

/*
	Name: function_82457e35
	Namespace: namespace_fddd83bd
	Checksum: 0x24175417
	Offset: 0x23F8
	Size: 0x22C
	Parameters: 1
	Flags: Linked
*/
function function_82457e35(params)
{
	var_62e3519c = params.smeansofdeath === "MOD_MELEE" || params.smeansofdeath === "MOD_MELEE_WEAPON_BUTT" || params.smeansofdeath === "MOD_MELEE_ASSASSINATE";
	if(isalive(self) && self.archetype === #"zombie" && var_62e3519c)
	{
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
		wait(randomfloatrange(1, 2));
		mdl_fx delete();
	}
}

/*
	Name: club
	Namespace: namespace_fddd83bd
	Checksum: 0x4F380E40
	Offset: 0x2630
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function club()
{
	/#
		iprintlnbold("");
	#/
	level thread namespace_9cf755b::function_ec34b5ee(#"hash_2c4fa652fb89d231");
	exploder::exploder("fxexp_disco_lgt");
	playsoundatposition(#"hash_c8d3a1557c42ab7", (1, 1145, -350));
	wait(253);
	exploder::stop_exploder("fxexp_disco_lgt");
	/#
		iprintlnbold("");
	#/
}

/*
	Name: duck
	Namespace: namespace_fddd83bd
	Checksum: 0x865E1995
	Offset: 0x2708
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function duck()
{
	/#
		iprintlnbold("");
	#/
	level thread namespace_9cf755b::function_ec34b5ee(#"hash_2c4fa652fb89d231");
	callback::on_ai_damage(&function_369efa3e);
	wait(300);
	callback::remove_callback(#"on_ai_damage", &function_369efa3e);
	/#
		iprintlnbold("");
	#/
}

/*
	Name: function_369efa3e
	Namespace: namespace_fddd83bd
	Checksum: 0xE54AE5CC
	Offset: 0x27D0
	Size: 0x114
	Parameters: 1
	Flags: Linked
*/
function function_369efa3e(params)
{
	var_62e3519c = params.smeansofdeath === "MOD_MELEE" || params.smeansofdeath === "MOD_MELEE_WEAPON_BUTT" || params.smeansofdeath === "MOD_MELEE_ASSASSINATE";
	if(isalive(self) && (self.archetype === #"zombie" || self.archetype === #"zombie_dog" || self.archetype === #"nova_crawler") && var_62e3519c)
	{
		if(zm_audio::sndisnetworksafe())
		{
			self playsoundontag(#"hash_5d1ae984d240e43d", "j_head");
		}
	}
}

/*
	Name: song
	Namespace: namespace_fddd83bd
	Checksum: 0x4813C15C
	Offset: 0x28F0
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function song()
{
	level thread namespace_9cf755b::function_ec34b5ee(#"hash_2c4fa652fb89d231");
	wait(1);
	if(level.musicsystem.currentplaytype < 4)
	{
		level thread zm_audio::sndmusicsystem_stopandflush();
		waitframe(1);
		level thread zm_audio::sndmusicsystem_playstate("ee_song_main");
	}
}

/*
	Name: function_a2c208d5
	Namespace: namespace_fddd83bd
	Checksum: 0x8D687BA1
	Offset: 0x2978
	Size: 0x22C
	Parameters: 0
	Flags: Linked
*/
function function_a2c208d5()
{
	level endon(#"hash_1a91b42d31e0b28d");
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_73fd31eafa77ad51", 0, 1);
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_23131f0d452094c1", 0, 0);
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_23131f0d452094c1", 1, 0);
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_12cb80d7a172a4b", 0, 0);
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_12cb80d7a172a4b", 1, 0);
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_6b80107bf5762401", 0, 0);
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_6b80107bf5762401", 1, 0);
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_25e8d751b537b7b7", 0, 0);
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_25e8d751b537b7b7", 1, 0);
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_5890d651d18916db", 0, 0);
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_5890d651d18916db", 1, 0);
}

/*
	Name: ugly
	Namespace: namespace_fddd83bd
	Checksum: 0xC25D481F
	Offset: 0x2BB0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function ugly()
{
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_508205d179ebb89a", 0, 1);
}

/*
	Name: joke
	Namespace: namespace_fddd83bd
	Checksum: 0x68768225
	Offset: 0x2BF0
	Size: 0x1D0
	Parameters: 0
	Flags: Linked
*/
function joke()
{
	if(!isdefined(level.var_9551e688))
	{
		level.var_9551e688 = 0;
	}
	switch(level.var_9551e688)
	{
		case 0:
		{
			level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_1382b96530ccddd7", 0, 1);
			break;
		}
		case 1:
		{
			level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_477362650641d121", 0, 1);
			break;
		}
		case 2:
		{
			level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_5c9c346d2be844fb", 0, 1);
			break;
		}
		case 3:
		{
			level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_1e85c53e64df168d", 0, 1);
			break;
		}
		case 4:
		{
			level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_6870bc3e45a45ebd", 0, 1);
			break;
		}
		case 5:
		{
			level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_72711a651e8449f3", 0, 1);
			break;
		}
	}
	level.var_9551e688++;
}

/*
	Name: yawn
	Namespace: namespace_fddd83bd
	Checksum: 0x3CF4E61E
	Offset: 0x2DC8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function yawn()
{
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_29c0b280a4237f3c", 0, 1);
}

/*
	Name: vent
	Namespace: namespace_fddd83bd
	Checksum: 0xF414242B
	Offset: 0x2E08
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function vent()
{
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_411bf7894ec932a2", 0, 1);
}

/*
	Name: love
	Namespace: namespace_fddd83bd
	Checksum: 0x77C0D811
	Offset: 0x2E48
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function love()
{
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_2f3d1518125f702f", 0, 1);
}

/*
	Name: life
	Namespace: namespace_fddd83bd
	Checksum: 0x50DEF1BC
	Offset: 0x2E88
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function life()
{
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d(#"hash_344c94a20b946893", 0, 1);
}

/*
	Name: boom
	Namespace: namespace_fddd83bd
	Checksum: 0xBD7ED719
	Offset: 0x2EC8
	Size: 0x136
	Parameters: 0
	Flags: Linked
*/
function boom()
{
	level thread namespace_9cf755b::function_ec34b5ee(#"hash_2c4fa652fb89d231");
	s_spawn_loc = struct::get("computer_system_powerup_drop");
	s_keypad = struct::get("keypad");
	e_player = level.var_f13364b4.var_12633dc5;
	if(isdefined(s_spawn_loc) && isdefined(s_keypad) && isdefined(e_player))
	{
		v_spawn = s_keypad.origin + anglestoforward(s_keypad.angles) * 4;
		v_velocity = vectorscale((0, 0, 1), 200);
		var_b5b97738 = e_player magicgrenadeplayer(getweapon(#"hash_34b7eb9fde56bd35"), v_spawn, v_velocity);
	}
}

/*
	Name: pack
	Namespace: namespace_fddd83bd
	Checksum: 0x22A5A789
	Offset: 0x3008
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function pack()
{
	level thread namespace_9cf755b::function_ec34b5ee(#"hash_2c4fa652fb89d231");
	var_68b709a = struct::get("computer_system_powerup_drop");
	if(isdefined(var_68b709a))
	{
		zm_powerups::specific_powerup_drop("bonfire_sale", var_68b709a.origin);
	}
}

