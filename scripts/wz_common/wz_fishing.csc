// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\clientfield_shared.csc;

#namespace wz_fishing;

/*
	Name: __init__system__
	Namespace: wz_fishing
	Checksum: 0x580BB31C
	Offset: 0x140
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"wz_fishing", &__init__, undefined, undefined);
}

/*
	Name: __init
	Namespace: wz_fishing
	Checksum: 0x80F724D1
	Offset: 0x188
	Size: 0x4
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init()
{
}

/*
	Name: __init__
	Namespace: wz_fishing
	Checksum: 0xCB437D
	Offset: 0x198
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("scriptmover", "fishing_splash", 21000, 1, "int", &fishing_splash, 0, 0);
	clientfield::register("scriptmover", "fishing_buoy_splash", 21000, 1, "int", &fishing_splash, 0, 0);
	clientfield::register("toplayer", "player_fishing", 21000, 1, "int", &function_c06a890a, 0, 0);
}

/*
	Name: function_c06a890a
	Namespace: wz_fishing
	Checksum: 0x6F387A3E
	Offset: 0x280
	Size: 0xCC
	Parameters: 7
	Flags: Linked
*/
function function_c06a890a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.canUseQuickInventory"), 0);
	}
	else
	{
		setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.canUseQuickInventory"), 1);
	}
}

/*
	Name: fishing_buoy_splash
	Namespace: wz_fishing
	Checksum: 0x69A1D25F
	Offset: 0x358
	Size: 0xCC
	Parameters: 7
	Flags: None
*/
function fishing_buoy_splash(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 0)
	{
		if(isdefined(self.var_85dbab0))
		{
			stopfx(localclientnum, self.var_85dbab0);
		}
	}
	else
	{
		self.var_85dbab0 = playfx(localclientnum, "player/fx_plyr_water_splash_sm", self.origin);
		playsound(localclientnum, #"hash_7ff007fca6ac13d7", self.origin);
	}
}

/*
	Name: fishing_splash
	Namespace: wz_fishing
	Checksum: 0xFFA2CA7
	Offset: 0x430
	Size: 0xCC
	Parameters: 7
	Flags: Linked
*/
function fishing_splash(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 0)
	{
		if(isdefined(self.var_85dbab0))
		{
			stopfx(localclientnum, self.var_85dbab0);
		}
	}
	else
	{
		self.var_85dbab0 = playfx(localclientnum, "impacts/fx8_bul_impact_water_sm", self.origin);
		playsound(localclientnum, #"hash_4b98472de9aeb14b", self.origin);
	}
}

