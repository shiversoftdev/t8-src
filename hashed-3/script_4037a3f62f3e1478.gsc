// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace namespace_1a2bd81f;

/*
	Name: function_89f2df9
	Namespace: namespace_1a2bd81f
	Checksum: 0xCC4C2990
	Offset: 0xC8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_d287d6d0be9f28c", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_1a2bd81f
	Checksum: 0xF4AE1A00
	Offset: 0x110
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(getdvarint(#"hash_d287d6d0be9f28c", 0))
	{
		clientfield::register("actor", "" + #"hash_59e8c30d5e28dad3", 14000, 1, "int", &function_b245ef9e, 0, 0);
		clientfield::register("scriptmover", "" + #"hash_d260ef4191c5b3d", 14000, 1, "int", &function_9a20c93e, 0, 0);
	}
}

/*
	Name: function_b245ef9e
	Namespace: namespace_1a2bd81f
	Checksum: 0xC990B76D
	Offset: 0x1F0
	Size: 0x8C
	Parameters: 7
	Flags: Linked
*/
function function_b245ef9e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self zm_utility::function_3a020b0f(localclientnum, "rob_zm_eyes_green", #"wz/fx8_zombie_eye_glow_green_wz");
	}
	else
	{
		self zm_utility::function_704f7c0e(localclientnum);
	}
}

/*
	Name: function_9a20c93e
	Namespace: namespace_1a2bd81f
	Checksum: 0x50B2D231
	Offset: 0x288
	Size: 0x146
	Parameters: 7
	Flags: Linked
*/
function function_9a20c93e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_c9d177e8 = util::playfxontag(localclientnum, #"hash_286e0d228779181", self, "tag_origin");
		if(!isdefined(self.var_2a145797))
		{
			self playsound(localclientnum, #"zmb_sq_souls_release");
			self.var_2a145797 = self playloopsound(#"zmb_sq_souls_lp");
		}
	}
	else if(isdefined(self.var_c9d177e8))
	{
		killfx(localclientnum, self.var_c9d177e8);
		self.var_c9d177e8 = undefined;
	}
	if(isdefined(self.var_2a145797))
	{
		self stoploopsound(self.var_2a145797);
		self.var_2a145797 = undefined;
	}
}

