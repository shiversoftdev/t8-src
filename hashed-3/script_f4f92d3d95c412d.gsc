// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_a3164734;

/*
	Name: function_89f2df9
	Namespace: namespace_a3164734
	Checksum: 0xDDF58610
	Offset: 0x130
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_3c059795b5caee04", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_a3164734
	Checksum: 0xED29EEFD
	Offset: 0x178
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("scriptmover", "collapsesphereflag", 1, 1, "int", &function_fe37390, 0, 0);
	clientfield::register("toplayer", "playerincollapsegrenade", 1, 1, "int", &function_6f48ad35, 0, 0);
}

/*
	Name: function_fe37390
	Namespace: namespace_a3164734
	Checksum: 0x2384BC33
	Offset: 0x218
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function function_fe37390(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	self function_bf9d3071(#"hash_75168376918f5ab7");
	self function_78233d29(#"hash_75168376918f5ab7", "", "Scale", 1);
}

/*
	Name: function_6f48ad35
	Namespace: namespace_a3164734
	Checksum: 0x2613172B
	Offset: 0x2B8
	Size: 0x156
	Parameters: 7
	Flags: Linked
*/
function function_6f48ad35(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newvalue == 1)
	{
		self codeplaypostfxbundle(#"hash_7c7ea03189fe65d8");
		self.var_d8c2003e = playfxoncamera(localclientnum, "wz/fx8_plyr_pstfx_barrier_lvl_01_wz", (0, 0, 0), (1, 0, 0), (0, 0, 1));
		self.var_7b79495b = function_239993de(localclientnum, "wz/fx8_player_outside_circle", self, "tag_origin");
	}
	else
	{
		self codestoppostfxbundle(#"hash_7c7ea03189fe65d8");
		if(isdefined(self.var_d8c2003e))
		{
			deletefx(localclientnum, self.var_d8c2003e, 1);
			self.var_d8c2003e = undefined;
		}
		if(isdefined(self.var_7b79495b))
		{
			killfx(localclientnum, self.var_7b79495b);
			self.var_7b79495b = undefined;
		}
	}
}

