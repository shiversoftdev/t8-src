// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\heatseekingmissile.gsc;
#using scripts\core_common\player\player_stats.gsc;
#using scripts\killstreaks\killstreaks_util.gsc;
#using scripts\killstreaks\killstreaks_shared.gsc;
#using scripts\weapons\weaponobjects.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace hacker_tool;

/*
	Name: init_shared
	Namespace: hacker_tool
	Checksum: 0x7F602A14
	Offset: 0x100
	Size: 0x184
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	level.weaponhackertool = getweapon(#"pda_hack");
	level.hackertoollostsightlimitms = 1000;
	level.hackertoollockonradius = 25;
	level.hackertoollockonfov = 65;
	level.hackertoolhacktimems = 0.4;
	level.equipmenthackertoolradius = 20;
	level.equipmenthackertooltimems = 100;
	level.carepackagehackertoolradius = 60;
	level.carepackagehackertooltimems = getgametypesetting(#"cratecapturetime") * 500;
	level.carepackagefriendlyhackertooltimems = getgametypesetting(#"cratecapturetime") * 2000;
	level.carepackageownerhackertooltimems = 250;
	level.vehiclehackertoolradius = 80;
	level.vehiclehackertooltimems = 5000;
	clientfield::register("toplayer", "hacker_tool", 1, 2, "int");
	callback::on_spawned(&on_player_spawned);
}

/*
	Name: on_player_spawned
	Namespace: hacker_tool
	Checksum: 0x3BF4F91
	Offset: 0x290
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function on_player_spawned()
{
	self endon(#"disconnect");
	self clearhackertarget(undefined, 0, 1);
	self thread watchhackertoolfired();
}

/*
	Name: clearhackertarget
	Namespace: hacker_tool
	Checksum: 0xAEF5989C
	Offset: 0x2E8
	Size: 0x204
	Parameters: 3
	Flags: None
*/
function clearhackertarget(weapon, successfulhack, spawned)
{
	self notify(#"stop_lockon_sound");
	self notify(#"stop_locked_sound");
	self notify(#"clearhackertarget");
	self.stingerlocksound = undefined;
	self stoprumble("stinger_lock_rumble");
	self.hackertoollockstarttime = 0;
	self.hackertoollockstarted = 0;
	self.hackertoollockfinalized = 0;
	self.hackertoollocktimeelapsed = 0;
	if(isdefined(weapon))
	{
		self setweaponhackpercent(weapon, 0);
		if(isdefined(self.hackertooltarget))
		{
			heatseekingmissile::setfriendlyflags(weapon, self.hackertooltarget);
		}
	}
	if(successfulhack == 0)
	{
		if(spawned == 0)
		{
			if(isdefined(self.hackertooltarget))
			{
				self playsoundtoplayer(#"evt_hacker_hack_lost", self);
			}
		}
		self clientfield::set_to_player("hacker_tool", 0);
		self stophackertoolsoundloop();
	}
	if(isdefined(self.hackertooltarget))
	{
		heatseekingmissile::targetinghacking(self.hackertooltarget, 0);
	}
	self.hackertooltarget = undefined;
	self weaponlockfree();
	self weaponlocktargettooclose(0);
	self weaponlocknoclearance(0);
	/#
		self heatseekingmissile::destroylockoncanceledmessage();
	#/
}

/*
	Name: watchhackertoolfired
	Namespace: hacker_tool
	Checksum: 0x6E0ECC7B
	Offset: 0x4F8
	Size: 0x6E8
	Parameters: 0
	Flags: None
*/
function watchhackertoolfired()
{
	self endon(#"disconnect", #"death", #"killhackermonitor");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"hacker_tool_fired");
		hackertooltarget = waitresult.target;
		weapon = waitresult.weapon;
		if(isdefined(hackertooltarget))
		{
			if(isentityhackablecarepackage(hackertooltarget))
			{
				scoreevents::givecratecapturemedal(hackertooltarget, self);
				hackertooltarget notify(#"captured", {#is_remote_hack:1, #player:self});
				if(isdefined(hackertooltarget.owner) && isplayer(hackertooltarget.owner) && hackertooltarget.owner.team != self.team)
				{
					hackertooltarget.owner killstreaks::play_killstreak_hacked_dialog(hackertooltarget.killstreaktype, hackertooltarget.killstreakid, self);
				}
			}
			else
			{
				if(isentityhackableweaponobject(hackertooltarget) && isdefined(hackertooltarget.hackertrigger))
				{
					hackertooltarget.hackertrigger notify(#"trigger", {#dropped_item:1, #activator:self});
					hackertooltarget.previouslyhacked = 1;
					self.throwinggrenade = 0;
				}
				else
				{
					if(isdefined(hackertooltarget.killstreak_hackedcallback) && (!isdefined(hackertooltarget.killstreaktimedout) || hackertooltarget.killstreaktimedout == 0))
					{
						if(hackertooltarget.killstreak_hackedprotection == 0)
						{
							if(isdefined(hackertooltarget.owner) && isplayer(hackertooltarget.owner))
							{
								hackertooltarget.owner killstreaks::play_killstreak_hacked_dialog(hackertooltarget.killstreaktype, hackertooltarget.killstreakid, self);
							}
							self playsoundtoplayer(#"evt_hacker_fw_success", self);
							hackertooltarget notify(#"killstreak_hacked", {#hacker:self});
							hackertooltarget.previouslyhacked = 1;
							hackertooltarget [[hackertooltarget.killstreak_hackedcallback]](self);
							if(self util::has_blind_eye_perk_purchased_and_equipped() || self util::has_hacker_perk_purchased_and_equipped())
							{
								self stats::function_dad108fa(#"hack_streak_with_blindeye_or_engineer", 1);
							}
						}
						else
						{
							if(isdefined(hackertooltarget.owner) && isplayer(hackertooltarget.owner))
							{
								self.hackertooltarget.owner killstreaks::play_killstreak_firewall_hacked_dialog(self.hackertooltarget.killstreaktype, self.hackertooltarget.killstreakid);
							}
							self playsoundtoplayer(#"evt_hacker_ks_success", self);
							scoreevents::processscoreevent(#"hacked_killstreak_protection", self, hackertooltarget, level.weaponhackertool);
						}
						hackertooltarget.killstreak_hackedprotection = 0;
					}
					else
					{
						if(isdefined(hackertooltarget.classname) && hackertooltarget.classname == "grenade")
						{
							damage = 1;
						}
						else
						{
							if(isdefined(hackertooltarget.hackertooldamage))
							{
								damage = hackertooltarget.hackertooldamage;
							}
							else
							{
								if(isdefined(hackertooltarget.maxhealth))
								{
									damage = hackertooltarget.maxhealth + 1;
								}
								else
								{
									damage = 999999;
								}
							}
						}
						if(isdefined(hackertooltarget.numflares) && hackertooltarget.numflares > 0)
						{
							damage = 1;
							hackertooltarget.numflares--;
							hackertooltarget heatseekingmissile::missiletarget_playflarefx();
						}
						hackertooltarget dodamage(damage, self.origin, self, self, 0, "MOD_UNKNOWN", 0, weapon);
					}
				}
			}
			if(self util::is_item_purchased(#"pda_hack"))
			{
				self stats::function_dad108fa(#"hack_enemy_target", 1);
			}
			self stats::function_e24eec31(weapon, #"used", 1);
		}
		clearhackertarget(weapon, 1, 0);
		self forceoffhandend();
		/#
			if(getdvarint(#"player_sustainammo", 0) == 0)
			{
				clip_ammo = self getweaponammoclip(weapon);
				clip_ammo--;
				/#
					/#
						assert(clip_ammo >= 0);
					#/
				#/
				self setweaponammoclip(weapon, clip_ammo);
			}
		#/
		self killstreaks::switch_to_last_non_killstreak_weapon();
	}
}

/*
	Name: function_f4068d35
	Namespace: hacker_tool
	Checksum: 0x64F68BBA
	Offset: 0xBE8
	Size: 0x124
	Parameters: 1
	Flags: Event
*/
event function_f4068d35(eventstruct)
{
	if(!isplayer(self))
	{
		return;
	}
	weapon = eventstruct.weapon;
	if(isdefined(level.weaponhackertool) && weapon.rootweapon == level.weaponhackertool)
	{
		waitframe(1);
		currentoffhand = self getcurrentoffhand();
		if(self isusingoffhand() && currentoffhand.rootweapon == level.weaponhackertool)
		{
			self thread hackertooltargetloop(weapon);
			self thread watchhackertoolend(weapon);
			self thread watchforgrenadefire(weapon);
			self thread watchhackertoolinterrupt(weapon);
		}
	}
}

/*
	Name: watchhackertoolinterrupt
	Namespace: hacker_tool
	Checksum: 0xE89C39A8
	Offset: 0xD18
	Size: 0xCE
	Parameters: 1
	Flags: None
*/
function watchhackertoolinterrupt(weapon)
{
	self endon(#"disconnect", #"hacker_tool_fired", #"death", #"weapon_change", #"grenade_fire");
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(#"use_interrupt");
		if(self.hackertooltarget == waitresult.target)
		{
			clearhackertarget(weapon, 0, 0);
		}
		waitframe(1);
	}
}

/*
	Name: watchhackertoolend
	Namespace: hacker_tool
	Checksum: 0x44C70472
	Offset: 0xDF0
	Size: 0xC4
	Parameters: 1
	Flags: None
*/
function watchhackertoolend(weapon)
{
	self endon(#"disconnect", #"hacker_tool_fired");
	self waittill(#"weapon_change", #"death", #"hacker_tool_fired", #"disconnect");
	clearhackertarget(weapon, 0, 0);
	self clientfield::set_to_player("hacker_tool", 0);
	self stophackertoolsoundloop();
}

/*
	Name: watchforgrenadefire
	Namespace: hacker_tool
	Checksum: 0x3AC9E5FD
	Offset: 0xEC0
	Size: 0x164
	Parameters: 1
	Flags: None
*/
function watchforgrenadefire(weapon)
{
	self endon(#"disconnect", #"hacker_tool_fired", #"weapon_change", #"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"grenade_fire");
		grenade_instance = waitresult.projectile;
		grenade_weapon = waitresult.weapon;
		respawnfromhack = waitresult.respawn_from_hack;
		if(isdefined(respawnfromhack) && respawnfromhack)
		{
			continue;
		}
		clearhackertarget(grenade_weapon, 0, 0);
		clip_ammo = self getweaponammoclip(grenade_weapon);
		clip_max_ammo = grenade_weapon.clipsize;
		if(clip_ammo < clip_max_ammo)
		{
			clip_ammo++;
		}
		self setweaponammoclip(grenade_weapon, clip_ammo);
		break;
	}
}

/*
	Name: playhackertoolsoundloop
	Namespace: hacker_tool
	Checksum: 0x3817D864
	Offset: 0x1030
	Size: 0x6E
	Parameters: 0
	Flags: None
*/
function playhackertoolsoundloop()
{
	if(!isdefined(self.hacker_sound_ent) || (isdefined(self.hacker_alreadyhacked) && self.hacker_alreadyhacked == 1))
	{
		self playloopsound(#"evt_hacker_device_loop");
		self.hacker_sound_ent = 1;
		self.hacker_alreadyhacked = 0;
	}
}

/*
	Name: stophackertoolsoundloop
	Namespace: hacker_tool
	Checksum: 0xA3D4AF9
	Offset: 0x10A8
	Size: 0x36
	Parameters: 0
	Flags: None
*/
function stophackertoolsoundloop()
{
	self stoploopsound(0.5);
	self.hacker_sound_ent = undefined;
	self.hacker_alreadyhacked = undefined;
}

/*
	Name: hackertooltargetloop
	Namespace: hacker_tool
	Checksum: 0xF2ABBDEC
	Offset: 0x10E8
	Size: 0x980
	Parameters: 1
	Flags: None
*/
function hackertooltargetloop(weapon)
{
	self endon(#"disconnect", #"death", #"weapon_change", #"grenade_fire");
	self clientfield::set_to_player("hacker_tool", 1);
	self playhackertoolsoundloop();
	while(true)
	{
		waitframe(1);
		waitframe(1);
		if(self.hackertoollockfinalized)
		{
			if(!self isvalidhackertooltarget(self.hackertooltarget, weapon, 0))
			{
				self clearhackertarget(weapon, 0, 0);
				continue;
			}
			passed = self hackersoftsighttest(weapon);
			if(!passed)
			{
				continue;
			}
			self clientfield::set_to_player("hacker_tool", 0);
			self stophackertoolsoundloop();
			heatseekingmissile::targetinghacking(self.hackertooltarget, 0);
			heatseekingmissile::setfriendlyflags(weapon, self.hackertooltarget);
			thread heatseekingmissile::looplocallocksound(game.locked_on_sound, 0.75);
			self notify(#"hacker_tool_fired", {#weapon:weapon, #target:self.hackertooltarget});
			return;
		}
		if(self.hackertoollockstarted)
		{
			if(!self isvalidhackertooltarget(self.hackertooltarget, weapon, 0))
			{
				self clearhackertarget(weapon, 0, 0);
				continue;
			}
			lockontime = self getlockontime(self.hackertooltarget, weapon);
			if(lockontime == 0)
			{
				self clearhackertarget(weapon, 0, 0);
				continue;
			}
			if(self.hackertoollocktimeelapsed == 0)
			{
				self playlocalsound(#"evt_hacker_hacking");
				if(isdefined(self.hackertooltarget.owner) && isplayer(self.hackertooltarget.owner))
				{
					if(isdefined(self.hackertooltarget.killstreak_hackedcallback) && (!isdefined(self.hackertooltarget.killstreaktimedout) || self.hackertooltarget.killstreaktimedout == 0))
					{
						if(self.hackertooltarget.killstreak_hackedprotection == 0)
						{
							self.hackertooltarget.owner killstreaks::play_killstreak_being_hacked_dialog(self.hackertooltarget.killstreaktype, self.hackertooltarget.killstreakid);
						}
						else
						{
							self.hackertooltarget.owner killstreaks::play_killstreak_firewall_being_hacked_dialog(self.hackertooltarget.killstreaktype, self.hackertooltarget.killstreakid);
						}
					}
				}
			}
			self weaponlockstart(self.hackertooltarget);
			self playhackertoolsoundloop();
			if(isdefined(self.hackertooltarget.killstreak_hackedprotection) && self.hackertooltarget.killstreak_hackedprotection == 1)
			{
				self clientfield::set_to_player("hacker_tool", 3);
			}
			else
			{
				self clientfield::set_to_player("hacker_tool", 2);
			}
			heatseekingmissile::targetinghacking(self.hackertooltarget, 1);
			heatseekingmissile::setfriendlyflags(weapon, self.hackertooltarget);
			passed = self hackersoftsighttest(weapon);
			if(!passed)
			{
				continue;
			}
			if(self.hackertoollostsightlinetime == 0)
			{
				self.hackertoollocktimeelapsed = self.hackertoollocktimeelapsed + (0.1 * hackingtimescale(self.hackertooltarget));
				hackpercentage = (self.hackertoollocktimeelapsed / lockontime) * 100;
				self setweaponhackpercent(weapon, hackpercentage);
				heatseekingmissile::setfriendlyflags(weapon, self.hackertooltarget);
			}
			else
			{
				self.hackertoollocktimeelapsed = self.hackertoollocktimeelapsed - (0.1 * hackingtimenolineofsightscale(self.hackertooltarget));
				if(self.hackertoollocktimeelapsed < 0)
				{
					self.hackertoollocktimeelapsed = 0;
					self clearhackertarget(weapon, 0, 0);
					continue;
				}
				hackpercentage = (self.hackertoollocktimeelapsed / lockontime) * 100;
				self setweaponhackpercent(weapon, hackpercentage);
				heatseekingmissile::setfriendlyflags(weapon, self.hackertooltarget);
			}
			if(self.hackertoollocktimeelapsed < lockontime)
			{
				continue;
			}
			/#
				assert(isdefined(self.hackertooltarget));
			#/
			self notify(#"stop_lockon_sound");
			self.hackertoollockfinalized = 1;
			self weaponlockfinalize(self.hackertooltarget);
			continue;
		}
		if(self isempjammed())
		{
			/#
				self heatseekingmissile::destroylockoncanceledmessage();
			#/
			continue;
		}
		besttarget = self getbesthackertooltarget(weapon);
		if(!isdefined(besttarget))
		{
			self stophackertoolsoundloop();
			/#
				self heatseekingmissile::destroylockoncanceledmessage();
			#/
			continue;
		}
		if(!self heatseekingmissile::locksighttest(besttarget))
		{
			self stophackertoolsoundloop();
			/#
				self heatseekingmissile::destroylockoncanceledmessage();
			#/
			continue;
		}
		if(self heatseekingmissile::locksighttest(besttarget) && isdefined(besttarget.lockondelay) && besttarget.lockondelay)
		{
			self stophackertoolsoundloop();
			/#
				self heatseekingmissile::displaylockoncanceledmessage();
			#/
			continue;
		}
		/#
			self heatseekingmissile::destroylockoncanceledmessage();
		#/
		if(isentitypreviouslyhacked(besttarget))
		{
			if(!isdefined(self.hacker_sound_ent) || (isdefined(self.hacker_alreadyhacked) && self.hacker_alreadyhacked == 0))
			{
				self.hacker_sound_ent = 1;
				self.hacker_alreadyhacked = 1;
				self playloopsound(#"evt_hacker_unhackable_loop");
			}
			continue;
		}
		else
		{
			self stophackertoolsoundloop();
		}
		heatseekingmissile::initlockfield(besttarget);
		self.hackertooltarget = besttarget;
		self thread watchtargetentityupdate(besttarget);
		self.hackertoollockstarttime = gettime();
		self.hackertoollockstarted = 1;
		self.hackertoollostsightlinetime = 0;
		self.hackertoollocktimeelapsed = 0;
		self setweaponhackpercent(weapon, 0);
		if(isdefined(self.hackertooltarget))
		{
			heatseekingmissile::setfriendlyflags(weapon, self.hackertooltarget);
		}
	}
}

/*
	Name: watchtargetentityupdate
	Namespace: hacker_tool
	Checksum: 0x802E5C4
	Offset: 0x1A70
	Size: 0xCE
	Parameters: 1
	Flags: None
*/
function watchtargetentityupdate(besttarget)
{
	self endon(#"death", #"disconnect");
	self notify(#"watchtargetentityupdate");
	self endon(#"watchtargetentityupdate", #"clearhackertarget");
	besttarget endon(#"death");
	waitresult = undefined;
	waitresult = besttarget waittill(#"hackertool_update_ent");
	heatseekingmissile::initlockfield(waitresult.entity);
	self.hackertooltarget = waitresult.entity;
}

/*
	Name: getbesthackertooltarget
	Namespace: hacker_tool
	Checksum: 0xF5D36B3B
	Offset: 0x1B48
	Size: 0x35E
	Parameters: 1
	Flags: None
*/
function getbesthackertooltarget(weapon)
{
	targetsvalid = [];
	targetsall = arraycombine(target_getarray(), level.missileentities, 0, 0);
	targetsall = arraycombine(targetsall, level.hackertooltargets, 0, 0);
	for(idx = 0; idx < targetsall.size; idx++)
	{
		target_ent = targetsall[idx];
		if(!isdefined(target_ent) || !isdefined(target_ent.owner))
		{
			continue;
		}
		/#
			if(getdvarint(#"scr_freelock", 0) == 1)
			{
				if(self iswithinhackertoolreticle(targetsall[idx], weapon))
				{
					targetsvalid[targetsvalid.size] = targetsall[idx];
				}
				continue;
			}
		#/
		if(level.teambased || level.use_team_based_logic_for_locking_on === 1)
		{
			if(isentityhackablecarepackage(target_ent))
			{
				if(self cantargetentity(target_ent, weapon))
				{
					targetsvalid[targetsvalid.size] = target_ent;
				}
			}
			else
			{
				if(isdefined(target_ent.team))
				{
					if(target_ent.team != self.team)
					{
						if(self cantargetentity(target_ent, weapon))
						{
							targetsvalid[targetsvalid.size] = target_ent;
						}
					}
				}
				else if(isdefined(target_ent.owner.team))
				{
					if(target_ent.owner.team != self.team)
					{
						if(self cantargetentity(target_ent, weapon))
						{
							targetsvalid[targetsvalid.size] = target_ent;
						}
					}
				}
			}
			continue;
		}
		if(self iswithinhackertoolreticle(target_ent, weapon))
		{
			if(isentityhackablecarepackage(target_ent))
			{
				if(self cantargetentity(target_ent, weapon))
				{
					targetsvalid[targetsvalid.size] = target_ent;
				}
				continue;
			}
			if(isdefined(target_ent.owner) && self != target_ent.owner)
			{
				if(self cantargetentity(target_ent, weapon))
				{
					targetsvalid[targetsvalid.size] = target_ent;
				}
			}
		}
	}
	chosenent = undefined;
	if(targetsvalid.size != 0)
	{
		chosenent = targetsvalid[0];
	}
	return chosenent;
}

/*
	Name: cantargetentity
	Namespace: hacker_tool
	Checksum: 0xEDC43D6D
	Offset: 0x1EB0
	Size: 0x5E
	Parameters: 2
	Flags: None
*/
function cantargetentity(target, weapon)
{
	if(!self iswithinhackertoolreticle(target, weapon))
	{
		return false;
	}
	if(!isvalidhackertooltarget(target, weapon, 1))
	{
		return false;
	}
	return true;
}

/*
	Name: iswithinhackertoolreticle
	Namespace: hacker_tool
	Checksum: 0xBD1AD08C
	Offset: 0x1F18
	Size: 0xAA
	Parameters: 2
	Flags: None
*/
function iswithinhackertoolreticle(target, weapon)
{
	radiusinner = gethackertoolinnerradius(target);
	radiusouter = gethackertoolouterradius(target);
	if(target_scaleminmaxradius(target, self, level.hackertoollockonfov, radiusinner, radiusouter) > 0)
	{
		return 1;
	}
	return target_boundingisunderreticle(self, target, weapon.lockonmaxrange);
}

/*
	Name: hackingtimescale
	Namespace: hacker_tool
	Checksum: 0xD54A9938
	Offset: 0x1FD0
	Size: 0x1C0
	Parameters: 1
	Flags: None
*/
function hackingtimescale(target)
{
	hackratio = 1;
	radiusinner = gethackertoolinnerradius(target);
	radiusouter = gethackertoolouterradius(target);
	if(radiusinner != radiusouter)
	{
		scale = target_scaleminmaxradius(target, self, level.hackertoollockonfov, radiusinner, radiusouter);
		hacktime = lerpfloat(gethackoutertime(target), gethacktime(target), scale);
		/#
			hackertooldebugtext = getdvarint(#"hackertooldebugtext", 0);
			if(hackertooldebugtext)
			{
				print3d(target.origin, (((("" + scale) + "") + radiusinner) + "") + radiusouter, (0, 0, 0), 1, hackertooldebugtext, 2);
			}
			/#
				assert(hacktime > 0);
			#/
		#/
		hackratio = gethacktime(target) / hacktime;
		if(!isdefined(hackratio))
		{
			hackratio = 1;
		}
	}
	return hackratio;
}

/*
	Name: hackingtimenolineofsightscale
	Namespace: hacker_tool
	Checksum: 0x399B73D1
	Offset: 0x2198
	Size: 0x7C
	Parameters: 1
	Flags: None
*/
function hackingtimenolineofsightscale(target)
{
	hackratio = 1;
	if(isdefined(target.killstreakhacklostlineofsighttimems) && target.killstreakhacklostlineofsighttimems > 0)
	{
		/#
			/#
				assert(target.killstreakhacklostlineofsighttimems > 0);
			#/
		#/
		hackratio = 1000 / target.killstreakhacklostlineofsighttimems;
	}
	return hackratio;
}

/*
	Name: isentityhackableweaponobject
	Namespace: hacker_tool
	Checksum: 0x66DF85CB
	Offset: 0x2220
	Size: 0xD4
	Parameters: 1
	Flags: None
*/
function isentityhackableweaponobject(entity)
{
	if(isdefined(entity.classname) && entity.classname == "grenade")
	{
		if(isdefined(entity.weapon))
		{
			watcher = weaponobjects::getweaponobjectwatcherbyweapon(entity.weapon);
			if(isdefined(watcher))
			{
				if(watcher.hackable)
				{
					/#
						/#
							assert(isdefined(watcher.hackertoolradius));
						#/
						/#
							assert(isdefined(watcher.hackertooltimems));
						#/
					#/
					return true;
				}
			}
		}
	}
	return false;
}

/*
	Name: getweaponobjecthackerradius
	Namespace: hacker_tool
	Checksum: 0x5752E22D
	Offset: 0x2300
	Size: 0xC6
	Parameters: 1
	Flags: None
*/
function getweaponobjecthackerradius(entity)
{
	/#
		/#
			assert(isdefined(entity.classname));
		#/
		/#
			assert(isdefined(entity.weapon));
		#/
	#/
	watcher = weaponobjects::getweaponobjectwatcherbyweapon(entity.weapon);
	/#
		/#
			assert(watcher.hackable);
		#/
		/#
			assert(isdefined(watcher.hackertoolradius));
		#/
	#/
	return watcher.hackertoolradius;
}

/*
	Name: getweaponobjecthacktimems
	Namespace: hacker_tool
	Checksum: 0x10A31021
	Offset: 0x23D0
	Size: 0xC6
	Parameters: 1
	Flags: None
*/
function getweaponobjecthacktimems(entity)
{
	/#
		/#
			assert(isdefined(entity.classname));
		#/
		/#
			assert(isdefined(entity.weapon));
		#/
	#/
	watcher = weaponobjects::getweaponobjectwatcherbyweapon(entity.weapon);
	/#
		/#
			assert(watcher.hackable);
		#/
		/#
			assert(isdefined(watcher.hackertooltimems));
		#/
	#/
	return watcher.hackertooltimems;
}

/*
	Name: isentityhackablecarepackage
	Namespace: hacker_tool
	Checksum: 0x8696DE81
	Offset: 0x24A0
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function isentityhackablecarepackage(entity)
{
	if(isdefined(entity.model))
	{
		return entity.model == #"wpn_t7_care_package_world";
	}
	return 0;
}

/*
	Name: isvalidhackertooltarget
	Namespace: hacker_tool
	Checksum: 0x2B938EF5
	Offset: 0x24E8
	Size: 0x160
	Parameters: 3
	Flags: None
*/
function isvalidhackertooltarget(ent, weapon, allowhacked)
{
	if(!isdefined(ent))
	{
		return false;
	}
	if(self util::isusingremote())
	{
		return false;
	}
	if(self isempjammed())
	{
		return false;
	}
	if(!(target_istarget(ent) || (isdefined(ent.allowhackingaftercloak) && ent.allowhackingaftercloak == 1)) && !isentityhackableweaponobject(ent) && !isinarray(level.hackertooltargets, ent))
	{
		return false;
	}
	if(isentityhackableweaponobject(ent))
	{
		if(distancesquared(self.origin, ent.origin) > weapon.lockonmaxrange * weapon.lockonmaxrange)
		{
			return false;
		}
	}
	if(allowhacked == 0 && isentitypreviouslyhacked(ent))
	{
		return false;
	}
	return true;
}

/*
	Name: isentitypreviouslyhacked
	Namespace: hacker_tool
	Checksum: 0x8CE28CCC
	Offset: 0x2650
	Size: 0x34
	Parameters: 1
	Flags: None
*/
function isentitypreviouslyhacked(entity)
{
	if(isdefined(entity.previouslyhacked) && entity.previouslyhacked)
	{
		return true;
	}
	return false;
}

/*
	Name: hackersoftsighttest
	Namespace: hacker_tool
	Checksum: 0x7781F40A
	Offset: 0x2690
	Size: 0x196
	Parameters: 1
	Flags: None
*/
function hackersoftsighttest(weapon)
{
	passed = 1;
	lockontime = 0;
	if(isdefined(self.hackertooltarget))
	{
		lockontime = self getlockontime(self.hackertooltarget, weapon);
	}
	if(lockontime == 0 || self isempjammed())
	{
		self clearhackertarget(weapon, 0, 0);
		passed = 0;
	}
	else
	{
		if(iswithinhackertoolreticle(self.hackertooltarget, weapon) && self heatseekingmissile::locksighttest(self.hackertooltarget))
		{
			self.hackertoollostsightlinetime = 0;
		}
		else
		{
			if(self.hackertoollostsightlinetime == 0)
			{
				self.hackertoollostsightlinetime = gettime();
			}
			timepassed = gettime() - self.hackertoollostsightlinetime;
			lostlineofsighttimelimitmsec = level.hackertoollostsightlimitms;
			if(isdefined(self.hackertooltarget.killstreakhacklostlineofsightlimitms))
			{
				lostlineofsighttimelimitmsec = self.hackertooltarget.killstreakhacklostlineofsightlimitms;
			}
			if(timepassed >= lostlineofsighttimelimitmsec)
			{
				self clearhackertarget(weapon, 0, 0);
				passed = 0;
			}
		}
	}
	return passed;
}

/*
	Name: registerwithhackertool
	Namespace: hacker_tool
	Checksum: 0xB8462652
	Offset: 0x2830
	Size: 0xA6
	Parameters: 2
	Flags: None
*/
function registerwithhackertool(radius, hacktimems)
{
	self endon(#"death");
	if(isdefined(radius))
	{
		self.hackertoolradius = radius;
	}
	else
	{
		self.hackertoolradius = level.hackertoollockonradius;
	}
	if(isdefined(hacktimems))
	{
		self.hackertooltimems = hacktimems;
	}
	else
	{
		self.hackertooltimems = level.hackertoolhacktimems;
	}
	self thread watchhackableentitydeath();
	level.hackertooltargets[level.hackertooltargets.size] = self;
}

/*
	Name: watchhackableentitydeath
	Namespace: hacker_tool
	Checksum: 0xB9FD3CCF
	Offset: 0x28E0
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function watchhackableentitydeath()
{
	self waittill(#"death");
	arrayremovevalue(level.hackertooltargets, self);
}

/*
	Name: gethackertoolinnerradius
	Namespace: hacker_tool
	Checksum: 0xB1CC6920
	Offset: 0x2920
	Size: 0xEA
	Parameters: 1
	Flags: None
*/
function gethackertoolinnerradius(target)
{
	radius = level.hackertoollockonradius;
	if(isentityhackablecarepackage(target))
	{
		/#
			/#
				assert(isdefined(target.hackertoolradius));
			#/
		#/
		radius = target.hackertoolradius;
	}
	else
	{
		if(isentityhackableweaponobject(target))
		{
			radius = getweaponobjecthackerradius(target);
		}
		else
		{
			if(isdefined(target.hackertoolinnerradius))
			{
				radius = target.hackertoolinnerradius;
			}
			else if(isdefined(target.hackertoolradius))
			{
				radius = target.hackertoolradius;
			}
		}
	}
	return radius;
}

/*
	Name: gethackertoolouterradius
	Namespace: hacker_tool
	Checksum: 0xBE83D7C
	Offset: 0x2A18
	Size: 0xEA
	Parameters: 1
	Flags: None
*/
function gethackertoolouterradius(target)
{
	radius = level.hackertoollockonradius;
	if(isentityhackablecarepackage(target))
	{
		/#
			/#
				assert(isdefined(target.hackertoolradius));
			#/
		#/
		radius = target.hackertoolradius;
	}
	else
	{
		if(isentityhackableweaponobject(target))
		{
			radius = getweaponobjecthackerradius(target);
		}
		else
		{
			if(isdefined(target.hackertoolouterradius))
			{
				radius = target.hackertoolouterradius;
			}
			else if(isdefined(target.hackertoolradius))
			{
				radius = target.hackertoolradius;
			}
		}
	}
	return radius;
}

/*
	Name: gethacktime
	Namespace: hacker_tool
	Checksum: 0x24A277E3
	Offset: 0x2B10
	Size: 0x14E
	Parameters: 1
	Flags: None
*/
function gethacktime(target)
{
	time = 500;
	if(isentityhackablecarepackage(target))
	{
		/#
			/#
				assert(isdefined(target.hackertooltimems));
			#/
		#/
		if(isdefined(target.owner) && target.owner == self)
		{
			time = level.carepackageownerhackertooltimems;
		}
		else
		{
			if(isdefined(target.owner) && target.owner.team == self.team)
			{
				time = level.carepackagefriendlyhackertooltimems;
			}
			else
			{
				time = level.carepackagehackertooltimems;
			}
		}
	}
	else
	{
		if(isentityhackableweaponobject(target))
		{
			time = getweaponobjecthacktimems(target);
		}
		else
		{
			if(isdefined(target.hackertoolinnertimems))
			{
				time = target.hackertoolinnertimems;
			}
			else
			{
				time = level.vehiclehackertooltimems;
			}
		}
	}
	return time;
}

/*
	Name: gethackoutertime
	Namespace: hacker_tool
	Checksum: 0x710604C8
	Offset: 0x2C68
	Size: 0x14E
	Parameters: 1
	Flags: None
*/
function gethackoutertime(target)
{
	time = 500;
	if(isentityhackablecarepackage(target))
	{
		/#
			/#
				assert(isdefined(target.hackertooltimems));
			#/
		#/
		if(isdefined(target.owner) && target.owner == self)
		{
			time = level.carepackageownerhackertooltimems;
		}
		else
		{
			if(isdefined(target.owner) && target.owner.team == self.team)
			{
				time = level.carepackagefriendlyhackertooltimems;
			}
			else
			{
				time = level.carepackagehackertooltimems;
			}
		}
	}
	else
	{
		if(isentityhackableweaponobject(target))
		{
			time = getweaponobjecthacktimems(target);
		}
		else
		{
			if(isdefined(target.hackertooloutertimems))
			{
				time = target.hackertooloutertimems;
			}
			else
			{
				time = level.vehiclehackertooltimems;
			}
		}
	}
	return time;
}

/*
	Name: getlockontime
	Namespace: hacker_tool
	Checksum: 0xC1CA81FF
	Offset: 0x2DC0
	Size: 0x84
	Parameters: 2
	Flags: None
*/
function getlockontime(target, weapon)
{
	locklengthms = self gethacktime(self.hackertooltarget);
	if(locklengthms == 0)
	{
		return 0;
	}
	lockonspeed = weapon.lockonspeed;
	if(lockonspeed <= 0)
	{
		lockonspeed = 1000;
	}
	return locklengthms / lockonspeed;
}

/*
	Name: tunables
	Namespace: hacker_tool
	Checksum: 0x516EDD69
	Offset: 0x2E50
	Size: 0xAC
	Parameters: 0
	Flags: None
*/
function tunables()
{
	/#
		while(true)
		{
			level.hackertoollostsightlimitms = getdvarint(#"scr_hackertoollostsightlimitms", 1000);
			level.hackertoollockonradius = getdvarfloat(#"scr_hackertoollockonradius", 20);
			level.hackertoollockonfov = getdvarint(#"scr_hackertoollockonfov", 65);
			wait(1);
		}
	#/
}

