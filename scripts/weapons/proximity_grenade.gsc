// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.gsc;
#using scripts\weapons\weaponobjects.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\player\player_stats.gsc;
#using scripts\core_common\damage.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\values_shared.gsc;

#namespace proximity_grenade;

/*
	Name: init_shared
	Namespace: proximity_grenade
	Checksum: 0xABE22366
	Offset: 0x180
	Size: 0x43C
	Parameters: 0
	Flags: Linked
*/
function init_shared()
{
	level._effect[#"prox_grenade_friendly_default"] = #"weapon/fx_prox_grenade_scan_blue";
	level._effect[#"prox_grenade_friendly_warning"] = #"weapon/fx_prox_grenade_wrn_grn";
	level._effect[#"prox_grenade_enemy_default"] = #"weapon/fx_prox_grenade_scan_orng";
	level._effect[#"prox_grenade_enemy_warning"] = #"weapon/fx_prox_grenade_wrn_red";
	level._effect[#"prox_grenade_player_shock"] = #"weapon/fx_prox_grenade_impact_player_spwner";
	level._effect[#"prox_grenade_chain_bolt"] = #"weapon/fx_prox_grenade_elec_jump";
	level.proximitygrenadedetectionradius = getdvarint(#"scr_proximitygrenadedetectionradius", 180);
	level.proximitygrenadeduration = getdvarfloat(#"scr_proximitygrenadeduration", 1.2);
	level.proximitygrenadegraceperiod = getdvarfloat(#"scr_proximitygrenadegraceperiod", 0.05);
	level.proximitygrenadedotdamageamount = getdvarint(#"scr_proximitygrenadedotdamageamount", 1);
	level.proximitygrenadedotdamageamounthardcore = getdvarint(#"scr_proximitygrenadedotdamageamounthardcore", 1);
	level.proximitygrenadedotdamagetime = getdvarfloat(#"scr_proximitygrenadedotdamagetime", 0.2);
	level.proximitygrenadedotdamageinstances = getdvarint(#"scr_proximitygrenadedotdamageinstances", 4);
	level.proximitygrenadeactivationtime = getdvarfloat(#"scr_proximitygrenadeactivationtime", 0.1);
	level.proximitychaindebug = getdvarint(#"scr_proximitychaindebug", 0);
	level.proximitychaingraceperiod = getdvarint(#"scr_proximitychaingraceperiod", 2500);
	level.proximitychainboltspeed = getdvarfloat(#"scr_proximitychainboltspeed", 400);
	level.proximitygrenadeprotectedtime = getdvarfloat(#"scr_proximitygrenadeprotectedtime", 0.45);
	level.poisonfxduration = 6;
	level thread register();
	callback::add_weapon_damage(getweapon(#"proximity_grenade"), &on_damage);
	weaponobjects::function_e6400478(#"proximity_grenade", &createproximitygrenadewatcher, 0);
	weaponobjects::function_e6400478(#"gadget_sticky_proximity", &creategadgetproximitygrenadewatcher, 0);
	/#
		level thread updatedvars();
	#/
}

/*
	Name: updatedvars
	Namespace: proximity_grenade
	Checksum: 0xE95AFFC6
	Offset: 0x5C8
	Size: 0x2B4
	Parameters: 0
	Flags: None
*/
function updatedvars()
{
	/#
		while(true)
		{
			level.proximitygrenadedetectionradius = getdvarint(#"scr_proximitygrenadedetectionradius", level.proximitygrenadedetectionradius);
			level.proximitygrenadeduration = getdvarfloat(#"scr_proximitygrenadeduration", 1.5);
			level.proximitygrenadegraceperiod = getdvarfloat(#"scr_proximitygrenadegraceperiod", level.proximitygrenadegraceperiod);
			level.proximitygrenadedotdamageamount = getdvarint(#"scr_proximitygrenadedotdamageamount", level.proximitygrenadedotdamageamount);
			level.proximitygrenadedotdamageamounthardcore = getdvarint(#"scr_proximitygrenadedotdamageamounthardcore", level.proximitygrenadedotdamageamounthardcore);
			level.proximitygrenadedotdamagetime = getdvarfloat(#"scr_proximitygrenadedotdamagetime", level.proximitygrenadedotdamagetime);
			level.proximitygrenadedotdamageinstances = getdvarint(#"scr_proximitygrenadedotdamageinstances", level.proximitygrenadedotdamageinstances);
			level.proximitygrenadeactivationtime = getdvarfloat(#"scr_proximitygrenadeactivationtime", level.proximitygrenadeactivationtime);
			level.proximitychaindebug = getdvarint(#"scr_proximitychaindebug", level.proximitychaindebug);
			level.proximitychaingraceperiod = getdvarint(#"scr_proximitychaingraceperiod", level.proximitychaingraceperiod);
			level.proximitychainboltspeed = getdvarfloat(#"scr_proximitychainboltspeed", level.proximitychainboltspeed);
			level.proximitygrenadeprotectedtime = getdvarfloat(#"scr_proximitygrenadeprotectedtime", level.proximitygrenadeprotectedtime);
			wait(1);
		}
	#/
}

/*
	Name: register
	Namespace: proximity_grenade
	Checksum: 0xBE4142B9
	Offset: 0x888
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function register()
{
	clientfield::register("toplayer", "tazered", 1, 1, "int");
}

/*
	Name: createproximitygrenadewatcher
	Namespace: proximity_grenade
	Checksum: 0x56B13921
	Offset: 0x8C8
	Size: 0x15E
	Parameters: 1
	Flags: Linked
*/
function createproximitygrenadewatcher(watcher)
{
	watcher.watchforfire = 1;
	watcher.hackable = 1;
	watcher.hackertoolradius = level.equipmenthackertoolradius;
	watcher.hackertooltimems = level.equipmenthackertooltimems;
	watcher.activatefx = 1;
	watcher.ownergetsassist = 1;
	watcher.ignoredirection = 1;
	watcher.immediatedetonation = 1;
	watcher.detectiongraceperiod = level.proximitygrenadegraceperiod;
	watcher.detonateradius = level.proximitygrenadedetectionradius;
	watcher.onstun = &weaponobjects::weaponstun;
	watcher.stuntime = 1;
	watcher.ondetonatecallback = &proximitydetonate;
	watcher.activationdelay = level.proximitygrenadeactivationtime;
	watcher.activatesound = #"wpn_claymore_alert";
	watcher.immunespecialty = "specialty_immunetriggershock";
	watcher.onspawn = &onspawnproximitygrenadeweaponobject;
}

/*
	Name: creategadgetproximitygrenadewatcher
	Namespace: proximity_grenade
	Checksum: 0xB97C0F4B
	Offset: 0xA30
	Size: 0x146
	Parameters: 1
	Flags: Linked
*/
function creategadgetproximitygrenadewatcher(watcher)
{
	watcher.watchforfire = 1;
	watcher.hackable = 1;
	watcher.hackertoolradius = level.equipmenthackertoolradius;
	watcher.hackertooltimems = level.equipmenthackertooltimems;
	watcher.activatefx = 1;
	watcher.ownergetsassist = 1;
	watcher.ignoredirection = 1;
	watcher.immediatedetonation = 1;
	watcher.detectiongraceperiod = level.proximitygrenadegraceperiod;
	watcher.detonateradius = level.proximitygrenadedetectionradius;
	watcher.onstun = &weaponobjects::weaponstun;
	watcher.stuntime = 1;
	watcher.ondetonatecallback = &proximitydetonate;
	watcher.activationdelay = level.proximitygrenadeactivationtime;
	watcher.activatesound = #"wpn_claymore_alert";
	watcher.onspawn = &onspawnproximitygrenadeweaponobject;
}

/*
	Name: onspawnproximitygrenadeweaponobject
	Namespace: proximity_grenade
	Checksum: 0x6401FD0B
	Offset: 0xB80
	Size: 0xFA
	Parameters: 2
	Flags: Linked
*/
function onspawnproximitygrenadeweaponobject(watcher, owner)
{
	self thread setupkillcament();
	if(isplayer(owner))
	{
		owner stats::function_e24eec31(self.weapon, #"used", 1);
	}
	if(isdefined(self.weapon) && self.weapon.proximitydetonation > 0)
	{
		watcher.detonateradius = self.weapon.proximitydetonation;
	}
	weaponobjects::onspawnproximityweaponobject(watcher, owner);
	self trackonowner(self.owner);
	self.originalowner = owner;
}

/*
	Name: trackonowner
	Namespace: proximity_grenade
	Checksum: 0x8F54FA73
	Offset: 0xC88
	Size: 0x8A
	Parameters: 1
	Flags: Linked
*/
function trackonowner(owner)
{
	if(level.trackproximitygrenadesonowner === 1)
	{
		if(!isdefined(owner))
		{
			return;
		}
		if(!isdefined(owner.activeproximitygrenades))
		{
			owner.activeproximitygrenades = [];
		}
		else
		{
			arrayremovevalue(owner.activeproximitygrenades, undefined);
		}
		owner.activeproximitygrenades[owner.activeproximitygrenades.size] = self;
	}
}

/*
	Name: setupkillcament
	Namespace: proximity_grenade
	Checksum: 0xA46C503F
	Offset: 0xD20
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function setupkillcament()
{
	self endon(#"death");
	self util::waittillnotmoving();
	self.killcament = spawn("script_model", self.origin + vectorscale((0, 0, 1), 8));
	self thread cleanupkillcamentondeath();
}

/*
	Name: cleanupkillcamentondeath
	Namespace: proximity_grenade
	Checksum: 0x8A217296
	Offset: 0xDA0
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function cleanupkillcamentondeath()
{
	self waittill(#"death");
	self.killcament util::deleteaftertime(4 + (level.proximitygrenadedotdamagetime * level.proximitygrenadedotdamageinstances));
}

/*
	Name: proximitydetonate
	Namespace: proximity_grenade
	Checksum: 0xC7DEFDDE
	Offset: 0xDF8
	Size: 0x124
	Parameters: 3
	Flags: Linked
*/
function proximitydetonate(attacker, weapon, target)
{
	if(isdefined(weapon) && weapon.isvalid)
	{
		if(isdefined(attacker))
		{
			if(self.owner util::isenemyplayer(attacker))
			{
				if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame())
				{
					attacker challenges::destroyedexplosive(weapon);
					scoreevents::processscoreevent(#"destroyed_claymore", attacker, self.owner, weapon);
					if(isdefined(level.var_d2600afc))
					{
						self [[level.var_d2600afc]](attacker, self.owner, self.weapon, weapon);
					}
				}
			}
		}
	}
	weaponobjects::weapondetonate(attacker, weapon);
}

/*
	Name: proximitygrenadedamageplayer
	Namespace: proximity_grenade
	Checksum: 0xE1DBC3ED
	Offset: 0xF28
	Size: 0xCC
	Parameters: 7
	Flags: Linked
*/
function proximitygrenadedamageplayer(eattacker, einflictor, killcament, weapon, meansofdeath, damage, proximitychain)
{
	self thread damageplayerinradius(einflictor.origin, eattacker, killcament);
	if(weapon.chaineventradius > 0 && !self hasperk(#"specialty_proximityprotection"))
	{
		self thread proximitygrenadechain(eattacker, einflictor, killcament, weapon, meansofdeath, damage, proximitychain, 0);
	}
}

/*
	Name: getproximitychain
	Namespace: proximity_grenade
	Checksum: 0xBD03E9E9
	Offset: 0x1000
	Size: 0xD6
	Parameters: 0
	Flags: Linked
*/
function getproximitychain()
{
	if(!isdefined(level.proximitychains))
	{
		level.proximitychains = [];
	}
	foreach(chain in level.proximitychains)
	{
		if(!chainisactive(chain))
		{
			return chain;
		}
	}
	chain = spawnstruct();
	level.proximitychains[level.proximitychains.size] = chain;
	return chain;
}

/*
	Name: chainisactive
	Namespace: proximity_grenade
	Checksum: 0x43E4B69F
	Offset: 0x10E0
	Size: 0x38
	Parameters: 1
	Flags: Linked
*/
function chainisactive(chain)
{
	if(isdefined(chain.activeendtime) && chain.activeendtime > gettime())
	{
		return true;
	}
	return false;
}

/*
	Name: cleanupproximitychainent
	Namespace: proximity_grenade
	Checksum: 0x32F55FEA
	Offset: 0x1120
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function cleanupproximitychainent()
{
	self.cleanup = 1;
	any_active = 1;
	while(any_active)
	{
		wait(1);
		if(!isdefined(self))
		{
			return;
		}
		any_active = 0;
		foreach(proximitychain in self.chains)
		{
			if(proximitychain.activeendtime > gettime())
			{
				any_active = 1;
				break;
			}
		}
	}
	if(isdefined(self))
	{
		self delete();
	}
}

/*
	Name: isinchain
	Namespace: proximity_grenade
	Checksum: 0x3D1BB9D9
	Offset: 0x1208
	Size: 0x3E
	Parameters: 1
	Flags: Linked
*/
function isinchain(player)
{
	player_num = player getentitynumber();
	return isdefined(self.chain_players[player_num]);
}

/*
	Name: addplayertochain
	Namespace: proximity_grenade
	Checksum: 0xE1019BAE
	Offset: 0x1250
	Size: 0x42
	Parameters: 1
	Flags: Linked
*/
function addplayertochain(player)
{
	player_num = player getentitynumber();
	self.chain_players[player_num] = player;
}

/*
	Name: proximitygrenadechain
	Namespace: proximity_grenade
	Checksum: 0xD0880B2C
	Offset: 0x12A0
	Size: 0x482
	Parameters: 8
	Flags: Linked
*/
function proximitygrenadechain(eattacker, einflictor, killcament, weapon, meansofdeath, damage, proximitychain, delay)
{
	self endon(#"disconnect", #"death");
	eattacker endon(#"disconnect");
	if(!isdefined(proximitychain))
	{
		proximitychain = getproximitychain();
		proximitychain.chaineventnum = 0;
		if(!isdefined(einflictor.proximitychainent))
		{
			einflictor.proximitychainent = spawn("script_origin", self.origin);
			einflictor.proximitychainent.chains = [];
			einflictor.proximitychainent.chain_players = [];
		}
		proximitychain.proximitychainent = einflictor.proximitychainent;
		proximitychain.proximitychainent.chains[proximitychain.proximitychainent.chains.size] = proximitychain;
	}
	proximitychain.chaineventnum = proximitychain.chaineventnum + 1;
	if(proximitychain.chaineventnum >= weapon.chaineventmax)
	{
		return;
	}
	chaineventradiussq = weapon.chaineventradius * weapon.chaineventradius;
	endtime = gettime() + weapon.chaineventtime;
	proximitychain.proximitychainent addplayertochain(self);
	proximitychain.activeendtime = (endtime + (int(delay * 1000))) + level.proximitychaingraceperiod;
	if(delay > 0)
	{
		wait(delay);
	}
	if(!isdefined(proximitychain.proximitychainent.cleanup))
	{
		proximitychain.proximitychainent thread cleanupproximitychainent();
	}
	while(true)
	{
		currenttime = gettime();
		if(endtime < currenttime)
		{
			return;
		}
		closestplayers = arraysort(level.players, self.origin, 1);
		foreach(player in closestplayers)
		{
			waitframe(1);
			if(proximitychain.chaineventnum >= weapon.chaineventmax)
			{
				return;
			}
			if(!isdefined(player) || !isalive(player) || player == self)
			{
				continue;
			}
			if(player.sessionstate != "playing")
			{
				continue;
			}
			distancesq = distancesquared(player.origin, self.origin);
			if(distancesq > chaineventradiussq)
			{
				break;
			}
			if(proximitychain.proximitychainent isinchain(player))
			{
				continue;
			}
			if(level.proximitychaindebug || damage::friendlyfirecheck(eattacker, player))
			{
				if(level.proximitychaindebug || !player hasperk(#"specialty_proximityprotection"))
				{
					self thread chainplayer(eattacker, killcament, weapon, meansofdeath, damage, proximitychain, player, distancesq);
				}
			}
		}
		waitframe(1);
	}
}

/*
	Name: chainplayer
	Namespace: proximity_grenade
	Checksum: 0xEFCD460A
	Offset: 0x1730
	Size: 0x1B4
	Parameters: 8
	Flags: Linked
*/
function chainplayer(eattacker, killcament, weapon, meansofdeath, damage, proximitychain, player, distancesq)
{
	waittime = 0.25;
	speedsq = level.proximitychainboltspeed * level.proximitychainboltspeed;
	if(speedsq > 100 && distancesq > 1)
	{
		waittime = distancesq / speedsq;
	}
	player thread proximitygrenadechain(eattacker, self, killcament, weapon, meansofdeath, damage, proximitychain, waittime);
	waitframe(1);
	if(level.proximitychaindebug)
	{
		/#
			color = (1, 1, 1);
			alpha = 1;
			depth = 0;
			time = 200;
			util::debug_line(self.origin + vectorscale((0, 0, 1), 50), player.origin + vectorscale((0, 0, 1), 50), color, alpha, depth, time);
		#/
	}
	self tesla_play_arc_fx(player, waittime);
	player thread damageplayerinradius(self.origin, eattacker, killcament);
}

/*
	Name: tesla_play_arc_fx
	Namespace: proximity_grenade
	Checksum: 0x56927083
	Offset: 0x18F0
	Size: 0x1C4
	Parameters: 2
	Flags: Linked
*/
function tesla_play_arc_fx(target, waittime)
{
	if(!isdefined(self) || !isdefined(target))
	{
		return;
	}
	tag = "J_SpineUpper";
	target_tag = "J_SpineUpper";
	origin = self gettagorigin(tag);
	target_origin = target gettagorigin(target_tag);
	distance_squared = 16384;
	if(distancesquared(origin, target_origin) < distance_squared)
	{
		return;
	}
	fxorg = spawn("script_model", origin);
	fxorg setmodel(#"tag_origin");
	fx = playfxontag(level._effect[#"prox_grenade_chain_bolt"], fxorg, "tag_origin");
	playsoundatposition(#"wpn_tesla_bounce", fxorg.origin);
	fxorg moveto(target_origin, waittime);
	fxorg waittill(#"movedone");
	fxorg delete();
}

/*
	Name: debugchainsphere
	Namespace: proximity_grenade
	Checksum: 0xC3CB96D0
	Offset: 0x1AC0
	Size: 0x3C
	Parameters: 0
	Flags: None
*/
function debugchainsphere()
{
	/#
		util::debug_sphere(self.origin + vectorscale((0, 0, 1), 50), 20, (1, 1, 1), 1, 0);
	#/
}

/*
	Name: watchproximitygrenadehitplayer
	Namespace: proximity_grenade
	Checksum: 0x3EBB3E39
	Offset: 0x1B08
	Size: 0x152
	Parameters: 1
	Flags: Linked
*/
function watchproximitygrenadehitplayer(owner)
{
	self endon(#"death");
	self setowner(owner);
	self setteam(owner.team);
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"grenade_bounce");
		ent = waitresult.entity;
		surface = waitresult.stype;
		if(isdefined(ent) && isplayer(ent) && surface != "riotshield")
		{
			if(level.teambased && !util::function_fbce7263(ent.team, self.owner.team))
			{
				continue;
			}
			self proximitydetonate(self.owner, self.weapon);
			return;
		}
	}
}

/*
	Name: performhudeffects
	Namespace: proximity_grenade
	Checksum: 0xBBE9DBF2
	Offset: 0x1C68
	Size: 0x126
	Parameters: 2
	Flags: None
*/
function performhudeffects(position, distancetogrenade)
{
	forwardvec = vectornormalize(anglestoforward(self.angles));
	rightvec = vectornormalize(anglestoright(self.angles));
	explosionvec = vectornormalize(position - self.origin);
	fdot = vectordot(explosionvec, forwardvec);
	rdot = vectordot(explosionvec, rightvec);
	fangle = acos(fdot);
	rangle = acos(rdot);
}

/*
	Name: damageplayerinradius
	Namespace: proximity_grenade
	Checksum: 0xFB5217E
	Offset: 0x1D98
	Size: 0x48C
	Parameters: 3
	Flags: Linked
*/
function damageplayerinradius(position, eattacker, killcament)
{
	self notify(#"proximitygrenadedamagestart");
	self endon(#"proximitygrenadedamagestart", #"disconnect", #"death");
	eattacker endon(#"disconnect");
	playfxontag(level._effect[#"prox_grenade_player_shock"], self, "J_SpineUpper");
	g_time = gettime();
	if(self util::mayapplyscreeneffect())
	{
		if(!self hasperk(#"specialty_proximityprotection"))
		{
			self.lastshockedby = eattacker;
			self.shockendtime = gettime() + (int(level.proximitygrenadeduration * 1000));
			self shellshock(#"proximity_grenade", level.proximitygrenadeduration, 0);
		}
		self clientfield::set_to_player("tazered", 1);
	}
	self playrumbleonentity("proximity_grenade");
	self playsound(#"wpn_taser_mine_zap");
	if(!self hasperk(#"specialty_proximityprotection"))
	{
		self thread watch_death();
		if(!isdefined(killcament))
		{
			killcament = spawn("script_model", position + vectorscale((0, 0, 1), 8));
		}
		killcament.soundmod = "taser_spike";
		killcament util::deleteaftertime(3 + (level.proximitygrenadedotdamagetime * level.proximitygrenadedotdamageinstances));
		self val::set(#"grenade_damage", "show_hud", 0);
		damage = level.proximitygrenadedotdamageamount;
		if(level.hardcoremode)
		{
			damage = level.proximitygrenadedotdamageamounthardcore;
		}
		for(i = 0; i < level.proximitygrenadedotdamageinstances; i++)
		{
			/#
				assert(isdefined(eattacker));
			#/
			if(!isdefined(killcament))
			{
				killcament = spawn("script_model", position + vectorscale((0, 0, 1), 8));
				killcament.soundmod = "taser_spike";
				killcament util::deleteaftertime(3 + (level.proximitygrenadedotdamagetime * (level.proximitygrenadedotdamageinstances - i)));
			}
			self dodamage(damage, position, eattacker, killcament, "none", "MOD_GAS", 0, getweapon(#"proximity_grenade_aoe"));
			wait(level.proximitygrenadedotdamagetime);
		}
		if(gettime() - g_time < int(level.proximitygrenadeduration * 1000))
		{
			wait((float(gettime() - g_time)) / 1000);
		}
		self val::reset(#"grenade_damage", "show_hud");
	}
	else
	{
		wait(level.proximitygrenadeprotectedtime);
	}
	self clientfield::set_to_player("tazered", 0);
}

/*
	Name: proximitydeathwait
	Namespace: proximity_grenade
	Checksum: 0xE75BF707
	Offset: 0x2230
	Size: 0x36
	Parameters: 1
	Flags: None
*/
function proximitydeathwait(owner)
{
	self waittill(#"death");
	self notify(#"deletesound");
}

/*
	Name: deleteentonownerdeath
	Namespace: proximity_grenade
	Checksum: 0xF076DF25
	Offset: 0x2270
	Size: 0x76
	Parameters: 1
	Flags: None
*/
function deleteentonownerdeath(owner)
{
	self thread deleteentontimeout();
	self thread deleteentaftertime();
	self endon(#"delete");
	owner waittill(#"death");
	self notify(#"deletesound");
}

/*
	Name: deleteentaftertime
	Namespace: proximity_grenade
	Checksum: 0xAF2EEBE4
	Offset: 0x22F0
	Size: 0x36
	Parameters: 0
	Flags: Linked
*/
function deleteentaftertime()
{
	self endon(#"delete");
	wait(10);
	self notify(#"deletesound");
}

/*
	Name: deleteentontimeout
	Namespace: proximity_grenade
	Checksum: 0x80B19A40
	Offset: 0x2330
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function deleteentontimeout()
{
	self endon(#"delete");
	self waittill(#"deletesound");
	self delete();
}

/*
	Name: watch_death
	Namespace: proximity_grenade
	Checksum: 0x2F3C458B
	Offset: 0x2378
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function watch_death()
{
	self endon(#"disconnect");
	self notify(#"proximity_cleanup");
	self endon(#"proximity_cleanup");
	self waittill(#"death");
	self stoprumble("proximity_grenade");
	self setblur(0, 0);
	self val::reset(#"grenade_damage", "show_hud");
	self clientfield::set_to_player("tazered", 0);
}

/*
	Name: function_b0604bb3
	Namespace: proximity_grenade
	Checksum: 0xF9C7E62D
	Offset: 0x2450
	Size: 0xAC
	Parameters: 1
	Flags: Event
*/
event function_b0604bb3(eventstruct)
{
	if(!isplayer(self))
	{
		return;
	}
	grenade = eventstruct.projectile;
	weapon = eventstruct.weapon;
	if(grenade util::ishacked())
	{
		return;
	}
	if(weapon.rootweapon.name == "proximity_grenade")
	{
		grenade thread watchproximitygrenadehitplayer(self);
	}
}

/*
	Name: on_damage
	Namespace: proximity_grenade
	Checksum: 0xEFE19385
	Offset: 0x2508
	Size: 0x64
	Parameters: 5
	Flags: Linked
*/
function on_damage(eattacker, einflictor, weapon, meansofdeath, damage)
{
	self thread proximitygrenadedamageplayer(eattacker, einflictor, einflictor.killcament, weapon, meansofdeath, damage, undefined);
}

