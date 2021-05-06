// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_47fb62300ac0bd60;
#using script_8988fdbc78d6c53;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace sprint_boost_grenade;

/*
	Name: function_89f2df9
	Namespace: sprint_boost_grenade
	Checksum: 0x769F28E9
	Offset: 0x90
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"sprint_boost_grenade", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: sprint_boost_grenade
	Checksum: 0x452EBAAE
	Offset: 0xD8
	Size: 0x94
	Parameters: 0
	Flags: None
*/
function __init__()
{
	level._effect[#"satchel_charge_enemy_light"] = #"weapon/fx_c4_light_orng";
	level._effect[#"satchel_charge_friendly_light"] = #"weapon/fx_c4_light_blue";
	weaponobjects::function_e6400478(#"sprint_boost_grenade", &create_grenade_watcher, 1);
}

/*
	Name: create_grenade_watcher
	Namespace: sprint_boost_grenade
	Checksum: 0xF9704264
	Offset: 0x178
	Size: 0x6E
	Parameters: 1
	Flags: None
*/
function create_grenade_watcher(watcher)
{
	watcher.watchforfire = 1;
	watcher.hackable = 1;
	watcher.hackertoolradius = level.equipmenthackertoolradius;
	watcher.hackertooltimems = level.equipmenthackertooltimems;
	watcher.onspawn = &grenade_spawn;
}

/*
	Name: grenade_spawn
	Namespace: sprint_boost_grenade
	Checksum: 0x949D5048
	Offset: 0x1F0
	Size: 0x194
	Parameters: 2
	Flags: None
*/
function grenade_spawn(watcher, owner)
{
	self endon(#"grenade_timeout");
	self thread grenade_timeout(10);
	self thread weaponobjects::onspawnuseweaponobject(watcher, owner);
	radius = self.weapon.sprintboostradius;
	duration = self.weapon.sprintboostduration;
	if(!(isdefined(self.previouslyhacked) && self.previouslyhacked))
	{
		if(isdefined(owner))
		{
			owner stats::function_e24eec31(self.weapon, #"used", 1);
			origin = owner.origin;
		}
		boost_on_throw = 1;
		detonated = 0;
		if(!boost_on_throw)
		{
			waitresult = undefined;
			waitresult = self waittill(#"explode");
			detonated = 1;
		}
		level thread apply_sprint_boost_to_players(owner, waitresult.position, radius, duration);
		if(!detonated)
		{
			self detonate(owner);
		}
	}
}

/*
	Name: grenade_timeout
	Namespace: sprint_boost_grenade
	Checksum: 0x5E98952B
	Offset: 0x390
	Size: 0x86
	Parameters: 1
	Flags: None
*/
function grenade_timeout(timeout)
{
	self endon(#"death");
	frames = int(timeout / float(function_60d95f53()) / 1000);
	waitframe(frames);
	self notify(#"grenade_timeout");
}

/*
	Name: apply_sprint_boost_to_players
	Namespace: sprint_boost_grenade
	Checksum: 0xFC5D3537
	Offset: 0x420
	Size: 0x178
	Parameters: 4
	Flags: None
*/
function apply_sprint_boost_to_players(owner, origin, radius, duration)
{
	if(!isdefined(owner))
	{
		return;
	}
	if(!isdefined(owner.team))
	{
		return;
	}
	if(!isdefined(origin))
	{
		return;
	}
	radiussq = (isdefined(radius) ? radius : 150) * (isdefined(radius) ? radius : 150);
	foreach(player in level.players)
	{
		if(!isplayer(player))
		{
			continue;
		}
		if(util::function_fbce7263(player.team, owner.team))
		{
			continue;
		}
		if(distancesquared(player.origin, origin) > radiussq)
		{
			continue;
		}
		player thread apply_sprint_boost(duration);
	}
}

/*
	Name: apply_sprint_boost
	Namespace: sprint_boost_grenade
	Checksum: 0xE30C3388
	Offset: 0x5A0
	Size: 0x124
	Parameters: 1
	Flags: None
*/
function apply_sprint_boost(duration)
{
	player = self;
	player endon(#"death", #"disconnect");
	player notify(#"apply_sprint_boost_singleton");
	player endon(#"apply_sprint_boost_singleton");
	player setsprintboost(1);
	duration = math::clamp((isdefined(duration) ? duration : 10), 1, 1200);
	frames_to_wait = int(duration / float(function_60d95f53()) / 1000);
	waitframe(frames_to_wait);
	player setsprintboost(0);
}

