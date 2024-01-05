// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\clientfield_shared.csc;

#namespace namespace_fddd83bd;

/*
	Name: init
	Namespace: namespace_fddd83bd
	Checksum: 0x5AA71E2C
	Offset: 0xC8
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function init()
{
	init_clientfields();
	init_fx();
}

/*
	Name: init_clientfields
	Namespace: namespace_fddd83bd
	Checksum: 0xC10DC7F9
	Offset: 0xF8
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("scriptmover", "" + #"hash_7876f33937c8a764", 20000, 1, "int", &vomit, 0, 0);
}

/*
	Name: init_fx
	Namespace: namespace_fddd83bd
	Checksum: 0x59029027
	Offset: 0x160
	Size: 0x2A
	Parameters: 0
	Flags: Linked
*/
function init_fx()
{
	level._effect[#"fx8_blightfather_vomit_object"] = "zm_ai/fx8_blightfather_vomit_object";
}

/*
	Name: vomit
	Namespace: namespace_fddd83bd
	Checksum: 0xA4E852C1
	Offset: 0x198
	Size: 0xB2
	Parameters: 7
	Flags: Linked
*/
function vomit(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_39c21153))
	{
		stopfx(localclientnum, self.var_39c21153);
		self.var_39c21153 = undefined;
	}
	if(newval)
	{
		self.var_39c21153 = util::playfxontag(localclientnum, level._effect[#"fx8_blightfather_vomit_object"], self, "tag_origin");
	}
}

