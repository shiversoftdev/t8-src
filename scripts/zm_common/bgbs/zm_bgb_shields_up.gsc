// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace zm_bgb_shields_up;

/*
	Name: __init__system__
	Namespace: zm_bgb_shields_up
	Checksum: 0xBFF8431C
	Offset: 0xB0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_bgb_shields_up", &__init__, undefined, "bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_shields_up
	Checksum: 0x56224796
	Offset: 0xF8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"zm_bgb_shields_up", "activated", 1, undefined, undefined, &validation, &activation);
}

/*
	Name: activation
	Namespace: zm_bgb_shields_up
	Checksum: 0x5BCC4B26
	Offset: 0x178
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function activation()
{
	self give_shield();
}

/*
	Name: validation
	Namespace: zm_bgb_shields_up
	Checksum: 0x5DE0A5BC
	Offset: 0x1A0
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function validation()
{
	if(isdefined(self.weaponriotshield) && self.weaponriotshield != level.weaponnone)
	{
		w_shield = self.weaponriotshield;
		n_health_max = int(w_shield.weaponstarthitpoints);
		var_9428def3 = self damageriotshield(0);
		if(var_9428def3 < n_health_max)
		{
			return true;
		}
		return false;
	}
	if(isdefined(level.var_b115fab2))
	{
		return true;
	}
	return false;
}

/*
	Name: give_shield
	Namespace: zm_bgb_shields_up
	Checksum: 0x186592DB
	Offset: 0x258
	Size: 0x13C
	Parameters: 0
	Flags: Linked
*/
function give_shield()
{
	if(!(isdefined(self.hasriotshield) && self.hasriotshield))
	{
		if(isdefined(self.var_5ba94c1e) && self.var_5ba94c1e && isdefined(level.var_70f7eb75))
		{
			self zm_weapons::weapon_give(level.var_70f7eb75);
			self zm_weapons::ammo_give(level.var_70f7eb75, 0);
		}
		else if(!self hasweapon(level.var_b115fab2))
		{
			self zm_weapons::weapon_give(level.var_b115fab2);
			self zm_weapons::ammo_give(level.var_b115fab2, 0);
		}
	}
	else if(isdefined(self.hasriotshield) && self.hasriotshield && isdefined(self.player_shield_reset_health))
	{
		self [[self.player_shield_reset_health]]();
		self zm_weapons::ammo_give(self.weaponriotshield, 0);
	}
}

