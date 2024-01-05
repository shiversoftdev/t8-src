// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\clientfield_shared.csc;

#namespace zm_white_electric_traps;

/*
	Name: __init__system__
	Namespace: zm_white_electric_traps
	Checksum: 0x7A904D9B
	Offset: 0xD8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_white_electric_trap", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_white_electric_traps
	Checksum: 0x81AA6534
	Offset: 0x120
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level init_fx();
	level init_clientfields();
}

/*
	Name: init_fx
	Namespace: zm_white_electric_traps
	Checksum: 0xE2D394E
	Offset: 0x160
	Size: 0xC2
	Parameters: 0
	Flags: Linked
*/
function init_fx()
{
	level._effect[#"hash_6d40a3f1944d81b2"] = #"hash_3a5776a6c23c9563";
	level._effect[#"hash_3d339d7ae7b008d3"] = #"hash_6a84f61b7271e098";
	level._effect[#"hash_6a97de5de4ae14a"] = #"zombie/fx_tesla_shock_zmb";
	level._effect[#"hash_21e93d9faa37cad"] = #"zombie/fx_tesla_shock_eyes_zmb";
}

/*
	Name: init_clientfields
	Namespace: zm_white_electric_traps
	Checksum: 0x82BA7CFD
	Offset: 0x230
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("scriptmover", "" + #"hash_6d40a3f1944d81b2", 20000, 2, "int", &function_946acaec, 0, 0);
	clientfield::register("actor", "" + #"electrocute_ai_fx", 20000, 1, "int", &electrocute_ai, 0, 0);
}

/*
	Name: function_946acaec
	Namespace: zm_white_electric_traps
	Checksum: 0x4AF579C5
	Offset: 0x2F0
	Size: 0x10C
	Parameters: 7
	Flags: Linked
*/
function function_946acaec(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 2)
	{
		self.blinking_fx = util::playfxontag(localclientnum, level._effect[#"hash_6d40a3f1944d81b2"], self, "tag_origin");
	}
	else
	{
		if(newval == 1)
		{
			self.blinking_fx = util::playfxontag(localclientnum, level._effect[#"hash_3d339d7ae7b008d3"], self, "tag_origin");
		}
		else if(isdefined(self.blinking_fx))
		{
			deletefx(localclientnum, self.blinking_fx);
		}
	}
}

/*
	Name: electrocute_ai
	Namespace: zm_white_electric_traps
	Checksum: 0xB11F1801
	Offset: 0x408
	Size: 0x1FE
	Parameters: 7
	Flags: Linked
*/
function electrocute_ai(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		str_tag = "J_SpineUpper";
		if(isdefined(self.var_c8b0b5be))
		{
			str_tag = self.var_c8b0b5be;
		}
		else if(self.archetype === #"zombie_dog")
		{
			str_tag = "J_Spine1";
		}
		self.n_shock_eyes_fx = util::playfxontag(localclientnum, level._effect[#"hash_21e93d9faa37cad"], self, "J_Eyeball_LE");
		if(isdefined(self) && isdefined(self.n_shock_eyes_fx))
		{
			setfxignorepause(localclientnum, self.n_shock_eyes_fx, 1);
		}
		self.n_shock_fx = util::playfxontag(localclientnum, level._effect[#"hash_6a97de5de4ae14a"], self, str_tag);
		if(isdefined(self) && isdefined(self.n_shock_eyes_fx))
		{
			setfxignorepause(localclientnum, self.n_shock_fx, 1);
		}
	}
	else
	{
		if(isdefined(self.n_shock_eyes_fx))
		{
			deletefx(localclientnum, self.n_shock_eyes_fx, 1);
			self.n_shock_eyes_fx = undefined;
		}
		if(isdefined(self.n_shock_fx))
		{
			deletefx(localclientnum, self.n_shock_fx, 1);
			self.n_shock_fx = undefined;
		}
	}
}

