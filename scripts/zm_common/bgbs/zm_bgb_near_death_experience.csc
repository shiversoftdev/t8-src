// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_bgb.csc;

#namespace zm_bgb_near_death_experience;

/*
	Name: __init__system__
	Namespace: zm_bgb_near_death_experience
	Checksum: 0xB3C7327E
	Offset: 0x140
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_bgb_near_death_experience", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_near_death_experience
	Checksum: 0xBC9503CF
	Offset: 0x190
	Size: 0xEA
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	clientfield::register("allplayers", "zm_bgb_near_death_experience_3p_fx", 1, 1, "int", &function_f177aa9f, 0, 0);
	clientfield::register("toplayer", "zm_bgb_near_death_experience_1p_fx", 1, 1, "int", &function_70565a6d, 0, 1);
	bgb::register(#"zm_bgb_near_death_experience", "time");
	level.var_d066b29d = [];
}

/*
	Name: function_f177aa9f
	Namespace: zm_bgb_near_death_experience
	Checksum: 0xCDF25BAC
	Offset: 0x288
	Size: 0x12C
	Parameters: 7
	Flags: Linked
*/
function function_f177aa9f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	e_local_player = function_5c10bd79(localclientnum);
	if(newval)
	{
		if(e_local_player != self)
		{
			if(!isdefined(self.var_5dacba16))
			{
				self.var_5dacba16 = [];
			}
			if(isdefined(self.var_5dacba16[localclientnum]))
			{
				return;
			}
			self.var_5dacba16[localclientnum] = util::playfxontag(localclientnum, "zombie/fx_bgb_near_death_3p", self, "j_spine4");
		}
	}
	else if(isdefined(self.var_5dacba16) && isdefined(self.var_5dacba16[localclientnum]))
	{
		stopfx(localclientnum, self.var_5dacba16[localclientnum]);
		self.var_5dacba16[localclientnum] = undefined;
	}
}

/*
	Name: function_70565a6d
	Namespace: zm_bgb_near_death_experience
	Checksum: 0x48F49DAF
	Offset: 0x3C0
	Size: 0x104
	Parameters: 7
	Flags: Linked
*/
function function_70565a6d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(isdefined(level.var_d066b29d[localclientnum]))
		{
			deletefx(localclientnum, level.var_d066b29d[localclientnum]);
		}
		level.var_d066b29d[localclientnum] = playfxoncamera(localclientnum, "zombie/fx_bgb_near_death_1p", (0, 0, 0), (1, 0, 0));
	}
	else if(isdefined(level.var_d066b29d[localclientnum]))
	{
		stopfx(localclientnum, level.var_d066b29d[localclientnum]);
		level.var_d066b29d[localclientnum] = undefined;
	}
}

