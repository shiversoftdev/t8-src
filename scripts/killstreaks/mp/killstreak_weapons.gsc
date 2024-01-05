// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\killstreaks\mp\supplydrop.gsc;
#using scripts\mp_common\gametypes\globallogic_utils.gsc;
#using scripts\weapons\weapons.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\popups_shared.gsc;
#using scripts\core_common\player\player_stats.gsc;
#using scripts\core_common\loadout_shared.gsc;
#using scripts\killstreaks\killstreaks_util.gsc;
#using scripts\killstreaks\killstreaks_shared.gsc;
#using scripts\killstreaks\killstreakrules_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace killstreak_weapons;

/*
	Name: init
	Namespace: killstreak_weapons
	Checksum: 0xCF6D12EE
	Offset: 0x178
	Size: 0x104
	Parameters: 0
	Flags: None
*/
function init()
{
	killstreaks::register("minigun", "minigun", "killstreak_minigun", "minigun_used", &usecarriedkillstreakweapon, 0, 1, "MINIGUN_USED");
	killstreaks::register("m32", "m32", "killstreak_m32", "m32_used", &usecarriedkillstreakweapon, 0, 1, "M32_USED");
	killstreaks::override_entity_camera_in_demo("m32", 1);
	callback::on_spawned(&on_player_spawned);
	setdvar(#"scr_heldkillstreak_penalty", 0);
}

/*
	Name: on_player_spawned
	Namespace: killstreak_weapons
	Checksum: 0xF2EED308
	Offset: 0x288
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	self endon(#"disconnect");
	self.firedkillstreakweapon = 0;
	self.usingkillstreakheldweapon = undefined;
	if(!util::isfirstround() && !util::isoneround())
	{
		if(level.roundstartkillstreakdelay > float(globallogic_utils::gettimepassed()) / 1000)
		{
			self thread watchkillstreakweapondelay();
		}
	}
}

/*
	Name: watchkillstreakweapondelay
	Namespace: killstreak_weapons
	Checksum: 0xDA840B45
	Offset: 0x338
	Size: 0x1F0
	Parameters: 0
	Flags: Linked
*/
function watchkillstreakweapondelay()
{
	self endon(#"disconnect", #"death");
	while(true)
	{
		currentweapon = self getcurrentweapon();
		waitresult = undefined;
		waitresult = self waittill(#"weapon_change");
		newweapon = waitresult.weapon;
		if(level.roundstartkillstreakdelay < float(globallogic_utils::gettimepassed()) / 1000)
		{
			return;
		}
		if(!killstreaks::is_killstreak_weapon(newweapon))
		{
			wait(0.5);
			continue;
		}
		killstreak = killstreaks::get_killstreak_for_weapon(newweapon);
		if(killstreaks::is_delayable_killstreak(killstreak) && newweapon.iscarriedkillstreak)
		{
			timeleft = int(level.roundstartkillstreakdelay - (float(globallogic_utils::gettimepassed()) / 1000));
			if(!timeleft)
			{
				timeleft = 1;
			}
			self iprintlnbold(#"hash_55a79f95e07a10bc", (" " + timeleft) + " ", #"hash_79a58948c3b976f5");
			self switchtoweapon(currentweapon);
			wait(0.5);
		}
	}
}

/*
	Name: usekillstreakweapondrop
	Namespace: killstreak_weapons
	Checksum: 0x43A55A20
	Offset: 0x530
	Size: 0x7C
	Parameters: 1
	Flags: None
*/
function usekillstreakweapondrop(hardpointtype)
{
	if(self supplydrop::issupplydropgrenadeallowed(hardpointtype) == 0)
	{
		return 0;
	}
	result = self supplydrop::usesupplydropmarker();
	self notify(#"supply_drop_marker_done");
	if(!isdefined(result) || !result)
	{
		return 0;
	}
	return result;
}

/*
	Name: usecarriedkillstreakweapon
	Namespace: killstreak_weapons
	Checksum: 0xB7789C37
	Offset: 0x5B8
	Size: 0x6DC
	Parameters: 1
	Flags: Linked
*/
function usecarriedkillstreakweapon(hardpointtype)
{
	if(!isdefined(hardpointtype))
	{
		return false;
	}
	if(self killstreakrules::iskillstreakallowed(hardpointtype, self.team) == 0)
	{
		self switchtoweapon(self.lastdroppableweapon);
		return false;
	}
	currentweapon = self getcurrentweapon();
	killstreakweapon = killstreaks::get_killstreak_weapon(hardpointtype);
	if(killstreakweapon == level.weaponnone)
	{
		return false;
	}
	level weapons::add_limited_weapon(killstreakweapon, self, 3);
	if(issubstr(hardpointtype, "inventory"))
	{
		isfrominventory = 1;
	}
	else
	{
		isfrominventory = 0;
	}
	currentammo = self getammocount(killstreakweapon);
	if(hardpointtype == "minigun" || hardpointtype == "inventory_minigun" && (!(isdefined(self.minigunstart) && self.minigunstart)) || (hardpointtype == "m32" || hardpointtype == "inventory_m32" && (!(isdefined(self.m32start) && self.m32start))))
	{
		if(hardpointtype == "minigun" || hardpointtype == "inventory_minigun")
		{
			self.minigunstart = 1;
		}
		else
		{
			self.m32start = 1;
		}
		self killstreaks::play_killstreak_start_dialog(hardpointtype, self.team, 1);
		self stats::function_e24eec31(killstreakweapon, #"used", 1);
		level thread popups::displayteammessagetoall(level.killstreaks[hardpointtype].inboundtext, self);
		self.pers[#"held_killstreak_clip_count"][killstreakweapon] = (killstreakweapon.clipsize > currentammo ? currentammo : killstreakweapon.clipsize);
		if(isfrominventory == 0)
		{
			if(self.pers[#"killstreak_quantity"][killstreakweapon] > 0)
			{
				ammopool = killstreakweapon.maxammo;
			}
			else
			{
				ammopool = self.pers[#"held_killstreak_ammo_count"][killstreakweapon];
			}
			self setweaponammoclip(killstreakweapon, self.pers[#"held_killstreak_clip_count"][killstreakweapon]);
			self setweaponammostock(killstreakweapon, ammopool - self.pers[#"held_killstreak_clip_count"][killstreakweapon]);
		}
	}
	if(hardpointtype == "minigun" || hardpointtype == "inventory_minigun")
	{
		if(!(isdefined(self.minigunactive) && self.minigunactive))
		{
			killstreak_id = self killstreakrules::killstreakstart(hardpointtype, self.team, 0, 0);
			if(hardpointtype == "inventory_minigun")
			{
				killstreak_id = self.pers[#"killstreak_unique_id"][self.pers[#"killstreak_unique_id"].size - 1];
			}
			self.minigunid = killstreak_id;
			self.minigunactive = 1;
		}
		else
		{
			killstreak_id = self.minigunid;
		}
	}
	else
	{
		if(!(isdefined(self.m32active) && self.m32active))
		{
			killstreak_id = self killstreakrules::killstreakstart(hardpointtype, self.team, 0, 0);
			if(hardpointtype == "inventory_m32")
			{
				killstreak_id = self.pers[#"killstreak_unique_id"][self.pers[#"killstreak_unique_id"].size - 1];
			}
			self.m32id = killstreak_id;
			self.m32active = 1;
		}
		else
		{
			killstreak_id = self.m32id;
		}
	}
	/#
		assert(killstreak_id != -1);
	#/
	self.firedkillstreakweapon = 0;
	self setblockweaponpickup(killstreakweapon, 1);
	if(isfrominventory)
	{
		self setweaponammoclip(killstreakweapon, self.pers[#"held_killstreak_clip_count"][killstreakweapon]);
		self setweaponammostock(killstreakweapon, (self.pers[#"killstreak_ammo_count"][self.pers[#"killstreak_ammo_count"].size - 1]) - self.pers[#"held_killstreak_clip_count"][killstreakweapon]);
	}
	notifystring = "killstreakWeapon_" + killstreakweapon.name;
	self notify(notifystring);
	self thread watchkillstreakweaponswitch(killstreakweapon, killstreak_id, isfrominventory);
	self thread watchkillstreakweapondeath(killstreakweapon, killstreak_id, isfrominventory);
	self thread watchkillstreakroundchange(isfrominventory, killstreak_id);
	self thread watchplayerdeath(killstreakweapon);
	if(isfrominventory)
	{
		self thread watchkillstreakremoval(hardpointtype, killstreak_id);
	}
	self.usingkillstreakheldweapon = 1;
	return false;
}

/*
	Name: usekillstreakweaponfromcrate
	Namespace: killstreak_weapons
	Checksum: 0xFC6756E2
	Offset: 0xCA0
	Size: 0x16E
	Parameters: 1
	Flags: Linked
*/
function usekillstreakweaponfromcrate(hardpointtype)
{
	if(!isdefined(hardpointtype))
	{
		return false;
	}
	killstreakweapon = killstreaks::get_killstreak_weapon(hardpointtype);
	if(killstreakweapon == level.weaponnone)
	{
		return false;
	}
	self.firedkillstreakweapon = 0;
	self setblockweaponpickup(killstreakweapon, 1);
	killstreak_id = self killstreakrules::killstreakstart(hardpointtype, self.team, 0, 0);
	/#
		assert(killstreak_id != -1);
	#/
	if(issubstr(hardpointtype, "inventory"))
	{
		isfrominventory = 1;
	}
	else
	{
		isfrominventory = 0;
	}
	self thread watchkillstreakweaponswitch(killstreakweapon, killstreak_id, isfrominventory);
	self thread watchkillstreakweapondeath(killstreakweapon, killstreak_id, isfrominventory);
	if(isfrominventory)
	{
		self thread watchkillstreakremoval(hardpointtype, killstreak_id);
	}
	self.usingkillstreakheldweapon = 1;
	return true;
}

/*
	Name: watchkillstreakweaponswitch
	Namespace: killstreak_weapons
	Checksum: 0x36F227C7
	Offset: 0xE18
	Size: 0x4F4
	Parameters: 3
	Flags: Linked
*/
function watchkillstreakweaponswitch(killstreakweapon, killstreak_id, isfrominventory)
{
	self endon(#"disconnect", #"death");
	noneweapon = getweapon(#"none");
	minigunweapon = getweapon(#"minigun");
	miniguninventoryweapon = getweapon(#"inventory_minigun");
	while(true)
	{
		currentweapon = self getcurrentweapon();
		waitresult = undefined;
		waitresult = self waittill(#"weapon_change");
		newweapon = waitresult.weapon;
		if(level.infinalkillcam)
		{
			continue;
		}
		if(newweapon == noneweapon)
		{
			continue;
		}
		currentammo = self getammocount(killstreakweapon);
		currentammoinclip = self getweaponammoclip(killstreakweapon);
		if(isfrominventory && currentammo > 0)
		{
			killstreakindex = self killstreaks::get_killstreak_index_by_id(killstreak_id);
			if(isdefined(killstreakindex))
			{
				self.pers[#"killstreak_ammo_count"][killstreakindex] = currentammo;
				self.pers[#"held_killstreak_clip_count"][killstreakweapon] = currentammoinclip;
			}
		}
		if(killstreaks::is_killstreak_weapon(newweapon) && !newweapon.iscarriedkillstreak)
		{
			continue;
		}
		if(newweapon.isgameplayweapon)
		{
			continue;
		}
		if(newweapon == self.lastnonkillstreakweapon && newweapon.iscarriedkillstreak)
		{
			continue;
		}
		killstreakid = killstreaks::get_top_killstreak_unique_id();
		self.pers[#"held_killstreak_ammo_count"][killstreakweapon] = currentammo;
		self.pers[#"held_killstreak_clip_count"][killstreakweapon] = currentammoinclip;
		if(killstreak_id != -1)
		{
			self notify(#"killstreak_weapon_switch");
		}
		self.firedkillstreakweapon = 0;
		self.usingkillstreakheldweapon = undefined;
		waittillframeend();
		if(currentammo == 0 || self.pers[#"killstreak_quantity"][killstreakweapon] > 0 || (isfrominventory && isdefined(killstreakid) && killstreakid != killstreak_id))
		{
			killstreakrules::killstreakstop(killstreaks::get_killstreak_for_weapon(killstreakweapon), self.team, killstreak_id);
			if(killstreakweapon == miniguninventoryweapon || killstreakweapon == minigunweapon)
			{
				self.minigunstart = 0;
				self.minigunactive = 0;
			}
			else
			{
				self.m32start = 0;
				self.m32active = 0;
			}
			if(self.pers[#"killstreak_quantity"][killstreakweapon] > 0)
			{
				self.pers[#"held_killstreak_ammo_count"][killstreakweapon] = killstreakweapon.maxammo;
				self loadout::function_3ba6ee5d(killstreakweapon, self.pers[#"held_killstreak_ammo_count"][killstreakweapon]);
				self.pers[#"killstreak_quantity"][killstreakweapon]--;
			}
		}
		if(isfrominventory && currentammo == 0)
		{
			self takeweapon(killstreakweapon);
			self killstreaks::remove_used_killstreak(killstreaks::get_killstreak_for_weapon(killstreakweapon), killstreak_id);
			self killstreaks::activate_next();
		}
		break;
	}
}

/*
	Name: watchkillstreakweapondeath
	Namespace: killstreak_weapons
	Checksum: 0xF21BE0E1
	Offset: 0x1318
	Size: 0x538
	Parameters: 3
	Flags: Linked
*/
function watchkillstreakweapondeath(killstreakweapon, killstreak_id, isfrominventory)
{
	self endon(#"disconnect", #"killstreak_weapon_switch");
	if(killstreak_id == -1)
	{
		return;
	}
	oldteam = self.team;
	self waittill(#"death");
	penalty = getdvarfloat(#"scr_heldkillstreak_penalty", 0.5);
	maxammo = killstreakweapon.maxammo;
	currentammo = self getammocount(killstreakweapon);
	currentammoinclip = self getweaponammoclip(killstreakweapon);
	if(self.pers[#"killstreak_quantity"].size == 0)
	{
		currentammo = 0;
		currentammoinclip = 0;
	}
	maxclipsize = killstreakweapon.clipsize;
	newammo = int(currentammo - (maxammo * penalty));
	killstreakid = killstreaks::get_top_killstreak_unique_id();
	if(self.lastnonkillstreakweapon == killstreakweapon)
	{
		if(newammo < 0)
		{
			self.pers[#"held_killstreak_ammo_count"][killstreakweapon] = 0;
			self.pers[#"held_killstreak_clip_count"][killstreakweapon] = 0;
		}
		else
		{
			self.pers[#"held_killstreak_ammo_count"][killstreakweapon] = newammo;
			self.pers[#"held_killstreak_clip_count"][killstreakweapon] = (maxclipsize <= newammo ? maxclipsize : newammo);
		}
	}
	self.usingkillstreakheldweapon = 0;
	killstreaktype = killstreaks::get_killstreak_for_weapon(killstreakweapon);
	if(newammo <= 0 || self.pers[#"killstreak_quantity"][killstreakweapon] > 0 || (isfrominventory && isdefined(killstreakid) && killstreakid != killstreak_id))
	{
		killstreakrules::killstreakstop(killstreaktype, oldteam, killstreak_id);
		if(killstreaktype == "minigun" || killstreaktype == "inventory_minigun")
		{
			self.minigunstart = 0;
			self.minigunactive = 0;
		}
		else
		{
			self.m32start = 0;
			self.m32active = 0;
		}
		if(isdefined(self.pers[#"killstreak_quantity"][killstreakweapon]) && self.pers[#"killstreak_quantity"][killstreakweapon] > 0)
		{
			self.pers[#"held_killstreak_ammo_count"][killstreakweapon] = maxammo;
			self.pers[#"held_killstreak_clip_count"][killstreakweapon] = maxclipsize;
			self setweaponammoclip(killstreakweapon, self.pers[#"held_killstreak_clip_count"][killstreakweapon]);
			self setweaponammostock(killstreakweapon, self.pers[#"held_killstreak_ammo_count"][killstreakweapon] - self.pers[#"held_killstreak_clip_count"][killstreakweapon]);
			self.pers[#"killstreak_quantity"][killstreakweapon]--;
		}
	}
	if(isfrominventory && newammo <= 0)
	{
		self takeweapon(killstreakweapon);
		self killstreaks::remove_used_killstreak(killstreaktype, killstreak_id);
		self killstreaks::activate_next();
	}
	else if(isfrominventory)
	{
		killstreakindex = self killstreaks::get_killstreak_index_by_id(killstreak_id);
		if(isdefined(killstreakindex))
		{
			self.pers[#"killstreak_ammo_count"][killstreakindex] = self.pers[#"held_killstreak_ammo_count"][killstreakweapon];
		}
	}
}

/*
	Name: watchplayerdeath
	Namespace: killstreak_weapons
	Checksum: 0x6DEB589D
	Offset: 0x1858
	Size: 0xD0
	Parameters: 1
	Flags: Linked
*/
function watchplayerdeath(killstreakweapon)
{
	self endon(#"disconnect");
	endonweaponstring = "killstreakWeapon_" + killstreakweapon.name;
	self endon(endonweaponstring);
	self waittill(#"death");
	currentammo = self getammocount(killstreakweapon);
	self.pers[#"held_killstreak_clip_count"][killstreakweapon] = (killstreakweapon.clipsize <= currentammo ? killstreakweapon.clipsize : currentammo);
}

/*
	Name: watchkillstreakremoval
	Namespace: killstreak_weapons
	Checksum: 0xDDB4CA66
	Offset: 0x1930
	Size: 0x122
	Parameters: 2
	Flags: Linked
*/
function watchkillstreakremoval(killstreaktype, killstreak_id)
{
	self endon(#"disconnect", #"death", #"killstreak_weapon_switch");
	waitresult = undefined;
	waitresult = self waittill(#"oldest_killstreak_removed");
	removedkillstreaktype = waitresult.type;
	removed_id = waitresult.id;
	if(killstreaktype == removedkillstreaktype && killstreak_id == removed_id)
	{
		removedkillstreakweapon = killstreaks::get_killstreak_weapon(removedkillstreaktype);
		if(removedkillstreakweapon.name == "inventory_minigun")
		{
			self.minigunstart = 0;
			self.minigunactive = 0;
		}
		else
		{
			self.m32start = 0;
			self.m32active = 0;
		}
	}
}

/*
	Name: watchkillstreakroundchange
	Namespace: killstreak_weapons
	Checksum: 0x283AE5E2
	Offset: 0x1A60
	Size: 0x1B8
	Parameters: 2
	Flags: Linked
*/
function watchkillstreakroundchange(isfrominventory, killstreak_id)
{
	self endon(#"disconnect", #"death", #"killstreak_weapon_switch");
	self waittill(#"round_ended");
	currentweapon = self getcurrentweapon();
	if(!currentweapon.iscarriedkillstreak)
	{
		return;
	}
	currentammo = self getammocount(currentweapon);
	maxclipsize = currentweapon.clipsize;
	if(isfrominventory && currentammo > 0)
	{
		killstreakindex = self killstreaks::get_killstreak_index_by_id(killstreak_id);
		if(isdefined(killstreakindex))
		{
			self.pers[#"killstreak_ammo_count"][killstreakindex] = currentammo;
			self.pers[#"held_killstreak_clip_count"][currentweapon] = (maxclipsize <= currentammo ? maxclipsize : currentammo);
		}
	}
	else
	{
		self.pers[#"held_killstreak_ammo_count"][currentweapon] = currentammo;
		self.pers[#"held_killstreak_clip_count"][currentweapon] = (maxclipsize <= currentammo ? maxclipsize : currentammo);
	}
}

/*
	Name: checkifswitchableweapon
	Namespace: killstreak_weapons
	Checksum: 0xCBC193AA
	Offset: 0x1C20
	Size: 0x214
	Parameters: 4
	Flags: None
*/
function checkifswitchableweapon(currentweapon, newweapon, killstreakweapon, currentkillstreakid)
{
	switchableweapon = 1;
	topkillstreak = killstreaks::get_top_killstreak();
	killstreakid = killstreaks::get_top_killstreak_unique_id();
	if(!isdefined(killstreakid))
	{
		killstreakid = -1;
	}
	if(self hasweapon(killstreakweapon) && !self getammocount(killstreakweapon))
	{
		switchableweapon = 1;
	}
	else
	{
		if(self.firedkillstreakweapon && newweapon == killstreakweapon && currentweapon.iscarriedkillstreak)
		{
			switchableweapon = 1;
		}
		else
		{
			if(newweapon.isequipment)
			{
				switchableweapon = 1;
			}
			else
			{
				if(isdefined(level.grenade_array[newweapon]))
				{
					switchableweapon = 0;
				}
				else
				{
					if(newweapon.iscarriedkillstreak && currentweapon.iscarriedkillstreak && (!isdefined(currentkillstreakid) || currentkillstreakid != killstreakid))
					{
						switchableweapon = 1;
					}
					else
					{
						if(killstreaks::is_killstreak_weapon(newweapon))
						{
							switchableweapon = 0;
						}
						else
						{
							if(newweapon.isgameplayweapon)
							{
								switchableweapon = 0;
							}
							else
							{
								if(self.firedkillstreakweapon)
								{
									switchableweapon = 1;
								}
								else
								{
									if(self.lastnonkillstreakweapon == killstreakweapon)
									{
										switchableweapon = 0;
									}
									else if(isdefined(topkillstreak) && topkillstreak == killstreakweapon && currentkillstreakid == killstreakid)
									{
										switchableweapon = 0;
									}
								}
							}
						}
					}
				}
			}
		}
	}
	return switchableweapon;
}

