// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_perks.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace zm_perk_widows_wine;

/*
	Name: function_89f2df9
	Namespace: zm_perk_widows_wine
	Checksum: 0xD955652E
	Offset: 0x240
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_perk_widows_wine", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_widows_wine
	Checksum: 0xCF0A3ACF
	Offset: 0x288
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_perks::register_perk_clientfields(#"specialty_widowswine", &widows_wine_client_field_func, &widows_wine_code_callback_func);
	zm_perks::register_perk_effects(#"specialty_widowswine", "widow_light");
	zm_perks::register_perk_init_thread(#"specialty_widowswine", &init_widows_wine);
	zm_perks::function_b60f4a9f(#"specialty_widowswine", #"hash_3ceb5aea438db8ab", "zombie/fx8_perk_altar_symbol_ambient_widows_wine", #"hash_557e3edd7fe168c3");
	zm_perks::function_f3c80d73("zombie_perk_bottle_widows_wine", "zombie_perk_totem_winters_wail");
}

/*
	Name: init_widows_wine
	Namespace: zm_perk_widows_wine
	Checksum: 0x9B216FEC
	Offset: 0x398
	Size: 0xC2
	Parameters: 0
	Flags: Linked
*/
function init_widows_wine()
{
	if(isdefined(level.enable_magic) && level.enable_magic)
	{
		level._effect[#"widow_light"] = "zombie/fx_perk_widows_wine_zmb";
		level._effect[#"winters_wail_freeze"] = "zombie/fx8_perk_winters_wail_freeze";
		level._effect[#"winters_wail_explosion"] = "zombie/fx8_perk_winters_wail_exp";
		level._effect[#"winters_wail_slow_field"] = "zombie/fx8_perk_winters_wail_aoe";
	}
}

/*
	Name: widows_wine_client_field_func
	Namespace: zm_perk_widows_wine
	Checksum: 0x80A35824
	Offset: 0x468
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function widows_wine_client_field_func()
{
	clientfield::register("actor", "winters_wail_freeze", 1, 1, "int", &function_fd02d096, 0, 1);
	clientfield::register("vehicle", "winters_wail_freeze", 1, 1, "int", &function_fd02d096, 0, 0);
	clientfield::register("allplayers", "winters_wail_explosion", 1, 1, "counter", &widows_wine_explosion, 0, 0);
	clientfield::register("allplayers", "winters_wail_slow_field", 1, 1, "int", &function_c6366dbe, 0, 0);
}

/*
	Name: widows_wine_code_callback_func
	Namespace: zm_perk_widows_wine
	Checksum: 0x80F724D1
	Offset: 0x598
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function widows_wine_code_callback_func()
{
}

/*
	Name: function_fd02d096
	Namespace: zm_perk_widows_wine
	Checksum: 0xB7A720CC
	Offset: 0x5A8
	Size: 0x1BC
	Parameters: 7
	Flags: Linked
*/
function function_fd02d096(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(isalive(self))
		{
			if(!isdefined(self.var_ba239a31))
			{
				if(isdefined(self gettagorigin("j_spineupper")))
				{
					str_tag = "j_spineupper";
				}
				else
				{
					str_tag = "j_spine4";
				}
				self.var_ba239a31 = util::playfxontag(localclientnum, level._effect[#"winters_wail_freeze"], self, str_tag);
			}
			if(!isdefined(self.sndwidowswine))
			{
				self playsound(localclientnum, #"hash_21bfd3813003fd44");
				self.sndwidowswine = self playloopsound(#"hash_199de7173fb36de6", 0.1);
			}
		}
	}
	else if(isdefined(self.var_ba239a31))
	{
		stopfx(localclientnum, self.var_ba239a31);
		self.var_ba239a31 = undefined;
	}
	if(isdefined(self.sndwidowswine))
	{
		self stoploopsound(self.sndwidowswine, 1);
	}
}

/*
	Name: widows_wine_explosion
	Namespace: zm_perk_widows_wine
	Checksum: 0x743752B3
	Offset: 0x770
	Size: 0x11C
	Parameters: 7
	Flags: Linked
*/
function widows_wine_explosion(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval && isdefined(self) && isdefined(level._effect[#"winters_wail_explosion"]))
	{
		origin = self gettagorigin("j_spine4");
		if(!isdefined(origin))
		{
			origin = self.origin;
		}
		playfx(localclientnum, level._effect[#"winters_wail_explosion"], origin, anglestoforward(self.angles));
		self playsound(localclientnum, #"hash_3b59d3c99bac4071");
	}
}

/*
	Name: function_c6366dbe
	Namespace: zm_perk_widows_wine
	Checksum: 0x99CF6AD7
	Offset: 0x898
	Size: 0x278
	Parameters: 7
	Flags: Linked
*/
function function_c6366dbe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self.var_e7addfc4))
	{
		self.var_e7addfc4 = [];
	}
	if(isdefined(self.var_e7addfc4[localclientnum]))
	{
		stopfx(localclientnum, self.var_e7addfc4[localclientnum]);
		self.var_e7addfc4[localclientnum] = undefined;
	}
	a_e_players = getlocalplayers();
	foreach(e_player in a_e_players)
	{
		if(!e_player util::function_50ed1561(localclientnum))
		{
			e_player notify(#"hash_517b3e71a56dcfcb");
		}
	}
	if(newval)
	{
		self.var_e7addfc4[localclientnum] = util::playfxontag(localclientnum, level._effect[#"winters_wail_slow_field"], self, "j_spine");
		self playsound(localclientnum, #"hash_2d956dd01a5a8800");
		a_e_players = getlocalplayers();
		foreach(e_player in a_e_players)
		{
			if(!e_player util::function_50ed1561(localclientnum))
			{
				e_player thread zm_utility::function_ae3780f1(localclientnum, self.var_e7addfc4[localclientnum], #"hash_517b3e71a56dcfcb");
			}
		}
	}
}

