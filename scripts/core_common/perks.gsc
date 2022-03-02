// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace perks;

/*
	Name: function_7637bafa
	Namespace: perks
	Checksum: 0x8219A3D3
	Offset: 0x68
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function function_7637bafa(str_perk)
{
	if(!isdefined(self.var_fb3c9d6a))
	{
		self.var_fb3c9d6a = [];
	}
	if(!isdefined(self.var_fb3c9d6a[str_perk]))
	{
		self.var_fb3c9d6a[str_perk] = 0;
	}
	/#
		assert(self.var_fb3c9d6a[str_perk] >= 0, "");
	#/
	/#
		assert(self.var_fb3c9d6a[str_perk] < 23, "");
	#/
	self.var_fb3c9d6a[str_perk]++;
	self setperk(str_perk);
}

/*
	Name: function_45d12554
	Namespace: perks
	Checksum: 0x789E35B0
	Offset: 0x148
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function function_45d12554(str_perk)
{
	if(!isdefined(self.var_fb3c9d6a))
	{
		self.var_fb3c9d6a = [];
	}
	if(!isdefined(self.var_fb3c9d6a[str_perk]))
	{
		self.var_fb3c9d6a[str_perk] = 0;
	}
	self.var_fb3c9d6a[str_perk]--;
	/#
		assert(self.var_fb3c9d6a[str_perk] >= 0, "");
	#/
	if(self.var_fb3c9d6a[str_perk] <= 0)
	{
		self unsetperk(str_perk);
	}
}

/*
	Name: function_be94fe26
	Namespace: perks
	Checksum: 0x2C0FB884
	Offset: 0x208
	Size: 0x4A
	Parameters: 1
	Flags: Linked
*/
function function_be94fe26(str_perk)
{
	if(isdefined(self.var_fb3c9d6a) && isdefined(self.var_fb3c9d6a[str_perk]) && self.var_fb3c9d6a[str_perk] > 0)
	{
		return true;
	}
	return false;
}

/*
	Name: function_3cd6f625
	Namespace: perks
	Checksum: 0x69DD788
	Offset: 0x260
	Size: 0x26
	Parameters: 0
	Flags: None
*/
function function_3cd6f625()
{
	self clearperks();
	self.var_fb3c9d6a = [];
}

