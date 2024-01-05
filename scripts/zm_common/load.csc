// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_aoe.csc;
#using scripts\weapons\zm\weaponobjects.csc;
#using scripts\zm_common\zm_traps.csc;
#using scripts\zm_common\zm_score.csc;
#using scripts\zm_common\zm_magicbox.csc;
#using scripts\zm_common\zm_customgame.csc;
#using scripts\zm_common\zm_audio.csc;
#using scripts\zm_common\zm.csc;
#using scripts\zm_common\global_fx.csc;
#using scripts\zm_common\ambient.csc;
#using scripts\core_common\vehicles\driving_fx.csc;
#using scripts\core_common\vehicle_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\turret_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\load_shared.csc;
#using scripts\core_common\footsteps_shared.csc;
#using scripts\core_common\fx_shared.csc;
#using scripts\core_common\flagsys_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\clientfaceanim_shared.csc;

#namespace load;

/*
	Name: levelnotifyhandler
	Namespace: load
	Checksum: 0xF5DAE872
	Offset: 0x140
	Size: 0x3A
	Parameters: 3
	Flags: Linked
*/
function levelnotifyhandler(clientnum, state, oldstate)
{
	if(state != "")
	{
		level notify(state, clientnum);
	}
}

/*
	Name: warnmissilelocking
	Namespace: load
	Checksum: 0xAC6C2FE9
	Offset: 0x188
	Size: 0x14
	Parameters: 2
	Flags: None
*/
function warnmissilelocking(localclientnum, set)
{
}

/*
	Name: warnmissilelocked
	Namespace: load
	Checksum: 0xE535A043
	Offset: 0x1A8
	Size: 0x14
	Parameters: 2
	Flags: None
*/
function warnmissilelocked(localclientnum, set)
{
}

/*
	Name: warnmissilefired
	Namespace: load
	Checksum: 0x9796FE04
	Offset: 0x1C8
	Size: 0x14
	Parameters: 2
	Flags: None
*/
function warnmissilefired(localclientnum, set)
{
}

/*
	Name: main
	Namespace: load
	Checksum: 0x2150D358
	Offset: 0x1E8
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function main()
{
	/#
		/#
			assert(isdefined(level.first_frame), "");
		#/
	#/
	zm::init();
	level thread util::init_utility();
	util::register_system(#"levelnotify", &levelnotifyhandler);
	register_clientfields();
	level.createfx_disable_fx = getdvarint(#"disable_fx", 0) == 1;
	system::wait_till("all");
	level thread art_review();
	level flagsys::set(#"load_main_complete");
}

/*
	Name: register_clientfields
	Namespace: load
	Checksum: 0xC6CF8FF9
	Offset: 0x310
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function register_clientfields()
{
	clientfield::register("allplayers", "zmbLastStand", 1, 1, "int", &zm::laststand, 0, 1);
}

