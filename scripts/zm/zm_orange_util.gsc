// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_vo.gsc;
#using scripts\zm\zm_hms_util.gsc;
#using scripts\zm_common\zm_round_logic.gsc;
#using scripts\zm_common\zm_characters.gsc;
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

#namespace zm_orange_util;

/*
	Name: init
	Namespace: zm_orange_util
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
	level.a_w_wonder = array(getweapon("ray_gun"), getweapon("ray_gun_upgraded"), getweapon("ray_gun_mk2"), getweapon("ray_gun_mk2_upgraded"), getweapon("tundragun"), getweapon("tundragun_upgraded"), getweapon("thundergun"), getweapon("thundergun_upgraded"), getweapon("ww_tesla_sniper_t8"), getweapon("ww_tesla_sniper_upgraded_t8"));
	level.a_w_ray_guns = array(getweapon("ray_gun"), getweapon("ray_gun_upgraded"), getweapon("ray_gun_mk2"), getweapon("ray_gun_mk2_upgraded"));
	level.var_ee565b3f = &function_8a4b7d4a;
	level.var_bb2323e4 = &function_afbd7223;
	level.custom_magic_box_selection_logic = &custom_magic_box_selection_logic;
	level.var_2f57e2d2 = &function_2f57e2d2;
	callback::on_connect(&on_connect);
}

/*
	Name: function_583cad13
	Namespace: zm_orange_util
	Checksum: 0x91C7C994
	Offset: 0x5F0
	Size: 0x2D0
	Parameters: 1
	Flags: Linked
*/
function function_583cad13(var_2753f06a)
{
	wait(1);
	b_played = 0;
	a_players = arraycopy(level.players);
	if(!isdefined(level.host))
	{
		return 0;
	}
	var_5316ea7d = level.host zm_vo::function_82f9bc9f();
	if(a_players.size == 1)
	{
		e_player = a_players[0];
		if(var_2753f06a == 0)
		{
			str_suffix = #"vox_solo_game_start_" + var_5316ea7d;
		}
		else
		{
			str_suffix = ((#"vox_solo_end_round" + var_2753f06a) + "_") + var_5316ea7d;
		}
		b_played = e_player zm_vo::function_a2bd5a0c(str_suffix, 0, 1);
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
			var_d1e952c4 = zm_hms_util::function_3815943c(a_players);
			if(isdefined(var_d1e952c4))
			{
				var_d1e952c4 function_51b752a9(#"hash_4c0be2bb6d0c80b0" + var_5316ea7d);
			}
		}
		else
		{
			level.host function_51b752a9(((#"hash_71bde3a512edb440" + var_2753f06a) + "_") + var_5316ea7d);
			var_d1e952c4 = zm_hms_util::function_3815943c(a_players);
			if(isdefined(var_d1e952c4))
			{
				var_d1e952c4 function_51b752a9(((#"hash_71bde3a512edb440" + var_2753f06a) + "_") + var_5316ea7d);
			}
		}
		b_played = 1;
	}
	return b_played;
}

/*
	Name: function_3e0d878f
	Namespace: zm_orange_util
	Checksum: 0xD0C6333A
	Offset: 0x8C8
	Size: 0x4E
	Parameters: 0
	Flags: Linked, Private
*/
function private function_3e0d878f()
{
	self endon(#"death");
	level flag::wait_till(#"hash_142bf0da77232815");
	self.var_631a26f0 = level.var_fee8e90b;
}

/*
	Name: function_af205e69
	Namespace: zm_orange_util
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
	Namespace: zm_orange_util
	Checksum: 0x44537BB5
	Offset: 0xA58
	Size: 0x2AC
	Parameters: 0
	Flags: Linked, Private
*/
function private on_connect()
{
	level endon(#"end_game");
	self endon(#"disconnect");
	if(self zm_characters::is_character(array(#"hash_447b3c77b73aa2a9")))
	{
		self thread function_3e0d878f();
		self thread function_2e565334();
	}
	self zm_audio::function_6191af93(#"surrounded", #"self", #"oh", #"shit", 100);
	self zm_audio::function_6191af93(#"general", #"crawl_spawn", #"general", #"crawl_seen", 100);
	self zm_audio::function_6191af93(#"magicbox", #"homunculus", #"magicbox", #"monkey", 100);
	self zm_audio::function_6191af93(#"kill", #"homunculus", #"kill", #"monkey", 100);
	self zm_audio::function_87714659(&function_e08cd7b, #"roundstart", #"special");
	level flag::wait_till(#"hash_621d31a87bd6d05b");
	self zm_audio::function_6191af93(#"kill", #"music_box", #"post_kill", #"music_box", 100);
}

/*
	Name: function_2e565334
	Namespace: zm_orange_util
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
		if(zm_vo::is_player_speaking(self) && self.str_vo_being_spoken === #"hash_1242b7914448ebc7")
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
	Namespace: zm_orange_util
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
		return true;
	}
	return false;
}

/*
	Name: function_8123b826
	Namespace: zm_orange_util
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
		str_alias = (vox.suffix + "_plr_5_") + self.var_fbbeefe6;
		if(soundexists(str_alias))
		{
			zm_audio::play_vo_internal(str_alias, self);
		}
	}
	return true;
}

/*
	Name: function_51b752a9
	Namespace: zm_orange_util
	Checksum: 0xD0D1C77E
	Offset: 0xF30
	Size: 0x322
	Parameters: 4
	Flags: Linked
*/
function function_51b752a9(str_alias, n_variant = int(-1), b_wait_if_busy = 0, var_a97d4e32 = 0)
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
	n_index = zm_characters::function_dc232a80();
	if(n_variant < 0)
	{
		if(n_index === 17)
		{
			var_a5e8d5c7 = function_ab3ed097(str_alias + "_plr_17");
			if(var_a5e8d5c7.size > 0)
			{
				n_variant = array::random(var_a5e8d5c7);
				return self function_51b752a9(str_alias, n_variant, b_wait_if_busy, var_a97d4e32);
			}
		}
		else
		{
			return self zm_vo::function_a2bd5a0c(str_alias, 0, b_wait_if_busy);
		}
	}
	else
	{
		str_vo_alias = (((str_alias + "_plr_") + n_index) + "_") + n_variant;
		if(b_wait_if_busy)
		{
			self notify(#"hash_7efd5bdf8133ff7b");
			self endon(#"hash_7efd5bdf8133ff7b");
			var_215d4efb = (b_wait_if_busy == 2 ? 1 : 0);
			while(!zm_audio::function_65e5c19a(self.toself, var_215d4efb))
			{
				waitframe(1);
				waittillframeend();
			}
		}
		if(!zm_audio::function_65e5c19a(self.toself))
		{
			return 0;
		}
		self zm_audio::do_player_or_npc_playvox(str_vo_alias);
		if(n_index === 17)
		{
			str_vo_alias = (str_alias + "_plr_5_") + n_variant;
			if(soundexists(str_vo_alias))
			{
				self.var_5b6ebfd0 = 1;
				self zm_audio::play_vo_internal(str_vo_alias, self);
				self zm_vo::vo_clear();
			}
		}
		return 1;
	}
}

/*
	Name: function_ab3ed097
	Namespace: zm_orange_util
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
		str_alias = (aliasprefix + "_") + i;
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
	Namespace: zm_orange_util
	Checksum: 0x85BD1051
	Offset: 0x1330
	Size: 0xC4
	Parameters: 4
	Flags: Linked
*/
function function_fd24e47f(str_alias, n_variant = int(-1), b_wait_if_busy = 0, var_a97d4e32 = 0)
{
	level endon(#"game_ended");
	player = zm_hms_util::function_3815943c();
	if(isdefined(player))
	{
		player function_51b752a9(str_alias, n_variant, b_wait_if_busy, var_a97d4e32);
	}
}

/*
	Name: function_865209df
	Namespace: zm_orange_util
	Checksum: 0xDE4E9AFD
	Offset: 0x1400
	Size: 0x1C8
	Parameters: 6
	Flags: Linked
*/
function function_865209df(category, flag, delay = 2, var_ba54b77d = -1, n_range = 800, var_618a04 = 0)
{
	subcategory = #"react";
	self endon(#"death", #"dynamited");
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
	Namespace: zm_orange_util
	Checksum: 0x7E93B1A4
	Offset: 0x15D0
	Size: 0x222
	Parameters: 3
	Flags: Linked, Private
*/
function private function_bf1b121a(timeout, n_range, var_618a04)
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
	while(!(__timeout__ >= 0 && (__timeout__ - ((float(gettime() - var_a51f2d59)) / 1000)) <= 0));
}

/*
	Name: function_e43bea18
	Namespace: zm_orange_util
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
		case "snowball_upgraded":
		case "snowball":
		case "snowball_yellow_upgraded":
		case "snowball_yellow":
		{
			str_weapon = #"snowball";
			break;
		}
		case "hash_a2556a2905fd952":
		{
			str_weapon = #"matryoshka";
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
	Namespace: zm_orange_util
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
		return #"tempest";
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
		return #"matryoshka";
	}
	return str_vo_line;
}

/*
	Name: function_cda40569
	Namespace: zm_orange_util
	Checksum: 0x46BF7284
	Offset: 0x19E0
	Size: 0x5C
	Parameters: 4
	Flags: None
*/
function function_cda40569(n_delay, str_alias, n_variant, str_endon)
{
	level endon(str_endon);
	wait(n_delay);
	level.pablo_npc thread zm_hms_util::function_6a0d675d(str_alias, n_variant, 0, 1);
}

/*
	Name: docks_power
	Namespace: zm_orange_util
	Checksum: 0x311CCFAE
	Offset: 0x1A48
	Size: 0x14C
	Parameters: 0
	Flags: None
*/
function docks_power()
{
	level endon(#"end_game");
	level waittill(#"start_of_round");
	var_833bb1c7 = getentarray("use_elec_switch", "targetname");
	foreach(trig in var_833bb1c7)
	{
		if(trig.script_int === 1)
		{
			power_trig = trig;
			break;
		}
	}
	if(isdefined(power_trig))
	{
		waitresult = undefined;
		waitresult = power_trig waittill(#"trigger");
		user = waitresult.activator;
		user thread function_51b752a9(#"hash_52d22e25dd1ac29f");
	}
}

/*
	Name: function_3d6809e9
	Namespace: zm_orange_util
	Checksum: 0xC07FB1E1
	Offset: 0x1BA0
	Size: 0x1AA
	Parameters: 0
	Flags: Linked
*/
function function_3d6809e9()
{
	level endon(#"end_game");
	n_round = zm_round_logic::get_round_number();
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
	level.var_1c53964e zm_hms_util::function_6a0d675d(#"hash_58f39ce928f3a523", -1, 0, 1);
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
	level.var_1c53964e zm_hms_util::function_6a0d675d(#"vox_round_end_2_nikolai", -1, 0, 1);
	function_fd24e47f("vox_round_end_2_nikolai", -1, 0, 0);
	level.var_b2b15659 = 0;
}

/*
	Name: function_8a7521db
	Namespace: zm_orange_util
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
	Namespace: zm_orange_util
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
		if(isdefined(var_b36eb2ad) && (var_b36eb2ad == level.w_snowball || var_b36eb2ad == level.var_f8934665 || var_b36eb2ad == level.var_bf70d56c || var_b36eb2ad == level.var_d879215 || var_b36eb2ad == level.w_tundragun || var_b36eb2ad == level.w_tundragun_upgraded))
		{
			return true;
		}
		return false;
	}
	if(isdefined(var_b36eb2ad) && (var_b36eb2ad == level.w_snowball || var_b36eb2ad == level.var_f8934665 || var_b36eb2ad == level.var_bf70d56c || var_b36eb2ad == level.var_d879215))
	{
		return true;
	}
	return false;
}

/*
	Name: function_60403468
	Namespace: zm_orange_util
	Checksum: 0x4B805186
	Offset: 0x1FA8
	Size: 0x88
	Parameters: 0
	Flags: Linked
*/
function function_60403468()
{
	foreach(w_wonder in level.a_w_wonder)
	{
		if(self hasweapon(w_wonder))
		{
			return w_wonder;
		}
	}
}

/*
	Name: function_3d581a6
	Namespace: zm_orange_util
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
	Namespace: zm_orange_util
	Checksum: 0xA5BE386C
	Offset: 0x2068
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function is_wonder_weapon(w_weapon)
{
	return isinarray(level.a_w_wonder, w_weapon);
}

/*
	Name: function_5cd05b9
	Namespace: zm_orange_util
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
	Namespace: zm_orange_util
	Checksum: 0xBB4FB400
	Offset: 0x2120
	Size: 0x1A8
	Parameters: 1
	Flags: Linked
*/
function function_adb657dd(e_player)
{
	w_give = self.stub.related_parent.w_pickup;
	w_take = e_player function_60403468();
	if(isdefined(w_take))
	{
		if(function_5cd05b9(w_take, w_give))
		{
			self sethintstring(zm_utility::function_d6046228(#"hash_1ee18bf56df7a29b", #"hash_39d6b1ad0b94f111"));
		}
		else
		{
			self sethintstring(zm_utility::function_d6046228(#"hash_172253c9314825fc", #"hash_71016e43b6fe0570"), w_give.displayname, w_take.displayname);
		}
	}
	else
	{
		if(e_player.currentweapon.isheroweapon === 1 || e_player.currentweapon.name === #"hash_603fdd2e4ae5b2b0")
		{
			return false;
		}
		self sethintstring(zm_utility::function_d6046228(#"hash_314a7588b45256eb", #"hash_6831cfd35264e1"), w_give.displayname);
	}
	return true;
}

/*
	Name: function_c3d56ed8
	Namespace: zm_orange_util
	Checksum: 0x518A4198
	Offset: 0x22D0
	Size: 0x15C
	Parameters: 0
	Flags: Linked
*/
function function_c3d56ed8()
{
	self endon(#"death");
	w_give = self.w_pickup;
	var_be17187b = undefined;
	var_be17187b = self waittill(#"trigger_activated");
	e_player = var_be17187b.e_who;
	w_take = e_player function_60403468();
	b_give_weapon = 1;
	if(isdefined(w_take))
	{
		if(function_5cd05b9(w_take, w_give))
		{
			e_player zm_weapons::function_7c5dd4bd(w_take);
			b_give_weapon = 0;
		}
		else
		{
			e_player zm_weapons::weapon_take(w_take);
		}
	}
	if(b_give_weapon)
	{
		e_player zm_weapons::weapon_give(w_give, 1);
	}
	zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
	if(isdefined(self.func_cleanup))
	{
		level thread [[self.func_cleanup]](e_player, b_give_weapon);
	}
	self delete();
}

/*
	Name: start_zombies_collision_manager
	Namespace: zm_orange_util
	Checksum: 0xB4A4E7C3
	Offset: 0x2438
	Size: 0x6C
	Parameters: 2
	Flags: Linked
*/
function start_zombies_collision_manager(w_pickup, func_cleanup)
{
	self.w_pickup = w_pickup;
	self.func_cleanup = func_cleanup;
	self zm_unitrigger::create(&function_adb657dd, 96);
	self thread function_c3d56ed8();
}

/*
	Name: custom_magic_box_selection_logic
	Namespace: zm_orange_util
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
		return false;
	}
	return true;
}

/*
	Name: function_2f57e2d2
	Namespace: zm_orange_util
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
		return false;
	}
	return true;
}

/*
	Name: function_8a4b7d4a
	Namespace: zm_orange_util
	Checksum: 0xE73A49
	Offset: 0x2590
	Size: 0xB8
	Parameters: 1
	Flags: Linked
*/
function function_8a4b7d4a(weapon)
{
	if(isinarray(level.a_w_ray_guns, weapon))
	{
		foreach(w_ray_gun in level.a_w_ray_guns)
		{
			if(self hasweapon(w_ray_gun, 1))
			{
				return w_ray_gun;
			}
		}
	}
}

/*
	Name: function_afbd7223
	Namespace: zm_orange_util
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
		var_8500c3b7 = array(level.a_w_ray_guns[3], level.a_w_ray_guns[1], level.a_w_ray_guns[2], level.a_w_ray_guns[0]);
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

