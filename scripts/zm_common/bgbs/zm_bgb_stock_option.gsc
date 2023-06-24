// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\perks.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace zm_bgb_stock_option;

/*
	Name: __init__system__
	Namespace: zm_bgb_stock_option
	Checksum: 0x7E9447DF
	Offset: 0xB8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_bgb_stock_option", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_stock_option
	Checksum: 0x921B9DD7
	Offset: 0x108
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"zm_bgb_stock_option", "time", 120, &enable, &disable, &validation);
	bgb::function_1fee6b3(#"zm_bgb_stock_option", 35);
}

/*
	Name: enable
	Namespace: zm_bgb_stock_option
	Checksum: 0xE4E3C6AA
	Offset: 0x1B8
	Size: 0x16C
	Parameters: 0
	Flags: Linked
*/
function enable()
{
	self thread function_1ff1beff();
	w_previous = self.previousweapon;
	if(w_previous.isprimary)
	{
		n_clip = self getweaponammoclip(w_previous);
		n_clip_size = w_previous.clipsize;
		n_stock_size = self getweaponammostock(w_previous);
		var_97c3ac3d = n_clip_size - n_clip;
		if(var_97c3ac3d > 0 && n_stock_size > 0)
		{
			if(n_stock_size >= var_97c3ac3d)
			{
				self setweaponammoclip(w_previous, n_clip_size);
				var_88f48290 = n_stock_size - var_97c3ac3d;
				self setweaponammostock(w_previous, var_88f48290);
			}
			else
			{
				var_3a347a66 = n_clip + n_stock_size;
				self setweaponammoclip(w_previous, var_3a347a66);
				self setweaponammostock(w_previous, 0);
			}
		}
	}
}

/*
	Name: disable
	Namespace: zm_bgb_stock_option
	Checksum: 0x98916C32
	Offset: 0x330
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function disable()
{
	self endon(#"disconnect");
	self notify(#"hash_120ea24fd48cb17a");
	wait(0.1);
	if(self hasperk("specialty_ammodrainsfromstockfirst"))
	{
		self perks::perk_unsetperk("specialty_ammodrainsfromstockfirst");
	}
}

/*
	Name: validation
	Namespace: zm_bgb_stock_option
	Checksum: 0x3BB553DB
	Offset: 0x3B0
	Size: 0x68
	Parameters: 0
	Flags: Linked
*/
function validation()
{
	w_current = self getcurrentweapon();
	if(isdefined(w_current.isheroweapon) && w_current.isheroweapon || zm_weapons::is_wonder_weapon(w_current))
	{
		return false;
	}
	return true;
}

/*
	Name: function_1ff1beff
	Namespace: zm_bgb_stock_option
	Checksum: 0x7AB17EAC
	Offset: 0x420
	Size: 0x1B0
	Parameters: 0
	Flags: Linked
*/
function function_1ff1beff()
{
	self endon(#"disconnect", #"player_downed", #"hash_120ea24fd48cb17a");
	w_current = self getcurrentweapon();
	if(!(isdefined(w_current.isheroweapon) && w_current.isheroweapon) && !zm_weapons::is_wonder_weapon(w_current))
	{
		self perks::perk_setperk("specialty_ammodrainsfromstockfirst");
	}
	while(true)
	{
		s_notify = undefined;
		s_notify = self waittill(#"weapon_change");
		w_check = s_notify.weapon;
		if(isdefined(w_check.isheroweapon) && w_check.isheroweapon || zm_weapons::is_wonder_weapon(w_check))
		{
			if(self hasperk("specialty_ammodrainsfromstockfirst"))
			{
				self perks::perk_unsetperk("specialty_ammodrainsfromstockfirst");
			}
		}
		else if(!self hasperk("specialty_ammodrainsfromstockfirst"))
		{
			self perks::perk_setperk("specialty_ammodrainsfromstockfirst");
		}
	}
}

