// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_47fb62300ac0bd60;
#using script_545a0bac37bda541;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\sound_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace smokegrenade;

/*
	Name: init_shared
	Namespace: smokegrenade
	Checksum: 0x9D8FCA62
	Offset: 0x150
	Size: 0x14C
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	level.willypetedamageradius = 300;
	level.willypetedamageheight = 128;
	level.smokegrenadeduration = 8;
	level.smokegrenadedissipation = 4;
	level.smokegrenadetotaltime = level.smokegrenadeduration + level.smokegrenadedissipation;
	level.fx_smokegrenade_single = "smoke_center";
	level.smoke_grenade_triggers = [];
	clientfield::register("allplayers", "inenemysmoke", 14000, 1, "int");
	clientfield::register("allplayers", "insmoke", 16000, 2, "int");
	clientfield::register("scriptmover", "smoke_state", 16000, 1, "int");
	globallogic_score::function_5a241bd8(getweapon(#"eq_smoke"), &function_b4a975f1);
}

/*
	Name: function_79d42bea
	Namespace: smokegrenade
	Checksum: 0xD37CD3C3
	Offset: 0x2A8
	Size: 0x6A
	Parameters: 1
	Flags: None
*/
function function_79d42bea(weapon)
{
	if(!isdefined(weapon.var_4dd46f8a))
	{
		return 128;
	}
	var_b0b958b3 = getscriptbundle(weapon.var_4dd46f8a);
	return (isdefined(var_b0b958b3.var_40dfefd1) ? var_b0b958b3.var_40dfefd1 : 128);
}

/*
	Name: function_f199623f
	Namespace: smokegrenade
	Checksum: 0x33A14033
	Offset: 0x320
	Size: 0x76
	Parameters: 1
	Flags: None
*/
function function_f199623f(weapon)
{
	if(!isdefined(weapon.var_4dd46f8a))
	{
		return level.smokegrenadeduration;
	}
	var_b0b958b3 = getscriptbundle(weapon.var_4dd46f8a);
	return (isdefined(var_b0b958b3.smokegrenadeduration) ? var_b0b958b3.smokegrenadeduration : level.smokegrenadeduration);
}

/*
	Name: function_184e15d2
	Namespace: smokegrenade
	Checksum: 0xC04CCE68
	Offset: 0x3A0
	Size: 0x76
	Parameters: 1
	Flags: None
*/
function function_184e15d2(weapon)
{
	if(!isdefined(weapon.var_4dd46f8a))
	{
		return level.smokegrenadedissipation;
	}
	var_b0b958b3 = getscriptbundle(weapon.var_4dd46f8a);
	return (isdefined(var_b0b958b3.smokegrenadedissipation) ? var_b0b958b3.smokegrenadedissipation : level.smokegrenadedissipation);
}

/*
	Name: watchsmokegrenadedetonation
	Namespace: smokegrenade
	Checksum: 0x272F4405
	Offset: 0x420
	Size: 0x184
	Parameters: 5
	Flags: None
*/
function watchsmokegrenadedetonation(owner, statweapon, smokeweapon, duration, totaltime)
{
	self endon(#"trophy_destroyed");
	if(isplayer(owner))
	{
		owner stats::function_e24eec31(statweapon, #"used", 1);
	}
	waitresult = undefined;
	waitresult = self waittill(#"explode", #"death");
	if(waitresult._notify != "explode")
	{
		return;
	}
	onefoot = vectorscale((0, 0, 1), 12);
	startpos = waitresult.position + onefoot;
	smokedetonate(owner, statweapon, smokeweapon, waitresult.position, function_79d42bea(smokeweapon), totaltime, duration);
	damageeffectarea(owner, startpos, smokeweapon.explosionradius, level.willypetedamageheight);
}

/*
	Name: smokedetonate
	Namespace: smokegrenade
	Checksum: 0x67111E45
	Offset: 0x5B0
	Size: 0x190
	Parameters: 7
	Flags: None
*/
function smokedetonate(owner, statweapon, smokeweapon, position, radius, effectlifetime, smokeblockduration)
{
	dir_up = (0, 0, 1);
	if(!isdefined(effectlifetime))
	{
		effectlifetime = 10;
	}
	ent = spawntimedfx(smokeweapon, position, dir_up, int(effectlifetime));
	if(isdefined(owner))
	{
		ent setteam(owner.team);
		if(isplayer(owner))
		{
			ent setowner(owner);
		}
	}
	ent thread smokeblocksight(smokeweapon, radius);
	ent thread spawnsmokegrenadetrigger(smokeweapon, smokeblockduration, owner);
	if(isdefined(owner))
	{
		owner.smokegrenadetime = gettime();
		owner.smokegrenadeposition = position;
	}
	thread playsmokesound(position, smokeblockduration, statweapon.projsmokestartsound, statweapon.projsmokeendsound, statweapon.projsmokeloopsound);
	return ent;
}

/*
	Name: damageeffectarea
	Namespace: smokegrenade
	Checksum: 0x4DE25BF
	Offset: 0x748
	Size: 0x94
	Parameters: 4
	Flags: None
*/
function damageeffectarea(owner, position, radius, height)
{
	effectarea = spawn("trigger_radius", position, 0, radius, height);
	if(isdefined(level.dogsonflashdogs))
	{
		owner thread [[level.dogsonflashdogs]](effectarea);
	}
	effectarea delete();
}

/*
	Name: smokeblocksight
	Namespace: smokegrenade
	Checksum: 0x2B249640
	Offset: 0x7E8
	Size: 0xD0
	Parameters: 2
	Flags: None
*/
function smokeblocksight(smokeweapon, radius)
{
	self endon(#"death");
	smokeradius = function_79d42bea(smokeweapon);
	while(true)
	{
		fxblocksight(self, radius);
		/#
			if(getdvarint(#"scr_smokegrenade_debug", 0))
			{
				sphere(self.origin, smokeradius, (1, 0, 0), 0.25, 0, 10, 15);
			}
		#/
		wait(0.75);
	}
}

/*
	Name: waitanddelete
	Namespace: smokegrenade
	Checksum: 0x4E105811
	Offset: 0x8C0
	Size: 0x54
	Parameters: 1
	Flags: None
*/
function waitanddelete(time)
{
	self ghost();
	self endon(#"death");
	wait(time);
	self delete();
}

/*
	Name: spawnsmokegrenadetrigger
	Namespace: smokegrenade
	Checksum: 0x8F7B3FA1
	Offset: 0x920
	Size: 0x25C
	Parameters: 3
	Flags: None
*/
function spawnsmokegrenadetrigger(smokeweapon, duration, owner)
{
	team = self.team;
	radius = function_79d42bea(smokeweapon);
	trigger = spawn("trigger_radius", self.origin, 0, radius, radius);
	trigger.owner = owner;
	self.var_b999539c = trigger;
	anchor = spawn("script_model", self.origin);
	if(isdefined(owner))
	{
		anchor setowner(owner);
		anchor setteam(owner.team);
	}
	anchor setmodel(#"tag_origin");
	self.anchor = anchor;
	if(!isdefined(level.smoke_grenade_triggers))
	{
		level.smoke_grenade_triggers = [];
	}
	else if(!isarray(level.smoke_grenade_triggers))
	{
		level.smoke_grenade_triggers = array(level.smoke_grenade_triggers);
	}
	level.smoke_grenade_triggers[level.smoke_grenade_triggers.size] = trigger;
	if(function_579815a1(smokeweapon))
	{
		thread function_8b6ddd71(self, smokeweapon);
	}
	self waittill_timeout(duration, #"death");
	arrayremovevalue(level.smoke_grenade_triggers, trigger);
	if(isdefined(anchor))
	{
		anchor thread waitanddelete(1);
		self.anchor = undefined;
	}
	if(isdefined(trigger))
	{
		trigger delete();
	}
}

/*
	Name: function_b4a975f1
	Namespace: smokegrenade
	Checksum: 0xED7C9A13
	Offset: 0xB88
	Size: 0x276
	Parameters: 5
	Flags: None
*/
function function_b4a975f1(attacker, victim, weapon, attackerweapon, meansofdeath)
{
	if(!isdefined(attacker) || !isdefined(victim))
	{
		return 0;
	}
	var_b999539c = victim function_367ce00e();
	if(isdefined(var_b999539c))
	{
		if(attacker === var_b999539c.owner)
		{
			if(isdefined(attackerweapon) && attackerweapon !== level.var_8e2aec59)
			{
				if(isdefined(level.playgadgetsuccess) && !isdefined(var_b999539c.var_25db02aa))
				{
					var_b999539c.kills = (isdefined(var_b999539c.kills) ? var_b999539c.kills : 0) + 1;
					if(isdefined(level.var_ac6052e9))
					{
						var_9194a036 = [[level.var_ac6052e9]]("muteSmokeSuccessLineCount", 0);
					}
					if(var_b999539c.kills == (isdefined(var_9194a036) ? var_9194a036 : 3))
					{
						attacker [[level.playgadgetsuccess]](getweapon(#"eq_smoke"), undefined, victim, undefined);
						var_b999539c.var_25db02aa = 1;
					}
				}
			}
			return 1;
		}
		if(isdefined(var_b999539c.owner) && isplayer(var_b999539c.owner) && isalive(var_b999539c.owner) && util::function_fbce7263(var_b999539c.owner.team, victim.team))
		{
			if(level.teambased)
			{
				scoreevents::processscoreevent(#"hash_2ffa19a7dfef2ea0", var_b999539c.owner, undefined, getweapon(#"eq_smoke"));
			}
		}
	}
	return 0;
}

/*
	Name: function_367ce00e
	Namespace: smokegrenade
	Checksum: 0xDCEF04D
	Offset: 0xE08
	Size: 0xB2
	Parameters: 1
	Flags: None
*/
function function_367ce00e(var_7acab93a)
{
	foreach(trigger in level.smoke_grenade_triggers)
	{
		if(self istouching(trigger))
		{
			if(isdefined(var_7acab93a))
			{
				if(var_7acab93a != trigger)
				{
					return trigger;
				}
				continue;
			}
			return trigger;
		}
	}
	return undefined;
}

/*
	Name: function_4cc4db89
	Namespace: smokegrenade
	Checksum: 0x7F7C9146
	Offset: 0xEC8
	Size: 0xD4
	Parameters: 2
	Flags: None
*/
function function_4cc4db89(team, var_7acab93a)
{
	foreach(trigger in level.smoke_grenade_triggers)
	{
		if(!trigger util::isenemyteam(team) && self istouching(trigger))
		{
			if(isdefined(var_7acab93a))
			{
				if(var_7acab93a != trigger)
				{
					return trigger;
				}
				continue;
			}
			return trigger;
		}
	}
	return undefined;
}

/*
	Name: function_50ef4b12
	Namespace: smokegrenade
	Checksum: 0x2A62A6C1
	Offset: 0xFA8
	Size: 0x124
	Parameters: 1
	Flags: None
*/
function function_50ef4b12(weapon)
{
	if(getweapon(#"eq_smoke") == weapon.rootweapon)
	{
		return 1;
	}
	if(getweapon(#"willy_pete") == weapon.rootweapon)
	{
		return 1;
	}
	if(getweapon(#"hash_615e6c73989c85b4") == weapon.rootweapon)
	{
		return 1;
	}
	if(getweapon(#"hash_7a88daffaea7a9cf") == weapon.rootweapon)
	{
		return 1;
	}
	if(getweapon(#"hash_531d2030796963b2") == weapon.rootweapon)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_579815a1
	Namespace: smokegrenade
	Checksum: 0x50F72A9C
	Offset: 0x10D8
	Size: 0x80
	Parameters: 1
	Flags: Private
*/
private function function_579815a1(weapon)
{
	if(!isdefined(weapon.var_4dd46f8a))
	{
		return 0;
	}
	var_e6fbac16 = getscriptbundle(weapon.var_4dd46f8a);
	if(var_e6fbac16.var_8ceb6ac8 === 1)
	{
		return 1;
	}
	if(var_e6fbac16.var_6942aad6 === 1)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_87d0a127
	Namespace: smokegrenade
	Checksum: 0xD19793C6
	Offset: 0x1160
	Size: 0x17E
	Parameters: 2
	Flags: None
*/
function function_87d0a127(grenadeent, smokeweapon)
{
	if(!isdefined(grenadeent.var_b999539c))
	{
		return;
	}
	var_ce7665b1 = grenadeent.team;
	owner = grenadeent.var_b999539c.owner;
	while(true)
	{
		waitresult = undefined;
		waitresult = grenadeent waittill_timeout(0.25, #"death");
		if(isdefined(owner))
		{
			if(isdefined(grenadeent) && isdefined(grenadeent.var_b999539c) && owner istouching(grenadeent.var_b999539c) && waitresult._notify == #"timeout")
			{
				owner clientfield::set("inenemysmoke", 1);
			}
			else
			{
				owner clientfield::set("inenemysmoke", 0);
			}
		}
		if(!isdefined(owner) || !isdefined(grenadeent) || waitresult._notify != "timeout")
		{
			break;
		}
	}
}

/*
	Name: function_8b6ddd71
	Namespace: smokegrenade
	Checksum: 0xB5509D2B
	Offset: 0x12E8
	Size: 0x2F4
	Parameters: 2
	Flags: None
*/
function function_8b6ddd71(grenadeent, smokeweapon)
{
	if(!isdefined(grenadeent.var_b999539c))
	{
		return;
	}
	var_ce7665b1 = grenadeent.team;
	while(true)
	{
		waitresult = undefined;
		waitresult = grenadeent waittill_timeout(0.25, #"death");
		foreach(player in level.players)
		{
			curval = player clientfield::get("insmoke");
			if(isdefined(grenadeent) && isdefined(grenadeent.var_b999539c) && player istouching(grenadeent.var_b999539c) && waitresult._notify == #"timeout")
			{
				if(player util::isenemyteam(var_ce7665b1))
				{
					player clientfield::set("insmoke", curval | 1);
				}
				else
				{
					player clientfield::set("insmoke", curval | 2);
				}
				continue;
			}
			if(player util::isenemyteam(var_ce7665b1))
			{
				mask = 1;
			}
			else
			{
				mask = 2;
			}
			if(curval & mask)
			{
				trig = undefined;
				if(isdefined(grenadeent))
				{
					trig = function_4cc4db89(var_ce7665b1, grenadeent.var_b999539c);
				}
				if(!isdefined(trig))
				{
					player clientfield::set("insmoke", curval & (~mask));
				}
			}
		}
		if(!isdefined(grenadeent) || waitresult._notify != "timeout" || (!isdefined(grenadeent.var_b999539c) && grenadeent.item === getweapon(#"hash_531d2030796963b2")))
		{
			break;
		}
	}
}

/*
	Name: function_debb0d4e
	Namespace: smokegrenade
	Checksum: 0x342C8650
	Offset: 0x15E8
	Size: 0x1AC
	Parameters: 1
	Flags: Event
*/
event function_debb0d4e(eventstruct)
{
	weapon = eventstruct.weapon;
	if(!function_50ef4b12(weapon))
	{
		return;
	}
	if(weapon.rootweapon == getweapon(#"eq_smoke"))
	{
		weapon_smoke = getweapon(#"eq_smoke");
	}
	else if(weapon.rootweapon == getweapon(#"hash_531d2030796963b2"))
	{
		weapon_smoke = getweapon(#"hash_531d2030796963b2");
	}
	else
	{
		weapon_smoke = getweapon(#"willy_pete");
	}
	duration = function_f199623f(weapon_smoke);
	totaltime = duration + function_184e15d2(weapon_smoke);
	grenade = eventstruct.projectile;
	if(grenade util::ishacked())
	{
		return;
	}
	grenade thread watchsmokegrenadedetonation(self, weapon_smoke, weapon_smoke, duration, totaltime);
}

/*
	Name: playsmokesound
	Namespace: smokegrenade
	Checksum: 0x6491D4BF
	Offset: 0x17A0
	Size: 0x144
	Parameters: 5
	Flags: None
*/
function playsmokesound(position, duration, startsound, stopsound, loopsound)
{
	smokesound = spawn("script_origin", (0, 0, 1));
	if(isdefined(smokesound))
	{
		smokesound endon(#"death");
		smokesound.origin = position;
		if(isdefined(startsound))
		{
			smokesound playsound(startsound);
		}
		if(isdefined(loopsound))
		{
			smokesound playloopsound(loopsound);
		}
		if(duration > 0.5)
		{
			wait(duration - 0.5);
		}
		if(isdefined(stopsound))
		{
			thread sound::play_in_space(stopsound, position);
		}
		smokesound stoploopsound(0.5);
		wait(0.5);
		smokesound delete();
	}
}

