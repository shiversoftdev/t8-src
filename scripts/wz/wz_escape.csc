// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\wz_nixie_tubes.csc;
#using scripts\mp_common\item_world.csc;
#using scripts\wz\wz_escape_ffotd.csc;
#using scripts\core_common\exploder_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\mp_common\load.csc;

#namespace wz_escape;

/*
	Name: main
	Namespace: wz_escape
	Checksum: 0xD9B1C720
	Offset: 0xB8
	Size: 0x1E4
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	setsaveddvar(#"enable_global_wind", 1);
	setsaveddvar(#"wind_global_vector", "88 0 0");
	setsaveddvar(#"wind_global_low_altitude", 0);
	setsaveddvar(#"wind_global_hi_altitude", 10000);
	setsaveddvar(#"wind_global_low_strength_percent", 100);
	load::main();
	setdvar(#"cg_aggressivecullradius", 100);
	setdvar(#"hash_53f625ed150e7700", 12000);
	if(isdefined(getgametypesetting(#"hash_26f00de198472b81")) && getgametypesetting(#"hash_26f00de198472b81"))
	{
		setdvar(#"hash_53f625ed150e7700", 6000);
	}
	util::waitforclient(0);
	level.sensor_dart_radius = 1200;
	level thread function_e656c6cb();
}

/*
	Name: function_e656c6cb
	Namespace: wz_escape
	Checksum: 0xAB20ED31
	Offset: 0x2A8
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_e656c6cb()
{
	item_world::function_4de3ca98();
	exploder::exploder("fxexp_portal_idle");
}

