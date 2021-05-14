// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\aat_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace zm_aat_plasmatic_burst;

/*
	Name: function_89f2df9
	Namespace: zm_aat_plasmatic_burst
	Checksum: 0x13886FD8
	Offset: 0x1B0
	Size: 0x34
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register("zm_aat_plasmatic_burst", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_aat_plasmatic_burst
	Checksum: 0x9333B00F
	Offset: 0x1F0
	Size: 0x1BA
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.aat_in_use) && level.aat_in_use))
	{
		return;
	}
	aat::register("zm_aat_plasmatic_burst", #"hash_164d02d599d1fa8f", "t7_icon_zm_aat_blast_furnace");
	clientfield::register("actor", "zm_aat_plasmatic_burst" + "_explosion", 1, 1, "counter", &zm_aat_plasmatic_burst_explosion, 0, 0);
	clientfield::register("vehicle", "zm_aat_plasmatic_burst" + "_explosion", 1, 1, "counter", &zm_aat_plasmatic_burst_explosion, 0, 0);
	clientfield::register("actor", "zm_aat_plasmatic_burst" + "_burn", 1, 1, "int", &function_7abfa551, 0, 0);
	clientfield::register("vehicle", "zm_aat_plasmatic_burst" + "_burn", 1, 1, "int", &function_a98c42a3, 0, 0);
	level._effect[#"zm_aat_plasmatic_burst"] = "zm_weapons/fx8_aat_plasmatic_burst_torso";
}

/*
	Name: zm_aat_plasmatic_burst_explosion
	Namespace: zm_aat_plasmatic_burst
	Checksum: 0xCA47698B
	Offset: 0x3B8
	Size: 0xDC
	Parameters: 7
	Flags: Linked
*/
function zm_aat_plasmatic_burst_explosion(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self))
	{
		str_fx_tag = self zm_utility::function_467efa7b(1);
		if(!isdefined(str_fx_tag))
		{
			str_fx_tag = "tag_origin";
		}
		self playsound(localclientnum, #"hash_6990e5a39e894c04");
		util::playfxontag(localclientnum, level._effect[#"zm_aat_plasmatic_burst"], self, str_fx_tag);
	}
}

/*
	Name: function_7abfa551
	Namespace: zm_aat_plasmatic_burst
	Checksum: 0xA7022CBF
	Offset: 0x4A0
	Size: 0xBC
	Parameters: 7
	Flags: Linked
*/
function function_7abfa551(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		str_tag = "j_spine4";
		v_tag = self gettagorigin(str_tag);
		if(!isdefined(v_tag))
		{
			str_tag = "tag_origin";
		}
		self function_c36aebed(localclientnum, str_tag);
	}
	else
	{
		self function_b4d21494(localclientnum);
	}
}

/*
	Name: function_a98c42a3
	Namespace: zm_aat_plasmatic_burst
	Checksum: 0xD5AEABE4
	Offset: 0x568
	Size: 0xBC
	Parameters: 7
	Flags: Linked
*/
function function_a98c42a3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		str_tag = "tag_body";
		v_tag = self gettagorigin(str_tag);
		if(!isdefined(v_tag))
		{
			str_tag = "tag_origin";
		}
		self function_c36aebed(localclientnum, str_tag);
	}
	else
	{
		self function_b4d21494(localclientnum);
	}
}

/*
	Name: function_c36aebed
	Namespace: zm_aat_plasmatic_burst
	Checksum: 0xAE1B8713
	Offset: 0x630
	Size: 0x9A
	Parameters: 2
	Flags: Linked
*/
function function_c36aebed(localclientnum, tag)
{
	self.var_def62862 = util::playfxontag(localclientnum, "zm_weapons/fx8_aat_plasmatic_burst_torso_fire", self, tag);
	self.var_4a87444e = util::playfxontag(localclientnum, "zm_weapons/fx8_aat_plasmatic_burst_head", self, "j_head");
	if(!isdefined(self.var_fa3f8eb7))
	{
		self.var_fa3f8eb7 = self playloopsound(#"hash_645b60f29309dc9b");
	}
}

/*
	Name: function_b4d21494
	Namespace: zm_aat_plasmatic_burst
	Checksum: 0x448EAF86
	Offset: 0x6D8
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function function_b4d21494(localclientnum)
{
	if(isdefined(self.var_fa3f8eb7))
	{
		self stoploopsound(self.var_fa3f8eb7);
	}
	if(isdefined(self.var_def62862))
	{
		stopfx(localclientnum, self.var_def62862);
	}
	if(isdefined(self.var_4a87444e))
	{
		stopfx(localclientnum, self.var_4a87444e);
	}
}

