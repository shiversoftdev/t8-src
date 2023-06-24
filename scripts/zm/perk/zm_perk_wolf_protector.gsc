// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\visionset_mgr_shared.gsc;
#using scripts\zm_common\callbacks.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace zm_perk_wolf_protector;

/*
	Name: __init__system__
	Namespace: zm_perk_wolf_protector
	Checksum: 0x7A205F9E
	Offset: 0x200
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_wolf_protector", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_wolf_protector
	Checksum: 0x689D8AC6
	Offset: 0x248
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(getdvarint(#"hash_4e1190045ef3588b", 0))
	{
		function_27473e44();
	}
}

/*
	Name: function_27473e44
	Namespace: zm_perk_wolf_protector
	Checksum: 0x88565EC8
	Offset: 0x290
	Size: 0x20C
	Parameters: 0
	Flags: Linked
*/
function function_27473e44()
{
	if(function_8b1a219a())
	{
		zm_perks::register_perk_basic_info(#"specialty_wolf_protector", #"perk_wolf_protector", 3000, #"hash_4cacb949ec1378", getweapon("zombie_perk_bottle_wolf_protector"), getweapon("zombie_perk_totem_wolf_protector"), #"zmperkswolfprotector");
	}
	else
	{
		zm_perks::register_perk_basic_info(#"specialty_wolf_protector", #"perk_wolf_protector", 3000, #"hash_5b2099ef891bc954", getweapon("zombie_perk_bottle_wolf_protector"), getweapon("zombie_perk_totem_wolf_protector"), #"zmperkswolfprotector");
	}
	zm_perks::register_perk_clientfields(#"specialty_wolf_protector", &register_clientfield, &set_clientfield);
	zm_perks::register_perk_threads(#"specialty_wolf_protector", &give_perk, &take_perk, &function_9227a4d8);
	callback::on_ai_killed(&on_ai_killed);
	callback::on_ai_damage(&on_ai_damaged);
	callback::on_disconnect(&on_disconnect);
}

/*
	Name: register_clientfield
	Namespace: zm_perk_wolf_protector
	Checksum: 0x112BFB2
	Offset: 0x4A8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function register_clientfield()
{
	clientfield::register("actor", "wolf_protector_fx", 20000, 1, "int");
	clientfield::register("actor", "wolf_protector_spawn_fx", 20000, 1, "counter");
}

/*
	Name: set_clientfield
	Namespace: zm_perk_wolf_protector
	Checksum: 0x3BA939A4
	Offset: 0x518
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function set_clientfield(state)
{
}

/*
	Name: give_perk
	Namespace: zm_perk_wolf_protector
	Checksum: 0xCEAF2C06
	Offset: 0x530
	Size: 0x17E
	Parameters: 0
	Flags: Linked
*/
function give_perk()
{
	self endon(#"disconnect", #"specialty_wolf_protector" + "_take");
	self.var_7d46fb46 = zm_perks::function_c1efcc57(#"specialty_wolf_protector");
	if(isdefined(self.var_6577c75d) && self.var_6577c75d && isdefined(self.var_7d46fb46))
	{
		self zm_perks::function_2ac7579(self.var_7d46fb46, 2, #"perk_wolf_protector");
	}
	if(!isdefined(self.var_6577c75d))
	{
		self.var_6577c75d = 0;
	}
	if(!isdefined(self.var_815af0c3))
	{
		self.var_815af0c3 = 0;
	}
	if(!isdefined(self.var_f7a89869))
	{
		self.var_f7a89869 = 45;
	}
	if(!isdefined(self.var_f9d35f81))
	{
		self.var_f9d35f81 = 1;
	}
	if(!isdefined(self.var_9a054c95))
	{
		self.var_9a054c95 = 300;
	}
	if(!isdefined(self.var_669304d0))
	{
		self.var_669304d0 = 0;
	}
	if(!isdefined(self.var_2dc0d63c))
	{
		self.var_2dc0d63c = 0;
	}
	if(!isdefined(self.var_841cdb3))
	{
		self.var_841cdb3 = 0;
	}
}

/*
	Name: take_perk
	Namespace: zm_perk_wolf_protector
	Checksum: 0xA468BE0D
	Offset: 0x6B8
	Size: 0xC6
	Parameters: 4
	Flags: Linked
*/
function take_perk(b_pause, str_perk, str_result, n_slot)
{
	self notify(#"specialty_wolf_protector" + "_take");
	/#
		assert(isdefined(self.var_7d46fb46), "");
	#/
	self function_6d80c359();
	if(isdefined(self.var_7d46fb46))
	{
		self zm_perks::function_13880aa5(self.var_7d46fb46, 0, #"perk_wolf_protector");
		self.var_7d46fb46 = undefined;
	}
}

/*
	Name: on_ai_killed
	Namespace: zm_perk_wolf_protector
	Checksum: 0x93B4AD32
	Offset: 0x788
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function on_ai_killed(s_params)
{
	player = s_params.eattacker;
	if(isplayer(player) && player hasperk(#"specialty_wolf_protector") && player.var_6577c75d === 0 && player.var_815af0c3 === 0)
	{
		if(!player.var_669304d0)
		{
			player.var_841cdb3 = 1;
			player thread function_ce74ad2e();
			player thread function_f3cd6eac();
		}
		else
		{
			player.var_841cdb3++;
		}
	}
}

/*
	Name: on_ai_damaged
	Namespace: zm_perk_wolf_protector
	Checksum: 0xDE2B0C41
	Offset: 0x870
	Size: 0x142
	Parameters: 1
	Flags: Linked
*/
function on_ai_damaged(s_params)
{
	player = s_params.eattacker;
	if(isplayer(player) && player hasperk(#"specialty_wolf_protector") && isdefined(s_params.weapon) && player.var_6577c75d === 0 && player.var_815af0c3 === 0)
	{
		var_c7364922 = s_params.idamage;
		if(s_params.idamage > self.health)
		{
			var_c7364922 = self.health;
		}
		if(!player.var_669304d0)
		{
			player.var_2dc0d63c = var_c7364922;
			player.var_841cdb3 = 0;
			player thread function_ce74ad2e();
			player thread function_f3cd6eac();
		}
		else
		{
			player.var_2dc0d63c = player.var_2dc0d63c + var_c7364922;
		}
	}
}

/*
	Name: on_disconnect
	Namespace: zm_perk_wolf_protector
	Checksum: 0x8F7D8081
	Offset: 0x9C0
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function on_disconnect()
{
	self.var_815af0c3 = 0;
	if(isdefined(self.var_5e8ff98e))
	{
		self.var_5e8ff98e val::reset(#"wolf_protector", "takedamage");
		self.var_5e8ff98e clientfield::set("wolf_protector_fx", 0);
		self.var_5e8ff98e playsound(#"hash_55c72512f51a5e87");
		self.var_5e8ff98e thread util::delayed_delete(0.1);
	}
}

/*
	Name: function_ce74ad2e
	Namespace: zm_perk_wolf_protector
	Checksum: 0xB9193E6D
	Offset: 0xA80
	Size: 0xB6
	Parameters: 0
	Flags: Linked
*/
function function_ce74ad2e()
{
	self notify("7c799d117c563854");
	self endon("7c799d117c563854");
	level endon(#"end_game");
	self endon(#"death", #"disconnect", #"wolf_protector_spawn");
	self.var_669304d0 = 1;
	wait(4);
	if(self.var_2dc0d63c <= (level.zombie_health * 6) || self.var_841cdb3 <= 6)
	{
		self.var_669304d0 = 0;
	}
}

/*
	Name: function_f3cd6eac
	Namespace: zm_perk_wolf_protector
	Checksum: 0x3363B66F
	Offset: 0xB40
	Size: 0x16A
	Parameters: 0
	Flags: Linked
*/
function function_f3cd6eac()
{
	self endon(#"death", #"disconnect");
	self notify("695e9be7c8a2488a");
	self endon("695e9be7c8a2488a");
	while(self.var_669304d0)
	{
		waitframe(1);
		if(self.var_2dc0d63c >= (level.zombie_health * 6) || self.var_841cdb3 >= 6 && !isdefined(self.var_5e8ff98e) && !self scene::is_igc_active())
		{
			/#
				iprintlnbold("");
			#/
			self playsound(#"hash_7c5128882f070d07");
			self notify(#"wolf_protector_spawn");
			wait(1.5);
			if(zm_utility::is_player_valid(self, undefined, undefined, undefined, 0) && self hasperk(#"specialty_wolf_protector"))
			{
				self function_d0c6285a();
			}
			self.var_669304d0 = 0;
		}
	}
}

/*
	Name: function_562ade9e
	Namespace: zm_perk_wolf_protector
	Checksum: 0x61782E20
	Offset: 0xCB8
	Size: 0x8A
	Parameters: 0
	Flags: Linked
*/
function function_562ade9e()
{
	spawn_location = getclosestpointonnavmesh((anglestoforward(self.angles) * 100) + self.origin, 100);
	if(isdefined(spawn_location) && !is_in_playable_space(spawn_location))
	{
		spawn_location = function_d5b75a76(spawn_location);
	}
	return spawn_location;
}

/*
	Name: function_d0c6285a
	Namespace: zm_perk_wolf_protector
	Checksum: 0x79D45821
	Offset: 0xD50
	Size: 0x214
	Parameters: 0
	Flags: Linked
*/
function function_d0c6285a()
{
	self notify("28244f2ad3846403");
	self endon("28244f2ad3846403");
	spawn_pos = function_562ade9e();
	if(!isdefined(spawn_pos))
	{
		/#
			iprintlnbold("");
		#/
		return;
	}
	if(!isdefined(self.var_5e8ff98e))
	{
		ai = spawnactor(#"hash_3f174b9bcc408705", spawn_pos, self.angles, "wolf_protector", 1);
		if(isdefined(ai))
		{
			self.var_815af0c3 = 1;
			ai val::set(#"wolf_protector", "takedamage", 0);
			ai.player_owner = self;
			self.var_5e8ff98e = ai;
			ai clientfield::increment("wolf_protector_spawn_fx");
			ai thread clientfield::set("wolf_protector_fx", 1);
			ai ghost();
			wait(0.6);
			if(isdefined(ai))
			{
				ai show();
				ai spawn_shockwave();
				ai playsound(#"evt_wolf_protector_spawn");
				self thread function_163853f(self.var_f7a89869);
				ai thread zm_audio::zmbaivox_notifyconvert();
				ai thread zm_audio::play_ambient_zombie_vocals();
			}
		}
	}
}

/*
	Name: spawn_shockwave
	Namespace: zm_perk_wolf_protector
	Checksum: 0x7DA21D2D
	Offset: 0xF70
	Size: 0x130
	Parameters: 0
	Flags: Linked
*/
function spawn_shockwave()
{
	a_ai = getaiarray();
	a_aoe_ai = arraysortclosest(a_ai, self.origin, a_ai.size, 0, 200);
	foreach(ai in a_aoe_ai)
	{
		if(isactor(ai))
		{
			ai playsound(#"hash_22ff6701cf652785");
			ai.marked_for_recycle = 1;
			ai.has_been_damaged_by_player = 0;
			ai dodamage(ai.health + 1000, self.origin, self);
		}
	}
}

/*
	Name: is_in_playable_space
	Namespace: zm_perk_wolf_protector
	Checksum: 0x69408C0B
	Offset: 0x10A8
	Size: 0xE8
	Parameters: 1
	Flags: Linked
*/
function is_in_playable_space(pos)
{
	if(zm_utility::function_21f4ac36() && !isdefined(level.var_a2a9b2de))
	{
		level.var_a2a9b2de = getnodearray("player_region", "script_noteworthy");
	}
	if(isdefined(level.var_a2a9b2de))
	{
		node = undefined;
		if(isdefined(level.var_61afcb81))
		{
			node = function_52c1730(pos, level.var_a2a9b2de, level.var_61afcb81);
		}
		else
		{
			node = function_52c1730(pos, level.var_a2a9b2de, 500);
		}
		if(isdefined(node))
		{
			return true;
		}
		return false;
	}
}

/*
	Name: function_d5b75a76
	Namespace: zm_perk_wolf_protector
	Checksum: 0xDCE7ADC8
	Offset: 0x1198
	Size: 0x106
	Parameters: 1
	Flags: Linked
*/
function function_d5b75a76(pos)
{
	if(!zm_utility::function_21f4ac36() || !isdefined(level.var_a2a9b2de))
	{
		return undefined;
	}
	var_1a7af6f3 = arraysortclosest(level.var_a2a9b2de, pos);
	foreach(var_30d9be5a in var_1a7af6f3)
	{
		if(zm_zonemgr::zone_is_enabled(var_30d9be5a.targetname))
		{
			nd_closest = var_30d9be5a;
			break;
		}
	}
	if(!isdefined(nd_closest))
	{
		return undefined;
	}
	return nd_closest.origin;
}

/*
	Name: function_163853f
	Namespace: zm_perk_wolf_protector
	Checksum: 0x2F9A8795
	Offset: 0x12A8
	Size: 0xF4
	Parameters: 1
	Flags: Linked
*/
function function_163853f(var_e31f9259)
{
	self endon(#"disconnect", #"specialty_wolf_protector" + "_take");
	if(self hasperk(#"specialty_wolf_protector") && isdefined(self.var_7d46fb46))
	{
		self zm_perks::function_f0ac059f(self.var_7d46fb46, self.var_815af0c3, #"perk_wolf_protector");
	}
	self thread function_eb6d99d7(var_e31f9259);
	self waittilltimeout(var_e31f9259, #"scene_igc_shot_started", #"fake_death");
	self function_6d80c359();
}

/*
	Name: function_6d80c359
	Namespace: zm_perk_wolf_protector
	Checksum: 0x90B18A7E
	Offset: 0x13A8
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function function_6d80c359()
{
	self.var_815af0c3 = 0;
	if(isdefined(self.var_5e8ff98e))
	{
		self zm_perks::function_f0ac059f(self.var_7d46fb46, self.var_815af0c3, #"perk_dying_wish");
		self thread function_166fb685(self.var_9a054c95);
		self.var_5e8ff98e val::reset(#"wolf_protector", "takedamage");
		self.var_5e8ff98e clientfield::set("wolf_protector_fx", 0);
		self.var_5e8ff98e playsound(#"hash_55c72512f51a5e87");
		self.var_5e8ff98e thread util::delayed_delete(0.1);
	}
}

/*
	Name: function_eb6d99d7
	Namespace: zm_perk_wolf_protector
	Checksum: 0xDD509EBD
	Offset: 0x14B8
	Size: 0x170
	Parameters: 1
	Flags: Linked
*/
function function_eb6d99d7(var_1483b30b)
{
	self endon(#"disconnect", #"specialty_wolf_protector" + "_take", #"scene_igc_shot_started");
	n_time_left = var_1483b30b;
	self zm_perks::function_13880aa5(self.var_7d46fb46, 1, #"perk_wolf_protector");
	while(n_time_left > 0)
	{
		wait(0.1);
		n_time_left = n_time_left - 0.1;
		n_time_left = math::clamp(n_time_left, 0, var_1483b30b);
		n_percentage = n_time_left / var_1483b30b;
		n_percentage = math::clamp(n_percentage, 0.02, var_1483b30b);
		if(self hasperk(#"specialty_wolf_protector") && isdefined(self.var_7d46fb46))
		{
			self zm_perks::function_13880aa5(self.var_7d46fb46, n_percentage, #"perk_wolf_protector");
		}
	}
}

/*
	Name: function_166fb685
	Namespace: zm_perk_wolf_protector
	Checksum: 0xFCFDD3C1
	Offset: 0x1630
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function function_166fb685(var_85dcb56c)
{
	self endon(#"hash_7c5d9af32e10c147", #"disconnect");
	self.var_6577c75d = 1;
	if(self hasperk(#"specialty_wolf_protector") && isdefined(self.var_7d46fb46))
	{
		self zm_perks::function_2ac7579(self.var_7d46fb46, 2, #"perk_wolf_protector");
	}
	self thread function_7d72c6f9(var_85dcb56c);
	wait(var_85dcb56c);
	self thread function_9227a4d8();
}

/*
	Name: function_7d72c6f9
	Namespace: zm_perk_wolf_protector
	Checksum: 0x82F10CB7
	Offset: 0x1708
	Size: 0x160
	Parameters: 1
	Flags: Linked
*/
function function_7d72c6f9(var_85dcb56c)
{
	self endon(#"disconnect", #"hash_7c5d9af32e10c147");
	self.var_72c60d5 = var_85dcb56c;
	self zm_perks::function_13880aa5(self.var_7d46fb46, 0, #"perk_wolf_protector");
	while(true)
	{
		wait(0.1);
		self.var_72c60d5 = self.var_72c60d5 - 0.1;
		self.var_72c60d5 = math::clamp(self.var_72c60d5, 0, var_85dcb56c);
		n_percentage = 1 - (self.var_72c60d5 / var_85dcb56c);
		n_percentage = math::clamp(n_percentage, 0.02, var_85dcb56c);
		if(self hasperk(#"specialty_wolf_protector") && isdefined(self.var_7d46fb46))
		{
			self zm_perks::function_13880aa5(self.var_7d46fb46, n_percentage, #"perk_wolf_protector");
		}
	}
}

/*
	Name: function_9227a4d8
	Namespace: zm_perk_wolf_protector
	Checksum: 0x5A631471
	Offset: 0x1870
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function function_9227a4d8()
{
	self notify(#"hash_7c5d9af32e10c147");
	self.var_6577c75d = 0;
	if(self hasperk(#"specialty_wolf_protector"))
	{
		/#
			assert(isdefined(self.var_7d46fb46), "");
		#/
		if(isdefined(self.var_7d46fb46))
		{
			self zm_perks::function_2ac7579(self.var_7d46fb46, 1, #"perk_wolf_protector");
			self zm_perks::function_13880aa5(self.var_7d46fb46, 1, #"perk_wolf_protector");
		}
	}
}

