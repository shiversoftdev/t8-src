// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\weaponobjects.gsc;
#using scripts\core_common\player\player_stats.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace weaponobjects;

/*
	Name: function_b455d5d8
	Namespace: weaponobjects
	Checksum: 0x6F1EE32B
	Offset: 0xD8
	Size: 0x1CC
	Parameters: 0
	Flags: Linked
*/
function function_b455d5d8()
{
	function_e6400478(#"hatchet", &createhatchetwatcher, 1);
	function_e6400478(#"tactical_insertion", &createtactinsertwatcher, 1);
	function_e6400478(#"rcbomb", &creatercbombwatcher, 1);
	function_e6400478(#"qrdrone", &createqrdronewatcher, 1);
	function_e6400478(#"helicopter_player", &createplayerhelicopterwatcher, 1);
	function_e6400478(#"tr_flechette_t8", &function_1eaa3e20);
	function_e6400478(#"hash_17ac9a2101b6ff2d", &function_1eaa3e20);
	if(isdefined(level.var_b68902c4) && level.var_b68902c4)
	{
		function_e6400478(#"tr_flechette_t8_upgraded", &function_1eaa3e20);
	}
}

/*
	Name: createspecialcrossbowwatchertypes
	Namespace: weaponobjects
	Checksum: 0x5CC76FC1
	Offset: 0x2B0
	Size: 0xF6
	Parameters: 1
	Flags: Linked
*/
function createspecialcrossbowwatchertypes(watcher)
{
	watcher.ondetonatecallback = &deleteent;
	watcher.ondamage = &voidondamage;
	if(isdefined(level.b_crossbow_bolt_destroy_on_impact) && level.b_crossbow_bolt_destroy_on_impact)
	{
		watcher.onspawn = &onspawncrossbowboltimpact;
		watcher.onspawnretrievetriggers = &voidonspawnretrievetriggers;
		watcher.pickup = &voidpickup;
	}
	else
	{
		watcher.onspawn = &onspawncrossbowbolt;
		watcher.onspawnretrievetriggers = &function_23b0aea9;
		watcher.pickup = &function_d9219ce2;
	}
}

/*
	Name: function_f297d773
	Namespace: weaponobjects
	Checksum: 0x2E114810
	Offset: 0x3B0
	Size: 0x104
	Parameters: 0
	Flags: None
*/
function function_f297d773()
{
	function_e6400478(#"special_crossbow_t8", &createspecialcrossbowwatchertypes, 1);
	function_e6400478(#"special_crossbowlh", &createspecialcrossbowwatchertypes, 1);
	function_e6400478(#"special_crossbow_dw", &createspecialcrossbowwatchertypes, 1);
	if(isdefined(level.b_create_upgraded_crossbow_watchers) && level.b_create_upgraded_crossbow_watchers)
	{
		function_e6400478(#"special_crossbow_t8_upgraded", &createspecialcrossbowwatchertypes, 1);
	}
}

/*
	Name: function_1eaa3e20
	Namespace: weaponobjects
	Checksum: 0xEB0C9ABD
	Offset: 0x4C0
	Size: 0x26
	Parameters: 1
	Flags: Linked
*/
function function_1eaa3e20(watcher)
{
	watcher.notequipment = 1;
	watcher.onfizzleout = undefined;
}

/*
	Name: createhatchetwatcher
	Namespace: weaponobjects
	Checksum: 0x9FFE44AF
	Offset: 0x4F0
	Size: 0xAE
	Parameters: 1
	Flags: Linked
*/
function createhatchetwatcher(watcher)
{
	watcher.ondetonatecallback = &deleteent;
	watcher.onspawn = &onspawnhatchet;
	watcher.ondamage = &voidondamage;
	watcher.onspawnretrievetriggers = &function_23b0aea9;
	if(!sessionmodeiswarzonegame())
	{
		watcher.timeout = 120;
	}
	watcher.pickup = &function_d9219ce2;
}

/*
	Name: createtactinsertwatcher
	Namespace: weaponobjects
	Checksum: 0xC8F5F2D1
	Offset: 0x5A8
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function createtactinsertwatcher(watcher)
{
	watcher.playdestroyeddialog = 0;
}

/*
	Name: creatercbombwatcher
	Namespace: weaponobjects
	Checksum: 0x5B1D009
	Offset: 0x5D0
	Size: 0x86
	Parameters: 1
	Flags: Linked
*/
function creatercbombwatcher(watcher)
{
	watcher.altdetonate = 0;
	watcher.ismovable = 1;
	watcher.ownergetsassist = 1;
	watcher.playdestroyeddialog = 0;
	watcher.deleteonkillbrush = 0;
	watcher.ondetonatecallback = level.rcbombonblowup;
	watcher.stuntime = 1;
	watcher.notequipment = 1;
}

/*
	Name: createqrdronewatcher
	Namespace: weaponobjects
	Checksum: 0xE3D64544
	Offset: 0x660
	Size: 0x9A
	Parameters: 1
	Flags: Linked
*/
function createqrdronewatcher(watcher)
{
	watcher.altdetonate = 0;
	watcher.ismovable = 1;
	watcher.ownergetsassist = 1;
	watcher.playdestroyeddialog = 0;
	watcher.deleteonkillbrush = 0;
	watcher.ondetonatecallback = level.qrdroneonblowup;
	watcher.ondamage = level.qrdroneondamage;
	watcher.stuntime = 5;
	watcher.notequipment = 1;
}

/*
	Name: getspikelauncheractivespikecount
	Namespace: weaponobjects
	Checksum: 0x7EEB86EA
	Offset: 0x708
	Size: 0xB0
	Parameters: 1
	Flags: Linked
*/
function getspikelauncheractivespikecount(watcher)
{
	currentitemcount = 0;
	foreach(obj in watcher.objectarray)
	{
		if(isdefined(obj) && obj.item !== watcher.weapon)
		{
			currentitemcount++;
		}
	}
	return currentitemcount;
}

/*
	Name: watchspikelauncheritemcountchanged
	Namespace: weaponobjects
	Checksum: 0xB48C58C7
	Offset: 0x7C0
	Size: 0x10E
	Parameters: 1
	Flags: None
*/
function watchspikelauncheritemcountchanged(watcher)
{
	self endon(#"death");
	lastitemcount = undefined;
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"weapon_change");
		weapon = waitresult.weapon;
		while(weapon.name == #"spike_launcher")
		{
			currentitemcount = getspikelauncheractivespikecount(watcher);
			if(currentitemcount !== lastitemcount)
			{
				self setcontrolleruimodelvalue("spikeLauncherCounter.spikesReady", currentitemcount);
				lastitemcount = currentitemcount;
			}
			wait(0.1);
			weapon = self getcurrentweapon();
		}
	}
}

/*
	Name: spikesdetonating
	Namespace: weaponobjects
	Checksum: 0x2EA3F1BE
	Offset: 0x8D8
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function spikesdetonating(watcher)
{
	spikecount = getspikelauncheractivespikecount(watcher);
	if(spikecount > 0)
	{
		self setcontrolleruimodelvalue("spikeLauncherCounter.blasting", 1);
		wait(2);
		self setcontrolleruimodelvalue("spikeLauncherCounter.blasting", 0);
	}
}

/*
	Name: createspikelauncherwatcher
	Namespace: weaponobjects
	Checksum: 0xAF26A396
	Offset: 0x968
	Size: 0x146
	Parameters: 1
	Flags: None
*/
function createspikelauncherwatcher(watcher)
{
	watcher.altname = #"spike_charge";
	watcher.altweapon = getweapon(#"spike_charge");
	watcher.altdetonate = 0;
	watcher.watchforfire = 1;
	watcher.hackable = 1;
	watcher.hackertoolradius = level.equipmenthackertoolradius;
	watcher.hackertooltimems = level.equipmenthackertooltimems;
	watcher.ondetonatecallback = &spikedetonate;
	watcher.onstun = &weaponstun;
	watcher.stuntime = 1;
	watcher.ownergetsassist = 1;
	watcher.detonatestationary = 0;
	watcher.detonationdelay = 0;
	watcher.detonationsound = #"wpn_claymore_alert";
	watcher.ondetonationhandle = &spikesdetonating;
}

/*
	Name: createplayerhelicopterwatcher
	Namespace: weaponobjects
	Checksum: 0xCD7F2B66
	Offset: 0xAB8
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function createplayerhelicopterwatcher(watcher)
{
	watcher.altdetonate = 1;
	watcher.notequipment = 1;
}

/*
	Name: function_50d4198b
	Namespace: weaponobjects
	Checksum: 0x29F2EE4D
	Offset: 0xAF0
	Size: 0x56
	Parameters: 1
	Flags: None
*/
function function_50d4198b(watcher)
{
	watcher.hackable = 0;
	watcher.headicon = 0;
	watcher.deleteonplayerspawn = 0;
	watcher.enemydestroy = 0;
	watcher.onspawn = &function_f0e307a2;
}

/*
	Name: function_f0e307a2
	Namespace: weaponobjects
	Checksum: 0x907B50D4
	Offset: 0xB50
	Size: 0xC4
	Parameters: 2
	Flags: Linked
*/
function function_f0e307a2(watcher, player)
{
	level endon(#"game_ended");
	self endon(#"death");
	if(isdefined(player))
	{
		player stats::function_e24eec31(self.weapon, #"used", 1);
	}
	self playloopsound(#"uin_c4_air_alarm_loop");
	self waittilltimeout(10, #"stationary");
	function_b70eb3a9(watcher, player);
}

/*
	Name: function_b70eb3a9
	Namespace: weaponobjects
	Checksum: 0xFA0D7872
	Offset: 0xC20
	Size: 0xC4
	Parameters: 2
	Flags: Linked
*/
function function_b70eb3a9(watcher, player)
{
	pos = self.origin + vectorscale((0, 0, 1), 15);
	self.ammo_trigger = spawn("trigger_radius", pos, 0, 50, 50);
	self.ammo_trigger setteamfortrigger(player.team);
	self.ammo_trigger.owner = player;
	self thread function_5742754c();
	self thread function_42eeab72(self);
}

/*
	Name: function_5742754c
	Namespace: weaponobjects
	Checksum: 0xC53C4DE0
	Offset: 0xCF0
	Size: 0x170
	Parameters: 0
	Flags: Linked
*/
function function_5742754c()
{
	station = self;
	station endon(#"death");
	if(!isdefined(station.ammo_resupplies_given))
	{
		station.ammo_resupplies_given = 0;
	}
	/#
		assert(isdefined(station.ammo_trigger));
	#/
	trigger = station.ammo_trigger;
	while(isdefined(trigger))
	{
		waitresult = undefined;
		waitresult = trigger waittill(#"touch");
		player = waitresult.entity;
		if(!isplayer(player))
		{
			continue;
		}
		if(!isalive(player))
		{
			continue;
		}
		if(isdefined(trigger.team) && util::function_fbce7263(player.team, trigger.team))
		{
			continue;
		}
		station function_e98cee52(player, station);
	}
}

/*
	Name: function_e98cee52
	Namespace: weaponobjects
	Checksum: 0xECC41CC1
	Offset: 0xE68
	Size: 0x16C
	Parameters: 2
	Flags: Linked
*/
function function_e98cee52(player, station)
{
	primary_weapons = player getweaponslistprimaries();
	var_c20b09e1 = 0;
	foreach(weapon in primary_weapons)
	{
		var_c20b09e1 = var_c20b09e1 | player function_61bdb626(weapon);
	}
	if(!var_c20b09e1)
	{
		return;
	}
	if(!isdefined(station.last_ammo_resupply_time))
	{
		station.last_ammo_resupply_time = [];
	}
	station.last_ammo_resupply_time[player getentitynumber()] = gettime();
	station.ammo_resupplies_given++;
	if(station.ammo_resupplies_given >= 1)
	{
		station function_f47cd4cb();
		station delete();
	}
}

/*
	Name: function_61bdb626
	Namespace: weaponobjects
	Checksum: 0x116C4560
	Offset: 0xFE0
	Size: 0xB8
	Parameters: 1
	Flags: Linked
*/
function function_61bdb626(weapon)
{
	player = self;
	new_ammo = weapon.clipsize;
	stockammo = player getweaponammostock(weapon);
	player setweaponammostock(weapon, int(stockammo + new_ammo));
	newammo = player getweaponammostock(weapon);
	return newammo > stockammo;
}

/*
	Name: function_42eeab72
	Namespace: weaponobjects
	Checksum: 0xDAECC0DF
	Offset: 0x10A0
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_42eeab72(station)
{
	self waittill(#"death");
	self function_f47cd4cb();
}

/*
	Name: function_f47cd4cb
	Namespace: weaponobjects
	Checksum: 0x3C03A841
	Offset: 0x10E0
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_f47cd4cb()
{
	if(isdefined(self.ammo_trigger))
	{
		self.ammo_trigger delete();
	}
}

/*
	Name: delayedspikedetonation
	Namespace: weaponobjects
	Checksum: 0xC19CF275
	Offset: 0x1118
	Size: 0xE4
	Parameters: 2
	Flags: Linked
*/
function delayedspikedetonation(attacker, weapon)
{
	if(!isdefined(self.owner.spikedelay))
	{
		self.owner.spikedelay = 0;
	}
	delaytime = self.owner.spikedelay;
	owner = self.owner;
	self.owner.spikedelay = self.owner.spikedelay + 0.3;
	waittillframeend();
	wait(delaytime);
	owner.spikedelay = owner.spikedelay - 0.3;
	if(isdefined(self))
	{
		self weapondetonate(attacker, weapon);
	}
}

/*
	Name: spikedetonate
	Namespace: weaponobjects
	Checksum: 0x8C21C52D
	Offset: 0x1208
	Size: 0x6C
	Parameters: 3
	Flags: Linked
*/
function spikedetonate(attacker, weapon, target)
{
	if(isdefined(weapon) && weapon.isvalid)
	{
		if(isdefined(attacker))
		{
		}
	}
	thread delayedspikedetonation(attacker, weapon);
}

/*
	Name: onspawnhatchet
	Namespace: weaponobjects
	Checksum: 0x7A42ED3
	Offset: 0x1280
	Size: 0x38
	Parameters: 2
	Flags: Linked
*/
function onspawnhatchet(watcher, player)
{
	if(isdefined(level.playthrowhatchet))
	{
		player [[level.playthrowhatchet]]();
	}
}

/*
	Name: onspawncrossbowbolt
	Namespace: weaponobjects
	Checksum: 0x78CE9D35
	Offset: 0x12C0
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function onspawncrossbowbolt(watcher, player)
{
	self.delete_on_death = 1;
	self thread onspawncrossbowbolt_internal(watcher, player);
}

/*
	Name: onspawncrossbowbolt_internal
	Namespace: weaponobjects
	Checksum: 0x7295C385
	Offset: 0x1308
	Size: 0xDC
	Parameters: 2
	Flags: Linked
*/
function onspawncrossbowbolt_internal(watcher, player)
{
	player endon(#"disconnect");
	self endon(#"death");
	wait(0.25);
	linkedent = self getlinkedent();
	if(!isdefined(linkedent) || !isvehicle(linkedent))
	{
		self.takedamage = 0;
	}
	else
	{
		self.takedamage = 1;
		if(isvehicle(linkedent))
		{
			self thread dieonentitydeath(linkedent, player);
		}
	}
}

/*
	Name: onspawncrossbowboltimpact
	Namespace: weaponobjects
	Checksum: 0x8154F0B9
	Offset: 0x13F0
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function onspawncrossbowboltimpact(s_watcher, e_player)
{
	self.delete_on_death = 1;
	self thread onspawncrossbowboltimpact_internal(s_watcher, e_player);
}

/*
	Name: onspawncrossbowboltimpact_internal
	Namespace: weaponobjects
	Checksum: 0x46C3401
	Offset: 0x1438
	Size: 0x104
	Parameters: 2
	Flags: Linked
*/
function onspawncrossbowboltimpact_internal(s_watcher, e_player)
{
	self endon(#"death");
	e_player endon(#"disconnect");
	self waittill(#"stationary");
	s_watcher thread waitandfizzleout(self, 0);
	foreach(n_index, e_object in s_watcher.objectarray)
	{
		if(self == e_object)
		{
			s_watcher.objectarray[n_index] = undefined;
		}
	}
	cleanweaponobjectarray(s_watcher);
}

/*
	Name: dieonentitydeath
	Namespace: weaponobjects
	Checksum: 0x6E3D80D4
	Offset: 0x1548
	Size: 0xB6
	Parameters: 2
	Flags: Linked
*/
function dieonentitydeath(entity, player)
{
	player endon(#"disconnect");
	self endon(#"death");
	alreadydead = entity.dead === 1 || (isdefined(entity.health) && entity.health < 0);
	if(!alreadydead)
	{
		entity waittill(#"death");
	}
	self notify(#"death");
}

