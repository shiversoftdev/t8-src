// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_bgb.csc;

#namespace zm_bgb_dividend_yield;

/*
	Name: __init__system__
	Namespace: zm_bgb_dividend_yield
	Checksum: 0xF21ACAC1
	Offset: 0xF0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_bgb_dividend_yield", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_dividend_yield
	Checksum: 0x7EBB8698
	Offset: 0x140
	Size: 0x10A
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	clientfield::register("allplayers", "" + #"hash_11a25fb3db96fc2d", 1, 1, "int", &function_441dc042, 0, 0);
	clientfield::register("toplayer", "" + #"hash_31b61c511ced94d7", 1, 1, "int", &function_1e792793, 0, 1);
	bgb::register(#"zm_bgb_dividend_yield", "time");
	level.var_b28c30ba = [];
}

/*
	Name: function_441dc042
	Namespace: zm_bgb_dividend_yield
	Checksum: 0x2024BDF2
	Offset: 0x258
	Size: 0x12C
	Parameters: 7
	Flags: Linked
*/
function function_441dc042(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	e_local_player = function_5c10bd79(localclientnum);
	if(newval)
	{
		if(e_local_player != self)
		{
			if(!isdefined(self.var_4399fda6))
			{
				self.var_4399fda6 = [];
			}
			if(isdefined(self.var_4399fda6[localclientnum]))
			{
				return;
			}
			self.var_4399fda6[localclientnum] = util::playfxontag(localclientnum, "zombie/fx_bgb_profit_3p", self, "j_spine4");
		}
	}
	else if(isdefined(self.var_4399fda6) && isdefined(self.var_4399fda6[localclientnum]))
	{
		stopfx(localclientnum, self.var_4399fda6[localclientnum]);
		self.var_4399fda6[localclientnum] = undefined;
	}
}

/*
	Name: function_1e792793
	Namespace: zm_bgb_dividend_yield
	Checksum: 0xA9436C5A
	Offset: 0x390
	Size: 0x104
	Parameters: 7
	Flags: Linked
*/
function function_1e792793(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(isdefined(level.var_b28c30ba[localclientnum]))
		{
			deletefx(localclientnum, level.var_b28c30ba[localclientnum]);
		}
		level.var_b28c30ba[localclientnum] = playfxoncamera(localclientnum, "zombie/fx_bgb_profit_1p", (0, 0, 0), (1, 0, 0));
	}
	else if(isdefined(level.var_b28c30ba[localclientnum]))
	{
		stopfx(localclientnum, level.var_b28c30ba[localclientnum]);
		level.var_b28c30ba[localclientnum] = undefined;
	}
}

