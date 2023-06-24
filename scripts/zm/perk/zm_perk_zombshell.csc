// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace zm_perk_zombshell;

/*
	Name: __init__system__
	Namespace: zm_perk_zombshell
	Checksum: 0x3E2DB32E
	Offset: 0x160
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_zombshell", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_zombshell
	Checksum: 0x9724E510
	Offset: 0x1A8
	Size: 0x22C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(getdvarint(#"hash_49ef5478510b5af3", 0))
	{
		zm_perks::register_perk_clientfields(#"specialty_zombshell", &function_9e1d9985, &function_d0ba0d3);
		zm_perks::register_perk_effects(#"specialty_zombshell", "zombshell_light");
		zm_perks::register_perk_init_thread(#"specialty_zombshell", &function_efe56acb);
		zm_perks::function_b60f4a9f(#"specialty_zombshell", #"p8_zm_vapor_altar_icon_01_zombshell", "zombie/fx8_perk_altar_symbol_ambient_zombshell", #"zmperkszombshell");
		zm_perks::function_f3c80d73("zombie_perk_bottle_zombshell", "zombie_perk_totem_zombshell");
		clientfield::register("scriptmover", "" + #"zombshell_aoe", 15000, 1, "int", &zombshell_aoe, 0, 0);
		clientfield::register("toplayer", "" + #"hash_5f545b88ba3e2938", 15000, 1, "int", &function_1e112e5f, 0, 1);
		clientfield::register("actor", "" + #"zombshell_explosion", 15000, 1, "counter", &zombshell_explosion, 0, 0);
	}
}

/*
	Name: function_efe56acb
	Namespace: zm_perk_zombshell
	Checksum: 0xADEE0758
	Offset: 0x3E0
	Size: 0x92
	Parameters: 0
	Flags: Linked
*/
function function_efe56acb()
{
	level._effect[#"zombshell_aoe"] = #"hash_3d2e7548c7dfc406";
	level._effect[#"zombshell_explosion"] = #"hash_1900ec48b2f264fe";
	level._effect[#"zombie_blood_1st"] = #"player/fx8_plyr_pstfx_katana_rush_loop";
}

/*
	Name: function_9e1d9985
	Namespace: zm_perk_zombshell
	Checksum: 0x80F724D1
	Offset: 0x480
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_9e1d9985()
{
}

/*
	Name: function_d0ba0d3
	Namespace: zm_perk_zombshell
	Checksum: 0x80F724D1
	Offset: 0x490
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_d0ba0d3()
{
}

/*
	Name: zombshell_aoe
	Namespace: zm_perk_zombshell
	Checksum: 0xF9954723
	Offset: 0x4A0
	Size: 0x1AE
	Parameters: 7
	Flags: Linked
*/
function zombshell_aoe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(isdefined(self.var_a6da95e6))
		{
			deletefx(localclientnum, self.var_a6da95e6, 1);
		}
		self.var_a6da95e6 = util::playfxontag(localclientnum, level._effect[#"zombshell_aoe"], self, "tag_origin");
		if(!isdefined(self.var_e3d27e69))
		{
			self playsound(localclientnum, #"hash_6aa32cc737673479");
			self.var_e3d27e69 = self playloopsound(#"hash_d377c202c27be3f");
		}
	}
	else
	{
		if(isdefined(self.var_a6da95e6))
		{
			deletefx(localclientnum, self.var_a6da95e6, 0);
			self.var_a6da95e6 = undefined;
		}
		if(isdefined(self.var_e3d27e69))
		{
			self playsound(localclientnum, #"hash_5aa45eab2ab681e8");
			self stoploopsound(self.var_e3d27e69);
			self.var_e3d27e69 = undefined;
		}
	}
}

/*
	Name: function_1e112e5f
	Namespace: zm_perk_zombshell
	Checksum: 0xF68F6908
	Offset: 0x658
	Size: 0x204
	Parameters: 7
	Flags: Linked
*/
function function_1e112e5f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(function_65b9eb0f(localclientnum))
	{
		return;
	}
	if(!isdefined(self.var_5b8b57b9))
	{
		self.var_5b8b57b9 = [];
	}
	if(!isdefined(self.var_5b8b57b9[localclientnum]))
	{
		self.var_5b8b57b9[localclientnum] = [];
	}
	if(self.var_5b8b57b9[localclientnum].size)
	{
		self postfx::stoppostfxbundle(#"hash_4c9c4b6464bd9a1c");
		foreach(n_fx_id in self.var_5b8b57b9[localclientnum])
		{
			stopfx(localclientnum, n_fx_id);
			n_fx_id = undefined;
		}
		if(newval == 0)
		{
			self.var_5b8b57b9[localclientnum] = undefined;
		}
	}
	if(newval == 1)
	{
		if(self getlocalclientnumber() === localclientnum)
		{
			self thread postfx::playpostfxbundle(#"hash_4c9c4b6464bd9a1c");
			self.var_5b8b57b9[localclientnum][self.var_5b8b57b9[localclientnum].size] = playfxoncamera(localclientnum, level._effect[#"zombie_blood_1st"]);
		}
	}
}

/*
	Name: zombshell_explosion
	Namespace: zm_perk_zombshell
	Checksum: 0xCFE5CC47
	Offset: 0x868
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function zombshell_explosion(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::playfxontag(localclientnum, level._effect[#"zombshell_explosion"], self, "j_spineupper");
}

