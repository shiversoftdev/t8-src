// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace zm_weap_ray_gun_mk2y;

/*
	Name: __init__system__
	Namespace: zm_weap_ray_gun_mk2y
	Checksum: 0x44CE5592
	Offset: 0x100
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"ray_gun_mk2y", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_weap_ray_gun_mk2y
	Checksum: 0x54A87F51
	Offset: 0x148
	Size: 0x1DC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_585eeded = spawnstruct();
	level.var_585eeded.var_ba76fe32[#"ray_gun_mk2y"] = getweapon("ray_gun_mk2y");
	level.var_585eeded.var_ba76fe32[#"ray_gun_mk2y_charged"] = getweapon("ray_gun_mk2y_charged");
	level.var_585eeded.var_ba76fe32[#"ray_gun_mk2y_upgraded"] = getweapon("ray_gun_mk2y_upgraded");
	level.var_585eeded.var_ba76fe32[#"ray_gun_mk2y_upgraded_charged"] = getweapon("ray_gun_mk2y_upgraded_charged");
	callback::function_f77ced93(&function_f77ced93);
	callback::function_34dea974(level.var_585eeded.var_ba76fe32[#"ray_gun_mk2y_charged"], &function_8a977b42);
	callback::function_34dea974(level.var_585eeded.var_ba76fe32[#"ray_gun_mk2y_upgraded_charged"], &function_8a977b42);
	clientfield::register("allplayers", "" + #"ray_gun_mk2y_charged", 20000, 1, "int");
}

/*
	Name: function_f77ced93
	Namespace: zm_weap_ray_gun_mk2y
	Checksum: 0xAFFF13F5
	Offset: 0x330
	Size: 0x6E
	Parameters: 1
	Flags: Linked
*/
function function_f77ced93(s_params)
{
	if(function_5b0214e(s_params.weapon))
	{
		self thread function_54922a21();
	}
	else if(function_5b0214e(s_params.last_weapon))
	{
		self notify(#"hash_414b2baf34e01af8");
	}
}

/*
	Name: function_54922a21
	Namespace: zm_weap_ray_gun_mk2y
	Checksum: 0x63909996
	Offset: 0x3A8
	Size: 0x180
	Parameters: 0
	Flags: Linked
*/
function function_54922a21()
{
	self endoncallback(&function_a059fe7f, #"death", #"hash_414b2baf34e01af8");
	w_current = self getcurrentweapon();
	while(true)
	{
		b_charged = 0;
		while(self attackbuttonpressed() && !self meleebuttonpressed() && !self laststand::player_is_in_laststand())
		{
			if(!b_charged && isdefined(self.chargeshotlevel) && self.chargeshotlevel > 1)
			{
				self function_bfbef8cc(self getcurrentweapon());
				self clientfield::set("" + #"ray_gun_mk2y_charged", 1);
				b_charged = 1;
			}
			waitframe(1);
		}
		if(b_charged)
		{
			self function_a059fe7f();
			wait(1);
		}
		else
		{
			waitframe(1);
		}
	}
}

/*
	Name: function_a059fe7f
	Namespace: zm_weap_ray_gun_mk2y
	Checksum: 0xAB4EF90D
	Offset: 0x530
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_a059fe7f(str_notify)
{
	self clientfield::set("" + #"ray_gun_mk2y_charged", 0);
}

/*
	Name: function_5b0214e
	Namespace: zm_weap_ray_gun_mk2y
	Checksum: 0xB334DD33
	Offset: 0x570
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_5b0214e(weapon)
{
	return isdefined(weapon) && isinarray(level.var_585eeded.var_ba76fe32, weapon);
}

/*
	Name: function_60365a28
	Namespace: zm_weap_ray_gun_mk2y
	Checksum: 0xF92C6688
	Offset: 0x5B8
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function function_60365a28(weapon)
{
	if(weapon == level.var_585eeded.var_ba76fe32[#"ray_gun_mk2y"] || weapon == level.var_585eeded.var_ba76fe32[#"ray_gun_mk2y_charged"])
	{
		return level.var_585eeded.var_ba76fe32[#"ray_gun_mk2y"];
	}
	return level.var_585eeded.var_ba76fe32[#"ray_gun_mk2y_upgraded"];
}

/*
	Name: function_8a977b42
	Namespace: zm_weap_ray_gun_mk2y
	Checksum: 0x2B2E9F13
	Offset: 0x668
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_8a977b42(weapon)
{
	self setweaponammoclip(function_60365a28(weapon), 0);
}

/*
	Name: function_bfbef8cc
	Namespace: zm_weap_ray_gun_mk2y
	Checksum: 0x374AEE79
	Offset: 0x6A8
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function function_bfbef8cc(weapon)
{
	w_uncharged = function_60365a28(weapon);
	n_clip_ammo = self getweaponammoclip(w_uncharged);
	if(n_clip_ammo < w_uncharged.clipsize)
	{
		n_ammo_diff = w_uncharged.clipsize - n_clip_ammo;
		n_stock_ammo = self getweaponammostock(w_uncharged);
		self setweaponammostock(w_uncharged, n_stock_ammo - n_ammo_diff);
		self setweaponammoclip(w_uncharged, w_uncharged.clipsize);
	}
}

