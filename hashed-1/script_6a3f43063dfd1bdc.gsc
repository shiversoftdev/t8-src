// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f9e0dc8454d98e1;
#using script_5bb072c3abf4652c;
#using script_6ce38ab036223e6e;
#using script_b52a163973f339f;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\callbacks.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_509a75d1;

/*
	Name: function_89f2df9
	Namespace: namespace_509a75d1
	Checksum: 0x31EA6918
	Offset: 0x1B8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_6cba02956ebaa3bc", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_509a75d1
	Checksum: 0x771C0C41
	Offset: 0x200
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	/#
		if(getdvarint(#"hash_79f58c97fc43e423", 0))
		{
			level thread function_774b42ac();
		}
		if(getdvarint(#"hash_4912911249444062", 0))
		{
			level.var_df9f1a00 = [];
			callback::on_ai_spawned(&function_df54cbcd);
			callback::on_ai_killed(&function_86b062a6);
			callback::function_74872db6(&function_acd2ba83);
			level thread function_84b292b4();
		}
		level thread devgui();
	#/
}

/*
	Name: function_e308175e
	Namespace: namespace_509a75d1
	Checksum: 0x27082122
	Offset: 0x310
	Size: 0x14C
	Parameters: 3
	Flags: Linked
*/
function function_e308175e(alias, v_pos, e_player)
{
	n_wait_time = float(soundgetplaybacktime(alias)) / 1000;
	if(isdefined(e_player) && isplayer(e_player) && isalive(e_player))
	{
		if(isentity(self))
		{
			self playsoundtoplayer(alias, e_player);
		}
		else
		{
			e_tag = util::spawn_model("tag_origin", v_pos);
			e_tag playsoundtoplayer(alias, e_player);
		}
	}
	else
	{
		playsoundatposition(alias, v_pos);
	}
	wait(n_wait_time);
	if(isdefined(e_tag))
	{
		e_tag delete();
	}
}

/*
	Name: function_52c3fe8d
	Namespace: namespace_509a75d1
	Checksum: 0xD2FFA257
	Offset: 0x468
	Size: 0x88
	Parameters: 2
	Flags: None
*/
function function_52c3fe8d(a_audio, v_pos)
{
	foreach(audio in a_audio)
	{
		function_e308175e(audio, v_pos);
	}
}

/*
	Name: function_d6dadf85
	Namespace: namespace_509a75d1
	Checksum: 0x602329B9
	Offset: 0x4F8
	Size: 0x7A
	Parameters: 3
	Flags: Linked
*/
function function_d6dadf85(alias, player, entity)
{
	n_wait_time = float(soundgetplaybacktime(alias)) / 1000;
	entity playsoundtoplayer(alias, player);
	wait(n_wait_time);
}

/*
	Name: function_80f6206e
	Namespace: namespace_509a75d1
	Checksum: 0xFEAAD265
	Offset: 0x580
	Size: 0x98
	Parameters: 3
	Flags: None
*/
function function_80f6206e(a_audio, player, entity)
{
	foreach(audio in a_audio)
	{
		function_d6dadf85(audio, player, entity);
	}
}

/*
	Name: function_fd24e47f
	Namespace: namespace_509a75d1
	Checksum: 0x975F83F5
	Offset: 0x620
	Size: 0xC4
	Parameters: 4
	Flags: None
*/
function function_fd24e47f(str_alias, var_e29c5f3b = int(-1), b_wait_if_busy = 0, var_a97d4e32 = 0)
{
	level endon(#"game_ended");
	player = function_3815943c();
	if(isdefined(player))
	{
		player function_51b752a9(str_alias, var_e29c5f3b, b_wait_if_busy, var_a97d4e32);
	}
}

/*
	Name: function_51b752a9
	Namespace: namespace_509a75d1
	Checksum: 0xDB137277
	Offset: 0x6F0
	Size: 0x22C
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
	if(var_e29c5f3b < 0)
	{
		self namespace_891c9bac::function_a2bd5a0c(str_alias, 0, b_wait_if_busy);
	}
	else
	{
		n_index = namespace_48f3568::function_dc232a80();
		str_vo_alias = str_alias + "_plr_" + n_index + "_" + var_e29c5f3b;
		if(b_wait_if_busy)
		{
			self notify(#"hash_7efd5bdf8133ff7b");
			self endon(#"hash_7efd5bdf8133ff7b");
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
	}
}

/*
	Name: function_6a0d675d
	Namespace: namespace_509a75d1
	Checksum: 0x1A4DDCE6
	Offset: 0x928
	Size: 0x294
	Parameters: 4
	Flags: Linked
*/
function function_6a0d675d(str_alias, var_e29c5f3b = int(-1), b_wait_if_busy = 0, var_a97d4e32 = 0)
{
	if(isdefined(level.var_3c9cfd6f) && level.var_3c9cfd6f || game.state == "postgame")
	{
		return;
	}
	level endon(#"game_ended");
	self endon(#"death");
	if(b_wait_if_busy)
	{
		self notify(#"hash_7efd5bdf8133ff7b");
		self endon(#"hash_7efd5bdf8133ff7b");
		while(!zm_audio::function_65e5c19a(self.var_8dd99641, var_215d4efb))
		{
			waitframe(1);
			waittillframeend();
		}
	}
	else if(!self zm_audio::function_65e5c19a())
	{
		return;
	}
	if(var_a97d4e32)
	{
		self.last_vo_played_time = 0;
	}
	str_vo_alias = str_alias;
	if(isdefined(self.name))
	{
		str_vo_alias = str_alias + "_" + self.name;
	}
	if(var_e29c5f3b < 0)
	{
		str_vo_alias = array::random(zm_audio::get_valid_lines(str_vo_alias));
	}
	else
	{
		str_vo_alias = str_vo_alias + "_" + var_e29c5f3b;
	}
	if(!isdefined(level.var_62281818))
	{
		level.var_62281818 = [];
	}
	else if(!isarray(level.var_62281818))
	{
		level.var_62281818 = array(level.var_62281818);
	}
	level.var_62281818[level.var_62281818.size] = self;
	self zm_audio::do_player_or_npc_playvox(str_vo_alias);
}

/*
	Name: function_3c173d37
	Namespace: namespace_509a75d1
	Checksum: 0x6F3BBA2C
	Offset: 0xBC8
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_3c173d37()
{
	level notify(#"hash_1a91b42d31e0b28d");
	level namespace_891c9bac::function_3c173d37((0, 0, 0), 2147483647);
	level function_29fe9a5d();
}

/*
	Name: function_29fe9a5d
	Namespace: namespace_509a75d1
	Checksum: 0xC50A75A7
	Offset: 0xC28
	Size: 0xC0
	Parameters: 0
	Flags: Linked
*/
function function_29fe9a5d()
{
	self notify("c3b9aba044301cd");
	self endon("c3b9aba044301cd");
	var_d2d5e742 = arraycopy(level.var_62281818);
	foreach(npc in var_d2d5e742)
	{
		if(isdefined(npc))
		{
			npc namespace_891c9bac::function_57b8cd17();
		}
	}
}

/*
	Name: function_3815943c
	Namespace: namespace_509a75d1
	Checksum: 0x5B40AFA6
	Offset: 0xCF0
	Size: 0x130
	Parameters: 1
	Flags: Linked
*/
function function_3815943c(a_players)
{
	players = getplayers();
	if(isdefined(a_players))
	{
		players = a_players;
	}
	valid_players = [];
	foreach(player in players)
	{
		if(zm_utility::is_player_valid(player))
		{
			if(!isdefined(valid_players))
			{
				valid_players = [];
			}
			else if(!isarray(valid_players))
			{
				valid_players = array(valid_players);
			}
			valid_players[valid_players.size] = player;
		}
	}
	if(valid_players.size > 0)
	{
		return array::random(valid_players);
	}
}

/*
	Name: function_2270b2c8
	Namespace: namespace_509a75d1
	Checksum: 0x4323D92B
	Offset: 0xE30
	Size: 0x9C
	Parameters: 1
	Flags: None
*/
function function_2270b2c8(var_6d71e83a)
{
	if(isarray(var_6d71e83a))
	{
		foreach(value in var_6d71e83a)
		{
			if(!isdefined(value))
			{
				return 1;
			}
		}
		return 0;
	}
	return !isdefined(var_6d71e83a);
}

/*
	Name: function_dc51a40
	Namespace: namespace_509a75d1
	Checksum: 0x6A0E7BFB
	Offset: 0xED8
	Size: 0x9C
	Parameters: 2
	Flags: Linked
*/
function function_dc51a40(var_2a7487f4, str_key)
{
	var_5e997e7a = [];
	foreach(entity in var_2a7487f4)
	{
		var_5e997e7a[entity.(str_key)] = entity;
	}
	return var_5e997e7a;
}

/*
	Name: function_bffcedde
	Namespace: namespace_509a75d1
	Checksum: 0x807EF2CE
	Offset: 0xF80
	Size: 0x5A
	Parameters: 3
	Flags: Linked
*/
function function_bffcedde(var_4f07f125, var_3f89038a, var_333f876e)
{
	temp_array = getentarray(var_4f07f125, var_3f89038a);
	temp_array = function_dc51a40(temp_array, var_333f876e);
	return temp_array;
}

/*
	Name: function_2719d4c0
	Namespace: namespace_509a75d1
	Checksum: 0xE959D275
	Offset: 0xFE8
	Size: 0x5A
	Parameters: 3
	Flags: Linked
*/
function function_2719d4c0(var_4f07f125, var_3f89038a, var_333f876e)
{
	temp_array = struct::get_array(var_4f07f125, var_3f89038a);
	temp_array = function_dc51a40(temp_array, var_333f876e);
	return temp_array;
}

/*
	Name: get_player_index
	Namespace: namespace_509a75d1
	Checksum: 0x672F291
	Offset: 0x1050
	Size: 0x4A
	Parameters: 0
	Flags: None
*/
function get_player_index()
{
	for(i = 0; i < level.activeplayers.size; i++)
	{
		if(self == level.activeplayers[i])
		{
			return i;
		}
	}
}

/*
	Name: function_8bda2199
	Namespace: namespace_509a75d1
	Checksum: 0x531AA99F
	Offset: 0x10A8
	Size: 0x54
	Parameters: 1
	Flags: None
*/
function function_8bda2199(v_pos)
{
	a_ai_zombies = getaiteamarray(level.zombie_team);
	if(a_ai_zombies.size > 0)
	{
		return arraygetclosest(v_pos, a_ai_zombies);
	}
}

/*
	Name: function_e1015abd
	Namespace: namespace_509a75d1
	Checksum: 0xAAB8EFAD
	Offset: 0x1108
	Size: 0x52
	Parameters: 0
	Flags: None
*/
function function_e1015abd()
{
	v_angles = (randomfloatrange(0, 360), randomfloatrange(0, 360), 0);
	return anglestoforward(v_angles);
}

/*
	Name: function_b649cf93
	Namespace: namespace_509a75d1
	Checksum: 0x5DD9DAC
	Offset: 0x1168
	Size: 0x3A
	Parameters: 0
	Flags: Linked
*/
function function_b649cf93()
{
	v_angles = (0, randomfloatrange(0, 360), 0);
	return anglestoforward(v_angles);
}

/*
	Name: function_b2e1326
	Namespace: namespace_509a75d1
	Checksum: 0x21944E5
	Offset: 0x11B0
	Size: 0x20A
	Parameters: 2
	Flags: Linked
*/
function function_b2e1326(var_58df9892, var_1dc9c1bf = 1)
{
	switch(var_58df9892)
	{
		case 0:
		{
			self sethintstring(#"hash_2276db2c26ee907a");
			break;
		}
		case 1:
		{
			self sethintstring(#"hash_71158766520dc432");
			break;
		}
		case 2:
		{
			if(util::function_5df4294() == "zstandard")
			{
				if(function_8b1a219a())
				{
					self sethintstring(#"hash_61d85c966dd9e83f");
				}
				else
				{
					self sethintstring(#"hash_24a438482954901");
				}
			}
			else if(function_8b1a219a())
			{
				self sethintstring(#"hash_6e8ef1b690e98e51", var_1dc9c1bf);
			}
			else
			{
				self sethintstring(#"hash_23c1c09e94181fdb", var_1dc9c1bf);
			}
			break;
		}
		case 3:
		{
			self sethintstring(#"hash_39d080503c6a8d96");
			break;
		}
		case 4:
		{
			self sethintstring(#"hash_21db2780833a8bfd");
			break;
		}
	}
}

/*
	Name: function_fab5fb4d
	Namespace: namespace_509a75d1
	Checksum: 0x9F95758B
	Offset: 0x13C8
	Size: 0x6C
	Parameters: 2
	Flags: Linked
*/
function function_fab5fb4d(w_weapon, var_c4c6c433)
{
	if(isplayer(self))
	{
		var_1590457 = self aat::getaatonweapon(w_weapon, 1);
		if(var_1590457 === var_c4c6c433)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_69320b44
	Namespace: namespace_509a75d1
	Checksum: 0x1115E91A
	Offset: 0x1440
	Size: 0x52
	Parameters: 1
	Flags: None
*/
function function_69320b44(var_c4c6c433)
{
	e_player = (isdefined(self.attacker) ? self.attacker : self.eattacker);
	return e_player function_fab5fb4d(self.weapon, var_c4c6c433);
}

/*
	Name: function_7c15625f
	Namespace: namespace_509a75d1
	Checksum: 0xD5135B68
	Offset: 0x14A0
	Size: 0x58
	Parameters: 2
	Flags: None
*/
function function_7c15625f(str_fx, v_pos)
{
	fx_ent = util::spawn_model("tag_origin", v_pos);
	playfxontag(str_fx, fx_ent, "tag_origin");
	return fx_ent;
}

/*
	Name: function_91a84161
	Namespace: namespace_509a75d1
	Checksum: 0x9592A15C
	Offset: 0x1500
	Size: 0x104
	Parameters: 2
	Flags: None
*/
function function_91a84161(w_weapon, var_7966d557)
{
	if(var_7966d557 == 0)
	{
		self setweaponammostock(w_weapon, 0);
		self setweaponammoclip(w_weapon, 0);
	}
	else
	{
		n_clip_size = self function_f09c133d(w_weapon);
		if(var_7966d557 < n_clip_size)
		{
			self setweaponammostock(w_weapon, 0);
			self setweaponammoclip(w_weapon, var_7966d557);
		}
		else
		{
			var_69648877 = var_7966d557 - n_clip_size;
			self setweaponammostock(w_weapon, var_69648877);
			self setweaponammoclip(w_weapon, n_clip_size);
		}
	}
}

/*
	Name: function_2ba419ee
	Namespace: namespace_509a75d1
	Checksum: 0xFF5DFADC
	Offset: 0x1610
	Size: 0xDC
	Parameters: 2
	Flags: Linked
*/
function function_2ba419ee(var_53458a86 = 1, round = level.round_number)
{
	level.zombie_total = 0;
	level.zombie_health = zombie_utility::ai_calculate_health(zombie_utility::function_d2dfacfd(#"zombie_health_start"), round);
	namespace_a28acff3::set_round_number(round);
	level notify(#"kill_round");
	level zm_utility::function_9ad5aeb1(1, 1, 0, var_53458a86, 1);
}

/*
	Name: function_314447b
	Namespace: namespace_509a75d1
	Checksum: 0xA4D3E22A
	Offset: 0x16F8
	Size: 0xBC
	Parameters: 2
	Flags: Linked
*/
function function_314447b(b_pause = 1, var_53458a86 = 1)
{
	if(b_pause)
	{
		level.disable_nuke_delay_spawning = 1;
		level flag::clear("spawn_zombies");
		level zm_utility::function_9ad5aeb1(1, 1, 0, var_53458a86, 0);
	}
	else
	{
		level.disable_nuke_delay_spawning = 0;
		level flag::set("spawn_zombies");
	}
}

/*
	Name: function_3d636893
	Namespace: namespace_509a75d1
	Checksum: 0x4CFD9C00
	Offset: 0x17C0
	Size: 0x5A
	Parameters: 2
	Flags: None
*/
function function_3d636893(str_value, str_key = "targetname")
{
	a_ents = getentarray(str_value, str_key);
	return array::random(a_ents);
}

/*
	Name: function_4e7f5b2e
	Namespace: namespace_509a75d1
	Checksum: 0xF176F89F
	Offset: 0x1828
	Size: 0x5A
	Parameters: 2
	Flags: None
*/
function function_4e7f5b2e(str_value, str_key = "targetname")
{
	a_structs = struct::get_array(str_value, str_key);
	return array::random(a_structs);
}

/*
	Name: function_b8a27acc
	Namespace: namespace_509a75d1
	Checksum: 0x86343706
	Offset: 0x1890
	Size: 0xB4
	Parameters: 0
	Flags: None
*/
function function_b8a27acc()
{
	a_e_players = getplayers();
	foreach(e_player in a_e_players)
	{
		if(zm_utility::is_player_valid(e_player) && e_player istouching(self))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_6d41bab8
	Namespace: namespace_509a75d1
	Checksum: 0xFABEAD33
	Offset: 0x1950
	Size: 0xDC
	Parameters: 2
	Flags: Linked
*/
function function_6d41bab8(v_pos, n_radius)
{
	if(isdefined(v_pos))
	{
		v_drop_point = function_9cc082d2(v_pos, 64);
		if(isdefined(v_drop_point) && zm_utility::check_point_in_playable_area(v_drop_point[#"point"]))
		{
			return v_drop_point[#"point"];
		}
		if(!isdefined(v_drop_point) && isdefined(n_radius))
		{
			var_de3c569e = getclosestpointonnavmesh(v_pos, n_radius, 16);
			if(zm_utility::check_point_in_playable_area(var_de3c569e))
			{
				return var_de3c569e;
			}
		}
	}
}

/*
	Name: function_45bb11e4
	Namespace: namespace_509a75d1
	Checksum: 0x82E4B06B
	Offset: 0x1A38
	Size: 0x35C
	Parameters: 1
	Flags: Linked
*/
function function_45bb11e4(spot)
{
	self endon_callback(&zm_spawner::function_fe3cb19a, #"death");
	self.var_5535a47d = 1;
	self zm_spawner::function_fe3cb19a();
	self.mdl_anchor = util::spawn_model("tag_origin", self.origin, self.angles);
	self ghost();
	if(!isdefined(spot.angles))
	{
		spot.angles = (0, 0, 0);
	}
	self.mdl_anchor moveto(spot.origin, 0.05);
	self.mdl_anchor rotateto(spot.angles, 0.05);
	self.mdl_anchor waittill(#"movedone", #"death");
	waitframe(1);
	self.create_eyes = 1;
	self show();
	if(!isdefined(self.var_9ed3cc11))
	{
		self.var_9ed3cc11 = self function_e827fc0e();
	}
	self pushplayer(1);
	e_align = (isdefined(self.mdl_anchor) ? self.mdl_anchor : spot);
	str_shot_name = "default";
	if(isdefined(self.archetype))
	{
		switch(self.archetype)
		{
			case "nova_crawler":
			{
				str_shot_name = "nova_crawler";
				break;
			}
		}
	}
	if(str_shot_name == "default" && (self.has_legs === 0 || self.var_eb91c296 === 1))
	{
		str_shot_name = "crawler";
	}
	if(isinarray(scene::get_all_shot_names(spot.scriptbundlename), str_shot_name))
	{
		e_align scene::play(spot.scriptbundlename, str_shot_name, self);
	}
	else
	{
		e_align scene::play(spot.scriptbundlename, self);
	}
	if(isdefined(self.var_9ed3cc11))
	{
		self pushplayer(self.var_9ed3cc11);
		self.var_9ed3cc11 = undefined;
	}
	self.var_5535a47d = 0;
	self thread zm_spawner::function_2d97cae1();
	self notify(#"risen", spot.script_string);
	self zm_spawner::zombie_complete_emerging_into_playable_area();
}

/*
	Name: function_9258efe1
	Namespace: namespace_509a75d1
	Checksum: 0x2BC2F488
	Offset: 0x1DA0
	Size: 0xCA
	Parameters: 1
	Flags: Linked
*/
function function_9258efe1(str_zone)
{
	var_cb24ec97 = 1;
	foreach(e_player in getplayers())
	{
		var_bdf9e3c2 = e_player zm_zonemgr::get_player_zone();
		if(!isdefined(var_bdf9e3c2) || var_bdf9e3c2 != str_zone)
		{
			var_cb24ec97 = 0;
			break;
		}
	}
	return var_cb24ec97;
}

/*
	Name: any_player_in_zone
	Namespace: namespace_509a75d1
	Checksum: 0xF8F1CE12
	Offset: 0x1E78
	Size: 0xBA
	Parameters: 1
	Flags: Linked
*/
function any_player_in_zone(a_str_zones)
{
	if(isarray(a_str_zones))
	{
		foreach(str_zone in a_str_zones)
		{
			if(zm_zonemgr::any_player_in_zone(str_zone))
			{
				return 1;
			}
		}
		return 0;
	}
	return zm_zonemgr::any_player_in_zone(a_str_zones);
}

/*
	Name: function_f9b8c5b6
	Namespace: namespace_509a75d1
	Checksum: 0x940C440E
	Offset: 0x1F40
	Size: 0x4A
	Parameters: 2
	Flags: None
*/
function function_f9b8c5b6(array, key)
{
	a_keys = getarraykeys(array);
	return isinarray(a_keys, key);
}

/*
	Name: function_a496116d
	Namespace: namespace_509a75d1
	Checksum: 0x884E5C22
	Offset: 0x1F98
	Size: 0xBE
	Parameters: 2
	Flags: None
*/
function function_a496116d(e_player, n_cost)
{
	if(e_player zm_score::can_player_purchase(n_cost))
	{
		e_player zm_score::minus_to_player_score(n_cost);
		self zm_utility::play_sound_on_ent("purchase");
		return 1;
	}
	self zm_utility::play_sound_on_ent("no_purchase");
	e_player zm_audio::create_and_play_dialog(#"general", #"outofmoney");
	return 0;
}

/*
	Name: function_7a5ba111
	Namespace: namespace_509a75d1
	Checksum: 0x99F7CC09
	Offset: 0x2060
	Size: 0x26
	Parameters: 0
	Flags: Linked
*/
function function_7a5ba111()
{
	zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
	self.s_unitrigger = undefined;
}

/*
	Name: function_795d5b4f
	Namespace: namespace_509a75d1
	Checksum: 0x2F2395ED
	Offset: 0x2090
	Size: 0x120
	Parameters: 3
	Flags: Linked
*/
function function_795d5b4f(a_e_ents, v_pos, n_radius)
{
	n_radius_sqr = n_radius * n_radius;
	a_e_targets = [];
	foreach(e_ent in a_e_ents)
	{
		if(distancesquared(v_pos, e_ent.origin) <= n_radius_sqr)
		{
			if(!isdefined(a_e_targets))
			{
				a_e_targets = [];
			}
			else if(!isarray(a_e_targets))
			{
				a_e_targets = array(a_e_targets);
			}
			a_e_targets[a_e_targets.size] = e_ent;
		}
	}
	return a_e_targets;
}

/*
	Name: function_6099877a
	Namespace: namespace_509a75d1
	Checksum: 0x4AB8C1B0
	Offset: 0x21B8
	Size: 0x124
	Parameters: 4
	Flags: Linked
*/
function function_6099877a(n_radius = 96, str_endon, str_hint = "", var_a33304ba = "")
{
	s_unitrigger = self zm_unitrigger::function_a7620bfb(n_radius, 0);
	zm_unitrigger::unitrigger_set_hint_string(s_unitrigger, zm_utility::function_d6046228(str_hint, var_a33304ba));
	s_unitrigger.related_parent = self;
	zm_unitrigger::register_static_unitrigger(s_unitrigger, &function_715588b3);
	if(isdefined(str_endon))
	{
		level endon(str_endon);
		level thread function_f4482deb(s_unitrigger, str_endon);
	}
	s_unitrigger waittill(#"hash_4993ab35c53e0b5c");
}

/*
	Name: function_715588b3
	Namespace: namespace_509a75d1
	Checksum: 0x375D2B94
	Offset: 0x22E8
	Size: 0x22C
	Parameters: 0
	Flags: Linked
*/
function function_715588b3()
{
	self endon(#"death");
	while(true)
	{
		self waittill(#"trigger");
		var_3ba1f680 = 1;
		while(n_time < 0.5)
		{
			foreach(player in util::get_active_players())
			{
				if(player util::function_bf5a8f5c())
				{
					continue;
				}
				if(!player usebuttonpressed() || !zm_utility::can_use(player) || player isinmovemode("ufo", "noclip") || !player istouching(self))
				{
					var_3ba1f680 = 0;
					n_time = 0;
					break;
				}
			}
			if(var_3ba1f680 == 0 || util::get_active_players().size == 0)
			{
				break;
			}
			wait(0.1);
			n_time = n_time + 0.1;
		}
		if(var_3ba1f680 == 1)
		{
			break;
		}
		wait(0.1);
	}
	s_unitrigger notify(#"hash_4993ab35c53e0b5c");
	zm_unitrigger::unregister_unitrigger(s_unitrigger);
}

/*
	Name: function_f4482deb
	Namespace: namespace_509a75d1
	Checksum: 0xD461BA9F
	Offset: 0x2520
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function function_f4482deb(s_unitrigger, str_endon)
{
	s_unitrigger endon(#"hash_4993ab35c53e0b5c");
	level waittill(str_endon);
	zm_unitrigger::unregister_unitrigger(s_unitrigger);
}

/*
	Name: function_49dc915f
	Namespace: namespace_509a75d1
	Checksum: 0xBE41357E
	Offset: 0x2578
	Size: 0x74
	Parameters: 2
	Flags: None
*/
function function_49dc915f(n_distance, n_move_time)
{
	vector = anglestoforward(self.angles);
	vector = n_distance * vector;
	goal_pos = self.origin + vector;
	self moveto(goal_pos, n_move_time);
}

/*
	Name: function_5c1535d0
	Namespace: namespace_509a75d1
	Checksum: 0xF1E1A186
	Offset: 0x25F8
	Size: 0x74
	Parameters: 2
	Flags: None
*/
function function_5c1535d0(n_distance, n_move_time)
{
	vector = anglestoright(self.angles);
	vector = n_distance * vector;
	goal_pos = self.origin + vector;
	self moveto(goal_pos, n_move_time);
}

/*
	Name: function_dc4ab629
	Namespace: namespace_509a75d1
	Checksum: 0xB8BB6C0B
	Offset: 0x2678
	Size: 0x74
	Parameters: 2
	Flags: Linked
*/
function function_dc4ab629(n_distance, n_move_time)
{
	vector = anglestoup(self.angles);
	vector = n_distance * vector;
	goal_pos = self.origin + vector;
	self moveto(goal_pos, n_move_time);
}

/*
	Name: function_df67a12d
	Namespace: namespace_509a75d1
	Checksum: 0xCABF6D63
	Offset: 0x26F8
	Size: 0x1FC
	Parameters: 2
	Flags: Linked
*/
function function_df67a12d(category, subcategory)
{
	if(isdefined(level.sndplayervox) && isdefined(level.sndplayervox[category]))
	{
		if(!isdefined(level.var_e745455))
		{
			level.var_e745455 = [];
		}
		else if(!isarray(level.var_e745455))
		{
			level.var_e745455 = array(level.var_e745455);
		}
		if(isdefined(subcategory))
		{
			if(isdefined(level.sndplayervox[category][subcategory]))
			{
				if(!isdefined(level.var_e745455[category]))
				{
					level.var_e745455[category] = [];
				}
				else if(!isarray(level.var_e745455[category]))
				{
					level.var_e745455[category] = array(level.var_e745455[category]);
				}
				level.var_e745455[category][subcategory] = level.sndplayervox[category][subcategory];
				arrayremoveindex(level.sndplayervox[category], subcategory, 1);
			}
		}
		else
		{
			level.var_e745455[category] = arraycopy(level.sndplayervox[category]);
			arrayremoveindex(level.sndplayervox, category, 1);
		}
	}
}

/*
	Name: function_774b42ac
	Namespace: namespace_509a75d1
	Checksum: 0x35D37DE7
	Offset: 0x2900
	Size: 0x7E
	Parameters: 0
	Flags: None
*/
function function_774b42ac()
{
	/#
		while(true)
		{
			a_ents = getentarray();
			debug2dtext((5, 1055, 0), "" + a_ents.size, (0, 1, 0), 1, (0, 0, 0), 0.5, 1, 30);
			waitframe(30);
		}
	#/
}

/*
	Name: devgui
	Namespace: namespace_509a75d1
	Checksum: 0x634CA7C6
	Offset: 0x2988
	Size: 0x118
	Parameters: 0
	Flags: Private
*/
private function devgui()
{
	/#
		adddebugcommand("");
		while(true)
		{
			waitframe(1);
			str_command = getdvarstring(#"hash_6c7113bf98c41367", "");
			switch(str_command)
			{
				case "hash_770aa7ca60060a4d":
				{
					zm_devgui::zombie_devgui_goto_round(10);
					level flag::set(#"spawn_zombies");
					level flag::set(#"infinite_round_spawning");
					break;
				}
			}
			setdvar(#"hash_6c7113bf98c41367", "");
		}
	#/
}

/*
	Name: function_af49a1e9
	Namespace: namespace_509a75d1
	Checksum: 0x16EDC3A5
	Offset: 0x2AA8
	Size: 0x162
	Parameters: 4
	Flags: None
*/
function function_af49a1e9(str_event, var_8c7a21ea, var_7dc08477, var_b8eefad3)
{
	/#
		if(!isdefined(var_8c7a21ea))
		{
			var_8c7a21ea = "";
		}
		if(!isdefined(var_7dc08477))
		{
			var_7dc08477 = "";
		}
		if(!isdefined(var_b8eefad3))
		{
			var_b8eefad3 = "";
		}
		s_event = {#hash_b8eefad3:var_b8eefad3, #hash_7dc08477:var_7dc08477, #hash_8c7a21ea:var_8c7a21ea, #n_time:float(gettime()) / 1000, #str_event:str_event};
		if(!isdefined(level.var_df9f1a00))
		{
			level.var_df9f1a00 = [];
		}
		else if(!isarray(level.var_df9f1a00))
		{
			level.var_df9f1a00 = array(level.var_df9f1a00);
		}
		level.var_df9f1a00[level.var_df9f1a00.size] = s_event;
	#/
}

/*
	Name: function_df54cbcd
	Namespace: namespace_509a75d1
	Checksum: 0xBE4AC852
	Offset: 0x2C18
	Size: 0x74
	Parameters: 0
	Flags: None
*/
function function_df54cbcd()
{
	/#
		if(!isvehicle(self))
		{
			function_af49a1e9("", self.actor_id, function_9e72a96(self.archetype));
			self thread function_fc28e798();
		}
	#/
}

/*
	Name: function_86b062a6
	Namespace: namespace_509a75d1
	Checksum: 0xB9A58A5
	Offset: 0x2C98
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function function_86b062a6(s_params)
{
	/#
		str_event = "";
		if(self.var_c39323b5 === 1)
		{
			str_event = "";
		}
		function_af49a1e9(str_event, self.actor_id, function_9e72a96(self.archetype));
	#/
}

/*
	Name: function_acd2ba83
	Namespace: namespace_509a75d1
	Checksum: 0x42E011E
	Offset: 0x2D18
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function function_acd2ba83()
{
	/#
		function_af49a1e9("", level.round_number);
	#/
}

/*
	Name: function_84b292b4
	Namespace: namespace_509a75d1
	Checksum: 0xD8791726
	Offset: 0x2D50
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function function_84b292b4()
{
	/#
		level waittill(#"end_game");
		function_4eb5a6ad();
	#/
}

/*
	Name: function_fc28e798
	Namespace: namespace_509a75d1
	Checksum: 0xF4E9D1F2
	Offset: 0x2D88
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function function_fc28e798()
{
	/#
		self endon(#"death");
		self waittill(#"completed_emerging_into_playable_area");
		function_af49a1e9("", self.actor_id, function_9e72a96(self.archetype));
	#/
}

/*
	Name: function_4eb5a6ad
	Namespace: namespace_509a75d1
	Checksum: 0xF41CB744
	Offset: 0x2DF8
	Size: 0x1BC
	Parameters: 0
	Flags: None
*/
function function_4eb5a6ad()
{
	/#
		dir = "";
		filename = level.script + "" + getutc() + "";
		path = dir + "" + filename;
		file = openfile(path, "");
		fprintln(file, "");
		foreach(s_event in level.var_df9f1a00)
		{
			fprintln(file, s_event.n_time + "" + s_event.str_event + "" + s_event.var_8c7a21ea + "" + s_event.var_7dc08477 + "" + s_event.var_b8eefad3);
		}
		closefile(file);
		println("" + path);
	#/
}

