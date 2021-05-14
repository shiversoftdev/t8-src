// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_18f0d22c75b141a7;
#using script_2dc48f46bfeac894;
#using script_47fb62300ac0bd60;
#using script_5399f402045d7abd;
#using script_545a0bac37bda541;
#using script_57f7003580bb15e0;
#using script_6c8abe14025b47c4;
#using script_7133a4d461308099;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\contracts_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\weapons_shared.gsc;
#using scripts\mp_common\challenges.gsc;
#using scripts\mp_common\gametypes\match.gsc;
#using scripts\mp_common\util.gsc;

#namespace scoreevents;

/*
	Name: function_89f2df9
	Namespace: scoreevents
	Checksum: 0xFB8FC2F7
	Offset: 0x618
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"scoreevents", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: scoreevents
	Checksum: 0x1AE0B442
	Offset: 0x660
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_start_gametype(&init);
	callback::on_spawned(&on_player_spawned);
}

/*
	Name: init
	Namespace: scoreevents
	Checksum: 0xE72AF501
	Offset: 0x6B0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level.scoreeventgameendcallback = &ongameend;
	registerscoreeventcallback("playerKilled", &scoreeventplayerkill);
	status_effect::function_7505baeb(&function_4013aee1);
}

/*
	Name: function_4013aee1
	Namespace: scoreevents
	Checksum: 0x65FC9B33
	Offset: 0x720
	Size: 0x1DA
	Parameters: 2
	Flags: Linked
*/
function function_4013aee1(status_effect, var_3bc85d80)
{
	if(!isdefined(status_effect.var_4b22e697) || status_effect.var_4b22e697 == status_effect.owner || !isdefined(status_effect.var_3d1ed4bd))
	{
		return;
	}
	switch(status_effect.var_67e2281d)
	{
		case 2:
		{
			if(var_3bc85d80 == "begin")
			{
				if(status_effect.var_3d1ed4bd == getweapon(#"concussion_grenade"))
				{
					processscoreevent(#"hash_67b2c6329cd728cf", status_effect.var_4b22e697, status_effect.owner, status_effect.var_3d1ed4bd);
					status_effect.var_4b22e697.var_9d19aa30 = (isdefined(status_effect.var_4b22e697.var_4b22e697.var_9d19aa30) ? status_effect.var_4b22e697.var_9d19aa30 : 0) + 1;
					if(status_effect.var_4b22e697.var_9d19aa30 == 2 && isdefined(level.playgadgetsuccess))
					{
						status_effect.var_4b22e697 thread [[level.playgadgetsuccess]](getweapon(#"concussion_grenade"), undefined, undefined, undefined);
					}
					break;
				}
			}
		}
		default:
		{
			break;
		}
	}
}

/*
	Name: on_player_spawned
	Namespace: scoreevents
	Checksum: 0xC661171C
	Offset: 0x908
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	self player_spawned();
	self thread function_dcdf1105();
	self callback::function_f77ced93(&function_f77ced93);
}

/*
	Name: function_f77ced93
	Namespace: scoreevents
	Checksum: 0x74EF9AA9
	Offset: 0x968
	Size: 0x1F6
	Parameters: 1
	Flags: Linked, Private
*/
private function function_f77ced93(params)
{
	if(!isdefined(params.weapon) || !isweapon(params.weapon) || !isdefined(params.last_weapon) || !isweapon(params.last_weapon) || !isdefined(self) || !isplayer(self))
	{
		return;
	}
	var_86ecd1f2 = weapons::getbaseweapon(params.weapon);
	var_b577d267 = weapons::getbaseweapon(params.last_weapon);
	if(!isdefined(var_86ecd1f2) || !isdefined(var_b577d267) || var_86ecd1f2 == var_b577d267)
	{
		return;
	}
	if(var_86ecd1f2.var_76ce72e8 === 1 || var_86ecd1f2.var_b76e0a09 === 1 || var_86ecd1f2.name == #"none")
	{
		return;
	}
	if(var_b577d267.var_76ce72e8 === 1 || var_b577d267.var_b76e0a09 === 1 || var_b577d267.name == #"none")
	{
		return;
	}
	if(isdefined(killstreaks::get_from_weapon(var_86ecd1f2)) || isdefined(killstreaks::get_from_weapon(var_b577d267)))
	{
		return;
	}
	self.var_6f3f5189 = gettime();
}

/*
	Name: scoreeventtablelookupint
	Namespace: scoreevents
	Checksum: 0x917487F3
	Offset: 0xB68
	Size: 0x52
	Parameters: 2
	Flags: None
*/
function scoreeventtablelookupint(index, scoreeventcolumn)
{
	return int(tablelookup(getscoreeventtablename(), 0, index, scoreeventcolumn));
}

/*
	Name: scoreeventtablelookup
	Namespace: scoreevents
	Checksum: 0x426AFB8C
	Offset: 0xBC8
	Size: 0x42
	Parameters: 2
	Flags: None
*/
function scoreeventtablelookup(index, scoreeventcolumn)
{
	return tablelookup(getscoreeventtablename(), 0, index, scoreeventcolumn);
}

/*
	Name: registerscoreeventcallback
	Namespace: scoreevents
	Checksum: 0xD391185F
	Offset: 0xC18
	Size: 0x84
	Parameters: 2
	Flags: Linked
*/
function registerscoreeventcallback(callback, func)
{
	if(!isdefined(level.scoreeventcallbacks))
	{
		level.scoreeventcallbacks = [];
	}
	if(!isdefined(level.scoreeventcallbacks[callback]))
	{
		level.scoreeventcallbacks[callback] = [];
	}
	level.scoreeventcallbacks[callback][level.scoreeventcallbacks[callback].size] = func;
}

/*
	Name: scoreeventplayerkill
	Namespace: scoreevents
	Checksum: 0x78E1EDCA
	Offset: 0xCA8
	Size: 0x442C
	Parameters: 2
	Flags: Linked
*/
function scoreeventplayerkill(data, time)
{
	victim = data.victim;
	if(!isdefined(victim))
	{
		return;
	}
	attacker = data.attacker;
	if(!isdefined(attacker) || !isplayer(attacker))
	{
		return;
	}
	time = data.time;
	level.numkills++;
	attacker.lastkilledplayer = victim;
	wasdefusing = data.wasdefusing;
	wasplanting = data.wasplanting;
	victimwasonground = data.victimonground;
	attackerwasonground = data.attackeronground;
	meansofdeath = data.smeansofdeath;
	attackertraversing = data.attackertraversing;
	attackersliding = data.attackersliding;
	var_406186a6 = data.var_406186a6;
	attackerspeedburst = data.attackerspeedburst;
	victimspeedburst = data.victimspeedburst;
	victimcombatefficieny = data.victimcombatefficieny;
	victimspeedburstlastontime = data.victimspeedburstlastontime;
	victimcombatefficiencylastontime = data.victimcombatefficiencylastontime;
	victimvisionpulseactivatetime = data.victimvisionpulseactivatetime;
	attackervisionpulseactivatetime = data.attackervisionpulseactivatetime;
	attackervisionpulsearray = data.attackervisionpulsearray;
	victimvisionpulsearray = data.victimvisionpulsearray;
	attackervisionpulseoriginarray = data.attackervisionpulseoriginarray;
	victimvisionpulseoriginarray = data.victimvisionpulseoriginarray;
	attackervisionpulseorigin = data.attackervisionpulseorigin;
	victimvisionpulseorigin = data.victimvisionpulseorigin;
	victimlastvisionpulsedby = data.victimlastvisionpulsedby;
	victimlastvisionpulsedtime = data.victimlastvisionpulsedtime;
	var_31d0fbf5 = data.var_31d0fbf5;
	attackerwasflashed = data.attackerwasflashed;
	attackerwasconcussed = data.attackerwasconcussed;
	victimwasunderwater = data.wasunderwater;
	victimheroabilityactive = data.victimheroabilityactive;
	victimheroability = data.victimheroability;
	attackerheroabilityactive = data.attackerheroabilityactive;
	attackerheroability = data.attackerheroability;
	attackerwasheatwavestunned = data.attackerwasheatwavestunned;
	victimwasheatwavestunned = data.victimwasheatwavestunned;
	victimelectrifiedby = data.victimelectrifiedby;
	victimwasinslamstate = data.victimwasinslamstate;
	victimbledout = data.bledout;
	victimwaslungingwitharmblades = data.victimwaslungingwitharmblades;
	var_9fb5719b = data.var_9fb5719b;
	victimpowerarmorlasttookdamagetime = data.victimpowerarmorlasttookdamagetime;
	victimgadgetpower = data.victimgadgetpower;
	victimgadgetwasactivelastdamage = data.victimgadgetwasactivelastdamage;
	victimisthieforroulette = data.victimisthieforroulette;
	attackerisroulette = data.attackerisroulette;
	victimheroabilityname = data.victimheroabilityname;
	var_64aaf8ac = data.var_64aaf8ac;
	var_78056843 = data.var_78056843;
	var_4f6eb670 = data.var_4f6eb670;
	var_cf13980c = data.var_cf13980c;
	var_7117b104 = data.var_7117b104;
	var_989b2258 = data.var_989b2258;
	var_893d5683 = data.var_893d5683;
	var_ab4f5741 = data.var_ab4f5741;
	var_504c7a2f = data.var_504c7a2f;
	var_7006e4f4 = data.var_7006e4f4;
	var_af1b39cb = data.var_af1b39cb;
	var_e020b97e = data.var_e020b97e;
	var_c3f8aa38 = data.var_ac7c0ef7;
	var_a79760b1 = data.var_a79760b1;
	var_dd195b6b = data.var_dd195b6b;
	var_31310133 = data.var_31310133;
	var_a99236f2 = data.var_a99236f2;
	var_9084d6e = data.var_9084d6e;
	var_157f4d3b = data.var_157f4d3b;
	var_f048a359 = data.var_f048a359;
	attacker.var_a7f5c61e = data.var_be469b25;
	var_5fa4aeed = data.var_5fa4aeed;
	if(isdefined(victimheroabilityname))
	{
		victimheroabilityequipped = getweapon(victimheroabilityname);
	}
	if(victimbledout == 1)
	{
		return;
	}
	exlosivedamage = 0;
	attackershotvictim = meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_HEAD_SHOT";
	weapon = level.weaponnone;
	inflictor = data.einflictor;
	isgrenade = 0;
	if(isdefined(data.weapon))
	{
		weapon = data.weapon;
		weaponclass = util::getweaponclass(data.weapon);
		isgrenade = weapon.isgrenadeweapon;
		killstreak = killstreaks::get_from_weapon(data.weapon);
	}
	victim.anglesondeath = victim getplayerangles();
	if(meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_EXPLOSIVE" || meansofdeath == "MOD_EXPLOSIVE_SPLASH" || meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_PROJECTILE_SPLASH")
	{
		if(weapon == level.weaponnone && isdefined(data.victim.explosiveinfo[#"weapon"]))
		{
			weapon = data.victim.explosiveinfo[#"weapon"];
		}
		exlosivedamage = 1;
	}
	if(!isdefined(killstreak))
	{
		if(level.teambased)
		{
			if(isdefined(victim.lastkilltime) && victim.lastkilltime > time - 3000)
			{
				if(isdefined(victim.lastkilledplayer) && victim.lastkilledplayer util::isenemyplayer(attacker) == 0 && attacker != victim.lastkilledplayer)
				{
					processscoreevent(#"kill_enemy_who_killed_teammate", attacker, victim, weapon);
					attacker activecamo::function_896ac347(weapon, #"avenger", 1);
					attacker activecamo::function_896ac347(weapon, #"hash_39ab7cda18fd5c74", 1);
					victim recordkillmodifier("avenger");
				}
			}
			if(isdefined(victim.damagedplayers) && isdefined(attacker) && isdefined(attacker.clientid))
			{
				keys = getarraykeys(victim.damagedplayers);
				for(i = 0; i < keys.size; i++)
				{
					key = keys[i];
					if(!isdefined(key) || key === attacker.clientid)
					{
						continue;
					}
					if(!isdefined(victim.damagedplayers[key].entity))
					{
						continue;
					}
					if(attacker util::isenemyplayer(victim.damagedplayers[key].entity))
					{
						continue;
					}
					if(time - victim.damagedplayers[key].time < 1000)
					{
						processscoreevent(#"kill_enemy_injuring_teammate", attacker, victim, weapon);
						if(isdefined(victim.damagedplayers[key].entity))
						{
							victim.damagedplayers[key].entity.lastrescuedby = attacker;
							victim.damagedplayers[key].entity.lastrescuedtime = time;
						}
						victim recordkillmodifier("defender");
					}
				}
			}
		}
		if(isgrenade == 0 || weapon.name == #"hero_gravityspikes")
		{
			if(attackersliding == 1)
			{
				processscoreevent(#"kill_enemy_while_sliding", attacker, victim, weapon);
			}
			if(attackertraversing == 1)
			{
				processscoreevent(#"traversal_kill", attacker, victim, weapon);
			}
			if(var_406186a6 && isdefined(attacker.var_3febb1e9) && isplayer(attacker.var_3febb1e9))
			{
				if(attacker == attacker.var_3febb1e9)
				{
					processscoreevent(#"hash_78ffd98403577905", attacker, victim, getweapon(#"eq_localheal"));
				}
				else
				{
					processscoreevent(#"hash_7eb6cf1758a9c2f2", attacker.var_3febb1e9, victim, getweapon(#"eq_localheal"));
				}
			}
			if(attackerwasflashed)
			{
				processscoreevent(#"kill_enemy_while_flashbanged", attacker, victim, weapon);
			}
			if(victim.currentweapon == getweapon(#"hash_40380537847df901") || victim.currentweapon == getweapon(#"hash_1d2a1056220e71a9") || victim.currentweapon == getweapon(#"hash_1d2a0f56220e6ff6") || victim.currentweapon == getweapon(#"hash_1d2a1256220e750f"))
			{
				processscoreevent(#"hash_6530935b474f2e11", attacker, victim, weapon);
			}
			if(attackerwasconcussed)
			{
				processscoreevent(#"kill_enemy_while_stunned", attacker, victim, weapon);
			}
			if(attackerwasheatwavestunned)
			{
				processscoreevent(#"kill_enemy_that_heatwaved_you", attacker, victim, weapon);
				attacker contracts::player_contract_event(#"killed_hero_ability_enemy");
			}
			if(victimwasheatwavestunned)
			{
				if(isdefined(victim._heat_wave_stunned_by) && isdefined(victim._heat_wave_stunned_by[attacker.clientid]) && victim._heat_wave_stunned_by[attacker.clientid] >= time)
				{
					processscoreevent(#"heatwave_kill", attacker, victim, getweapon(#"gadget_heat_wave"));
					attacker hero_ability_kill_event(getweapon(#"gadget_heat_wave"), get_equipped_hero_ability(victimheroabilityname));
					attacker specialistmedalachievement();
					attacker thread specialiststatabilityusage(4, 0);
					if(!victimisthieforroulette && victimheroabilityname === "gadget_heat_wave")
					{
						processscoreevent(#"kill_enemy_with_their_hero_ability", attacker, victim, getweapon(#"gadget_heat_wave"));
					}
				}
				if(attackerisroulette && !victimisthieforroulette && victimheroabilityname === "gadget_heat_wave")
				{
					processscoreevent(#"kill_enemy_with_their_hero_ability", attacker, victim, getweapon(#"gadget_heat_wave"));
				}
			}
		}
		if(isdefined(var_cf13980c))
		{
			sensor = function_c01cb128(victim, var_cf13980c);
			if(isdefined(sensor))
			{
				processscoreevent(#"hash_224fd59f924db25a", attacker, victim, sensor.weapon);
				if((isdefined(sensor.var_1fd3a368) ? sensor.var_1fd3a368 : 1) && isdefined(level.playgadgetsuccess))
				{
					attacker.var_cbb5d202 = (isdefined(attacker.var_cbb5d202) ? attacker.var_cbb5d202 : 0) + 1;
					if(isdefined(level.var_ac6052e9))
					{
						var_9194a036 = [[level.var_ac6052e9]]("sensorDartSuccessLineCount", 0);
					}
					if(attacker.var_cbb5d202 == (isdefined(var_9194a036) ? var_9194a036 : 3))
					{
						attacker [[level.playgadgetsuccess]](sensor.weapon, undefined, victim, undefined);
						function_3932ffa2(var_cf13980c);
						attacker.var_cbb5d202 = 0;
					}
				}
			}
		}
		else if(isdefined(var_4f6eb670))
		{
			sensor = function_c01cb128(victim, var_4f6eb670);
			if(isdefined(sensor))
			{
				if(function_9aef690a(weapon))
				{
					processscoreevent(#"hash_1f661efe5e6707ad", var_78056843, victim, weapon);
				}
				else
				{
					processscoreevent(#"hash_731f824a77ef7369", var_78056843, victim, weapon);
				}
				if((isdefined(sensor.var_1fd3a368) ? sensor.var_1fd3a368 : 1) && isdefined(level.playgadgetsuccess))
				{
					var_78056843.var_cbb5d202 = (isdefined(var_78056843.var_cbb5d202) ? var_78056843.var_cbb5d202 : 0) + 1;
					if(isdefined(level.var_ac6052e9))
					{
						var_9194a036 = [[level.var_ac6052e9]]("sensorDartSuccessLineCount", 0);
					}
					if(var_78056843.var_cbb5d202 == (isdefined(var_9194a036) ? var_9194a036 : 3))
					{
						var_78056843 [[level.playgadgetsuccess]](sensor.weapon, undefined, victim, attacker);
						function_3932ffa2(var_4f6eb670);
						var_78056843.var_cbb5d202 = 0;
					}
				}
			}
		}
		if(var_9084d6e && isdefined(var_f048a359))
		{
			if(var_f048a359 == getweapon(#"concussion_grenade"))
			{
				processscoreevent(#"hash_7380fa332edb5a82", attacker, victim, getweapon(#"concussion_grenade"));
				if(attacker != var_157f4d3b)
				{
					processscoreevent(#"assist_concussion", var_157f4d3b, victim, weapon);
				}
			}
		}
		if(weapon == getweapon(#"sig_buckler_turret") || weapon == getweapon(#"sig_buckler_dw"))
		{
			if(var_e020b97e && isdefined(var_af1b39cb) && var_af1b39cb == attacker)
			{
				processscoreevent(#"hash_63b75d5e59c12f69", attacker, victim, weapon);
			}
		}
		else if(var_e020b97e && !var_c3f8aa38 && isdefined(var_af1b39cb) && var_af1b39cb == attacker)
		{
			processscoreevent(#"hash_5133c3fc034db4aa", attacker, victim, weapon);
		}
		if(isdefined(attacker.var_121392a1) && isarray(attacker.var_121392a1))
		{
			foreach(effect in attacker.var_121392a1)
			{
				if(!isdefined(effect) || !isdefined(effect.var_3d1ed4bd) || !isweapon(effect.var_3d1ed4bd))
				{
					continue;
				}
				if(effect.var_3d1ed4bd == getweapon(#"hash_3f62a872201cd1ce") || effect.var_3d1ed4bd == getweapon(#"hash_638e1f0905f293cf") || effect.var_3d1ed4bd == getweapon(#"eq_slow_grenade"))
				{
					processscoreevent(#"hash_61640bd6bb7451ad", attacker, victim, effect.var_3d1ed4bd);
					break;
				}
			}
		}
		if(attackerspeedburst == 1)
		{
			processscoreevent(#"speed_burst_kill", attacker, victim, getweapon(#"gadget_speed_burst"));
			attacker hero_ability_kill_event(getweapon(#"gadget_speed_burst"), get_equipped_hero_ability(victimheroabilityname));
			attacker specialistmedalachievement();
			attacker thread specialiststatabilityusage(4, 0);
			if(attackerisroulette && !victimisthieforroulette && victimheroabilityname === "gadget_speed_burst")
			{
				processscoreevent(#"kill_enemy_with_their_hero_ability", attacker, victim, getweapon(#"gadget_speed_burst"));
			}
		}
		if(isdefined(attacker.var_6f3f5189) && attacker.var_6f3f5189 + 2000 >= time && !weapon.var_76ce72e8 === 1)
		{
			processscoreevent("kill_enemy_after_switching_weapons", attacker, victim, weapon);
		}
		if(victimspeedburstlastontime > time - 50)
		{
			processscoreevent(#"kill_enemy_who_is_speedbursting", attacker, victim, weapon);
			attacker contracts::player_contract_event(#"killed_hero_ability_enemy");
		}
		if(victimcombatefficiencylastontime > time - 50)
		{
			processscoreevent(#"kill_enemy_who_is_using_focus", attacker, victim, weapon);
			attacker contracts::player_contract_event(#"killed_hero_ability_enemy");
		}
		if(victimwasinslamstate)
		{
			attacker contracts::player_contract_event(#"killed_hero_weapon_enemy");
		}
		if(challenges::ishighestscoringplayer(victim))
		{
			processscoreevent(#"kill_enemy_who_has_high_score", attacker, victim, weapon);
			attacker activecamo::function_896ac347(weapon, #"kingslayer", 1);
			attacker activecamo::function_896ac347(weapon, #"hash_39ab7cda18fd5c74", 1);
			attacker contracts::function_a54e2068(#"hash_a75db3f2b544591");
		}
		if(victimwasunderwater && exlosivedamage)
		{
			processscoreevent(#"kill_underwater_enemy_explosive", attacker, victim, weapon);
		}
		if(var_5fa4aeed && isdefined(victim.lastattackedshieldplayer) && victim.lastattackedshieldplayer == attacker)
		{
			processscoreevent(#"hash_7c2d800a84be69a2", attacker, victim, weapon);
		}
		if(isdefined(victimelectrifiedby) && victimelectrifiedby != attacker)
		{
			processscoreevent(#"electrified", victimelectrifiedby, victim, weapon);
		}
		if(victimvisionpulseactivatetime != 0 && victimvisionpulseactivatetime > time - 4000)
		{
			for(i = 0; i < victimvisionpulsearray.size; i++)
			{
				player = victimvisionpulsearray[i];
				if(player == attacker)
				{
					if(victimvisionpulseactivatetime + 300 > time - level.var_2e3031be.gadget_pulse_duration)
					{
						distancetopulse = distance(victimvisionpulseoriginarray[i], victimvisionpulseorigin);
						ratio = distancetopulse / level.var_2e3031be.gadget_pulse_max_range;
						timing = ratio * level.var_2e3031be.gadget_pulse_duration;
						if(victimvisionpulseactivatetime + 300 > time - timing)
						{
							break;
						}
					}
					processscoreevent(#"hash_80ad2ddab577c7e", attacker, victim, weapon);
					attacker activecamo::function_896ac347(weapon, #"showstopper", 1);
					attacker contracts::player_contract_event(#"killed_hero_ability_enemy");
					break;
				}
			}
			if(isdefined(victimheroability))
			{
				attacker notify(#"hero_shutdown", {#gadget:victimheroability});
				attacker notify(#"hero_shutdown_gadget", {#victim:victim, #gadget:victimheroability});
			}
		}
		if(victimlastvisionpulsedtime != 0 && victimlastvisionpulsedtime > time - level.var_2e3031be.var_9d776ba6)
		{
			if(isdefined(victimlastvisionpulsedby) && attacker != victimlastvisionpulsedby && attacker util::isenemyplayer(victimlastvisionpulsedby) == 0)
			{
				if(function_9aef690a(weapon))
				{
					processscoreevent(#"hash_bad79b50f40ce0b", victimlastvisionpulsedby, victim, level.var_2e3031be);
				}
				else
				{
					processscoreevent(#"hash_7ce9f144e4d72853", victimlastvisionpulsedby, victim, level.var_2e3031be);
				}
				processscoreevent(#"hash_6d41ba237c04cb10", attacker, victim, weapon);
			}
			else
			{
				attacker hero_ability_kill_event(level.var_2e3031be, get_equipped_hero_ability(victimheroabilityname));
				attacker specialistmedalachievement();
				attacker thread specialiststatabilityusage(4, 0);
				if(attackerisroulette && !victimisthieforroulette && victimheroabilityname === "gadget_vision_pulse")
				{
					processscoreevent(#"kill_enemy_with_their_hero_ability", attacker, victim, level.var_2e3031be);
				}
			}
			if(isdefined(level.playgadgetsuccess) && isdefined(victimlastvisionpulsedby))
			{
				victimlastvisionpulsedby.var_35182804 = (isdefined(victimlastvisionpulsedby.var_35182804) ? victimlastvisionpulsedby.var_35182804 : 0) + 1;
				if(isdefined(level.var_ac6052e9))
				{
					var_9194a036 = [[level.var_ac6052e9]]("visionPulseSuccessLineCount", 0);
				}
				if(victimlastvisionpulsedby.var_35182804 == (isdefined(var_9194a036) ? var_9194a036 : 3))
				{
					victimlastvisionpulsedby thread [[level.playgadgetsuccess]](level.var_2e3031be, undefined, undefined, undefined);
				}
			}
		}
		if(isdefined(var_989b2258))
		{
			processscoreevent(#"hash_51f0b8510479cbef", attacker, victim, getweapon(#"hash_a3fa25abdd4b905"));
		}
		else if(weapon == getweapon(#"hash_a3fa25abdd4b905") && meansofdeath == "MOD_EXPLOSIVE")
		{
			processscoreevent(#"hash_48d355527fe7ff9", attacker, victim, weapon);
		}
		if(isdefined(var_ab4f5741) && var_ab4f5741 === 1)
		{
			foreach(var_69162b32 in victim._gadgets_player)
			{
				if(var_69162b32 == getweapon(#"hash_2ce2e438ecd6b2d2"))
				{
					processscoreevent(#"hash_438160ef75ca2ea", attacker, victim, weapon);
					break;
				}
			}
			if(weapon == getweapon(#"hash_19049416fc420e6f"))
			{
				processscoreevent(#"hash_1e657ba6178ae2c6", attacker, victim, weapon);
			}
			if(isdefined(var_7006e4f4) && var_504c7a2f == 1)
			{
				if(var_7006e4f4 == attacker)
				{
					processscoreevent(#"hash_3d3467f13cf43727", attacker, victim, getweapon(#"hash_2ce2e438ecd6b2d2"));
				}
				else
				{
					processscoreevent(#"hash_5a52344f66f68864", var_7006e4f4, victim, weapon);
				}
			}
		}
		if(isdefined(var_a99236f2))
		{
			if(attacker == var_a99236f2)
			{
				processscoreevent(#"hash_6dee98175676f663", attacker, victim, weapon);
			}
			else
			{
				processscoreevent(#"hash_6528a1312edf578e", var_a99236f2, victim, weapon);
			}
		}
		if(isdefined(attacker.var_a7f5c61e) && attacker.var_a7f5c61e)
		{
			if(isdefined(level.playgadgetsuccess) && weapon != getweapon(#"hash_4bb2d7f789b561eb") && gettime() > (isdefined(attacker.var_5069fdec) ? attacker.var_5069fdec : int(-30 * 1000)) + int(30 * 1000))
			{
				attacker [[level.playgadgetsuccess]](getweapon(#"hash_3a19c6a9c8caef33"), undefined, undefined, undefined);
				attacker.var_5069fdec = gettime();
			}
			processscoreevent(#"hash_2b28b6abff07567e", attacker, victim, weapon);
		}
		if(weapon == getweapon(#"hash_4bb2d7f789b561eb"))
		{
			processscoreevent(#"hash_5c8c3bd3007e5948", attacker, victim, weapon);
		}
		if(victimheroabilityactive && isdefined(victimheroability))
		{
			attacker notify(#"hero_shutdown", {#gadget:victimheroability});
			attacker notify(#"hero_shutdown_gadget", {#victim:victim, #gadget:victimheroability});
			switch(victimheroability.name)
			{
				case "gadget_armor":
				{
					processscoreevent(#"kill_enemy_who_has_powerarmor", attacker, victim, weapon);
					attacker contracts::player_contract_event(#"killed_hero_ability_enemy");
					break;
				}
				case "gadget_resurrect":
				{
					processscoreevent(#"kill_enemy_that_used_resurrect", attacker, victim, weapon);
					attacker contracts::player_contract_event(#"killed_hero_ability_enemy");
					break;
				}
				case "gadget_camo":
				{
					processscoreevent(#"kill_enemy_that_is_using_optic_camo", attacker, victim, weapon);
					attacker contracts::player_contract_event(#"killed_hero_ability_enemy");
					break;
				}
				case "gadget_clone":
				{
					processscoreevent(#"end_enemy_psychosis", attacker, victim, weapon);
					attacker contracts::player_contract_event(#"killed_hero_ability_enemy");
					break;
				}
			}
		}
		else if(isdefined(victimpowerarmorlasttookdamagetime) && time - victimpowerarmorlasttookdamagetime <= 3000)
		{
			attacker notify(#"hero_shutdown", {#gadget:victimheroability});
			attacker notify(#"hero_shutdown_gadget", {#victim:victim, #gadget:victimheroability});
			processscoreevent(#"kill_enemy_who_has_powerarmor", attacker, victim, weapon);
			attacker contracts::player_contract_event(#"killed_hero_ability_enemy");
		}
		if(isdefined(data.victimweapon) && data.victimweapon.isheavyweapon)
		{
			attacker notify(#"heavy_shutdown", {#weapon:data.victimweapon});
			attacker notify(#"heavy_shutdown_gadget", {#victim:victim, #weapon:data.victimweapon});
		}
		else if(isdefined(victim.heavyweapon) && isdefined(victimgadgetpower) && victimgadgetwasactivelastdamage === 1 && victimgadgetpower < 100)
		{
			attacker notify(#"heavy_shutdown", {#weapon:victim.heavyweapon});
			attacker notify(#"heavy_shutdown_gadget", {#victim:victim, #weapon:victim.heavyweapon});
		}
		if(attackerheroabilityactive && isdefined(attackerheroability))
		{
			abilitytocheck = undefined;
			switch(attackerheroability.name)
			{
				case "gadget_armor":
				{
					processscoreevent(#"power_armor_kill", attacker, victim, getweapon(#"gadget_armor"));
					attacker hero_ability_kill_event(attackerheroability, get_equipped_hero_ability(victimheroabilityname));
					attacker specialistmedalachievement();
					attacker thread specialiststatabilityusage(4, 0);
					abilitytocheck = attackerheroability.name;
					break;
				}
				case "gadget_resurrect":
				{
					processscoreevent(#"resurrect_kill", attacker, victim, getweapon(#"gadget_resurrect"));
					attacker hero_ability_kill_event(attackerheroability, get_equipped_hero_ability(victimheroabilityname));
					attacker specialistmedalachievement();
					attacker thread specialiststatabilityusage(4, 0);
					abilitytocheck = attackerheroability.name;
					break;
				}
				case "gadget_camo":
				{
					processscoreevent(#"optic_camo_kill", attacker, victim, getweapon(#"gadget_camo"));
					attacker hero_ability_kill_event(attackerheroability, get_equipped_hero_ability(victimheroabilityname));
					attacker specialistmedalachievement();
					attacker thread specialiststatabilityusage(4, 0);
					abilitytocheck = attackerheroability.name;
					break;
				}
				case "gadget_clone":
				{
					processscoreevent(#"kill_enemy_while_using_psychosis", attacker, victim, getweapon(#"gadget_clone"));
					attacker hero_ability_kill_event(attackerheroability, get_equipped_hero_ability(victimheroabilityname));
					attacker specialistmedalachievement();
					attacker thread specialiststatabilityusage(4, 0);
					abilitytocheck = attackerheroability.name;
					break;
				}
			}
			if(attackerisroulette && !victimisthieforroulette && isdefined(abilitytocheck) && victimheroabilityname === abilitytocheck)
			{
				processscoreevent(#"kill_enemy_with_their_hero_ability", attacker, victim, weapon);
			}
		}
		if(victimwaslungingwitharmblades)
		{
			processscoreevent(#"end_enemy_armblades_attack", attacker, victim, weapon);
		}
		if(var_9fb5719b)
		{
			processscoreevent(#"hash_300c1c6babed2cb3", attacker, victim, weapon);
		}
		if(isdefined(data.victimweapon))
		{
			killedheavyweaponenemy(attacker, victim, weapon, data.victimweapon, victimgadgetpower);
			if(data.victimweapon.statindex == level.var_697e9965.statindex)
			{
				processscoreevent(#"hash_3988d3aa940f2e77", attacker, victim, weapon);
			}
			else if(data.victimweapon.name == "m32")
			{
				processscoreevent(#"killed_multiple_grenade_launcher_enemy", attacker, victim, weapon);
			}
		}
		if(weapon.statname == #"frag_grenade")
		{
			attacker stats::function_dad108fa(#"hash_448dd62e83fdf39e", 1);
		}
		else if(weapon.statname == #"eq_molotov")
		{
			attacker stats::function_dad108fa(#"hash_48b36f9eaa29e8b3", 1);
		}
		attacker thread updatemultikills(weapon, weaponclass, killstreak, victim);
		if(level.numkills == 1)
		{
			victim recordkillmodifier("firstblood");
			processscoreevent(#"first_kill", attacker, victim, weapon);
			level.var_8a3a9ca4.firstblood = gettime();
			attacker contracts::function_a54e2068(#"hash_61c7d530de491c8d");
			util::function_5a68c330(22, attacker.team, attacker getentitynumber());
		}
		else if(isdefined(attacker.lastkilledby))
		{
			if(attacker.lastkilledby == victim)
			{
				level.globalpaybacks++;
				processscoreevent(#"revenge_kill", attacker, victim, weapon);
				attacker stats::function_e24eec31(weapon, #"revenge_kill", 1);
				attacker activecamo::function_896ac347(weapon, #"revenge", 1);
				attacker activecamo::function_896ac347(weapon, #"hash_39ab7cda18fd5c74", 1);
				victim recordkillmodifier("revenge");
				attacker.lastkilledby = undefined;
			}
		}
		if(victim killstreaks::is_an_a_killstreak())
		{
			level.globalbuzzkills++;
			processscoreevent(#"stop_enemy_killstreak", attacker, victim, weapon);
			attacker activecamo::function_896ac347(weapon, #"buzzkill", 1);
			attacker activecamo::function_896ac347(weapon, #"hash_39ab7cda18fd5c74", 1);
			victim recordkillmodifier("buzzkill");
		}
		if(isdefined(victim.lastmansd) && victim.lastmansd == 1)
		{
			processscoreevent(#"final_kill_elimination", attacker, victim, weapon);
			if(isdefined(attacker.lastmansd) && attacker.lastmansd == 1)
			{
				processscoreevent(#"elimination_and_last_player_alive", attacker, victim, weapon);
			}
		}
		if(is_weapon_valid(meansofdeath, weapon, weaponclass, killstreak))
		{
			if(isdefined(victim.vattackerorigin))
			{
				attackerorigin = victim.vattackerorigin;
			}
			else
			{
				attackerorigin = attacker.origin;
			}
			disttovictim = distancesquared(victim.origin, attackerorigin);
			weap_min_dmg_range = get_distance_for_weapon(weapon, weaponclass);
			if(disttovictim > weap_min_dmg_range)
			{
				attacker challenges::longdistancekillmp(weapon, meansofdeath);
				if(weapon.rootweapon.name == "hatchet")
				{
					attacker challenges::longdistancehatchetkill();
				}
				processscoreevent(#"longshot_kill", attacker, victim, weapon);
				attacker contracts::function_a54e2068(#"hash_37a6781050049cc4");
				attacker.pers[#"longshots"]++;
				attacker.longshots = attacker.pers[#"longshots"];
				victim recordkillmodifier("longshot");
				if(isdefined(attacker.var_ea1458aa))
				{
					if(!isdefined(attacker.var_ea1458aa.var_eb577364))
					{
						attacker.var_ea1458aa.var_eb577364 = 0;
					}
					attacker.var_ea1458aa.var_eb577364++;
					if(attacker.var_ea1458aa.var_eb577364 % 3 == 0)
					{
						attacker stats::function_dad108fa(#"longshot_3_onelife", 1);
					}
				}
			}
			killdistance = distance(victim.origin, attackerorigin);
			attacker.pers[#"kill_distances"] = attacker.pers[#"kill_distances"] + killdistance;
			attacker.pers[#"num_kill_distance_entries"]++;
		}
		if(isalive(attacker))
		{
			if(attacker.health < attacker.maxhealth * 0.35)
			{
				attacker.lastkillwheninjured = time;
				processscoreevent(#"kill_enemy_when_injured", attacker, victim, weapon);
				attacker stats::function_e24eec31(weapon, #"kill_enemy_when_injured", 1);
				if(attacker util::has_toughness_perk_purchased_and_equipped())
				{
					attacker stats::function_dad108fa(#"perk_bulletflinch_kills", 1);
				}
			}
		}
		else if(isdefined(attacker.deathtime) && attacker.deathtime + 800 < time && !attacker isinvehicle())
		{
			level.globalafterlifes++;
			processscoreevent(#"kill_enemy_after_death", attacker, victim, weapon);
			victim recordkillmodifier("posthumous");
		}
		if(isdefined(attacker.cur_death_streak) && attacker.cur_death_streak >= 3)
		{
			level.globalcomebacks++;
			processscoreevent(#"comeback_from_deathstreak", attacker, victim, weapon);
			victim recordkillmodifier("comeback");
		}
		if(isdefined(victim.lastmicrowavedby))
		{
			foreach(beingmicrowavedby in victim.beingmicrowavedby)
			{
				if(isdefined(beingmicrowavedby) && attacker util::isenemyplayer(beingmicrowavedby) == 0)
				{
					if(beingmicrowavedby != attacker)
					{
						scoregiven = processscoreevent(#"microwave_turret_assist", beingmicrowavedby, victim, weapon);
						if(isdefined(scoregiven))
						{
							beingmicrowavedby challenges::earnedmicrowaveassistscore(scoregiven);
						}
						continue;
					}
					attackermicrowavedvictim = 1;
				}
			}
			if(attackermicrowavedvictim === 1 && weapon.name != "microwave_turret")
			{
				attacker challenges::killwhiledamagingwithhpm();
				processscoreevent(#"microwave_turret_kill", beingmicrowavedby, victim, weapon);
				attacker function_be7a08a8(weapon, 1);
			}
		}
		if(weapon_utils::ismeleemod(meansofdeath) && !weapon.isriotshield)
		{
			attacker.pers[#"stabs"]++;
			attacker.stabs = attacker.pers[#"stabs"];
			vangles = victim.anglesondeath[1];
			pangles = attacker.anglesonkill[1];
			anglediff = angleclamp180(vangles - pangles);
			if(isdefined(weapon.var_cfc07f04) && weapon.var_cfc07f04 && anglediff > -30 && anglediff < 70)
			{
				level.globalbackstabs++;
				processscoreevent(#"backstabber_kill", attacker, victim, weapon);
				var_1c73f975 = 1;
				weaponpickedup = 0;
				if(isdefined(attacker.pickedupweapons) && isdefined(attacker.pickedupweapons[weapon]))
				{
					weaponpickedup = 1;
				}
				attacker stats::function_eec52333(weapon, #"backstabber_kill", 1, attacker.class_num, weaponpickedup);
				attacker.pers[#"backstabs"]++;
				attacker.backstabs = attacker.pers[#"backstabs"];
			}
			else if(!(isdefined(weapon.var_cfc07f04) && weapon.var_cfc07f04) && (anglediff < -30 || anglediff > 70 || (isdefined(victim.laststand) && victim.laststand)))
			{
				if(meansofdeath == "MOD_MELEE_WEAPON_BUTT" && weapon.name != "ball")
				{
					processscoreevent(#"kill_enemy_with_gunbutt", attacker, victim, weapon);
				}
				else if(weapon_utils::ispunch(weapon))
				{
					processscoreevent(#"kill_enemy_with_fists", attacker, victim, weapon);
				}
			}
		}
		else if(isdefined(victim.firsttimedamaged) && victim.firsttimedamaged == time && (weapon.statindex == level.var_bb448b5f.statindex || weapon.inventorytype != "ability"))
		{
			if(attackershotvictim)
			{
				attacker thread updateoneshotmultikills(victim, weapon, victim.firsttimedamaged, meansofdeath);
				attacker stats::function_e24eec31(weapon, #"kill_enemy_one_bullet", 1);
			}
		}
		if(isdefined(victim.var_d6f11c60) && attacker == victim.var_d6f11c60 && victim.var_e6c1bab8 + 2000 > gettime())
		{
			var_21877ec1 = 1;
		}
		else if(meansofdeath == "MOD_HEAD_SHOT" && (isdefined(victim.armor) ? victim.armor : 0) > 0)
		{
			var_21877ec1 = 1;
		}
		if(isdefined(var_21877ec1) && var_21877ec1)
		{
			processscoreevent(#"hash_50328eac1e8cfdcb", attacker, victim, weapon);
		}
		/#
			assert(isdefined(attacker));
		#/
		/#
			assert(isdefined(attacker.tookweaponfrom), "" + attacker getentnum() + "");
		#/
		if(isdefined(attacker) && isdefined(attacker.tookweaponfrom) && isdefined(attacker.tookweaponfrom[weapon]) && isdefined(attacker.tookweaponfrom[weapon].previousowner))
		{
			pickedupweapon = attacker.tookweaponfrom[weapon];
			if(pickedupweapon.previousowner == victim)
			{
				processscoreevent(#"kill_enemy_with_their_weapon", attacker, victim, weapon);
				attacker stats::function_e24eec31(weapon, #"kill_enemy_with_their_weapon", 1);
				if(isdefined(pickedupweapon.sweapon) && isdefined(pickedupweapon.smeansofdeath) && weapon_utils::ismeleemod(pickedupweapon.smeansofdeath))
				{
					foreach(meleeweapon in level.meleeweapons)
					{
						if(weapon != meleeweapon && pickedupweapon.sweapon.rootweapon == meleeweapon)
						{
							attacker stats::function_e24eec31(meleeweapon, #"kill_enemy_with_their_weapon", 1);
							break;
						}
					}
				}
			}
		}
		if(wasdefusing)
		{
			processscoreevent(#"killed_bomb_defuser", attacker, victim, weapon);
		}
		else if(wasplanting)
		{
			processscoreevent(#"killed_bomb_planter", attacker, victim, weapon);
		}
		heavyweaponkill(attacker, victim, weapon);
	}
	specificweaponkill(attacker, victim, weapon, killstreak, inflictor);
	if(isdefined(level.vtol) && isdefined(level.vtol.owner))
	{
		attacker stats::function_dad108fa(#"kill_as_support_gunner", 1);
		processscoreevent(#"mothership_assist_kill", level.vtol.owner, victim, weapon);
	}
	if(isdefined(var_7117b104) && time - var_7117b104 < 5300)
	{
		processscoreevent(#"hash_3382a0f71afb182f", attacker, victim, weapon);
	}
	switch(weapon.rootweapon.name)
	{
		case "hatchet":
		{
			attacker.pers[#"tomahawks"]++;
			attacker.tomahawks = attacker.pers[#"tomahawks"];
			processscoreevent(#"hatchet_kill", attacker, victim, weapon);
			attacker contracts::function_a54e2068(#"hash_172456fa969d6c82");
			if(isdefined(data.victim.explosiveinfo[#"projectile_bounced"]) && data.victim.explosiveinfo[#"projectile_bounced"] == 1)
			{
				level.globalbankshots++;
				processscoreevent(#"bounce_hatchet_kill", attacker, victim, weapon);
				attacker contracts::function_a54e2068(#"hash_660f842f7d97edcc");
			}
			break;
		}
		case "supplydrop":
		case "inventory_supplydrop":
		case "supplydrop_marker":
		case "inventory_supplydrop_marker":
		{
			if(meansofdeath == "MOD_HIT_BY_OBJECT" || meansofdeath == "MOD_CRUSH")
			{
				processscoreevent(#"kill_enemy_with_care_package_crush", attacker, victim, weapon);
			}
			else
			{
				processscoreevent(#"kill_enemy_with_hacked_care_package", attacker, victim, weapon);
			}
			break;
		}
	}
	if(isdefined(killstreak))
	{
		attacker thread updatemultikills(weapon, weaponclass, killstreak, victim);
		victim recordkillmodifier("killstreak");
	}
	attacker.cur_death_streak = 0;
	attacker disabledeathstreak();
}

/*
	Name: get_equipped_hero_ability
	Namespace: scoreevents
	Checksum: 0x14A75AAB
	Offset: 0x50E0
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function get_equipped_hero_ability(ability_name)
{
	if(!isdefined(ability_name))
	{
		return undefined;
	}
	return getweapon(ability_name);
}

/*
	Name: heavyweaponkill
	Namespace: scoreevents
	Checksum: 0xC95657C0
	Offset: 0x5118
	Size: 0x284
	Parameters: 3
	Flags: Linked
*/
function heavyweaponkill(attacker, victim, weapon)
{
	if(!isdefined(weapon))
	{
		return;
	}
	switch(weapon.name)
	{
		case "hero_minigun":
		{
			event = "minigun_kill";
			break;
		}
		case "hero_flamethrower":
		{
			event = "flamethrower_kill";
			break;
		}
		case "hero_lightninggun":
		case "hero_lightninggun_arc":
		{
			event = "tempest_kill";
			break;
		}
		case "hero_firefly_swarm":
		case "hero_chemicalgelgun":
		{
			event = "gelgun_kill";
			break;
		}
		case "hero_bowlauncher2":
		case "hero_bowlauncher3":
		case "hero_bowlauncher4":
		case "hash_1d2a0f56220e6ff6":
		case "hash_1d2a1056220e71a9":
		case "hash_1d2a1256220e750f":
		case "hash_40380537847df901":
		case "hero_bowlauncher":
		{
			event = "bowlauncher_kill";
			break;
		}
		case "hash_10f001e3a1d7dcfa":
		case "sig_minigun":
		case "hash_5a34a2f4b8c715c0":
		case "hash_5a34aef4b8c72a24":
		case "hash_5a382ef4b8ca397b":
		case "hash_5a3832f4b8ca4047":
		case "hash_5a492ef4b8d8acae":
		case "hash_5a4932f4b8d8b37a":
		{
			if(attacker function_a867284b() && attacker playerads() == 1)
			{
				event = "mounted_kill";
			}
			else
			{
				event = "minigun_kill";
			}
			break;
		}
		default:
		{
			return;
		}
	}
	processscoreevent(event, attacker, victim, weapon);
}

/*
	Name: killedheavyweaponenemy
	Namespace: scoreevents
	Checksum: 0xBB44661F
	Offset: 0x53A8
	Size: 0x1A4
	Parameters: 5
	Flags: Linked
*/
function killedheavyweaponenemy(attacker, victim, weapon, victim_weapon, victim_gadget_power)
{
	if(!isdefined(victim_weapon))
	{
		return;
	}
	if(!isdefined(victim_gadget_power))
	{
		return;
	}
	if(victim_gadget_power >= 100)
	{
		return;
	}
	switch(victim_weapon.name)
	{
		case "hero_minigun":
		{
			event = "killed_minigun_enemy";
			break;
		}
		case "hero_flamethrower":
		{
			event = "killed_flamethrower_enemy";
			break;
		}
		case "hero_lightninggun":
		case "hero_lightninggun_arc":
		{
			event = "tempest_shutdown";
			break;
		}
		case "hero_chemicalgelgun":
		{
			event = "killed_gelgun_enemy";
			break;
		}
		case "hero_bowlauncher2":
		case "hero_bowlauncher3":
		case "hero_bowlauncher4":
		case "hero_bowlauncher":
		{
			event = "killed_bowlauncher_enemy";
			break;
		}
		default:
		{
			return;
		}
	}
	processscoreevent(event, attacker, victim, weapon);
	attacker contracts::player_contract_event(#"killed_hero_weapon_enemy");
}

/*
	Name: specificweaponkill
	Namespace: scoreevents
	Checksum: 0xBC438BBD
	Offset: 0x5558
	Size: 0x39C
	Parameters: 5
	Flags: Linked
*/
function specificweaponkill(attacker, victim, weapon, killstreak, inflictor)
{
	switchweapon = weapon.name;
	if(isdefined(killstreak))
	{
		switchweapon = killstreak;
		bundle = level.killstreakbundle[killstreak];
	}
	switch(switchweapon)
	{
		case "hash_19049416fc420e6f":
		{
			event = "blade_kill";
			break;
		}
		case "autoturret":
		case "inventory_autoturret":
		{
			event = "sentry_gun_kill";
			break;
		}
		case "tank_robot":
		case "tank_robot_launcher_turret":
		{
			event = "tank_robot_kill";
			if(isdefined(attacker.var_5f28922a) && attacker.var_5f28922a)
			{
				attacker stats::function_dad108fa(#"kill_with_controlled_ai_tank", 1);
			}
			break;
		}
		case "microwave_turret":
		case "microwaveturret":
		case "inventory_microwaveturret":
		case "inventory_microwave_turret":
		{
			event = "microwave_turret_kill";
			break;
		}
		case "combat_robot":
		case "inventory_combat_robot":
		{
			event = "combat_robot_kill";
			break;
		}
		case "claymore":
		{
			event = "claymore_kill";
			break;
		}
		case "inventory_rcbomb":
		case "rcbomb":
		{
			event = "hover_rcxd_kill";
			break;
		}
		case "incendiary_fire":
		{
			event = "thermite_kill";
			break;
		}
		case "hash_357c8bc7826f851d":
		{
			event = "frag_kill";
			break;
		}
		case "overwatch_helicopter":
		{
			event = "overwatch_helicopter_kill";
			break;
		}
		case "swat_team":
		{
			event = "swat_team_kill";
			break;
		}
		default:
		{
			return;
		}
	}
	if(isdefined(inflictor))
	{
		if(isdefined(inflictor.killstreak_id) && isdefined(level.matchrecorderkillstreakkills[inflictor.killstreak_id]))
		{
			level.matchrecorderkillstreakkills[inflictor.killstreak_id]++;
		}
		else if(isdefined(inflictor.killcament) && isdefined(inflictor.killcament.killstreak_id) && isdefined(level.matchrecorderkillstreakkills[inflictor.killcament.killstreak_id]))
		{
			level.matchrecorderkillstreakkills[inflictor.killcament.killstreak_id]++;
		}
	}
	processscoreevent(event, attacker, victim, weapon);
}

/*
	Name: function_8fe4629e
	Namespace: scoreevents
	Checksum: 0x216E6A72
	Offset: 0x5900
	Size: 0x174
	Parameters: 2
	Flags: Linked
*/
function function_8fe4629e(killcount, weapon)
{
	doublekill = int(killcount / 2);
	if(doublekill > 0)
	{
		self activecamo::function_896ac347(weapon, #"doublekill", doublekill);
	}
	triplekill = int(killcount / 3);
	if(triplekill > 0)
	{
		self activecamo::function_896ac347(weapon, #"triplekill", triplekill);
	}
	var_d781da3d = int(killcount / 4);
	if(var_d781da3d > 0)
	{
		self activecamo::function_896ac347(weapon, #"hash_7f19a53e1e4e0f95", var_d781da3d);
	}
	var_22016f22 = int(killcount / 5);
	if(var_22016f22 > 0)
	{
		self activecamo::function_896ac347(weapon, #"hash_6a11a30d9f8002c7", var_22016f22);
	}
}

/*
	Name: multikill
	Namespace: scoreevents
	Checksum: 0x11282D5D
	Offset: 0x5A80
	Size: 0x3BC
	Parameters: 2
	Flags: Linked
*/
function multikill(killcount, weapon)
{
	/#
		assert(killcount > 1);
	#/
	self challenges::multikill(killcount, weapon);
	if(killcount > 7)
	{
		processscoreevent(#"hash_5276c86cb9b56332", self, undefined, weapon);
	}
	else
	{
		processscoreevent(#"multikill_" + killcount, self, undefined, weapon);
	}
	if(isdefined(self.var_a95c605e) && isdefined(self.var_3e5d9e0f))
	{
		if(self.var_a95c605e > 0 && self.var_3e5d9e0f > 0)
		{
			self stats::function_dad108fa(#"hash_1be224b059c35269", 1);
		}
	}
	if(killcount > 3)
	{
		util::function_5a68c330(19, self.team, self getentitynumber(), killcount);
	}
	if(killcount > 2)
	{
		if(isdefined(self.challenge_objectivedefensivekillcount) && self.challenge_objectivedefensivekillcount > 0)
		{
			self.challenge_objectivedefensivetriplekillmedalorbetterearned = 1;
		}
	}
	if(killcount >= 2)
	{
		scoreevents = globallogic_score::function_3cbc4c6c(weapon.var_2e4a8800);
		var_8a4cfbd = weapon.var_76ce72e8 && isdefined(scoreevents) && scoreevents.var_fcd2ff3a === 1;
		if(var_8a4cfbd)
		{
			self stats::function_dad108fa(#"hash_2fa96b97166080d2", 1);
			self contracts::function_a54e2068(#"hash_7861508178a93a0f");
		}
		else if(weapon.var_b76e0a09)
		{
			self stats::function_dad108fa(#"hash_cb8c5c845093e02", 1);
			self contracts::function_a54e2068(#"hash_3f50e5536ee788ab");
		}
	}
	if(killcount >= 3)
	{
		self contracts::function_a54e2068(#"hash_34056df55815ffbe");
		self contracts::function_a54e2068(#"hash_64a10fd107fcf644");
	}
	if(killcount >= 2)
	{
		self contracts::function_a54e2068(#"hash_586557e86aef88fd");
		self contracts::function_a54e2068(#"hash_8c7ac8fa81d9bc3");
	}
	if(!isdefined(self.pers[#"highestmultikill"]))
	{
		self.pers[#"highestmultikill"] = 0;
	}
	if(self.pers[#"highestmultikill"] < killcount)
	{
		self.pers[#"highestmultikill"] = killcount;
	}
	self recordmultikill(killcount);
}

/*
	Name: multiheroabilitykill
	Namespace: scoreevents
	Checksum: 0x5C8A5008
	Offset: 0x5E48
	Size: 0x12C
	Parameters: 2
	Flags: Linked
*/
function multiheroabilitykill(killcount, weapon)
{
	if(killcount > 1)
	{
		self stats::function_dad108fa(#"multikill_2_with_heroability", int(killcount / 2));
		self stats::function_e24eec31(weapon, #"heroability_doublekill", int(killcount / 2));
		self stats::function_dad108fa(#"multikill_3_with_heroability", int(killcount / 3));
		self stats::function_e24eec31(weapon, #"heroability_triplekill", int(killcount / 3));
	}
}

/*
	Name: is_weapon_valid
	Namespace: scoreevents
	Checksum: 0x2D6785EA
	Offset: 0x5F80
	Size: 0x1B2
	Parameters: 4
	Flags: Linked
*/
function is_weapon_valid(meansofdeath, weapon, weaponclass, killstreak)
{
	valid_weapon = 0;
	if(isdefined(killstreak))
	{
		valid_weapon = 0;
	}
	else if(get_distance_for_weapon(weapon, weaponclass) == 0)
	{
		valid_weapon = 0;
	}
	else if(meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_RIFLE_BULLET")
	{
		valid_weapon = 1;
	}
	else if(meansofdeath == "MOD_HEAD_SHOT")
	{
		valid_weapon = 1;
	}
	else if(weapon.rootweapon.name == "hatchet" && meansofdeath == "MOD_IMPACT")
	{
		valid_weapon = 1;
	}
	else
	{
		baseweapon = challenges::getbaseweapon(weapon);
		if(baseweapon == level.weaponspecialcrossbow || weapon.isballisticknife || baseweapon == level.var_9e188c0b && meansofdeath == "MOD_IMPACT")
		{
			valid_weapon = 1;
		}
		else if(baseweapon.forcedamagehitlocation || baseweapon == level.weaponshotgunenergy && meansofdeath == "MOD_PROJECTILE")
		{
			valid_weapon = 1;
		}
	}
	return valid_weapon;
}

/*
	Name: updatemultikills
	Namespace: scoreevents
	Checksum: 0x2EF3FA19
	Offset: 0x6140
	Size: 0x1084
	Parameters: 4
	Flags: Linked
*/
function updatemultikills(weapon, weaponclass, killstreak, victim)
{
	self endon(#"disconnect");
	self notify(#"updaterecentkills");
	self endon(#"updaterecentkills");
	baseweapon = weapons::getbaseweapon(weapon);
	if(!isdefined(self.recentkillvariables))
	{
		self resetrecentkillvariables();
	}
	primary_weapon = self loadout::function_18a77b37("primary");
	secondary_weapon = self loadout::function_18a77b37("secondary");
	if(isdefined(primary_weapon) && baseweapon.statname == primary_weapon.statname)
	{
		if(!isdefined(self.var_a95c605e))
		{
			self.var_a95c605e = 0;
		}
		self.var_a95c605e++;
	}
	else if(isdefined(secondary_weapon) && baseweapon.statname == secondary_weapon.statname)
	{
		if(!isdefined(self.var_3e5d9e0f))
		{
			self.var_3e5d9e0f = 0;
		}
		self.var_3e5d9e0f++;
	}
	if(!isdefined(self.recentkillcountweapon) || self.recentkillcountweapon != baseweapon)
	{
		self.recentkillcountsameweapon = 0;
		self.recentkillcountweapon = baseweapon;
	}
	if(!isdefined(killstreak))
	{
		self.recentkillcountsameweapon++;
		self.recentkillcount++;
	}
	if(isdefined(baseweapon.var_b76e0a09) && baseweapon.var_b76e0a09 || (isdefined(baseweapon.var_76ce72e8) && baseweapon.var_76ce72e8))
	{
		self.var_311e32f++;
		if(self.var_311e32f > 8)
		{
			processscoreevent(#"hash_658629ce68f99fb5", self, victim, weapon);
		}
		else if(self.var_311e32f > 1)
		{
			var_2ad6ce74 = "specialist_weapon_equipment_multikill_x" + self.var_311e32f;
			processscoreevent(var_2ad6ce74, self, victim, weapon);
		}
	}
	if(isdefined(weaponclass))
	{
		if(weaponclass == "weapon_lmg" || weaponclass == "weapon_smg")
		{
			if(self playerads() < 1)
			{
				self.recent_lmg_smg_killcount++;
			}
		}
		if(weaponclass == "weapon_grenade")
		{
			self.recentlethalcount++;
		}
	}
	if(weapon.name == #"satchel_charge")
	{
		self.recentc4killcount++;
	}
	if(isdefined(level.killstreakweapons) && isdefined(level.killstreakweapons[weapon]))
	{
		switch(level.killstreakweapons[weapon])
		{
			case "remote_missile":
			case "inventory_remote_missile":
			{
				self.recentremotemissilecount++;
				break;
			}
			case "inventory_rcbomb":
			case "rcbomb":
			{
				self.recentrcbombcount++;
				break;
			}
		}
	}
	if(weapon.isheavyweapon)
	{
		self.recentheavykill = gettime();
		self.recentheavyweaponkillcount++;
		if(isdefined(victim))
		{
			self.recentheavyweaponvictims[victim getentitynumber()] = victim;
		}
		switch(weapon.name)
		{
			case "hero_annihilator":
			{
				self.recentanihilatorcount++;
				break;
			}
			case "hero_minigun":
			{
				self.recentminiguncount++;
				break;
			}
			case "hero_bowlauncher2":
			case "hero_bowlauncher3":
			case "hero_bowlauncher4":
			case "hero_bowlauncher":
			{
				self.recentbowlaunchercount++;
				break;
			}
			case "hero_flamethrower":
			{
				self.recentflamethrowercount++;
				break;
			}
			case "hero_lightninggun":
			case "hero_lightninggun_arc":
			{
				self.recentlightningguncount++;
				break;
			}
			case "hero_pineapple_grenade":
			case "hero_pineapplegun":
			{
				self.recentpineappleguncount++;
				break;
			}
			case "hero_firefly_swarm":
			case "hero_chemicalgun":
			{
				self.recentgelguncount++;
				break;
			}
		}
	}
	if(self.var_a7f5c61e && weapon.name == #"hash_4bb2d7f789b561eb")
	{
		self.var_cc5ece37++;
	}
	if(isdefined(self.heroability) && isdefined(victim))
	{
		if(victim ability_player::gadget_checkheroabilitykill(self))
		{
			if(isdefined(self.recentheroabilitykillweapon) && self.recentheroabilitykillweapon != self.heroability)
			{
				self.recentheroabilitykillcount = 0;
			}
			self.recentheroabilitykillweapon = self.heroability;
			self.recentheroabilitykillcount++;
		}
	}
	if(isdefined(killstreak))
	{
		switch(killstreak)
		{
			case "remote_missile":
			{
				self.recentremotemissilekillcount++;
				break;
			}
			case "rcbomb":
			{
				self.recentrcbombkillcount++;
				break;
			}
			case "recon_car":
			case "inventory_recon_car":
			{
				self.var_70845d87++;
				break;
			}
			case "m32":
			case "inventory_m32":
			{
				self.recentmglkillcount++;
				break;
			}
		}
	}
	if(self.recentkillcountsameweapon == 2)
	{
		self stats::function_e24eec31(weapon, #"multikill_2", 1);
	}
	else if(self.recentkillcountsameweapon == 3)
	{
		self stats::function_e24eec31(weapon, #"multikill_3", 1);
	}
	self function_179829ab(4);
	if(self.recent_lmg_smg_killcount >= 3)
	{
		self challenges::multi_lmg_smg_kill();
	}
	if(self.recentrcbombkillcount >= 2)
	{
		self challenges::multi_rcbomb_kill();
	}
	if(self.var_70845d87 >= 2)
	{
		self challenges::function_46754062();
		self contracts::function_a54e2068(#"hash_741b3c0ab3e7a55f");
	}
	if(self.recentmglkillcount >= 3)
	{
		self challenges::multi_mgl_kill();
	}
	if(self.recentremotemissilekillcount >= 3)
	{
		self challenges::multi_remotemissile_kill();
		self contracts::function_a54e2068(#"hash_276886a0fbac5de0");
	}
	if(isdefined(self.recentheroweaponkillcount) && self.recentheroweaponkillcount > 1)
	{
		self hero_weapon_multikill_event(self.recentheroweaponkillcount, weapon);
	}
	if(self.recentheavyweaponkillcount > 5)
	{
		arrayremovevalue(self.recentheavyweaponvictims, undefined);
		if(self.recentheavyweaponvictims.size > 5)
		{
			self stats::function_dad108fa(#"kill_entire_team_with_specialist_weapon", 1);
		}
	}
	if(self.recentanihilatorcount >= 3)
	{
		self multikillmedalachievement();
	}
	else if(self.recentanihilatorcount == 2)
	{
		self multikillmedalachievement();
	}
	if(self.recentminiguncount >= 3)
	{
		processscoreevent(#"minigun_multikill", self, victim, weapon);
		self multikillmedalachievement();
	}
	else if(self.recentminiguncount == 2)
	{
		processscoreevent(#"minigun_multikill_2", self, victim, weapon);
		self multikillmedalachievement();
	}
	if(self.recentbowlaunchercount >= 3)
	{
		processscoreevent(#"bowlauncher_multikill", self, victim, weapon);
		self multikillmedalachievement();
	}
	else if(self.recentbowlaunchercount == 2)
	{
		processscoreevent(#"bowlauncher_multikill_2", self, victim, weapon);
		self multikillmedalachievement();
	}
	if(self.recentflamethrowercount >= 3)
	{
		processscoreevent(#"flamethrower_multikill", self, victim, weapon);
		self multikillmedalachievement();
	}
	else if(self.recentflamethrowercount == 2)
	{
		processscoreevent(#"flamethrower_multikill_2", self, victim, weapon);
		self multikillmedalachievement();
	}
	if(self.recentlightningguncount >= 3)
	{
		processscoreevent(#"lightninggun_multikill", self, victim, weapon);
		self multikillmedalachievement();
	}
	else if(self.recentlightningguncount == 2)
	{
		processscoreevent(#"hash_1ff9cffb9d62d81a", self, victim, weapon);
		self multikillmedalachievement();
	}
	if(self.recentpineappleguncount >= 3)
	{
		self multikillmedalachievement();
	}
	else if(self.recentpineappleguncount == 2)
	{
		self multikillmedalachievement();
	}
	if(self.recentgelguncount >= 3)
	{
		processscoreevent(#"gelgun_multikill", self, victim, weapon);
		self multikillmedalachievement();
	}
	else if(self.recentgelguncount == 2)
	{
		processscoreevent(#"gelgun_multikill_2", self, victim, weapon);
		self multikillmedalachievement();
	}
	if(self.recentarmbladecount >= 3)
	{
		processscoreevent(#"armblades_multikill", self, victim, weapon);
		self multikillmedalachievement();
	}
	else if(self.recentarmbladecount == 2)
	{
		processscoreevent(#"armblades_multikill_2", self, victim, weapon);
		self multikillmedalachievement();
	}
	if(self.recentc4killcount >= 2)
	{
		processscoreevent(#"c4_multikill", self, victim, weapon);
	}
	if(self.recentremotemissilecount >= 3)
	{
		self stats::function_dad108fa(#"multikill_3_remote_missile", 1);
	}
	if(self.recentrcbombcount >= 2)
	{
		self stats::function_dad108fa(#"multikill_2_rcbomb", 1);
	}
	if(self.recentlethalcount >= 2)
	{
		if(!isdefined(self.pers[#"challenge_kills_double_kill_lethal"]))
		{
			self.pers[#"challenge_kills_double_kill_lethal"] = 0;
		}
		self.pers[#"challenge_kills_double_kill_lethal"]++;
		if(self.pers[#"challenge_kills_double_kill_lethal"] >= 3)
		{
			self stats::function_dad108fa(#"kills_double_kill_3_lethal", 1);
		}
	}
	if(self.recentkillcount > 1)
	{
		self multikill(self.recentkillcount, weapon);
		if(self.recentkillcountsameweapon < self.recentkillcount)
		{
			self contracts::function_a54e2068(#"hash_23e14aee63c48afc");
		}
	}
	if(self.recentkillcountsameweapon > 1)
	{
		self function_8fe4629e(self.recentkillcountsameweapon, weapon);
	}
	if(self.recentheroabilitykillcount > 1)
	{
		self multiheroabilitykill(self.recentheroabilitykillcount, self.recentheroabilitykillweapon);
		self hero_ability_multikill_event(self.recentheroabilitykillcount, self.recentheroabilitykillweapon);
	}
	if(self.var_cc5ece37 >= 2)
	{
		event = "grapple_slam_multikill_" + self.var_cc5ece37;
		processscoreevent(event, self, victim, weapon);
	}
	self resetrecentkillvariables();
}

/*
	Name: resetrecentkillvariables
	Namespace: scoreevents
	Checksum: 0x4AF85A5
	Offset: 0x71D0
	Size: 0x146
	Parameters: 0
	Flags: Linked
*/
function resetrecentkillvariables()
{
	self.recentanihilatorcount = 0;
	self.recent_lmg_smg_killcount = 0;
	self.recentarmbladecount = 0;
	self.recentbowlaunchercount = 0;
	self.recentc4killcount = 0;
	self.recentflamethrowercount = 0;
	self.recentgelguncount = 0;
	self.var_cc5ece37 = 0;
	self.recentheroabilitykillcount = 0;
	self.recentheavyweaponkillcount = 0;
	self.recentheavyweaponvictims = [];
	self.recentkillcount = 0;
	self.recentkillcountsameweapon = 0;
	self.recentkillcountweapon = undefined;
	self.recentlethalcount = 0;
	self.recentlightningguncount = 0;
	self.recentmglkillcount = 0;
	self.recentminiguncount = 0;
	self.recentpineappleguncount = 0;
	self.recentrcbombcount = 0;
	self.recentrcbombkillcount = 0;
	self.var_70845d87 = 0;
	self.recentremotemissilecount = 0;
	self.recentremotemissilekillcount = 0;
	self.var_311e32f = 0;
	self.var_a95c605e = undefined;
	self.var_3e5d9e0f = undefined;
	self.recentkillvariables = 1;
}

/*
	Name: function_179829ab
	Namespace: scoreevents
	Checksum: 0x588BD323
	Offset: 0x7320
	Size: 0x38
	Parameters: 1
	Flags: Linked
*/
function function_179829ab(timeout)
{
	self endon(#"death");
	level endon(#"game_ended");
	wait(timeout);
}

/*
	Name: updateoneshotmultikills
	Namespace: scoreevents
	Checksum: 0xF91E3A45
	Offset: 0x7360
	Size: 0x2BE
	Parameters: 4
	Flags: Linked
*/
function updateoneshotmultikills(victim, weapon, firsttimedamaged, meansofdeath)
{
	self endon(#"death", #"disconnect");
	self notify("updateoneshotmultikills" + firsttimedamaged);
	self endon("updateoneshotmultikills" + firsttimedamaged);
	if(!isdefined(self.oneshotmultikills) || firsttimedamaged > (isdefined(self.oneshotmultikillsdamagetime) ? self.oneshotmultikillsdamagetime : 0))
	{
		self.oneshotmultikills = 0;
	}
	self.oneshotmultikills++;
	self.oneshotmultikillsdamagetime = firsttimedamaged;
	wait(1);
	if(self.oneshotmultikills > 1)
	{
		processscoreevent(#"kill_enemies_one_bullet", self, victim, weapon);
		self contracts::function_a54e2068(#"hash_45b74ebf1ab2fd47");
	}
	else if(weapon.statindex != level.var_bb448b5f.statindex)
	{
		processscoreevent(#"kill_enemy_one_bullet", self, victim, weapon);
		if(!level.hardcoremode)
		{
			self contracts::function_a54e2068(#"hash_47f2f8fa5afb9d01");
		}
		if(meansofdeath == "MOD_HEAD_SHOT")
		{
			var_f9d69b3b = self stats::function_441050ca(#"hash_4db8a1f607f40ac1");
			var_35635206 = self stats::function_af5584ca(#"hash_4db8a1f607f40ac1");
			var_413c3e61 = 1;
			if(isdefined(var_35635206))
			{
				switch(var_35635206)
				{
					case 1:
					{
						if(var_f9d69b3b < 50)
						{
							var_413c3e61 = var_413c3e61 + 50;
						}
						break;
					}
					case 2:
					{
						if(var_f9d69b3b < 150)
						{
							var_413c3e61 = var_413c3e61 + 150;
						}
						break;
					}
				}
			}
			self stats::function_dad108fa(#"hash_4db8a1f607f40ac1", var_413c3e61);
		}
	}
	self.oneshotmultikills = 0;
}

/*
	Name: get_distance_for_weapon
	Namespace: scoreevents
	Checksum: 0xB646CB94
	Offset: 0x7628
	Size: 0x21E
	Parameters: 2
	Flags: Linked
*/
function get_distance_for_weapon(weapon, weaponclass)
{
	distance = 0;
	if(!isdefined(weaponclass))
	{
		return 0;
	}
	if(weapon.rootweapon.name == "pistol_shotgun")
	{
		weaponclass = "weapon_cqb";
	}
	switch(weaponclass)
	{
		case "weapon_smg":
		{
			distance = 1960000;
			break;
		}
		case "weapon_assault":
		{
			distance = 2560000;
			break;
		}
		case "weapon_tactical":
		{
			distance = 2560000;
			break;
		}
		case "weapon_lmg":
		{
			distance = 2560000;
			break;
		}
		case "weapon_sniper":
		{
			distance = 4000000;
			break;
		}
		case "weapon_pistol":
		{
			distance = 1000000;
			break;
		}
		case "weapon_cqb":
		{
			distance = 302500;
			break;
		}
		case "weapon_special":
		{
			if(weapon.isballisticknife)
			{
				distance = 2250000;
			}
			else
			{
				baseweapon = challenges::getbaseweapon(weapon);
				if(baseweapon == level.weaponspecialcrossbow)
				{
					distance = 1000000;
				}
			}
			break;
		}
		case "weapon_grenade":
		{
			if(weapon.rootweapon.name == "hatchet")
			{
				distance = 2250000;
			}
			break;
		}
		default:
		{
			distance = 0;
			break;
		}
	}
	return distance;
}

/*
	Name: ongameend
	Namespace: scoreevents
	Checksum: 0x127F51CA
	Offset: 0x7850
	Size: 0x1E4
	Parameters: 1
	Flags: Linked
*/
function ongameend(data)
{
	player = data.player;
	winner = data.winner;
	if(isdefined(winner))
	{
		if(level.teambased)
		{
			if(!match::function_5f24faac("tie") && player.team == winner)
			{
				player.pers[#"hash_6344af0b142ed0b6"] = 1;
				processscoreevent(#"won_match", player, undefined, undefined);
				return;
			}
		}
		else
		{
			placement = level.placement[#"all"];
			topthreeplayers = min(3, placement.size);
			for(index = 0; index < topthreeplayers; index++)
			{
				if(level.placement[#"all"][index] == player)
				{
					player.pers[#"hash_6344af0b142ed0b6"] = 1;
					processscoreevent(#"won_match", player, undefined, undefined);
					return;
				}
			}
		}
	}
	processscoreevent(#"completed_match", player, undefined, undefined);
}

/*
	Name: specialistmedalachievement
	Namespace: scoreevents
	Checksum: 0xF13121AD
	Offset: 0x7A40
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function specialistmedalachievement()
{
	if(level.rankedmatch)
	{
		if(!isdefined(self.pers[#"specialistmedalachievement"]))
		{
			self.pers[#"specialistmedalachievement"] = 0;
		}
		self.pers[#"specialistmedalachievement"]++;
		if(self.pers[#"specialistmedalachievement"] == 5)
		{
			self giveachievement("MP_SPECIALIST_MEDALS");
		}
		self contracts::player_contract_event(#"earned_specialist_ability_medal");
	}
}

/*
	Name: specialiststatabilityusage
	Namespace: scoreevents
	Checksum: 0x3C3DD1D9
	Offset: 0x7B10
	Size: 0x246
	Parameters: 2
	Flags: Linked
*/
function specialiststatabilityusage(usagesinglegame, multitrackperlife)
{
	self endon(#"disconnect");
	self notify(#"hash_f92aeaeaf35ba82");
	self endon(#"hash_f92aeaeaf35ba82");
	isroulette = self.isroulette === 1;
	if(isdefined(self.heroability) && !isroulette)
	{
		self function_be7a08a8(self.heroability, 1);
	}
	self challenges::processspecialistchallenge("kills_ability");
	if(!isdefined(self.pers[#"specialistusagepergame"]))
	{
		self.pers[#"specialistusagepergame"] = 0;
	}
	self.pers[#"specialistusagepergame"]++;
	if(self.pers[#"specialistusagepergame"] >= usagesinglegame)
	{
		self challenges::processspecialistchallenge("kill_one_game_ability");
		self.pers[#"specialistusagepergame"] = 0;
	}
	if(multitrackperlife)
	{
		self.pers[#"specialiststatabilityusage"]++;
		if(self.pers[#"specialiststatabilityusage"] >= 2)
		{
			self challenges::processspecialistchallenge("multikill_ability");
		}
	}
	else if(!isdefined(self.specialiststatabilityusage))
	{
		self.specialiststatabilityusage = 0;
	}
	self.specialiststatabilityusage++;
	self function_179829ab(4);
	if(self.specialiststatabilityusage >= 2)
	{
		self challenges::processspecialistchallenge("multikill_ability");
	}
	self.specialiststatabilityusage = 0;
}

/*
	Name: function_9aef690a
	Namespace: scoreevents
	Checksum: 0x75C046ED
	Offset: 0x7D60
	Size: 0x6E
	Parameters: 1
	Flags: Linked
*/
function function_9aef690a(weapon)
{
	baseweapon = weapons::getbaseweapon(weapon);
	return isdefined(baseweapon.var_b76e0a09) && baseweapon.var_b76e0a09 || (isdefined(baseweapon.var_76ce72e8) && baseweapon.var_76ce72e8);
}

/*
	Name: multikillmedalachievement
	Namespace: scoreevents
	Checksum: 0x86F38928
	Offset: 0x7DD8
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function multikillmedalachievement()
{
	if(level.rankedmatch)
	{
		self giveachievement("MP_MULTI_KILL_MEDALS");
		self challenges::processspecialistchallenge("multikill_weapon");
	}
}

/*
	Name: function_c01cb128
	Namespace: scoreevents
	Checksum: 0x28B2D241
	Offset: 0x7E30
	Size: 0x82
	Parameters: 2
	Flags: Linked
*/
function function_c01cb128(entity, var_f208fb92)
{
	if(!isdefined(entity) || !isdefined(var_f208fb92) || !isarray(var_f208fb92) || !isdefined(entity.origin))
	{
		return undefined;
	}
	return function_c28e2c05(entity.origin, var_f208fb92, 1);
}

/*
	Name: function_c28e2c05
	Namespace: scoreevents
	Checksum: 0xFD8B0544
	Offset: 0x7EC0
	Size: 0x13A
	Parameters: 3
	Flags: Linked
*/
function function_c28e2c05(var_152c14d0, var_f208fb92, var_e13a103a)
{
	if(!var_e13a103a)
	{
		if(!isdefined(var_f208fb92) || !isarray(var_f208fb92) || !isdefined(var_152c14d0))
		{
			return undefined;
		}
	}
	foreach(sensor in var_f208fb92)
	{
		if(!isdefined(sensor))
		{
			continue;
		}
		if(distancesquared(var_152c14d0, sensor.origin) < (function_f99d2668() ? 2400 : 800) + 50 * (function_f99d2668() ? 2400 : 800) + 50)
		{
			return sensor;
		}
	}
	return undefined;
}

/*
	Name: function_3932ffa2
	Namespace: scoreevents
	Checksum: 0xD7A75B18
	Offset: 0x8008
	Size: 0x82
	Parameters: 1
	Flags: Linked
*/
function function_3932ffa2(var_f208fb92)
{
	foreach(sensor in var_f208fb92)
	{
		if(!isdefined(sensor))
		{
			continue;
		}
		sensor.var_1fd3a368 = 0;
	}
}

/*
	Name: function_43ee1b3d
	Namespace: scoreevents
	Checksum: 0xE8EF1124
	Offset: 0x8098
	Size: 0x2CC
	Parameters: 3
	Flags: None
*/
function function_43ee1b3d(attacker, victim, attackerweapon)
{
	if(!isdefined(level.var_5101157d) || !isdefined(level.var_5101157d.var_f115c746))
	{
		return;
	}
	if(isdefined(attackerweapon) && isdefined(level.iskillstreakweapon) && [[level.iskillstreakweapon]](attackerweapon))
	{
		return 0;
	}
	foreach(smartcover in level.var_5101157d.var_f115c746)
	{
		if(!isdefined(smartcover))
		{
			continue;
		}
		if(victim == smartcover.owner)
		{
			continue;
		}
		var_583e1573 = distancesquared(smartcover.origin, attacker.origin);
		if(var_583e1573 > level.var_5101157d.var_357db326)
		{
			continue;
		}
		var_eb870c = distancesquared(victim.origin, smartcover.origin);
		var_ae30f518 = distancesquared(victim.origin, attacker.origin);
		var_d9ecf725 = var_ae30f518 > var_583e1573;
		var_1d1ca33b = var_ae30f518 > var_eb870c;
		if(var_d9ecf725 && var_1d1ca33b)
		{
			var_a3aba5a9 = 1;
			var_71eedb0b = smartcover.owner;
			break;
		}
	}
	if(isdefined(var_71eedb0b) && isdefined(var_a3aba5a9) && var_a3aba5a9)
	{
		if(smartcover.owner == attacker)
		{
			processscoreevent(#"hash_253788f8c27edb93", var_71eedb0b, victim, level.var_5101157d.var_8d86ade8);
		}
		else
		{
			processscoreevent(#"hash_3d0d53aff3c68c68", var_71eedb0b, victim, level.var_5101157d.var_8d86ade8);
		}
	}
}

