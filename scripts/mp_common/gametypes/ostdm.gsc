// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\gametypes\globallogic_audio.gsc;
#using scripts\mp_common\gametypes\os.gsc;
#using scripts\mp_common\gametypes\tdm.gsc;

#namespace ostdm;

/*
	Name: main
	Namespace: ostdm
	Checksum: 0xBC31A217
	Offset: 0xA8
	Size: 0x64
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	tdm::main();
	os::turn_back_time("tdm");
	globallogic_audio::set_leader_gametype_dialog("osStartTdm", "", "gameBoost", "gameBoost");
}

