// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_magicbox.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace zm_bgb_bullet_boost;

/*
	Name: function_89f2df9
	Namespace: zm_bgb_bullet_boost
	Checksum: 0xF20931D3
	Offset: 0xD0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_bgb_bullet_boost", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_bullet_boost
	Checksum: 0xDF496373
	Offset: 0x120
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"zm_bgb_bullet_boost", "activated", 1, undefined, undefined, &validation, &activation);
	bgb::function_e1f37ce7(#"zm_bgb_bullet_boost");
}

/*
	Name: validation
	Namespace: zm_bgb_bullet_boost
	Checksum: 0x74A8E8E9
	Offset: 0x1C0
	Size: 0xDA
	Parameters: 0
	Flags: Linked
*/
function validation()
{
	current_weapon = self getcurrentweapon();
	if(!zm_weapons::is_weapon_or_base_included(current_weapon) || !self zm_magicbox::can_buy_weapon() || self laststand::player_is_in_laststand() || (isdefined(self.intermission) && self.intermission) || self isthrowinggrenade() || self isswitchingweapons() || !zm_weapons::weapon_supports_aat(current_weapon))
	{
		return 0;
	}
	return 1;
}

/*
	Name: activation
	Namespace: zm_bgb_bullet_boost
	Checksum: 0x184099A0
	Offset: 0x2A8
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function activation()
{
	self endon(#"death");
	self playsoundtoplayer(#"zmb_bgb_bullet_boost", self);
	current_weapon = self getcurrentweapon();
	current_weapon = self zm_weapons::switch_from_alt_weapon(current_weapon);
	var_9a9544b8 = self aat::getaatonweapon(current_weapon, 1);
	self aat::acquire(current_weapon, undefined, var_9a9544b8);
}

