// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\dev_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace heatseekingmissile;

/*
	Name: init_shared
	Namespace: heatseekingmissile
	Checksum: 0x3AF7DC0E
	Offset: 0x198
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function init_shared()
{
	game.locking_on_sound = "uin_alert_lockon_start";
	game.locked_on_sound = "uin_alert_lockon";
	callback::on_spawned(&on_player_spawned);
	level.fx_flare = "killstreaks/fx8_atkchpr_chaff";
	/#
		setdvar(#"scr_freelock", 0);
	#/
}

/*
	Name: on_player_spawned
	Namespace: heatseekingmissile
	Checksum: 0xBDBB8F41
	Offset: 0x228
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	self endon(#"disconnect");
	self clearirtarget();
	self callback::function_f77ced93(&function_f77ced93);
}

/*
	Name: clearirtarget
	Namespace: heatseekingmissile
	Checksum: 0xDC9ECEEF
	Offset: 0x280
	Size: 0x1EC
	Parameters: 0
	Flags: Linked
*/
function clearirtarget()
{
	self notify(#"stop_lockon_sound");
	self notify(#"stop_locked_sound");
	self.stingerlocksound = undefined;
	self stoprumble("stinger_lock_rumble");
	self.stingerlockstarttime = 0;
	self.stingerlockstarted = 0;
	self.stingerlockfinalized = 0;
	self.stingerlockdetected = 0;
	if(isdefined(self.stingertarget))
	{
		self.stingertarget notify(#"missile_unlocked");
		clientnum = self getentitynumber();
		if((self.stingertarget.locked_on & (1 << clientnum)) != 0)
		{
			self notify(#"hash_41e93a518427847c");
		}
		self lockingon(self.stingertarget, 0);
		self lockedon(self.stingertarget, 0);
	}
	self.stingertarget = undefined;
	self.stingersubtarget = undefined;
	self weaponlockfree();
	self weaponlocktargettooclose(0);
	self weaponlocknoclearance(0);
	self stoplocalsound(game.locking_on_sound);
	self stoplocalsound(game.locked_on_sound);
	/#
		self destroylockoncanceledmessage();
	#/
}

/*
	Name: function_5e6cd0ab
	Namespace: heatseekingmissile
	Checksum: 0xB5CD9017
	Offset: 0x478
	Size: 0x84
	Parameters: 2
	Flags: Linked
*/
function function_5e6cd0ab(weapon, attacker)
{
	params = {#attacker:attacker, #weapon:weapon};
	self notify(#"missile_lock", params);
	self callback::callback(#"missile_lock", params);
}

/*
	Name: function_a439ae56
	Namespace: heatseekingmissile
	Checksum: 0x464EA457
	Offset: 0x508
	Size: 0x9C
	Parameters: 3
	Flags: Linked
*/
function function_a439ae56(missile, weapon, attacker)
{
	params = {#attacker:attacker, #weapon:weapon, #projectile:missile};
	self notify(#"stinger_fired_at_me", params);
	self callback::callback(#"hash_1a32e0fdeb70a76b", params);
}

/*
	Name: function_a3d258b6
	Namespace: heatseekingmissile
	Checksum: 0x329FF725
	Offset: 0x5B0
	Size: 0x10C
	Parameters: 1
	Flags: Event
*/
event function_a3d258b6(eventstruct)
{
	missile = eventstruct.projectile;
	weapon = eventstruct.weapon;
	target = eventstruct.target;
	/#
		thread debug_missile(missile);
	#/
	if(weapon.lockontype == "Legacy Single")
	{
		if(isplayer(self) && isdefined(self.stingertarget) && self.stingerlockfinalized)
		{
			self.stingertarget function_a439ae56(missile, weapon, self);
		}
		else if(isdefined(target))
		{
			target function_a439ae56(missile, weapon, self);
		}
	}
}

/*
	Name: debug_missile
	Namespace: heatseekingmissile
	Checksum: 0x22E540B7
	Offset: 0x6C8
	Size: 0x252
	Parameters: 1
	Flags: None
*/
function debug_missile(missile)
{
	/#
		level notify(#"debug_missile");
		level endon(#"debug_missile");
		level.debug_missile_dots = [];
		while(true)
		{
			if(getdvarint(#"scr_debug_missile", 0) == 0)
			{
				wait(0.5);
				continue;
			}
			if(isdefined(missile))
			{
				missile_info = spawnstruct();
				missile_info.origin = missile.origin;
				target = missile missile_gettarget();
				missile_info.targetentnum = (isdefined(target) ? target getentitynumber() : undefined);
				if(!isdefined(level.debug_missile_dots))
				{
					level.debug_missile_dots = [];
				}
				else if(!isarray(level.debug_missile_dots))
				{
					level.debug_missile_dots = array(level.debug_missile_dots);
				}
				level.debug_missile_dots[level.debug_missile_dots.size] = missile_info;
			}
			foreach(missile_info in level.debug_missile_dots)
			{
				dot_color = (isdefined(missile_info.targetentnum) ? (1, 0, 0) : (0, 1, 0));
				dev::debug_sphere(missile_info.origin, 10, dot_color, 0.66, 1);
			}
			waitframe(1);
		}
	#/
}

/*
	Name: getappropriateplayerweapon
	Namespace: heatseekingmissile
	Checksum: 0x30E427BC
	Offset: 0x928
	Size: 0xB2
	Parameters: 1
	Flags: Linked
*/
function getappropriateplayerweapon(currentweapon)
{
	appropriateweapon = currentweapon;
	if(self.usingvehicle)
	{
		vehicleseatposition = (isdefined(self.vehicleposition) ? self.vehicleposition : 0);
		vehicleentity = self.viewlockedentity;
		if(isdefined(vehicleentity) && isvehicle(vehicleentity))
		{
			appropriateweapon = vehicleentity seatgetweapon(vehicleseatposition);
			if(!isdefined(appropriateweapon))
			{
				appropriateweapon = currentweapon;
			}
		}
	}
	return appropriateweapon;
}

/*
	Name: stingerwaitforads
	Namespace: heatseekingmissile
	Checksum: 0xC0510940
	Offset: 0x9E8
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function stingerwaitforads()
{
	while(!self playerstingerads())
	{
		waitframe(1);
		currentweapon = self getcurrentweapon();
		weapon = getappropriateplayerweapon(currentweapon);
		if(weapon.lockontype != "Legacy Single" || weapon.noadslockoncheck)
		{
			return false;
		}
	}
	return true;
}

/*
	Name: function_f77ced93
	Namespace: heatseekingmissile
	Checksum: 0x72E86EE8
	Offset: 0xA90
	Size: 0x210
	Parameters: 1
	Flags: Linked
*/
function function_f77ced93(params)
{
	self endon(#"death", #"disconnect");
	weapon = self getappropriateplayerweapon(params.weapon);
	while(weapon.lockontype == "Legacy Single")
	{
		weaponammoclip = self getweaponammoclip(weapon);
		if(weaponammoclip == 0 && !weapon.unlimitedammo)
		{
			waitframe(1);
			currentweapon = self getcurrentweapon();
			weapon = self getappropriateplayerweapon(params.weapon);
			continue;
		}
		if(!weapon.noadslockoncheck && !stingerwaitforads())
		{
			break;
		}
		self thread stingerirtloop(weapon);
		if(weapon.noadslockoncheck)
		{
			waitresult = undefined;
			waitresult = self waittill(#"weapon_change");
			weapon = self getappropriateplayerweapon(waitresult.weapon);
		}
		else
		{
			while(self playerstingerads())
			{
				waitframe(1);
			}
			currweap = self getcurrentweapon();
			weapon = self getappropriateplayerweapon(currweap);
		}
		self notify(#"stinger_irt_off");
		self clearirtarget();
	}
}

/*
	Name: stingerirtloop
	Namespace: heatseekingmissile
	Checksum: 0x38CF3D6B
	Offset: 0xCA8
	Size: 0x7A8
	Parameters: 1
	Flags: Linked
*/
function stingerirtloop(weapon)
{
	self endon(#"disconnect", #"death", #"stinger_irt_off");
	locklength = self getlockonspeed();
	if(!isdefined(self.stingerlockfinalized))
	{
		self.stingerlockfinalized = 0;
	}
	for(;;)
	{
		waitframe(1);
		if(!self hasweapon(weapon))
		{
			return;
		}
		currentweapon = self getcurrentweapon();
		currentplayerweapon = self getappropriateplayerweapon(currentweapon);
		if(currentplayerweapon !== weapon)
		{
			continue;
		}
		if(isdefined(self.stingerlockfinalized) && self.stingerlockfinalized)
		{
			passed = softsighttest();
			if(!passed)
			{
				continue;
			}
			if(!self isstillvalidtarget(self.stingertarget, self.stingersubtarget, weapon) || self insidestingerreticlelocked(self.stingertarget, self.stingersubtarget, weapon) == 0)
			{
				self setweaponlockonpercent(weapon, 0);
				self clearirtarget();
				continue;
			}
			if(!self.stingertarget.locked_on)
			{
				self.stingertarget function_5e6cd0ab(self getcurrentweapon(), self);
			}
			self lockingon(self.stingertarget, 0);
			self lockedon(self.stingertarget, 1);
			if(isdefined(weapon))
			{
				setfriendlyflags(weapon, self.stingertarget);
			}
			thread looplocallocksound(game.locked_on_sound, 0.75);
			continue;
		}
		if(isdefined(self.stingerlockstarted) && self.stingerlockstarted)
		{
			if(!self isstillvalidtarget(self.stingertarget, self.stingersubtarget, weapon) || self insidestingerreticlelocked(self.stingertarget, self.stingersubtarget, weapon) == 0)
			{
				self setweaponlockonpercent(weapon, 0);
				self clearirtarget();
				continue;
			}
			self lockingon(self.stingertarget, 1);
			self lockedon(self.stingertarget, 0);
			if(isdefined(weapon))
			{
				setfriendlyflags(weapon, self.stingertarget);
			}
			passed = softsighttest();
			if(!passed)
			{
				continue;
			}
			timepassed = gettime() - self.stingerlockstarttime;
			if(isdefined(weapon))
			{
				lockpct = 1;
				if(locklength > 0)
				{
					lockpct = timepassed / locklength;
				}
				self setweaponlockonpercent(weapon, lockpct * 100);
				setfriendlyflags(weapon, self.stingertarget);
			}
			if(timepassed < locklength)
			{
				continue;
			}
			/#
				assert(isdefined(self.stingertarget));
			#/
			self notify(#"stop_lockon_sound");
			self.stingerlockfinalized = 1;
			self weaponlockfinalize(self.stingertarget, 0, self.stingersubtarget);
			continue;
		}
		result = self getbeststingertarget(weapon);
		besttarget = result[#"target"];
		bestsubtarget = result[#"subtarget"];
		if(!isdefined(besttarget) || (isdefined(self.stingertarget) && self.stingertarget != besttarget))
		{
			/#
				self destroylockoncanceledmessage();
			#/
			if(self.stingerlockdetected == 1)
			{
				self weaponlockfree();
				self.stingerlockdetected = 0;
			}
			continue;
		}
		if(!self locksighttest(besttarget))
		{
			/#
				self destroylockoncanceledmessage();
			#/
			continue;
		}
		if(isdefined(besttarget.lockondelay) && besttarget.lockondelay)
		{
			/#
				self displaylockoncanceledmessage();
			#/
			continue;
		}
		if(!targetwithinrangeofplayspace(besttarget))
		{
			/#
				self displaylockoncanceledmessage();
			#/
			continue;
		}
		if(!function_1b76fb42(besttarget, weapon))
		{
			/#
				self displaylockoncanceledmessage();
			#/
			continue;
		}
		/#
			self destroylockoncanceledmessage();
		#/
		if(self insidestingerreticlelocked(besttarget, bestsubtarget, weapon) == 0)
		{
			if(self.stingerlockdetected == 0)
			{
				self weaponlockdetect(besttarget, 0, bestsubtarget);
			}
			self.stingerlockdetected = 1;
			if(isdefined(weapon))
			{
				setfriendlyflags(weapon, besttarget);
			}
			continue;
		}
		self.stingerlockdetected = 0;
		initlockfield(besttarget);
		self.stingertarget = besttarget;
		self.stingersubtarget = bestsubtarget;
		self.stingerlockstarttime = gettime();
		self.stingerlockstarted = 1;
		self.stingerlostsightlinetime = 0;
		self weaponlockstart(besttarget, 0, bestsubtarget);
		self thread looplocalseeksound(game.locking_on_sound, 0.6);
	}
}

/*
	Name: targetwithinrangeofplayspace
	Namespace: heatseekingmissile
	Checksum: 0xC26E97F9
	Offset: 0x1458
	Size: 0x196
	Parameters: 1
	Flags: Linked
*/
function targetwithinrangeofplayspace(target)
{
	/#
		if(getdvarint(#"scr_missilelock_playspace_extra_radius_override_enabled", 0) > 0)
		{
			extraradiusdvar = getdvarint(#"scr_missilelock_playspace_extra_radius", 5000);
			if(extraradiusdvar != (isdefined(level.missilelockplayspacecheckextraradius) ? level.missilelockplayspacecheckextraradius : 0))
			{
				level.missilelockplayspacecheckextraradius = extraradiusdvar;
				level.missilelockplayspacecheckradiussqr = undefined;
			}
		}
	#/
	if(level.missilelockplayspacecheckenabled === 1)
	{
		if(!isdefined(target))
		{
			return false;
		}
		if(!isdefined(level.playspacecenter))
		{
			level.playspacecenter = util::getplayspacecenter();
		}
		if(!isdefined(level.missilelockplayspacecheckradiussqr))
		{
			level.missilelockplayspacecheckradiussqr = ((util::getplayspacemaxwidth() * 0.5) + level.missilelockplayspacecheckextraradius) * ((util::getplayspacemaxwidth() * 0.5) + level.missilelockplayspacecheckextraradius);
		}
		if(distance2dsquared(target.origin, level.playspacecenter) > level.missilelockplayspacecheckradiussqr)
		{
			return false;
		}
	}
	return true;
}

/*
	Name: destroylockoncanceledmessage
	Namespace: heatseekingmissile
	Checksum: 0xB3D3F071
	Offset: 0x15F8
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function destroylockoncanceledmessage()
{
	/#
		if(isdefined(self.lockoncanceledmessage))
		{
			self.lockoncanceledmessage destroy();
		}
	#/
}

/*
	Name: displaylockoncanceledmessage
	Namespace: heatseekingmissile
	Checksum: 0xE5279E87
	Offset: 0x1630
	Size: 0x144
	Parameters: 0
	Flags: None
*/
function displaylockoncanceledmessage()
{
	/#
		if(isdefined(self.lockoncanceledmessage))
		{
			return;
		}
		self.lockoncanceledmessage = newdebughudelem(self);
		self.lockoncanceledmessage.fontscale = 1.25;
		self.lockoncanceledmessage.x = 0;
		self.lockoncanceledmessage.y = 50;
		self.lockoncanceledmessage.alignx = "";
		self.lockoncanceledmessage.aligny = "";
		self.lockoncanceledmessage.horzalign = "";
		self.lockoncanceledmessage.vertalign = "";
		self.lockoncanceledmessage.foreground = 1;
		self.lockoncanceledmessage.hidewheninmenu = 1;
		self.lockoncanceledmessage.archived = 0;
		self.lockoncanceledmessage.alpha = 1;
		self.lockoncanceledmessage settext(#"hash_31537402e7b1c369");
	#/
}

/*
	Name: function_d656e945
	Namespace: heatseekingmissile
	Checksum: 0xD27CC20A
	Offset: 0x1780
	Size: 0x9E
	Parameters: 1
	Flags: Linked, Private
*/
function private function_d656e945(team)
{
	if(!isdefined(self.team))
	{
		return false;
	}
	vehicle_team = self.team;
	if(vehicle_team == #"neutral")
	{
		driver = self getseatoccupant(0);
		if(isdefined(driver))
		{
			vehicle_team = driver.team;
		}
	}
	if(util::function_fbce7263(vehicle_team, team))
	{
		return true;
	}
	return false;
}

/*
	Name: getbeststingertarget
	Namespace: heatseekingmissile
	Checksum: 0x7DE9C4A8
	Offset: 0x1828
	Size: 0x4EE
	Parameters: 1
	Flags: Linked
*/
function getbeststingertarget(weapon)
{
	result = [];
	targetsall = [];
	if(isdefined(self.get_stinger_target_override))
	{
		targetsall = self [[self.get_stinger_target_override]]();
	}
	else
	{
		targetsall = target_getarray();
	}
	targetsvalid = [];
	subtargetsvalid = [];
	for(idx = 0; idx < targetsall.size; idx++)
	{
		/#
			if(getdvarint(#"scr_freelock", 0) == 1)
			{
				if(self insidestingerreticlenolock(targetsall[idx], undefined, weapon))
				{
					targetsvalid[targetsvalid.size] = targetsall[idx];
				}
				continue;
			}
		#/
		target = targetsall[idx];
		if(!isdefined(target))
		{
			continue;
		}
		subtargets = target_getsubtargets(target);
		for(sidx = 0; sidx < subtargets.size; sidx++)
		{
			subtarget = subtargets[sidx];
			if(isdefined(target))
			{
				if(level.teambased || level.use_team_based_logic_for_locking_on === 1)
				{
					if(target function_d656e945(self.team))
					{
						if(self insidestingerreticledetect(target, subtarget, weapon))
						{
							if(!isdefined(self.is_valid_target_for_stinger_override) || self [[self.is_valid_target_for_stinger_override]](target))
							{
								if(!isentity(target) || isalive(target))
								{
									hascamo = isdefined(target.camo_state) && target.camo_state == 1 && !self hasperk(#"specialty_showenemyequipment");
									if(!hascamo)
									{
										targetsvalid[targetsvalid.size] = target;
										subtargetsvalid[subtargetsvalid.size] = subtarget;
									}
								}
							}
						}
					}
					continue;
				}
				if(self insidestingerreticledetect(target, subtarget, weapon))
				{
					if(isdefined(target.owner) && self != target.owner || (isplayer(target) && self != target))
					{
						if(!isdefined(self.is_valid_target_for_stinger_override) || self [[self.is_valid_target_for_stinger_override]](target))
						{
							if(!isentity(target) || isalive(target))
							{
								targetsvalid[targetsvalid.size] = target;
								subtargetsvalid[subtargetsvalid.size] = subtarget;
							}
						}
					}
				}
			}
		}
	}
	if(targetsvalid.size == 0)
	{
		return result;
	}
	besttarget = targetsvalid[0];
	bestsubtarget = subtargetsvalid[0];
	if(targetsvalid.size > 1)
	{
		closestratio = 0;
		foreach(target in targetsvalid)
		{
			ratio = ratiodistancefromscreencenter(target, subtarget, weapon);
			if(ratio > closestratio)
			{
				closestratio = ratio;
				besttarget = target;
			}
		}
	}
	result[#"target"] = besttarget;
	result[#"subtarget"] = bestsubtarget;
	return result;
}

/*
	Name: calclockonradius
	Namespace: heatseekingmissile
	Checksum: 0x888B04B6
	Offset: 0x1D20
	Size: 0x100
	Parameters: 3
	Flags: Linked
*/
function calclockonradius(target, subtarget, weapon)
{
	radius = self getlockonradius();
	if(isdefined(weapon) && isdefined(weapon.lockonscreenradius) && weapon.lockonscreenradius > radius)
	{
		radius = weapon.lockonscreenradius;
	}
	if(isdefined(level.lockoncloserange) && isdefined(level.lockoncloseradiusscaler))
	{
		dist2 = distancesquared(target.origin, self.origin);
		if(dist2 < level.lockoncloserange * level.lockoncloserange)
		{
			radius = radius * level.lockoncloseradiusscaler;
		}
	}
	return radius;
}

/*
	Name: calclockonlossradius
	Namespace: heatseekingmissile
	Checksum: 0x69E34548
	Offset: 0x1E28
	Size: 0x100
	Parameters: 3
	Flags: Linked
*/
function calclockonlossradius(target, subtarget, weapon)
{
	radius = self getlockonlossradius();
	if(isdefined(weapon) && isdefined(weapon.lockonscreenradius) && weapon.lockonscreenradius > radius)
	{
		radius = weapon.lockonscreenradius;
	}
	if(isdefined(level.lockoncloserange) && isdefined(level.lockoncloseradiusscaler))
	{
		dist2 = distancesquared(target.origin, self.origin);
		if(dist2 < level.lockoncloserange * level.lockoncloserange)
		{
			radius = radius * level.lockoncloseradiusscaler;
		}
	}
	return radius;
}

/*
	Name: ratiodistancefromscreencenter
	Namespace: heatseekingmissile
	Checksum: 0x38484A83
	Offset: 0x1F30
	Size: 0x6A
	Parameters: 3
	Flags: Linked
*/
function ratiodistancefromscreencenter(target, subtarget, weapon)
{
	radius = calclockonradius(target, subtarget, weapon);
	return target_scaleminmaxradius(target, self, 65, 0, radius, subtarget);
}

/*
	Name: insidestingerreticledetect
	Namespace: heatseekingmissile
	Checksum: 0xA15278F5
	Offset: 0x1FA8
	Size: 0x6A
	Parameters: 3
	Flags: Linked
*/
function insidestingerreticledetect(target, subtarget, weapon)
{
	radius = calclockonradius(target, subtarget, weapon);
	return target_isincircle(target, self, 65, radius, 0, subtarget);
}

/*
	Name: insidestingerreticlenolock
	Namespace: heatseekingmissile
	Checksum: 0x58D23FD2
	Offset: 0x2020
	Size: 0x6A
	Parameters: 3
	Flags: None
*/
function insidestingerreticlenolock(target, subtarget, weapon)
{
	radius = calclockonradius(target, subtarget, weapon);
	return target_isincircle(target, self, 65, radius, 0, subtarget);
}

/*
	Name: insidestingerreticlelocked
	Namespace: heatseekingmissile
	Checksum: 0xD6A635DD
	Offset: 0x2098
	Size: 0x6A
	Parameters: 3
	Flags: Linked
*/
function insidestingerreticlelocked(target, subtarget, weapon)
{
	radius = calclockonlossradius(target, subtarget, weapon);
	return target_isincircle(target, self, 65, radius, 0, subtarget);
}

/*
	Name: isstillvalidtarget
	Namespace: heatseekingmissile
	Checksum: 0xD909D419
	Offset: 0x2110
	Size: 0x116
	Parameters: 3
	Flags: Linked
*/
function isstillvalidtarget(ent, subtarget, weapon)
{
	if(!isdefined(ent))
	{
		return 0;
	}
	if(isentity(ent) && !isalive(ent))
	{
		return 0;
	}
	if(isdefined(ent.is_still_valid_target_for_stinger_override))
	{
		return self [[ent.is_still_valid_target_for_stinger_override]](ent, weapon);
	}
	if(isdefined(self.is_still_valid_target_for_stinger_override))
	{
		return self [[self.is_still_valid_target_for_stinger_override]](ent, weapon);
	}
	if(!target_istarget(ent) && (!(isdefined(ent.allowcontinuedlockonafterinvis) && ent.allowcontinuedlockonafterinvis)))
	{
		return 0;
	}
	if(!function_1b76fb42(ent, weapon))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_1b76fb42
	Namespace: heatseekingmissile
	Checksum: 0xBF356322
	Offset: 0x2230
	Size: 0xAC
	Parameters: 2
	Flags: Linked
*/
function function_1b76fb42(ent, weapon)
{
	var_91c7ae51 = distance2dsquared(self.origin, ent.origin);
	if(weapon.lockonminrange > 0)
	{
		if(var_91c7ae51 < weapon.lockonminrange * weapon.lockonminrange)
		{
			return false;
		}
	}
	if(weapon.lockonmaxrange > 0)
	{
		if(var_91c7ae51 > weapon.lockonmaxrange * weapon.lockonmaxrange)
		{
			return false;
		}
	}
	return true;
}

/*
	Name: playerstingerads
	Namespace: heatseekingmissile
	Checksum: 0xD5735B05
	Offset: 0x22E8
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function playerstingerads()
{
	return self playerads() == 1;
}

/*
	Name: looplocalseeksound
	Namespace: heatseekingmissile
	Checksum: 0x2560BDDA
	Offset: 0x2318
	Size: 0xAC
	Parameters: 2
	Flags: Linked
*/
function looplocalseeksound(alias, interval)
{
	self endon(#"stop_lockon_sound", #"disconnect", #"death", #"enter_vehicle", #"exit_vehicle");
	for(;;)
	{
		self playsoundforlocalplayer(alias);
		self playrumbleonentity("stinger_lock_rumble");
		wait(interval / 2);
	}
}

/*
	Name: playsoundforlocalplayer
	Namespace: heatseekingmissile
	Checksum: 0x8F14618C
	Offset: 0x23D0
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function playsoundforlocalplayer(alias)
{
	if(self isinvehicle())
	{
		sound_target = self getvehicleoccupied();
		if(isdefined(sound_target))
		{
			sound_target playsoundtoplayer(alias, self);
		}
	}
	else
	{
		self playlocalsound(alias);
	}
}

/*
	Name: looplocallocksound
	Namespace: heatseekingmissile
	Checksum: 0x8F175BC5
	Offset: 0x2460
	Size: 0x172
	Parameters: 2
	Flags: Linked
*/
function looplocallocksound(alias, interval)
{
	self endon(#"stop_locked_sound", #"disconnect", #"death", #"enter_vehicle", #"exit_vehicle");
	if(isdefined(self.stingerlocksound))
	{
		return;
	}
	self.stingerlocksound = 1;
	for(;;)
	{
		self playsoundforlocalplayer(alias);
		self playrumbleonentity("stinger_lock_rumble");
		wait(interval / 6);
		self playsoundforlocalplayer(alias);
		self playrumbleonentity("stinger_lock_rumble");
		wait(interval / 6);
		self playsoundforlocalplayer(alias);
		self playrumbleonentity("stinger_lock_rumble");
		wait(interval / 6);
		self stoprumble("stinger_lock_rumble");
	}
	self.stingerlocksound = undefined;
}

/*
	Name: locksighttest
	Namespace: heatseekingmissile
	Checksum: 0x6734BB86
	Offset: 0x25E0
	Size: 0x24E
	Parameters: 2
	Flags: Linked
*/
function locksighttest(target, subtarget)
{
	camerapos = self getplayercamerapos();
	if(!isdefined(target))
	{
		return false;
	}
	if(isdefined(target.var_e8ec304d) && target.var_e8ec304d)
	{
		return false;
	}
	targetorigin = target_getorigin(target, subtarget);
	if(isdefined(target.parent))
	{
		passed = bullettracepassed(camerapos, targetorigin, 0, target, target.parent);
	}
	else
	{
		passed = bullettracepassed(camerapos, targetorigin, 0, target);
	}
	if(passed)
	{
		return true;
	}
	front = target getpointinbounds(1, 0, 0);
	if(isdefined(target.parent))
	{
		passed = bullettracepassed(camerapos, front, 0, target, target.parent);
	}
	else
	{
		passed = bullettracepassed(camerapos, front, 0, target);
	}
	if(passed)
	{
		return true;
	}
	back = target getpointinbounds(-1, 0, 0);
	if(isdefined(target.parent))
	{
		passed = bullettracepassed(camerapos, back, 0, target, target.parent);
	}
	else
	{
		passed = bullettracepassed(camerapos, back, 0, target);
	}
	if(passed)
	{
		return true;
	}
	return false;
}

/*
	Name: softsighttest
	Namespace: heatseekingmissile
	Checksum: 0xDA1B4863
	Offset: 0x2838
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function softsighttest()
{
	lost_sight_limit = 500;
	if(self locksighttest(self.stingertarget, self.stingersubtarget))
	{
		self.stingerlostsightlinetime = 0;
		return true;
	}
	if(self.stingerlostsightlinetime == 0)
	{
		self.stingerlostsightlinetime = gettime();
	}
	timepassed = gettime() - self.stingerlostsightlinetime;
	if(timepassed >= lost_sight_limit)
	{
		self clearirtarget();
		return false;
	}
	return true;
}

/*
	Name: initlockfield
	Namespace: heatseekingmissile
	Checksum: 0x686E33D5
	Offset: 0x28F0
	Size: 0x42
	Parameters: 1
	Flags: Linked
*/
function initlockfield(target)
{
	if(isdefined(target.locking_on))
	{
		return;
	}
	target.locking_on = 0;
	target.locked_on = 0;
	target.locking_on_hacking = 0;
}

/*
	Name: lockingon
	Namespace: heatseekingmissile
	Checksum: 0xD64CE2FF
	Offset: 0x2940
	Size: 0x12A
	Parameters: 2
	Flags: Linked
*/
function lockingon(target, lock)
{
	/#
		assert(isdefined(target.locking_on));
	#/
	clientnum = self getentitynumber();
	if(lock)
	{
		if((target.locking_on & (1 << clientnum)) == 0)
		{
			target notify(#"hash_594587fd1093c3b3");
			target.locking_on = target.locking_on | (1 << clientnum);
			self thread watchclearlockingon(target, clientnum);
			if(isdefined(level.var_cef454e8))
			{
				self thread [[level.var_cef454e8]](target);
			}
		}
	}
	else
	{
		self notify(#"locking_on_cleared");
		target.locking_on = target.locking_on & (~(1 << clientnum));
	}
}

/*
	Name: watchclearlockingon
	Namespace: heatseekingmissile
	Checksum: 0x504CC5EA
	Offset: 0x2A78
	Size: 0x86
	Parameters: 2
	Flags: Linked
*/
function watchclearlockingon(target, clientnum)
{
	target endon(#"death");
	self endon(#"locking_on_cleared");
	self waittill(#"death", #"disconnect");
	target.locking_on = target.locking_on & (~(1 << clientnum));
}

/*
	Name: lockedon
	Namespace: heatseekingmissile
	Checksum: 0xB4501774
	Offset: 0x2B08
	Size: 0x112
	Parameters: 2
	Flags: Linked
*/
function lockedon(target, lock)
{
	/#
		assert(isdefined(target.locked_on));
	#/
	clientnum = self getentitynumber();
	if(lock)
	{
		if((target.locked_on & (1 << clientnum)) == 0)
		{
			target.locked_on = target.locked_on | (1 << clientnum);
			self notify(#"lock_on_acquired");
			self thread watchclearlockedon(target, clientnum);
		}
	}
	else
	{
		self notify(#"locked_on_cleared");
		target.locked_on = target.locked_on & (~(1 << clientnum));
	}
}

/*
	Name: targetinghacking
	Namespace: heatseekingmissile
	Checksum: 0xADDCD9DC
	Offset: 0x2C28
	Size: 0xEA
	Parameters: 2
	Flags: None
*/
function targetinghacking(target, lock)
{
	/#
		assert(isdefined(target.locking_on_hacking));
	#/
	clientnum = self getentitynumber();
	if(lock)
	{
		target notify(#"hash_7cda5f1e15bc902c");
		target.locking_on_hacking = target.locking_on_hacking | (1 << clientnum);
		self thread watchclearhacking(target, clientnum);
	}
	else
	{
		self notify(#"locking_on_hacking_cleared");
		target.locking_on_hacking = target.locking_on_hacking & (~(1 << clientnum));
	}
}

/*
	Name: watchclearhacking
	Namespace: heatseekingmissile
	Checksum: 0x230BDCD7
	Offset: 0x2D20
	Size: 0x86
	Parameters: 2
	Flags: Linked
*/
function watchclearhacking(target, clientnum)
{
	target endon(#"death");
	self endon(#"locking_on_hacking_cleared");
	self waittill(#"death", #"disconnect");
	target.locking_on_hacking = target.locking_on_hacking & (~(1 << clientnum));
}

/*
	Name: setfriendlyflags
	Namespace: heatseekingmissile
	Checksum: 0xAE76D30C
	Offset: 0x2DB0
	Size: 0x5C4
	Parameters: 2
	Flags: Linked
*/
function setfriendlyflags(weapon, target)
{
	if(!self isinvehicle())
	{
		self setfriendlyhacking(weapon, target);
		self setfriendlytargetting(weapon, target);
		self setfriendlytargetlocked(weapon, target);
		if(isdefined(level.killstreakmaxhealthfunction))
		{
			if(isdefined(target.usevtoltime) && isdefined(level.vtol))
			{
				killstreakendtime = level.vtol.killstreakendtime;
				if(isdefined(killstreakendtime))
				{
					self settargetedentityendtime(weapon, int(killstreakendtime));
				}
			}
			else
			{
				if(isdefined(target.killstreakendtime))
				{
					self settargetedentityendtime(weapon, int(target.killstreakendtime));
				}
				else
				{
					if(isdefined(target.parentstruct) && isdefined(target.parentstruct.killstreakendtime))
					{
						self settargetedentityendtime(weapon, int(target.parentstruct.killstreakendtime));
					}
					else
					{
						self settargetedentityendtime(weapon, 0);
					}
				}
			}
			self settargetedmissilesremaining(weapon, 0);
			killstreaktype = target.killstreaktype;
			if(!isdefined(target.killstreaktype) && isdefined(target.parentstruct) && isdefined(target.parentstruct.killstreaktype))
			{
				killstreaktype = target.parentstruct.killstreaktype;
			}
			else if(isdefined(target.usevtoltime) && isdefined(level.vtol.killstreaktype))
			{
				killstreaktype = level.vtol.killstreaktype;
			}
			if(isdefined(killstreaktype) && isdefined(level.killstreakbundle[killstreaktype]))
			{
				if(isdefined(target.forceonemissile))
				{
					self settargetedmissilesremaining(weapon, 1);
				}
				else
				{
					if(isdefined(target.usevtoltime) && isdefined(level.vtol) && isdefined(level.vtol.totalrockethits) && isdefined(level.vtol.missiletodestroy))
					{
						self settargetedmissilesremaining(weapon, level.vtol.missiletodestroy - level.vtol.totalrockethits);
					}
					else
					{
						maxhealth = [[level.killstreakmaxhealthfunction]](killstreaktype);
						damagetaken = target.damagetaken;
						if(!isdefined(damagetaken) && isdefined(target.parentstruct))
						{
							damagetaken = target.parentstruct.damagetaken;
						}
						if(isdefined(target.missiletrackdamage))
						{
							damagetaken = target.missiletrackdamage;
						}
						if(isdefined(damagetaken) && isdefined(maxhealth))
						{
							rocketstokill = level.killstreakbundle[killstreaktype].ksrocketstokill;
							if(level.var_71c35c9f && isdefined(level.killstreakbundle[killstreaktype].var_b744074b) && level.killstreakbundle[killstreaktype].var_b744074b != 0)
							{
								rocketstokill = level.killstreakbundle[killstreaktype].var_b744074b;
							}
							damageperrocket = (maxhealth / rocketstokill) + 1;
							remaininghealth = maxhealth - damagetaken;
							if(remaininghealth > 0)
							{
								missilesremaining = int(ceil(remaininghealth / damageperrocket));
								if(isdefined(target.numflares) && target.numflares > 0)
								{
									missilesremaining = missilesremaining + target.numflares;
								}
								if(isdefined(target.flak_drone))
								{
									missilesremaining = missilesremaining + 1;
								}
								self settargetedmissilesremaining(weapon, missilesremaining);
							}
						}
					}
				}
			}
		}
		else if(isdefined(level.callback_set_missiles_remaining))
		{
			self settargetedmissilesremaining(weapon, [[level.callback_set_missiles_remaining]](weapon, target));
		}
	}
}

/*
	Name: setfriendlyhacking
	Namespace: heatseekingmissile
	Checksum: 0x30D2F1DE
	Offset: 0x3380
	Size: 0xD4
	Parameters: 2
	Flags: Linked
*/
function setfriendlyhacking(weapon, target)
{
	if(level.teambased)
	{
		friendlyhackingmask = target.locking_on_hacking;
		if(isdefined(friendlyhackingmask) && self hasweapon(weapon))
		{
			friendlyhacking = 0;
			clientnum = self getentitynumber();
			friendlyhackingmask = friendlyhackingmask & (~(1 << clientnum));
			if(friendlyhackingmask != 0)
			{
				friendlyhacking = 1;
			}
			self setweaponfriendlyhacking(weapon, friendlyhacking);
		}
	}
}

/*
	Name: setfriendlytargetting
	Namespace: heatseekingmissile
	Checksum: 0x4D0490BA
	Offset: 0x3460
	Size: 0xD4
	Parameters: 2
	Flags: Linked
*/
function setfriendlytargetting(weapon, target)
{
	if(level.teambased)
	{
		friendlytargetingmask = target.locking_on;
		if(isdefined(friendlytargetingmask) && self hasweapon(weapon))
		{
			friendlytargeting = 0;
			clientnum = self getentitynumber();
			friendlytargetingmask = friendlytargetingmask & (~(1 << clientnum));
			if(friendlytargetingmask != 0)
			{
				friendlytargeting = 1;
			}
			self setweaponfriendlytargeting(weapon, friendlytargeting);
		}
	}
}

/*
	Name: setfriendlytargetlocked
	Namespace: heatseekingmissile
	Checksum: 0x78E54545
	Offset: 0x3540
	Size: 0xE4
	Parameters: 2
	Flags: Linked
*/
function setfriendlytargetlocked(weapon, target)
{
	if(level.teambased)
	{
		friendlytargetlocked = 0;
		friendlylockingonmask = target.locked_on;
		if(isdefined(friendlylockingonmask))
		{
			friendlytargetlocked = 0;
			clientnum = self getentitynumber();
			friendlylockingonmask = friendlylockingonmask & (~(1 << clientnum));
			if(friendlylockingonmask != 0)
			{
				friendlytargetlocked = 1;
			}
		}
		if(friendlytargetlocked == 0)
		{
			friendlytargetlocked = target missiletarget_isotherplayermissileincoming(self);
		}
		self setweaponfriendlytargetlocked(weapon, friendlytargetlocked);
	}
}

/*
	Name: watchclearlockedon
	Namespace: heatseekingmissile
	Checksum: 0xD4048BF5
	Offset: 0x3630
	Size: 0x76
	Parameters: 2
	Flags: Linked
*/
function watchclearlockedon(target, clientnum)
{
	self endon(#"locked_on_cleared");
	self waittill(#"death", #"disconnect");
	if(isdefined(target))
	{
		target.locked_on = target.locked_on & (~(1 << clientnum));
	}
}

/*
	Name: missiletarget_lockonmonitor
	Namespace: heatseekingmissile
	Checksum: 0x2E47D006
	Offset: 0x36B0
	Size: 0x250
	Parameters: 3
	Flags: None
*/
function missiletarget_lockonmonitor(player, endon1, endon2)
{
	self endon(#"death");
	if(isdefined(endon1))
	{
		self endon(endon1);
	}
	if(isdefined(endon2))
	{
		self endon(endon2);
	}
	for(;;)
	{
		if(target_istarget(self))
		{
			if(self missiletarget_ismissileincoming())
			{
				self clientfield::set("heli_warn_fired", 1);
				self clientfield::set("heli_warn_locked", 0);
				self clientfield::set("heli_warn_targeted", 0);
			}
			else
			{
				if(isdefined(self.locked_on) && self.locked_on)
				{
					self clientfield::set("heli_warn_locked", 1);
					self clientfield::set("heli_warn_fired", 0);
					self clientfield::set("heli_warn_targeted", 0);
				}
				else
				{
					if(isdefined(self.locking_on) && self.locking_on)
					{
						self clientfield::set("heli_warn_targeted", 1);
						self clientfield::set("heli_warn_fired", 0);
						self clientfield::set("heli_warn_locked", 0);
					}
					else
					{
						self clientfield::set("heli_warn_fired", 0);
						self clientfield::set("heli_warn_targeted", 0);
						self clientfield::set("heli_warn_locked", 0);
					}
				}
			}
		}
		wait(0.1);
	}
}

/*
	Name: _incomingmissile
	Namespace: heatseekingmissile
	Checksum: 0x7DB8576C
	Offset: 0x3908
	Size: 0x104
	Parameters: 2
	Flags: Linked
*/
function _incomingmissile(missile, attacker)
{
	if(!isdefined(self.incoming_missile))
	{
		self.incoming_missile = 0;
	}
	if(!isdefined(self.incoming_missile_owner))
	{
		self.incoming_missile_owner = [];
	}
	attacker_entnum = attacker getentitynumber();
	if(!isdefined(self.incoming_missile_owner[attacker_entnum]))
	{
		self.incoming_missile_owner[attacker_entnum] = 0;
	}
	self.incoming_missile++;
	self.incoming_missile_owner[attacker_entnum]++;
	if(isplayer(attacker))
	{
		attacker lockedon(self, 1);
	}
	self thread _incomingmissiletracker(missile, attacker);
	self thread _targetmissiletracker(missile, attacker);
}

/*
	Name: _targetmissiletracker
	Namespace: heatseekingmissile
	Checksum: 0x9559EDD
	Offset: 0x3A18
	Size: 0x84
	Parameters: 2
	Flags: Linked
*/
function _targetmissiletracker(missile, attacker)
{
	missile endon(#"death");
	self waittill(#"death");
	if(isdefined(attacker) && isplayer(attacker) && isdefined(self))
	{
		attacker lockedon(self, 0);
	}
}

/*
	Name: _incomingmissiletracker
	Namespace: heatseekingmissile
	Checksum: 0x1AA0850
	Offset: 0x3AA8
	Size: 0xFC
	Parameters: 2
	Flags: Linked
*/
function _incomingmissiletracker(missile, attacker)
{
	self endon(#"death");
	attacker_entnum = attacker getentitynumber();
	missile waittill(#"death");
	self.incoming_missile--;
	self.incoming_missile_owner[attacker_entnum]--;
	if(self.incoming_missile_owner[attacker_entnum] == 0)
	{
		self.incoming_missile_owner[attacker_entnum] = undefined;
	}
	if(isdefined(attacker) && isplayer(attacker))
	{
		attacker lockedon(self, 0);
	}
	/#
		assert(self.incoming_missile >= 0);
	#/
}

/*
	Name: missiletarget_ismissileincoming
	Namespace: heatseekingmissile
	Checksum: 0xFA5F86DD
	Offset: 0x3BB0
	Size: 0x26
	Parameters: 0
	Flags: Linked
*/
function missiletarget_ismissileincoming()
{
	if(!isdefined(self.incoming_missile))
	{
		return false;
	}
	if(self.incoming_missile)
	{
		return true;
	}
	return false;
}

/*
	Name: missiletarget_isotherplayermissileincoming
	Namespace: heatseekingmissile
	Checksum: 0x9062531E
	Offset: 0x3BE0
	Size: 0x80
	Parameters: 1
	Flags: Linked
*/
function missiletarget_isotherplayermissileincoming(attacker)
{
	if(!isdefined(self.incoming_missile_owner))
	{
		return false;
	}
	if(self.incoming_missile_owner.size == 0)
	{
		return false;
	}
	attacker_entnum = attacker getentitynumber();
	if(self.incoming_missile_owner.size == 1 && isdefined(self.incoming_missile_owner[attacker_entnum]))
	{
		return false;
	}
	return true;
}

/*
	Name: missiletarget_handleincomingmissile
	Namespace: heatseekingmissile
	Checksum: 0xF27B8005
	Offset: 0x3C68
	Size: 0x108
	Parameters: 4
	Flags: Linked
*/
function missiletarget_handleincomingmissile(responsefunc, endon1, endon2, allowdirectdamage)
{
	level endon(#"game_ended");
	self endon(#"death");
	if(isdefined(endon1))
	{
		self endon(endon1);
	}
	if(isdefined(endon2))
	{
		self endon(endon2);
	}
	for(;;)
	{
		waitresult = undefined;
		waitresult = self waittill(#"stinger_fired_at_me");
		_incomingmissile(waitresult.projectile, waitresult.attacker);
		if(isdefined(responsefunc))
		{
			[[responsefunc]](waitresult.projectile, waitresult.attacker, waitresult.weapon, endon1, endon2, allowdirectdamage);
		}
	}
}

/*
	Name: missiletarget_proximitydetonateincomingmissile
	Namespace: heatseekingmissile
	Checksum: 0x711BB188
	Offset: 0x3D78
	Size: 0x44
	Parameters: 3
	Flags: None
*/
function missiletarget_proximitydetonateincomingmissile(endon1, endon2, allowdirectdamage)
{
	missiletarget_handleincomingmissile(&missiletarget_proximitydetonate, endon1, endon2, allowdirectdamage);
}

/*
	Name: _missiledetonate
	Namespace: heatseekingmissile
	Checksum: 0x27BA9C16
	Offset: 0x3DC8
	Size: 0x1EC
	Parameters: 6
	Flags: Linked
*/
function _missiledetonate(attacker, weapon, range, mindamage, maxdamage, allowdirectdamage)
{
	origin = self.origin;
	target = self missile_gettarget();
	self detonate();
	if(allowdirectdamage === 1 && isdefined(target) && isdefined(target.origin))
	{
		mindistsq = (isdefined(target.locked_missile_min_distsq) ? target.locked_missile_min_distsq : range * range);
		distsq = distancesquared(self.origin, target.origin);
		if(distsq < mindistsq)
		{
			target dodamage(maxdamage, origin, attacker, self, "none", "MOD_PROJECTILE", 0, weapon);
		}
	}
	var_fd0cb0de = attacker;
	if(function_3132f113(attacker) || (isdefined(attacker) && !isplayer(attacker) && !isalive(attacker)))
	{
		var_fd0cb0de = undefined;
	}
	radiusdamage(origin, range, maxdamage, mindamage, var_fd0cb0de, "MOD_PROJECTILE_SPLASH", weapon);
}

/*
	Name: missiletarget_proximitydetonate
	Namespace: heatseekingmissile
	Checksum: 0x1D620549
	Offset: 0x3FC0
	Size: 0x360
	Parameters: 6
	Flags: Linked
*/
function missiletarget_proximitydetonate(missile, attacker, weapon, endon1, endon2, allowdirectdamage)
{
	level endon(#"game_ended");
	missile endon(#"death");
	if(isdefined(endon1))
	{
		self endon(endon1);
	}
	if(isdefined(endon2))
	{
		self endon(endon2);
	}
	mindist = distancesquared(missile.origin, self.origin);
	lastcenter = self.origin;
	missile missile_settarget(self, (isdefined(target_getoffset(self)) ? target_getoffset(self) : (0, 0, 0)));
	if(isdefined(self.missiletargetmissdistance))
	{
		misseddistancesq = self.missiletargetmissdistance * self.missiletargetmissdistance;
	}
	else
	{
		misseddistancesq = 250000;
	}
	flaredistancesq = 12250000;
	for(;;)
	{
		if(!isdefined(self))
		{
			center = lastcenter;
		}
		else
		{
			center = self.origin;
		}
		lastcenter = center;
		curdist = distancesquared(missile.origin, center);
		if(curdist < flaredistancesq && isdefined(self.numflares) && self.numflares > 0)
		{
			self.numflares--;
			self thread missiletarget_playflarefx();
			self challenges::trackassists(attacker, 0, 1);
			newtarget = self missiletarget_deployflares(missile.origin, missile.angles);
			missile missile_settarget(newtarget, (isdefined(target_getoffset(newtarget)) ? target_getoffset(newtarget) : (0, 0, 0)));
			missiletarget = newtarget;
			scoreevents::processscoreevent(#"hash_74973027b2bb47ef", attacker, undefined, weapon);
			self notify(#"hash_63404ad70a51f8ca");
			return;
		}
		if(curdist < mindist)
		{
			mindist = curdist;
		}
		if(curdist > mindist)
		{
			if(curdist > misseddistancesq)
			{
				return;
			}
			missile thread _missiledetonate(attacker, weapon, 500, 600, 600, allowdirectdamage);
			return;
		}
		waitframe(1);
	}
}

/*
	Name: missiletarget_playflarefx
	Namespace: heatseekingmissile
	Checksum: 0xED28E40A
	Offset: 0x4328
	Size: 0x104
	Parameters: 2
	Flags: Linked
*/
function missiletarget_playflarefx(flare_fx, tag_origin)
{
	if(!isdefined(self))
	{
		return;
	}
	if(!isdefined(flare_fx))
	{
		if(isdefined(self.fx_flare))
		{
			flare_fx = self.fx_flare;
		}
		else
		{
			flare_fx = level.fx_flare;
		}
	}
	if(!isdefined(tag_origin))
	{
		tag_origin = "tag_origin";
	}
	if(isdefined(self.flare_ent))
	{
		playfxontag(flare_fx, self.flare_ent, tag_origin);
	}
	else
	{
		playfxontag(flare_fx, self, tag_origin);
	}
	if(isdefined(self.owner))
	{
		self playsoundtoplayer(#"veh_huey_chaff_drop_plr", self.owner);
	}
	self playsound(#"veh_huey_chaff_explo_npc");
}

/*
	Name: missiletarget_deployflares
	Namespace: heatseekingmissile
	Checksum: 0x702C02EB
	Offset: 0x4438
	Size: 0x2A0
	Parameters: 2
	Flags: Linked
*/
function missiletarget_deployflares(origin, angles)
{
	vec_toforward = anglestoforward(self.angles);
	vec_toright = anglestoright(self.angles);
	vec_tomissileforward = anglestoforward(angles);
	delta = self.origin - origin;
	dot = vectordot(vec_tomissileforward, vec_toright);
	sign = 1;
	if(dot > 0)
	{
		sign = -1;
	}
	flare_dir = vectornormalize((vectorscale(vec_toforward, -0.5)) + vectorscale(vec_toright, sign));
	velocity = vectorscale(flare_dir, randomintrange(200, 400));
	velocity = (velocity[0], velocity[1], velocity[2] - randomintrange(10, 100));
	flareorigin = self.origin;
	flareorigin = flareorigin + vectorscale(flare_dir, randomintrange(600, 800));
	flareorigin = flareorigin + vectorscale((0, 0, 1), 500);
	if(isdefined(self.flareoffset))
	{
		flareorigin = flareorigin + self.flareoffset;
	}
	flareobject = spawn("script_origin", flareorigin);
	flareobject.angles = self.angles;
	flareobject setmodel(#"tag_origin");
	flareobject movegravity(velocity, 5);
	flareobject thread util::deleteaftertime(5);
	/#
		self thread debug_tracker(flareobject);
	#/
	return flareobject;
}

/*
	Name: debug_tracker
	Namespace: heatseekingmissile
	Checksum: 0x225E89B5
	Offset: 0x46E0
	Size: 0x5E
	Parameters: 1
	Flags: None
*/
function debug_tracker(target)
{
	/#
		target endon(#"death");
		while(true)
		{
			dev::debug_sphere(target.origin, 10, (1, 0, 0), 1, 1);
			waitframe(1);
		}
	#/
}

