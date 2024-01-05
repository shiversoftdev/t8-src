// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\clientfield_shared.csc;

#namespace namespace_f2050961;

/*
	Name: init
	Namespace: namespace_f2050961
	Checksum: 0x2AE49D26
	Offset: 0x90
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	clientfield::register("toplayer", "" + #"hash_686e5c0d7af86361", 16000, 1, "int", &function_be33348b, 0, 0);
}

/*
	Name: function_be33348b
	Namespace: namespace_f2050961
	Checksum: 0xEBBDA42E
	Offset: 0xF8
	Size: 0x154
	Parameters: 7
	Flags: Linked
*/
function function_be33348b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self postfx::playpostfxbundle(#"pstfx_blood_wash");
		self postfx::playpostfxbundle(#"pstfx_zm_acid_dmg");
		self postfx::playpostfxbundle(#"hash_25c3aa91c32db43c");
		self.var_431ddde9 = self playloopsound(#"hash_341a3fa00975f232");
	}
	else
	{
		self postfx::exitpostfxbundle(#"pstfx_blood_wash");
		self postfx::exitpostfxbundle(#"pstfx_zm_acid_dmg");
		self postfx::exitpostfxbundle(#"hash_25c3aa91c32db43c");
		if(isdefined(self.var_431ddde9))
		{
			self stoploopsound(self.var_431ddde9);
		}
	}
}

