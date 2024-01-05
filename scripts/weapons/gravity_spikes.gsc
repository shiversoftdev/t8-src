// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\abilities\ability_player.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace gravity_spikes;

/*
	Name: init_shared
	Namespace: gravity_spikes
	Checksum: 0x1D90FAFA
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	ability_player::register_gadget_should_notify(7, 1);
	callback::on_connect(&function_aaef50a);
}

/*
	Name: function_aaef50a
	Namespace: gravity_spikes
	Checksum: 0x28675E50
	Offset: 0xE0
	Size: 0x14
	Parameters: 0
	Flags: None
*/
function function_aaef50a()
{
	thread function_263a039();
}

/*
	Name: function_263a039
	Namespace: gravity_spikes
	Checksum: 0xD1234CAD
	Offset: 0x100
	Size: 0xB0
	Parameters: 0
	Flags: None
*/
function function_263a039()
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"projectile_impact");
		self clientfield::increment("sndRattle", 1);
		scoreevents::processscoreevent(#"hash_5814e5b2ee30cc5a", self, undefined, waitresult.weapon);
		self notify(#"hash_5814e5b2ee30cc5a");
		waitframe(1);
	}
}

