// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_3f9e0dc8454d98e1;
#using script_58c342edd81589fb;
#using script_5bb072c3abf4652c;
#using script_6021ce59143452c3;
#using script_6c5b51f98cd04fa3;
#using script_b52a163973f339f;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\music_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace zm_audio;

/*
	Name: function_89f2df9
	Namespace: zm_audio
	Checksum: 0xE5EBCEE6
	Offset: 0x4E8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_audio", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_audio
	Checksum: 0x4C25D738
	Offset: 0x530
	Size: 0x15C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("allplayers", "charindex", 1, 4, "int");
	clientfield::register("toplayer", "isspeaking", 1, 1, "int");
	/#
		println("");
	#/
	level zmbvox();
	callback::on_connect(&init_audio_functions);
	callback::on_ai_spawned(&function_198818fe);
	callback::on_ai_killed(&ai_killed);
	level thread sndannouncer_init();
	level thread function_2c31a0a6();
	level thread function_aa7d1d97();
	/#
		level thread function_cb26577a();
	#/
}

/*
	Name: ai_killed
	Namespace: zm_audio
	Checksum: 0x2C7BF9C5
	Offset: 0x698
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function ai_killed(s_params)
{
	self thread player_zombie_kill_vox(s_params);
}

/*
	Name: function_198818fe
	Namespace: zm_audio
	Checksum: 0x534339
	Offset: 0x6C8
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_198818fe()
{
	if(isdefined(self.archetype))
	{
		switch(self.archetype)
		{
			case "brutus":
			{
				n_delay = 5;
				break;
			}
		}
	}
	if(function_63f85f39(self.var_9fde8624))
	{
		function_ef9ba49c(self.var_9fde8624, n_delay);
	}
	if(function_63f85f39(self.archetype))
	{
		function_ef9ba49c(self.archetype, n_delay);
	}
}

/*
	Name: setexertvoice
	Namespace: zm_audio
	Checksum: 0x9C5636E1
	Offset: 0x790
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function setexertvoice(exert_id)
{
	self.player_exert_id = exert_id;
	self clientfield::set("charindex", self.player_exert_id);
}

/*
	Name: playerexert
	Namespace: zm_audio
	Checksum: 0xA4CE29D3
	Offset: 0x7D8
	Size: 0x20C
	Parameters: 2
	Flags: Linked
*/
function playerexert(exert, notifywait = 0)
{
	if(isdefined(self.isspeaking) && self.isspeaking || (isdefined(self.isexerting) && self.isexerting))
	{
		return;
	}
	if(isdefined(self.beastmode) && self.beastmode)
	{
		return;
	}
	self endon(#"disconnect");
	id = level.exert_sounds[0][exert];
	if(isdefined(self.player_exert_id))
	{
		if(!isdefined(level.exert_sounds) || !isdefined(level.exert_sounds[self.player_exert_id]) || !isdefined(level.exert_sounds[self.player_exert_id][exert]))
		{
			return;
		}
		if(isarray(level.exert_sounds[self.player_exert_id][exert]))
		{
			id = array::random(level.exert_sounds[self.player_exert_id][exert]);
		}
		else
		{
			id = level.exert_sounds[self.player_exert_id][exert];
		}
	}
	if(isdefined(id))
	{
		self.isexerting = 1;
		if(notifywait)
		{
			self playsoundwithnotify(id, "done_exerting");
			self waittill(#"done_exerting");
			if(isdefined(self))
			{
				self.isexerting = 0;
			}
		}
		else
		{
			self thread exert_timer();
			self playsound(id);
		}
	}
}

/*
	Name: exert_timer
	Namespace: zm_audio
	Checksum: 0xB898381A
	Offset: 0x9F0
	Size: 0x3E
	Parameters: 0
	Flags: Linked
*/
function exert_timer()
{
	self endon(#"disconnect");
	wait(randomfloatrange(1.5, 3));
	self.isexerting = 0;
}

/*
	Name: zmbvox
	Namespace: zm_audio
	Checksum: 0x401FAAF6
	Offset: 0xA38
	Size: 0x164
	Parameters: 0
	Flags: Linked
*/
function zmbvox()
{
	level.votimer = [];
	level.vox = zmbvoxcreate();
	if(isdefined(level._zmbvoxlevelspecific))
	{
		level thread [[level._zmbvoxlevelspecific]]();
	}
	if(isdefined(level._zmbvoxgametypespecific))
	{
		level thread [[level._zmbvoxgametypespecific]]();
	}
	announcer_ent = spawn("script_origin", (0, 0, 0));
	level.vox zmbvoxinitspeaker("announcer", "vox_zmba_", announcer_ent);
	level.exert_sounds[0][#"burp"] = "evt_belch";
	level.exert_sounds[0][#"hitmed"] = "null";
	level.exert_sounds[0][#"hitlrg"] = "null";
	if(isdefined(level.setupcustomcharacterexerts))
	{
		[[level.setupcustomcharacterexerts]]();
	}
}

/*
	Name: init_audio_functions
	Namespace: zm_audio
	Checksum: 0x2AEB426A
	Offset: 0xBA8
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function init_audio_functions()
{
	self.isspeaking = 0;
	function_654ec86b();
	self thread zombie_behind_vox();
	self thread player_killstreak_timer();
	self thread water_vox();
	if(isdefined(level._custom_zombie_oh_shit_vox_func))
	{
		self thread [[level._custom_zombie_oh_shit_vox_func]]();
	}
	else
	{
		self thread oh_shit_vox();
	}
}

/*
	Name: oh_shit_vox
	Namespace: zm_audio
	Checksum: 0x78B2361D
	Offset: 0xC60
	Size: 0x2CE
	Parameters: 0
	Flags: Linked
*/
function oh_shit_vox()
{
	self endon(#"death");
	while(true)
	{
		wait(1);
		a_ai_enemies = getaiteamarray(level.zombie_team);
		players = getplayers();
		if(players.size == 0)
		{
			continue;
		}
		var_d49b32f7 = 0;
		for(i = 0; i < a_ai_enemies.size; i++)
		{
			if(isdefined(a_ai_enemies[i].favoriteenemy) && a_ai_enemies[i].favoriteenemy == self || !isdefined(a_ai_enemies[i].favoriteenemy))
			{
				if(distancesquared(a_ai_enemies[i].origin, self.origin) < 250 * 250)
				{
					var_d49b32f7++;
				}
			}
		}
		if(var_d49b32f7 > 9)
		{
			if(math::cointoss() && players.size > 1)
			{
				foreach(e_player in players)
				{
					if(!isdefined(e_player))
					{
						continue;
					}
					if(self != e_player && sighttracepassed(self.origin + vectorscale((0, 0, 1), 30), e_player.origin + vectorscale((0, 0, 1), 30), 0, undefined))
					{
						e_player create_and_play_dialog(#"surrounded", #"hash_2cfacc18d3ecb7ad" + self zm_vo::function_82f9bc9f());
						continue;
					}
				}
			}
			else
			{
				self create_and_play_dialog(#"surrounded", #"self");
			}
			wait(4);
		}
	}
}

/*
	Name: function_2c31a0a6
	Namespace: zm_audio
	Checksum: 0xB0F5D904
	Offset: 0xF38
	Size: 0xA6
	Parameters: 0
	Flags: Linked
*/
function function_2c31a0a6()
{
	level endon(#"game_over");
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(#"hash_5198ca6a3343ece8");
		if(isplayer(waitresult.player))
		{
			waitresult.player create_and_play_dialog(#"general", #"crawl_spawn");
			wait(1);
		}
	}
}

/*
	Name: function_aa7d1d97
	Namespace: zm_audio
	Checksum: 0xF4119D2D
	Offset: 0xFE8
	Size: 0x140
	Parameters: 0
	Flags: Linked
*/
function function_aa7d1d97()
{
	level endon(#"game_over");
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(#"gib");
		if(level.round_number > 3)
		{
			return;
		}
		if(isplayer(waitresult.attacker))
		{
			if(isalive(waitresult.entity))
			{
				if(waitresult.area === "left_arm" || waitresult.area === "right_arm")
				{
					if(waitresult.entity.damageweapon !== getweapon(#"hash_42a45d43be3dba42"))
					{
						waitresult.attacker create_and_play_dialog(#"general", #"gib");
					}
				}
			}
		}
	}
}

/*
	Name: player_killstreak_timer
	Namespace: zm_audio
	Checksum: 0x3249B4E9
	Offset: 0x1130
	Size: 0x260
	Parameters: 0
	Flags: Linked
*/
function player_killstreak_timer()
{
	self endon(#"disconnect", #"death");
	if(getdvarstring(#"zombie_kills") == "")
	{
		setdvar(#"zombie_kills", 8);
	}
	if(getdvarstring(#"zombie_kill_timer") == "")
	{
		setdvar(#"zombie_kill_timer", 6);
	}
	kills = getdvarint(#"zombie_kills", 0);
	time = getdvarint(#"zombie_kill_timer", 0);
	if(!isdefined(self.timerisrunning))
	{
		self.timerisrunning = 0;
		self.killcounter = 0;
	}
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"zom_kill");
		zomb = waitresult.zombie;
		if(isdefined(zomb._black_hole_bomb_collapse_death) && zomb._black_hole_bomb_collapse_death == 1)
		{
			continue;
		}
		if(isdefined(zomb.microwavegun_death) && zomb.microwavegun_death)
		{
			continue;
		}
		if(zm_loadout::is_hero_weapon(zomb.damageweapon))
		{
			continue;
		}
		if(zomb.damagemod === "MOD_UNKNOWN")
		{
			continue;
		}
		self.killcounter++;
		if(self.timerisrunning != 1)
		{
			self.timerisrunning = 1;
			self thread timer_actual(kills, time);
		}
	}
}

/*
	Name: player_zombie_kill_vox
	Namespace: zm_audio
	Checksum: 0xEE4CA9A5
	Offset: 0x1398
	Size: 0x1E4
	Parameters: 1
	Flags: Linked
*/
function player_zombie_kill_vox(params)
{
	death = undefined;
	player = undefined;
	if(isstring(params) || function_7a600918(params))
	{
		death = params;
		player = self;
	}
	else if(isstruct(params))
	{
		player = params.eattacker;
		zombie = self;
		if(!isplayer(player))
		{
			return;
		}
		death = function_bb6bf99c(zombie);
		if(!isdefined(death))
		{
			instakill = player zm_powerups::is_insta_kill_active();
			dist = distancesquared(player.origin, zombie.origin);
			death = function_d412c3a8(params.shitloc, params.smeansofdeath, params.weapon, zombie, instakill, dist, player);
		}
	}
	if(isdefined(death))
	{
		player endon(#"death");
		b_played = player create_and_play_dialog(#"kill", death);
		if(isdefined(b_played) && b_played)
		{
			player function_dd19aefa(death);
		}
	}
}

/*
	Name: function_dd19aefa
	Namespace: zm_audio
	Checksum: 0xBC73240A
	Offset: 0x1588
	Size: 0x164
	Parameters: 1
	Flags: Linked
*/
function function_dd19aefa(death)
{
	var_bff0cf99 = death + "_" + self zm_vo::function_82f9bc9f();
	if(!function_63f85f39(#"kill", var_bff0cf99))
	{
		return;
	}
	e_speaker = undefined;
	var_a841b5f1 = array::randomize(zm_vo::function_347f7d34());
	foreach(e_player in var_a841b5f1)
	{
		if(e_player != self && zm_vo::function_5c82f986(e_player, self))
		{
			e_speaker = e_player;
			break;
		}
	}
	if(isdefined(e_speaker))
	{
		e_speaker create_and_play_dialog(#"kill", var_bff0cf99, undefined, 1);
	}
}

/*
	Name: function_d412c3a8
	Namespace: zm_audio
	Checksum: 0x1B1ED2EB
	Offset: 0x16F8
	Size: 0x334
	Parameters: 7
	Flags: Linked
*/
function function_d412c3a8(impact, mod, weapon, zombie, instakill, dist, player)
{
	close_dist = 4096;
	med_dist = 15376;
	far_dist = 160000;
	if(!isdefined(level.var_d2ed4be7))
	{
		level.var_d2ed4be7 = array();
	}
	str_weapon = function_350fc8cc(weapon, zombie, mod, player);
	if(isdefined(str_weapon))
	{
		return (str_weapon == #"novox" ? undefined : str_weapon);
	}
	if(isdefined(weapon.isheroweapon) && weapon.isheroweapon)
	{
		return;
	}
	if(level flag::get("special_round") && !isinarray(level.var_d2ed4be7, zombie.archetype))
	{
		return "specialround";
	}
	if(zombie.archetype === #"zombie_dog")
	{
		return;
	}
	if(mod != "MOD_BURNED")
	{
		if(dist < close_dist)
		{
			if(player.health < player.maxhealth && isdefined(player.lastdamagetime) && gettime() - player.lastdamagetime < 1500)
			{
				return "revenge";
			}
			return "close";
		}
	}
	if(zombie.archetype === #"zombie")
	{
		if(mod == "MOD_MELEE")
		{
			return #"melee";
		}
		if(isdefined(zombie.missinglegs) && zombie.missinglegs)
		{
			return "crawler";
		}
	}
	if(zombie zm_utility::is_headshot(weapon, impact, mod, 0) && dist >= far_dist)
	{
		return "headshot";
	}
	if(instakill)
	{
		return "weapon_instakill";
	}
	if(!(isdefined(zombie.is_on_fire) && zombie.is_on_fire))
	{
		if(zm_utility::is_explosive_damage(mod))
		{
			if(function_e17d0760(weapon))
			{
				return "explosive";
			}
		}
	}
	if(mod == "MOD_RIFLE_BULLET" || mod == "MOD_PISTOL_BULLET")
	{
		return "bullet";
	}
}

/*
	Name: function_e17d0760
	Namespace: zm_audio
	Checksum: 0x131398E5
	Offset: 0x1A38
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function function_e17d0760(weapon)
{
	return isdefined(weapon.islauncher) && weapon.islauncher || zm_loadout::is_lethal_grenade(weapon) || zm_loadout::is_tactical_grenade(weapon) || zm_loadout::is_placeable_mine(weapon) || zm_equipment::is_equipment(weapon);
}

/*
	Name: function_bb6bf99c
	Namespace: zm_audio
	Checksum: 0xC07E3571
	Offset: 0x1AD0
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function function_bb6bf99c(ai)
{
	if(isdefined(ai.var_9fde8624) && function_63f85f39("kill", ai.var_9fde8624))
	{
		return ai.var_9fde8624;
	}
	if(isdefined(ai.archetype) && function_63f85f39("kill", ai.archetype))
	{
		return ai.archetype;
	}
}

/*
	Name: function_350fc8cc
	Namespace: zm_audio
	Checksum: 0x4D08CD1E
	Offset: 0x1B70
	Size: 0x95C
	Parameters: 4
	Flags: Linked
*/
function function_350fc8cc(weapon, zombie, mod, player)
{
	str_weapon = undefined;
	if(!isdefined(zombie.damageweapon))
	{
		return undefined;
	}
	if(weapon.name == zombie.damageweapon.name)
	{
		if(isdefined(weapon.isheroweapon) && weapon.isheroweapon)
		{
			str_weapon_name = function_fa4dfde0(weapon);
			if(!isdefined(str_weapon_name))
			{
				str_weapon = undefined;
			}
			str_weapon = str_weapon_name;
			return str_weapon;
			return #"novox";
			break;
			return #"novox";
			break;
			return #"novox";
			return str_weapon;
			break;
			return #"novox";
			break;
			return str_weapon;
			return #"novox";
			break;
			return str_weapon;
			return #"novox";
			break;
			return str_weapon;
			str_weapon = #"hash_67fe90358e2cb4a8";
			return #"novox";
			return #"novox";
			str_weapon = #"sword";
			return #"novox";
			return #"novox";
			str_weapon = #"pistol";
		}
		str_weapon = #"raygun";
		break;
		str_weapon = #"hash_34540a6bb099133e";
		break;
		str_weapon = #"hash_24c829c980982c1";
		break;
		str_weapon = #"thundergun";
		str_weapon = #"no_vox";
		break;
		str_weapon = #"tundragun";
		str_weapon = #"no_vox";
		break;
		break;
		str_weapon = #"wonder";
		str_weapon = level thread [[level.var_45b0f2f3]](weapon.name);
	}
	else
	{
		switch(weapon.name)
		{
			case "minigun":
			{
				if(mod == "MOD_RIFLE_BULLET" && player function_6049efce(str_weapon))
				{
				}
				else
				{
				}
			}
			case "scepter":
			{
				if(!(isdefined(zombie.var_4857363e) && zombie.var_4857363e))
				{
				}
			}
			case "flamethrower":
			{
				if(mod == "MOD_IMPACT")
				{
				}
				else if(mod == "MOD_BURNED" && (!(isdefined(zombie.var_d9e7a08a) && zombie.var_d9e7a08a)) && player function_6049efce(str_weapon))
				{
				}
			}
			case "gravityspikes":
			{
				if(!(isdefined(zombie.var_46d39f48) && zombie.var_46d39f48))
				{
				}
			}
			case "katana":
			{
				if(mod == "MOD_MELEE" && !player flagsys::get("katana_dash") && player function_6049efce(str_weapon))
				{
				}
				else
				{
				}
			}
			case "hammer":
			{
				if(mod == "MOD_MELEE")
				{
					if(player function_6049efce(str_weapon))
					{
					}
					else
					{
					}
				}
			}
		}
		if(function_d2429d4f(str_weapon))
		{
			if(player function_6049efce(str_weapon))
			{
			}
		}
		if(str_weapon == #"chakram")
		{
			if(isdefined(player) && (isdefined(player.var_fbe120be) && player.var_fbe120be))
			{
				if(player function_6049efce(str_weapon, 3, 0.75))
				{
				}
				else
				{
				}
			}
			else
			{
			}
		}
		if(str_weapon == #"sword_pistol")
		{
			if(mod == "MOD_MELEE")
			{
				if(player function_6049efce(str_weapon))
				{
				}
				else
				{
				}
			}
			else if(mod == "MOD_UNKNOWN" || mod == "MOD_PROJECTILE" || (isdefined(zombie.var_8c8102a5) && zombie.var_8c8102a5))
			{
			}
			if(player function_6049efce(str_weapon))
			{
			}
		}
		else if(zm_weapons::is_wonder_weapon(weapon))
		{
			switch(str_weapon)
			{
				case "ray_gun_upgraded":
				case "ray_gun":
				{
					if(player function_6049efce(weapon.name))
					{
					}
				}
				case "ray_gun_mk2":
				case "ray_gun_mk2_upgraded":
				{
					if(player function_6049efce(weapon.name))
					{
					}
				}
				case "ww_tesla_sniper_t8":
				{
					if(player function_6049efce(weapon.name))
					{
					}
				}
				case "thundergun":
				{
					if(player function_6049efce(weapon.name))
					{
					}
					else
					{
					}
				}
				case "tundragun":
				{
					if(player function_6049efce(weapon.name))
					{
					}
					else
					{
					}
				}
				case "hash_2605a6745df58840":
				{
					if(zombie.archetype === #"zombie_dog")
					{
					}
				}
				default:
				{
				}
			}
		}
		if(!isdefined(str_weapon))
		{
			if(isdefined(level.var_45b0f2f3))
			{
			}
		}
		if(isdefined(str_weapon))
		{
			return str_weapon;
		}
		switch(zombie.damageweapon.name)
		{
			case "hash_10f614b278daaebc":
			case "cymbal_monkey":
			{
				str_weapon = #"hash_10f614b278daaebc";
				break;
			}
			case "bowie_knife_story_1":
			case "bowie_knife":
			case "knife":
			{
				str_weapon = #"melee";
				break;
			}
			case "hash_3882e337d28ec4df":
			case "special_ballisticknife_t8_dw":
			{
				if(mod == "MOD_MELEE")
				{
					str_weapon = #"melee";
				}
				else
				{
					str_weapon = #"ballistic";
				}
				break;
			}
			case "galvaknuckles_t8":
			{
				str_weapon = #"galva";
				break;
			}
			case "hash_c78156ba6aeda14":
			case "hash_23dd6039fe2f36c6":
			case "hash_308049a67e5afecf":
			case "hash_55a4aa4a1077e2cc":
			case "eq_molotov":
			case "hash_6cb687e3f8c569fd":
			{
				str_weapon = #"molotov";
				break;
			}
			case "mini_turret":
			{
				str_weapon = undefined;
				break;
			}
		}
		if(!isdefined(str_weapon))
		{
			if(isdefined(level.var_45b0f2f3))
			{
				str_weapon = level thread [[level.var_45b0f2f3]](zombie.damageweapon.name);
			}
		}
		return str_weapon;
	}
}

/*
	Name: function_cb8103f6
	Namespace: zm_audio
	Checksum: 0x58EC2F4D
	Offset: 0x24D8
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_cb8103f6(w_weapon)
{
	str_weapon_name = function_fa4dfde0(w_weapon);
	if(isdefined(str_weapon_name))
	{
		self thread create_and_play_dialog(#"hero_activate", str_weapon_name);
	}
}

/*
	Name: function_2d93d659
	Namespace: zm_audio
	Checksum: 0x79C04ED3
	Offset: 0x2540
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function function_2d93d659(w_weapon)
{
	if(!isdefined(self.var_8095a228))
	{
		self.var_8095a228 = 0;
	}
	str_weapon_name = function_fa4dfde0(w_weapon);
	n_variant = self.var_72d6f15d;
	if(isdefined(str_weapon_name) && isdefined(n_variant))
	{
		if(self.var_8095a228 === n_variant)
		{
			self.var_8095a228++;
			self thread create_and_play_dialog(#"hash_14214c4848ae30d9", str_weapon_name, n_variant, 1, #"hash_2eed9998dba1b252");
		}
	}
}

/*
	Name: function_fa4dfde0
	Namespace: zm_audio
	Checksum: 0x72E2B6A5
	Offset: 0x2608
	Size: 0x222
	Parameters: 1
	Flags: Linked
*/
function function_fa4dfde0(w_weapon)
{
	switch(w_weapon.name)
	{
		case "hash_50f35c4cfb775a9c":
		case "hash_50f35d4cfb775c4f":
		case "hash_50f35e4cfb775e02":
		{
			return #"scepter";
		}
		case "hero_hammer_lv3":
		case "hero_hammer_lv2":
		case "hero_hammer_lv1":
		{
			return #"hammer";
		}
		case "hero_chakram_lv2":
		case "hero_chakram_lv3":
		case "hero_chakram_lv1":
		{
			return #"chakram";
		}
		case "hero_sword_pistol_lv2":
		case "hero_sword_pistol_lv3":
		case "hero_sword_pistol_lv1":
		{
			return #"sword_pistol";
		}
		case "hash_18829d56b3fbd75b":
		case "hash_18829e56b3fbd90e":
		case "hash_18829f56b3fbdac1":
		{
			return #"flamethrower";
		}
		case "hash_74dd67dd8a46d144":
		case "hash_74dd69dd8a46d4aa":
		case "hash_74dd6add8a46d65d":
		{
			return #"minigun";
		}
		case "hash_6627879099b8a337":
		case "hash_6627889099b8a4ea":
		case "hash_6627899099b8a69d":
		{
			return #"katana";
		}
		case "hash_1d3a5309fa2c9b80":
		case "hash_1d3a5409fa2c9d33":
		case "hash_1d3a5509fa2c9ee6":
		{
			return #"gravityspikes";
		}
	}
}

/*
	Name: function_6049efce
	Namespace: zm_audio
	Checksum: 0xE7A1BCCA
	Offset: 0x2838
	Size: 0x6A
	Parameters: 3
	Flags: Linked
*/
function function_6049efce(weapon, n_kill_count = 10, var_b0f9afde = 6)
{
	self thread function_7ea301dd(weapon, var_b0f9afde);
	return function_f9928a31(weapon, n_kill_count);
}

/*
	Name: function_7ea301dd
	Namespace: zm_audio
	Checksum: 0xDAF72151
	Offset: 0x28B0
	Size: 0xFA
	Parameters: 2
	Flags: Linked
*/
function function_7ea301dd(weapon, var_b0f9afde = 6)
{
	self notify(weapon + "sndMultiKillTracker");
	self endon(weapon + "sndMultiKillTracker", #"death");
	if(!isdefined(self.var_4cbaf28d))
	{
		self.var_4cbaf28d = [];
	}
	else if(!isarray(self.var_4cbaf28d))
	{
		self.var_4cbaf28d = array(self.var_4cbaf28d);
	}
	if(!isdefined(self.var_4cbaf28d[weapon]))
	{
		self.var_4cbaf28d[weapon] = 0;
	}
	self.var_4cbaf28d[weapon]++;
	wait(var_b0f9afde);
	self.var_4cbaf28d[weapon] = 0;
}

/*
	Name: function_f9928a31
	Namespace: zm_audio
	Checksum: 0xF4572A2A
	Offset: 0x29B8
	Size: 0x66
	Parameters: 2
	Flags: Linked
*/
function function_f9928a31(weapon, n_kill_count = 6)
{
	if(self.var_4cbaf28d[weapon] >= n_kill_count)
	{
		self notify(weapon + "sndMultiKillTracker");
		self.var_4cbaf28d[weapon] = 0;
		return 1;
	}
	return 0;
}

/*
	Name: function_d2429d4f
	Namespace: zm_audio
	Checksum: 0x708AAC80
	Offset: 0x2A28
	Size: 0x7E
	Parameters: 1
	Flags: Linked
*/
function function_d2429d4f(str_weapon)
{
	var_300d3c47 = 0;
	switch(str_weapon)
	{
		case "gravityspikes":
		case "flamethrower":
		case "katana":
		case "minigun":
		{
			var_300d3c47 = 1;
			break;
		}
	}
	return var_300d3c47;
}

/*
	Name: timer_actual
	Namespace: zm_audio
	Checksum: 0x1E4BC813
	Offset: 0x2AB0
	Size: 0x22A
	Parameters: 2
	Flags: Linked
*/
function timer_actual(kills, time)
{
	self endon(#"disconnect", #"death");
	timer = gettime() + time * 1000;
	while(gettime() < timer)
	{
		if(self.killcounter > kills)
		{
			if(math::cointoss() && level.players.size > 1 && isdefined(self.var_eee02beb))
			{
				players = getplayers();
				foreach(e_player in players)
				{
					if(!isdefined(e_player))
					{
						continue;
					}
					if(self != e_player && sighttracepassed(self.origin + vectorscale((0, 0, 1), 30), e_player.origin + vectorscale((0, 0, 1), 30), 0, undefined))
					{
						e_player create_and_play_dialog(#"kill", self.var_eee02beb);
						continue;
					}
				}
			}
			else
			{
				self create_and_play_dialog(#"kill", #"hash_64af7b70ae9d5316");
			}
			wait(10);
			self.killcounter = 0;
			timer = -1;
		}
		wait(0.1);
	}
	self.killcounter = 0;
	self.timerisrunning = 0;
}

/*
	Name: zmbvoxcreate
	Namespace: zm_audio
	Checksum: 0x229B9132
	Offset: 0x2CE8
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function zmbvoxcreate()
{
	vox = spawnstruct();
	vox.speaker = [];
	return vox;
}

/*
	Name: zmbvoxinitspeaker
	Namespace: zm_audio
	Checksum: 0xD83A8073
	Offset: 0x2D20
	Size: 0xB2
	Parameters: 3
	Flags: Linked
*/
function zmbvoxinitspeaker(speaker, prefix, ent)
{
	ent.zmbvoxid = speaker;
	if(!isdefined(self.speaker[speaker]))
	{
		self.speaker[speaker] = spawnstruct();
		self.speaker[speaker].alias = [];
	}
	self.speaker[speaker].prefix = prefix;
	self.speaker[speaker].ent = ent;
}

/*
	Name: custom_kill_damaged_vo
	Namespace: zm_audio
	Checksum: 0xC692AD6C
	Offset: 0x2DE0
	Size: 0x5E
	Parameters: 1
	Flags: None
*/
function custom_kill_damaged_vo(player)
{
	self notify(#"sound_damage_player_updated");
	self endon(#"death", #"sound_damage_player_updated");
	self.sound_damage_player = player;
	wait(2);
	self.sound_damage_player = undefined;
}

/*
	Name: loadplayervoicecategories
	Namespace: zm_audio
	Checksum: 0xD5E1AFC0
	Offset: 0x2E48
	Size: 0x1D2
	Parameters: 1
	Flags: Linked
*/
function loadplayervoicecategories(table)
{
	index = 0;
	row = tablelookuprow(table, index);
	while(isdefined(row))
	{
		category = checkstringvalid(row[0]);
		subcategory = checkstringvalid(row[1]);
		suffix = checkstringvalid(row[2]);
		percentage = int(row[3]);
		if(percentage <= 0)
		{
			percentage = 100;
		}
		cooldown = checkintvalid(row[4]);
		var_50219c90 = row[5];
		var_7aadcbd7 = row[6];
		var_8dd99641 = row[7];
		var_884fa3fe = row[8];
		zmbvoxadd(category, subcategory, suffix, percentage, cooldown, var_50219c90, var_7aadcbd7, var_8dd99641, var_884fa3fe);
		index++;
		row = tablelookuprow(table, index);
	}
}

/*
	Name: checkstringvalid
	Namespace: zm_audio
	Checksum: 0xD7ADF8AE
	Offset: 0x3028
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function checkstringvalid(str)
{
	if(str != "")
	{
		return str;
	}
	return undefined;
}

/*
	Name: checkstringtrue
	Namespace: zm_audio
	Checksum: 0x9EE0680E
	Offset: 0x3058
	Size: 0x50
	Parameters: 1
	Flags: None
*/
function checkstringtrue(str)
{
	if(!isdefined(str))
	{
		return 0;
	}
	if(str != "")
	{
		if(tolower(str) == "true")
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: checkintvalid
	Namespace: zm_audio
	Checksum: 0x4458C92B
	Offset: 0x30B0
	Size: 0x5A
	Parameters: 2
	Flags: Linked
*/
function checkintvalid(value, defaultvalue = 0)
{
	if(!isdefined(value))
	{
		return defaultvalue;
	}
	if(value == "")
	{
		return defaultvalue;
	}
	return int(value);
}

/*
	Name: zmbvoxadd
	Namespace: zm_audio
	Checksum: 0xE0EB50AA
	Offset: 0x3118
	Size: 0x1F2
	Parameters: 9
	Flags: Linked
*/
function zmbvoxadd(category, subcategory, suffix, percentage = 100, cooldown = 0, var_50219c90 = 0, var_7aadcbd7 = 0, var_8dd99641 = 0, var_884fa3fe = 0)
{
	/#
		assert(isdefined(category));
	#/
	/#
		assert(isdefined(subcategory));
	#/
	/#
		assert(isdefined(suffix));
	#/
	if(!isdefined(level.votimer))
	{
		level.votimer = [];
	}
	if(!isdefined(level.sndplayervox))
	{
		level.sndplayervox = [];
	}
	if(!isdefined(level.sndplayervox[category]))
	{
		level.sndplayervox[category] = [];
	}
	level.sndplayervox[category][subcategory] = {#hash_884fa3fe:var_884fa3fe, #hash_8dd99641:var_8dd99641, #hash_7aadcbd7:var_7aadcbd7, #hash_50219c90:var_50219c90, #cooldown:cooldown, #percentage:percentage, #suffix:suffix};
	level.votimer[subcategory] = 0;
}

/*
	Name: function_ef9ba49c
	Namespace: zm_audio
	Checksum: 0xF61A0565
	Offset: 0x3318
	Size: 0x1FA
	Parameters: 6
	Flags: Linked
*/
function function_ef9ba49c(category, delay = 2, var_ba54b77d = -1, n_range = 800, endons, var_618a04 = 0)
{
	subcategory = #"react";
	self endon(#"death");
	if(!isdefined(endons))
	{
		endons = [];
	}
	else if(!isarray(endons))
	{
		endons = array(endons);
	}
	foreach(str_endon in endons)
	{
		self endon(str_endon);
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
	if(isdefined(player_vo))
	{
		return 1 === player_vo create_and_play_dialog(category, subcategory, undefined, 1);
	}
	return level function_bca32e49(category, subcategory, undefined, 1);
}

/*
	Name: function_bf1b121a
	Namespace: zm_audio
	Checksum: 0x4CFF444F
	Offset: 0x3520
	Size: 0x232
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
		var_6f868336 = array::randomize(var_6f868336);
		foreach(player in var_6f868336)
		{
			if(!player function_65e5c19a() || (isdefined(level.var_b625a184) && level.var_b625a184))
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
	Name: function_bca32e49
	Namespace: zm_audio
	Checksum: 0x2015F5D9
	Offset: 0x3760
	Size: 0x90
	Parameters: 4
	Flags: Linked
*/
function function_bca32e49(category, subcategory, force_variant, b_wait_if_busy = 0)
{
	e_player = array::random(zm_vo::function_347f7d34());
	if(isdefined(e_player))
	{
		return 1 === e_player create_and_play_dialog(category, subcategory, force_variant, b_wait_if_busy);
	}
	return 0;
}

/*
	Name: create_and_play_dialog
	Namespace: zm_audio
	Checksum: 0x5298F857
	Offset: 0x37F8
	Size: 0x554
	Parameters: 5
	Flags: Linked
*/
function create_and_play_dialog(category, subcategory, force_variant, b_wait_if_busy = 0, var_d0acc84f)
{
	if(!isplayer(self))
	{
		return 0;
	}
	self endon(#"death");
	if(zm_trial::function_b47f6aba() || zm_utility::is_standard() || (isdefined(level.var_d555ff19) && level.var_d555ff19))
	{
		return 0;
	}
	s_overrides = function_a3932430(category, subcategory);
	if(isdefined(s_overrides))
	{
		if(s_overrides.str_category == "" && s_overrides.var_39acfdda == "")
		{
			return 0;
		}
		if(!function_63f85f39(s_overrides.str_category, s_overrides.var_39acfdda))
		{
			/#
				if(getdvarint(#"debug_audio", 0))
				{
					println("" + category + "" + subcategory + "");
				}
			#/
		}
		else if(s_overrides.chance == 0 || s_overrides.chance > randomint(100))
		{
			category = s_overrides.str_category;
			subcategory = s_overrides.var_39acfdda;
		}
	}
	attempt(category, subcategory);
	if(!function_43f17c2(category, subcategory))
	{
		return 0;
	}
	var_3c443e97 = subcategory;
	subcategory = function_9c83876e(category, subcategory);
	if(!function_63f85f39(category, subcategory))
	{
		/#
			if(getdvarint(#"debug_audio", 0))
			{
				println("" + category + "" + subcategory + "");
			}
		#/
		return 0;
	}
	if(sndvoxoverride() || (isdefined(level.var_b625a184) && level.var_b625a184))
	{
		return 0;
	}
	if(b_wait_if_busy)
	{
		self notify(#"hash_7efd5bdf8133ff7b");
		self endon(#"hash_7efd5bdf8133ff7b");
		if(isdefined(var_d0acc84f))
		{
			self endon(var_d0acc84f);
		}
		var_215d4efb = (b_wait_if_busy == 2 ? 1 : 0);
		while(!function_65e5c19a(self.var_8dd99641, var_215d4efb))
		{
			waitframe(1);
			waittillframeend();
		}
	}
	if(sndvoxoverride())
	{
		return 0;
	}
	if(!function_65e5c19a(self.var_8dd99641))
	{
		return 0;
	}
	if(!function_e2bd90b5(category, subcategory, force_variant))
	{
		return 0;
	}
	vox = level.sndplayervox[category][subcategory];
	prefix = shouldplayerspeak(self, category, subcategory, vox);
	if(!isdefined(prefix))
	{
		return 0;
	}
	var_651f2941 = vox.var_50219c90;
	sound_to_play = self zmbvoxgetlinevariant(prefix, vox.suffix, var_651f2941, force_variant);
	if(isdefined(sound_to_play) || function_31230d39(category, subcategory))
	{
		self thread do_player_or_npc_playvox(sound_to_play, vox.var_8dd99641, category, subcategory);
		success(category, var_3c443e97);
	}
	else
	{
		/#
			if(getdvarint(#"debug_audio", 0))
			{
				iprintln("");
			}
		#/
		return 0;
	}
	return 1;
}

/*
	Name: sndvoxoverride
	Namespace: zm_audio
	Checksum: 0x432C470B
	Offset: 0x3D58
	Size: 0x52
	Parameters: 1
	Flags: Linked
*/
function sndvoxoverride(b_toggle)
{
	if(isdefined(b_toggle))
	{
		level thread function_82f4b1cd(b_toggle);
	}
	else
	{
		waitframe(1);
		return isdefined(level.sndvoxoverride) && level.sndvoxoverride;
	}
}

/*
	Name: function_82f4b1cd
	Namespace: zm_audio
	Checksum: 0xBE44FD89
	Offset: 0x3DB8
	Size: 0x56
	Parameters: 1
	Flags: Linked, Private
*/
private function function_82f4b1cd(b_toggle)
{
	self notify("1e6b41d8289481f3");
	self endon("1e6b41d8289481f3");
	if(!b_toggle)
	{
		wait(3);
		level.sndvoxoverride = undefined;
	}
	else
	{
		level.sndvoxoverride = 1;
	}
}

/*
	Name: function_cb26577a
	Namespace: zm_audio
	Checksum: 0x53DB9D49
	Offset: 0x3E18
	Size: 0xA8
	Parameters: 0
	Flags: None
*/
function function_cb26577a()
{
	while(true)
	{
		waitframe(1);
		/#
			if(getdvarint(#"debug_audio", 0))
			{
				debug2dtext((500, 20, 0), (level.sndvoxoverride ? "" : ""), (1, 0, 0), 1, (0, 0, 0), 0, 0.8, 1);
			}
		#/
	}
}

/*
	Name: function_43f17c2
	Namespace: zm_audio
	Checksum: 0x99EA5765
	Offset: 0x3EC8
	Size: 0x164
	Parameters: 2
	Flags: Linked
*/
function function_43f17c2(category, subcategory)
{
	if(!isdefined(level.var_e1b27bb2))
	{
		level.var_e1b27bb2 = [];
	}
	else if(!isarray(level.var_e1b27bb2))
	{
		level.var_e1b27bb2 = array(level.var_e1b27bb2);
	}
	if(!isdefined(level.var_e1b27bb2[category]))
	{
		level.var_e1b27bb2[category] = [];
	}
	else if(!isarray(level.var_e1b27bb2[category]))
	{
		level.var_e1b27bb2[category] = array(level.var_e1b27bb2[category]);
	}
	if(function_63f85f39(category, subcategory) && level.sndplayervox[category][subcategory].var_7aadcbd7)
	{
		if(level.var_e1b27bb2[category][subcategory] === level.round_number)
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: function_250becf4
	Namespace: zm_audio
	Checksum: 0x3DD56D53
	Offset: 0x4038
	Size: 0x120
	Parameters: 2
	Flags: Linked
*/
function function_250becf4(category, subcategory)
{
	if(!isdefined(level.var_e1b27bb2))
	{
		level.var_e1b27bb2 = [];
	}
	else if(!isarray(level.var_e1b27bb2))
	{
		level.var_e1b27bb2 = array(level.var_e1b27bb2);
	}
	if(!isdefined(level.var_e1b27bb2[category]))
	{
		level.var_e1b27bb2[category] = [];
	}
	else if(!isarray(level.var_e1b27bb2[category]))
	{
		level.var_e1b27bb2[category] = array(level.var_e1b27bb2[category]);
	}
	level.var_e1b27bb2[category][subcategory] = level.round_number;
}

/*
	Name: attempt
	Namespace: zm_audio
	Checksum: 0x1244B730
	Offset: 0x4160
	Size: 0x64
	Parameters: 2
	Flags: Linked
*/
function attempt(category, subcategory)
{
	if(isdefined(self.var_a9a870e2) && isdefined(self.var_a9a870e2[category]) && isdefined(self.var_a9a870e2[category][subcategory]))
	{
		self.var_a9a870e2[category][subcategory]++;
	}
}

/*
	Name: success
	Namespace: zm_audio
	Checksum: 0xC1C11E99
	Offset: 0x41D0
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function success(category, subcategory)
{
	self.var_a9a870e2[category][subcategory] = 0;
	function_250becf4(category, subcategory);
}

/*
	Name: function_9c83876e
	Namespace: zm_audio
	Checksum: 0x225113DF
	Offset: 0x4220
	Size: 0x1FC
	Parameters: 2
	Flags: Linked
*/
function function_9c83876e(category, subcategory)
{
	if(!isdefined(level.var_79bbe09a))
	{
		level.var_79bbe09a = [];
	}
	else if(!isarray(level.var_79bbe09a))
	{
		level.var_79bbe09a = array(level.var_79bbe09a);
	}
	if(!isdefined(level.var_79bbe09a[category]))
	{
		level.var_79bbe09a[category] = [];
	}
	else if(!isarray(level.var_79bbe09a[category]))
	{
		level.var_79bbe09a[category] = array(level.var_79bbe09a[category]);
	}
	if(!isdefined(level.var_79bbe09a[category][subcategory]))
	{
		level.var_79bbe09a[category][subcategory] = 0;
	}
	level.var_79bbe09a[category][subcategory]++;
	if(level.var_79bbe09a[category][subcategory] == 1)
	{
		var_9c4a66e5 = subcategory + "_first";
		if(function_63f85f39(category, var_9c4a66e5))
		{
			if(!isdefined(level.var_79bbe09a[category][var_9c4a66e5]))
			{
				level.var_79bbe09a[category][var_9c4a66e5] = 0;
			}
			if(level.var_79bbe09a[category][var_9c4a66e5] < 1)
			{
				return var_9c4a66e5;
			}
		}
	}
	return subcategory;
}

/*
	Name: function_cd71e220
	Namespace: zm_audio
	Checksum: 0x80F22571
	Offset: 0x4428
	Size: 0x14C
	Parameters: 2
	Flags: None
*/
function function_cd71e220(category, subcategory)
{
	if(!isdefined(level.var_79bbe09a))
	{
		level.var_79bbe09a = [];
	}
	else if(!isarray(level.var_79bbe09a))
	{
		level.var_79bbe09a = array(level.var_79bbe09a);
	}
	if(!isdefined(level.var_79bbe09a[category]))
	{
		level.var_79bbe09a[category] = [];
	}
	else if(!isarray(level.var_79bbe09a[category]))
	{
		level.var_79bbe09a[category] = array(level.var_79bbe09a[category]);
	}
	if(!isdefined(level.var_79bbe09a[category][subcategory]))
	{
		level.var_79bbe09a[category][subcategory] = 0;
	}
	level.var_79bbe09a[category][subcategory]++;
}

/*
	Name: function_6191af93
	Namespace: zm_audio
	Checksum: 0xB3A79BCE
	Offset: 0x4580
	Size: 0xD4
	Parameters: 5
	Flags: Linked
*/
function function_6191af93(str_category, var_39acfdda, var_6e8fc6db, var_60626fa8, var_2bff7297 = 0)
{
	if(!isdefined(self.var_c13233ee))
	{
		self.var_c13233ee = [];
	}
	if(!isdefined(self.var_c13233ee[str_category]))
	{
		self.var_c13233ee[str_category] = [];
	}
	s_override = {#chance:var_2bff7297, #hash_39acfdda:var_60626fa8, #str_category:var_6e8fc6db};
	self.var_c13233ee[str_category][var_39acfdda] = s_override;
}

/*
	Name: function_e1666976
	Namespace: zm_audio
	Checksum: 0xF94B1454
	Offset: 0x4660
	Size: 0x9A
	Parameters: 2
	Flags: None
*/
function function_e1666976(str_category, var_39acfdda)
{
	if(isdefined(self.var_c13233ee))
	{
		if(isdefined(self.var_c13233ee[str_category]))
		{
			if(isdefined(self.var_c13233ee[str_category][var_39acfdda]))
			{
				self.var_c13233ee[str_category][var_39acfdda] = undefined;
				if(!self.var_c13233ee[str_category].size)
				{
					self.var_c13233ee[str_category] = undefined;
				}
				if(!self.var_c13233ee.size)
				{
					self.var_c13233ee = undefined;
				}
			}
		}
	}
}

/*
	Name: function_a3932430
	Namespace: zm_audio
	Checksum: 0xBDB5EA46
	Offset: 0x4708
	Size: 0xBE
	Parameters: 2
	Flags: Linked, Private
*/
private function function_a3932430(str_category, var_39acfdda)
{
	if(isdefined(self.var_c13233ee))
	{
		if(isdefined(self.var_c13233ee[str_category]))
		{
			if(isdefined(self.var_c13233ee[str_category][var_39acfdda]))
			{
				return self.var_c13233ee[str_category][var_39acfdda];
			}
		}
	}
	else if(isdefined(level.var_c13233ee))
	{
		if(isdefined(level.var_c13233ee[str_category]))
		{
			if(isdefined(level.var_c13233ee[str_category][var_39acfdda]))
			{
				return level.var_c13233ee[str_category][var_39acfdda];
			}
		}
	}
	return undefined;
}

/*
	Name: function_65e5c19a
	Namespace: zm_audio
	Checksum: 0x13034AA7
	Offset: 0x47D0
	Size: 0xBE
	Parameters: 2
	Flags: Linked
*/
function function_65e5c19a(var_7faa9b94 = 0, var_7d84f04b = 0)
{
	if(var_7d84f04b)
	{
		return !(isdefined(self.zmannouncertalking) && self.zmannouncertalking);
	}
	if(isdefined(self.isspeaking) && self.isspeaking || (isdefined(self.var_5b6ebfd0) && self.var_5b6ebfd0) || (isdefined(self.zmannouncertalking) && self.zmannouncertalking))
	{
		return 0;
	}
	if(function_c028678a(var_7faa9b94))
	{
		return 0;
	}
	return 1;
}

/*
	Name: do_player_or_npc_playvox
	Namespace: zm_audio
	Checksum: 0x4B346CA9
	Offset: 0x4898
	Size: 0x174
	Parameters: 4
	Flags: Linked
*/
function do_player_or_npc_playvox(sound_to_play, var_8dd99641 = 0, category, subcategory)
{
	self endon(#"death", #"vo_clear");
	self.str_vo_being_spoken = sound_to_play;
	self.isspeaking = 1;
	self.var_5b6ebfd0 = var_8dd99641;
	if(isplayer(self))
	{
		self clientfield::set_to_player("isspeaking", 1);
	}
	var_cf98fdd8 = float(gettime() - (isdefined(self.last_vo_played_time) ? self.last_vo_played_time : 0)) / 1000;
	if(var_cf98fdd8 < 1)
	{
		wait(2 - var_cf98fdd8);
	}
	if(!function_631a26f0(category, subcategory))
	{
		play_vo_internal(sound_to_play, (var_8dd99641 ? self : undefined));
	}
	else
	{
		waitframe(1);
	}
	zm_vo::vo_clear();
}

/*
	Name: play_vo_internal
	Namespace: zm_audio
	Checksum: 0x5FF7EFDE
	Offset: 0x4A18
	Size: 0x224
	Parameters: 2
	Flags: Linked
*/
function play_vo_internal(str_sound, e_to_player)
{
	if(isstring(str_sound) || function_7a600918(str_sound))
	{
		self.str_vo_being_spoken = str_sound;
		self.var_4377124 = undefined;
		if(isplayer(self) && isentity(e_to_player))
		{
			self playsoundtoplayer(str_sound, e_to_player);
			n_time = float(max((isdefined(soundgetplaybacktime(str_sound)) ? soundgetplaybacktime(str_sound) : 500), 500)) / 1000;
			s = undefined;
			s = self waittill_timeout(n_time, #"vo_clear");
		}
		else if(isdefined(self gettagorigin("J_head")))
		{
			self playsoundwithnotify(str_sound, "vo_done", "J_head");
		}
		else
		{
			self playsoundwithnotify(str_sound, "vo_done");
		}
		s = undefined;
		s = self waittill(#"vo_done", #"vo_clear");
		if(s._notify != "vo_clear")
		{
			self.var_4377124 = 1;
		}
	}
	else
	{
		waitframe(1);
	}
}

/*
	Name: function_631a26f0
	Namespace: zm_audio
	Checksum: 0x7DE8A509
	Offset: 0x4C48
	Size: 0x5E
	Parameters: 2
	Flags: Linked
*/
function function_631a26f0(str_category, var_39acfdda)
{
	if(function_31230d39(str_category, var_39acfdda))
	{
		self.var_5b6ebfd0 = 0;
		return [[self.var_631a26f0[str_category][var_39acfdda]]](str_category, var_39acfdda);
	}
	return 0;
}

/*
	Name: function_31230d39
	Namespace: zm_audio
	Checksum: 0xD2B1FFDD
	Offset: 0x4CB0
	Size: 0x80
	Parameters: 2
	Flags: Linked
*/
function function_31230d39(str_category, var_39acfdda)
{
	if(!isdefined(str_category) || !isdefined(var_39acfdda))
	{
		return 0;
	}
	if(isdefined(self.var_631a26f0) && isdefined(self.var_631a26f0[str_category]) && isfunctionptr(self.var_631a26f0[str_category][var_39acfdda]))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_87714659
	Namespace: zm_audio
	Checksum: 0x86B96D37
	Offset: 0x4D38
	Size: 0x4C
	Parameters: 3
	Flags: None
*/
function function_87714659(func, str_category, var_39acfdda)
{
	if(!isdefined(self.var_631a26f0))
	{
		self.var_631a26f0 = [];
	}
	self.var_631a26f0[str_category][var_39acfdda] = func;
}

/*
	Name: shouldplayerspeak
	Namespace: zm_audio
	Checksum: 0xBA6C3C61
	Offset: 0x4D90
	Size: 0x22C
	Parameters: 4
	Flags: Linked
*/
function shouldplayerspeak(player, category, subcategory, vox)
{
	if(!isplayer(player))
	{
		return;
	}
	if(player.sessionstate != "playing")
	{
		return;
	}
	if(player laststand::player_is_in_laststand() && (subcategory != "revive_down" || subcategory != "revive_up") && category != "revive")
	{
		return;
	}
	if(player isplayerunderwater())
	{
		return;
	}
	if(player scene::is_igc_active())
	{
		return;
	}
	if(isdefined(player.dontspeak) && player.dontspeak)
	{
		return;
	}
	if(!(isdefined(vox.var_884fa3fe) && vox.var_884fa3fe) && function_1b438b7b())
	{
		return;
	}
	if(isvoxoncooldown(player, category, subcategory))
	{
		return;
	}
	if(vox.percentage <= 0)
	{
		return;
	}
	n_attempt = player.var_a9a870e2[category][subcategory] - 1;
	if(n_attempt < 100 / vox.percentage)
	{
		if(!math::cointoss(vox.percentage))
		{
			return;
		}
	}
	level.voxtimer = level.time;
	player.voxtimer[category][subcategory] = level.time;
	index = player zm_characters::function_dc232a80();
	return "plr_" + index;
}

/*
	Name: isvoxoncooldown
	Namespace: zm_audio
	Checksum: 0x3BDB83CE
	Offset: 0x4FC8
	Size: 0x1E0
	Parameters: 3
	Flags: Linked
*/
function isvoxoncooldown(player, category, subcategory)
{
	if(level.sndplayervox[category][subcategory].cooldown <= 0)
	{
		return 0;
	}
	if(!isdefined(player.voxtimer))
	{
		player.voxtimer = [];
	}
	else if(!isarray(player.voxtimer))
	{
		player.voxtimer = array(player.voxtimer);
	}
	if(!isdefined(player.voxtimer[category]))
	{
		player.voxtimer[category] = [];
	}
	else if(!isarray(player.voxtimer[category]))
	{
		player.voxtimer[category] = array(player.voxtimer[category]);
	}
	if(!isdefined(player.voxtimer[category][subcategory]))
	{
		player.voxtimer[category][subcategory] = 0;
	}
	if(level.time - player.voxtimer[category][subcategory] <= int(level.sndplayervox[category][subcategory].cooldown * 1000))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_1b438b7b
	Namespace: zm_audio
	Checksum: 0xE2EA35DC
	Offset: 0x51B0
	Size: 0x5A
	Parameters: 0
	Flags: Linked
*/
function function_1b438b7b()
{
	if(isdefined(level.voxtimer) && level.time - level.voxtimer <= int(5 * 1000))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_63f85f39
	Namespace: zm_audio
	Checksum: 0xB9FEBB49
	Offset: 0x5218
	Size: 0x76
	Parameters: 2
	Flags: Linked
*/
function function_63f85f39(category, subcategory)
{
	if(isdefined(level.sndplayervox))
	{
		if(isdefined(category))
		{
			if(isdefined(level.sndplayervox[category]))
			{
				if(isdefined(subcategory))
				{
					if(isdefined(level.sndplayervox[category][subcategory]))
					{
						return 1;
					}
				}
				else
				{
					return 1;
				}
			}
		}
	}
	return 0;
}

/*
	Name: function_654ec86b
	Namespace: zm_audio
	Checksum: 0x569261C6
	Offset: 0x5298
	Size: 0x1F4
	Parameters: 0
	Flags: Linked
*/
function function_654ec86b()
{
	if(!isdefined(level.sndplayervox))
	{
		return;
	}
	index = zm_characters::function_dc232a80();
	prefix = "plr_" + index;
	foreach(category, a_category in level.sndplayervox)
	{
		foreach(subcategory, vox in a_category)
		{
			var_a1effcd = get_number_variants(vox.suffix + "_" + prefix);
			self.sound_dialog[vox.suffix] = [];
			self.sound_dialog_available[vox.suffix] = [];
			for(i = 0; i < var_a1effcd; i++)
			{
				self.sound_dialog[vox.suffix][i] = i;
				self.sound_dialog_available[vox.suffix][i] = i;
			}
			self.var_a9a870e2[category][subcategory] = 0;
		}
	}
}

/*
	Name: function_e2bd90b5
	Namespace: zm_audio
	Checksum: 0xAF2C266D
	Offset: 0x5498
	Size: 0x24A
	Parameters: 3
	Flags: Linked
*/
function function_e2bd90b5(category, subcategory, variant)
{
	if(!isplayer(self))
	{
		/#
			/#
				assert(0, "" + "");
			#/
		#/
		return 0;
	}
	if(function_31230d39(category, subcategory))
	{
		return 1;
	}
	if(function_63f85f39(category, subcategory))
	{
		vox = level.sndplayervox[category][subcategory];
		if(!isdefined(self.sound_dialog))
		{
			self.sound_dialog = [];
		}
		if(!isdefined(self.sound_dialog_available))
		{
			self.sound_dialog_available = [];
		}
		if(!isdefined(self.sound_dialog_available[vox.suffix]))
		{
			self.sound_dialog_available[vox.suffix] = [];
		}
		if(!vox.var_50219c90)
		{
			if(!self.sound_dialog_available[vox.suffix].size && isarray(self.sound_dialog[vox.suffix]))
			{
				for(i = 0; i < self.sound_dialog[vox.suffix].size; i++)
				{
					self.sound_dialog_available[vox.suffix][i] = self.sound_dialog[vox.suffix][i];
				}
			}
		}
		if(isdefined(variant))
		{
			return isinarray(self.sound_dialog_available[vox.suffix], variant);
		}
		return self.sound_dialog_available[vox.suffix].size;
	}
	return 0;
}

/*
	Name: zmbvoxgetlinevariant
	Namespace: zm_audio
	Checksum: 0xBEE9986A
	Offset: 0x56F0
	Size: 0x216
	Parameters: 4
	Flags: Linked
*/
function zmbvoxgetlinevariant(prefix, suffix, var_651f2941, force_variant)
{
	if(!self.sound_dialog[suffix].size)
	{
		/#
			if(getdvarint(#"debug_audio", 0) > 0)
			{
				println("" + suffix + "" + prefix);
			}
		#/
		return undefined;
	}
	if(isdefined(force_variant))
	{
		variation = force_variant;
	}
	else if(!(isdefined(var_651f2941) && var_651f2941) && !self.sound_dialog_available[suffix].size)
	{
		for(i = 0; i < self.sound_dialog[suffix].size; i++)
		{
			self.sound_dialog_available[suffix][i] = self.sound_dialog[suffix][i];
		}
	}
	if(!self.sound_dialog_available[suffix].size)
	{
		/#
			if(getdvarint(#"debug_audio", 0) > 0)
			{
				println("" + suffix + "" + prefix);
			}
		#/
		return undefined;
	}
	variation = array::random(self.sound_dialog_available[suffix]);
	arrayremovevalue(self.sound_dialog_available[suffix], variation);
	self.var_fbbeefe6 = variation;
	return suffix + "_" + prefix + "_" + variation;
}

/*
	Name: function_c028678a
	Namespace: zm_audio
	Checksum: 0x2D87C58A
	Offset: 0x5910
	Size: 0x13C
	Parameters: 1
	Flags: Linked
*/
function function_c028678a(var_7faa9b94 = 0)
{
	var_4d6b74e0 = 0;
	a_speakers = arraycombine(util::get_active_players(), level.var_62281818, 0, 0);
	foreach(speaker in a_speakers)
	{
		if(isdefined(speaker))
		{
			if(self == speaker)
			{
				continue;
			}
			if(var_7faa9b94 && (isdefined(speaker.var_5b6ebfd0) && speaker.var_5b6ebfd0))
			{
				continue;
			}
			if(isdefined(speaker.isspeaking) && speaker.isspeaking)
			{
				var_4d6b74e0 = 1;
				break;
			}
		}
	}
	return var_4d6b74e0;
}

/*
	Name: musicstate_create
	Namespace: zm_audio
	Checksum: 0x36189AE5
	Offset: 0x5A58
	Size: 0x29C
	Parameters: 8
	Flags: Linked
*/
function musicstate_create(statename, playtype = 1, musname1, musname2, musname3, musname4, musname5, musname6)
{
	if(!isdefined(level.musicsystem))
	{
		level.musicsystem = spawnstruct();
		level.musicsystem.queue = 0;
		level.musicsystem.currentplaytype = 0;
		level.musicsystem.currentset = undefined;
		level.musicsystem.states = [];
	}
	level.musicsystem.states[statename] = spawnstruct();
	level.musicsystem.states[statename].playtype = playtype;
	level.musicsystem.states[statename].musarray = array();
	if(isdefined(musname1))
	{
		array::add(level.musicsystem.states[statename].musarray, musname1);
	}
	if(isdefined(musname2))
	{
		array::add(level.musicsystem.states[statename].musarray, musname2);
	}
	if(isdefined(musname3))
	{
		array::add(level.musicsystem.states[statename].musarray, musname3);
	}
	if(isdefined(musname4))
	{
		array::add(level.musicsystem.states[statename].musarray, musname4);
	}
	if(isdefined(musname5))
	{
		array::add(level.musicsystem.states[statename].musarray, musname5);
	}
	if(isdefined(musname6))
	{
		array::add(level.musicsystem.states[statename].musarray, musname6);
	}
}

/*
	Name: sndmusicsystem_playstate
	Namespace: zm_audio
	Checksum: 0x61D2FEE3
	Offset: 0x5D00
	Size: 0x254
	Parameters: 2
	Flags: Linked
*/
function sndmusicsystem_playstate(state, var_ceca37b = 0)
{
	if(zm_utility::is_tutorial() && !var_ceca37b)
	{
		return;
	}
	if(!isdefined(level.musicsystem))
	{
		return;
	}
	m = level.musicsystem;
	if(!isdefined(m.states[state]))
	{
		return;
	}
	s = level.musicsystem.states[state];
	playtype = s.playtype;
	if(zm_utility::is_standard() || zm_trial::function_b47f6aba() && !var_ceca37b)
	{
		if(playtype != 5)
		{
			return;
		}
	}
	if(m.currentplaytype > 0)
	{
		if(playtype == 1)
		{
			return;
		}
		else if(playtype == 2)
		{
			level thread sndmusicsystem_queuestate(state);
		}
		else if(playtype > m.currentplaytype || (playtype == 3 && m.currentplaytype == 3))
		{
			if(isdefined(level.musicsystemoverride) && level.musicsystemoverride && playtype != 5)
			{
				return;
			}
			level sndmusicsystem_stopandflush();
			level thread playstate(state);
		}
	}
	else if(!(isdefined(level.musicsystemoverride) && level.musicsystemoverride) || playtype == 5)
	{
		level thread playstate(state);
	}
}

/*
	Name: playstate
	Namespace: zm_audio
	Checksum: 0xCE004A0D
	Offset: 0x5F60
	Size: 0x1EA
	Parameters: 1
	Flags: Linked
*/
function playstate(state)
{
	level endon(#"sndstatestop");
	m = level.musicsystem;
	musarray = level.musicsystem.states[state].musarray;
	if(musarray.size <= 0)
	{
		return;
	}
	mustoplay = musarray[randomintrange(0, musarray.size)];
	m.currentplaytype = m.states[state].playtype;
	m.currentstate = state;
	wait(0.1);
	if(isdefined(level.sndplaystateoverride))
	{
		perplayer = level [[level.sndplaystateoverride]](state);
		if(!(isdefined(perplayer) && perplayer))
		{
			music::setmusicstate(mustoplay);
		}
	}
	else
	{
		music::setmusicstate(mustoplay);
	}
	aliasname = "mus_" + mustoplay + "_intro";
	playbacktime = (isdefined(soundgetplaybacktime(aliasname)) ? soundgetplaybacktime(aliasname) : 1000);
	var_6f451dc0 = gettime() + playbacktime;
	while(gettime() < var_6f451dc0)
	{
		wait(0.1);
	}
	m.currentplaytype = 0;
	m.currentstate = undefined;
}

/*
	Name: sndmusicsystem_queuestate
	Namespace: zm_audio
	Checksum: 0x9856550E
	Offset: 0x6158
	Size: 0xE2
	Parameters: 1
	Flags: Linked
*/
function sndmusicsystem_queuestate(state)
{
	level endon(#"sndqueueflush");
	m = level.musicsystem;
	count = 0;
	if(isdefined(m.queue) && m.queue)
	{
		return;
	}
	m.queue = 1;
	while(m.currentplaytype > 0)
	{
		wait(0.5);
		count++;
		if(count >= 20)
		{
			m.queue = 0;
			return;
		}
	}
	level thread playstate(state);
	m.queue = 0;
}

/*
	Name: sndmusicsystem_stopandflush
	Namespace: zm_audio
	Checksum: 0x38418B43
	Offset: 0x6248
	Size: 0x62
	Parameters: 0
	Flags: Linked
*/
function sndmusicsystem_stopandflush()
{
	level notify(#"sndqueueflush");
	level.musicsystem.queue = 0;
	level notify(#"sndstatestop");
	level.musicsystem.currentplaytype = 0;
	level.musicsystem.currentstate = undefined;
}

/*
	Name: sndmusicsystem_isabletoplay
	Namespace: zm_audio
	Checksum: 0xCE569834
	Offset: 0x62B8
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function sndmusicsystem_isabletoplay()
{
	if(!isdefined(level.musicsystem))
	{
		return 0;
	}
	if(!isdefined(level.musicsystem.currentplaytype))
	{
		return 0;
	}
	if(level.musicsystem.currentplaytype >= 4)
	{
		return 0;
	}
	if(isdefined(level.musicsystemoverride) && level.musicsystemoverride)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_a3c4af48
	Namespace: zm_audio
	Checksum: 0x9E646DEC
	Offset: 0x6340
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_a3c4af48(str_location)
{
	self notify(#"hash_29bd5874900989d6");
	level thread function_6c53ab30(str_location);
	self thread location_vox(str_location);
}

/*
	Name: function_3442c81a
	Namespace: zm_audio
	Checksum: 0xEB86EB6E
	Offset: 0x6398
	Size: 0x144
	Parameters: 5
	Flags: None
*/
function function_3442c81a(str_location, var_f9761829, b_repeat = 0, var_57b726a7 = 1, var_22324b12 = 2)
{
	if(!isdefined(level.var_4d771f19))
	{
		level.var_4d771f19 = [];
	}
	level.var_4d771f19[str_location] = spawnstruct();
	level.var_4d771f19[str_location].var_f9761829 = var_f9761829;
	level.var_4d771f19[str_location].b_repeat = b_repeat;
	level.var_4d771f19[str_location].var_496a8f95 = 0;
	level.var_4d771f19[str_location].b_played = 0;
	level.var_4d771f19[str_location].var_57b726a7 = var_57b726a7;
	musicstate_create(var_f9761829, var_22324b12, var_f9761829);
}

/*
	Name: function_6c53ab30
	Namespace: zm_audio
	Checksum: 0x68118E4F
	Offset: 0x64E8
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function function_6c53ab30(str_location)
{
	if(!isdefined(level.var_4d771f19))
	{
		return;
	}
	if(isdefined(level.var_4d771f19[str_location]))
	{
		level thread function_b9d832a0(level.var_4d771f19[str_location]);
	}
}

/*
	Name: function_b9d832a0
	Namespace: zm_audio
	Checksum: 0x4EDB0CF4
	Offset: 0x6548
	Size: 0x1BC
	Parameters: 1
	Flags: Linked
*/
function function_b9d832a0(var_790f33a7)
{
	level notify(#"hash_78615fca09ef53a");
	level endon(#"hash_78615fca09ef53a");
	if(zm_utility::is_trials() || zm_utility::is_tutorial())
	{
		return;
	}
	if(!var_790f33a7.var_57b726a7)
	{
		return;
	}
	if(level.musicsystem.currentplaytype > 0)
	{
		b_success = level function_85c0295a();
		if(!b_success)
		{
			return;
		}
	}
	if(var_790f33a7.b_played)
	{
		if(!var_790f33a7.b_repeat)
		{
			return;
		}
		if(var_790f33a7.var_496a8f95 >= 3)
		{
			var_790f33a7.b_played = 0;
		}
		else
		{
			return;
		}
	}
	foreach(struct in level.var_4d771f19)
	{
		if(struct != var_790f33a7)
		{
			struct.var_496a8f95++;
		}
	}
	var_790f33a7.b_played = 1;
	var_790f33a7.var_496a8f95 = 0;
	level thread sndmusicsystem_playstate(var_790f33a7.var_f9761829);
}

/*
	Name: function_85c0295a
	Namespace: zm_audio
	Checksum: 0x73933273
	Offset: 0x6710
	Size: 0x68
	Parameters: 0
	Flags: Linked
*/
function function_85c0295a()
{
	level endon(#"hash_78615fca09ef53a");
	n_counter = 0;
	while(level.musicsystem.currentplaytype > 0)
	{
		wait(0.5);
		n_counter++;
		if(n_counter >= 30)
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: function_8557c25d
	Namespace: zm_audio
	Checksum: 0x8D4C290
	Offset: 0x6780
	Size: 0x5A
	Parameters: 2
	Flags: None
*/
function function_8557c25d(str_location, b_toggle)
{
	if(!isdefined(level.var_4d771f19))
	{
		return;
	}
	if(!isdefined(level.var_4d771f19[str_location]))
	{
		return;
	}
	level.var_4d771f19[str_location].var_57b726a7 = b_toggle;
}

/*
	Name: sndmusicsystem_eesetup
	Namespace: zm_audio
	Checksum: 0x49A78CA0
	Offset: 0x67E8
	Size: 0x2B0
	Parameters: 6
	Flags: None
*/
function sndmusicsystem_eesetup(state, origin1, origin2, origin3, origin4, origin5)
{
	sndeearray = array();
	if(isdefined(origin1))
	{
		if(!isdefined(sndeearray))
		{
			sndeearray = [];
		}
		else if(!isarray(sndeearray))
		{
			sndeearray = array(sndeearray);
		}
		sndeearray[sndeearray.size] = origin1;
	}
	if(isdefined(origin2))
	{
		if(!isdefined(sndeearray))
		{
			sndeearray = [];
		}
		else if(!isarray(sndeearray))
		{
			sndeearray = array(sndeearray);
		}
		sndeearray[sndeearray.size] = origin2;
	}
	if(isdefined(origin3))
	{
		if(!isdefined(sndeearray))
		{
			sndeearray = [];
		}
		else if(!isarray(sndeearray))
		{
			sndeearray = array(sndeearray);
		}
		sndeearray[sndeearray.size] = origin3;
	}
	if(isdefined(origin4))
	{
		if(!isdefined(sndeearray))
		{
			sndeearray = [];
		}
		else if(!isarray(sndeearray))
		{
			sndeearray = array(sndeearray);
		}
		sndeearray[sndeearray.size] = origin4;
	}
	if(isdefined(origin5))
	{
		if(!isdefined(sndeearray))
		{
			sndeearray = [];
		}
		else if(!isarray(sndeearray))
		{
			sndeearray = array(sndeearray);
		}
		sndeearray[sndeearray.size] = origin5;
	}
	if(sndeearray.size > 0)
	{
		level.sndeemax = sndeearray.size;
		level.sndeecount = 0;
		foreach(origin in sndeearray)
		{
			level thread sndmusicsystem_eewait(origin, state);
		}
	}
}

/*
	Name: sndmusicsystem_eewait
	Namespace: zm_audio
	Checksum: 0x44AE2024
	Offset: 0x6AA0
	Size: 0x16C
	Parameters: 2
	Flags: Linked
*/
function sndmusicsystem_eewait(origin, state)
{
	temp_ent = spawn("script_origin", origin);
	temp_ent playloopsound(#"zmb_meteor_loop");
	temp_ent thread secretuse("main_music_egg_hit", vectorscale((0, 1, 0), 255), &sndmusicsystem_eeoverride);
	waitresult = undefined;
	waitresult = temp_ent waittill(#"main_music_egg_hit");
	temp_ent stoploopsound(1);
	waitresult.player playsound(#"zmb_meteor_activate");
	level.sndeecount++;
	if(level.sndeecount >= level.sndeemax)
	{
		level notify(#"hash_6499c9075229a517");
		level thread sndmusicsystem_playstate(state);
	}
	temp_ent delete();
}

/*
	Name: sndmusicsystem_eeoverride
	Namespace: zm_audio
	Checksum: 0x8B27E27B
	Offset: 0x6C18
	Size: 0x52
	Parameters: 2
	Flags: Linked
*/
function sndmusicsystem_eeoverride(arg1, arg2)
{
	if(isdefined(level.musicsystem.currentplaytype) && level.musicsystem.currentplaytype >= 4)
	{
		return 0;
	}
	return 1;
}

/*
	Name: secretuse
	Namespace: zm_audio
	Checksum: 0xC2F5EF5E
	Offset: 0x6C78
	Size: 0x18C
	Parameters: 5
	Flags: Linked
*/
function secretuse(notify_string, color, qualifier_func, arg1, arg2)
{
	waittillframeend();
	while(true)
	{
		if(!isdefined(self))
		{
			return;
		}
		/#
			print3d(self.origin, "", color, 1);
		#/
		players = level.players;
		foreach(player in players)
		{
			qualifier_passed = 1;
			if(isdefined(qualifier_func))
			{
				qualifier_passed = player [[qualifier_func]](arg1, arg2);
			}
			if(qualifier_passed && distancesquared(self.origin, player.origin) < 4096)
			{
				if(player laststand::is_facing(self))
				{
					if(player usebuttonpressed())
					{
						self notify(notify_string, player);
						return;
					}
				}
			}
		}
		wait(0.1);
	}
}

/*
	Name: function_4138a262
	Namespace: zm_audio
	Checksum: 0xDFE47561
	Offset: 0x6E10
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function function_4138a262()
{
	if(!isdefined(level.var_607bd5fb))
	{
		level.var_607bd5fb = 0;
	}
	var_bf1569b1 = 0;
	var_3a6fab91 = namespace_c3287616::function_f6cd912d(1);
	if(isdefined(var_3a6fab91))
	{
		var_f40360e8 = var_3a6fab91.n_round;
		if(isdefined(var_f40360e8) && level.round_number == var_f40360e8)
		{
			var_bf1569b1 = 1;
		}
	}
	if(isdefined(level.musicsystem.states[#"round_start_first"]) && level.round_number <= 1)
	{
		level thread sndmusicsystem_playstate("round_start_first");
	}
	else if(var_bf1569b1)
	{
		level thread sndmusicsystem_playstate("round_start_special");
		level.var_607bd5fb = 1;
	}
	else
	{
		level thread sndmusicsystem_playstate("round_start");
	}
}

/*
	Name: function_d0f5602a
	Namespace: zm_audio
	Checksum: 0x6DD68260
	Offset: 0x6F60
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_d0f5602a()
{
	if(level.var_607bd5fb)
	{
		level thread sndmusicsystem_playstate("round_end_special");
		level.var_607bd5fb = 0;
	}
	else
	{
		level thread sndmusicsystem_playstate("round_end");
	}
}

/*
	Name: sndannouncer_init
	Namespace: zm_audio
	Checksum: 0xC4853073
	Offset: 0x6FC8
	Size: 0x14D4
	Parameters: 0
	Flags: Linked
*/
function sndannouncer_init()
{
	if(!isdefined(level.zmannouncerprefix))
	{
		level.zmannouncerprefix = "zmba";
	}
	sndannouncervoxadd(#"carpenter", #"hash_4d495ea70e8796d2");
	sndannouncervoxadd(#"insta_kill", #"hash_4c409b9a3baca485");
	sndannouncervoxadd(#"double_points", #"hash_1ee1ecb2bf07589c");
	sndannouncervoxadd(#"nuke", #"hash_61ee7a1e5b4c68c7");
	sndannouncervoxadd(#"full_ammo", #"hash_773c07eb3a67a793");
	sndannouncervoxadd(#"fire_sale", #"hash_3cf43f66b71287e5");
	sndannouncervoxadd(#"minigun", #"hash_7e30cbacaffa9676");
	sndannouncervoxadd(#"bonus_points_team", #"hash_5540d7f63941a8b3");
	sndannouncervoxadd(#"bonus_points_player", #"hash_5540d7f63941a8b3");
	sndannouncervoxadd(#"bonus_points_player_shared", #"hash_5540d7f63941a8b3");
	sndannouncervoxadd(#"hero_weapon_power", #"hash_49a75f92b85c0f95");
	sndannouncervoxadd(#"zombie_blood", #"hash_2f095e1811169fc7");
	sndannouncervoxadd(#"bonfire_sale", #"hash_554659b1fbc7a5bd");
	sndannouncervoxadd(#"boxmove", #"hash_523d2f6c8930a8ee");
	sndannouncervoxadd(#"dogstart", #"hash_12ca8e434ec4d884");
	sndannouncervoxadd(#"hash_19b48fabd371ee3f", #"hash_1853f3e031b48c22");
	if(zm_utility::is_standard())
	{
		sndannouncervoxadd(#"game_start", #"hash_7d784b195050f75f");
		sndannouncervoxadd(#"hash_1ec72233df59f732", #"hash_646845f33ad513ae");
		sndannouncervoxadd(#"hash_1da7eef4cc220ec9", #"hash_50b840aeb746403");
		sndannouncervoxadd(#"hash_6805b30c4ae5c48e", #"hash_1a9b68e180865ba1");
		sndannouncervoxadd(#"hash_67fea40c4adf8c63", #"hash_1a9b65e180865688");
		sndannouncervoxadd(#"hash_387cfe32fb824ce", #"hash_1a9b66e18086583b");
		sndannouncervoxadd(#"hash_380c0e32fb1eca3", #"hash_1a9b6be1808660ba");
		sndannouncervoxadd(#"hash_37d3de32faed833", #"hash_1a9b6ce18086626d");
		sndannouncervoxadd(#"hash_6f8668b64fa3cfaf", #"hash_3867b4fd5932968a");
		sndannouncervoxadd(#"hash_5b141f82a55645a9", #"hash_70503fc906187e02");
		sndannouncervoxadd(#"specialty_phdflopper", #"hash_7b66342b9cdb1b0d");
		sndannouncervoxadd(#"hash_37aa3a5919757781", #"hash_4b9e2835c9165954");
		sndannouncervoxadd(#"specialty_shield", #"hash_21a6409eae2b8aa9");
		sndannouncervoxadd(#"hash_5706909bc1db0f85", #"hash_4fb2d077e5dcb19c");
		sndannouncervoxadd(#"specialty_extraammo", #"hash_52fd3e1c86fae905");
		sndannouncervoxadd(#"specialty_deadshot", #"hash_7d9ebc736dc5c25d");
		sndannouncervoxadd(#"specialty_quickrevive", #"hash_7a34372ef3e6346a");
		sndannouncervoxadd(#"specialty_electriccherry", #"hash_29f880b55da36b01");
		sndannouncervoxadd(#"specialty_additionalprimaryweapon", #"hash_674b1b55a9da1d5d");
		sndannouncervoxadd(#"specialty_widowswine", #"hash_12cddd02a9942f4");
		sndannouncervoxadd(#"specialty_staminup", #"hash_aa9d8fbea60223c");
		sndannouncervoxadd(#"hash_34c7d1e8a059f87e", #"hash_7eede5144457270f");
		sndannouncervoxadd(#"hash_6da63d760c1788e2", #"hash_5cc1d7e95e2997f1");
		sndannouncervoxadd(#"hash_36b9957a693185ea", #"hash_128987fbb6bdfef");
		sndannouncervoxadd(#"hash_4519dc1d3ac79139", #"hash_10a34f0962908792");
		sndannouncervoxadd(#"hash_377149a415143f1b", #"hash_406c5704d041fd85");
		sndannouncervoxadd(#"perk_generic", #"hash_43dafce207fa7ff4");
		sndannouncervoxadd(#"hash_3fee8792a6abec06", #"hash_279b4769ea79b472");
		sndannouncervoxadd(#"extra_life", #"hash_788159511078e87f");
		sndannouncervoxadd(#"hash_1abc3796d2516587", #"hash_639624432c8aa9a9");
		sndannouncervoxadd(#"hash_554c3930bc5813d4", #"hash_5cc0ecbbf45f025d");
		sndannouncervoxadd(#"hash_23b7754ca08b8e1b", #"hash_2014f409889112e");
		sndannouncervoxadd(#"hash_745ad4406b6608e7", #"hash_50e18452b9e9f79c");
		sndannouncervoxadd(#"hash_1d0c325eadefe6a1", #"hash_162307bf1d9cd28a");
		sndannouncervoxadd(#"hash_7d4064a8d03e0606", #"hash_1903816aeeed7cdb");
		sndannouncervoxadd(#"hash_1b1ab77bf244b15b", #"hash_643588a5ac2630e9");
		sndannouncervoxadd(#"defend_start", #"hash_52b5e94b0f834e89");
		sndannouncervoxadd(#"defend_complete", #"hash_54ce3eea0889438");
		sndannouncervoxadd(#"player_out", #"hash_46140c2ff7ed0028");
		sndannouncervoxadd(#"hash_1e0175fdcfa89dbb", #"hash_445a8d6ac36b6ce4");
		sndannouncervoxadd(#"player_respawn", #"hash_2c7fcf9c80b61898");
		sndannouncervoxadd(#"hash_5dea50269df90336", #"hash_12d38add4b1b4225");
		sndannouncervoxadd(#"hash_41990254d567065a", #"hash_75115605ce26435f");
		sndannouncervoxadd(#"hash_41990354d567080d", #"hash_75115505ce2641ac");
		sndannouncervoxadd(#"hash_4198f454d566ee90", #"hash_75115c05ce264d91");
		sndannouncervoxadd(#"hash_4198f554d566f043", #"hash_75115b05ce264bde");
		sndannouncervoxadd(#"hash_4198f654d566f1f6", #"hash_75115a05ce264a2b");
		sndannouncervoxadd(#"hash_4198f754d566f3a9", #"hash_75115905ce264878");
		sndannouncervoxadd(#"hash_4198f854d566f55c", #"hash_75116005ce26545d");
		sndannouncervoxadd(#"hash_4198f954d566f70f", #"hash_75115f05ce2652aa");
		sndannouncervoxadd(#"hash_4198fa54d566f8c2", #"hash_75115e05ce2650f7");
		sndannouncervoxadd(#"hash_72c41c0eef65bb72", #"hash_442eb3cbb773a1ff");
		sndannouncervoxadd(#"lead_lost", #"hash_3de4c149127a437b");
		sndannouncervoxadd(#"hash_784cbfe750be656c", #"hash_35d45a5646f89aa5");
		sndannouncervoxadd(#"hash_1cd6763f49f8b829", #"hash_519c3a0ce3e3266e");
		sndannouncervoxadd(#"hash_207d901d1a9487e1", #"hash_38d8439ae5fc2c7a");
		sndannouncervoxadd(#"hash_15d8616ab0b6f870", #"hash_c085a88269ae2cf");
		sndannouncervoxadd(#"player_down", #"hash_3dca2528566ddf10");
		sndannouncervoxadd(#"hash_435dce8984528996", #"hash_67b680cea28e5157");
		sndannouncervoxadd(#"hash_77e06980e2fc1567", #"hash_5100f8a2b1c77bd4");
		sndannouncervoxadd(#"hash_79b3b9e8ed3f0631", #"hash_1f56554135705816");
		sndannouncervoxadd(#"hash_3acd6d72567def3a", #"hash_4a4a214d167991b");
		sndannouncervoxadd(#"carpenter", #"hash_642d1c987098b98a");
		sndannouncervoxadd(#"insta_kill", #"hash_709765ed03192a2d");
		sndannouncervoxadd(#"double_points", #"hash_660aab11b5d4ebe4");
		sndannouncervoxadd(#"nuke", #"hash_4918bf9ec93d41df");
		sndannouncervoxadd(#"full_ammo", #"hash_52598fa43214b60b");
		sndannouncervoxadd(#"fire_sale", #"hash_3f9078bc10e0529d");
		sndannouncervoxadd(#"bonus_points_team", #"hash_451ad4649125eabb");
		sndannouncervoxadd(#"bonus_points_player_shared", #"hash_451ad4649125eabb");
		sndannouncervoxadd(#"hero_weapon_power", #"hash_93327b9599b606d");
		sndannouncervoxadd(#"hellhound", #"hash_1ee46eef183307d9");
		sndannouncervoxadd(#"hash_3a6c12bfc807aa2", #"hash_133c3414ba1817b5");
		sndannouncervoxadd(#"zmb_tigers", #"hash_33120300ceee6b04");
		sndannouncervoxadd(#"tigers", #"hash_6ee21c358714ed5a");
		sndannouncervoxadd(#"catalyst", #"hash_51aa5a9d6896a049");
		sndannouncervoxadd(#"hash_15bbfece95507937", #"hash_5b183378b7f2428e");
		sndannouncervoxadd(#"stoker", #"hash_5eb48315f77f748c");
		sndannouncervoxadd(#"stokers", #"hash_6c2fbd538d93cd4d");
		sndannouncervoxadd(#"blightfather", #"hash_243f4785815444b2");
		sndannouncervoxadd(#"hash_1bc37979ddc73c52", #"hash_6bcb48dac230d3f3");
		sndannouncervoxadd(#"marauder", #"hash_2fff3bb943f4b1af");
		sndannouncervoxadd(#"marauders", #"hash_36457ce78ca38d4");
		sndannouncervoxadd(#"destroyer", #"hash_771d36fe61955de3");
		sndannouncervoxadd(#"destroyers", #"hash_7c02023fd0cdfbb0");
		sndannouncervoxadd(#"warden", #"hash_48ad0ff98fe175ef");
		sndannouncervoxadd(#"hash_2f7e9fb76f9087d5", #"hash_5f87c10f7c1ad814");
		sndannouncervoxadd(#"werewolf", #"hash_23c5292237128e03");
		sndannouncervoxadd(#"nosferatu", #"hash_38bb4e0a7dfc9a1d");
		sndannouncervoxadd(#"hash_e5dacec7371220e", #"hash_6e2246878a31d24d");
		sndannouncervoxadd(#"hash_5d3e3c928faf3015", #"hash_2fabde0f1747632a");
		sndannouncervoxadd(#"bombers", #"hash_5bfc95be3db89d7e");
		sndannouncervoxadd(#"hash_6acb03a0373891c1", #"hash_2629e8b3b9215214");
		sndannouncervoxadd(#"electric_zombie", #"hash_3a33b9a23485f075");
	}
}

/*
	Name: sndannouncervoxadd
	Namespace: zm_audio
	Checksum: 0x79D653C0
	Offset: 0x84A8
	Size: 0x56
	Parameters: 2
	Flags: Linked
*/
function sndannouncervoxadd(type, suffix)
{
	if(!isdefined(level.zmannouncervox))
	{
		level.zmannouncervox = array();
	}
	level.zmannouncervox[type] = suffix;
}

/*
	Name: sndannouncerplayvox
	Namespace: zm_audio
	Checksum: 0x439F7D44
	Offset: 0x8508
	Size: 0x506
	Parameters: 6
	Flags: Linked
*/
function sndannouncerplayvox(type, player, str_sound, var_e08a84d6, b_wait_if_busy = 0, var_92885147 = 0)
{
	if(isdefined(level.var_bec5bf67))
	{
		b_exit = self [[level.var_bec5bf67]](type);
		if(b_exit)
		{
			return;
		}
	}
	if(!isdefined(str_sound))
	{
		prefix = level.zmannouncerprefix;
		suffix = level.zmannouncervox[type];
		if(isdefined(prefix) && isdefined(suffix))
		{
			if(isdefined(var_e08a84d6))
			{
				str_sound = suffix + "_" + prefix + "_" + var_e08a84d6;
			}
			else
			{
				str_sound = array::random(get_valid_lines(suffix + "_" + prefix));
			}
		}
	}
	if(!isdefined(str_sound))
	{
		return;
	}
	n_wait = float(soundgetplaybacktime(str_sound)) / 1000;
	n_wait = max(n_wait - 2, 2.5);
	if(isplayer(player))
	{
		player endon(#"disconnect");
		if(!isdefined(player.var_85ea4daf))
		{
			player.var_85ea4daf = [];
		}
		if(var_92885147)
		{
			arrayinsert(player.var_85ea4daf, str_sound, 0);
		}
		else if(!isdefined(player.var_85ea4daf))
		{
			player.var_85ea4daf = [];
		}
		else if(!isarray(player.var_85ea4daf))
		{
			player.var_85ea4daf = array(player.var_85ea4daf);
		}
		player.var_85ea4daf[player.var_85ea4daf.size] = str_sound;
		if(isdefined(player.zmannouncertalking) && player.zmannouncertalking && (b_wait_if_busy || var_92885147))
		{
			do
			{
				player waittill(#"hash_26a44682c9fd6f62");
			}
			while(isdefined(player.var_85ea4daf[0]) && player.var_85ea4daf[0] != str_sound);
		}
		if(!(isdefined(player.zmannouncertalking) && player.zmannouncertalking))
		{
			player.zmannouncertalking = 1;
			/#
				if(getdvarint(#"debug_audio", 0))
				{
					if(!soundexists(str_sound))
					{
						var_2dbe34fe = "" + "" + function_9e72a96(str_sound) + "";
						iprintlnbold(var_2dbe34fe);
						println(var_2dbe34fe);
					}
				}
			#/
			player playsoundtoplayer(str_sound, player);
			wait(n_wait);
			player.zmannouncertalking = undefined;
			player notify(#"hash_26a44682c9fd6f62", {#str_sound:str_sound});
		}
		arrayremovevalue(player.var_85ea4daf, str_sound);
	}
	else
	{
		foreach(player in level.players)
		{
			level thread sndannouncerplayvox(type, player, str_sound, var_e08a84d6, b_wait_if_busy, var_92885147);
		}
		wait(n_wait);
	}
}

/*
	Name: sndperksjingles_timer
	Namespace: zm_audio
	Checksum: 0x6FD7ED0F
	Offset: 0x8A18
	Size: 0xA8
	Parameters: 0
	Flags: Linked
*/
function sndperksjingles_timer()
{
	self endon(#"death");
	if(isdefined(self.sndjinglecooldown))
	{
		self.sndjinglecooldown = 0;
	}
	while(true)
	{
		wait(randomfloatrange(30, 60));
		if(randomintrange(0, 100) <= 10 && (!(isdefined(self.sndjinglecooldown) && self.sndjinglecooldown)))
		{
			self thread sndperksjingles_player(0);
		}
	}
}

/*
	Name: sndperksjingles_player
	Namespace: zm_audio
	Checksum: 0x7BEA25BF
	Offset: 0x8AC8
	Size: 0x1A6
	Parameters: 1
	Flags: Linked
*/
function sndperksjingles_player(type)
{
	self endon(#"death");
	if(!isdefined(self.sndjingleactive))
	{
		self.sndjingleactive = 0;
	}
	alias = self.stub.script_sound;
	if(type == 1)
	{
		alias = self.stub.script_label;
	}
	if(isdefined(level.musicsystem) && level.musicsystem.currentplaytype >= 4)
	{
		return;
	}
	self.str_jingle_alias = alias;
	if(!(isdefined(self.sndjingleactive) && self.sndjingleactive))
	{
		self.sndjingleactive = 1;
		self playsoundwithnotify(alias, "sndDone");
		playbacktime = float(max((isdefined(soundgetplaybacktime(alias)) ? soundgetplaybacktime(alias) : 500), 500)) / 1000;
		wait(playbacktime);
		if(type == 0)
		{
			self.sndjinglecooldown = 1;
			self thread sndperksjingles_cooldown();
		}
		self.sndjingleactive = 0;
	}
}

/*
	Name: sndperksjingles_cooldown
	Namespace: zm_audio
	Checksum: 0x6D7AB571
	Offset: 0x8C78
	Size: 0x56
	Parameters: 0
	Flags: Linked
*/
function sndperksjingles_cooldown()
{
	self endon(#"death");
	if(isdefined(self.var_b5b4d60a))
	{
		while(isdefined(self.var_b5b4d60a) && self.var_b5b4d60a)
		{
			wait(1);
		}
	}
	wait(45);
	self.sndjinglecooldown = 0;
}

/*
	Name: water_vox
	Namespace: zm_audio
	Checksum: 0xE7BF37D
	Offset: 0x8CD8
	Size: 0x190
	Parameters: 0
	Flags: Linked
*/
function water_vox()
{
	self endon(#"disconnect");
	level endon(#"end_game");
	self.voxunderwatertime = 0;
	self.voxemergebreath = 0;
	self.voxdrowning = 0;
	while(true)
	{
		if(!isalive(self))
		{
			wait(1);
			continue;
		}
		if(self isplayerunderwater())
		{
			if(!self.voxunderwatertime && !self.voxemergebreath)
			{
				self vo_clear_underwater();
				self.voxunderwatertime = gettime();
			}
			else if(self.voxunderwatertime)
			{
				if(gettime() > self.voxunderwatertime + 3000)
				{
					self.voxunderwatertime = 0;
					self.voxemergebreath = 1;
				}
			}
		}
		else if(self.voxdrowning)
		{
			self playerexert("underwater_gasp");
			self.voxdrowning = 0;
			self.voxemergebreath = 0;
		}
		if(self.voxemergebreath)
		{
			self playerexert("underwater_emerge");
			self.voxemergebreath = 0;
		}
		else
		{
			self.voxunderwatertime = 0;
		}
		waitframe(1);
	}
}

/*
	Name: vo_clear_underwater
	Namespace: zm_audio
	Checksum: 0x1000A111
	Offset: 0x8E70
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function vo_clear_underwater()
{
	if(level flag::exists("abcd_speaking"))
	{
		if(level flag::get("abcd_speaking"))
		{
			return;
		}
	}
	if(level flag::exists("shadowman_speaking"))
	{
		if(level flag::get("shadowman_speaking"))
		{
			return;
		}
	}
	self stopsounds();
	zm_vo::function_57b8cd17();
}

/*
	Name: sndplayerhitalert
	Namespace: zm_audio
	Checksum: 0x3A2A2F4B
	Offset: 0x8F28
	Size: 0x17C
	Parameters: 6
	Flags: Linked
*/
function sndplayerhitalert(e_victim, str_meansofdeath, e_inflictor, weapon, shitloc, damage)
{
	str_alias = #"zmb_hit_alert";
	if(!isdefined(e_inflictor))
	{
		return;
	}
	if(!isplayer(e_inflictor) && !isplayer(e_inflictor.owner))
	{
		return;
	}
	if(!checkforvalidmod(str_meansofdeath))
	{
		return;
	}
	if(!checkforvalidweapon(weapon))
	{
		return;
	}
	if(!checkforvalidaitype(e_victim))
	{
		return;
	}
	if(isdefined(e_victim.health) && e_victim.health <= 0)
	{
		return;
	}
	if(e_victim zm_utility::is_headshot(weapon, shitloc, str_meansofdeath))
	{
		str_alias = str_alias + "_headshot";
	}
	if(function_185bb766(e_victim, damage))
	{
		str_alias = str_alias + "_fatal";
	}
	self thread sndplayerhitalert_playsound(str_alias);
}

/*
	Name: sndplayerhitalert_playsound
	Namespace: zm_audio
	Checksum: 0x39406EA8
	Offset: 0x90B0
	Size: 0x72
	Parameters: 1
	Flags: Linked
*/
function sndplayerhitalert_playsound(str_alias)
{
	self endon(#"disconnect");
	if(isdefined(self.hitsoundtracker) && self.hitsoundtracker)
	{
		self.hitsoundtracker = 0;
		self playsoundtoplayer(str_alias, self);
		wait(0.05);
		self.hitsoundtracker = 1;
	}
}

/*
	Name: checkforvalidmod
	Namespace: zm_audio
	Checksum: 0x28D52E91
	Offset: 0x9130
	Size: 0x96
	Parameters: 1
	Flags: Linked
*/
function checkforvalidmod(str_meansofdeath)
{
	if(!isdefined(str_meansofdeath))
	{
		return 0;
	}
	switch(str_meansofdeath)
	{
		case "mod_melee_weapon_butt":
		case "mod_crush":
		case "mod_hit_by_object":
		case "mod_grenade_splash":
		case "mod_melee_assassinate":
		case "mod_melee":
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: checkforvalidweapon
	Namespace: zm_audio
	Checksum: 0xC2D7B951
	Offset: 0x91D0
	Size: 0xCE
	Parameters: 1
	Flags: Linked
*/
function checkforvalidweapon(weapon)
{
	var_439ed98e = 1;
	switch(weapon.name)
	{
		case "hash_42a45d43be3dba42":
		case "hash_78e66b21aa05c753":
		{
			var_439ed98e = 0;
			break;
		}
		case "hash_18829d56b3fbd75b":
		case "hash_18829e56b3fbd90e":
		case "hash_18829f56b3fbdac1":
		case "hash_50f35c4cfb775a9c":
		case "hash_50f35d4cfb775c4f":
		case "hash_50f35e4cfb775e02":
		{
			var_439ed98e = 0;
			break;
		}
	}
	return var_439ed98e;
}

/*
	Name: checkforvalidaitype
	Namespace: zm_audio
	Checksum: 0xC6671587
	Offset: 0x92A8
	Size: 0x10
	Parameters: 1
	Flags: Linked
*/
function checkforvalidaitype(e_victim)
{
	return 1;
}

/*
	Name: function_185bb766
	Namespace: zm_audio
	Checksum: 0x6BF7E66B
	Offset: 0x92C0
	Size: 0x3A
	Parameters: 2
	Flags: Linked
*/
function function_185bb766(e_victim, damage)
{
	if(isdefined(damage) && damage >= e_victim.health)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_320145f7
	Namespace: zm_audio
	Checksum: 0x2CE38B4
	Offset: 0x9308
	Size: 0x2CA
	Parameters: 1
	Flags: Event
*/
event function_320145f7(eventstruct)
{
	if(isdefined(self.var_b467f3a1))
	{
		self thread [[self.var_b467f3a1]](eventstruct);
		return;
	}
	notify_string = eventstruct.action;
	switch(notify_string)
	{
		case "death":
		{
			if(isdefined(self.bgb_tone_death) && self.bgb_tone_death)
			{
				level thread zmbaivox_playvox(self, "death_whimsy", 1, 4);
			}
			else if(isdefined(self.sinkhole_charges_detonatedteleportterminate) && self.sinkhole_charges_detonatedteleportterminate)
			{
				level thread zmbaivox_playvox(self, "death_quack", 1, 4);
			}
			else
			{
				level thread zmbaivox_playvox(self, notify_string, 1, 4);
			}
			break;
		}
		case "pain":
		{
			level thread zmbaivox_playvox(self, notify_string, 1, 3);
			break;
		}
		case "behind":
		{
			level thread zmbaivox_playvox(self, notify_string, 1, 3);
			break;
		}
		case "electrocute":
		{
			level thread zmbaivox_playvox(self, notify_string, 1, 3);
			break;
		}
		case "attack_melee_notetrack":
		{
			level thread zmbaivox_playvox(self, "attack_melee", 1, 2, 1);
			break;
		}
		case "sprint":
		case "ambient":
		case "crawler":
		case "teardown":
		case "taunt":
		{
			level thread zmbaivox_playvox(self, notify_string, 0, 1);
			break;
		}
		case "attack_melee":
		{
			break;
		}
		default:
		{
			level thread zmbaivox_playvox(self, notify_string, 0, 2);
			break;
		}
	}
}

/*
	Name: zmbaivox_notifyconvert
	Namespace: zm_audio
	Checksum: 0x3EA94FD6
	Offset: 0x95E0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function zmbaivox_notifyconvert()
{
	self endon(#"death", #"disconnect");
	level endon(#"game_ended");
	self thread zmbaivox_playdeath();
	self thread zmbaivox_playelectrocution();
}

/*
	Name: zmbaivox_playvox
	Namespace: zm_audio
	Checksum: 0x740AD18B
	Offset: 0x9650
	Size: 0x39E
	Parameters: 5
	Flags: Linked
*/
function zmbaivox_playvox(zombie, type, override, priority, delayambientvox = 0)
{
	zombie endon(#"death");
	if(!isdefined(zombie))
	{
		return;
	}
	if(!isdefined(zombie.voiceprefix))
	{
		return;
	}
	if(!isdefined(priority))
	{
		priority = 1;
	}
	if(!isdefined(zombie.talking))
	{
		zombie.talking = 0;
	}
	if(!isdefined(zombie.currentvoxpriority))
	{
		zombie.currentvoxpriority = 1;
	}
	if(!isdefined(self.delayambientvox))
	{
		self.delayambientvox = 0;
	}
	if(isdefined(zombie.var_e8920729) && zombie.var_e8920729)
	{
		return;
	}
	if(type == "ambient" || type == "sprint" || type == "crawler" && (isdefined(self.delayambientvox) && self.delayambientvox))
	{
		return;
	}
	if(delayambientvox)
	{
		self.delayambientvox = 1;
		self thread zmbaivox_ambientdelay();
	}
	alias = "zmb_vocals_" + zombie.voiceprefix + "_" + type;
	if(sndisnetworksafe())
	{
		if(isdefined(override) && override)
		{
			if(isdefined(zombie.currentvox) && priority > zombie.currentvoxpriority)
			{
				zombie stopsound(zombie.currentvox);
				waitframe(1);
			}
			if(type == "death" || type == "death_whimsy" || type == "death_nohead")
			{
				zombie playsound(alias);
				return;
			}
		}
		if(zombie.talking === 1 && (priority < zombie.currentvoxpriority || priority === 1))
		{
			return;
		}
		zombie.talking = 1;
		zombie.currentvox = alias;
		zombie.currentvoxpriority = priority;
		zombie playsoundontag(alias, "j_head");
		playbacktime = float(max((isdefined(soundgetplaybacktime(alias)) ? soundgetplaybacktime(alias) : 500), 500)) / 1000;
		wait(playbacktime);
		zombie.talking = 0;
		zombie.currentvox = undefined;
		zombie.currentvoxpriority = 1;
	}
}

/*
	Name: zmbaivox_playdeath
	Namespace: zm_audio
	Checksum: 0xBEF9B230
	Offset: 0x99F8
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function zmbaivox_playdeath()
{
	self endon(#"disconnect");
	self waittill(#"death");
	if(isdefined(self))
	{
		if(isdefined(self.bgb_tone_death) && self.bgb_tone_death)
		{
			level thread zmbaivox_playvox(self, "death_whimsy", 1);
		}
		else if(isdefined(self.head_gibbed) && self.head_gibbed)
		{
			level thread zmbaivox_playvox(self, "death_nohead", 1);
		}
		else
		{
			level thread zmbaivox_playvox(self, "death", 1);
		}
	}
}

/*
	Name: zmbaivox_playelectrocution
	Namespace: zm_audio
	Checksum: 0xE631BF77
	Offset: 0x9AE0
	Size: 0x122
	Parameters: 0
	Flags: Linked
*/
function zmbaivox_playelectrocution()
{
	self endon(#"disconnect", #"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		weapon = waitresult.weapon;
		if(!isdefined(weapon))
		{
			continue;
		}
		if(weapon.name === #"zombie_beast_lightning_dwl" || weapon.name === #"zombie_beast_lightning_dwl2" || weapon.name === #"zombie_beast_lightning_dwl3")
		{
			function_6eac4ca1(self, "electrocute");
			self notify(#"bhtn_action_notify", {#action:"electrocute"});
		}
	}
}

/*
	Name: zmbaivox_ambientdelay
	Namespace: zm_audio
	Checksum: 0xEA4D0E83
	Offset: 0x9C10
	Size: 0x5A
	Parameters: 0
	Flags: Linked
*/
function zmbaivox_ambientdelay()
{
	self notify(#"sndambientdelay");
	self endon(#"sndambientdelay", #"death", #"disconnect");
	wait(2);
	self.delayambientvox = 0;
}

/*
	Name: networksafereset
	Namespace: zm_audio
	Checksum: 0x2115B6CC
	Offset: 0x9C78
	Size: 0x30
	Parameters: 0
	Flags: Linked
*/
function networksafereset()
{
	while(true)
	{
		level._numzmbaivox = 0;
		util::wait_network_frame();
	}
}

/*
	Name: sndisnetworksafe
	Namespace: zm_audio
	Checksum: 0xB4CA677E
	Offset: 0x9CB0
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function sndisnetworksafe()
{
	if(!isdefined(level._numzmbaivox))
	{
		level thread networksafereset();
	}
	if(level._numzmbaivox >= 2)
	{
		return 0;
	}
	level._numzmbaivox++;
	return 1;
}

/*
	Name: is_last_zombie
	Namespace: zm_audio
	Checksum: 0x4A8DB34D
	Offset: 0x9D10
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function is_last_zombie()
{
	if(zombie_utility::get_current_zombie_count() <= 1)
	{
		return 1;
	}
	return 0;
}

/*
	Name: zombie_behind_vox
	Namespace: zm_audio
	Checksum: 0xBC0B4277
	Offset: 0x9D40
	Size: 0x398
	Parameters: 0
	Flags: Linked
*/
function zombie_behind_vox()
{
	level endon(#"unloaded");
	self endon(#"death", #"disconnect");
	if(!isdefined(level._zbv_vox_last_update_time))
	{
		level._zbv_vox_last_update_time = 0;
		level._audio_zbv_shared_ent_list = zombie_utility::get_zombie_array();
	}
	while(true)
	{
		wait(1);
		t = gettime();
		if(t > level._zbv_vox_last_update_time + 1000)
		{
			level._zbv_vox_last_update_time = t;
			level._audio_zbv_shared_ent_list = zombie_utility::get_zombie_array();
		}
		zombs = level._audio_zbv_shared_ent_list;
		played_sound = 0;
		for(i = 0; i < zombs.size; i++)
		{
			if(!isdefined(zombs[i]))
			{
				continue;
			}
			if(zombs[i].isdog)
			{
				continue;
			}
			dist = 150;
			z_dist = 50;
			alias = level.vox_behind_zombie;
			if(isdefined(zombs[i].zombie_move_speed))
			{
				switch(zombs[i].zombie_move_speed)
				{
					case "walk":
					{
						dist = 150;
						break;
					}
					case "run":
					{
						dist = 175;
						break;
					}
					case "sprint":
					{
						dist = 200;
						break;
					}
				}
			}
			if(distancesquared(zombs[i].origin, self.origin) < dist * dist)
			{
				yaw = self zm_utility::getyawtospot(zombs[i].origin);
				z_diff = self.origin[2] - zombs[i].origin[2];
				if(yaw < -95 || yaw > 95 && abs(z_diff) < 50)
				{
					wait(0.1);
					if(isdefined(zombs[i]) && isalive(zombs[i]))
					{
						function_6eac4ca1(zombs[i], "behind");
						zombs[i] notify(#"bhtn_action_notify", {#action:"behind"});
						played_sound = 1;
					}
					break;
				}
			}
		}
		if(played_sound)
		{
			wait(2.5);
		}
	}
}

/*
	Name: play_ambient_zombie_vocals
	Namespace: zm_audio
	Checksum: 0xD24D2E4D
	Offset: 0xA0E0
	Size: 0x1A0
	Parameters: 0
	Flags: Linked
*/
function play_ambient_zombie_vocals()
{
	self endon(#"death");
	while(true)
	{
		type = "ambient";
		float = 3;
		if(isdefined(self.zombie_move_speed))
		{
			switch(self.zombie_move_speed)
			{
				case "walk":
				{
					type = "ambient";
					float = 3;
					break;
				}
				case "run":
				{
					type = "sprint";
					float = 3;
					break;
				}
				case "sprint":
				{
					type = "sprint";
					float = 3;
					break;
				}
			}
		}
		if(isdefined(self.script_noteworthy) && self.script_noteworthy == "zombie_catalyst_spawner")
		{
			float = 2.5;
		}
		else if(isdefined(self.missinglegs) && self.missinglegs)
		{
			float = 2;
			type = "crawler";
		}
		function_6eac4ca1(self, type);
		self notify(#"bhtn_action_notify", {#action:type});
		wait(randomfloatrange(1, float));
	}
}

/*
	Name: function_713192b1
	Namespace: zm_audio
	Checksum: 0xF7B54F6F
	Offset: 0xA288
	Size: 0xA2
	Parameters: 2
	Flags: Linked
*/
function function_713192b1(str_location, var_39acfdda)
{
	if(!isdefined(level.var_cbcee8da))
	{
		level.var_cbcee8da = [];
	}
	if(!isdefined(level.var_b2a9a8d7))
	{
		level.var_b2a9a8d7 = [];
	}
	if(!isdefined(level.var_cbcee8da[var_39acfdda]))
	{
		level.var_cbcee8da[var_39acfdda] = 0;
	}
	if(!isdefined(level.var_b2a9a8d7[str_location]))
	{
		level.var_b2a9a8d7[str_location] = var_39acfdda;
	}
}

/*
	Name: location_vox
	Namespace: zm_audio
	Checksum: 0x6E62AB67
	Offset: 0xA338
	Size: 0x126
	Parameters: 1
	Flags: Linked
*/
function location_vox(str_location)
{
	if(!isdefined(level.var_b2a9a8d7))
	{
		return;
	}
	if(!isdefined(level.var_b2a9a8d7[str_location]))
	{
		return;
	}
	var_39acfdda = level.var_b2a9a8d7[str_location];
	if(!isdefined(self.var_cbcee8da))
	{
		self.var_cbcee8da = [];
	}
	if(!isdefined(self.var_cbcee8da[var_39acfdda]))
	{
		self.var_cbcee8da[var_39acfdda] = 0;
	}
	if(!level.var_cbcee8da[var_39acfdda] && !self.var_cbcee8da[var_39acfdda])
	{
		self.var_cbcee8da[var_39acfdda] = 1;
		b_played = create_and_play_dialog(#"hash_20b463357f4ae8f", var_39acfdda);
		if(isdefined(b_played) && b_played)
		{
			level.var_cbcee8da[var_39acfdda] = 1;
		}
	}
}

/*
	Name: get_number_variants
	Namespace: zm_audio
	Checksum: 0x66DC437F
	Offset: 0xA468
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function get_number_variants(aliasprefix)
{
	for(i = 0; i < 20; i++)
	{
		if(!soundexists(aliasprefix + "_" + i))
		{
			return i;
		}
	}
	/#
		/#
			assertmsg("");
		#/
	#/
}

/*
	Name: get_valid_lines
	Namespace: zm_audio
	Checksum: 0x89DA4111
	Offset: 0xA4F0
	Size: 0x13A
	Parameters: 1
	Flags: Linked
*/
function get_valid_lines(aliasprefix)
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
			var_a5e8d5c7[var_a5e8d5c7.size] = str_alias;
			continue;
		}
		if(soundexists(aliasprefix))
		{
			if(!isdefined(var_a5e8d5c7))
			{
				var_a5e8d5c7 = [];
			}
			else if(!isarray(var_a5e8d5c7))
			{
				var_a5e8d5c7 = array(var_a5e8d5c7);
			}
			var_a5e8d5c7[var_a5e8d5c7.size] = aliasprefix;
			break;
		}
	}
	return var_a5e8d5c7;
}

