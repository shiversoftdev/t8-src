// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_bc839bb0e693558;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\contracts_shared.gsc;
#using scripts\core_common\rank_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace scoreevents;

/*
	Name: function_6f51d1e9
	Namespace: scoreevents
	Checksum: 0x6C178449
	Offset: 0x140
	Size: 0xB8
	Parameters: 4
	Flags: None
*/
function function_6f51d1e9(event, players, victim, weapon)
{
	if(!isdefined(players))
	{
		return;
	}
	foreach(player in players)
	{
		if(!isdefined(player))
		{
			continue;
		}
		processscoreevent(event, player, victim, weapon);
	}
}

/*
	Name: processscoreevent
	Namespace: scoreevents
	Checksum: 0x8E08FE88
	Offset: 0x200
	Size: 0x674
	Parameters: 5
	Flags: Linked
*/
function processscoreevent(event, player, victim, weapon, var_36f23f1f)
{
	scoregiven = 0;
	if(isdefined(level.scoreinfo[event]) && (isdefined(level.scoreinfo[event][#"hash_7b64eabf26f777c7"]) && level.scoreinfo[event][#"hash_7b64eabf26f777c7"]))
	{
		return scoregiven;
	}
	if(isdefined(level.var_64ce2685) && level.var_64ce2685)
	{
		return scoregiven;
	}
	if(!isplayer(player))
	{
		return scoregiven;
	}
	pixbeginevent(#"processscoreevent");
	isscoreevent = 0;
	/#
		if(getdvarint(#"hash_39060c853726e6c0", 0) > 0)
		{
			if(!isdefined(level.var_10cd7193))
			{
				level.var_10cd7193 = [];
			}
			eventstr = (function_7a600918(event) ? function_9e72a96(event) : event);
			if(!isdefined(level.var_10cd7193))
			{
				level.var_10cd7193 = [];
			}
			else if(!isarray(level.var_10cd7193))
			{
				level.var_10cd7193 = array(level.var_10cd7193);
			}
			level.var_10cd7193[level.var_10cd7193.size] = eventstr;
		}
	#/
	if(isdefined(level.challengesoneventreceived))
	{
		player thread [[level.challengesoneventreceived]](event);
	}
	if(isdefined(level.var_6c0f31f5))
	{
		params = {};
		params.event = event;
		params.victim = victim;
		player [[level.var_6c0f31f5]](params);
	}
	if(isregisteredevent(event) && (!sessionmodeiszombiesgame() || level.onlinegame))
	{
		if(isdefined(level.scoreongiveplayerscore))
		{
			scoregiven = [[level.scoreongiveplayerscore]](event, player, victim, undefined, weapon, var_36f23f1f);
			if(scoregiven > 0)
			{
				player ability_power::power_gain_event_score(event, victim, scoregiven, weapon);
			}
		}
	}
	if(shouldaddrankxp(player) && (!isdefined(victim) || (!(isdefined(victim.disable_score_events) && victim.disable_score_events))))
	{
		pickedup = 0;
		if(isdefined(weapon) && isdefined(player.pickedupweapons) && isdefined(player.pickedupweapons[weapon]))
		{
			pickedup = 1;
		}
		xp_difficulty_multiplier = 1;
		if(isdefined(level.var_3426461d))
		{
			xp_difficulty_multiplier = [[level.var_3426461d]]();
		}
		player addrankxp(event, weapon, player.class_num, pickedup, isscoreevent, xp_difficulty_multiplier);
		if(isdefined(event) && isdefined(weapon) && isdefined(level.scoreinfo[event]))
		{
			var_6d1793bb = level.scoreinfo[event][#"hash_17ffe407dca54dd7"];
			if(isdefined(var_6d1793bb))
			{
				specialistindex = player getspecialistindex();
				medalname = function_dcad256c(specialistindex, currentsessionmode(), 0);
				if(medalname == var_6d1793bb)
				{
					player.ability_medal_count = (isdefined(player.ability_medal_count) ? player.ability_medal_count : 0) + 1;
					player.pers["ability_medal_count" + specialistindex] = player.ability_medal_count;
				}
				medalname = function_dcad256c(specialistindex, currentsessionmode(), 1);
				if(medalname == var_6d1793bb)
				{
					player.equipment_medal_count = (isdefined(player.equipment_medal_count) ? player.equipment_medal_count : 0) + 1;
					player.pers["equipment_medal_count" + specialistindex] = player.equipment_medal_count;
				}
			}
		}
	}
	pixendevent();
	if(sessionmodeiscampaigngame() && isdefined(xp_difficulty_multiplier))
	{
		if(isdefined(victim) && isdefined(victim.team))
		{
			if(victim.team == #"axis" || victim.team == #"team3")
			{
				scoregiven = scoregiven * xp_difficulty_multiplier;
			}
		}
	}
	return scoregiven;
}

/*
	Name: shouldaddrankxp
	Namespace: scoreevents
	Checksum: 0xCD39143E
	Offset: 0x880
	Size: 0x16A
	Parameters: 1
	Flags: Linked
*/
function shouldaddrankxp(player)
{
	if(level.gametype == "fr")
	{
		return false;
	}
	if(level.gametype == "zclassic" && (isdefined(level.var_5164a0ca) && level.var_5164a0ca))
	{
		return false;
	}
	if(isdefined(level.var_4f654f3a) && level.var_4f654f3a)
	{
		/#
			playername = "";
			if(isdefined(player) && isdefined(player.name))
			{
				playername = player.name;
			}
			println("" + playername);
		#/
		return false;
	}
	if(!isdefined(level.rankcap) || level.rankcap == 0)
	{
		return true;
	}
	if(player.pers[#"plevel"] > 0 || player.pers[#"rank"] > level.rankcap)
	{
		return false;
	}
	return true;
}

/*
	Name: uninterruptedobitfeedkills
	Namespace: scoreevents
	Checksum: 0x3E35B6B6
	Offset: 0x9F8
	Size: 0x9C
	Parameters: 2
	Flags: None
*/
function uninterruptedobitfeedkills(attacker, weapon)
{
	self endon(#"disconnect");
	wait(0.1);
	util::waittillslowprocessallowed();
	wait(0.1);
	if(isdefined(attacker))
	{
		processscoreevent(#"uninterrupted_obit_feed_kills", attacker, self, weapon);
		attacker contracts::function_a54e2068(#"hash_2e97dac7aef215da");
	}
}

/*
	Name: function_c046c773
	Namespace: scoreevents
	Checksum: 0x294D3C02
	Offset: 0xAA0
	Size: 0x64
	Parameters: 5
	Flags: None
*/
function function_c046c773(waitduration, event, player, victim, weapon)
{
	self endon(#"disconnect");
	wait(waitduration);
	processscoreevent(event, player, victim, weapon);
}

/*
	Name: isregisteredevent
	Namespace: scoreevents
	Checksum: 0x90EAA5FF
	Offset: 0xB10
	Size: 0x2E
	Parameters: 1
	Flags: Linked
*/
function isregisteredevent(type)
{
	if(isdefined(level.scoreinfo[type]))
	{
		return true;
	}
	return false;
}

/*
	Name: decrementlastobituaryplayercountafterfade
	Namespace: scoreevents
	Checksum: 0x886EBE9F
	Offset: 0xB48
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function decrementlastobituaryplayercountafterfade()
{
	level endon(#"reset_obituary_count");
	wait(5);
	level.lastobituaryplayercount--;
	/#
		assert(level.lastobituaryplayercount >= 0);
	#/
}

/*
	Name: function_2b96d7dc
	Namespace: scoreevents
	Checksum: 0x2D42533B
	Offset: 0xBA0
	Size: 0x122
	Parameters: 0
	Flags: Linked
*/
function function_2b96d7dc()
{
	if(!isdefined(level.var_d1455682))
	{
		return undefined;
	}
	table_name = function_6a9e36d6();
	if(!isdefined(table_name))
	{
		return undefined;
	}
	args = strtok(table_name, "\\");
	if(args.size)
	{
		table_name = "";
		foreach(index, arg in args)
		{
			table_name = table_name + arg;
			if(index < args.size - 1)
			{
				table_name = table_name + ("/");
			}
		}
	}
	return hash(table_name);
}

/*
	Name: getscoreeventtablename
	Namespace: scoreevents
	Checksum: 0x40D2B611
	Offset: 0xCD0
	Size: 0x25A
	Parameters: 1
	Flags: Linked
*/
function getscoreeventtablename(gametype)
{
	table_name = function_2b96d7dc();
	if(isdefined(table_name) && (isdefined(isassetloaded("stringtable", table_name)) && isassetloaded("stringtable", table_name)))
	{
		return table_name;
	}
	if(!isdefined(gametype))
	{
		gametype = "base";
	}
	prefix = #"hash_44588d37c7fe1bf3";
	if(sessionmodeiscampaigngame())
	{
		prefix = #"hash_3bebadbc9db1102b";
	}
	else
	{
		if(sessionmodeiszombiesgame())
		{
			prefix = #"hash_5f114025234e912f";
		}
		else if(function_f99d2668())
		{
			prefix = #"hash_2bedaa060f1bcc0f";
		}
	}
	gametype = function_ea13f55(gametype, "_hc", "");
	gametype = function_ea13f55(gametype, "_cwl", "");
	gametype = function_ea13f55(gametype, "_bb", "");
	tablename = ((prefix + "_") + gametype) + ".csv";
	if(!(isdefined(isassetloaded("stringtable", tablename)) && isassetloaded("stringtable", tablename)))
	{
		tablename = prefix + "_base.csv";
	}
	if(isdefined(isassetloaded("stringtable", tablename)) && isassetloaded("stringtable", tablename))
	{
		return tablename;
	}
	return tablename;
}

/*
	Name: getscoreeventtableid
	Namespace: scoreevents
	Checksum: 0x4813999A
	Offset: 0xF38
	Size: 0xE8
	Parameters: 1
	Flags: None
*/
function getscoreeventtableid(gametype)
{
	scoreinfotableloaded = 0;
	tablename = getscoreeventtablename(gametype);
	scoreinfotableid = tablelookupfindcoreasset(tablename);
	if(!isdefined(scoreinfotableid))
	{
		tablelookupfindcoreasset(getscoreeventtablename("base"));
	}
	if(isdefined(scoreinfotableid))
	{
		scoreinfotableloaded = 1;
	}
	/#
		assert(scoreinfotableloaded, "" + function_9e72a96(getscoreeventtablename()));
	#/
	return scoreinfotableid;
}

/*
	Name: givecratecapturemedal
	Namespace: scoreevents
	Checksum: 0xB6F9D4DF
	Offset: 0x1028
	Size: 0x1EC
	Parameters: 2
	Flags: None
*/
function givecratecapturemedal(crate, capturer)
{
	if(isdefined(crate.owner) && isplayer(crate.owner))
	{
		if(level.teambased)
		{
			if(capturer.team != crate.owner.team)
			{
				crate.owner playlocalsound(#"mpl_crate_enemy_steals");
				if(!isdefined(crate.hacker))
				{
					processscoreevent(#"capture_enemy_crate", capturer, undefined, undefined);
				}
			}
			else if(isdefined(crate.owner) && capturer != crate.owner)
			{
				crate.owner playlocalsound(#"mpl_crate_friendly_steals");
				if(!isdefined(crate.hacker))
				{
					level.globalsharepackages++;
					processscoreevent(#"share_care_package", crate.owner, undefined, undefined);
				}
			}
		}
		else if(capturer != crate.owner)
		{
			crate.owner playlocalsound(#"mpl_crate_enemy_steals");
			if(!isdefined(crate.hacker))
			{
				processscoreevent(#"capture_enemy_crate", capturer, undefined, undefined);
			}
		}
	}
}

/*
	Name: register_hero_ability_kill_event
	Namespace: scoreevents
	Checksum: 0x80D37D99
	Offset: 0x1220
	Size: 0x46
	Parameters: 1
	Flags: None
*/
function register_hero_ability_kill_event(event_func)
{
	if(!isdefined(level.hero_ability_kill_events))
	{
		level.hero_ability_kill_events = [];
	}
	level.hero_ability_kill_events[level.hero_ability_kill_events.size] = event_func;
}

/*
	Name: register_hero_ability_multikill_event
	Namespace: scoreevents
	Checksum: 0xF7DA446A
	Offset: 0x1270
	Size: 0x46
	Parameters: 1
	Flags: None
*/
function register_hero_ability_multikill_event(event_func)
{
	if(!isdefined(level.hero_ability_multikill_events))
	{
		level.hero_ability_multikill_events = [];
	}
	level.hero_ability_multikill_events[level.hero_ability_multikill_events.size] = event_func;
}

/*
	Name: register_hero_weapon_multikill_event
	Namespace: scoreevents
	Checksum: 0xBD8B4D61
	Offset: 0x12C0
	Size: 0x46
	Parameters: 1
	Flags: None
*/
function register_hero_weapon_multikill_event(event_func)
{
	if(!isdefined(level.hero_weapon_multikill_events))
	{
		level.hero_weapon_multikill_events = [];
	}
	level.hero_weapon_multikill_events[level.hero_weapon_multikill_events.size] = event_func;
}

/*
	Name: register_thief_shutdown_enemy_event
	Namespace: scoreevents
	Checksum: 0xC5C04663
	Offset: 0x1310
	Size: 0x46
	Parameters: 1
	Flags: None
*/
function register_thief_shutdown_enemy_event(event_func)
{
	if(!isdefined(level.thief_shutdown_enemy_events))
	{
		level.thief_shutdown_enemy_events = [];
	}
	level.thief_shutdown_enemy_events[level.thief_shutdown_enemy_events.size] = event_func;
}

/*
	Name: hero_ability_kill_event
	Namespace: scoreevents
	Checksum: 0xD26A5ACE
	Offset: 0x1360
	Size: 0xA4
	Parameters: 2
	Flags: None
*/
function hero_ability_kill_event(ability, victim_ability)
{
	if(!isdefined(level.hero_ability_kill_events))
	{
		return;
	}
	foreach(event_func in level.hero_ability_kill_events)
	{
		if(isdefined(event_func))
		{
			self [[event_func]](ability, victim_ability);
		}
	}
}

/*
	Name: hero_ability_multikill_event
	Namespace: scoreevents
	Checksum: 0x41F47C2A
	Offset: 0x1410
	Size: 0xA4
	Parameters: 2
	Flags: None
*/
function hero_ability_multikill_event(killcount, ability)
{
	if(!isdefined(level.hero_ability_multikill_events))
	{
		return;
	}
	foreach(event_func in level.hero_ability_multikill_events)
	{
		if(isdefined(event_func))
		{
			self [[event_func]](killcount, ability);
		}
	}
}

/*
	Name: hero_weapon_multikill_event
	Namespace: scoreevents
	Checksum: 0x89927CE4
	Offset: 0x14C0
	Size: 0xA4
	Parameters: 2
	Flags: None
*/
function hero_weapon_multikill_event(killcount, weapon)
{
	if(!isdefined(level.hero_weapon_multikill_events))
	{
		return;
	}
	foreach(event_func in level.hero_weapon_multikill_events)
	{
		if(isdefined(event_func))
		{
			self [[event_func]](killcount, weapon);
		}
	}
}

/*
	Name: thief_shutdown_enemy_event
	Namespace: scoreevents
	Checksum: 0xB262480B
	Offset: 0x1570
	Size: 0x8E
	Parameters: 0
	Flags: None
*/
function thief_shutdown_enemy_event()
{
	if(!isdefined(level.thief_shutdown_enemy_event))
	{
		return;
	}
	foreach(event_func in level.thief_shutdown_enemy_event)
	{
		if(isdefined(event_func))
		{
			self [[event_func]]();
		}
	}
}

/*
	Name: function_dcdf1105
	Namespace: scoreevents
	Checksum: 0x7445A52C
	Offset: 0x1608
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function function_dcdf1105()
{
	self callback::add_callback(#"fully_healed", &player_fully_healed);
}

/*
	Name: player_fully_healed
	Namespace: scoreevents
	Checksum: 0xB9F795C0
	Offset: 0x1648
	Size: 0xE
	Parameters: 0
	Flags: Linked
*/
function player_fully_healed()
{
	self.var_ae639436 = undefined;
}

/*
	Name: player_spawned
	Namespace: scoreevents
	Checksum: 0x98CAFCF2
	Offset: 0x1660
	Size: 0x10
	Parameters: 0
	Flags: None
*/
function player_spawned()
{
	self.var_ae639436 = undefined;
}

/*
	Name: function_f40d64cc
	Namespace: scoreevents
	Checksum: 0x92E2B475
	Offset: 0x1678
	Size: 0xC4
	Parameters: 3
	Flags: None
*/
function function_f40d64cc(attacker, vehicle, weapon)
{
	if(!isdefined(weapon))
	{
		return;
	}
	switch(weapon.statname)
	{
		case "ultimate_turret":
		{
			event = "automated_turret_vehicle_destruction";
			break;
		}
		default:
		{
			return;
		}
	}
	victim = (isdefined(vehicle) ? vehicle.owner : undefined);
	processscoreevent(event, attacker, victim, weapon);
}

