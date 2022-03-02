// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_6115a5707cfb78b3;
#using script_6ef496a1b77e83a4;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_ea8c4bc9;

/*
	Name: function_89f2df9
	Namespace: namespace_ea8c4bc9
	Checksum: 0xBEE2F20C
	Offset: 0xD0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_16f5a81348e35487", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: namespace_ea8c4bc9
	Checksum: 0x82699E77
	Offset: 0x120
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"hash_16f5a81348e35487", "activated", 1, undefined, undefined, &validation, &activation);
}

/*
	Name: validation
	Namespace: namespace_ea8c4bc9
	Checksum: 0x959E9A0
	Offset: 0x1A0
	Size: 0x76
	Parameters: 0
	Flags: Linked
*/
function validation()
{
	if(isdefined(self.var_b773066d) && self.var_b773066d)
	{
		return false;
	}
	if(namespace_5f71460c::is_active() || namespace_7b1a5a90::is_active())
	{
		return false;
	}
	if(self zm_perks::function_80cb4982())
	{
		return false;
	}
	return true;
}

/*
	Name: activation
	Namespace: namespace_ea8c4bc9
	Checksum: 0xD91DA015
	Offset: 0x220
	Size: 0xDA
	Parameters: 0
	Flags: Linked
*/
function activation()
{
	self endon(#"fake_death", #"death", #"player_downed");
	if(!self laststand::player_is_in_laststand() && self.sessionstate != "spectator")
	{
		self thread function_183a26f5();
		for(i = 0; i < 4; i++)
		{
			var_16c042b8 = self zm_perks::function_b2cba45a();
			if(isdefined(var_16c042b8))
			{
				self.var_b773066d = 1;
				continue;
			}
			return;
		}
	}
}

/*
	Name: function_183a26f5
	Namespace: namespace_ea8c4bc9
	Checksum: 0x2FA8920E
	Offset: 0x308
	Size: 0x6A
	Parameters: 0
	Flags: Linked
*/
function function_183a26f5()
{
	self notify(#"hash_46621c50b1ffc556");
	self endon(#"hash_46621c50b1ffc556");
	self waittill(#"fake_death", #"player_downed", #"death");
	if(isdefined(self))
	{
		self.var_b773066d = undefined;
	}
}

