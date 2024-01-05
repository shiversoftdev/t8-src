// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai\archetype_utility.gsc;
#using script_4c5c4a64a59247a2;
#using scripts\core_common\name_shared.gsc;

#namespace init;

/*
	Name: initweapon
	Namespace: init
	Checksum: 0x5B7A63C
	Offset: 0xC0
	Size: 0xD6
	Parameters: 1
	Flags: Linked
*/
function initweapon(weapon)
{
	self.weaponinfo[weapon.name] = spawnstruct();
	self.weaponinfo[weapon.name].position = "none";
	self.weaponinfo[weapon.name].hasclip = 1;
	if(isdefined(weapon.clipmodel))
	{
		self.weaponinfo[weapon.name].useclip = 1;
	}
	else
	{
		self.weaponinfo[weapon.name].useclip = 0;
	}
}

/*
	Name: main
	Namespace: init
	Checksum: 0xEA0388F
	Offset: 0x1A0
	Size: 0x46A
	Parameters: 0
	Flags: Linked
*/
function main()
{
	self.a = spawnstruct();
	self.a.weaponpos = [];
	if(self.weapon == level.weaponnone)
	{
		self aiutility::setcurrentweapon(level.weaponnone);
	}
	self aiutility::setprimaryweapon(self.weapon);
	if(self.secondaryweapon == level.weaponnone)
	{
		self aiutility::setsecondaryweapon(level.weaponnone);
	}
	self aiutility::setsecondaryweapon(self.secondaryweapon);
	self aiutility::setcurrentweapon(self.primaryweapon);
	self.initial_primaryweapon = self.primaryweapon;
	self.initial_secondaryweapon = self.secondaryweapon;
	self initweapon(self.primaryweapon);
	self initweapon(self.secondaryweapon);
	self initweapon(self.sidearm);
	self.weapon_positions = array("left", "right", "chest", "back");
	for(i = 0; i < self.weapon_positions.size; i++)
	{
		self.a.weaponpos[self.weapon_positions[i]] = level.weaponnone;
	}
	self.lastweapon = self.weapon;
	firstinit();
	self.a.rockets = 3;
	self.a.rocketvisible = 1;
	self.a.pose = "stand";
	self.a.prevpose = self.a.pose;
	self.a.movement = "stop";
	self.a.special = "none";
	self.a.gunhand = "none";
	shared::placeweaponon(self.primaryweapon, "right");
	if(isdefined(self.secondaryweaponclass) && self.secondaryweaponclass != "none" && self.secondaryweaponclass != "pistol")
	{
		shared::placeweaponon(self.secondaryweapon, "back");
	}
	self.a.combatendtime = gettime();
	self.a.nextgrenadetrytime = 0;
	self.a.isaiming = 0;
	self.rightaimlimit = 45;
	self.leftaimlimit = -45;
	self.upaimlimit = 45;
	self.downaimlimit = -45;
	self.walk = 0;
	self.sprint = 0;
	self.a.postscriptfunc = undefined;
	self.baseaccuracy = self.accuracy;
	if(!isdefined(self.script_accuracy))
	{
		self.script_accuracy = 1;
	}
	self.a.misstime = 0;
	self.ai.bulletsinclip = self.weapon.clipsize;
	self.lastenemysighttime = 0;
	self.combattime = 0;
	self.suppressed = 0;
	self.suppressedtime = 0;
	self.suppressionthreshold = 0.75;
	self.randomgrenaderange = 128;
	self.reacquire_state = 0;
}

/*
	Name: setnameandrank
	Namespace: init
	Checksum: 0xFE73EE6F
	Offset: 0x618
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function setnameandrank()
{
	self endon(#"death");
	self name::get();
}

/*
	Name: donothing
	Namespace: init
	Checksum: 0x80F724D1
	Offset: 0x650
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function donothing()
{
}

/*
	Name: set_anim_playback_rate
	Namespace: init
	Checksum: 0x783A5E7B
	Offset: 0x660
	Size: 0x3A
	Parameters: 0
	Flags: None
*/
function set_anim_playback_rate()
{
	self.animplaybackrate = 0.9 + randomfloat(0.2);
	self.moveplaybackrate = 1;
}

/*
	Name: trackvelocity
	Namespace: init
	Checksum: 0x89C0B4D6
	Offset: 0x6A8
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function trackvelocity()
{
	self endon(#"death");
	for(;;)
	{
		self.oldorigin = self.origin;
		wait(0.2);
	}
}

/*
	Name: checkapproachangles
	Namespace: init
	Checksum: 0xFD6A6F6B
	Offset: 0x6E8
	Size: 0x400
	Parameters: 1
	Flags: None
*/
function checkapproachangles(transtypes)
{
	/#
		idealtransangles[1] = 45;
		idealtransangles[2] = 0;
		idealtransangles[3] = -45;
		idealtransangles[4] = 90;
		idealtransangles[6] = -90;
		idealtransangles[7] = 135;
		idealtransangles[8] = 180;
		idealtransangles[9] = -135;
		waitframe(1);
		for(i = 1; i <= 9; i++)
		{
			for(j = 0; j < transtypes.size; j++)
			{
				trans = transtypes[j];
				idealadd = 0;
				if(trans == "" || trans == "")
				{
					idealadd = 90;
				}
				else if(trans == "" || trans == "")
				{
					idealadd = -90;
				}
				if(isdefined(anim.covertransangles[trans][i]))
				{
					correctangle = angleclamp180(idealtransangles[i] + idealadd);
					actualangle = angleclamp180(anim.covertransangles[trans][i]);
					if(absangleclamp180(actualangle - correctangle) > 7)
					{
						println(((((((("" + trans) + "") + i) + "") + actualangle) + "") + correctangle) + "");
					}
				}
			}
		}
		for(i = 1; i <= 9; i++)
		{
			for(j = 0; j < transtypes.size; j++)
			{
				trans = transtypes[j];
				idealadd = 0;
				if(trans == "" || trans == "")
				{
					idealadd = 90;
				}
				else if(trans == "" || trans == "")
				{
					idealadd = -90;
				}
				if(isdefined(anim.coverexitangles[trans][i]))
				{
					correctangle = angleclamp180(-1 * ((idealtransangles[i] + idealadd) + 180));
					actualangle = angleclamp180(anim.coverexitangles[trans][i]);
					if(absangleclamp180(actualangle - correctangle) > 7)
					{
						println(((((((("" + trans) + "") + i) + "") + actualangle) + "") + correctangle) + "");
					}
				}
			}
		}
	#/
}

/*
	Name: getexitsplittime
	Namespace: init
	Checksum: 0xEB1FCBB2
	Offset: 0xAF0
	Size: 0x2A
	Parameters: 2
	Flags: None
*/
function getexitsplittime(approachtype, dir)
{
	return anim.coverexitsplit[approachtype][dir];
}

/*
	Name: gettranssplittime
	Namespace: init
	Checksum: 0x9C9BD793
	Offset: 0xB28
	Size: 0x2A
	Parameters: 2
	Flags: None
*/
function gettranssplittime(approachtype, dir)
{
	return anim.covertranssplit[approachtype][dir];
}

/*
	Name: firstinit
	Namespace: init
	Checksum: 0xD73D8988
	Offset: 0xB60
	Size: 0x1C6
	Parameters: 0
	Flags: Linked
*/
function firstinit()
{
	if(isdefined(anim.notfirsttime))
	{
		return;
	}
	anim.notfirsttime = 1;
	anim.grenadetimers[#"player_frag_grenade_sp"] = randomintrange(1000, 20000);
	anim.grenadetimers[#"player_flash_grenade_sp"] = randomintrange(1000, 20000);
	anim.grenadetimers[#"player_double_grenade"] = randomintrange(10000, 60000);
	anim.grenadetimers[#"ai_frag_grenade_sp"] = randomintrange(0, 20000);
	anim.grenadetimers[#"ai_flash_grenade_sp"] = randomintrange(0, 20000);
	anim.numgrenadesinprogresstowardsplayer = 0;
	anim.lastgrenadelandednearplayertime = -1000000;
	anim.lastfraggrenadetoplayerstart = -1000000;
	thread setnextplayergrenadetime();
	if(!isdefined(level.flag))
	{
		level.flag = [];
	}
	level.painai = undefined;
	anim.covercrouchleanpitch = -55;
}

/*
	Name: onplayerconnect
	Namespace: init
	Checksum: 0x1EAF3771
	Offset: 0xD30
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function onplayerconnect()
{
	player = self;
	firstinit();
	player.invul = 0;
}

/*
	Name: setnextplayergrenadetime
	Namespace: init
	Checksum: 0x6DFBAFBF
	Offset: 0xD70
	Size: 0x172
	Parameters: 0
	Flags: Linked
*/
function setnextplayergrenadetime()
{
	waittillframeend();
	if(isdefined(anim.playergrenaderangetime))
	{
		maxtime = int(anim.playergrenaderangetime * 0.7);
		if(maxtime < 1)
		{
			maxtime = 1;
		}
		anim.grenadetimers[#"player_frag_grenade_sp"] = randomintrange(0, maxtime);
		anim.grenadetimers[#"player_flash_grenade_sp"] = randomintrange(0, maxtime);
	}
	if(isdefined(anim.playerdoublegrenadetime))
	{
		maxtime = int(anim.playerdoublegrenadetime);
		mintime = int(maxtime / 2);
		if(maxtime <= mintime)
		{
			maxtime = mintime + 1;
		}
		anim.grenadetimers[#"player_double_grenade"] = randomintrange(mintime, maxtime);
	}
}

/*
	Name: addtomissiles
	Namespace: init
	Checksum: 0x3E29B032
	Offset: 0xEF0
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function addtomissiles(grenade)
{
	if(!isdefined(level.missileentities))
	{
		level.missileentities = [];
	}
	if(!isdefined(level.missileentities))
	{
		level.missileentities = [];
	}
	else if(!isarray(level.missileentities))
	{
		level.missileentities = array(level.missileentities);
	}
	level.missileentities[level.missileentities.size] = grenade;
	while(isdefined(grenade))
	{
		waitframe(1);
	}
	arrayremovevalue(level.missileentities, grenade);
}

/*
	Name: function_960adbea
	Namespace: init
	Checksum: 0xB0FF18DE
	Offset: 0xFD8
	Size: 0x74
	Parameters: 1
	Flags: Event
*/
event function_960adbea(eventstruct)
{
	grenade = eventstruct.projectile;
	weapon = eventstruct.weapon;
	if(isdefined(grenade))
	{
		grenade.owner = self;
		grenade.weapon = weapon;
		level thread addtomissiles(grenade);
	}
}

/*
	Name: function_c6ddaa47
	Namespace: init
	Checksum: 0xBF4E1FE8
	Offset: 0x1058
	Size: 0x64
	Parameters: 1
	Flags: Event
*/
event function_c6ddaa47(eventstruct)
{
	eventstruct.projectile.owner = self;
	eventstruct.projectile.weapon = eventstruct.weapon;
	level thread addtomissiles(eventstruct.projectile);
}

/*
	Name: function_596d3a28
	Namespace: init
	Checksum: 0xB07EC8B4
	Offset: 0x10C8
	Size: 0x64
	Parameters: 1
	Flags: Event
*/
event function_596d3a28(eventstruct)
{
	eventstruct.projectile.owner = self;
	eventstruct.projectile.weapon = eventstruct.weapon;
	level thread addtomissiles(eventstruct.projectile);
}

/*
	Name: end_script
	Namespace: init
	Checksum: 0x80F724D1
	Offset: 0x1138
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function end_script()
{
}

