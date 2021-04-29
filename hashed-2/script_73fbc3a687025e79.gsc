// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f9e0dc8454d98e1;
#using script_9e4105ea1798ccc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_eb173264;

/*
	Name: function_89f2df9
	Namespace: namespace_eb173264
	Checksum: 0x35DC4EFD
	Offset: 0xB0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_53f12a7ebb3e91ac", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: namespace_eb173264
	Checksum: 0xC29C8773
	Offset: 0x100
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"hash_53f12a7ebb3e91ac", "activated", 1, undefined, undefined, &validation, &activation);
	namespace_ad4d960b::register(#"hash_7bfec2f0ecb46104", 1);
}

/*
	Name: validation
	Namespace: namespace_eb173264
	Checksum: 0x8D58E716
	Offset: 0x1A8
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function validation()
{
	if(self namespace_ad4d960b::get(#"hash_7bfec2f0ecb46104") == 100)
	{
		return 0;
	}
	return !(isdefined(self bgb::function_ff7c0158()) && self bgb::function_ff7c0158());
}

/*
	Name: activation
	Namespace: namespace_eb173264
	Checksum: 0xCE8A8D9
	Offset: 0x210
	Size: 0x130
	Parameters: 0
	Flags: Linked
*/
function activation()
{
	foreach(player in getplayers())
	{
		if(self === player || (!player laststand::player_is_in_laststand() && isalive(player) && distance2dsquared(player.origin, self.origin) < 250000))
		{
			player namespace_ad4d960b::remove(#"hash_7bfec2f0ecb46104", 1);
			player namespace_ad4d960b::add(#"hash_7bfec2f0ecb46104", 100, 100);
		}
	}
}

