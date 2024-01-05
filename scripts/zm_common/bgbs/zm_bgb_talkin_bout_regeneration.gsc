// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;

#namespace zm_bgb_talkin_bout_regeneration;

/*
	Name: __init__system__
	Namespace: zm_bgb_talkin_bout_regeneration
	Checksum: 0xE7C3A9DB
	Offset: 0xB0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_bgb_talkin_bout_regeneration", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_talkin_bout_regeneration
	Checksum: 0xDA4380B9
	Offset: 0x100
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"zm_bgb_talkin_bout_regeneration", "time", 240, &enable, &disable, undefined, undefined);
	bgb::function_e1f37ce7(#"zm_bgb_talkin_bout_regeneration");
}

/*
	Name: enable
	Namespace: zm_bgb_talkin_bout_regeneration
	Checksum: 0x840DBDCD
	Offset: 0x1A0
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function enable()
{
	self thread function_c0c85fe();
}

/*
	Name: disable
	Namespace: zm_bgb_talkin_bout_regeneration
	Checksum: 0xB8DE61C6
	Offset: 0x1C8
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function disable()
{
	self notify(#"hash_fcaa137035db4e");
	val::reset(#"zm_bgb_talkin_bout_regeneration", "ignore_health_regen_delay");
}

/*
	Name: function_c0c85fe
	Namespace: zm_bgb_talkin_bout_regeneration
	Checksum: 0xDE4C0EA7
	Offset: 0x210
	Size: 0x146
	Parameters: 0
	Flags: Linked
*/
function function_c0c85fe()
{
	self endon(#"death", #"hash_fcaa137035db4e");
	var_47624402 = 0;
	while(true)
	{
		var_197c85d1 = self getvelocity();
		var_9b7f7d9b = length(var_197c85d1);
		if(var_9b7f7d9b > 0 && !self laststand::player_is_in_laststand() && (var_197c85d1[0] != 0 || var_197c85d1[1] != 0))
		{
			if(!var_47624402)
			{
				var_47624402 = 1;
				self val::set(#"zm_bgb_talkin_bout_regeneration", "ignore_health_regen_delay", 1);
			}
		}
		else if(var_47624402)
		{
			var_47624402 = 0;
			self val::reset(#"zm_bgb_talkin_bout_regeneration", "ignore_health_regen_delay");
		}
		waitframe(1);
	}
}

