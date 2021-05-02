// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_6e3c826b1814cab6;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_53595129;

/*
	Name: init
	Namespace: namespace_53595129
	Checksum: 0xAA9FCA55
	Offset: 0x278
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function init()
{
	callback::on_connect(&function_17b76033);
}

/*
	Name: function_17b76033
	Namespace: namespace_53595129
	Checksum: 0x2723C129
	Offset: 0x2A8
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function function_17b76033()
{
	self thread function_f47a878a();
	self thread function_70003bac();
	self thread function_4f363fd4();
	self thread function_cf262a06();
	self thread function_e5df009();
	self thread function_4c6d1750();
	self thread function_8b752e69();
	self thread function_ce31237b();
	self thread function_73fdd23e();
}

/*
	Name: function_73fdd23e
	Namespace: namespace_53595129
	Checksum: 0x74C48D92
	Offset: 0x390
	Size: 0x44
	Parameters: 0
	Flags: Linked, Private
*/
private function function_73fdd23e()
{
	self endon(#"disconnect");
	self waittill(#"hash_108cb6aa18caf726");
	self zm_utility::giveachievement_wrapper("zm_escape_most_escape");
}

/*
	Name: function_f47a878a
	Namespace: namespace_53595129
	Checksum: 0x7371E1FC
	Offset: 0x3E0
	Size: 0x44
	Parameters: 0
	Flags: Linked, Private
*/
private function function_f47a878a()
{
	self endon(#"disconnect");
	self waittill(#"hash_6db9af45fe6345fc");
	self zm_utility::giveachievement_wrapper("zm_escape_patch_up");
}

/*
	Name: function_70003bac
	Namespace: namespace_53595129
	Checksum: 0xDBCC10E5
	Offset: 0x430
	Size: 0x44
	Parameters: 0
	Flags: Linked, Private
*/
private function function_70003bac()
{
	self endon(#"disconnect");
	self waittill(#"hash_6e0a27b37f225a25");
	self zm_utility::giveachievement_wrapper("zm_escape_hot_stuff");
}

/*
	Name: function_4f363fd4
	Namespace: namespace_53595129
	Checksum: 0xF0333B1A
	Offset: 0x480
	Size: 0x294
	Parameters: 0
	Flags: Linked, Private
*/
private function function_4f363fd4()
{
	self endon(#"disconnect");
	var_4f57eb04 = getweapon(#"hash_19c157f2230454ad");
	var_ab3c01bc = getweapon(#"hash_cb1cdb5b47f0226");
	var_f92d6c6e = getweapon(#"tomahawk_t8");
	var_b7c4015f = getweapon(#"tomahawk_t8_upgraded");
	var_7088dc5c = getweapon(#"hash_52b03a79f854eed3");
	var_444cfef5 = getweapon(#"hash_32a584f5a65c70d1");
	var_f0511818 = getweapon(#"smg_thompson_t8");
	var_149c244d = getweapon(#"hash_3273c6574279dea9");
	b_continue = 1;
	while(true)
	{
		self waittill(#"weapon_change");
		if(isalive(self))
		{
			if(self hasweapon(var_4f57eb04) || self hasweapon(var_ab3c01bc) && (self hasweapon(var_f92d6c6e) || self hasweapon(var_b7c4015f)) && (self hasweapon(var_7088dc5c) || self hasweapon(var_444cfef5)) && (self hasweapon(var_f0511818) || self hasweapon(var_149c244d)))
			{
				break;
			}
		}
	}
	self zm_utility::giveachievement_wrapper("zm_escape_hist_reenact");
}

/*
	Name: function_cf262a06
	Namespace: namespace_53595129
	Checksum: 0x7D0C722
	Offset: 0x720
	Size: 0x44
	Parameters: 0
	Flags: Linked, Private
*/
private function function_cf262a06()
{
	self endon(#"disconnect");
	self waittill(#"hash_7af72088379d7ac6");
	self zm_utility::giveachievement_wrapper("zm_escape_match_made");
}

/*
	Name: function_e5df009
	Namespace: namespace_53595129
	Checksum: 0xBE9F23FC
	Offset: 0x770
	Size: 0x1EC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_e5df009()
{
	self endon(#"disconnect", #"hash_b5d3534da3f4508");
	level endon(#"end_game", #"activate_catwalk");
	if(level flag::get("activate_catwalk"))
	{
		return;
	}
	if(namespace_59ff1d6c::function_901b751c(#"startround") > 1)
	{
		return;
	}
	if(namespace_59ff1d6c::function_901b751c(#"hash_29004a67830922b6") != 2)
	{
		while(level.round_number < 20)
		{
			level waittill(#"end_of_round");
		}
	}
	else
	{
		var_76f21e6b = array("zone_model_industries", "zone_model_industries_upper", "zone_west_side_exterior_upper", "zone_west_side_exterior_upper_02", "zone_west_side_exterior_lower", "zone_powerhouse", "zone_west_side_exterior_tunnel", "zone_new_industries", "zone_new_industries_transverse_tunnel");
		while(level.round_number < 20)
		{
			str_zone = self zm_zonemgr::get_player_zone();
			if(!isdefined(str_zone) || !isinarray(var_76f21e6b, str_zone))
			{
				self notify(#"hash_b5d3534da3f4508");
			}
			wait(1);
		}
	}
	self zm_utility::giveachievement_wrapper("zm_escape_west_side");
}

/*
	Name: function_4c6d1750
	Namespace: namespace_53595129
	Checksum: 0x10353EB
	Offset: 0x968
	Size: 0xB2
	Parameters: 0
	Flags: Linked, Private
*/
private function function_4c6d1750()
{
	self endon(#"disconnect", #"hash_1410cda9f15ef1c3");
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"hash_3669499a148a6d6e");
		if(var_88706ea7.weapon == getweapon(#"tomahawk_t8_upgraded"))
		{
			self zm_utility::giveachievement_wrapper("zm_escape_senseless");
			self notify(#"hash_1410cda9f15ef1c3");
		}
	}
}

/*
	Name: function_8b752e69
	Namespace: namespace_53595129
	Checksum: 0xB22489BB
	Offset: 0xA28
	Size: 0x224
	Parameters: 0
	Flags: Linked, Private
*/
private function function_8b752e69()
{
	self endon(#"disconnect");
	self.var_cd7cfb60 = 0;
	self.var_8179ae74 = 0;
	self.var_3ad4276f = 0;
	while(!self.var_cd7cfb60 || !self.var_8179ae74 || !self.var_3ad4276f)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"hash_2e36f5f4d9622bb3");
		if(var_88706ea7.weapon == getweapon(#"hash_19c157f2230454ad") || var_88706ea7.weapon == getweapon(#"hash_cb1cdb5b47f0226"))
		{
			self.var_cd7cfb60 = 1;
		}
		if(var_88706ea7.weapon == getweapon(#"hash_23882a5729dceca") || var_88706ea7.weapon == getweapon(#"hash_1b5092cccdb3d65b"))
		{
			self.var_8179ae74 = 1;
		}
		if(var_88706ea7.weapon == getweapon(#"hash_25a13b6f6232a985") || var_88706ea7.weapon == getweapon(#"hash_4c157b1aeefae09e") || var_88706ea7.weapon == getweapon(#"hash_494f5501b3f8e1e9"))
		{
			self.var_3ad4276f = 1;
		}
	}
	self zm_utility::giveachievement_wrapper("zm_escape_gat");
}

/*
	Name: function_ce31237b
	Namespace: namespace_53595129
	Checksum: 0xCBC86ED5
	Offset: 0xC58
	Size: 0x1DC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_ce31237b()
{
	level endon(#"soul_catchers_charged");
	self endon(#"disconnect");
	if(!level flag::exists(#"soul_catchers_charged") || level flag::get(#"soul_catchers_charged"))
	{
		return;
	}
	self.var_23d1ca17 = 0;
	self.var_ba2bd447 = 0;
	self.var_5b73502a = 0;
	while(!self.var_23d1ca17 || !self.var_ba2bd447 || !self.var_5b73502a)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"hash_2706d6137c04adf4");
		str_zone = self zm_zonemgr::get_player_zone();
		if(!isdefined(str_zone))
		{
			continue;
		}
		switch(str_zone)
		{
			case "zone_model_industries_upper":
			{
				self.var_5b73502a = 1;
				break;
			}
			case "zone_gondola_ride":
			{
				self.var_23d1ca17 = 1;
				break;
			}
			case "zone_citadel":
			case "zone_citadel_shower":
			case "zone_citadel_warden":
			{
				self.var_ba2bd447 = 1;
				break;
			}
		}
	}
	self zm_utility::giveachievement_wrapper("zm_escape_throw_dog");
}

