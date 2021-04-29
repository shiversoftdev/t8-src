// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_708634f09dc66b3;
#using script_8988fdbc78d6c53;
#using scripts\core_common\system_shared.gsc;

#namespace claymore;

/*
	Name: function_89f2df9
	Namespace: claymore
	Checksum: 0xF6FD6A84
	Offset: 0xB0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"claymore", &init_shared, undefined, undefined);
}

/*
	Name: init_shared
	Namespace: claymore
	Checksum: 0x2CFFCF19
	Offset: 0xF8
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	weaponobjects::function_e6400478("claymore", &createclaymorewatcher, 0);
}

/*
	Name: createclaymorewatcher
	Namespace: claymore
	Checksum: 0xE57C47FE
	Offset: 0x130
	Size: 0x18E
	Parameters: 1
	Flags: None
*/
function createclaymorewatcher(watcher)
{
	watcher.watchforfire = 1;
	watcher.activatesound = #"wpn_claymore_alert";
	watcher.hackable = 1;
	watcher.hackertoolradius = level.equipmenthackertoolradius;
	watcher.hackertooltimems = level.equipmenthackertooltimems;
	watcher.ownergetsassist = 1;
	watcher.ignoredirection = undefined;
	watcher.immediatedetonation = 1;
	watcher.immunespecialty = "specialty_immunetriggerbetty";
	watcher.deleteonplayerspawn = 0;
	watcher.detectiondot = cos(70);
	watcher.detectionmindist = 20;
	watcher.detectiongraceperiod = 0.6;
	watcher.stuntime = 1;
	watcher.ondetonatecallback = &proximity_grenade::proximitydetonate;
	watcher.onfizzleout = &weaponobjects::weaponobjectfizzleout;
	watcher.onspawn = &function_c9893179;
	watcher.stun = &weaponobjects::weaponstun;
	watcher.var_994b472b = &function_aeb91d3;
}

/*
	Name: function_aeb91d3
	Namespace: claymore
	Checksum: 0x2CC35C54
	Offset: 0x2C8
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function function_aeb91d3(player)
{
	self weaponobjects::weaponobjectfizzleout();
}

/*
	Name: function_c9893179
	Namespace: claymore
	Checksum: 0xA03511A5
	Offset: 0x2F8
	Size: 0x52
	Parameters: 2
	Flags: None
*/
function function_c9893179(watcher, player)
{
	proximity_grenade::onspawnproximitygrenadeweaponobject(watcher, player);
	self.weapon = getweapon(#"claymore");
}

