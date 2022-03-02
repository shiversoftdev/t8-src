// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\perks.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_7d2b62ed;

/*
	Name: function_89f2df9
	Namespace: namespace_7d2b62ed
	Checksum: 0x1B099ED8
	Offset: 0xA8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_b69b008e289ded4", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: namespace_7d2b62ed
	Checksum: 0x4C4F431B
	Offset: 0xF8
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"hash_b69b008e289ded4", "time", 30, &enable, &disable, &validation, undefined);
}

/*
	Name: enable
	Namespace: namespace_7d2b62ed
	Checksum: 0x22CAE6AF
	Offset: 0x188
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function enable()
{
	self thread function_1ff1beff();
	w_current = self getcurrentweapon();
	self function_9d347621(w_current);
}

/*
	Name: disable
	Namespace: namespace_7d2b62ed
	Checksum: 0xBE46133C
	Offset: 0x1E8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function disable()
{
	self endon(#"disconnect");
	self notify(#"hash_1b878c77be2d017b");
	wait(0.1);
	if(self hasperk("specialty_freefire"))
	{
		self perks::function_45d12554("specialty_freefire");
	}
}

/*
	Name: validation
	Namespace: namespace_7d2b62ed
	Checksum: 0xA3EDF05C
	Offset: 0x268
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
	Namespace: namespace_7d2b62ed
	Checksum: 0x8ED67F99
	Offset: 0x2D8
	Size: 0x1C8
	Parameters: 0
	Flags: Linked
*/
function function_1ff1beff()
{
	self endon(#"disconnect", #"player_downed", #"hash_1b878c77be2d017b");
	w_current = self getcurrentweapon();
	if(!(isdefined(w_current.isheroweapon) && w_current.isheroweapon) && !zm_weapons::is_wonder_weapon(w_current))
	{
		self perks::function_7637bafa("specialty_freefire");
	}
	while(true)
	{
		s_notify = undefined;
		s_notify = self waittill(#"weapon_change");
		var_1c114591 = s_notify.weapon;
		if(isdefined(var_1c114591.isheroweapon) && var_1c114591.isheroweapon || zm_weapons::is_wonder_weapon(var_1c114591))
		{
			if(self hasperk("specialty_freefire"))
			{
				self perks::function_45d12554("specialty_freefire");
			}
		}
		else
		{
			if(!self hasperk("specialty_freefire"))
			{
				self perks::function_7637bafa("specialty_freefire");
			}
			self function_9d347621(var_1c114591);
		}
	}
}

/*
	Name: function_9d347621
	Namespace: namespace_7d2b62ed
	Checksum: 0xCA54CAC1
	Offset: 0x4A8
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function function_9d347621(var_1c114591)
{
	n_ammo_total = 0;
	var_510d7f2b = self getweaponammostock(var_1c114591);
	n_ammo_clip = self getweaponammoclip(var_1c114591);
	n_ammo_total = n_ammo_total + (var_510d7f2b + n_ammo_clip);
	if(n_ammo_total == 0)
	{
		self setweaponammoclip(var_1c114591, 1);
	}
}

