// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_86e99a0d;

/*
	Name: function_89f2df9
	Namespace: namespace_86e99a0d
	Checksum: 0xBFF8431C
	Offset: 0xB0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_56d3df5058c56523", &__init__, undefined, "bgb");
}

/*
	Name: __init__
	Namespace: namespace_86e99a0d
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
	bgb::register(#"hash_56d3df5058c56523", "activated", 1, undefined, undefined, &validation, &activation);
}

/*
	Name: activation
	Namespace: namespace_86e99a0d
	Checksum: 0x5BCC4B26
	Offset: 0x178
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function activation()
{
	self function_92cb336d();
}

/*
	Name: validation
	Namespace: namespace_86e99a0d
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
		var_54cae2d8 = self.weaponriotshield;
		n_health_max = int(var_54cae2d8.weaponstarthitpoints);
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
	Name: function_92cb336d
	Namespace: namespace_86e99a0d
	Checksum: 0x186592DB
	Offset: 0x258
	Size: 0x13C
	Parameters: 0
	Flags: Linked
*/
function function_92cb336d()
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

