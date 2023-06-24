// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_perks.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace zm_perk_stronghold;

/*
	Name: __init__system__
	Namespace: zm_perk_stronghold
	Checksum: 0x899D9052
	Offset: 0x140
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_stronghold", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_stronghold
	Checksum: 0x2C676F2F
	Offset: 0x188
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	enable_stronghold_perk_for_level();
	level._effect[#"hash_24e322568c9492c5"] = #"hash_497cb15bcf6c05b1";
	callback::on_localclient_connect(&on_localclient_connect);
}

/*
	Name: enable_stronghold_perk_for_level
	Namespace: zm_perk_stronghold
	Checksum: 0x169A1DBE
	Offset: 0x1F8
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function enable_stronghold_perk_for_level()
{
	zm_perks::register_perk_clientfields(#"specialty_camper", &function_5a4557ee, &function_44bd921f);
	zm_perks::register_perk_effects(#"specialty_camper", "divetonuke_light");
	zm_perks::register_perk_init_thread(#"specialty_camper", &function_eaf3e7f1);
	zm_perks::function_b60f4a9f(#"specialty_camper", #"p8_zm_vapor_altar_icon_01_stonecoldstronghold", "zombie/fx8_perk_altar_symbol_ambient_stronghold", #"hash_5690c4dcc61973ec");
	zm_perks::function_f3c80d73("zombie_perk_bottle_stronghold", "zombie_perk_totem_stronghold");
}

/*
	Name: function_eaf3e7f1
	Namespace: zm_perk_stronghold
	Checksum: 0x80F724D1
	Offset: 0x308
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_eaf3e7f1()
{
}

/*
	Name: function_5a4557ee
	Namespace: zm_perk_stronghold
	Checksum: 0x28680403
	Offset: 0x318
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_5a4557ee()
{
	clientfield::register("toplayer", "" + #"hash_24e322568c9492c5", 1, 1, "int", &function_2400dd1d, 0, 1);
}

/*
	Name: function_44bd921f
	Namespace: zm_perk_stronghold
	Checksum: 0x80F724D1
	Offset: 0x380
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_44bd921f()
{
}

/*
	Name: function_2400dd1d
	Namespace: zm_perk_stronghold
	Checksum: 0xF6AFB0B8
	Offset: 0x390
	Size: 0x1EE
	Parameters: 7
	Flags: Linked
*/
function function_2400dd1d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self.var_f9c892e3))
	{
		self.var_f9c892e3 = [];
	}
	if(newval)
	{
		if(isdefined(self.var_f9c892e3[localclientnum]))
		{
			deletefx(localclientnum, self.var_f9c892e3[localclientnum], 1);
		}
		self.var_f9c892e3[localclientnum] = util::playfxontag(localclientnum, level._effect[#"hash_24e322568c9492c5"], self, "j_spine");
		if(!isdefined(self.var_2ec16150))
		{
			self playsound(localclientnum, #"hash_5e1e162af8490f1d");
			self.var_2ec16150 = self playloopsound(#"hash_641286598a33d4e3");
		}
	}
	else
	{
		if(isdefined(self.var_f9c892e3[localclientnum]))
		{
			deletefx(localclientnum, self.var_f9c892e3[localclientnum], 0);
			self.var_f9c892e3[localclientnum] = undefined;
		}
		if(isdefined(self.var_2ec16150))
		{
			self playsound(localclientnum, #"hash_73b66a25abec1fe4");
			self stoploopsound(self.var_2ec16150);
			self.var_2ec16150 = undefined;
		}
	}
}

/*
	Name: on_localclient_connect
	Namespace: zm_perk_stronghold
	Checksum: 0xC7619F19
	Offset: 0x588
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function on_localclient_connect(localclientnum)
{
	self callback::on_death(&on_death);
}

/*
	Name: on_death
	Namespace: zm_perk_stronghold
	Checksum: 0x8E3B93B6
	Offset: 0x5C0
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function on_death(params)
{
	if(!isplayer(self))
	{
		return;
	}
	localclientnum = params.localclientnum;
	if(function_65b9eb0f(localclientnum))
	{
		return;
	}
	if(isarray(self.var_f9c892e3) && isdefined(self.var_f9c892e3[localclientnum]))
	{
		deletefx(localclientnum, self.var_f9c892e3[localclientnum], 1);
	}
}

