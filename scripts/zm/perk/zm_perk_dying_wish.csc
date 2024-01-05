// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_utility.csc;
#using scripts\zm_common\zm_perks.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\callbacks_shared.csc;

#namespace zm_perk_dying_wish;

/*
	Name: __init__system__
	Namespace: zm_perk_dying_wish
	Checksum: 0x2127AAB9
	Offset: 0x148
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_dying_wish", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_dying_wish
	Checksum: 0x178ED801
	Offset: 0x190
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	enable_dying_wish_perk_for_level();
}

/*
	Name: enable_dying_wish_perk_for_level
	Namespace: zm_perk_dying_wish
	Checksum: 0xB278AFB5
	Offset: 0x1B0
	Size: 0x174
	Parameters: 0
	Flags: Linked
*/
function enable_dying_wish_perk_for_level()
{
	zm_perks::register_perk_clientfields(#"specialty_berserker", &function_6e5c87d, &function_36db14fb);
	zm_perks::register_perk_effects(#"specialty_berserker", "divetonuke_light");
	zm_perks::register_perk_init_thread(#"specialty_berserker", &function_536f842f);
	zm_perks::function_b60f4a9f(#"specialty_berserker", #"p8_zm_vapor_altar_icon_01_dyingwish", "zombie/fx8_perk_altar_symbol_ambient_dying_wish", #"zmperksdyingwish");
	zm_perks::function_f3c80d73("zombie_perk_bottle_dying_wish", "zombie_perk_totem_dying_wish");
	level._effect[#"hash_481f130cd5e53b7f"] = #"hash_620000088d4c3f79";
	callback::on_spawned(&on_spawned);
	callback::on_localclient_connect(&on_localclient_connect);
}

/*
	Name: function_536f842f
	Namespace: zm_perk_dying_wish
	Checksum: 0x80F724D1
	Offset: 0x330
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_536f842f()
{
}

/*
	Name: function_6e5c87d
	Namespace: zm_perk_dying_wish
	Checksum: 0x4282C662
	Offset: 0x340
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_6e5c87d()
{
	clientfield::register("allplayers", "" + #"hash_10f459edea6b3eb", 1, 1, "int", &function_bd2b1ccb, 0, 0);
}

/*
	Name: function_36db14fb
	Namespace: zm_perk_dying_wish
	Checksum: 0x80F724D1
	Offset: 0x3A8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_36db14fb()
{
}

/*
	Name: on_spawned
	Namespace: zm_perk_dying_wish
	Checksum: 0xC1A7270A
	Offset: 0x3B8
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function on_spawned(localclientnum)
{
	if(self postfx::function_556665f2(#"pstfx_zm_dying_wish"))
	{
		self thread postfx::exitpostfxbundle(#"pstfx_zm_dying_wish");
	}
}

/*
	Name: function_bd2b1ccb
	Namespace: zm_perk_dying_wish
	Checksum: 0x13E88DDD
	Offset: 0x410
	Size: 0x206
	Parameters: 7
	Flags: Linked, Private
*/
function private function_bd2b1ccb(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newvalue)
	{
		if(self zm_utility::function_f8796df3(localclientnum))
		{
			self thread postfx::playpostfxbundle(#"pstfx_zm_dying_wish");
		}
		else
		{
			self.var_d413d3e = util::playfxontag(localclientnum, level._effect[#"hash_481f130cd5e53b7f"], self, "j_spine4");
		}
		if(!isdefined(self.var_cffdb842))
		{
			self.var_e9dd2ca0 = 1;
			self playsound(localclientnum, #"hash_268d2ee0a0daf799");
			self.var_cffdb842 = self playloopsound(#"hash_22a448c0d7682cdf");
		}
	}
	else
	{
		if(self zm_utility::function_f8796df3(localclientnum))
		{
			self thread postfx::exitpostfxbundle(#"pstfx_zm_dying_wish");
		}
		else if(isdefined(self.var_d413d3e))
		{
			stopfx(localclientnum, self.var_d413d3e);
			self.var_d413d3e = undefined;
		}
		if(isdefined(self.var_cffdb842))
		{
			self.var_e9dd2ca0 = 0;
			self playsound(localclientnum, #"hash_2f273ae29320f08");
			self stoploopsound(self.var_cffdb842);
			self.var_cffdb842 = undefined;
		}
	}
}

/*
	Name: on_localclient_connect
	Namespace: zm_perk_dying_wish
	Checksum: 0x49D9C2DE
	Offset: 0x620
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
	Namespace: zm_perk_dying_wish
	Checksum: 0x8C190EAA
	Offset: 0x658
	Size: 0x84
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
	if(isdefined(self.var_d413d3e))
	{
		deletefx(localclientnum, self.var_d413d3e, 1);
	}
}

