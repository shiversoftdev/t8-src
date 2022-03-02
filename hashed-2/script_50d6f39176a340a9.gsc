// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\aat_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm\zm_lightning_chain.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace zm_aat_kill_o_watt;

/*
	Name: function_89f2df9
	Namespace: zm_aat_kill_o_watt
	Checksum: 0x33C99B1D
	Offset: 0x198
	Size: 0x34
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register("zm_aat_kill_o_watt", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_aat_kill_o_watt
	Checksum: 0x91893AA4
	Offset: 0x1D8
	Size: 0x194
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.aat_in_use) && level.aat_in_use))
	{
		return;
	}
	aat::register("zm_aat_kill_o_watt", #"hash_17fd44c733f7c66b", "t7_icon_zm_aat_dead_wire");
	clientfield::register("actor", "zm_aat_kill_o_watt" + "_explosion", 1, 1, "counter", &function_d2ca081b, 0, 0);
	clientfield::register("vehicle", "zm_aat_kill_o_watt" + "_explosion", 1, 1, "counter", &function_d2ca081b, 0, 0);
	clientfield::register("actor", "zm_aat_kill_o_watt" + "_zap", 1, 1, "int", &function_846837f, 0, 0);
	clientfield::register("vehicle", "zm_aat_kill_o_watt" + "_zap", 1, 1, "int", &function_846837f, 0, 0);
}

/*
	Name: function_846837f
	Namespace: zm_aat_kill_o_watt
	Checksum: 0xD2AFBCCF
	Offset: 0x378
	Size: 0x196
	Parameters: 7
	Flags: Linked
*/
function function_846837f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		str_fx_tag = self zm_utility::function_467efa7b(1);
		if(!isdefined(str_fx_tag))
		{
			str_fx_tag = "tag_origin";
		}
		self.var_548620a = util::playfxontag(localclientnum, "zm_weapons/fx8_aat_elec_torso", self, str_fx_tag);
		self.var_9fddda59 = util::playfxontag(localclientnum, "zm_weapons/fx8_aat_elec_eye", self, "j_eyeball_le");
		if(!isdefined(self.var_6a8124b))
		{
			self.var_6a8124b = self playloopsound("zmb_aat_kilowatt_stunned_lp");
		}
	}
	else if(isdefined(self.var_548620a))
	{
		stopfx(localclientnum, self.var_548620a);
		self.var_548620a = undefined;
		stopfx(localclientnum, self.var_9fddda59);
		self.var_9fddda59 = undefined;
		if(isdefined(self.var_6a8124b))
		{
			self stoploopsound(self.var_6a8124b);
			self.var_6a8124b = undefined;
		}
	}
}

/*
	Name: function_d2ca081b
	Namespace: zm_aat_kill_o_watt
	Checksum: 0xB925B715
	Offset: 0x518
	Size: 0xD4
	Parameters: 7
	Flags: Linked
*/
function function_d2ca081b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self))
	{
		v_fx_origin = self gettagorigin(self zm_utility::function_467efa7b(1));
		if(!isdefined(v_fx_origin))
		{
			v_fx_origin = self.origin;
		}
		playfx(localclientnum, "zm_weapons/fx8_aat_elec_exp", v_fx_origin);
		self playsound(localclientnum, #"zmb_aat_kilowatt_explode");
	}
}

