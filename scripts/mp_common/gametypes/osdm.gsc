// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\gametypes\dm.gsc;
#using scripts\mp_common\gametypes\globallogic_audio.gsc;
#using scripts\mp_common\gametypes\os.gsc;

#namespace namespace_82ae72f6;

/*
	Name: main
	Namespace: namespace_82ae72f6
	Checksum: 0xFB55F198
	Offset: 0xA8
	Size: 0x64
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	dm::main();
	os::turn_back_time("dm");
	globallogic_audio::set_leader_gametype_dialog("osStartFfa", "", "gameBoost", "gameBoost");
}

