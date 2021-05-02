// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_5bb072c3abf4652c;
#using script_6a3f43063dfd1bdc;
#using script_6ce38ab036223e6e;
#using script_b52a163973f339f;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_3263198e;

/*
	Name: init
	Namespace: namespace_3263198e
	Checksum: 0x8CABB19C
	Offset: 0x220
	Size: 0x3C4
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level.var_45b0f2f3 = &function_e43bea18;
	level.var_210f9911 = &function_e162fac3;
	level.var_8c164439 = [];
	level.var_8c164439[#"hash_1242b7914448ebc7"] = #"hash_3708586aed65f7b7";
	level.var_1c53964e = spawn("script_origin", (0, 0, 0));
	level.var_1c53964e.name = "plr_7";
	level.var_1c53964e.isspeaking = 0;
	level.var_1c53964e.var_5b6ebfd0 = 0;
	level.var_60b08c24 = spawn("script_origin", (0, 0, 0));
	level.var_60b08c24.name = "apot";
	level.var_60b08c24.isspeaking = 0;
	level.var_60b08c24.var_5b6ebfd0 = 0;
	level flag::init(#"hash_73e5e9787832fc70");
	level flag::init(#"hash_c38f82bacfe540c");
	level flag::init(#"hash_42f42c8c6a56a111");
	level flag::init(#"hash_6d9b683b3abbb981");
	level.var_8f81a2cc = array(getweapon("ray_gun"), getweapon("ray_gun_upgraded"), getweapon("ray_gun_mk2"), getweapon("ray_gun_mk2_upgraded"), getweapon("tundragun"), getweapon("tundragun_upgraded"), getweapon("thundergun"), getweapon("thundergun_upgraded"), getweapon("ww_tesla_sniper_t8"), getweapon("ww_tesla_sniper_upgraded_t8"));
	level.var_2aeeb358 = array(getweapon("ray_gun"), getweapon("ray_gun_upgraded"), getweapon("ray_gun_mk2"), getweapon("ray_gun_mk2_upgraded"));
	level.var_ee565b3f = &function_8a4b7d4a;
	level.var_bb2323e4 = &function_afbd7223;
	level.custom_magic_box_selection_logic = &custom_magic_box_selection_logic;
	level.var_2f57e2d2 = &function_2f57e2d2;
	callback::on_connect(&on_connect);
}

/*
	Name: function_583cad13
	Namespace: namespace_3263198e
	Checksum: 0x91C7C994
	Offset: 0x5F0
	Size: 0x2D0
	Parameters: 1
	Flags: Linked
*/
function function_583cad13(var_2753f06a)
{
	wait(1);
	var_845efa03 = 0;
	a_players = arraycopy(level.players);
	if(!isdefined(level.host))
	{
		return 0;
	}
	var_5316ea7d = level.host namespace_891c9bac::function_82f9bc9f();
	if(a_players.size == 1)
	{
		e_player = a_players[0];
		if(var_2753f06a == 0)
		{
			str_suffix = #"hash_2f99f466b2830fbd" + var_5316ea7d;
		}
		else
		{
			str_suffix = #"hash_353c8321de1d10b1" + var_2753f06a + "_" + var_5316ea7d;
		}
		var_845efa03 = e_player namespace_891c9bac::function_a2bd5a0c(str_suffix, 0, 1);
		if(var_2753f06a == 0 && var_5316ea7d == "stuh" && (!(isdefined(level.var_3c9cfd6f) && level.var_3c9cfd6f)))
		{
			e_player zm_audio::do_player_or_npc_playvox(#"hash_55a4b3824ac230a1", 1);
		}
	}
	else
	{
		arrayremovevalue(a_players, level.host);
		if(var_2753f06a == 0)
		{
			level.host function_51b752a9(#"hash_4c0be2bb6d0c80b0" + var_5316ea7d);
			var_d1e952c4 = namespace_509a75d1::function_3815943c(a_players);
			if(isdefined(var_d1e952c4))
			{
				var_d1e952c4 function_51b752a9(#"hash_4c0be2bb6d0c80b0" + var_5316ea7d);
			}
		}
		else
		{
			level.host function_51b752a9(#"hash_71bde3a512edb440" + var_2753f06a + "_" + var_5316ea7d);
			var_d1e952c4 = namespace_509a75d1::function_3815943c(a_players);
			if(isdefined(var_d1e952c4))
			{
				var_d1e952c4 function_51b752a9(#"hash_71bde3a512edb440" + var_2753f06a + "_" + var_5316ea7d);
			}
		}
		var_845efa03 = 1;
	}
	return var_845efa03;
}

/*
	Name: function_3e0d878f
	Namespace: namespace_3263198e
	Checksum: 0xD0C6333A
	Offset: 0x8C8
	Size: 0x4E
	Parameters: 0
	Flags: Linked, Private
*/
private function function_3e0d878f()
{
	self endon(#"death");
	level flag::wait_till(#"hash_142bf0da77232815");
	self.var_631a26f0 = level.var_fee8e90b;
}

/*
	Name: function_af205e69
	Namespace: namespace_3263198e
	Checksum: 0x3812066A
	Offset: 0x920
	Size: 0x12A
	Parameters: 1
	Flags: Linked
*/
function function_af205e69(table)
{
	index = 0;
	row = tablelookuprow(table, index);
	while(isdefined(row))
	{
		category = zm_audio::checkstringvalid(row[0]);
		subcategory = zm_audio::checkstringvalid(row[1]);
		if(!isdefined(level.var_fee8e90b))
		{
			level.var_fee8e90b = [];
		}
		if(!isdefined(level.var_fee8e90b[category]))
		{
			level.var_fee8e90b[category] = [];
		}
		level.var_fee8e90b[category][subcategory] = &function_8123b826;
		index++;
		row = tablelookuprow(table, index);
	}
}

/*
	Name: on_connect
	Namespace: namespace_3263198e
	Checksum: 0x44537BB5
	Offset: 0xA58
	Size: 0x2AC
	Parameters: 0
	Flags: Linked, Private
*/
private function on_connect()
{
	level endon(#"end_game");
	self endon(#"disconnect");
	if(self namespace_48f3568::function_69e9e553(array(#"hash_447b3c77b73aa2a9")))
	{
		self thread function_3e0d878f();
		self thread function_2e565334();
	}
	self zm_audio::function_6191af93(#"surrounded", #"self", #"oh", #"shit", 100);
	self zm_audio::function_6191af93(#"general", #"crawl_spawn", #"general", #"hash_6bfa61b5a465d382", 100);
	self zm_audio::function_6191af93(#"magicbox", #"hash_10f614b278daaebc", #"magicbox", #"monkey", 100);
	self zm_audio::function_6191af93(#"kill", #"hash_10f614b278daaebc", #"kill", #"monkey", 100);
	self zm_audio::function_87714659(&function_e08cd7b, #"roundstart", #"special");
	level flag::wait_till(#"hash_621d31a87bd6d05b");
	self zm_audio::function_6191af93(#"kill", #"music_box", #"hash_425b5ddae83ca6a8", #"music_box", 100);
}

/*
	Name: function_2e565334
	Namespace: namespace_3263198e
	Checksum: 0x698889BF
	Offset: 0xD10
	Size: 0xDA
	Parameters: 0
	Flags: Linked
*/
function function_2e565334()
{
	level endon(#"end_game");
	self endon(#"disconnect");
	while(true)
	{
		if(namespace_891c9bac::function_d122265c(self) && self.str_vo_being_spoken === #"hash_1242b7914448ebc7")
		{
			while(!isdefined(self.var_4377124))
			{
				wait(0.1);
			}
			wait(1);
			if(!(isdefined(level.var_3c9cfd6f) && level.var_3c9cfd6f))
			{
				self zm_audio::do_player_or_npc_playvox(#"hash_3708596aed65f96a", 1);
			}
		}
		else
		{
			wait(1);
		}
	}
}

/*
	Name: function_e08cd7b
	Namespace: namespace_3263198e
	Checksum: 0x66F984AC
	Offset: 0xDF8
	Size: 0x3E
	Parameters: 2
	Flags: Linked
*/
function function_e08cd7b(category, subcategory)
{
	if(level flag::get("trinket_round"))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_8123b826
	Namespace: namespace_3263198e
	Checksum: 0x779401CB
	Offset: 0xE40
	Size: 0xE8
	Parameters: 2
	Flags: Linked
*/
function function_8123b826(str_category, var_39acfdda)
{
	zm_audio::play_vo_internal(self.str_vo_being_spoken, undefined);
	if(isdefined(self.var_fbbeefe6) && isdefined(level.sndplayervox[str_category]) && isdefined(level.sndplayervox[str_category][var_39acfdda]))
	{
		vox = level.sndplayervox[str_category][var_39acfdda];
		str_alias = vox.suffix + "_plr_5_" + self.var_fbbeefe6;
		if(soundexists(str_alias))
		{
			zm_audio::play_vo_internal(str_alias, self);
		}
	}
	return 1;
}

/*
	Name: function_51b752a9
	Namespace: namespace_3263198e
	Checksum: 0xD0D1C77E
	Offset: 0xF30
	Size: 0x322
	Parameters: 4
	Flags: Linked
*/
function function_51b752a9(str_alias, var_e29c5f3b = int(-1), b_wait_if_busy = 0, var_a97d4e32 = 0)
{
	if(isdefined(level.var_3c9cfd6f) && level.var_3c9cfd6f || !isdefined(self))
	{
		return;
	}
	level endon(#"game_ended");
	self endon(#"player_downed", #"death", #"disconnect");
	if(!zm_utility::is_player_valid(self))
	{
		return;
	}
	if(var_a97d4e32)
	{
		self.last_vo_played_time = 0;
	}
	n_index = namespace_48f3568::function_dc232a80();
	if(var_e29c5f3b < 0)
	{
		if(n_index === 17)
		{
			var_a5e8d5c7 = function_ab3ed097(str_alias + "_plr_17");
			if(var_a5e8d5c7.size > 0)
			{
				var_e29c5f3b = array::random(var_a5e8d5c7);
				return self function_51b752a9(str_alias, var_e29c5f3b, b_wait_if_busy, var_a97d4e32);
			}
		}
		else
		{
			return self namespace_891c9bac::function_a2bd5a0c(str_alias, 0, b_wait_if_busy);
		}
	}
	else
	{
		str_vo_alias = str_alias + "_plr_" + n_index + "_" + var_e29c5f3b;
		if(b_wait_if_busy)
		{
			self notify(#"hash_7efd5bdf8133ff7b");
			self endon(#"hash_7efd5bdf8133ff7b");
			var_215d4efb = (b_wait_if_busy == 2 ? 1 : 0);
			while(!zm_audio::function_65e5c19a(self.var_8dd99641, var_215d4efb))
			{
				waitframe(1);
				waittillframeend();
			}
		}
		if(!zm_audio::function_65e5c19a(self.var_8dd99641))
		{
			return 0;
		}
		self zm_audio::do_player_or_npc_playvox(str_vo_alias);
		if(n_index === 17)
		{
			str_vo_alias = str_alias + "_plr_5_" + var_e29c5f3b;
			if(soundexists(str_vo_alias))
			{
				self.var_5b6ebfd0 = 1;
				self zm_audio::play_vo_internal(str_vo_alias, self);
				self namespace_891c9bac::vo_clear();
			}
		}
		return 1;
	}
}

/*
	Name: function_ab3ed097
	Namespace: namespace_3263198e
	Checksum: 0xB16A8C61
	Offset: 0x1260
	Size: 0xC6
	Parameters: 1
	Flags: Linked
*/
function function_ab3ed097(aliasprefix)
{
	var_a5e8d5c7 = [];
	for(i = 0; i < 20; i++)
	{
		str_alias = aliasprefix + "_" + i;
		if(soundexists(str_alias))
		{
			if(!isdefined(var_a5e8d5c7))
			{
				var_a5e8d5c7 = [];
			}
			else if(!isarray(var_a5e8d5c7))
			{
				var_a5e8d5c7 = array(var_a5e8d5c7);
			}
			var_a5e8d5c7[var_a5e8d5c7.size] = i;
		}
	}
	return var_a5e8d5c7;
}

/*
	Name: function_fd24e47f
	Namespace: namespace_3263198e
	Checksum: 0x85BD1051
	Offset: 0x1330
	Size: 0xC4
	Parameters: 4
	Flags: Linked
*/
function function_fd24e47f(str_alias, var_e29c5f3b = int(-1), b_wait_if_busy = 0, var_a97d4e32 = 0)
{
	level endon(#"game_ended");
	player = namespace_509a75d1::function_3815943c();
	if(isdefined(player))
	{
		player function_51b752a9(str_alias, var_e29c5f3b, b_wait_if_busy, var_a97d4e32);
	}
}

/*
	Name: function_865209df
	Namespace: namespace_3263198e
	Checksum: 0xDE4E9AFD
	Offset: 0x1400
	Size: 0x1C8
	Parameters: 6
	Flags: Linked
*/
function function_865209df(category, flag, delay = 2, var_ba54b77d = -1, n_range = 800, var_618a04 = 0)
{
	subcategory = #"react";
	self endon(#"death", #"hash_63017bebd33d7316");
	b_flag = level flag::get(flag);
	if(b_flag)
	{
		return;
	}
	if(isstring(delay))
	{
		self waittill(delay);
	}
	else if(delay > 0)
	{
		wait(delay);
	}
	player_vo = function_bf1b121a(var_ba54b77d, n_range, var_618a04);
	b_flag = level flag::get(flag);
	if(isdefined(player_vo) && !b_flag)
	{
		result = 1 === player_vo zm_audio::create_and_play_dialog(category, subcategory, undefined, 0);
	}
	if(result === 1)
	{
		level flag::set(flag);
	}
	return result;
}

/*
	Name: function_bf1b121a
	Namespace: namespace_3263198e
	Checksum: 0x7E93B1A4
	Offset: 0x15D0
	Size: 0x222
	Parameters: 3
	Flags: Linked, Private
*/
private function function_bf1b121a(timeout, n_range, var_618a04)
{
	__timeout__ = timeout;
	var_a51f2d59 = gettime();
	do
	{
		var_6f868336 = arraysort(level.activeplayers, self.origin, 1, level.activeplayers.size, n_range);
		foreach(player in var_6f868336)
		{
			if(!player zm_audio::function_65e5c19a(1) || (isdefined(level.var_b625a184) && level.var_b625a184))
			{
				continue;
			}
			if(isstruct(self) || var_618a04)
			{
				if(player util::is_looking_at(self, 0.65, 1))
				{
					return player;
				}
				continue;
			}
			if(isentity(self))
			{
				if(self sightconetrace(player getplayercamerapos(), player, anglestoforward(player.angles)) > 0.3)
				{
					return player;
				}
			}
		}
		waitframe(5);
	}
	while(!(__timeout__ >= 0 && __timeout__ - float(gettime() - var_a51f2d59) / 1000 <= 0));
}

/*
	Name: function_e43bea18
	Namespace: namespace_3263198e
	Checksum: 0x83D56FB7
	Offset: 0x1800
	Size: 0xD6
	Parameters: 1
	Flags: Linked
*/
function function_e43bea18(var_11975e15)
{
	str_weapon = undefined;
	switch(var_11975e15)
	{
		case "hash_1ecb90ddb44096f4":
		case "hash_4b7e4696d38d13e3":
		case "hash_4d50a2c4ff4e615d":
		case "hash_7b1ab4354f6a9ef4":
		{
			str_weapon = #"hash_4b7e4696d38d13e3";
			break;
		}
		case "hash_a2556a2905fd952":
		{
			str_weapon = #"hash_72fe417b2fdf3abe";
			break;
		}
		case "music_box":
		{
			str_weapon = #"music_box";
			break;
		}
	}
	return str_weapon;
}

/*
	Name: function_e162fac3
	Namespace: namespace_3263198e
	Checksum: 0xB10E273B
	Offset: 0x18E0
	Size: 0xF8
	Parameters: 2
	Flags: Linked
*/
function function_e162fac3(weapon, str_vo_line)
{
	if(weapon === getweapon(#"ww_tesla_sniper_t8"))
	{
		return #"hash_24c829c980982c1";
	}
	if(weapon === getweapon(#"thundergun"))
	{
		return #"thundergun";
	}
	if(weapon === getweapon(#"tundragun"))
	{
		return #"tundragun";
	}
	if(weapon === getweapon(#"hash_7a42b57be462143f"))
	{
		return #"hash_72fe417b2fdf3abe";
	}
	return str_vo_line;
}

/*
	Name: function_cda40569
	Namespace: namespace_3263198e
	Checksum: 0x46BF7284
	Offset: 0x19E0
	Size: 0x5C
	Parameters: 4
	Flags: None
*/
function function_cda40569(n_delay, str_alias, var_e29c5f3b, str_endon)
{
	level endon(str_endon);
	wait(n_delay);
	level.pablo_npc thread namespace_509a75d1::function_6a0d675d(str_alias, var_e29c5f3b, 0, 1);
}

/*
	Name: function_67b3a43
	Namespace: namespace_3263198e
	Checksum: 0x311CCFAE
	Offset: 0x1A48
	Size: 0x14C
	Parameters: 0
	Flags: None
*/
function function_67b3a43()
{
	level endon(#"end_game");
	level waittill(#"start_of_round");
	var_833bb1c7 = getentarray("use_elec_switch", "targetname");
	foreach(trig in var_833bb1c7)
	{
		if(trig.script_int === 1)
		{
			var_2b95ab5b = trig;
			break;
		}
	}
	if(isdefined(var_2b95ab5b))
	{
		waitresult = undefined;
		waitresult = var_2b95ab5b waittill(#"trigger");
		user = waitresult.activator;
		user thread function_51b752a9(#"hash_52d22e25dd1ac29f");
	}
}

/*
	Name: function_3d6809e9
	Namespace: namespace_3263198e
	Checksum: 0xC07FB1E1
	Offset: 0x1BA0
	Size: 0x1AA
	Parameters: 0
	Flags: Linked
*/
function function_3d6809e9()
{
	level endon(#"end_game");
	n_round = namespace_a28acff3::get_round_number();
	zm_utility::function_fdb0368(3);
	level.var_b2b15659 = 1;
	while(true)
	{
		level waittill(#"end_of_round");
		wait(5);
		if(level.var_1c53964e zm_audio::function_65e5c19a())
		{
			break;
		}
	}
	level.var_1c53964e namespace_509a75d1::function_6a0d675d(#"hash_58f39ce928f3a523", -1, 0, 1);
	function_fd24e47f(#"hash_58f39ce928f3a523");
	while(true)
	{
		level waittill(#"end_of_round");
		wait(5);
		if(level.var_1c53964e zm_audio::function_65e5c19a())
		{
			break;
		}
	}
	level.var_1c53964e namespace_509a75d1::function_6a0d675d(#"vox_round_end_2_nikolai", -1, 0, 1);
	function_fd24e47f("vox_round_end_2_nikolai", -1, 0, 0);
	level.var_b2b15659 = 0;
}

/*
	Name: function_8a7521db
	Namespace: namespace_3263198e
	Checksum: 0x3E4EFEAA
	Offset: 0x1D58
	Size: 0x110
	Parameters: 1
	Flags: Linked
*/
function function_8a7521db(str)
{
	/#
		/#
			assert(isdefined(str), "");
		#/
	#/
	var_58c9b9cc = struct::get_array(str, "targetname");
	foreach(var_3bb6cef5 in var_58c9b9cc)
	{
		/#
			/#
				assert(isdefined(var_3bb6cef5.var_ee00b371), "");
			#/
		#/
		var_3bb6cef5 thread scene::play(var_3bb6cef5.var_ee00b371);
	}
}

/*
	Name: function_fe8ee9f0
	Namespace: namespace_3263198e
	Checksum: 0xD81854A7
	Offset: 0x1E70
	Size: 0x128
	Parameters: 2
	Flags: Linked
*/
function function_fe8ee9f0(var_b36eb2ad, var_7f70dbec = 1)
{
	if(isdefined(var_7f70dbec) && var_7f70dbec)
	{
		if(isdefined(var_b36eb2ad) && (var_b36eb2ad == level.var_ad5d43cf || var_b36eb2ad == level.var_f8934665 || var_b36eb2ad == level.var_bf70d56c || var_b36eb2ad == level.var_d879215 || var_b36eb2ad == level.var_2274350d || var_b36eb2ad == level.var_a3ee16a0))
		{
			return 1;
		}
		return 0;
	}
	if(isdefined(var_b36eb2ad) && (var_b36eb2ad == level.var_ad5d43cf || var_b36eb2ad == level.var_f8934665 || var_b36eb2ad == level.var_bf70d56c || var_b36eb2ad == level.var_d879215))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_60403468
	Namespace: namespace_3263198e
	Checksum: 0x4B805186
	Offset: 0x1FA8
	Size: 0x88
	Parameters: 0
	Flags: Linked
*/
function function_60403468()
{
	foreach(var_9204e482 in level.var_8f81a2cc)
	{
		if(self hasweapon(var_9204e482))
		{
			return var_9204e482;
		}
	}
}

/*
	Name: function_3d581a6
	Namespace: namespace_3263198e
	Checksum: 0x992EEE45
	Offset: 0x2040
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_3d581a6()
{
	return isdefined(self function_60403468());
}

/*
	Name: is_wonder_weapon
	Namespace: namespace_3263198e
	Checksum: 0xA5BE386C
	Offset: 0x2068
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function is_wonder_weapon(w_weapon)
{
	return isinarray(level.var_8f81a2cc, w_weapon);
}

/*
	Name: function_5cd05b9
	Namespace: namespace_3263198e
	Checksum: 0xD30FF51F
	Offset: 0x20A0
	Size: 0x74
	Parameters: 2
	Flags: Linked
*/
function function_5cd05b9(var_6a82f66f, var_78c892fa)
{
	var_e8d0313a = zm_weapons::get_base_weapon(var_6a82f66f);
	var_db8e96b7 = zm_weapons::get_base_weapon(var_78c892fa);
	return isdefined(var_e8d0313a) && isdefined(var_db8e96b7) && var_e8d0313a == var_db8e96b7;
}

/*
	Name: function_adb657dd
	Namespace: namespace_3263198e
	Checksum: 0xBB4FB400
	Offset: 0x2120
	Size: 0x1A8
	Parameters: 1
	Flags: Linked
*/
function function_adb657dd(e_player)
{
	w_give = self.stub.related_parent.var_5af20245;
	var_40d3de6c = e_player function_60403468();
	if(isdefined(var_40d3de6c))
	{
		if(function_5cd05b9(var_40d3de6c, w_give))
		{
			self sethintstring(zm_utility::function_d6046228(#"hash_1ee18bf56df7a29b", #"hash_39d6b1ad0b94f111"));
		}
		else
		{
			self sethintstring(zm_utility::function_d6046228(#"hash_172253c9314825fc", #"hash_71016e43b6fe0570"), w_give.displayname, var_40d3de6c.displayname);
		}
	}
	else if(e_player.currentweapon.isheroweapon === 1 || e_player.currentweapon.name === #"hash_603fdd2e4ae5b2b0")
	{
		return 0;
	}
	self sethintstring(zm_utility::function_d6046228(#"hash_314a7588b45256eb", #"hash_6831cfd35264e1"), w_give.displayname);
	return 1;
}

/*
	Name: function_c3d56ed8
	Namespace: namespace_3263198e
	Checksum: 0x518A4198
	Offset: 0x22D0
	Size: 0x15C
	Parameters: 0
	Flags: Linked
*/
function function_c3d56ed8()
{
	self endon(#"death");
	w_give = self.var_5af20245;
	var_be17187b = undefined;
	var_be17187b = self waittill(#"trigger_activated");
	e_player = var_be17187b.e_who;
	var_40d3de6c = e_player function_60403468();
	var_5543fe20 = 1;
	if(isdefined(var_40d3de6c))
	{
		if(function_5cd05b9(var_40d3de6c, w_give))
		{
			e_player zm_weapons::function_7c5dd4bd(var_40d3de6c);
			var_5543fe20 = 0;
		}
		else
		{
			e_player zm_weapons::weapon_take(var_40d3de6c);
		}
	}
	if(var_5543fe20)
	{
		e_player zm_weapons::weapon_give(w_give, 1);
	}
	zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
	if(isdefined(self.var_383f77fa))
	{
		level thread [[self.var_383f77fa]](e_player, var_5543fe20);
	}
	self delete();
}

/*
	Name: function_dfa12910
	Namespace: namespace_3263198e
	Checksum: 0xB4A4E7C3
	Offset: 0x2438
	Size: 0x6C
	Parameters: 2
	Flags: Linked
*/
function function_dfa12910(var_5af20245, var_383f77fa)
{
	self.var_5af20245 = var_5af20245;
	self.var_383f77fa = var_383f77fa;
	self zm_unitrigger::create(&function_adb657dd, 96);
	self thread function_c3d56ed8();
}

/*
	Name: custom_magic_box_selection_logic
	Namespace: namespace_3263198e
	Checksum: 0xB2A5F51F
	Offset: 0x24B0
	Size: 0x50
	Parameters: 2
	Flags: Linked
*/
function custom_magic_box_selection_logic(w_weapon, e_player)
{
	if(is_wonder_weapon(w_weapon) && e_player function_3d581a6())
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_2f57e2d2
	Namespace: namespace_3263198e
	Checksum: 0xED0076A1
	Offset: 0x2508
	Size: 0x80
	Parameters: 1
	Flags: Linked
*/
function function_2f57e2d2(e_player)
{
	var_5f6b2789 = self.stub.trigger_target;
	if(var_5f6b2789.weapon_out === 1 && is_wonder_weapon(var_5f6b2789.zbarrier.weapon) && e_player function_3d581a6())
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_8a4b7d4a
	Namespace: namespace_3263198e
	Checksum: 0xE73A49
	Offset: 0x2590
	Size: 0xB8
	Parameters: 1
	Flags: Linked
*/
function function_8a4b7d4a(weapon)
{
	if(isinarray(level.var_2aeeb358, weapon))
	{
		foreach(var_ea6b9209 in level.var_2aeeb358)
		{
			if(self hasweapon(var_ea6b9209, 1))
			{
				return var_ea6b9209;
			}
		}
	}
}

/*
	Name: function_afbd7223
	Namespace: namespace_3263198e
	Checksum: 0xD221DC7
	Offset: 0x2650
	Size: 0x298
	Parameters: 2
	Flags: Linked
*/
function function_afbd7223(oldweapondata, newweapondata)
{
	w_current = oldweapondata[#"weapon"];
	var_2153c223 = newweapondata[#"weapon"];
	if(isinarray(level.var_65b6264d, w_current) && isinarray(level.var_65b6264d, var_2153c223))
	{
		weapondata = [];
		var_8500c3b7 = array(level.var_2aeeb358[3], level.var_2aeeb358[1], level.var_2aeeb358[2], level.var_2aeeb358[0]);
		foreach(var_9fbd6e74 in var_8500c3b7)
		{
			if(w_current == var_9fbd6e74 || var_2153c223 == var_9fbd6e74)
			{
				weapondata[#"weapon"] = var_9fbd6e74;
				break;
			}
		}
		var_a0bd414d = weapondata[#"weapon"];
		weapondata[#"clip"] = int(min(newweapondata[#"clip"] + oldweapondata[#"clip"], var_a0bd414d.clipsize));
		weapondata[#"stock"] = int(min(newweapondata[#"stock"] + oldweapondata[#"stock"], var_a0bd414d.maxammo));
		return weapondata;
	}
}

