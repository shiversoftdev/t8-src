// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\exploder_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace zm_trap_electric;

/*
	Name: __init__system__
	Namespace: zm_trap_electric
	Checksum: 0xC79C188C
	Offset: 0x118
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_trap_electric", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_trap_electric
	Checksum: 0x55F8272B
	Offset: 0x160
	Size: 0x172
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	a_traps = struct::get_array("trap_electric", "targetname");
	foreach(trap in a_traps)
	{
		clientfield::register("world", trap.script_noteworthy, 1, 1, "int", &trap_fx_monitor, 0, 0);
	}
	clientfield::register("actor", "electrocute_ai_fx", 1, 1, "int", &electrocute_ai, 0, 0);
	level._effect[#"hash_6a97de5de4ae14a"] = #"zombie/fx_tesla_shock_zmb";
	level._effect[#"hash_21e93d9faa37cad"] = #"zombie/fx_tesla_shock_eyes_zmb";
}

/*
	Name: trap_fx_monitor
	Namespace: zm_trap_electric
	Checksum: 0x743B8674
	Offset: 0x2E0
	Size: 0x8C
	Parameters: 7
	Flags: Linked
*/
function trap_fx_monitor(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	exploder_name = "trap_electric_" + fieldname;
	if(newval)
	{
		exploder::exploder(exploder_name);
	}
	else
	{
		exploder::stop_exploder(exploder_name);
	}
}

/*
	Name: electrocute_ai
	Namespace: zm_trap_electric
	Checksum: 0xF1227C65
	Offset: 0x378
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

