// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2694b388c90e575;
#using script_467027ea7017462b;
#using script_4d000493c57bb851;
#using script_52c6c2d1a2ef1b46;
#using script_6e3c826b1814cab6;
#using script_7c62f55ce3a557ff;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\hud_util_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm\zm_escape_util.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_fc5c8455;

/*
	Name: function_89f2df9
	Namespace: namespace_fc5c8455
	Checksum: 0xD08F22D2
	Offset: 0x320
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_32658a301920c858", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_fc5c8455
	Checksum: 0x280E7BAD
	Offset: 0x370
	Size: 0x60C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("scriptmover", "" + #"hash_228caf5cb0610875", 1, getminbitcountfornum(4), "int");
	clientfield::register("scriptmover", "" + #"hash_5f7eb9d1316d02a7", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_247e2f70c08b01f6", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_f8ff865403f6655", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_6954721e3aab6b22", 1, 2, "int");
	clientfield::register("scriptmover", "" + #"hash_f03061885875815", 1, 1, "int");
	clientfield::register("toplayer", "" + #"hash_1a9944b03fae8660", 1, 1, "int");
	clientfield::register("toplayer", "" + #"hash_c79e0b124c4b75", 1, 1, "counter");
	clientfield::register("toplayer", "" + #"hash_39d19b76b846a27f", 1, 1, "counter");
	clientfield::register("scriptmover", "" + #"hash_148c1ac364522c90", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_1142930568dc278b", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_31f39c058ef79e2", 1, 1, "counter");
	clientfield::register("scriptmover", "" + #"hash_3c74a33b8e1adb73", 1, 1, "counter");
	clientfield::register("scriptmover", "" + #"hash_7692067c56d8b6cc", 1, 2, "int");
	level.var_8e6fc65e = getentarray("mg_al_skull", "targetname");
	level.var_5f506a2b = getent("mg_ho_vol", "targetname");
	zm_powerups::set_weapon_ignore_max_ammo(#"hash_617dcc39334959ce");
	var_e34de65b = struct::get("mg_door_frame_pos", "targetname");
	level.var_760f9184 = util::spawn_model("tag_origin", var_e34de65b.origin, var_e34de65b.angles);
	var_9eb4d270 = struct::get("mg_fp_pos", "targetname");
	level.var_cc5631a6 = util::spawn_model("tag_origin", var_9eb4d270.origin, var_9eb4d270.angles);
	var_dc49a24d = struct::get("mg_forg_pos", "targetname");
	level.var_bff24582 = util::spawn_model("tag_origin", var_dc49a24d.origin, var_dc49a24d.angles);
	level flag::init(#"hash_3ec656e276ceee53");
	level flag::init(#"hash_3fb7d58b07b04333");
	level flag::init(#"hash_1d5f5fbf80476490");
	level flag::init(#"hash_38c04d24b5213b00");
	level flag::init(#"hash_5e6097345e223e2d");
	level.var_19a54d73 = 0;
	scene::add_scene_func(#"hash_22d77c3d8f8cdb1e", &function_6672db20, "play");
}

/*
	Name: __main__
	Namespace: namespace_fc5c8455
	Checksum: 0x6DFE31D6
	Offset: 0x988
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	if(!namespace_59ff1d6c::function_901b751c(#"hash_541a4d5c476468f4"))
	{
		return;
	}
	/#
		level thread function_78ca248c();
	#/
	level flag::wait_till("start_zombie_round_logic");
	var_99f0b8d7 = struct::get_array("mg_fire_urn", "targetname");
	array::thread_all(var_99f0b8d7, &function_ff4e7fcd);
	level thread function_d445bc55();
	level thread function_316db647();
	level thread function_b00fd241();
}

/*
	Name: function_d445bc55
	Namespace: namespace_fc5c8455
	Checksum: 0x2180771D
	Offset: 0xA88
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_d445bc55()
{
	var_9eb4d270 = struct::get("mg_fp_pos");
	var_9eb4d270.s_unitrigger_stub = var_9eb4d270 zm_unitrigger::create(&function_842d114a, 128, &function_cbe7f871);
	zm_unitrigger::unitrigger_force_per_player_triggers(var_9eb4d270.s_unitrigger_stub, 1);
	level.var_cc5631a6 clientfield::set("" + #"hash_228caf5cb0610875", 1);
}

/*
	Name: function_842d114a
	Namespace: namespace_fc5c8455
	Checksum: 0x3A675D6B
	Offset: 0xB48
	Size: 0x528
	Parameters: 1
	Flags: Linked
*/
function function_842d114a(player)
{
	if(level flag::get(#"hash_38c04d24b5213b00") || level flag::get(#"hash_5e6097345e223e2d"))
	{
		return 0;
	}
	if(isdefined(zm_audio::function_fa4dfde0(player.currentweapon)))
	{
		return 0;
	}
	if(player hasweapon(getweapon(#"hash_19c157f2230454ad")) || player hasweapon(getweapon(#"hash_cb1cdb5b47f0226")) || player hasweapon(getweapon(#"hash_25a13b6f6232a985")) || player hasweapon(getweapon(#"hash_4c157b1aeefae09e")) && !isdefined(self.stub.var_bd8af718))
	{
		if(player hasweapon(getweapon(#"hash_19c157f2230454ad")))
		{
			if(function_8b1a219a())
			{
				self sethintstring(#"hash_4aaa1b70a31edb6f");
			}
			else
			{
				self sethintstring(#"hash_6aefb24885426431");
			}
		}
		else if(player hasweapon(getweapon(#"hash_cb1cdb5b47f0226")))
		{
			if(function_8b1a219a())
			{
				self sethintstring(#"hash_6363a7fc77e158a4");
			}
			else
			{
				self sethintstring(#"hash_7755302d416e3168");
			}
		}
		else if(player hasweapon(getweapon(#"hash_25a13b6f6232a985")))
		{
			if(function_8b1a219a())
			{
				self sethintstring(#"hash_49c7816541364de0");
			}
			else
			{
				self sethintstring(#"hash_1875e6c5a3e5e96c");
			}
		}
		else if(player hasweapon(getweapon(#"hash_4c157b1aeefae09e")))
		{
			if(function_8b1a219a())
			{
				self sethintstring(#"hash_66c939cc0e7e3b08");
			}
			else
			{
				self sethintstring(#"hash_ecb311bfa753664");
			}
		}
		return 1;
	}
	if(isdefined(player.var_b0c0f8bf) && player.var_b0c0f8bf)
	{
		if(!level flag::get(#"hash_1d5f5fbf80476490") && isdefined(self.stub.var_a29167c5))
		{
			if(function_8b1a219a())
			{
				self sethintstring(#"hash_781bc746720b47e3");
			}
			else
			{
				self sethintstring(#"hash_86231cba8afa1fd");
			}
			return 1;
		}
		if(level flag::get(#"hash_1d5f5fbf80476490"))
		{
			if(function_8b1a219a())
			{
				self sethintstring(#"hash_6413ba5620873f28");
			}
			else
			{
				self sethintstring(#"hash_6717cabd759589c4");
			}
			return 1;
		}
		return 0;
	}
	return 0;
}

/*
	Name: function_cbe7f871
	Namespace: namespace_fc5c8455
	Checksum: 0xF2903349
	Offset: 0x1080
	Size: 0x258
	Parameters: 0
	Flags: Linked, Private
*/
private function function_cbe7f871()
{
	v_weapon_origin_offset = (8, -2, 9);
	v_weapon_angles_offset = vectorscale((0, -1, 0), 90);
	self.stub.v_weapon_origin = level.var_cc5631a6.origin + v_weapon_origin_offset;
	self.stub.v_weapon_angles = level.var_cc5631a6.angles + v_weapon_angles_offset;
	var_a29167c5 = undefined;
	if(level flag::get(#"hash_3fb7d58b07b04333"))
	{
		var_a29167c5 = 1;
	}
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"trigger");
		e_player = var_88706ea7.activator;
		if(!level flag::get(#"hash_3fb7d58b07b04333") && !level flag::get(#"hash_1d5f5fbf80476490"))
		{
			self.stub thread function_d74a3faf(e_player);
		}
		else if(level flag::get(#"hash_3fb7d58b07b04333") && !level flag::get(#"hash_1d5f5fbf80476490"))
		{
			self.stub thread function_fcf0a319(e_player, var_a29167c5);
		}
		else if(level flag::get(#"hash_3fb7d58b07b04333") && level flag::get(#"hash_1d5f5fbf80476490"))
		{
			self.stub notify(#"hash_38a4480847fe9677", {#activator:e_player});
		}
	}
}

/*
	Name: function_d74a3faf
	Namespace: namespace_fc5c8455
	Checksum: 0x490183B3
	Offset: 0x12E0
	Size: 0x494
	Parameters: 1
	Flags: Linked
*/
function function_d74a3faf(e_player)
{
	self notify("4e021117b5553400");
	self endon("4e021117b5553400");
	var_f2528cbc = undefined;
	if(e_player hasweapon(getweapon(#"hash_19c157f2230454ad")))
	{
		var_f2528cbc = #"hash_19c157f2230454ad";
	}
	else if(e_player hasweapon(getweapon(#"hash_cb1cdb5b47f0226")))
	{
		var_f2528cbc = #"hash_cb1cdb5b47f0226";
	}
	else if(e_player hasweapon(getweapon(#"hash_25a13b6f6232a985")))
	{
		var_f2528cbc = #"hash_25a13b6f6232a985";
		var_da887cb9 = getweapon(#"hash_25a13b6f6232a985");
	}
	else if(e_player hasweapon(getweapon(#"hash_4c157b1aeefae09e")))
	{
		var_f2528cbc = #"hash_4c157b1aeefae09e";
		var_da887cb9 = getweapon(#"hash_4c157b1aeefae09e");
	}
	if(isdefined(var_da887cb9))
	{
		e_player.var_452feb6c = e_player getweaponammostock(var_da887cb9);
	}
	if(isdefined(var_f2528cbc))
	{
		e_player.var_22b64976 = var_f2528cbc;
		e_player takeweapon(getweapon(var_f2528cbc));
		e_player.var_95afb037 = 1;
		self.var_bd8af718 = 1;
		self.e_player = e_player;
		level.var_19a54d73 = 0;
		if(!(isdefined(e_player.intermission) && e_player.intermission) && (!(isdefined(e_player.is_drinking) && e_player.is_drinking)))
		{
			e_player zm_weapons::switch_back_primary_weapon();
		}
		exploder::exploder("fxexplo_magma_window_barrier_fx");
		level.var_cc5631a6 clientfield::set("" + #"hash_228caf5cb0610875", 1);
		playsoundatposition(#"hash_2c4234f291620027", self.origin);
		self.var_607f49de = zm_utility::spawn_weapon_model(getweapon(var_f2528cbc), undefined, self.v_weapon_origin, self.v_weapon_angles);
		self.var_607f49de thread scene::play(#"p8_fxanim_zm_esc_blundergat_fireplace_hover_bundle", self.var_607f49de);
		level flag::clear(#"hash_3ec656e276ceee53");
		e_player thread function_4022d369(self);
		e_player thread function_8b619951();
		e_player function_181eb502();
		if(isalive(e_player) && level flag::get(#"hash_3fb7d58b07b04333"))
		{
			var_a29167c5 = 1;
			self.var_a29167c5 = 1;
			e_player.var_b0c0f8bf = 1;
		}
		else
		{
			self function_599013ad(e_player, 1);
			playsoundatposition(#"hash_65b4e7aafb64c1a1", (0, 0, 0));
		}
	}
}

/*
	Name: function_fcf0a319
	Namespace: namespace_fc5c8455
	Checksum: 0x7B56301A
	Offset: 0x1780
	Size: 0x21C
	Parameters: 2
	Flags: Linked
*/
function function_fcf0a319(e_player, var_a29167c5)
{
	self notify("c470e33374ac8b5");
	self endon("c470e33374ac8b5");
	if(isdefined(self.var_607f49de))
	{
		self.var_607f49de delete();
	}
	self.var_607f49de = zm_utility::spawn_weapon_model(getweapon(#"hash_617dcc39334959ce"), undefined, self.v_weapon_origin, self.v_weapon_angles);
	self.var_a29167c5 = undefined;
	level.var_cc5631a6 function_d586e457();
	level flag::set(#"hash_1d5f5fbf80476490");
	if(isalive(e_player))
	{
		self thread function_11efbb03(e_player);
		self thread wait_for_timeout(e_player, var_a29167c5);
		var_2b94e3bb = undefined;
		var_2b94e3bb = self waittill(#"hash_5df93e8b56c1c70e", #"hash_17f1f2fec5688f9a");
	}
	if(isalive(e_player))
	{
		e_player.var_95afb037 = undefined;
		e_player.var_b0c0f8bf = undefined;
	}
	self.var_bd8af718 = undefined;
	self.var_a29167c5 = undefined;
	self.e_player = undefined;
	if(isdefined(var_2b94e3bb) && var_2b94e3bb._notify == #"hash_5df93e8b56c1c70e")
	{
		self function_599013ad(e_player, 1);
		playsoundatposition(#"hash_65b4e7aafb64c1a1", (0, 0, 0));
	}
}

/*
	Name: function_599013ad
	Namespace: namespace_fc5c8455
	Checksum: 0x55AAE0C6
	Offset: 0x19A8
	Size: 0x182
	Parameters: 2
	Flags: Linked
*/
function function_599013ad(e_player, var_98fbd60e)
{
	level notify(#"hash_fd8be2ffb55eaf7");
	level.var_19a54d73 = 0;
	function_a057cdf0();
	exploder::stop_exploder("fxexplo_magma_window_barrier_fx");
	level.var_cc5631a6 clientfield::set("" + #"hash_228caf5cb0610875", 1);
	level flag::clear(#"hash_3fb7d58b07b04333");
	level flag::clear(#"hash_1d5f5fbf80476490");
	level flag::clear(#"hash_3ec656e276ceee53");
	if(isdefined(self.var_607f49de))
	{
		if(isdefined(var_98fbd60e) && var_98fbd60e)
		{
			self thread function_817977d1();
		}
		self.var_607f49de delete();
	}
	self.var_bd8af718 = undefined;
	self.var_a29167c5 = undefined;
	if(isdefined(e_player))
	{
		e_player.var_22b64976 = undefined;
		e_player.var_13a24eee = undefined;
		e_player.var_b0c0f8bf = undefined;
	}
}

/*
	Name: function_a057cdf0
	Namespace: namespace_fc5c8455
	Checksum: 0xD6604167
	Offset: 0x1B38
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function function_a057cdf0()
{
	foreach(var_a2a0a44e in level.var_8e6fc65e)
	{
		var_a2a0a44e setmodel("p8_zm_esc_skull_sgl");
		var_a2a0a44e clientfield::set("" + #"hash_5f7eb9d1316d02a7", 0);
	}
}

/*
	Name: function_817977d1
	Namespace: namespace_fc5c8455
	Checksum: 0x399182FA
	Offset: 0x1BF8
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_817977d1()
{
	var_ce2c859d = util::spawn_model("tag_origin", self.v_weapon_origin, self.v_weapon_angles);
	if(isdefined(var_ce2c859d))
	{
		var_ce2c859d endon(#"death");
		util::wait_network_frame();
		var_ce2c859d clientfield::increment("" + #"hash_31f39c058ef79e2");
		wait(3);
		var_ce2c859d delete();
	}
}

/*
	Name: function_d586e457
	Namespace: namespace_fc5c8455
	Checksum: 0x59D0822C
	Offset: 0x1CB8
	Size: 0x184
	Parameters: 0
	Flags: Linked
*/
function function_d586e457()
{
	level endon(#"hash_fd8be2ffb55eaf7");
	var_ec3ff08c = array::sort_by_script_int(level.var_8e6fc65e, 0);
	foreach(var_a2a0a44e in var_ec3ff08c)
	{
		var_a2a0a44e setmodel("p8_zm_esc_skull_sgl");
		var_a2a0a44e clientfield::set("" + #"hash_5f7eb9d1316d02a7", 0);
		wait(0.5);
	}
	wait(0.5);
	self clientfield::set("" + #"hash_228caf5cb0610875", 4);
	playsoundatposition(#"hash_5642bd4cb9f030d7", self.origin);
	wait(1);
	self clientfield::set("" + #"hash_228caf5cb0610875", 3);
}

/*
	Name: function_11efbb03
	Namespace: namespace_fc5c8455
	Checksum: 0x77F19DDB
	Offset: 0x1E48
	Size: 0x2C2
	Parameters: 1
	Flags: Linked, Private
*/
private function function_11efbb03(e_player)
{
	self endon(#"hash_5df93e8b56c1c70e");
	e_player endon(#"disconnect");
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"hash_38a4480847fe9677");
		if(var_88706ea7.activator == e_player)
		{
			if(zm_utility::can_use(e_player, 1) && e_player.currentweapon.name != "none")
			{
				self notify(#"hash_17f1f2fec5688f9a");
				e_player notify(#"hash_17f1f2fec5688f9a");
				var_287a8343 = zm_utility::get_player_weapon_limit(e_player);
				var_4f33a328 = e_player getweaponslistprimaries();
				if(isdefined(var_4f33a328) && var_4f33a328.size >= var_287a8343)
				{
					e_player takeweapon(e_player.currentweapon);
				}
				e_player giveweapon(getweapon(#"hash_617dcc39334959ce"));
				e_player switchtoweapon(getweapon(#"hash_617dcc39334959ce"));
				e_player clientfield::set_to_player("" + #"hash_1a9944b03fae8660", 1);
				e_player.var_1ea09849 = 1;
				level notify(#"hash_575b654fc5c59146", {#e_player:e_player});
				level flag::set(#"hash_5e6097345e223e2d");
				e_player zm_audio::create_and_play_dialog(#"weapon_pickup", #"hash_49548133c092e662");
				e_player thread function_6222e98f();
				self function_599013ad(undefined, undefined);
				exploder::exploder("blue_fire");
				return;
			}
		}
	}
}

/*
	Name: wait_for_timeout
	Namespace: namespace_fc5c8455
	Checksum: 0x83ECF9D0
	Offset: 0x2118
	Size: 0x72
	Parameters: 2
	Flags: Linked, Private
*/
private function wait_for_timeout(e_player, var_9bce3ebf)
{
	self endon(#"hash_17f1f2fec5688f9a");
	if(isdefined(var_9bce3ebf) && var_9bce3ebf)
	{
		wait(30);
	}
	else
	{
		wait(30);
	}
	self notify(#"hash_5df93e8b56c1c70e");
	if(isdefined(e_player))
	{
		e_player.var_22b64976 = undefined;
	}
}

/*
	Name: function_181eb502
	Namespace: namespace_fc5c8455
	Checksum: 0xDDA15518
	Offset: 0x2198
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function function_181eb502()
{
	self endon_callback(&function_6eca1fcc, #"disconnect");
	level.var_760f9184 thread clientfield::set("" + #"hash_247e2f70c08b01f6", 1);
	callback::on_ai_killed(&function_ed30e654);
	var_88706ea7 = level flag::wait_till_any(array(#"hash_3ec656e276ceee53", #"hash_3fb7d58b07b04333"));
	callback::remove_on_ai_killed(&function_ed30e654);
	level.var_760f9184 thread clientfield::set("" + #"hash_247e2f70c08b01f6", 0);
	wait(1);
}

/*
	Name: function_6eca1fcc
	Namespace: namespace_fc5c8455
	Checksum: 0xB0009B7B
	Offset: 0x22C0
	Size: 0x96
	Parameters: 1
	Flags: Linked
*/
function function_6eca1fcc(str_notify)
{
	callback::remove_on_ai_killed(&function_ed30e654);
	level flag::set(#"hash_3ec656e276ceee53");
	var_9eb4d270 = struct::get("mg_fp_pos");
	var_9eb4d270.s_unitrigger_stub.var_a29167c5 = undefined;
	var_9eb4d270.s_unitrigger_stub.e_player = undefined;
}

/*
	Name: function_ed30e654
	Namespace: namespace_fc5c8455
	Checksum: 0xAC88988
	Offset: 0x2360
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function function_ed30e654(s_params)
{
	if(self.archetype != #"zombie" && self.archetype != #"zombie_dog" && self.archetype != #"brutus")
	{
		return;
	}
	if(isplayer(s_params.eattacker) && self istouching(level.var_5f506a2b))
	{
		self thread function_1ff8ba1();
	}
}

/*
	Name: function_1ff8ba1
	Namespace: namespace_fc5c8455
	Checksum: 0x41B47488
	Offset: 0x2420
	Size: 0x154
	Parameters: 0
	Flags: Linked
*/
function function_1ff8ba1()
{
	var_88f24b00 = util::spawn_model("tag_origin", self.origin + vectorscale((0, 0, 1), 22), self.angles);
	var_88f24b00 endon(#"death");
	var_146228fb = spawn("trigger_radius", self.origin, 0, 24, 96);
	var_146228fb setvisibletoteam(util::get_enemy_team(self.team));
	var_146228fb setteamfortrigger(util::get_enemy_team(self.team));
	var_146228fb thread function_9689b55c(var_88f24b00);
	var_88f24b00 thread function_dd30dc9a(var_146228fb);
	var_88f24b00 thread function_ce0bd88a(var_146228fb);
	while(isdefined(var_146228fb))
	{
		wait(0.25);
	}
	var_88f24b00 delete();
}

/*
	Name: function_9689b55c
	Namespace: namespace_fc5c8455
	Checksum: 0x535440B1
	Offset: 0x2580
	Size: 0x4B0
	Parameters: 1
	Flags: Linked
*/
function function_9689b55c(var_88f24b00)
{
	self endon(#"death");
	var_88f24b00 endon(#"death");
	var_39662a63 = int(5);
	foreach(var_a2a0a44e in level.var_8e6fc65e)
	{
		if(var_a2a0a44e.script_int == 0)
		{
			var_ddbc98df = var_a2a0a44e;
			continue;
		}
		if(var_a2a0a44e.script_int == 1)
		{
			var_f697c38 = var_a2a0a44e;
			continue;
		}
		var_b9484ff7 = var_a2a0a44e;
	}
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"trigger");
		if(isplayer(var_88706ea7.activator))
		{
			level.var_19a54d73++;
			var_88706ea7.activator playsound(#"hash_7924de0ae1c7e3c7");
			if(level.var_19a54d73 == var_39662a63)
			{
				var_ddbc98df setmodel("p8_zm_esc_skull_afterlife");
				var_ddbc98df thread clientfield::set("" + #"hash_5f7eb9d1316d02a7", 1);
				var_ddbc98df playsound(#"hash_4fad63fcdab19a1d");
			}
			else if(level.var_19a54d73 == var_39662a63 * 2)
			{
				var_f697c38 setmodel("p8_zm_esc_skull_afterlife");
				var_f697c38 thread clientfield::set("" + #"hash_5f7eb9d1316d02a7", 1);
				var_f697c38 playsound(#"hash_4fad63fcdab19a1d");
			}
			else if(level.var_19a54d73 >= 15)
			{
				var_b9484ff7 setmodel("p8_zm_esc_skull_afterlife");
				var_b9484ff7 thread clientfield::set("" + #"hash_5f7eb9d1316d02a7", 1);
				var_b9484ff7 playsound(#"hash_57188d77b17d82ca");
				level.var_cc5631a6 clientfield::set("" + #"hash_228caf5cb0610875", 2);
				exploder::exploder_stop("fxexplo_magma_window_barrier_fx");
				level flag::set(#"hash_3fb7d58b07b04333");
				var_9eb4d270 = struct::get("mg_fp_pos");
				var_9eb4d270.s_unitrigger_stub.var_a29167c5 = 1;
				if(isdefined(var_9eb4d270.s_unitrigger_stub.e_player))
				{
					var_9eb4d270.s_unitrigger_stub.e_player.var_b0c0f8bf = 1;
				}
			}
			var_88f24b00 clientfield::set("" + #"hash_1142930568dc278b", 0);
			var_88f24b00 clientfield::set("" + #"hash_148c1ac364522c90", 1);
			if(isdefined(self))
			{
				self delete();
			}
		}
	}
}

/*
	Name: function_dd30dc9a
	Namespace: namespace_fc5c8455
	Checksum: 0x1E861D38
	Offset: 0x2A38
	Size: 0x70
	Parameters: 1
	Flags: Linked
*/
function function_dd30dc9a(var_146228fb)
{
	self endon(#"death");
	self clientfield::set("" + #"hash_1142930568dc278b", 1);
	while(isdefined(var_146228fb))
	{
		self namespace_54386dac::function_8b5765c6();
	}
}

/*
	Name: function_ce0bd88a
	Namespace: namespace_fc5c8455
	Checksum: 0x25EBD26E
	Offset: 0x2AB0
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_ce0bd88a(var_146228fb)
{
	self endon(#"death");
	self movez(36, 3);
	wait(3);
	if(isdefined(var_146228fb))
	{
		var_146228fb delete();
	}
	self clientfield::set("" + #"hash_1142930568dc278b", 0);
	playsoundatposition(#"hash_279a376468c0749c", self.origin);
	self delete();
}

/*
	Name: function_4022d369
	Namespace: namespace_fc5c8455
	Checksum: 0x414744F4
	Offset: 0x2B80
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function function_4022d369(var_6282581e)
{
	level endon(#"hash_3ec656e276ceee53");
	self endon(#"hash_17f1f2fec5688f9a");
	self waittill(#"death", #"disconnect");
	if(level flag::get(#"hash_3fb7d58b07b04333"))
	{
		var_6282581e function_599013ad(self, 1);
	}
	level flag::set(#"hash_3ec656e276ceee53");
}

/*
	Name: function_8b619951
	Namespace: namespace_fc5c8455
	Checksum: 0x1D1C6C22
	Offset: 0x2C48
	Size: 0x128
	Parameters: 0
	Flags: Linked
*/
function function_8b619951()
{
	level endon(#"hash_3ec656e276ceee53");
	while(!level flag::get(#"hash_3fb7d58b07b04333"))
	{
		if(!self istouching(level.var_5f506a2b))
		{
			if(!isdefined(self.var_13a24eee))
			{
				self.var_13a24eee = 0;
			}
			else
			{
				self.var_13a24eee++;
				if(self.var_13a24eee >= 30)
				{
					level flag::set(#"hash_3ec656e276ceee53");
				}
				else if(self.var_13a24eee >= 10 && level.var_19a54d73 > 0)
				{
					level.var_19a54d73 = 0;
					function_a057cdf0();
				}
			}
		}
		else
		{
			self.var_13a24eee = 0;
		}
		wait(1);
	}
}

/*
	Name: function_6222e98f
	Namespace: namespace_fc5c8455
	Checksum: 0x5FE7F645
	Offset: 0x2D78
	Size: 0x2BE
	Parameters: 0
	Flags: Linked
*/
function function_6222e98f()
{
	if(!isdefined(self))
	{
		return;
	}
	self thread function_95a4deeb();
	self thread function_6b09dab1();
	self thread function_7f19d274();
	self.n_cooldown_time = 25;
	while(isdefined(self) && self.n_cooldown_time > 0 && (isdefined(self.var_1ea09849) && self.var_1ea09849))
	{
		self.n_cooldown_time = self.n_cooldown_time - 0.5;
		wait(0.5);
	}
	if(!isdefined(self))
	{
		return;
	}
	if(isdefined(self.var_1ea09849) && self.var_1ea09849 && self.n_cooldown_time <= 0)
	{
		if(self hasweapon(getweapon(#"hash_617dcc39334959ce")))
		{
			self clientfield::set_to_player("" + #"hash_1a9944b03fae8660", 0);
			self takeweapon(getweapon(#"hash_617dcc39334959ce"));
			playsoundatposition(#"hash_65b4e7aafb64c1a1", (0, 0, 0));
		}
		if(isdefined(self.var_22b64976))
		{
			self giveweapon(getweapon(self.var_22b64976));
			self switchtoweapon(getweapon(self.var_22b64976));
			self zm_audio::create_and_play_dialog(#"hash_14db46413dd7381e", #"hash_3f9b8ab1dea1f35c", undefined, 1);
			self.var_22b64976 = undefined;
		}
		self.var_1ea09849 = undefined;
		self notify(#"hash_3c807aeefe7734fa");
		function_e1f2fb39();
		self notify(#"hash_2c23d48f0925d266");
		level flag::clear(#"hash_5e6097345e223e2d");
	}
	self.n_cooldown_time = undefined;
}

/*
	Name: function_95a4deeb
	Namespace: namespace_fc5c8455
	Checksum: 0xEBB366C7
	Offset: 0x3040
	Size: 0x2A2
	Parameters: 0
	Flags: Linked
*/
function function_95a4deeb()
{
	self endon(#"death", #"disconnect", #"hash_5dc448a84a24492", #"hash_2c23d48f0925d266");
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"weapon_change", #"player_downed");
		if(var_88706ea7._notify === "player_downed")
		{
			var_e860f3d1 = 1;
		}
		else
		{
			wait(0.1);
		}
		if(isdefined(self.var_6417e645) && self.var_6417e645)
		{
			continue;
		}
		else if(!(isdefined(var_e860f3d1) && var_e860f3d1) && var_88706ea7.last_weapon !== getweapon(#"hash_617dcc39334959ce"))
		{
			continue;
		}
		else if(self hasweapon(getweapon(#"hash_617dcc39334959ce")))
		{
			self clientfield::set_to_player("" + #"hash_1a9944b03fae8660", 0);
			self takeweapon(getweapon(#"hash_617dcc39334959ce"));
			playsoundatposition(#"hash_65b4e7aafb64c1a1", (0, 0, 0));
		}
		if(isdefined(self.var_22b64976))
		{
			self giveweapon(getweapon(self.var_22b64976));
			self switchtoweapon(getweapon(self.var_22b64976));
			self.var_22b64976 = undefined;
		}
		level flag::clear(#"hash_5e6097345e223e2d");
		function_e1f2fb39();
		self.var_1ea09849 = undefined;
		self notify(#"hash_3c807aeefe7734fa");
		self notify(#"hash_2c23d48f0925d266");
	}
}

/*
	Name: function_6b09dab1
	Namespace: namespace_fc5c8455
	Checksum: 0x3FDF1EB4
	Offset: 0x32F0
	Size: 0x1DC
	Parameters: 0
	Flags: Linked
*/
function function_6b09dab1()
{
	self endon(#"death", #"disconnect", #"hash_5dc448a84a24492", #"hash_2c23d48f0925d266");
	self waittill(#"fasttravel_over");
	if(self hasweapon(getweapon(#"hash_617dcc39334959ce")))
	{
		self clientfield::set_to_player("" + #"hash_1a9944b03fae8660", 0);
		self takeweapon(getweapon(#"hash_617dcc39334959ce"));
		playsoundatposition(#"hash_65b4e7aafb64c1a1", (0, 0, 0));
		if(isdefined(self.var_22b64976))
		{
			self giveweapon(getweapon(self.var_22b64976));
			self switchtoweapon(getweapon(self.var_22b64976));
			self.var_22b64976 = undefined;
		}
		function_e1f2fb39();
		self.var_1ea09849 = undefined;
		self notify(#"hash_3c807aeefe7734fa");
		self notify(#"hash_2c23d48f0925d266");
		level flag::clear(#"hash_5e6097345e223e2d");
	}
}

/*
	Name: function_7f19d274
	Namespace: namespace_fc5c8455
	Checksum: 0xDEFF2D02
	Offset: 0x34D8
	Size: 0x140
	Parameters: 0
	Flags: Linked
*/
function function_7f19d274()
{
	self endon(#"death", #"disconnect", #"hash_5dc448a84a24492", #"hash_2c23d48f0925d266");
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"weapon_fired");
		if(var_88706ea7.weapon == getweapon(#"hash_617dcc39334959ce"))
		{
			/#
				assert(isdefined(self.n_cooldown_time), "");
			#/
			self.n_cooldown_time = self.n_cooldown_time - 6;
			self clientfield::increment_to_player("" + #"hash_39d19b76b846a27f");
			self givemaxammo(getweapon(#"hash_617dcc39334959ce"));
		}
	}
}

/*
	Name: function_ff4e7fcd
	Namespace: namespace_fc5c8455
	Checksum: 0x321BE5AF
	Offset: 0x3620
	Size: 0x160
	Parameters: 0
	Flags: Linked
*/
function function_ff4e7fcd()
{
	var_ff554ec = util::spawn_model("tag_origin", self.origin, self.angles);
	self.s_unitrigger_stub = self zm_unitrigger::create(&function_bc77319a, 64, &function_3e6b7a2d, 0);
	self.s_unitrigger_stub.var_ff554ec = var_ff554ec;
	self.var_ff554ec = var_ff554ec;
	wait(0.4);
	var_ff554ec clientfield::set("" + #"hash_6954721e3aab6b22", 1);
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = level waittill(#"hash_575b654fc5c59146");
		if(isplayer(var_88706ea7.e_player))
		{
			var_ff554ec clientfield::set("" + #"hash_6954721e3aab6b22", 2);
		}
	}
}

/*
	Name: function_bc77319a
	Namespace: namespace_fc5c8455
	Checksum: 0xC9A830D8
	Offset: 0x3788
	Size: 0x38
	Parameters: 1
	Flags: Linked
*/
function function_bc77319a(player)
{
	if(isdefined(player.var_1ea09849) && player.var_1ea09849)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_3e6b7a2d
	Namespace: namespace_fc5c8455
	Checksum: 0x79A1DEC8
	Offset: 0x37D0
	Size: 0x2A0
	Parameters: 0
	Flags: Linked
*/
function function_3e6b7a2d()
{
	var_fbab1c11 = undefined;
	while(true)
	{
		var_d249c0e6 = 25;
		n_power = var_d249c0e6;
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"trigger");
		e_player = var_88706ea7.activator;
		if(isdefined(e_player.var_1ea09849) && e_player.var_1ea09849 && var_d249c0e6 > 0)
		{
			self.stub.var_ff554ec clientfield::increment("" + #"hash_3c74a33b8e1adb73");
			self.stub.var_ff554ec clientfield::set("" + #"hash_6954721e3aab6b22", 0);
			if(isdefined(e_player.n_cooldown_time))
			{
				if(e_player.n_cooldown_time + n_power > 25)
				{
					e_player.n_cooldown_time = 25;
				}
				else
				{
					e_player.n_cooldown_time = e_player.n_cooldown_time + n_power;
				}
			}
			var_d249c0e6 = 0;
			if(isalive(e_player) && (isdefined(e_player.var_1ea09849) && e_player.var_1ea09849))
			{
				e_player clientfield::increment_to_player("" + #"hash_c79e0b124c4b75");
				e_player givemaxammo(getweapon(#"hash_617dcc39334959ce"));
				if(!(isdefined(e_player.var_a40e9d01) && e_player.var_a40e9d01))
				{
					e_player.var_a40e9d01 = 1;
					e_player thread function_e02f6600();
					e_player zm_audio::create_and_play_dialog(#"hash_14db46413dd7381e", #"hash_2d83229cecbed82", undefined, 1);
				}
			}
			level waittill(#"hash_575b654fc5c59146");
		}
	}
}

/*
	Name: function_e02f6600
	Namespace: namespace_fc5c8455
	Checksum: 0xA69E9D26
	Offset: 0x3A78
	Size: 0x2A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_e02f6600()
{
	self endon(#"disconnect");
	wait(45);
	self.var_a40e9d01 = undefined;
}

/*
	Name: function_e1f2fb39
	Namespace: namespace_fc5c8455
	Checksum: 0x41AF3FDB
	Offset: 0x3AB0
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function function_e1f2fb39()
{
	var_99f0b8d7 = struct::get_array("mg_fire_urn", "targetname");
	foreach(var_1fb87b8e in var_99f0b8d7)
	{
		var_1fb87b8e.var_ff554ec clientfield::set("" + #"hash_6954721e3aab6b22", 1);
	}
	exploder::stop_exploder("blue_fire");
}

/*
	Name: function_316db647
	Namespace: namespace_fc5c8455
	Checksum: 0xDA51823B
	Offset: 0x3B98
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function function_316db647()
{
	var_dc49a24d = struct::get("mg_forg_pos");
	var_dc49a24d = struct::get(var_dc49a24d.target);
	var_dc49a24d.s_unitrigger_stub = var_dc49a24d zm_unitrigger::create(&function_77e65267, 80, &function_d3db303d, 1);
	zm_unitrigger::unitrigger_force_per_player_triggers(var_dc49a24d.s_unitrigger_stub);
}

/*
	Name: function_77e65267
	Namespace: namespace_fc5c8455
	Checksum: 0x9CAEB125
	Offset: 0x3C48
	Size: 0x598
	Parameters: 1
	Flags: Linked
*/
function function_77e65267(player)
{
	if(isdefined(zm_audio::function_fa4dfde0(player.currentweapon)))
	{
		return 0;
	}
	if(player hasweapon(getweapon(#"hash_617dcc39334959ce")) && !isdefined(self.stub.var_cec3094a))
	{
		if(function_8b1a219a())
		{
			self sethintstring(#"hash_4aaa1b70a31edb6f");
		}
		else
		{
			self sethintstring(#"hash_6aefb24885426431");
		}
		return 1;
	}
	if(player hasweapon(getweapon(#"hash_19c157f2230454ad")) || player hasweapon(getweapon(#"hash_cb1cdb5b47f0226")) || player hasweapon(getweapon(#"hash_25a13b6f6232a985")) || player hasweapon(getweapon(#"hash_4c157b1aeefae09e")) && level flag::get(#"hash_38c04d24b5213b00") && !isdefined(self.stub.var_cec3094a))
	{
		if(player hasweapon(getweapon(#"hash_19c157f2230454ad")))
		{
			if(function_8b1a219a())
			{
				self sethintstring(#"hash_4aaa1b70a31edb6f");
			}
			else
			{
				self sethintstring(#"hash_6aefb24885426431");
			}
		}
		else if(player hasweapon(getweapon(#"hash_cb1cdb5b47f0226")))
		{
			if(function_8b1a219a())
			{
				self sethintstring(#"hash_6363a7fc77e158a4");
			}
			else
			{
				self sethintstring(#"hash_7755302d416e3168");
			}
		}
		else if(player hasweapon(getweapon(#"hash_25a13b6f6232a985")))
		{
			if(function_8b1a219a())
			{
				self sethintstring(#"hash_49c7816541364de0");
			}
			else
			{
				self sethintstring(#"hash_1875e6c5a3e5e96c");
			}
		}
		else if(player hasweapon(getweapon(#"hash_4c157b1aeefae09e")))
		{
			if(function_8b1a219a())
			{
				self sethintstring(#"hash_66c939cc0e7e3b08");
			}
			else
			{
				self sethintstring(#"hash_ecb311bfa753664");
			}
		}
		return 1;
	}
	if(isdefined(self.stub.var_154419fd) && self.stub.var_154419fd && (isdefined(player.var_6417e645) && player.var_6417e645))
	{
		if(self.stub.var_515e20e6)
		{
			if(function_8b1a219a())
			{
				self sethintstring(#"hash_e737d245c39d9ea");
			}
			else
			{
				self sethintstring(#"hash_293170106f0832fe");
			}
		}
		else if(function_8b1a219a())
		{
			self sethintstring(#"hash_4734e26452e1c11b");
		}
		else
		{
			self sethintstring(#"hash_14afad0ad7a156a5");
		}
		return 1;
	}
	return 0;
}

/*
	Name: function_d3db303d
	Namespace: namespace_fc5c8455
	Checksum: 0x3ECEA4EA
	Offset: 0x41F0
	Size: 0x8A0
	Parameters: 0
	Flags: Linked
*/
function function_d3db303d()
{
	v_weapon_origin_offset = vectorscale((0, 0, 1), 9);
	v_weapon_angles_offset = vectorscale((0, -1, 0), 90);
	self.stub.v_weapon_origin = level.var_bff24582.origin + anglestoforward(level.var_bff24582.angles) * 15 + v_weapon_origin_offset;
	self.stub.v_weapon_angles = level.var_bff24582.angles + v_weapon_angles_offset;
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"trigger");
		e_player = var_88706ea7.activator;
		var_fc074136 = undefined;
		if(!(isdefined(self.stub.var_154419fd) && self.stub.var_154419fd))
		{
			if(!level flag::get(#"hash_38c04d24b5213b00"))
			{
				if(e_player hasweapon(getweapon(#"hash_617dcc39334959ce")))
				{
					var_fc074136 = #"hash_617dcc39334959ce";
				}
			}
			else if(e_player hasweapon(getweapon(#"hash_19c157f2230454ad")))
			{
				var_fc074136 = #"hash_19c157f2230454ad";
			}
			else if(e_player hasweapon(getweapon(#"hash_cb1cdb5b47f0226")))
			{
				var_fc074136 = #"hash_cb1cdb5b47f0226";
			}
			else if(e_player hasweapon(getweapon(#"hash_25a13b6f6232a985")))
			{
				var_fc074136 = #"hash_25a13b6f6232a985";
			}
			else if(e_player hasweapon(getweapon(#"hash_4c157b1aeefae09e")))
			{
				var_fc074136 = #"hash_4c157b1aeefae09e";
			}
			if(isdefined(var_fc074136))
			{
				self.stub.var_cec3094a = 1;
				if(var_fc074136 == #"hash_617dcc39334959ce")
				{
					e_player clientfield::set_to_player("" + #"hash_1a9944b03fae8660", 0);
				}
				else
				{
					var_da887cb9 = getweapon(var_fc074136);
					e_player.var_452feb6c = e_player getweaponammostock(var_da887cb9);
				}
				e_player thread zm_audio::create_and_play_dialog(#"hash_74a0ff3487006243", #"generic");
				e_player takeweapon(getweapon(var_fc074136));
				e_player.var_6417e645 = 1;
				e_player.var_1ea09849 = undefined;
				e_player notify(#"hash_3c807aeefe7734fa");
				e_player notify(#"hash_5dc448a84a24492");
				if(isplayer(e_player) && (!(isdefined(e_player.intermission) && e_player.intermission)) && (!(isdefined(e_player.is_drinking) && e_player.is_drinking)))
				{
					e_player zm_weapons::switch_back_primary_weapon();
				}
				self.stub.var_607f49de = zm_utility::spawn_weapon_model(getweapon(var_fc074136), undefined, self.stub.v_weapon_origin, self.stub.v_weapon_angles);
				self.stub.e_player = e_player;
				var_25b99c94 = struct::get("s_ni_mach");
				var_25b99c94 thread scene::play();
				level notify(#"hash_5dc448a84a24492");
				function_e1f2fb39();
				self.stub thread function_e672cf9(e_player, var_fc074136);
				self.stub thread function_ecc34f71(e_player);
			}
		}
		else if(e_player == self.stub.e_player)
		{
			if(zm_utility::can_use(e_player, 1) && e_player.currentweapon.name != "none")
			{
				self.stub notify(#"hash_17f1f2fec5688f9a");
				e_player notify(#"hash_17f1f2fec5688f9a");
				var_287a8343 = zm_utility::get_player_weapon_limit(e_player);
				var_4f33a328 = e_player getweaponslistprimaries();
				if(isdefined(var_4f33a328) && var_4f33a328.size >= var_287a8343)
				{
					e_player takeweapon(e_player.currentweapon);
				}
				if(isdefined(self.stub.var_515e20e6) && self.stub.var_515e20e6)
				{
					var_f2fae71a = getweapon(#"hash_1b5092cccdb3d65b");
				}
				else
				{
					var_f2fae71a = getweapon(#"hash_23882a5729dceca");
				}
				e_player giveweapon(var_f2fae71a);
				e_player switchtoweapon(var_f2fae71a);
				if(isdefined(e_player.var_452feb6c))
				{
					e_player setweaponammostock(var_f2fae71a, math::clamp(e_player.var_452feb6c, 0, var_f2fae71a.maxammo));
					e_player.var_452feb6c = undefined;
				}
				e_player thread zm_audio::create_and_play_dialog(#"weapon_pickup", #"hash_14db46413dd7381e");
				e_player notify(#"hash_6e0a27b37f225a25");
				self.stub.var_154419fd = undefined;
				if(isdefined(e_player))
				{
					e_player.var_6417e645 = undefined;
					e_player.var_22b64976 = undefined;
				}
				if(!level flag::get(#"hash_38c04d24b5213b00"))
				{
					namespace_961cf978::attempt_brutus_spawn(1, "zone_new_industries");
				}
				level flag::set(#"hash_38c04d24b5213b00");
				self.stub.var_cec3094a = undefined;
				self.stub.var_515e20e6 = 0;
				self.stub.e_player = undefined;
				if(isdefined(self.stub.var_607f49de))
				{
					self.stub.var_607f49de delete();
				}
			}
		}
	}
}

/*
	Name: function_e672cf9
	Namespace: namespace_fc5c8455
	Checksum: 0x64EB6888
	Offset: 0x4A98
	Size: 0x234
	Parameters: 2
	Flags: Linked
*/
function function_e672cf9(e_player, var_fc074136)
{
	self endon(#"hash_17f1f2fec5688f9a");
	level waittill(#"hash_b36aace774a3377");
	self.var_607f49de ghost();
	level waittill(#"hash_933f0a634e259d9");
	self.var_607f49de show();
	if(isdefined(e_player))
	{
		self.var_154419fd = 1;
		self.var_515e20e6 = 0;
		if(!level flag::get(#"hash_38c04d24b5213b00"))
		{
			self.var_515e20e6 = self function_a6a91f7a(e_player.var_22b64976);
		}
		else
		{
			self.var_515e20e6 = self function_a6a91f7a(var_fc074136);
		}
		self thread wait_for_timeout(e_player);
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"hash_5df93e8b56c1c70e");
		playsoundatposition(#"hash_65b4e7aafb64c1a1", (0, 0, 0));
		level flag::clear(#"hash_5e6097345e223e2d");
		if(isdefined(self.e_player))
		{
			self.e_player.var_6417e645 = undefined;
			self.e_player = undefined;
		}
		self.var_cec3094a = undefined;
		self.var_515e20e6 = 0;
		self.var_154419fd = undefined;
		if(isdefined(self.var_607f49de))
		{
			self.var_607f49de clientfield::increment("" + #"hash_31f39c058ef79e2");
			waitframe(1);
			self.var_607f49de delete();
		}
	}
}

/*
	Name: function_6672db20
	Namespace: namespace_fc5c8455
	Checksum: 0xA616E0A8
	Offset: 0x4CD8
	Size: 0x1D4
	Parameters: 1
	Flags: Linked
*/
function function_6672db20(a_ents)
{
	var_36fa84e8 = a_ents[#"hash_5e9dee7036d632d2"];
	var_48c0a804 = a_ents[#"hash_5e9ded7036d6311f"];
	var_36fa84e8 clientfield::set("" + #"hash_7692067c56d8b6cc", 1);
	var_48c0a804 clientfield::set("" + #"hash_7692067c56d8b6cc", 1);
	var_48c0a804 waittill(#"start_alpha");
	var_48c0a804 clientfield::set("" + #"hash_7692067c56d8b6cc", 2);
	var_36fa84e8 waittill(#"start_alpha");
	var_36fa84e8 clientfield::set("" + #"hash_7692067c56d8b6cc", 2);
	var_36fa84e8 waittill(#"end_alpha");
	var_36fa84e8 clientfield::set("" + #"hash_7692067c56d8b6cc", 0);
	var_48c0a804 clientfield::set("" + #"hash_7692067c56d8b6cc", 0);
}

/*
	Name: function_a6a91f7a
	Namespace: namespace_fc5c8455
	Checksum: 0x13EAFAD9
	Offset: 0x4EB8
	Size: 0x15E
	Parameters: 1
	Flags: Linked, Private
*/
private function function_a6a91f7a(var_f2528cbc)
{
	if(isdefined(self.var_607f49de))
	{
		self.var_607f49de delete();
	}
	if(!isdefined(var_f2528cbc))
	{
		self.var_607f49de = zm_utility::spawn_weapon_model(getweapon(#"hash_23882a5729dceca"), undefined, self.v_weapon_origin, self.v_weapon_angles);
		return 0;
	}
	if(var_f2528cbc == #"hash_19c157f2230454ad" || var_f2528cbc == #"hash_25a13b6f6232a985")
	{
		self.var_607f49de = zm_utility::spawn_weapon_model(getweapon(#"hash_23882a5729dceca"), undefined, self.v_weapon_origin, self.v_weapon_angles);
		return 0;
	}
	self.var_607f49de = zm_utility::spawn_weapon_model(getweapon(#"hash_1b5092cccdb3d65b"), undefined, self.v_weapon_origin, self.v_weapon_angles);
	return 1;
}

/*
	Name: function_ecc34f71
	Namespace: namespace_fc5c8455
	Checksum: 0xF46E3720
	Offset: 0x5020
	Size: 0x8E
	Parameters: 1
	Flags: Linked
*/
function function_ecc34f71(e_player)
{
	self endon(#"hash_17f1f2fec5688f9a", #"hash_5df93e8b56c1c70e");
	e_player waittill(#"death", #"disconnect");
	self.e_player = undefined;
	self.var_cec3094a = undefined;
	self.var_515e20e6 = 0;
	self.e_player = undefined;
	self notify(#"hash_5df93e8b56c1c70e");
}

/*
	Name: function_78ca248c
	Namespace: namespace_fc5c8455
	Checksum: 0xC3D29318
	Offset: 0x50B8
	Size: 0x84
	Parameters: 0
	Flags: None
*/
function function_78ca248c()
{
	/#
		if(!getdvarint(#"hash_11ad6a9695943217", 0))
		{
			return;
		}
		zm_devgui::add_custom_devgui_callback(&function_6f4823a9);
		adddebugcommand("");
		adddebugcommand("");
	#/
}

/*
	Name: function_6f4823a9
	Namespace: namespace_fc5c8455
	Checksum: 0xC7881620
	Offset: 0x5148
	Size: 0x14A
	Parameters: 1
	Flags: None
*/
function function_6f4823a9(cmd)
{
	/#
		switch(cmd)
		{
			case "hash_2406dff55d52785a":
			{
				foreach(var_a2a0a44e in level.var_8e6fc65e)
				{
					var_a2a0a44e setmodel("");
					var_a2a0a44e clientfield::set("" + #"hash_5f7eb9d1316d02a7", 1);
				}
				level flag::set(#"hash_3fb7d58b07b04333");
				break;
			}
			case "hash_384ee6deba35ca28":
			{
				level flag::set(#"hash_38c04d24b5213b00");
				break;
			}
		}
	#/
}

/*
	Name: function_b00fd241
	Namespace: namespace_fc5c8455
	Checksum: 0xAAA4142F
	Offset: 0x52A0
	Size: 0x34C
	Parameters: 0
	Flags: Linked
*/
function function_b00fd241()
{
	var_7de73bd2 = struct::get_array("key_door_trigger", "targetname");
	foreach(var_f4539b2e in var_7de73bd2)
	{
		var_f4539b2e.a_e_doors = [];
		a_e_parts = getentarray(var_f4539b2e.target, "targetname");
		foreach(e_part in a_e_parts)
		{
			if(e_part.script_noteworthy === "door")
			{
				if(!isdefined(var_f4539b2e.a_e_doors))
				{
					var_f4539b2e.a_e_doors = [];
				}
				else if(!isarray(var_f4539b2e.a_e_doors))
				{
					var_f4539b2e.a_e_doors = array(var_f4539b2e.a_e_doors);
				}
				if(!isinarray(var_f4539b2e.a_e_doors, e_part))
				{
					var_f4539b2e.a_e_doors[var_f4539b2e.a_e_doors.size] = e_part;
				}
				continue;
			}
			if(e_part.script_noteworthy === "clip")
			{
				var_f4539b2e.e_clip = e_part;
				continue;
			}
			if(e_part.script_noteworthy === "lock")
			{
				var_f4539b2e.var_82e1ca26 = e_part;
				continue;
			}
			if(e_part.script_noteworthy === "item_part")
			{
				var_f4539b2e.var_2e1f34dd = e_part;
			}
		}
	}
	namespace_93829f86::function_4d230236(getweapon(#"hash_5517c404e6d9592b"), &function_6fe98729);
	namespace_93829f86::function_4d230236(getweapon(#"hash_5517c504e6d95ade"), &function_6fe98729);
	namespace_93829f86::function_4d230236(getweapon(#"hash_5517c604e6d95c91"), &function_6fe98729);
	array::thread_all(var_7de73bd2, &function_48c915fa);
}

/*
	Name: function_6fe98729
	Namespace: namespace_fc5c8455
	Checksum: 0xBBC1BA2A
	Offset: 0x55F8
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function function_6fe98729(e_holder, var_9c95ad05)
{
	self playsound(#"hash_230737b2535a3374");
}

/*
	Name: function_48c915fa
	Namespace: namespace_fc5c8455
	Checksum: 0x9E93E2CC
	Offset: 0x5638
	Size: 0x432
	Parameters: 0
	Flags: Linked
*/
function function_48c915fa()
{
	t_door = spawn("trigger_radius_use", self.origin, 0, 64, 64);
	t_door setcursorhint("HINT_NOICON");
	t_door triggerignoreteam();
	t_door setvisibletoall();
	t_door thread function_38792a35();
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = t_door waittill(#"trigger");
		e_player = var_88706ea7.activator;
		if(level flag::get(#"hash_7039457b1cc827de"))
		{
			t_door delete();
			self.var_82e1ca26 delete();
			foreach(e_door in self.a_e_doors)
			{
				if(isdefined(e_door.script_vector))
				{
					e_door rotateto(e_door.script_vector, 1);
				}
				else
				{
					e_door movez(10000, 1);
				}
				if(isdefined(e_door.script_sound))
				{
					playsoundatposition(e_door.script_sound, e_door.origin);
				}
			}
			if(isdefined(self.var_2e1f34dd) && isdefined(self.var_2e1f34dd.script_int))
			{
				if(self.var_2e1f34dd.script_int == 1)
				{
					level flag::set(#"activate_sally_port_acid");
					self.var_2e1f34dd ghost();
					var_80c0f2e6 = namespace_a1d9b01d::function_4c2f8683(#"hash_5517c404e6d9592b");
					namespace_93829f86::spawn_item(var_80c0f2e6, self.var_2e1f34dd.origin, self.var_2e1f34dd.angles);
					self.var_2e1f34dd delete();
				}
				if(self.var_2e1f34dd.script_int == 2)
				{
					self.var_2e1f34dd ghost();
					var_80c0f2e6 = namespace_a1d9b01d::function_4c2f8683(#"hash_5517c504e6d95ade");
					namespace_93829f86::spawn_item(var_80c0f2e6, self.var_2e1f34dd.origin, self.var_2e1f34dd.angles);
					self.var_2e1f34dd delete();
				}
			}
			if(isdefined(self.e_clip))
			{
				self.e_clip notsolid();
				self.e_clip connectpaths();
				wait(0.5);
				if(isdefined(self.e_clip))
				{
					self.e_clip delete();
				}
			}
			return;
		}
	}
}

/*
	Name: function_38792a35
	Namespace: namespace_fc5c8455
	Checksum: 0xB450267F
	Offset: 0x5A78
	Size: 0xB4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_38792a35()
{
	self endon(#"death");
	self sethintstring(#"hash_2f5a14e8bf175422");
	level flag::wait_till(#"hash_7039457b1cc827de");
	if(function_8b1a219a())
	{
		self sethintstring(#"hash_782c9287b8dfe2d4");
	}
	else
	{
		self sethintstring(#"hash_6ca88a5a4b9466d8");
	}
}

