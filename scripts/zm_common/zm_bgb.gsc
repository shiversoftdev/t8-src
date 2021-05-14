// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_47fb62300ac0bd60;
#using script_61a734c95edc17aa;
#using script_6e3c826b1814cab6;
#using script_ab890501c40b73c;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\demo_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\gestures.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\potm_shared.gsc;
#using scripts\core_common\rank_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace bgb;

/*
	Name: function_89f2df9
	Namespace: bgb
	Checksum: 0x9C672F76
	Offset: 0x2B8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"bgb", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: bgb
	Checksum: 0x4A79712C
	Offset: 0x308
	Size: 0x2DC
	Parameters: 0
	Flags: Linked, Private
*/
private function __init__()
{
	callback::on_spawned(&on_player_spawned);
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	level.var_d5e0e60b = getweapon(#"zombie_bgb_grab");
	level.var_ddff6359 = array(getweapon(#"hash_d0f29de78e218ad"), getweapon(#"hash_5e07292c519531e6"), getweapon(#"hash_305e5faa9ecb625a"), getweapon(#"hash_23cc1f9c16b375c3"), getweapon(#"hash_155cc0a9ba3c3260"), getweapon(#"hash_2394c41f048f7d2"), getweapon(#"hash_4565adf3abc61ea3"));
	level.bgb = [];
	clientfield::function_a8bbc967("zmhud.bgb_current", 1, 8, "int", 0);
	clientfield::function_a8bbc967("zmhud.bgb_display", 1, 1, "int", 0);
	clientfield::function_a8bbc967("zmhud.bgb_timer", 1, 8, "float", 0);
	clientfield::function_a8bbc967("zmhud.bgb_activations_remaining", 1, 3, "int", 0);
	clientfield::function_a8bbc967("zmhud.bgb_invalid_use", 1, 1, "counter", 0);
	clientfield::function_a8bbc967("zmhud.bgb_one_shot_use", 1, 1, "counter", 0);
	clientfield::register("toplayer", "bgb_blow_bubble", 1, 1, "counter");
	zm::register_vehicle_damage_callback(&vehicle_damage_override);
	zm_perks::register_lost_perk_override(&lost_perk_override);
}

/*
	Name: __main__
	Namespace: bgb
	Checksum: 0x4CE7CAA8
	Offset: 0x5F0
	Size: 0x82
	Parameters: 0
	Flags: Linked, Private
*/
private function __main__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	function_174e1d8e();
	/#
		level thread setup_devgui();
	#/
	level._effect[#"samantha_steal"] = #"zombie/fx_monkey_lightning_zmb";
}

/*
	Name: on_player_spawned
	Namespace: bgb
	Checksum: 0x822709AB
	Offset: 0x680
	Size: 0x56
	Parameters: 0
	Flags: Linked, Private
*/
private function on_player_spawned()
{
	self.bgb = #"none";
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	self thread function_c2e519e0();
	self.var_1898de24 = [];
}

/*
	Name: function_c2e519e0
	Namespace: bgb
	Checksum: 0x10CBD8F1
	Offset: 0x6E0
	Size: 0x74A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_c2e519e0()
{
	if(isdefined(self.var_7d0afffb))
	{
		for(i = 0; i < 4; i++)
		{
			if(isdefined(self.var_7d0afffb[i]) && isdefined(level.bgb[self.var_7d0afffb[i]]))
			{
				self namespace_7d0afffb::function_7b91e81c(i, level.bgb[self.var_7d0afffb[i]].item_index);
			}
		}
		return;
	}
	self.var_7d0afffb = self getbubblegumpack();
	for(x = 0; x < self.var_7d0afffb.size; x++)
	{
		if(isstring(self.var_7d0afffb[x]))
		{
			self.var_7d0afffb[x] = hash(self.var_7d0afffb[x]);
		}
	}
	self.var_682ee74a = [];
	var_6e18a410 = array();
	for(i = 0; i < 4; i++)
	{
		var_4c47dfdb = self.var_7d0afffb[i];
		if(var_4c47dfdb == #"weapon_null")
		{
			continue;
		}
		if(namespace_59ff1d6c::function_3ac936c6(var_4c47dfdb))
		{
			var_6e18a410[i] = var_4c47dfdb;
			continue;
		}
		if(var_4c47dfdb != #"weapon_null" && self getbgbremaining(var_4c47dfdb) > 0)
		{
			self thread namespace_59ff1d6c::function_deae84ba();
		}
	}
	self.var_7d0afffb = var_6e18a410;
	/#
		if(isdefined(self.var_d03d9cf3))
		{
			self.var_7d0afffb = self.var_d03d9cf3;
		}
	#/
	self.var_ed782493 = [];
	foreach(bgb in self.var_7d0afffb)
	{
		if(bgb == #"weapon_null")
		{
			continue;
		}
		if(isdefined(level.bgb) && isdefined(level.bgb[bgb]) && (!(isdefined(level.bgb[bgb].consumable) && level.bgb[bgb].consumable)))
		{
			continue;
		}
		self.var_ed782493[bgb] = spawnstruct();
		if(!isbot(self))
		{
			self.var_ed782493[bgb].var_c2a984f0 = self getbgbremaining(bgb);
		}
		else
		{
			self.var_ed782493[bgb].var_c2a984f0 = 0;
		}
		self.var_ed782493[bgb].var_a286cbfb = 0;
	}
	self function_3b5f181a();
	self thread bgb_player_monitor();
	self thread function_8613a3d2();
	for(i = 0; i < 4; i++)
	{
		if(isdefined(self.var_7d0afffb[i]) && isdefined(level.bgb[self.var_7d0afffb[i]]))
		{
			self namespace_7d0afffb::function_7b91e81c(i, level.bgb[self.var_7d0afffb[i]].item_index);
		}
	}
	if(namespace_59ff1d6c::function_901b751c(#"hash_3ab7cedcfef7eacc"))
	{
		var_66dd5e25 = array(#"hash_a303f67afd6f4a8", #"zm_bgb_now_you_see_me");
		n_rank = self rank::getrank() + 1;
		foreach(bgb in level.bgb)
		{
			str_name = bgb.name;
			if(bgb.rarity === 0 && str_name != #"hash_177ea318753f5418" && !array::contains(self.var_7d0afffb, str_name))
			{
				var_544e77f8 = level.bgb[str_name].var_a1750d43;
				if(!isdefined(var_544e77f8) || (isdefined(var_544e77f8) && n_rank >= var_544e77f8 || function_bea73b01() == 1) && namespace_59ff1d6c::function_3ac936c6(str_name))
				{
					if(!isinarray(var_66dd5e25, str_name))
					{
						if(!isdefined(self.var_2b74c8fe))
						{
							self.var_2b74c8fe = [];
						}
						else if(!isarray(self.var_2b74c8fe))
						{
							self.var_2b74c8fe = array(self.var_2b74c8fe);
						}
						self.var_2b74c8fe[self.var_2b74c8fe.size] = str_name;
					}
					if(!isdefined(self.var_82971641))
					{
						self.var_82971641 = [];
					}
					else if(!isarray(self.var_82971641))
					{
						self.var_82971641 = array(self.var_82971641);
					}
					self.var_82971641[self.var_82971641.size] = str_name;
				}
			}
		}
	}
}

/*
	Name: function_8613a3d2
	Namespace: bgb
	Checksum: 0x88075591
	Offset: 0xE38
	Size: 0x3C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_8613a3d2()
{
	self endon(#"disconnect");
	self waittill(#"report_bgb_consumption");
	self thread take();
}

/*
	Name: function_174e1d8e
	Namespace: bgb
	Checksum: 0x697D8C89
	Offset: 0xE80
	Size: 0x212
	Parameters: 0
	Flags: Linked, Private
*/
private function function_174e1d8e()
{
	foreach(v in level.bgb)
	{
		v.item_index = getitemindexfromref(v.name);
		var_ddcb67f4 = getunlockableiteminfofromindex(v.item_index, 2);
		v.stat_index = isdefined(var_ddcb67f4) && (isdefined(var_ddcb67f4.var_2f8e25b8) ? var_ddcb67f4.var_2f8e25b8 : 0);
		var_5415dfb9 = function_b143666d(v.item_index, 2);
		if(!isdefined(var_ddcb67f4) || !isdefined(var_5415dfb9))
		{
			/#
				println("" + v.name + "");
			#/
			continue;
		}
		if(!isdefined(var_5415dfb9.var_f5aaa47e))
		{
			var_5415dfb9.var_f5aaa47e = 0;
		}
		v.rarity = var_5415dfb9.var_f5aaa47e;
		if(0 == v.rarity || 1 == v.rarity)
		{
			v.consumable = 0;
		}
		else
		{
			v.consumable = 1;
		}
		v.camo_index = var_5415dfb9.var_daefc551;
		v.var_17f85838 = var_ddcb67f4.dlc;
	}
}

/*
	Name: bgb_player_monitor
	Namespace: bgb
	Checksum: 0x12997996
	Offset: 0x10A0
	Size: 0xD8
	Parameters: 0
	Flags: Linked, Private
*/
private function bgb_player_monitor()
{
	self endon(#"disconnect");
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(#"between_round_over", #"restart_round");
		str_return = waitresult._notify;
		if(isdefined(level.var_b77403b9))
		{
			if(!(isdefined(self [[level.var_b77403b9]]()) && self [[level.var_b77403b9]]()))
			{
				continue;
			}
		}
		if(str_return === "restart_round")
		{
			level waittill(#"between_round_over");
		}
	}
}

/*
	Name: setup_devgui
	Namespace: bgb
	Checksum: 0x40344E5E
	Offset: 0x1180
	Size: 0x244
	Parameters: 0
	Flags: Private
*/
private function setup_devgui()
{
	/#
		waittillframeend();
		setdvar(#"bgb_acquire_devgui", "");
		setdvar(#"hash_7877ee182ba11433", -1);
		bgb_devgui_base = "";
		keys = getarraykeys(level.bgb);
		foreach(key in keys)
		{
			name = function_9e72a96(level.bgb[key].name);
			adddebugcommand(bgb_devgui_base + name + "" + "" + "" + name + "");
		}
		adddebugcommand(bgb_devgui_base + "" + "" + "" + "" + "");
		for(i = 0; i < 4; i++)
		{
			playernum = i + 1;
			adddebugcommand(bgb_devgui_base + "" + playernum + "" + "" + "" + i + "");
		}
		level thread bgb_devgui_think();
	#/
}

/*
	Name: bgb_devgui_think
	Namespace: bgb
	Checksum: 0x7B72272E
	Offset: 0x13D0
	Size: 0x90
	Parameters: 0
	Flags: Private
*/
private function bgb_devgui_think()
{
	/#
		for(;;)
		{
			var_522737d6 = getdvarstring(#"bgb_acquire_devgui");
			if(var_522737d6 != "")
			{
				function_331277d1(var_522737d6);
			}
			setdvar(#"bgb_acquire_devgui", "");
			wait(0.5);
		}
	#/
}

/*
	Name: function_331277d1
	Namespace: bgb
	Checksum: 0x6A748773
	Offset: 0x1468
	Size: 0x146
	Parameters: 1
	Flags: Private
*/
private function function_331277d1(bgb_name)
{
	/#
		bgb_name = hash(bgb_name);
		playerid = getdvarint(#"hash_7877ee182ba11433", 0);
		players = getplayers();
		for(i = 0; i < players.size; i++)
		{
			if(playerid != -1 && playerid != i)
			{
				continue;
			}
			if(#"none" == bgb_name)
			{
				players[i] thread take();
				continue;
			}
			players[i] bgb_gumball_anim(bgb_name);
			if(isdefined(level.bgb[bgb_name].activation_func))
			{
				players[i] thread function_b7ba7d51(bgb_name);
			}
		}
	#/
}

/*
	Name: bgb_debug_text_display_init
	Namespace: bgb
	Checksum: 0x28158ACB
	Offset: 0x15B8
	Size: 0x142
	Parameters: 0
	Flags: Private
*/
private function bgb_debug_text_display_init()
{
	/#
		self.bgb_debug_text = newdebughudelem(self);
		self.bgb_debug_text.elemtype = "";
		self.bgb_debug_text.font = "";
		self.bgb_debug_text.fontscale = 1.8;
		self.bgb_debug_text.horzalign = "";
		self.bgb_debug_text.vertalign = "";
		self.bgb_debug_text.alignx = "";
		self.bgb_debug_text.aligny = "";
		self.bgb_debug_text.x = 15;
		self.bgb_debug_text.y = 35;
		self.bgb_debug_text.sort = 2;
		self.bgb_debug_text.color = (1, 1, 1);
		self.bgb_debug_text.alpha = 1;
		self.bgb_debug_text.hidewheninmenu = 1;
	#/
}

/*
	Name: bgb_set_debug_text
	Namespace: bgb
	Checksum: 0x5F1B83C0
	Offset: 0x1708
	Size: 0x1BE
	Parameters: 2
	Flags: Private
*/
private function bgb_set_debug_text(name, activations_remaining)
{
	/#
		if(!isdefined(self.bgb_debug_text))
		{
			return;
		}
		if(isdefined(activations_remaining))
		{
		}
		self notify(#"bgb_set_debug_text_thread");
		self endon(#"bgb_set_debug_text_thread", #"disconnect");
		self.bgb_debug_text fadeovertime(0.05);
		self.bgb_debug_text.alpha = 1;
		prefix = "";
		short_name = name;
		if(issubstr(name, prefix))
		{
			short_name = getsubstr(name, prefix.size);
		}
		if(isdefined(activations_remaining))
		{
			self.bgb_debug_text settext("" + short_name + "" + activations_remaining + "");
		}
		else
		{
			self.bgb_debug_text settext("" + short_name);
		}
		wait(1);
		if(#"none" == name)
		{
			self.bgb_debug_text fadeovertime(1);
			self.bgb_debug_text.alpha = 0;
		}
	#/
}

/*
	Name: function_188002fa
	Namespace: bgb
	Checksum: 0x9A6BD15
	Offset: 0x18D0
	Size: 0x114
	Parameters: 1
	Flags: None
*/
function function_188002fa(bgb)
{
	/#
		printtoprightln(function_9e72a96(bgb) + "" + self.var_ed782493[bgb].var_c2a984f0, (1, 1, 1));
		printtoprightln(function_9e72a96(bgb) + "" + self.var_ed782493[bgb].var_a286cbfb, (1, 1, 1));
		n_available = self.var_ed782493[bgb].var_c2a984f0 - self.var_ed782493[bgb].var_a286cbfb;
		printtoprightln(function_9e72a96(bgb) + "" + n_available, (1, 1, 1));
	#/
}

/*
	Name: function_e7678497
	Namespace: bgb
	Checksum: 0x3F313718
	Offset: 0x19F0
	Size: 0x68
	Parameters: 1
	Flags: Linked, Private
*/
private function function_e7678497(bgb)
{
	if(!isdefined(self.var_ed782493[bgb]) || (!(isdefined(level.bgb[bgb].consumable) && level.bgb[bgb].consumable)))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_b3a02b1f
	Namespace: bgb
	Checksum: 0x3F4FD606
	Offset: 0x1A68
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function function_b3a02b1f(bgb)
{
	if(!function_e7678497(bgb))
	{
		return;
	}
	if(isdefined(level.bgb[bgb].var_f8d9ac8c) && ![[level.bgb[bgb].var_f8d9ac8c]]())
	{
		return;
	}
	self.var_ed782493[bgb].var_a286cbfb++;
	if(level flag::exists("first_consumables_used"))
	{
		level flag::set("first_consumables_used");
	}
	/#
		function_188002fa(bgb);
	#/
}

/*
	Name: function_b7fa03cd
	Namespace: bgb
	Checksum: 0xEC47FF32
	Offset: 0x1B48
	Size: 0xB2
	Parameters: 1
	Flags: Linked
*/
function function_b7fa03cd(bgb)
{
	if(!isdefined(bgb))
	{
		return 0;
	}
	if(!isdefined(self.var_ed782493[bgb]))
	{
		return 1;
	}
	var_cb4d0349 = self.var_ed782493[bgb].var_c2a984f0;
	var_3f9a9f3d = self.var_ed782493[bgb].var_a286cbfb;
	var_74f79f80 = var_cb4d0349 - var_3f9a9f3d;
	if(isdefined(level.var_4af38aa3) && level.var_4af38aa3)
	{
		return 1;
	}
	return 0 < var_74f79f80;
}

/*
	Name: function_b331a28c
	Namespace: bgb
	Checksum: 0x2406FFE3
	Offset: 0x1C08
	Size: 0xD4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_b331a28c(bgb)
{
	if(!(isdefined(level.bgb[bgb].var_50206ca3) && level.bgb[bgb].var_50206ca3))
	{
		return;
	}
	self val::set(#"bgb_activation", "takedamage", 0);
	s_result = undefined;
	s_result = self waittill_timeout(2, #"bgb_bubble_blow_complete");
	if(isdefined(self))
	{
		self val::reset(#"bgb_activation", "takedamage");
	}
}

/*
	Name: function_1f3eb76f
	Namespace: bgb
	Checksum: 0x94920A6F
	Offset: 0x1CE8
	Size: 0x82
	Parameters: 1
	Flags: Linked, Private
*/
private function function_1f3eb76f(bgb)
{
	if(!(isdefined(level.bgb[bgb].var_f1f46d6b) && level.bgb[bgb].var_f1f46d6b))
	{
		return;
	}
	self.var_e75517b1 = 1;
	self waittill_timeout(2, #"bgb_bubble_blow_complete");
	if(isdefined(self))
	{
		self.var_e75517b1 = 0;
	}
}

/*
	Name: bgb_gumball_anim
	Namespace: bgb
	Checksum: 0xFB0827C7
	Offset: 0x1D78
	Size: 0x2B8
	Parameters: 1
	Flags: Linked
*/
function bgb_gumball_anim(bgb)
{
	self endon(#"disconnect");
	level endon(#"end_game");
	if(self isinmovemode("ufo", "noclip"))
	{
		return 0;
	}
	if(self laststand::player_is_in_laststand())
	{
		return 0;
	}
	weapon = bgb_get_gumball_anim_weapon(bgb);
	if(!isdefined(weapon))
	{
		return 0;
	}
	while(self isswitchingweapons() || self isusingoffhand() || self isthrowinggrenade() || self ismeleeing() || self function_61efcfe5() || self function_f071483d())
	{
		waitframe(1);
	}
	while(isdefined(self.var_1d940ef6) && self.var_1d940ef6)
	{
		waitframe(1);
	}
	while(self getcurrentweapon() == level.weaponnone)
	{
		waitframe(1);
	}
	weapon_options = self calcweaponoptions(level.bgb[bgb].camo_index, 0, 0);
	self thread gestures::function_f3e2696f(bgb, weapon, weapon_options, 2.5, &function_16670e75, &function_3b2a02d8, &function_62f40b0d);
	while(self isswitchingweapons())
	{
		waitframe(1);
	}
	evt = undefined;
	evt = self waittill_timeout(3, #"hash_593f920e9efd2ecd", #"bgb_gumball_anim_give");
	if(isdefined(evt) && evt.bgb === bgb)
	{
		if(evt._notify == #"bgb_gumball_anim_give")
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_a6c704c
	Namespace: bgb
	Checksum: 0xF4696C04
	Offset: 0x2038
	Size: 0x15C
	Parameters: 1
	Flags: Linked
*/
function function_a6c704c(bgb)
{
	self endon(#"disconnect");
	level endon(#"end_game");
	self thread function_b331a28c(bgb);
	self thread function_1f3eb76f(bgb);
	util::delay(#"hash_7b6a55a9b65e3194", "death", &zm_audio::create_and_play_dialog, #"elixir", #"drink");
	if(isdefined(level.bgb[bgb].var_4a9b0cdc) && level.bgb[bgb].var_4a9b0cdc || self function_e98aa964(1))
	{
		self notify(#"hash_27b238d082f65849", bgb);
		self function_d841e500();
		self thread function_b7ba7d51(bgb);
		return 1;
	}
	return 0;
}

/*
	Name: function_b7ba7d51
	Namespace: bgb
	Checksum: 0xC7ADC818
	Offset: 0x21A0
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function function_b7ba7d51(bgb)
{
	self endon(#"disconnect");
	self set_active(1);
	self do_one_shot_use();
	self notify(#"bgb_bubble_blow_complete");
	self [[level.bgb[bgb].activation_func]]();
	self set_active(0);
	self activation_complete();
}

/*
	Name: bgb_get_gumball_anim_weapon
	Namespace: bgb
	Checksum: 0x4B23B282
	Offset: 0x2260
	Size: 0x7C
	Parameters: 1
	Flags: Linked, Private
*/
private function bgb_get_gumball_anim_weapon(bgb)
{
	var_ab8d8da3 = undefined;
	if(isdefined(level.bgb[bgb]))
	{
		var_c16a4a5b = level.bgb[bgb].rarity;
		if(isdefined(level.var_ddff6359) && isdefined(var_c16a4a5b))
		{
			var_ab8d8da3 = level.var_ddff6359[var_c16a4a5b];
		}
	}
	return var_ab8d8da3;
}

/*
	Name: function_16670e75
	Namespace: bgb
	Checksum: 0x5DBD0001
	Offset: 0x22E8
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_16670e75(bgb)
{
	if(!isdefined(self))
	{
		return;
	}
	if(self laststand::player_is_in_laststand())
	{
		return;
	}
	self thread function_b331a28c(bgb);
	self thread function_1f3eb76f(bgb);
}

/*
	Name: function_3b2a02d8
	Namespace: bgb
	Checksum: 0xC837FFA8
	Offset: 0x2350
	Size: 0x2EC
	Parameters: 1
	Flags: Linked
*/
function function_3b2a02d8(bgb)
{
	if(!isdefined(self))
	{
		return;
	}
	if(self laststand::player_is_in_laststand())
	{
		return;
	}
	self notify(#"bgb_gumball_anim_give", {#bgb:bgb});
	self thread give(bgb);
	zm_audio::create_and_play_dialog(#"elixir", #"drink");
	self zm_stats::increment_client_stat("bgbs_chewed");
	self zm_stats::increment_player_stat("bgbs_chewed");
	self zm_stats::increment_challenge_stat(#"gum_gobbler_consume");
	self zm_stats::function_8f10788e("boas_bgbs_chewed");
	self zm_stats::function_c0c6ab19(#"hash_67f429ee3f93764d");
	if(level.bgb[bgb].rarity > 0)
	{
		self zm_stats::increment_challenge_stat(#"hash_41d41d501c70fb30");
	}
	self stats::inc_stat(#"hash_2cc30e2023be89c8", bgb, #"used", #"statvalue", 1);
	health = 0;
	if(isdefined(self.health))
	{
		health = self.health;
	}
	if(isdefined(level.bgb[bgb].consumable) && level.bgb[bgb].consumable)
	{
		self luinotifyevent(#"zombie_bgb_used", 1, level.bgb[bgb].item_index);
	}
	self recordmapevent(4, gettime(), self.origin, level.round_number, level.bgb[bgb].stat_index, health);
	demo::bookmark(#"zm_player_bgb_grab", gettime(), self);
	potm::bookmark(#"zm_player_bgb_grab", gettime(), self);
}

/*
	Name: function_62f40b0d
	Namespace: bgb
	Checksum: 0x6FAA34CD
	Offset: 0x2648
	Size: 0x46
	Parameters: 2
	Flags: Linked
*/
function function_62f40b0d(bgb, var_f3b15ce0)
{
	if(!isdefined(self))
	{
		return;
	}
	self notify(#"hash_593f920e9efd2ecd", {#bgb:bgb});
}

/*
	Name: function_73b4660b
	Namespace: bgb
	Checksum: 0x269C49F4
	Offset: 0x2698
	Size: 0x7C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_73b4660b()
{
	self notify(#"bgb_limit_monitor");
	self notify(#"bgb_activation_monitor");
	self clientfield::set_player_uimodel("zmhud.bgb_display", 0);
	self clientfield::set_player_uimodel("zmhud.bgb_activations_remaining", 0);
	self clear_timer();
}

/*
	Name: bgb_limit_monitor
	Namespace: bgb
	Checksum: 0x9B6CD048
	Offset: 0x2720
	Size: 0x5DC
	Parameters: 0
	Flags: Linked, Private
*/
private function bgb_limit_monitor()
{
	self notify(#"bgb_limit_monitor");
	self endon(#"bgb_limit_monitor", #"death", #"bgb_update");
	self clientfield::set_player_uimodel("zmhud.bgb_display", 1);
	self playsoundtoplayer(#"hash_56cc165edb993de8", self);
	switch(level.bgb[self.bgb].limit_type)
	{
		case "activated":
		{
			for(i = level.bgb[self.bgb].limit; i > 0; i--)
			{
				if(i != level.bgb[self.bgb].limit)
				{
					self playsoundtoplayer(#"hash_7bb31f4a25cf34a", self);
				}
				level.bgb[self.bgb].var_dbe7d224 = i;
				if(level.bgb[self.bgb].var_57eb02e)
				{
					function_f0d592c9();
				}
				else
				{
					self set_timer(i, level.bgb[self.bgb].limit);
				}
				self clientfield::set_player_uimodel("zmhud.bgb_activations_remaining", i);
				/#
					self thread bgb_set_debug_text(self.bgb, i);
				#/
				self waittill(#"bgb_activation");
				while(isdefined(self function_ff7c0158()) && self function_ff7c0158())
				{
					waitframe(1);
				}
			}
			if(isdefined(self.bgb) && isdefined(level.bgb[self.bgb]))
			{
				level.bgb[self.bgb].var_dbe7d224 = 0;
			}
			self playsoundtoplayer(#"hash_b8e60131176554b", self);
			if(isdefined(self.bgb) && isdefined(level.bgb[self.bgb]))
			{
				self set_timer(0, level.bgb[self.bgb].limit);
			}
			while(isdefined(self.var_109ff1) && self.var_109ff1)
			{
				waitframe(1);
			}
			break;
		}
		case "time":
		{
			/#
				self thread bgb_set_debug_text(self.bgb);
			#/
			self thread run_timer(level.bgb[self.bgb].limit);
			self waittill(#"hash_347d2afccb8337ab");
			self playsoundtoplayer(#"hash_b8e60131176554b", self);
			break;
		}
		case "rounds":
		{
			/#
				self thread bgb_set_debug_text(self.bgb);
			#/
			count = level.bgb[self.bgb].limit + 1;
			for(i = 0; i < count; i++)
			{
				if(i != 0)
				{
					self playsoundtoplayer(#"hash_7bb31f4a25cf34a", self);
				}
				self set_timer(count - i, count);
				level waittill(#"end_of_round");
			}
			self playsoundtoplayer(#"hash_b8e60131176554b", self);
			break;
		}
		case "event":
		{
			/#
				self thread bgb_set_debug_text(self.bgb);
			#/
			self function_ea2d1b42(1);
			self [[level.bgb[self.bgb].limit]]();
			self playsoundtoplayer(#"hash_b8e60131176554b", self);
			break;
		}
		default:
		{
			/#
				assert(0, "" + self.bgb + "" + level.bgb[self.bgb].limit_type + "");
			#/
		}
	}
	self thread take();
}

/*
	Name: function_ba5472fa
	Namespace: bgb
	Checksum: 0xC453740B
	Offset: 0x2D08
	Size: 0x94
	Parameters: 0
	Flags: Linked, Private
*/
private function function_ba5472fa()
{
	self endon(#"disconnect", #"bgb_update");
	self notify(#"hash_7dc11f5ae3919958");
	self endon(#"hash_7dc11f5ae3919958");
	self waittill(#"bled_out");
	self notify(#"bgb_about_to_take_on_bled_out");
	wait(0.1);
	self thread take();
}

/*
	Name: bgb_activation_monitor
	Namespace: bgb
	Checksum: 0xFC449AD8
	Offset: 0x2DA8
	Size: 0xD2
	Parameters: 0
	Flags: Private
*/
private function bgb_activation_monitor()
{
	self endon(#"disconnect");
	self notify(#"bgb_activation_monitor");
	self endon(#"bgb_activation_monitor");
	if("activated" != level.bgb[self.bgb].limit_type)
	{
		return;
	}
	for(;;)
	{
		self waittill(#"bgb_activation_request");
		waitframe(1);
		if(!self function_e98aa964(0))
		{
			continue;
		}
		if(self function_a6c704c(self.bgb))
		{
			self notify(#"bgb_activation", self.bgb);
		}
	}
}

/*
	Name: function_e98aa964
	Namespace: bgb
	Checksum: 0xEEB79A51
	Offset: 0x2E88
	Size: 0x18C
	Parameters: 2
	Flags: Linked
*/
function function_e98aa964(var_3e37f503 = 0, var_8593b089 = self.bgb)
{
	var_ceb582a8 = isdefined(level.bgb[var_8593b089].validation_func) && !self [[level.bgb[var_8593b089].validation_func]]();
	var_e6b14ccc = isdefined(level.var_67713b46) && !self [[level.var_67713b46]]();
	if(!var_3e37f503 && (isdefined(self.is_drinking) && self.is_drinking) || (isdefined(self.var_109ff1) && self.var_109ff1 && (!(isdefined(self.var_ec8a9710) && self.var_ec8a9710))) || self laststand::player_is_in_laststand() || var_ceb582a8 || var_e6b14ccc || (isdefined(self.var_16735873) && self.var_16735873) || (isdefined(self.var_30cbff55) && self.var_30cbff55))
	{
		self clientfield::increment_uimodel("zmhud.bgb_invalid_use");
		return 0;
	}
	return 1;
}

/*
	Name: function_1fdcef80
	Namespace: bgb
	Checksum: 0xE0F85258
	Offset: 0x3020
	Size: 0xBC
	Parameters: 1
	Flags: Private
*/
private function function_1fdcef80(bgb)
{
	self endon(#"disconnect", #"bled_out", #"bgb_update");
	if(isdefined(level.bgb[bgb].var_5a047886) && level.bgb[bgb].var_5a047886)
	{
		function_9c8e12d1(6);
	}
	else
	{
		return;
	}
	self waittill(#"bgb_activation_request");
	self thread take();
}

/*
	Name: function_9c8e12d1
	Namespace: bgb
	Checksum: 0x4CD2CDEC
	Offset: 0x30E8
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_9c8e12d1(n_value)
{
	self setactionslot(1, "bgb");
	self clientfield::set_player_uimodel("zmhud.bgb_activations_remaining", n_value);
}

/*
	Name: function_f37655df
	Namespace: bgb
	Checksum: 0x1D8A74A7
	Offset: 0x3140
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function function_f37655df(n_value)
{
	self clientfield::set_player_uimodel("zmhud.bgb_activations_remaining", 0);
}

/*
	Name: function_57eb02e
	Namespace: bgb
	Checksum: 0xBFD207DE
	Offset: 0x3178
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function function_57eb02e(name)
{
	level.bgb[name].var_57eb02e = 1;
}

/*
	Name: do_one_shot_use
	Namespace: bgb
	Checksum: 0x330E3006
	Offset: 0x31B0
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function do_one_shot_use(skip_demo_bookmark = 0)
{
	self clientfield::increment_uimodel("zmhud.bgb_one_shot_use");
	if(!skip_demo_bookmark)
	{
		demo::bookmark(#"zm_player_bgb_activate", gettime(), self);
		potm::bookmark(#"zm_player_bgb_activate", gettime(), self);
	}
}

/*
	Name: function_d841e500
	Namespace: bgb
	Checksum: 0x5E4FBA5E
	Offset: 0x3248
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function function_d841e500()
{
	self.var_109ff1 = 1;
}

/*
	Name: activation_complete
	Namespace: bgb
	Checksum: 0x96C71F57
	Offset: 0x3268
	Size: 0x1E
	Parameters: 0
	Flags: Linked, Private
*/
private function activation_complete()
{
	self.var_109ff1 = 0;
	self notify(#"activation_complete");
}

/*
	Name: set_active
	Namespace: bgb
	Checksum: 0x81675E92
	Offset: 0x3290
	Size: 0x1A
	Parameters: 1
	Flags: Linked, Private
*/
private function set_active(var_3c4b2051)
{
	self.var_2c195483 = var_3c4b2051;
}

/*
	Name: function_ff7c0158
	Namespace: bgb
	Checksum: 0x4470DB23
	Offset: 0x32B8
	Size: 0x18
	Parameters: 0
	Flags: Linked
*/
function function_ff7c0158()
{
	return isdefined(self.var_2c195483) && self.var_2c195483;
}

/*
	Name: is_active
	Namespace: bgb
	Checksum: 0x7D26294C
	Offset: 0x32D8
	Size: 0x42
	Parameters: 1
	Flags: Linked
*/
function is_active(name)
{
	if(!isdefined(self.bgb))
	{
		return 0;
	}
	return self.bgb == name && (isdefined(self.var_2c195483) && self.var_2c195483);
}

/*
	Name: is_team_active
	Namespace: bgb
	Checksum: 0xABAFFA6E
	Offset: 0x3328
	Size: 0x92
	Parameters: 1
	Flags: None
*/
function is_team_active(name)
{
	foreach(player in level.players)
	{
		if(player is_active(name))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_9b5990dd
	Namespace: bgb
	Checksum: 0xB849ADB8
	Offset: 0x33C8
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_9b5990dd(name)
{
	if(!isdefined(level.bgb[name]))
	{
		return 0;
	}
	var_d1efe11 = level.bgb[name].ref_count;
	level.bgb[name].ref_count++;
	return var_d1efe11;
}

/*
	Name: function_b95235f7
	Namespace: bgb
	Checksum: 0xE6D71343
	Offset: 0x3438
	Size: 0x56
	Parameters: 1
	Flags: Linked
*/
function function_b95235f7(name)
{
	if(!isdefined(level.bgb[name]))
	{
		return 0;
	}
	level.bgb[name].ref_count--;
	return level.bgb[name].ref_count;
}

/*
	Name: calc_remaining_duration_lerp
	Namespace: bgb
	Checksum: 0xC4734EE4
	Offset: 0x3498
	Size: 0x92
	Parameters: 2
	Flags: Linked, Private
*/
private function calc_remaining_duration_lerp(start_time, end_time)
{
	if(0 >= end_time - start_time)
	{
		return 0;
	}
	now = gettime();
	frac = float(end_time - now) / float(end_time - start_time);
	return math::clamp(frac, 0, 1);
}

/*
	Name: function_af43111c
	Namespace: bgb
	Checksum: 0x7F524CEC
	Offset: 0x3538
	Size: 0x122
	Parameters: 3
	Flags: Linked, Private
*/
private function function_af43111c(var_f205d85d, percent, var_5f12e334 = 0)
{
	self endon(#"disconnect", #"hash_6ae783a3051b411b");
	if(var_5f12e334)
	{
		self.var_4b0fb2fb = 1;
	}
	start_time = gettime();
	end_time = start_time + 1000;
	var_2cd46f25 = var_f205d85d;
	while(var_2cd46f25 > percent)
	{
		var_2cd46f25 = lerpfloat(percent, var_f205d85d, calc_remaining_duration_lerp(start_time, end_time));
		self clientfield::set_player_uimodel("zmhud.bgb_timer", var_2cd46f25);
		waitframe(1);
	}
	if(var_5f12e334)
	{
		self.var_76c47001 = var_2cd46f25;
		self.var_4b0fb2fb = undefined;
	}
}

/*
	Name: function_ea2d1b42
	Namespace: bgb
	Checksum: 0x2696C7A1
	Offset: 0x3668
	Size: 0xC4
	Parameters: 2
	Flags: Linked, Private
*/
private function function_ea2d1b42(percent, var_5f12e334 = 0)
{
	self notify(#"hash_6ae783a3051b411b");
	var_f205d85d = self clientfield::get_player_uimodel("zmhud.bgb_timer");
	if(percent < var_f205d85d && 0.1 <= var_f205d85d - percent)
	{
		self thread function_af43111c(var_f205d85d, percent, var_5f12e334);
	}
	else
	{
		self clientfield::set_player_uimodel("zmhud.bgb_timer", percent);
	}
}

/*
	Name: function_f0d592c9
	Namespace: bgb
	Checksum: 0x84385A9C
	Offset: 0x3738
	Size: 0x1C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_f0d592c9()
{
	self function_ea2d1b42(1);
}

/*
	Name: set_timer
	Namespace: bgb
	Checksum: 0xAC2B698D
	Offset: 0x3760
	Size: 0x64
	Parameters: 3
	Flags: Linked
*/
function set_timer(current, max, var_5f12e334 = 0)
{
	if(!(isdefined(self.var_4b0fb2fb) && self.var_4b0fb2fb))
	{
		self function_ea2d1b42(current / max, var_5f12e334);
	}
}

/*
	Name: run_timer
	Namespace: bgb
	Checksum: 0xA05E7EF8
	Offset: 0x37D0
	Size: 0x146
	Parameters: 1
	Flags: Linked
*/
function run_timer(max)
{
	self endon(#"disconnect");
	self notify(#"hash_35f9c692474b1b10");
	self endon(#"hash_35f9c692474b1b10");
	current = max;
	self.var_ec8a9710 = 1;
	while(current > 0)
	{
		self set_timer(current, max);
		waitframe(1);
		if(isdefined(self.var_76c47001))
		{
			current = max * self.var_76c47001;
			self.var_76c47001 = undefined;
		}
		else if(!(isdefined(self.var_4b0fb2fb) && self.var_4b0fb2fb))
		{
			current = current - float(function_60d95f53()) / 1000;
		}
	}
	self notify(#"hash_347d2afccb8337ab");
	self clear_timer();
	self.var_ec8a9710 = undefined;
}

/*
	Name: clear_timer
	Namespace: bgb
	Checksum: 0x7569B22E
	Offset: 0x3920
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function clear_timer()
{
	self function_ea2d1b42(0);
	self notify(#"hash_35f9c692474b1b10");
}

/*
	Name: register
	Namespace: bgb
	Checksum: 0x9A63E2F5
	Offset: 0x3958
	Size: 0x54E
	Parameters: 7
	Flags: Linked
*/
function register(name, limit_type, limit, enable_func, disable_func, validation_func, activation_func)
{
	/#
		assert(isdefined(name), "");
	#/
	/#
		assert(#"none" != name, "" + #"none" + "");
	#/
	/#
		assert(!isdefined(level.bgb[name]), "" + name + "");
	#/
	/#
		assert(isdefined(limit_type), "" + name + "");
	#/
	/#
		assert(isdefined(limit), "" + name + "");
	#/
	/#
		assert(!isdefined(enable_func) || isfunctionptr(enable_func), "" + name + "");
	#/
	/#
		assert(!isdefined(disable_func) || isfunctionptr(disable_func), "" + name + "");
	#/
	switch(limit_type)
	{
		case "activated":
		{
			/#
				assert(!isdefined(validation_func) || isfunctionptr(validation_func), "" + name + "" + limit_type + "");
			#/
			/#
				assert(isdefined(activation_func), "" + name + "" + limit_type + "");
			#/
			/#
				assert(isfunctionptr(activation_func), "" + name + "" + limit_type + "");
			#/
		}
		case "time":
		case "rounds":
		{
			/#
				assert(isint(limit), "" + name + "" + limit + "" + limit_type + "");
			#/
			break;
		}
		case "event":
		{
			/#
				assert(isfunctionptr(limit), "" + name + "" + limit_type + "");
			#/
			break;
		}
		default:
		{
			/#
				assert(0, "" + name + "" + limit_type + "");
			#/
		}
	}
	level.bgb[name] = spawnstruct();
	level.bgb[name].name = name;
	level.bgb[name].limit_type = limit_type;
	level.bgb[name].limit = limit;
	level.bgb[name].enable_func = enable_func;
	level.bgb[name].disable_func = disable_func;
	level.bgb[name].validation_func = validation_func;
	if("activated" == limit_type)
	{
		level.bgb[name].activation_func = activation_func;
		level.bgb[name].var_57eb02e = 0;
	}
	level.bgb[name].ref_count = 0;
}

/*
	Name: function_430970f6
	Namespace: bgb
	Checksum: 0x34B09894
	Offset: 0x3EB0
	Size: 0x72
	Parameters: 2
	Flags: Linked
*/
function function_430970f6(name, var_ebb91cb6)
{
	/#
		assert(isdefined(level.bgb[name]), "" + name + "");
	#/
	level.bgb[name].var_ebb91cb6 = var_ebb91cb6;
}

/*
	Name: function_cc303f91
	Namespace: bgb
	Checksum: 0xC00E77FC
	Offset: 0x3F30
	Size: 0x72
	Parameters: 2
	Flags: Linked
*/
function function_cc303f91(name, var_49cdead9)
{
	/#
		assert(isdefined(level.bgb[name]), "" + name + "");
	#/
	level.bgb[name].var_49cdead9 = var_49cdead9;
}

/*
	Name: function_95296005
	Namespace: bgb
	Checksum: 0x49AACFD
	Offset: 0x3FB0
	Size: 0x72
	Parameters: 2
	Flags: Linked
*/
function function_95296005(name, var_52fd36a5)
{
	/#
		assert(isdefined(level.bgb[name]), "" + name + "");
	#/
	level.bgb[name].var_52fd36a5 = var_52fd36a5;
}

/*
	Name: register_lost_perk_override
	Namespace: bgb
	Checksum: 0xC912AB30
	Offset: 0x4030
	Size: 0x96
	Parameters: 3
	Flags: Linked
*/
function register_lost_perk_override(name, lost_perk_override_func, lost_perk_override_func_always_run)
{
	/#
		assert(isdefined(level.bgb[name]), "" + name + "");
	#/
	level.bgb[name].lost_perk_override_func = lost_perk_override_func;
	level.bgb[name].lost_perk_override_func_always_run = lost_perk_override_func_always_run;
}

/*
	Name: function_c2721e81
	Namespace: bgb
	Checksum: 0x20357908
	Offset: 0x40D0
	Size: 0x96
	Parameters: 3
	Flags: Linked
*/
function function_c2721e81(name, var_279de8cd, var_52314e8c)
{
	/#
		assert(isdefined(level.bgb[name]), "" + name + "");
	#/
	level.bgb[name].var_279de8cd = var_279de8cd;
	level.bgb[name].var_52314e8c = var_52314e8c;
}

/*
	Name: function_72469efe
	Namespace: bgb
	Checksum: 0xE908A2F1
	Offset: 0x4170
	Size: 0x72
	Parameters: 2
	Flags: Linked
*/
function function_72469efe(name, var_50206ca3)
{
	/#
		assert(isdefined(level.bgb[name]), "" + name + "");
	#/
	level.bgb[name].var_50206ca3 = var_50206ca3;
}

/*
	Name: function_8a5d8cfb
	Namespace: bgb
	Checksum: 0x120462C4
	Offset: 0x41F0
	Size: 0x72
	Parameters: 2
	Flags: Linked
*/
function function_8a5d8cfb(name, var_f1f46d6b)
{
	/#
		assert(isdefined(level.bgb[name]), "" + name + "");
	#/
	level.bgb[name].var_f1f46d6b = var_f1f46d6b;
}

/*
	Name: function_be42abb0
	Namespace: bgb
	Checksum: 0x9FFE911C
	Offset: 0x4270
	Size: 0x72
	Parameters: 2
	Flags: None
*/
function function_be42abb0(name, var_f8d9ac8c)
{
	/#
		assert(isdefined(level.bgb[name]), "" + name + "");
	#/
	level.bgb[name].var_f8d9ac8c = var_f8d9ac8c;
}

/*
	Name: function_afe7b8e7
	Namespace: bgb
	Checksum: 0xC33DA3BA
	Offset: 0x42F0
	Size: 0x6A
	Parameters: 1
	Flags: None
*/
function function_afe7b8e7(name)
{
	/#
		assert(isdefined(level.bgb[name]), "" + name + "");
	#/
	level.bgb[name].var_5a047886 = 1;
}

/*
	Name: function_e1f37ce7
	Namespace: bgb
	Checksum: 0x6A2EEEE8
	Offset: 0x4368
	Size: 0x6A
	Parameters: 1
	Flags: Linked
*/
function function_e1f37ce7(name)
{
	/#
		assert(isdefined(level.bgb[name]), "" + name + "");
	#/
	level.bgb[name].var_4a9b0cdc = 1;
}

/*
	Name: function_1fee6b3
	Namespace: bgb
	Checksum: 0x1CC868DF
	Offset: 0x43E0
	Size: 0xA2
	Parameters: 2
	Flags: Linked
*/
function function_1fee6b3(name, n_rank)
{
	/#
		assert(isdefined(level.bgb[name]), "" + name + "");
	#/
	/#
		assert(isdefined(n_rank), "" + name + "");
	#/
	level.bgb[name].var_a1750d43 = n_rank;
}

/*
	Name: give
	Namespace: bgb
	Checksum: 0x827387C5
	Offset: 0x4490
	Size: 0x224
	Parameters: 1
	Flags: Linked
*/
function give(name)
{
	self thread take();
	if(#"none" == name)
	{
		return;
	}
	/#
		assert(isdefined(level.bgb[name]), "" + name + "");
	#/
	self notify(#"bgb_update", {#hash_826ddd38:self.bgb, #hash_3aee8e4:name});
	self notify("bgb_update_give_" + name);
	self.bgb = name;
	self clientfield::set_player_uimodel("zmhud.bgb_current", level.bgb[name].item_index);
	self luinotifyevent(#"zombie_bgb_notification", 1, level.bgb[name].item_index);
	self luinotifyeventtospectators(#"zombie_bgb_notification", 1, level.bgb[name].item_index);
	if(isdefined(level.bgb[name].enable_func))
	{
		self thread [[level.bgb[name].enable_func]]();
	}
	if(isdefined("activated" == level.bgb[name].limit_type))
	{
		self setactionslot(1, "bgb");
	}
	self thread bgb_limit_monitor();
	self thread function_ba5472fa();
}

/*
	Name: take
	Namespace: bgb
	Checksum: 0xD2412ECD
	Offset: 0x46C0
	Size: 0x132
	Parameters: 0
	Flags: Linked
*/
function take()
{
	if(#"none" == self.bgb)
	{
		return;
	}
	self setactionslot(1, "");
	/#
		self thread bgb_set_debug_text(#"none");
	#/
	if(isdefined(level.bgb[self.bgb].disable_func))
	{
		self thread [[level.bgb[self.bgb].disable_func]]();
	}
	self function_73b4660b();
	self notify(#"bgb_update", {#hash_826ddd38:self.bgb, #hash_3aee8e4:#"none"});
	self notify("bgb_update_take_" + self.bgb);
	self.bgb = #"none";
}

/*
	Name: get_enabled
	Namespace: bgb
	Checksum: 0xE26DA328
	Offset: 0x4800
	Size: 0x4A
	Parameters: 0
	Flags: Linked
*/
function get_enabled()
{
	if(isplayer(self) && isdefined(self.bgb))
	{
		return self.bgb;
	}
	return #"none";
}

/*
	Name: is_enabled
	Namespace: bgb
	Checksum: 0x4F686D15
	Offset: 0x4858
	Size: 0x58
	Parameters: 1
	Flags: Linked
*/
function is_enabled(name)
{
	/#
		assert(isdefined(self.bgb));
	#/
	if(!isdefined(self) || !isdefined(self.bgb))
	{
		return 0;
	}
	return self.bgb === name;
}

/*
	Name: function_c40d1b32
	Namespace: bgb
	Checksum: 0x5B044E23
	Offset: 0x48B8
	Size: 0x3C
	Parameters: 0
	Flags: None
*/
function function_c40d1b32()
{
	/#
		assert(isdefined(self.bgb));
	#/
	return self.bgb !== #"none";
}

/*
	Name: is_team_enabled
	Namespace: bgb
	Checksum: 0x5DC8C478
	Offset: 0x4900
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function is_team_enabled(bgb_name)
{
	foreach(player in util::get_players())
	{
		/#
			assert(isdefined(player.bgb));
		#/
		if(player.bgb === bgb_name)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_2bbfb816
	Namespace: bgb
	Checksum: 0x29FD684E
	Offset: 0x49C0
	Size: 0x88
	Parameters: 0
	Flags: Linked
*/
function function_2bbfb816()
{
	var_aa2142ad = self.origin + vectorscale(anglestoforward((0, self getplayerangles()[1], 0)), 60) + vectorscale((0, 0, 1), 5);
	self zm_stats::increment_challenge_stat(#"gum_gobbler_powerups");
	return var_aa2142ad;
}

/*
	Name: function_c6cd71d5
	Namespace: bgb
	Checksum: 0xA3BCF930
	Offset: 0x4A50
	Size: 0xBC
	Parameters: 3
	Flags: Linked
*/
function function_c6cd71d5(str_powerup, v_origin = self function_2bbfb816(), var_22a4c702)
{
	var_7d81025 = zm_powerups::specific_powerup_drop(str_powerup, v_origin, undefined, 0.1, undefined, undefined, 1, 1, 1, 1);
	var_7d81025.var_2b5ec373 = self;
	if(isplayer(self))
	{
		self zm_stats::increment_challenge_stat(#"hash_3ebae93ea866519c");
	}
}

/*
	Name: function_9d8118f5
	Namespace: bgb
	Checksum: 0xD250FD05
	Offset: 0x4B18
	Size: 0x260
	Parameters: 1
	Flags: Linked
*/
function function_9d8118f5(v_origin)
{
	if(!self isonground() && !self isplayerswimming())
	{
		return 0;
	}
	if(!isdefined(v_origin))
	{
		v_origin = self function_2bbfb816();
	}
	var_116b3a00 = 1;
	var_806b07bd = util::spawn_model("tag_origin", v_origin + (0, 0, 40));
	v_origin = var_806b07bd.origin;
	if(isdefined(var_806b07bd) && (!var_806b07bd zm_player::in_enabled_playable_area(96) && !var_806b07bd zm_player::in_life_brush()))
	{
		var_116b3a00 = 0;
	}
	if(self zm_utility::function_ab9a9770() || var_806b07bd zm_utility::function_ab9a9770())
	{
		var_116b3a00 = 0;
	}
	v_close = getclosestpointonnavmesh(v_origin, 128, 24);
	if(var_116b3a00 && (!isdefined(v_close) || v_close[2] - v_origin[2] > 40 / 4) && !self isplayerswimming())
	{
		var_116b3a00 = 0;
	}
	if(var_116b3a00 && (!(isdefined(bullettracepassed(self geteye(), v_origin, 0, self, undefined, 0, 1)) && bullettracepassed(self geteye(), v_origin, 0, self, undefined, 0, 1))))
	{
		var_116b3a00 = 0;
	}
	if(isdefined(var_806b07bd))
	{
		var_806b07bd delete();
	}
	return var_116b3a00;
}

/*
	Name: actor_damage_override
	Namespace: bgb
	Checksum: 0x274D0E88
	Offset: 0x4D80
	Size: 0x13E
	Parameters: 12
	Flags: Linked
*/
function actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(isplayer(attacker))
	{
		name = attacker get_enabled();
		if(name !== #"none" && isdefined(level.bgb[name]) && isdefined(level.bgb[name].var_ebb91cb6))
		{
			damage = [[level.bgb[name].var_ebb91cb6]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
		}
	}
	return damage;
}

/*
	Name: vehicle_damage_override
	Namespace: bgb
	Checksum: 0xA05E1C2D
	Offset: 0x4EC8
	Size: 0x182
	Parameters: 15
	Flags: Linked
*/
function vehicle_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal)
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return idamage;
	}
	if(isplayer(eattacker))
	{
		name = eattacker get_enabled();
		if(name !== #"none" && isdefined(level.bgb[name]) && isdefined(level.bgb[name].var_49cdead9))
		{
			idamage = [[level.bgb[name].var_49cdead9]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
		}
	}
	return idamage;
}

/*
	Name: actor_death_override
	Namespace: bgb
	Checksum: 0x8C7BEEA8
	Offset: 0x5058
	Size: 0xE2
	Parameters: 1
	Flags: Linked
*/
function actor_death_override(attacker)
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return 0;
	}
	if(isplayer(attacker))
	{
		name = attacker get_enabled();
		if(name !== #"none" && isdefined(level.bgb[name]) && isdefined(level.bgb[name].var_52fd36a5))
		{
			damage = [[level.bgb[name].var_52fd36a5]](attacker);
		}
	}
	return damage;
}

/*
	Name: lost_perk_override
	Namespace: bgb
	Checksum: 0x1AC5315B
	Offset: 0x5148
	Size: 0x234
	Parameters: 1
	Flags: Linked
*/
function lost_perk_override(perk)
{
	b_result = 0;
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return b_result;
	}
	keys = getarraykeys(level.bgb);
	for(i = 0; i < keys.size; i++)
	{
		name = keys[i];
		if(isdefined(level.bgb[name].lost_perk_override_func_always_run) && level.bgb[name].lost_perk_override_func_always_run && isdefined(level.bgb[name].lost_perk_override_func))
		{
			b_result = [[level.bgb[name].lost_perk_override_func]](perk, self, undefined);
			if(b_result)
			{
				return b_result;
			}
		}
	}
	foreach(player in level.activeplayers)
	{
		name = player get_enabled();
		if(name !== #"none" && isdefined(level.bgb[name]) && isdefined(level.bgb[name].lost_perk_override_func))
		{
			b_result = [[level.bgb[name].lost_perk_override_func]](perk, self, player);
			if(b_result)
			{
				return b_result;
			}
		}
	}
	return b_result;
}

/*
	Name: add_to_player_score_override
	Namespace: bgb
	Checksum: 0xD8422194
	Offset: 0x5388
	Size: 0x1C6
	Parameters: 2
	Flags: Linked
*/
function add_to_player_score_override(n_points, str_awarded_by)
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return n_points;
	}
	var_8569536c = self get_enabled();
	keys = getarraykeys(level.bgb);
	for(i = 0; i < keys.size; i++)
	{
		var_4c47dfdb = keys[i];
		if(var_4c47dfdb === var_8569536c)
		{
			continue;
		}
		if(isdefined(level.bgb[var_4c47dfdb].var_52314e8c) && level.bgb[var_4c47dfdb].var_52314e8c && isdefined(level.bgb[var_4c47dfdb].var_279de8cd))
		{
			n_points = [[level.bgb[var_4c47dfdb].var_279de8cd]](n_points, str_awarded_by, 0);
		}
	}
	if(var_8569536c !== #"none" && isdefined(level.bgb[var_8569536c]) && isdefined(level.bgb[var_8569536c].var_279de8cd))
	{
		n_points = [[level.bgb[var_8569536c].var_279de8cd]](n_points, str_awarded_by, 1);
	}
	return n_points;
}

/*
	Name: function_3fa57f3f
	Namespace: bgb
	Checksum: 0xBDD710B7
	Offset: 0x5558
	Size: 0xBE
	Parameters: 0
	Flags: None
*/
function function_3fa57f3f()
{
	keys = array::randomize(getarraykeys(level.bgb));
	for(i = 0; i < keys.size; i++)
	{
		if(level.bgb[keys[i]].rarity != 1)
		{
			continue;
		}
		if(level.bgb[keys[i]].var_17f85838 > 0)
		{
			continue;
		}
		return keys[i];
	}
}

/*
	Name: function_f51e3503
	Namespace: bgb
	Checksum: 0x5676B58F
	Offset: 0x5620
	Size: 0x1FA
	Parameters: 3
	Flags: Linked
*/
function function_f51e3503(n_max_distance, var_5250f4f6, var_8bc18989)
{
	self endon(#"disconnect", #"bled_out", #"bgb_update");
	self.var_9c42f3fe = [];
	while(true)
	{
		foreach(e_player in level.players)
		{
			if(e_player == self)
			{
				continue;
			}
			array::remove_undefined(self.var_9c42f3fe);
			var_fd14be26 = array::contains(self.var_9c42f3fe, e_player);
			var_d9cac58e = zm_utility::is_player_valid(e_player, 0, 1) && function_b70b2809(n_max_distance, self, e_player);
			if(!var_fd14be26 && var_d9cac58e)
			{
				array::add(self.var_9c42f3fe, e_player, 0);
				if(isdefined(var_5250f4f6))
				{
					self thread [[var_5250f4f6]](e_player);
				}
				continue;
			}
			if(var_fd14be26 && !var_d9cac58e)
			{
				arrayremovevalue(self.var_9c42f3fe, e_player);
				if(isdefined(var_8bc18989))
				{
					self thread [[var_8bc18989]](e_player);
				}
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_b70b2809
	Namespace: bgb
	Checksum: 0x71D6604
	Offset: 0x5828
	Size: 0x7C
	Parameters: 3
	Flags: Linked, Private
*/
private function function_b70b2809(n_distance, var_7b235bec, var_f8084a8)
{
	var_8c1c6c8d = n_distance * n_distance;
	var_a91ae6d4 = distancesquared(var_7b235bec.origin, var_f8084a8.origin);
	if(var_a91ae6d4 <= var_8c1c6c8d)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_b57e693f
	Namespace: bgb
	Checksum: 0x63A37A12
	Offset: 0x58B0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_b57e693f()
{
	self clientfield::increment_uimodel("zmhud.bgb_invalid_use");
}

/*
	Name: suspend_weapon_cycling
	Namespace: bgb
	Checksum: 0x7CA47AFC
	Offset: 0x58E0
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function suspend_weapon_cycling()
{
	self flag::clear("bgb_weapon_cycling");
}

/*
	Name: resume_weapon_cycling
	Namespace: bgb
	Checksum: 0x1C99F5D0
	Offset: 0x5910
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function resume_weapon_cycling()
{
	self flag::set("bgb_weapon_cycling");
}

/*
	Name: function_3b5f181a
	Namespace: bgb
	Checksum: 0xFED0E172
	Offset: 0x5940
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_3b5f181a()
{
	if(!self flag::exists("bgb_weapon_cycling"))
	{
		self flag::init("bgb_weapon_cycling");
	}
	self flag::set("bgb_weapon_cycling");
}

/*
	Name: function_303bde69
	Namespace: bgb
	Checksum: 0x47877F48
	Offset: 0x59B0
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function function_303bde69()
{
	self flag::wait_till("bgb_weapon_cycling");
}

/*
	Name: function_bd839f2c
	Namespace: bgb
	Checksum: 0x4C324AAC
	Offset: 0x59E0
	Size: 0x13C
	Parameters: 2
	Flags: Linked
*/
function function_bd839f2c(e_reviver, var_84280a99)
{
	if(isdefined(self.var_bdeb0f02) && self.var_bdeb0f02 || (isdefined(e_reviver) && (isdefined(self.bgb) && self is_enabled(#"zm_bgb_near_death_experience"))) || (isdefined(e_reviver) && isdefined(e_reviver.bgb) && e_reviver is_enabled(#"zm_bgb_near_death_experience")) || (isdefined(e_reviver) && (isdefined(self.bgb) && self is_enabled(#"zm_bgb_phoenix_up"))) || (isdefined(e_reviver) && isdefined(e_reviver.bgb) && e_reviver is_enabled(#"zm_bgb_phoenix_up")) || isdefined(var_84280a99))
	{
		return 1;
	}
	return 0;
}

/*
	Name: bgb_revive_watcher
	Namespace: bgb
	Checksum: 0xEA1D3AAA
	Offset: 0x5B28
	Size: 0xAE
	Parameters: 0
	Flags: Linked
*/
function bgb_revive_watcher()
{
	self endon(#"disconnect", #"death");
	self.var_bdeb0f02 = 1;
	waitresult = undefined;
	waitresult = self waittill(#"player_revived");
	e_reviver = waitresult.reviver;
	waitframe(1);
	if(isdefined(self.var_bdeb0f02) && self.var_bdeb0f02)
	{
		self notify(#"bgb_revive");
		self.var_bdeb0f02 = undefined;
	}
}

/*
	Name: function_69b88b5
	Namespace: bgb
	Checksum: 0xAB1AB3E0
	Offset: 0x5BE0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_69b88b5()
{
	if(!(isdefined(self.ready_for_score_events) && self.ready_for_score_events))
	{
		return 0;
	}
	return 1;
}

