// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_stats.gsc;

#namespace zm_bgb_equip_mint;

/*
	Name: __init__system__
	Namespace: zm_bgb_equip_mint
	Checksum: 0xE30BAA5D
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_bgb_equip_mint", &__init__, undefined, "bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_equip_mint
	Checksum: 0x72885549
	Offset: 0xE8
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
	bgb::register(#"zm_bgb_equip_mint", "activated", 1, undefined, undefined, &validation, &activation);
}

/*
	Name: activation
	Namespace: zm_bgb_equip_mint
	Checksum: 0x48E35A7B
	Offset: 0x168
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function activation()
{
	var_ac6ee9a0 = self zm_loadout::get_player_lethal_grenade();
	if(var_ac6ee9a0.isgadget)
	{
		n_slot = self gadgetgetslot(var_ac6ee9a0);
		if(var_ac6ee9a0 == getweapon(#"tomahawk_t8") || var_ac6ee9a0 == getweapon(#"tomahawk_t8_upgraded"))
		{
			self notify(#"hash_3d73720d4588203c");
			self gadgetpowerset(n_slot, 100);
		}
		else
		{
			self gadgetpowerreset(n_slot, 0);
		}
	}
	self zm_stats::increment_challenge_stat(#"hash_47646e52fcbb190e");
}

/*
	Name: validation
	Namespace: zm_bgb_equip_mint
	Checksum: 0xBB5C41A1
	Offset: 0x290
	Size: 0x142
	Parameters: 0
	Flags: Linked
*/
function validation()
{
	var_ac6ee9a0 = self zm_loadout::get_player_lethal_grenade();
	n_stock_size = self getweaponammostock(var_ac6ee9a0);
	n_clip_size = self getweaponammoclipsize(var_ac6ee9a0);
	n_slot = self gadgetgetslot(var_ac6ee9a0);
	n_power = self gadgetpowerget(n_slot);
	if(var_ac6ee9a0 == getweapon(#"tomahawk_t8") || var_ac6ee9a0 == getweapon(#"tomahawk_t8_upgraded") && self function_36dfc05f(n_slot))
	{
		return false;
	}
	if(n_stock_size < n_clip_size || n_power < 100)
	{
		return true;
	}
	return false;
}

