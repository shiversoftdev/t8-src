// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\clientfield_shared.csc;

#namespace gadget_combat_efficiency;

/*
	Name: __init__system__
	Namespace: gadget_combat_efficiency
	Checksum: 0x1380DD1E
	Offset: 0xB0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"gadget_combat_efficiency", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: gadget_combat_efficiency
	Checksum: 0xA66815CA
	Offset: 0xF8
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	clientfield::register("clientuimodel", "hudItems.combatEfficiencyActive", 1, 1, "int", &function_24a1439f, 0, 0);
}

/*
	Name: function_24a1439f
	Namespace: gadget_combat_efficiency
	Checksum: 0x4C369A6C
	Offset: 0x150
	Size: 0x126
	Parameters: 7
	Flags: None
*/
function function_24a1439f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(newval) && newval > 0)
	{
		if(newval != oldval)
		{
			self playsound(localclientnum, #"hash_3eea09f794eb0577");
		}
		if(!isdefined(self.var_8db0b9f5))
		{
			self.var_8db0b9f5 = self playloopsound(#"hash_1a6eca90431e5c64");
		}
	}
	else if(isdefined(self.var_8db0b9f5))
	{
		self stoploopsound(self.var_8db0b9f5);
		self playsound(localclientnum, #"hash_529910b20b42ef5b");
		self.var_8db0b9f5 = undefined;
	}
}

