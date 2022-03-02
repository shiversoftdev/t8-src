// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_20ac552ee498eb9d;
#using script_2255a7ad3edc838f;
#using script_2e7b2ce35bae89d9;
#using script_35b5ff21c2a0960f;
#using script_522aeb6ae906391e;
#using script_79a7e1c31a3e8cc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\gametypes\globallogic.gsc;
#using scripts\zm_common\gametypes\globallogic_actor.gsc;
#using scripts\zm_common\gametypes\globallogic_player.gsc;
#using scripts\zm_common\gametypes\hostmigration.gsc;

#namespace callback;

/*
	Name: function_89f2df9
	Namespace: callback
	Checksum: 0xA3F17E44
	Offset: 0xE0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"callback", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: callback
	Checksum: 0x4998828D
	Offset: 0x128
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level thread setup_callbacks();
}

/*
	Name: setup_callbacks
	Namespace: callback
	Checksum: 0x4A0B0DA6
	Offset: 0x150
	Size: 0xF2
	Parameters: 0
	Flags: Linked
*/
function setup_callbacks()
{
	setdefaultcallbacks();
	level.idflags_noflag = 0;
	level.idflags_radius = 1;
	level.idflags_no_armor = 2;
	level.idflags_no_knockback = 4;
	level.idflags_penetration = 8;
	level.idflags_destructible_entity = 16;
	level.idflags_shield_explosive_impact = 32;
	level.idflags_shield_explosive_impact_huge = 64;
	level.idflags_shield_explosive_splash = 128;
	level.idflags_hurt_trigger_allow_laststand = 256;
	level.idflags_disable_ragdoll_skip = 512;
	level.idflags_no_team_protection = 8192;
	level.var_598c4d23 = 16384;
	level.var_681a9181 = 32768;
}

/*
	Name: setdefaultcallbacks
	Namespace: callback
	Checksum: 0xD92281B5
	Offset: 0x250
	Size: 0x19A
	Parameters: 0
	Flags: Linked
*/
function setdefaultcallbacks()
{
	level.callbackstartgametype = &globallogic::callback_startgametype;
	level.callbackplayerconnect = &globallogic_player::callback_playerconnect;
	level.callbackplayerdisconnect = &globallogic_player::callback_playerdisconnect;
	level.callbackplayermelee = &globallogic_player::callback_playermelee;
	level.callbackactorspawned = &globallogic_actor::callback_actorspawned;
	level.callbackactorcloned = &globallogic_actor::callback_actorcloned;
	level.var_6788bf11 = &namespace_e42b3e24::function_8c7ec52f;
	level.callbackvehiclespawned = &globallogic_vehicle::callback_vehiclespawned;
	level.callbackplayermigrated = &globallogic_player::callback_playermigrated;
	level.callbackhostmigration = &hostmigration::callback_hostmigration;
	level.callbackhostmigrationsave = &hostmigration::callback_hostmigrationsave;
	level.callbackprehostmigrationsave = &hostmigration::callback_prehostmigrationsave;
	level.callbackbotentereduseredge = &bot::callback_botentereduseredge;
	level.callbackbotcreateplayerbot = &bot::function_c6e29bdf;
	level.callbackbotshutdown = &bot::function_3d575aa3;
	level.var_69959686 = &deployable::function_209fda28;
	level._gametype_default = "zclassic";
}

/*
	Name: function_6e6149a6
	Namespace: callback
	Checksum: 0xD0C38D3D
	Offset: 0x3F8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_6e6149a6(func, obj)
{
	add_callback(#"hash_1eda827ff5e6895b", func, obj);
}

/*
	Name: function_823e7181
	Namespace: callback
	Checksum: 0x18105E8A
	Offset: 0x440
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_823e7181(func, obj)
{
	remove_callback(#"hash_34edc1c4f45e5572", func, obj);
}

/*
	Name: function_4b58e5ab
	Namespace: callback
	Checksum: 0xC64C7C3E
	Offset: 0x488
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_4b58e5ab(func, obj)
{
	add_callback(#"hash_210adcf09e99fba1", func, obj);
}

/*
	Name: function_66d5d485
	Namespace: callback
	Checksum: 0x3135AD6F
	Offset: 0x4D0
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_66d5d485(func, obj)
{
	remove_callback(#"hash_1863ba8e81df2a64", func, obj);
}

/*
	Name: function_74872db6
	Namespace: callback
	Checksum: 0x688AA04F
	Offset: 0x518
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_74872db6(func, obj)
{
	add_callback(#"hash_6df5348c2fb9a509", func, obj);
}

/*
	Name: function_50fdac80
	Namespace: callback
	Checksum: 0xA3B2ED01
	Offset: 0x560
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_50fdac80(func, obj)
{
	remove_callback(#"hash_6df5348c2fb9a509", func, obj);
}

/*
	Name: function_189f87c1
	Namespace: callback
	Checksum: 0x2D53879D
	Offset: 0x5A8
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_189f87c1(func, obj)
{
	add_callback(#"hash_193ded5c8932fe29", func, obj);
}

/*
	Name: function_ec6dfc37
	Namespace: callback
	Checksum: 0x1AEA7DE4
	Offset: 0x5F0
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_ec6dfc37(func, obj)
{
	remove_callback(#"hash_193ded5c8932fe29", func, obj);
}

/*
	Name: function_b3c9adb7
	Namespace: callback
	Checksum: 0xF1BAA418
	Offset: 0x638
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_b3c9adb7(func, obj)
{
	add_callback(#"hash_7d40e25056b9275c", func, obj);
}

/*
	Name: function_342b2f6
	Namespace: callback
	Checksum: 0x20226EE8
	Offset: 0x680
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_342b2f6(func, obj)
{
	remove_callback(#"hash_7d40e25056b9275c", func, obj);
}

/*
	Name: function_aebeafc0
	Namespace: callback
	Checksum: 0x64D758D3
	Offset: 0x6C8
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_aebeafc0(func, obj)
{
	add_callback(#"hash_790b67aca1bf8fc0", func, obj);
}

/*
	Name: function_3e2ed898
	Namespace: callback
	Checksum: 0xD51794D4
	Offset: 0x710
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_3e2ed898(func, obj)
{
	remove_callback(#"hash_790b67aca1bf8fc0", func, obj);
}

