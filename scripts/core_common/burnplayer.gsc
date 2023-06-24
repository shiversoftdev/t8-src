// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace burnplayer;

/*
	Name: __init__system__
	Namespace: burnplayer
	Checksum: 0xD053C3E3
	Offset: 0xC0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"burnplayer", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: burnplayer
	Checksum: 0xE0843E7A
	Offset: 0x108
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("allplayers", "burn", 1, 1, "int");
	clientfield::register("playercorpse", "burned_effect", 1, 1, "int");
}

/*
	Name: setplayerburning
	Namespace: burnplayer
	Checksum: 0x5E5F1C1F
	Offset: 0x178
	Size: 0xB4
	Parameters: 5
	Flags: Linked
*/
function setplayerburning(duration, interval, damageperinterval, attacker, weapon)
{
	self clientfield::set("burn", 1);
	self thread watchburntimer(duration);
	self thread watchburndamage(interval, damageperinterval, attacker, weapon);
	self thread watchforwater();
	self thread watchburnfinished();
}

/*
	Name: takingburndamage
	Namespace: burnplayer
	Checksum: 0xC19F31C7
	Offset: 0x238
	Size: 0xC4
	Parameters: 3
	Flags: None
*/
function takingburndamage(eattacker, weapon, smeansofdeath)
{
	if(isdefined(self.doing_scripted_burn_damage))
	{
		self.doing_scripted_burn_damage = undefined;
		return;
	}
	if(weapon == level.weaponnone)
	{
		return;
	}
	if(weapon.burnduration == 0)
	{
		return;
	}
	self setplayerburning(float(weapon.burnduration) / 1000, float(weapon.burndamageinterval) / 1000, weapon.burndamage, eattacker, weapon);
}

/*
	Name: watchburnfinished
	Namespace: burnplayer
	Checksum: 0x40310B31
	Offset: 0x308
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function watchburnfinished()
{
	self endon(#"disconnect");
	self waittill(#"death", #"burn_finished");
	self clientfield::set("burn", 0);
}

/*
	Name: watchburntimer
	Namespace: burnplayer
	Checksum: 0x361396F3
	Offset: 0x370
	Size: 0x66
	Parameters: 1
	Flags: Linked
*/
function watchburntimer(duration)
{
	self notify(#"burnplayer_watchburntimer");
	self endon(#"burnplayer_watchburntimer", #"disconnect", #"death");
	wait(duration);
	self notify(#"burn_finished");
}

/*
	Name: watchburndamage
	Namespace: burnplayer
	Checksum: 0xE2A07A4B
	Offset: 0x3E0
	Size: 0xD2
	Parameters: 4
	Flags: Linked
*/
function watchburndamage(interval, damage, attacker, weapon)
{
	if(damage == 0)
	{
		return;
	}
	self endon(#"disconnect", #"death", #"burnplayer_watchburntimer", #"burn_finished");
	while(true)
	{
		wait(interval);
		self.doing_scripted_burn_damage = 1;
		self dodamage(damage, self.origin, attacker, undefined, undefined, "MOD_BURNED", 0, weapon);
		self.doing_scripted_burn_damage = undefined;
	}
}

/*
	Name: watchforwater
	Namespace: burnplayer
	Checksum: 0x43FFFEF2
	Offset: 0x4C0
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function watchforwater()
{
	self endon(#"disconnect", #"death", #"burn_finished");
	while(true)
	{
		if(self isplayerunderwater())
		{
			self notify(#"burn_finished");
		}
		wait(0.05);
	}
}

