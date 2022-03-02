// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace namespace_a35b43eb;

/*
	Name: function_89f2df9
	Namespace: namespace_a35b43eb
	Checksum: 0x655B57C4
	Offset: 0xD8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_18d1bdf8dbbfec6c", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_a35b43eb
	Checksum: 0x33B0C313
	Offset: 0x120
	Size: 0x72
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_clientfields();
	level._effect[#"trap_light_green"] = #"hash_3b61ca07c83b7171";
	level._effect[#"trap_light_red"] = #"hash_7534672c207c08ed";
}

/*
	Name: init_clientfields
	Namespace: namespace_a35b43eb
	Checksum: 0xCE093A33
	Offset: 0x1A0
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("scriptmover", "" + #"hash_1a4cf85bba32ee41", 8000, 2, "int", &function_1d5b8b9f, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_17df66ef5f71c0de", 8000, 2, "int", &function_b3f0f5cd, 0, 0);
}

/*
	Name: function_1d5b8b9f
	Namespace: namespace_a35b43eb
	Checksum: 0x798220C8
	Offset: 0x260
	Size: 0x142
	Parameters: 7
	Flags: Linked
*/
function function_1d5b8b9f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(isdefined(self.var_d476c975))
	{
		stopfx(localclientnum, self.var_d476c975);
		self.var_d476c975 = undefined;
	}
	if(isdefined(self.var_16c041ae))
	{
		stopfx(localclientnum, self.var_16c041ae);
		self.var_16c041ae = undefined;
	}
	if(newval == 1)
	{
		self.var_d476c975 = util::playfxontag(localclientnum, level._effect[#"trap_light_green"], self, "light_fx_tag");
	}
	else if(newval == 2)
	{
		self.var_16c041ae = util::playfxontag(localclientnum, level._effect[#"trap_light_red"], self, "light_fx_tag");
	}
}

/*
	Name: function_b3f0f5cd
	Namespace: namespace_a35b43eb
	Checksum: 0xF9FBD3B4
	Offset: 0x3B0
	Size: 0x212
	Parameters: 7
	Flags: Linked
*/
function function_b3f0f5cd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(isdefined(self.var_fca46d00))
	{
		stopfx(localclientnum, self.var_fca46d00);
		self.var_fca46d00 = undefined;
		stopfx(localclientnum, self.var_f7653c4b);
		self.var_f7653c4b = undefined;
	}
	if(isdefined(self.var_7504a327))
	{
		stopfx(localclientnum, self.var_7504a327);
		self.var_7504a327 = undefined;
		stopfx(localclientnum, self.var_5a0ff99d);
		self.var_5a0ff99d = undefined;
	}
	if(newval == 1)
	{
		self.var_fca46d00 = util::playfxontag(localclientnum, level._effect[#"trap_light_green"], self, "j_light_lt");
		self.var_f7653c4b = util::playfxontag(localclientnum, level._effect[#"trap_light_green"], self, "j_light_rt");
	}
	else if(newval == 2)
	{
		self.var_7504a327 = util::playfxontag(localclientnum, level._effect[#"trap_light_red"], self, "j_light_lt");
		self.var_5a0ff99d = util::playfxontag(localclientnum, level._effect[#"trap_light_red"], self, "j_light_rt");
	}
}

