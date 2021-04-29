// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_708634f09dc66b3;
#using script_7a7230237f77d815;
#using script_8988fdbc78d6c53;

#namespace namespace_9bf1b425;

/*
	Name: function_ae7e49da
	Namespace: namespace_9bf1b425
	Checksum: 0x103E0633
	Offset: 0xA0
	Size: 0x19A
	Parameters: 1
	Flags: None
*/
function function_ae7e49da(watcher)
{
	watcher.watchforfire = 1;
	watcher.activatesound = #"wpn_claymore_alert";
	watcher.hackable = 0;
	watcher.hackertoolradius = level.equipmenthackertoolradius;
	watcher.hackertooltimems = level.equipmenthackertooltimems;
	watcher.activatefx = 1;
	watcher.ownergetsassist = 1;
	watcher.ignoredirection = undefined;
	watcher.immediatedetonation = 1;
	watcher.immunespecialty = "specialty_immunetriggerbetty";
	watcher.detectiondot = cos(70);
	watcher.detectionmindist = 20;
	watcher.detectiongraceperiod = 0.6;
	watcher.stuntime = 3;
	watcher.notequipment = 1;
	watcher.activationdelay = 0.5;
	watcher.ondetonatecallback = &proximity_grenade::proximitydetonate;
	watcher.onfizzleout = &weaponobjects::weaponobjectfizzleout;
	watcher.onspawn = &proximity_grenade::onspawnproximitygrenadeweaponobject;
	watcher.stun = &weaponobjects::weaponstun;
	return watcher;
}

/*
	Name: function_1daa29fc
	Namespace: namespace_9bf1b425
	Checksum: 0x22CD3769
	Offset: 0x248
	Size: 0x17A
	Parameters: 1
	Flags: None
*/
function function_1daa29fc(watcher)
{
	watcher.watchforfire = 1;
	watcher.activatesound = #"wpn_claymore_alert";
	watcher.hackable = 0;
	watcher.hackertoolradius = level.equipmenthackertoolradius;
	watcher.hackertooltimems = level.equipmenthackertooltimems;
	watcher.activatefx = 1;
	watcher.ownergetsassist = 1;
	watcher.ignoredirection = 1;
	watcher.immediatedetonation = 1;
	watcher.immunespecialty = "specialty_immunetriggerbetty";
	watcher.detectionmindist = 64;
	watcher.detectiongraceperiod = 0.6;
	watcher.stuntime = 3;
	watcher.notequipment = 1;
	watcher.activationdelay = 0.5;
	watcher.ondetonatecallback = &proximity_grenade::proximitydetonate;
	watcher.onfizzleout = &weaponobjects::weaponobjectfizzleout;
	watcher.onspawn = &proximity_grenade::onspawnproximitygrenadeweaponobject;
	watcher.stun = &weaponobjects::weaponstun;
	return watcher;
}

/*
	Name: function_d8d3b49b
	Namespace: namespace_9bf1b425
	Checksum: 0xA29AB1DE
	Offset: 0x3D0
	Size: 0x17A
	Parameters: 1
	Flags: None
*/
function function_d8d3b49b(watcher)
{
	watcher.watchforfire = 1;
	watcher.activatesound = #"wpn_claymore_alert";
	watcher.hackable = 0;
	watcher.hackertoolradius = level.equipmenthackertoolradius;
	watcher.hackertooltimems = level.equipmenthackertooltimems;
	watcher.activatefx = 1;
	watcher.ownergetsassist = 1;
	watcher.ignoredirection = 1;
	watcher.immediatedetonation = 1;
	watcher.immunespecialty = "specialty_immunetriggerbetty";
	watcher.detectionmindist = 64;
	watcher.detectiongraceperiod = 0.6;
	watcher.stuntime = 3;
	watcher.notequipment = 1;
	watcher.activationdelay = 0.5;
	watcher.ondetonatecallback = &proximity_grenade::proximitydetonate;
	watcher.onfizzleout = &weaponobjects::weaponobjectfizzleout;
	watcher.onspawn = &proximity_grenade::onspawnproximitygrenadeweaponobject;
	watcher.stun = &weaponobjects::weaponstun;
	return watcher;
}

/*
	Name: function_518130e
	Namespace: namespace_9bf1b425
	Checksum: 0xFB1BB619
	Offset: 0x558
	Size: 0x17A
	Parameters: 1
	Flags: None
*/
function function_518130e(watcher)
{
	watcher.watchforfire = 1;
	watcher.activatesound = #"wpn_claymore_alert";
	watcher.hackable = 0;
	watcher.hackertoolradius = level.equipmenthackertoolradius;
	watcher.hackertooltimems = level.equipmenthackertooltimems;
	watcher.activatefx = 1;
	watcher.ownergetsassist = 1;
	watcher.ignoredirection = 1;
	watcher.immediatedetonation = 1;
	watcher.immunespecialty = "specialty_immunetriggerbetty";
	watcher.detectionmindist = 64;
	watcher.detectiongraceperiod = 0.6;
	watcher.stuntime = 3;
	watcher.notequipment = 1;
	watcher.activationdelay = 0.5;
	watcher.ondetonatecallback = &function_367f94ba;
	watcher.onfizzleout = &weaponobjects::weaponobjectfizzleout;
	watcher.onspawn = &proximity_grenade::onspawnproximitygrenadeweaponobject;
	watcher.stun = &weaponobjects::weaponstun;
	return watcher;
}

/*
	Name: function_367f94ba
	Namespace: namespace_9bf1b425
	Checksum: 0xE0ECC0E2
	Offset: 0x6E0
	Size: 0xCC
	Parameters: 3
	Flags: None
*/
function function_367f94ba(attacker, weapon, target)
{
	self.killcament.starttime = gettime();
	self molotov::function_462c8632(self.owner, self.origin, (0, 0, 1), vectorscale((0, 0, -1), 400), self.killcament, weapon, self.team, getscriptbundle(self.weapon.var_4dd46f8a));
	self hide();
	wait(10);
	self delete();
}

