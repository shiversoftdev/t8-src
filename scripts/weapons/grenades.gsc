// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\weaponobjects.gsc;
#using scripts\core_common\clientfield_shared.gsc;

#namespace grenades;

/*
	Name: init_shared
	Namespace: grenades
	Checksum: 0x87B60F9
	Offset: 0x88
	Size: 0xAC
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	weaponobjects::function_e6400478(#"eq_sticky_grenade", &creategrenadewatcher, 1);
	weaponobjects::function_e6400478(#"concussion_grenade", &creategrenadewatcher, 1);
	weaponobjects::function_e6400478(#"hash_5825488ac68418af", &creategrenadewatcher, 1);
}

/*
	Name: creategrenadewatcher
	Namespace: grenades
	Checksum: 0xA8974499
	Offset: 0x140
	Size: 0x26
	Parameters: 1
	Flags: None
*/
function creategrenadewatcher(watcher)
{
	watcher.onspawn = &function_aa95d684;
}

/*
	Name: function_aa95d684
	Namespace: grenades
	Checksum: 0x72B8E77D
	Offset: 0x170
	Size: 0x4C
	Parameters: 2
	Flags: None
*/
function function_aa95d684(watcher, player)
{
	self clientfield::set("enemyequip", 1);
	self thread function_5f86757d();
}

/*
	Name: function_5f86757d
	Namespace: grenades
	Checksum: 0xAAEA4CD2
	Offset: 0x1C8
	Size: 0x6C
	Parameters: 0
	Flags: None
*/
function function_5f86757d()
{
	level endon(#"game_ended");
	self waittill(#"explode", #"death");
	if(!isdefined(self))
	{
		return;
	}
	self clientfield::set("enemyequip", 0);
}

