// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_18f0d22c75b141a7;
#using script_47fb62300ac0bd60;
#using script_7133a4d461308099;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\contracts_shared.gsc;
#using scripts\core_common\rank_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\weapons_shared.gsc;

#namespace globallogic_score;

/*
	Name: function_89f2df9
	Namespace: globallogic_score
	Checksum: 0x652113EE
	Offset: 0x178
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"globallogic_score", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: globallogic_score
	Checksum: 0x2A1724E5
	Offset: 0x1C0
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_start_gametype(&init);
	callback::on_spawned(&playerspawn);
	/#
		setdvar(#"hash_39060c853726e6c0", 0);
		setdvar(#"hash_35960c7344552dce", 0);
		thread function_bb9f3842();
	#/
}

/*
	Name: init
	Namespace: globallogic_score
	Checksum: 0x1883083
	Offset: 0x268
	Size: 0x56
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level.var_e0582de1 = [];
	registerscoreeventcallback("playerKilled", &function_f7f7b14e);
	level.capturedobjectivefunction = &function_eced93f5;
}

/*
	Name: playerspawn
	Namespace: globallogic_score
	Checksum: 0x281D3F87
	Offset: 0x2C8
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function playerspawn()
{
	self.var_60a9eae7 = 0;
	self.var_a6b00192 = 0;
	self.var_7fff4605 = 0;
	self callback::function_f77ced93(&function_f77ced93);
	self callback::function_78ccee50(&function_78ccee50);
	self callback::function_20263b9e(&function_20263b9e);
}

/*
	Name: function_f77ced93
	Namespace: globallogic_score
	Checksum: 0xA4A1EF74
	Offset: 0x358
	Size: 0x22
	Parameters: 1
	Flags: Linked, Private
*/
private function function_f77ced93(params)
{
	self.var_a6b00192 = 0;
	self.var_7fff4605 = 0;
}

/*
	Name: function_78ccee50
	Namespace: globallogic_score
	Checksum: 0xE4B8F9EA
	Offset: 0x388
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_78ccee50(params)
{
	self function_5aa55c0a(params.weapon);
}

/*
	Name: function_f0d51d49
	Namespace: globallogic_score
	Checksum: 0xEEF6A8C1
	Offset: 0x3C0
	Size: 0xD4
	Parameters: 2
	Flags: Linked, Private
*/
private function function_f0d51d49(projectile, weapon)
{
	self endon(#"disconnect");
	level endon(#"game_ended");
	scoreevents = function_3cbc4c6c(weapon.var_2e4a8800);
	if(!isdefined(scoreevents.var_aa14d757))
	{
		return;
	}
	var_2a7ea9a6 = undefined;
	var_2a7ea9a6 = projectile waittill_timeout(10, #"death");
	if(var_2a7ea9a6._notify != "timeout")
	{
		scoreevents::processscoreevent(scoreevents.var_aa14d757, self, undefined, weapon);
	}
}

/*
	Name: function_20263b9e
	Namespace: globallogic_score
	Checksum: 0x2EDAD6EE
	Offset: 0x4A0
	Size: 0x7C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_20263b9e(params)
{
	weapon = params.weapon;
	if(!isdefined(weapon) || !isdefined(weapon.var_2e4a8800))
	{
		return;
	}
	self function_5aa55c0a(weapon);
	self thread function_f0d51d49(params.projectile, weapon);
}

/*
	Name: function_5aa55c0a
	Namespace: globallogic_score
	Checksum: 0xDB5D43E9
	Offset: 0x528
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function function_5aa55c0a(weapon)
{
	if(isdefined(weapon) && isdefined(weapon.var_2e4a8800))
	{
		scoreevents = function_3cbc4c6c(weapon.var_2e4a8800);
	}
	if(!isdefined(scoreevents))
	{
		return;
	}
	if(isdefined(scoreevents.var_7ecee77b))
	{
		scoreevents::processscoreevent(scoreevents.var_7ecee77b, self, undefined, weapon);
	}
}

/*
	Name: inctotalkills
	Namespace: globallogic_score
	Checksum: 0xCCFEEE86
	Offset: 0x5C0
	Size: 0x50
	Parameters: 1
	Flags: Linked
*/
function inctotalkills(team)
{
	if(level.teambased && isdefined(level.teams[team]))
	{
		game.totalkillsteam[team]++;
	}
	game.totalkills++;
}

/*
	Name: givekillstats
	Namespace: globallogic_score
	Checksum: 0x9D013D94
	Offset: 0x618
	Size: 0x48
	Parameters: 3
	Flags: Linked
*/
function givekillstats(smeansofdeath, weapon, evictim)
{
	if(isdefined(level.scoreevents_givekillstats))
	{
		[[level.scoreevents_givekillstats]](smeansofdeath, weapon, evictim);
	}
}

/*
	Name: function_e93cd1bb
	Namespace: globallogic_score
	Checksum: 0x6397AAC6
	Offset: 0x668
	Size: 0xDC
	Parameters: 6
	Flags: Linked
*/
function function_e93cd1bb(event, var_ba01256c, weapon, attacker, victim, var_586a3b24)
{
	if(!isdefined(var_ba01256c))
	{
		return 0;
	}
	if(!isdefined(attacker.var_19f577f))
	{
		attacker.var_19f577f = [];
	}
	attacker.var_19f577f[event] = (isdefined(attacker.var_19f577f[event]) ? attacker.var_19f577f[event] : 0) + 1;
	if(isdefined(var_586a3b24) && var_586a3b24)
	{
		scoreevents::processscoreevent(event, attacker, victim, weapon);
	}
}

/*
	Name: function_969ea48d
	Namespace: globallogic_score
	Checksum: 0xBA6583F7
	Offset: 0x750
	Size: 0xD8
	Parameters: 2
	Flags: Linked
*/
function function_969ea48d(var_ba01256c, weapon)
{
	if(!isdefined(var_ba01256c))
	{
		return 0;
	}
	scoreevents = function_3cbc4c6c(var_ba01256c.var_2e4a8800);
	if(!isdefined(scoreevents) || !isdefined(scoreevents.var_1253685d))
	{
		return 0;
	}
	scoreevents::processscoreevent(scoreevents.var_1253685d, self, undefined, weapon);
	if(rank::function_ca5d4a8(scoreevents.var_1253685d))
	{
		function_e93cd1bb(scoreevents.var_1253685d, var_ba01256c, weapon, self, undefined, 0);
	}
	return 1;
}

/*
	Name: function_52ca9649
	Namespace: globallogic_score
	Checksum: 0xF20A347
	Offset: 0x830
	Size: 0xEE
	Parameters: 1
	Flags: Linked
*/
function function_52ca9649(event)
{
	if(!isdefined(level.scoreinfo[event]))
	{
		/#
			println("" + event);
		#/
		return 0;
	}
	if(!isdefined(self.var_19f577f))
	{
		self.var_19f577f = [];
	}
	if(!isdefined(self.var_19f577f[event]) || self.var_19f577f[event] <= 0)
	{
		return;
	}
	eventindex = level.scoreinfo[event][#"row"];
	self luinotifyevent(#"hash_2ba26a631965ab0b", 1, eventindex);
	self.var_19f577f[event]--;
}

/*
	Name: function_fc47f2ff
	Namespace: globallogic_score
	Checksum: 0x795D0C69
	Offset: 0x928
	Size: 0x84
	Parameters: 2
	Flags: Linked
*/
function function_fc47f2ff(var_ba01256c, weapon)
{
	if(!isdefined(var_ba01256c))
	{
		return 0;
	}
	scoreevents = function_3cbc4c6c(var_ba01256c.var_2e4a8800);
	if(!isdefined(scoreevents) || !isdefined(scoreevents.var_1253685d))
	{
		return 0;
	}
	function_52ca9649(scoreevents.var_1253685d);
}

/*
	Name: processassist
	Namespace: globallogic_score
	Checksum: 0xE55CDB20
	Offset: 0x9B8
	Size: 0x1DC
	Parameters: 6
	Flags: Linked
*/
function processassist(killedplayer, damagedone, weapon, assist_level = undefined, time = gettime(), meansofdeath = "MOD_UNKNOWN")
{
	waitframe(1);
	util::waittillslowprocessallowed();
	if(!isdefined(self) || !isdefined(killedplayer) || !isplayer(self) || !isplayer(killedplayer) || !isdefined(weapon))
	{
		return;
	}
	if(isarray(level.var_b13d1f9b))
	{
		foreach(var_25f92d1d in level.var_b13d1f9b)
		{
			self function_b78294bf(killedplayer, var_25f92d1d.weapon, weapon, var_25f92d1d, time, meansofdeath);
		}
	}
	self function_b78294bf(killedplayer, weapon, weapon, undefined, time, meansofdeath);
	if(isdefined(level.scoreevents_processassist))
	{
		self [[level.scoreevents_processassist]](killedplayer, damagedone, weapon, assist_level);
	}
}

/*
	Name: function_b78294bf
	Namespace: globallogic_score
	Checksum: 0xC9AEDC1F
	Offset: 0xBA0
	Size: 0x1F4
	Parameters: 6
	Flags: Linked, Private
*/
private function function_b78294bf(victim, weapon, attackerweapon, var_67660cb2, time, meansofdeath)
{
	scoreevents = function_3cbc4c6c(weapon.var_2e4a8800);
	if((isdefined(victim.var_60a9eae7) ? victim.var_60a9eae7 : 0) && isdefined(scoreevents) && isdefined(scoreevents.var_a6bfdc5f))
	{
		if(isdefined(var_67660cb2))
		{
			if(!isdefined(var_67660cb2.var_37850de1) || ![[var_67660cb2.var_37850de1]](self, victim, weapon, attackerweapon))
			{
				return;
			}
		}
		self function_662aaa65(weapon);
		self.var_fee0b504[weapon.name].var_3e9f80b2++;
		if(isdefined(scoreevents) && isdefined(scoreevents.var_a6bfdc5f))
		{
			scoreevents::processscoreevent(scoreevents.var_a6bfdc5f, self, victim, weapon);
		}
	}
	else if(isdefined(var_67660cb2))
	{
		if(!isdefined(var_67660cb2.var_6d794427) || ![[var_67660cb2.var_6d794427]](self, victim, weapon, attackerweapon, meansofdeath))
		{
			return;
		}
	}
	if(isdefined(scoreevents) && isdefined(scoreevents.var_170b3630))
	{
		scoreevents::processscoreevent(scoreevents.var_170b3630, self, victim, weapon);
	}
	self function_8279d8bf(weapon, scoreevents);
}

/*
	Name: function_5829abe3
	Namespace: globallogic_score
	Checksum: 0x7D10D57A
	Offset: 0xDA0
	Size: 0x29C
	Parameters: 3
	Flags: None
*/
function function_5829abe3(attacker, weapon, var_651b6171)
{
	if(!isdefined(self) || !isdefined(var_651b6171) || !isdefined(attacker) || !isplayer(attacker))
	{
		return;
	}
	if(!isdefined(weapon))
	{
		weapon = level.weaponnone;
	}
	attacker challenges::function_24db0c33(weapon, var_651b6171);
	if(isdefined(level.iskillstreakweapon))
	{
		if([[level.iskillstreakweapon]](weapon) || (isdefined(weapon.statname) && [[level.iskillstreakweapon]](getweapon(weapon.statname))))
		{
			var_629fbd5c = 1;
		}
		if([[level.iskillstreakweapon]](var_651b6171))
		{
			destroyedkillstreak = 1;
		}
	}
	var_3c727edf = function_3cbc4c6c(var_651b6171.var_2e4a8800);
	if(!(isdefined(var_629fbd5c) && var_629fbd5c) || (isdefined(destroyedkillstreak) && destroyedkillstreak) && isdefined(var_3c727edf) && isdefined(var_3c727edf.var_3143c814) && util::function_fbce7263(attacker.team, self.team))
	{
		scoreevents::processscoreevent(var_3c727edf.var_3143c814, attacker, self, var_651b6171);
		attacker stats::function_dad108fa(#"stats_destructions", 1);
	}
	if(var_651b6171.var_b76e0a09)
	{
		attacker namespace_bd02cf1::function_896ac347(weapon, #"showstopper", 1);
	}
	scoreevents = function_3cbc4c6c(weapon.var_2e4a8800);
	if(isdefined(scoreevents) && isdefined(scoreevents.var_84eddb70))
	{
		scoreevents::processscoreevent(scoreevents.var_84eddb70, attacker, self, weapon);
	}
}

/*
	Name: function_a890cac2
	Namespace: globallogic_score
	Checksum: 0xDF35016
	Offset: 0x1048
	Size: 0x284
	Parameters: 6
	Flags: Linked
*/
function function_a890cac2(attacker, owningteam, weapon, scoreevents, var_4ed35da2, var_1bbdd8b0)
{
	attacker function_662aaa65(weapon);
	attacker.var_fee0b504[weapon.name].var_3e9f80b2++;
	if(level.teambased && isdefined(owningteam) && attacker.team == owningteam)
	{
		if(isdefined(level.var_b13d1f9b) && isdefined(level.var_b13d1f9b[weapon.name]) && isdefined(level.var_b13d1f9b[weapon.name].var_826b85e7))
		{
			[[level.var_b13d1f9b[weapon.name].var_826b85e7]](attacker, self, weapon, var_4ed35da2);
		}
		if(isdefined(scoreevents) && isdefined(scoreevents.var_867de225))
		{
			scoreevents::processscoreevent(scoreevents.var_867de225, attacker, self, weapon);
		}
		if((isdefined(attacker.var_fee0b504[attacker.var_fee0b504[weapon.name].name].var_3e9f80b2) ? attacker.var_fee0b504[weapon.name].var_3e9f80b2 : 0) > 2 && (isdefined(var_4ed35da2.var_4e02c9bd) ? var_4ed35da2.var_4e02c9bd : 0) < gettime())
		{
			enemies = attacker function_bdda420f(var_4ed35da2.origin, var_1bbdd8b0);
			if(enemies.size == 0)
			{
				var_4ed35da2.var_4e02c9bd = gettime() + 4000;
				attacker.var_fee0b504[weapon.name].var_d6089e48 = 1;
			}
		}
	}
	if(isdefined(scoreevents) && isdefined(scoreevents.var_8600aca4))
	{
		scoreevents::processscoreevent(scoreevents.var_8600aca4, attacker, self, weapon);
	}
}

/*
	Name: function_7d830bc
	Namespace: globallogic_score
	Checksum: 0xA58C51B
	Offset: 0x12D8
	Size: 0x32C
	Parameters: 7
	Flags: None
*/
function function_7d830bc(einflictor, attacker, weapon, var_4ed35da2, var_1bbdd8b0, owningteam, var_5b1d28ec)
{
	attacker endon(#"disconnect", #"death");
	level endon(#"game_ended");
	self notify("38c4e69a4b1b634c");
	self endon("38c4e69a4b1b634c");
	if(!isplayer(attacker) || !isplayer(self) || !isdefined(weapon) || !isdefined(var_4ed35da2) || !isdefined(var_5b1d28ec) || !isdefined(var_1bbdd8b0))
	{
		return 0;
	}
	if(!self istouching(var_5b1d28ec, (var_1bbdd8b0, var_1bbdd8b0, 100)))
	{
		if(!isdefined(einflictor) || einflictor != attacker || !attacker istouching(var_5b1d28ec, (var_1bbdd8b0, var_1bbdd8b0, 100)))
		{
			return 0;
		}
	}
	self.var_60a9eae7 = 1;
	attacker.var_f46a73a1 = weapon;
	attacker.var_60f43bac = gettime();
	attacker.var_e3d30669 = var_4ed35da2;
	scoreevents = function_3cbc4c6c(weapon.var_2e4a8800);
	self function_a890cac2(attacker, owningteam, weapon, scoreevents, var_4ed35da2, var_1bbdd8b0);
	if(isarray(level.var_b13d1f9b))
	{
		foreach(var_25f92d1d in level.var_b13d1f9b)
		{
			if(!isdefined(var_25f92d1d.var_37850de1) || ![[var_25f92d1d.var_37850de1]](attacker, self, var_25f92d1d.weapon, weapon))
			{
				continue;
			}
			var_bbe53115 = function_3cbc4c6c(var_25f92d1d.weapon.var_2e4a8800);
			self function_a890cac2(attacker, owningteam, var_25f92d1d.weapon, var_bbe53115, var_4ed35da2, var_1bbdd8b0);
		}
	}
	return 1;
}

/*
	Name: function_eced93f5
	Namespace: globallogic_score
	Checksum: 0x33390D52
	Offset: 0x1610
	Size: 0x1E4
	Parameters: 2
	Flags: Linked, Private
*/
private function function_eced93f5(objective, var_c217216c)
{
	if(!isdefined(objective) || !isdefined(var_c217216c) || !isdefined(self) || !isdefined(self.var_f46a73a1) || !isdefined(self.var_60f43bac) || !isdefined(self.var_e3d30669))
	{
		return;
	}
	if(var_c217216c - self.var_60f43bac > int(20 * 1000) || objective != self.var_e3d30669)
	{
		return;
	}
	if(isarray(level.var_b13d1f9b))
	{
		foreach(var_a1960192 in level.var_b13d1f9b)
		{
			if(isdefined(var_a1960192.var_d20c7012))
			{
				[[var_a1960192.var_d20c7012]](self, self.var_f46a73a1, self.var_60f43bac, self.var_e3d30669, var_a1960192.weapon);
			}
		}
	}
	scoreevents = function_3cbc4c6c(self.var_f46a73a1.var_2e4a8800);
	if(isdefined(scoreevents) && isdefined(scoreevents.var_1d0ab0f4))
	{
		scoreevents::processscoreevent(scoreevents.var_1d0ab0f4, self, undefined, self.var_f46a73a1);
	}
}

/*
	Name: registerscoreeventcallback
	Namespace: globallogic_score
	Checksum: 0x514BFA36
	Offset: 0x1800
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
	Name: function_3cbc4c6c
	Namespace: globallogic_score
	Checksum: 0xDADED46E
	Offset: 0x1890
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_3cbc4c6c(scriptbundle)
{
	if(!isdefined(scriptbundle))
	{
		return;
	}
	if(!isdefined(level.var_e0582de1[scriptbundle]))
	{
		level.var_e0582de1[scriptbundle] = getscriptbundle(scriptbundle);
	}
	return level.var_e0582de1[scriptbundle];
}

/*
	Name: function_24d66e59
	Namespace: globallogic_score
	Checksum: 0xC22B984A
	Offset: 0x18F8
	Size: 0x4E8
	Parameters: 7
	Flags: Linked
*/
function function_24d66e59(inflictor, meansofdeath, victim, attacker, weapon, var_bd10969, time)
{
	if(!isdefined(var_bd10969) || !isarray(var_bd10969))
	{
		return;
	}
	waitframe(1);
	util::waittillslowprocessallowed();
	if(!isdefined(victim))
	{
		return;
	}
	foreach(effect in var_bd10969)
	{
		if(!isdefined(effect) || !isdefined(effect.var_4b22e697) || victim == effect.var_4b22e697)
		{
			continue;
		}
		scoreevents = function_3cbc4c6c(effect.var_2e4a8800);
		if(!isdefined(scoreevents))
		{
			continue;
		}
		if((isdefined(victim.var_60a9eae7) ? victim.var_60a9eae7 : 0) && (isdefined(scoreevents.var_a6bfdc5f) || isdefined(scoreevents.var_8600aca4)))
		{
			attacker function_662aaa65(effect);
			attacker.var_fee0b504[effect.name].var_3e9f80b2++;
			if(isdefined(effect.var_4b22e697) && isplayer(effect.var_4b22e697) && attacker != effect.var_4b22e697)
			{
				if(isdefined(scoreevents.var_a6bfdc5f))
				{
					scoreevents::processscoreevent(scoreevents.var_a6bfdc5f, effect.var_4b22e697, victim, effect.var_3d1ed4bd);
				}
			}
			else if(isdefined(scoreevents.var_8600aca4))
			{
				scoreevents::processscoreevent(scoreevents.var_8600aca4, effect.var_4b22e697, victim, effect.var_3d1ed4bd);
			}
		}
		else if(isdefined(effect.var_4b22e697) && isplayer(effect.var_4b22e697) && attacker != effect.var_4b22e697 && attacker util::isenemyplayer(effect.var_4b22e697) == 0)
		{
			baseweapon = weapons::getbaseweapon(weapon);
			if(isdefined(scoreevents.var_2eaed769) && (isdefined(baseweapon.var_b76e0a09) && baseweapon.var_b76e0a09 || (isdefined(baseweapon.var_76ce72e8) && baseweapon.var_76ce72e8)))
			{
				scoreevents::processscoreevent(scoreevents.var_2eaed769, effect.var_4b22e697, victim, effect.var_3d1ed4bd);
			}
			else if(isdefined(scoreevents.var_170b3630))
			{
				scoreevents::processscoreevent(scoreevents.var_170b3630, effect.var_4b22e697, victim, effect.var_3d1ed4bd);
			}
		}
		if(attacker == effect.var_4b22e697)
		{
			if(isdefined(level.var_f19c99e1) && isdefined(level.var_f19c99e1[effect.name]) && isdefined(level.var_f19c99e1[effect.name].var_6d794427))
			{
				if(![[level.var_f19c99e1[effect.name].var_6d794427]](self, victim, effect.var_3d1ed4bd, weapon, meansofdeath))
				{
					return;
				}
			}
			function_4d412da8(inflictor, meansofdeath, victim, attacker, scoreevents, effect.var_3d1ed4bd, weapon, effect, time);
		}
	}
}

/*
	Name: function_f7f7b14e
	Namespace: globallogic_score
	Checksum: 0xAE4B415D
	Offset: 0x1DE8
	Size: 0x50C
	Parameters: 1
	Flags: Linked
*/
function function_f7f7b14e(data)
{
	inflictor = data.einflictor;
	victim = data.victim;
	attacker = data.attacker;
	meansofdeath = data.smeansofdeath;
	if(!isplayer(attacker))
	{
		return;
	}
	time = data.time;
	if(!isdefined(time))
	{
		time = gettime();
	}
	weapon = level.weaponnone;
	if(isdefined(data.weapon))
	{
		weapon = data.weapon;
	}
	if(isarray(level.var_b13d1f9b))
	{
		foreach(var_25f92d1d in level.var_b13d1f9b)
		{
			if(isdefined(var_25f92d1d.var_6d794427))
			{
				var_a6f160ea = var_25f92d1d.weapon;
				var_b6f366b = function_3cbc4c6c(var_a6f160ea.var_2e4a8800);
				attacker function_4d412da8(inflictor, meansofdeath, victim, attacker, var_b6f366b, var_a6f160ea, weapon, var_a6f160ea, time);
			}
		}
	}
	attacker thread function_24d66e59(inflictor, meansofdeath, victim, attacker, weapon, data.var_bd10969, time);
	if(isdefined(data.victimweapon))
	{
		var_3d2a11cf = function_3cbc4c6c(data.victimweapon.var_2e4a8800);
		if(data.victimweapon.var_b76e0a09)
		{
			attacker namespace_bd02cf1::function_896ac347(weapon, #"showstopper", 1);
		}
	}
	if(!isdefined(var_3d2a11cf) && isdefined(victim.heroability) && isdefined(victim.heroabilityactivatetime) && victim.heroabilityactivatetime + 700 > time)
	{
		var_3d2a11cf = function_3cbc4c6c(victim.heroability.var_2e4a8800);
		attacker namespace_bd02cf1::function_896ac347(weapon, #"showstopper", 1);
	}
	if(isdefined(weapon) && isdefined(level.iskillstreakweapon))
	{
		if([[level.iskillstreakweapon]](weapon) || (isdefined(weapon.statname) && [[level.iskillstreakweapon]](getweapon(weapon.statname))))
		{
			var_629fbd5c = 1;
		}
	}
	if(isdefined(var_3d2a11cf) && isdefined(var_3d2a11cf.var_3143c814) && (!(isdefined(var_629fbd5c) && var_629fbd5c)) && (isdefined(attacker) && isdefined(victim) && util::function_fbce7263(attacker.team, victim.team)))
	{
		scoreevents::processscoreevent(var_3d2a11cf.var_3143c814, attacker, victim, weapon);
		victim.var_ad1472a2 = 1;
		attacker stats::function_dad108fa(#"stats_shutdowns", 1);
		attacker contracts::function_a54e2068(#"hash_26f8726bc08d080c");
	}
	baseweapon = weapons::getbaseweapon(weapon);
	attacker function_4d412da8(inflictor, meansofdeath, victim, attacker, function_3cbc4c6c(weapon.var_2e4a8800), weapon, weapon, baseweapon, time);
}

/*
	Name: function_d68ae402
	Namespace: globallogic_score
	Checksum: 0xEEDE37DB
	Offset: 0x2300
	Size: 0x8EE
	Parameters: 8
	Flags: Linked, Private
*/
private function function_d68ae402(inflictor, meansofdeath, victim, attacker, scoreevents, weapon, var_f801f37e, time)
{
	level endon(#"game_ended");
	var_ac4c1 = var_f801f37e.name;
	attacker notify(var_ac4c1 + "MultiKillScore");
	attacker endon(var_ac4c1 + "MultiKillScore", #"disconnect");
	if(inflictor.var_a6b00192 >= 3 && !(isdefined(inflictor.var_7fff4605) ? inflictor.var_7fff4605 : 0))
	{
		if(isdefined(scoreevents) && isdefined(scoreevents.var_db750037))
		{
			scoreevents::processscoreevent(scoreevents.var_db750037, attacker, undefined, weapon);
		}
		inflictor.var_7fff4605 = 1;
	}
	if(var_ac4c1 == #"frag_grenade" || var_ac4c1 == #"eq_molotov" || var_ac4c1 == #"hatchet")
	{
		attacker contracts::function_a54e2068(#"hash_3ffc3d28289d21bb");
		if(var_ac4c1 == #"eq_molotov")
		{
			attacker contracts::function_a54e2068(#"hash_7aa4c7b37c66fcc1");
		}
	}
	if(!isdefined(attacker.var_fee0b504) || !isdefined(attacker.var_fee0b504[var_ac4c1]))
	{
		return;
	}
	waitresult = undefined;
	waitresult = attacker waittill_timeout(4, #"death", #"team_changed");
	if(var_ac4c1 == #"frag_grenade" || var_ac4c1 == #"eq_molotov" || var_ac4c1 == #"hatchet")
	{
		if(attacker.var_fee0b504[var_ac4c1].kills >= 2)
		{
			if(!isdefined(attacker.pers[#"hash_52e978325c91fe24"]))
			{
				attacker.pers[#"hash_52e978325c91fe24"] = 0;
			}
			attacker.pers[#"hash_52e978325c91fe24"]++;
			if(attacker.pers[#"hash_52e978325c91fe24"] % 2 == 0)
			{
				attacker stats::function_dad108fa(#"hash_52e978325c91fe24", 1);
			}
		}
	}
	if(var_ac4c1 == #"frag_grenade")
	{
		if(attacker.var_fee0b504[var_ac4c1].kills >= 2)
		{
			attacker contracts::function_a54e2068(#"hash_6696408f54c6ada7");
		}
	}
	if(var_ac4c1 == #"eq_molotov")
	{
		if(attacker.var_fee0b504[var_ac4c1].kills >= 2)
		{
			attacker contracts::function_a54e2068(#"hash_4a7d49c14e026e91");
		}
	}
	if(isdefined(scoreevents))
	{
		switch((isdefined(attacker.var_fee0b504[var_ac4c1].kills) ? attacker.var_fee0b504[var_ac4c1].kills : 0))
		{
			case 0:
			case 1:
			{
				break;
			}
			case 2:
			{
				if(isdefined(scoreevents.var_d58bd0e9))
				{
					scoreevents::processscoreevent(scoreevents.var_d58bd0e9, attacker, victim, weapon);
				}
				break;
			}
			case 3:
			{
				if(isdefined(scoreevents.var_6643c0a0))
				{
					scoreevents::processscoreevent(scoreevents.var_6643c0a0, attacker, victim, weapon);
				}
				break;
			}
			case 4:
			{
				if(isdefined(scoreevents.var_16abf654))
				{
					scoreevents::processscoreevent(scoreevents.var_16abf654, attacker, victim, weapon);
				}
				break;
			}
			case 5:
			{
				if(isdefined(scoreevents.var_1b8b6771))
				{
					scoreevents::processscoreevent(scoreevents.var_1b8b6771, attacker, victim, weapon);
				}
				break;
			}
			default:
			{
				if(attacker.var_fee0b504[var_ac4c1].kills > 5 && isdefined(scoreevents.var_67b4a761))
				{
					scoreevents::processscoreevent(scoreevents.var_67b4a761, attacker, victim, weapon);
				}
				break;
			}
		}
		if((isdefined(attacker.var_fee0b504[var_ac4c1].kills) ? attacker.var_fee0b504[var_ac4c1].kills : 0) >= 2)
		{
			attacker specialistmedalachievement(weapon, scoreevents);
		}
	}
	attacker.var_fee0b504[var_ac4c1].kills = 0;
	switch((isdefined(attacker.var_fee0b504[var_ac4c1].var_3e9f80b2) ? attacker.var_fee0b504[var_ac4c1].var_3e9f80b2 : 0))
	{
		case 0:
		case 1:
		case 2:
		{
			break;
		}
		default:
		{
			if(attacker.var_fee0b504[var_ac4c1].var_3e9f80b2 > 2)
			{
				if(isdefined(scoreevents) && isdefined(scoreevents.var_3655354))
				{
					scoreevents::processscoreevent(scoreevents.var_3655354, attacker, undefined, weapon);
				}
				if((isdefined(attacker.var_fee0b504[var_ac4c1].var_d6089e48) ? attacker.var_fee0b504[var_ac4c1].var_d6089e48 : 0))
				{
					if(isdefined(scoreevents) && isdefined(scoreevents.var_7b590f90))
					{
						scoreevents::processscoreevent(scoreevents.var_7b590f90, attacker, undefined, weapon);
						attacker.var_fee0b504[var_ac4c1].var_d6089e48 = 0;
					}
					if(isarray(level.var_b13d1f9b))
					{
						foreach(var_25f92d1d in level.var_b13d1f9b)
						{
							if(isdefined(var_25f92d1d.var_34f2424e))
							{
								[[var_25f92d1d.var_34f2424e]](attacker, time, weapon, var_25f92d1d.weapon);
							}
						}
					}
				}
			}
			break;
		}
	}
	attacker.var_fee0b504[var_ac4c1].var_3e9f80b2 = 0;
}

/*
	Name: function_4d412da8
	Namespace: globallogic_score
	Checksum: 0x952CCFA9
	Offset: 0x2BF8
	Size: 0x554
	Parameters: 9
	Flags: Linked, Private
*/
private function function_4d412da8(inflictor, meansofdeath, victim, attacker, scoreevents, weapon, attackerweapon, var_f801f37e, time)
{
	self function_662aaa65(var_f801f37e);
	if(!isdefined(inflictor))
	{
		inflictor = attacker;
	}
	if(isdefined(level.var_b13d1f9b) && isdefined(level.var_b13d1f9b[var_f801f37e.name]) && isdefined(level.var_b13d1f9b[var_f801f37e.name].var_6d794427))
	{
		if(![[level.var_b13d1f9b[var_f801f37e.name].var_6d794427]](self, victim, weapon, attackerweapon, meansofdeath))
		{
			return;
		}
	}
	if(isarray(level.var_b13d1f9b))
	{
		foreach(var_25f92d1d in level.var_b13d1f9b)
		{
			if(isdefined(var_25f92d1d.var_90e3cfd7))
			{
				[[var_25f92d1d.var_90e3cfd7]](attacker, time, weapon, var_25f92d1d.weapon, (isdefined(victim.var_60a9eae7) ? victim.var_60a9eae7 : 0));
			}
		}
	}
	if(isdefined(scoreevents) && isdefined(scoreevents.var_2ecceeab) && (!(isdefined(victim.var_60a9eae7) ? victim.var_60a9eae7 : 0) || !isdefined(scoreevents.var_8600aca4)))
	{
		scoreevents::processscoreevent(scoreevents.var_2ecceeab, attacker, victim, weapon);
	}
	attacker function_8279d8bf(weapon, scoreevents);
	if(isdefined(scoreevents) && isdefined(scoreevents.var_2892e164) || (isdefined(level.var_b13d1f9b) && isdefined(level.var_b13d1f9b[var_f801f37e.name]) && isdefined(level.var_b13d1f9b[var_f801f37e.name].var_ec2a6a4c)))
	{
		if(level.teambased && isdefined(victim) && isdefined(victim.damagedplayers))
		{
			foreach(var_96590ffe in victim.damagedplayers)
			{
				if(!isdefined(var_96590ffe.entity) || var_96590ffe.entity == attacker || attacker util::isenemyplayer(var_96590ffe.entity) || !isdefined(var_96590ffe.time))
				{
					continue;
				}
				if(time - var_96590ffe.time < 1000)
				{
					if(isdefined(level.var_b13d1f9b) && isdefined(level.var_b13d1f9b[var_f801f37e.name]) && isdefined(level.var_b13d1f9b[var_f801f37e.name].var_ec2a6a4c))
					{
						[[level.var_b13d1f9b[var_f801f37e.name].var_ec2a6a4c]](attacker, victim, var_96590ffe.entity, time, weapon, level.var_b13d1f9b[var_f801f37e.name].weapon);
					}
					if(isdefined(scoreevents) && isdefined(scoreevents.var_2892e164))
					{
						scoreevents::processscoreevent(scoreevents.var_2892e164, attacker, victim, weapon);
					}
				}
			}
		}
	}
	self.var_fee0b504[var_f801f37e.name].kills++;
	if(!isdefined(inflictor.var_a6b00192))
	{
		inflictor.var_a6b00192 = 0;
	}
	inflictor.var_a6b00192++;
	self thread function_d68ae402(inflictor, meansofdeath, victim, self, scoreevents, weapon, var_f801f37e, time);
}

/*
	Name: specialistmedalachievement
	Namespace: globallogic_score
	Checksum: 0x107E5DBF
	Offset: 0x3158
	Size: 0x4C4
	Parameters: 2
	Flags: Linked
*/
function specialistmedalachievement(weapon, scoreevents)
{
	if(!sessionmodeismultiplayergame() || !level.rankedmatch || level.disablestattracking || !isdefined(self) || !isplayer(self) || !isdefined(weapon))
	{
		return;
	}
	if(!isdefined(scoreevents))
	{
		scoreevents = function_3cbc4c6c(weapon.var_2e4a8800);
	}
	var_e716a62e = 0;
	baseweapon = weapons::getbaseweapon(weapon);
	if(isdefined(baseweapon.var_b76e0a09) && baseweapon.var_b76e0a09)
	{
		var_e716a62e = var_e716a62e + self stats::function_441050ca(#"hash_47a0714ddfa70685");
		var_e716a62e = var_e716a62e + self stats::function_441050ca(#"hash_3bd234a71d5f33b3");
		var_e716a62e = var_e716a62e + self stats::function_441050ca(#"hash_6181b5265fc5ed4e");
		var_e716a62e = var_e716a62e + self stats::function_441050ca(#"hash_12e6927a1f181c0d");
		var_e716a62e = var_e716a62e + self stats::function_441050ca(#"hash_8e1be3c09f208ce");
		var_e716a62e = var_e716a62e + self stats::function_441050ca(#"hash_a299f1dbd0c1c7d");
		var_e716a62e = var_e716a62e + self stats::function_441050ca(#"hash_525cf08fc8f2cf0f");
		var_e716a62e = var_e716a62e + self stats::function_441050ca(#"hash_5192cd4110abad38");
		var_e716a62e = var_e716a62e + self stats::function_441050ca(#"hash_305bd298951fd742");
		var_e716a62e = var_e716a62e + self stats::function_441050ca(#"hash_4b2ec734803df298");
		if(var_e716a62e >= 10)
		{
			self giveachievement("mp_trophy_special_issue_weaponry");
		}
	}
	else if(isdefined(baseweapon.var_76ce72e8) && baseweapon.var_76ce72e8 && isdefined(scoreevents) && (isdefined(scoreevents.var_fcd2ff3a) && scoreevents.var_fcd2ff3a))
	{
		var_e716a62e = var_e716a62e + self stats::function_441050ca(#"hash_214868c5de7bd62b");
		var_e716a62e = var_e716a62e + self stats::function_441050ca(#"hash_caa3df31fb4d23c");
		var_e716a62e = var_e716a62e + self stats::function_441050ca(#"hash_3427f2d4181d570");
		var_e716a62e = var_e716a62e + self stats::function_441050ca(#"hash_66425548f6b4d833");
		var_e716a62e = var_e716a62e + self stats::function_441050ca(#"hash_23697882250026c");
		var_e716a62e = var_e716a62e + self stats::function_441050ca(#"hash_3c34e77a82133b37");
		var_e716a62e = var_e716a62e + self stats::function_441050ca(#"hash_6b180a955b001f91");
		var_e716a62e = var_e716a62e + self stats::function_441050ca(#"hash_79dced8b891e63e5");
		var_e716a62e = var_e716a62e + self stats::function_441050ca(#"hash_13133901e76182d");
		var_e716a62e = var_e716a62e + self stats::function_441050ca(#"hash_7476fe46c6724393");
		if(var_e716a62e >= 10)
		{
			self giveachievement("mp_trophy_special_issue_equipment");
		}
	}
}

/*
	Name: function_8279d8bf
	Namespace: globallogic_score
	Checksum: 0x869704A9
	Offset: 0x3628
	Size: 0x134
	Parameters: 2
	Flags: Linked
*/
function function_8279d8bf(weapon, scoreevents)
{
	if(function_f99d2668())
	{
		return;
	}
	equipment = self loadout::function_18a77b37("primarygrenade");
	ability = self loadout::function_18a77b37("specialgrenade");
	baseweapon = weapons::getbaseweapon(weapon);
	if(isdefined(ability) && baseweapon.var_b76e0a09 === 1)
	{
		self function_be7a08a8(ability, 1);
	}
	else if(isdefined(equipment) && isdefined(scoreevents) && baseweapon.var_76ce72e8 === 1 && scoreevents.var_fcd2ff3a === 1)
	{
		self function_be7a08a8(equipment, 1);
	}
}

/*
	Name: function_662aaa65
	Namespace: globallogic_score
	Checksum: 0x25D71AF4
	Offset: 0x3768
	Size: 0x9A
	Parameters: 1
	Flags: Linked
*/
function function_662aaa65(var_f801f37e)
{
	if(!isdefined(self.var_fee0b504))
	{
		self.var_fee0b504 = [];
	}
	if(isdefined(var_f801f37e) && !isdefined(self.var_fee0b504[var_f801f37e.name]))
	{
		struct = spawnstruct();
		struct.kills = 0;
		struct.var_3e9f80b2 = 0;
		self.var_fee0b504[var_f801f37e.name] = struct;
	}
}

/*
	Name: function_1f9441d7
	Namespace: globallogic_score
	Checksum: 0x590FF112
	Offset: 0x3810
	Size: 0xBA
	Parameters: 1
	Flags: Linked
*/
function function_1f9441d7(weapon)
{
	if(!isdefined(level.var_b13d1f9b))
	{
		level.var_b13d1f9b = [];
	}
	if(!isdefined(level.var_b13d1f9b[weapon.name]))
	{
		level.var_b13d1f9b[weapon.name] = spawnstruct();
	}
	if(!isdefined(level.var_b13d1f9b[weapon.name].weapon))
	{
		level.var_b13d1f9b[weapon.name].weapon = weapon;
	}
}

/*
	Name: function_5a241bd8
	Namespace: globallogic_score
	Checksum: 0xC52DFD3F
	Offset: 0x38D8
	Size: 0x4E
	Parameters: 2
	Flags: None
*/
function function_5a241bd8(weapon, callback)
{
	function_1f9441d7(weapon);
	level.var_b13d1f9b[weapon.name].var_6d794427 = callback;
}

/*
	Name: function_a458dbe1
	Namespace: globallogic_score
	Checksum: 0x2901CC3E
	Offset: 0x3930
	Size: 0x8A
	Parameters: 2
	Flags: None
*/
function function_a458dbe1(var_b03e560d, callback)
{
	if(!isdefined(level.var_f19c99e1))
	{
		level.var_f19c99e1 = [];
	}
	if(!isdefined(level.var_f19c99e1[var_b03e560d]))
	{
		level.var_f19c99e1[var_b03e560d] = spawnstruct();
	}
	level.var_f19c99e1[var_b03e560d].var_6d794427 = callback;
}

/*
	Name: function_86f90713
	Namespace: globallogic_score
	Checksum: 0x6397F7C
	Offset: 0x39C8
	Size: 0x4E
	Parameters: 2
	Flags: None
*/
function function_86f90713(weapon, callback)
{
	function_1f9441d7(weapon);
	level.var_b13d1f9b[weapon.name].var_37850de1 = callback;
}

/*
	Name: function_82fb1afa
	Namespace: globallogic_score
	Checksum: 0x728E9CB6
	Offset: 0x3A20
	Size: 0x4E
	Parameters: 2
	Flags: None
*/
function function_82fb1afa(weapon, callback)
{
	function_1f9441d7(weapon);
	level.var_b13d1f9b[weapon.name].var_d20c7012 = callback;
}

/*
	Name: function_2b2c09db
	Namespace: globallogic_score
	Checksum: 0xD38A4A6
	Offset: 0x3A78
	Size: 0x4E
	Parameters: 2
	Flags: None
*/
function function_2b2c09db(weapon, callback)
{
	function_1f9441d7(weapon);
	level.var_b13d1f9b[weapon.name].var_ec2a6a4c = callback;
}

/*
	Name: function_5b0c227a
	Namespace: globallogic_score
	Checksum: 0xFE4BC543
	Offset: 0x3AD0
	Size: 0x4E
	Parameters: 2
	Flags: None
*/
function function_5b0c227a(weapon, callback)
{
	function_1f9441d7(weapon);
	level.var_b13d1f9b[weapon.name].var_34f2424e = callback;
}

/*
	Name: function_b150f9ac
	Namespace: globallogic_score
	Checksum: 0x6BB540F2
	Offset: 0x3B28
	Size: 0x4E
	Parameters: 2
	Flags: None
*/
function function_b150f9ac(weapon, callback)
{
	function_1f9441d7(weapon);
	level.var_b13d1f9b[weapon.name].var_826b85e7 = callback;
}

/*
	Name: function_c1e9b86b
	Namespace: globallogic_score
	Checksum: 0xFDB1DE9F
	Offset: 0x3B80
	Size: 0x4E
	Parameters: 2
	Flags: None
*/
function function_c1e9b86b(weapon, callback)
{
	function_1f9441d7(weapon);
	level.var_b13d1f9b[weapon.name].var_90e3cfd7 = callback;
}

/*
	Name: function_d3ca3608
	Namespace: globallogic_score
	Checksum: 0x121E5649
	Offset: 0x3BD8
	Size: 0x19E
	Parameters: 1
	Flags: Linked
*/
function function_d3ca3608(eventname)
{
	/#
		assert(isdefined(eventname));
	#/
	if(!isdefined(level.scoreinfo[eventname]) || !isdefined(self) || !isplayer(self))
	{
		return;
	}
	/#
		if(getdvarint(#"hash_39060c853726e6c0", 0) > 0)
		{
			if(!isdefined(level.var_10cd7193))
			{
				level.var_10cd7193 = [];
			}
			eventstr = (function_7a600918(eventname) ? function_9e72a96(eventname) : eventname);
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
	eventindex = level.scoreinfo[eventname][#"row"];
}

/*
	Name: function_61254438
	Namespace: globallogic_score
	Checksum: 0xA57A1642
	Offset: 0x3D80
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_61254438(weapon)
{
	var_8725a10d = function_3cbc4c6c(weapon.var_2e4a8800);
	if(!isdefined(var_8725a10d) || !isdefined(var_8725a10d.var_14d1d5a1))
	{
		return;
	}
	self function_d3ca3608(var_8725a10d.var_14d1d5a1);
}

/*
	Name: function_4842d1f6
	Namespace: globallogic_score
	Checksum: 0x60DCF20A
	Offset: 0x3DF8
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_4842d1f6(var_8d498080)
{
	var_8725a10d = function_3cbc4c6c(var_8d498080.var_2e4a8800);
	if(!isdefined(var_8725a10d) || !isdefined(var_8725a10d.var_14d1d5a1))
	{
		return;
	}
	self function_d3ca3608(var_8725a10d.var_14d1d5a1);
}

/*
	Name: function_bb9f3842
	Namespace: globallogic_score
	Checksum: 0x114ADE56
	Offset: 0x3E70
	Size: 0x226
	Parameters: 0
	Flags: None
*/
function function_bb9f3842()
{
	/#
		level endon(#"game_ended");
		if(!isdefined(level.var_10cd7193))
		{
			level.var_10cd7193 = [];
		}
		while(true)
		{
			if(getdvarint(#"hash_35960c7344552dce", 0) > 0)
			{
				var_594354f3 = [];
				foreach(scoreevent in level.var_10cd7193)
				{
					if(!isdefined(var_594354f3[scoreevent]))
					{
						var_594354f3[scoreevent] = 0;
					}
					var_594354f3[scoreevent]++;
				}
				println("");
				foreach(var_d975dd49 in getarraykeys(var_594354f3))
				{
					count = var_594354f3[var_d975dd49];
					println(var_d975dd49 + "" + (isdefined(count) ? "" + count : ""));
				}
				println("");
				setdvar(#"hash_35960c7344552dce", 0);
			}
			waitframe(1);
		}
	#/
}

