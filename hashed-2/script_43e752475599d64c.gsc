// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_5660bae5b402a1eb;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_blockers.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_d2304f18;

/*
	Name: function_89f2df9
	Namespace: namespace_d2304f18
	Checksum: 0x935496B4
	Offset: 0x110
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_493e4f8e3fb8b3d7", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_d2304f18
	Checksum: 0xE9750827
	Offset: 0x158
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_powerups::register_powerup("hero_weapon_power", &hero_weapon_power);
	if(zm_powerups::function_cc33adc8())
	{
		zm_powerups::add_zombie_powerup("hero_weapon_power", "p8_zm_powerup_full_power", #"zombie_powerup_free_perk", &function_7e51ac0f, 1, 0, 0);
	}
}

/*
	Name: function_7e51ac0f
	Namespace: namespace_d2304f18
	Checksum: 0x43A91667
	Offset: 0x1E8
	Size: 0xE
	Parameters: 0
	Flags: Linked
*/
function function_7e51ac0f()
{
	return level.var_ff96c5e4;
}

/*
	Name: hero_weapon_power
	Namespace: namespace_d2304f18
	Checksum: 0xB7F1552F
	Offset: 0x200
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function hero_weapon_power(e_player)
{
	e_player endon(#"death");
	if(isdefined(self.var_1f23fe79) && self.var_1f23fe79)
	{
		self waittill(#"hash_3eaa776332738598");
	}
	if(isdefined(self.var_c2bcd604) && self.var_c2bcd604)
	{
		e_player gadgetpowerchange(level.var_a53a05b5, self.var_c2bcd604);
	}
	else
	{
		e_player gadgetpowerset(level.var_a53a05b5, 100);
	}
	e_player thread function_5792ec16();
}

/*
	Name: function_5792ec16
	Namespace: namespace_d2304f18
	Checksum: 0xFA9A513B
	Offset: 0x2E0
	Size: 0x42
	Parameters: 0
	Flags: Linked, Private
*/
private function function_5792ec16()
{
	self endon(#"disconnect");
	self.var_c09e6d59 = 1;
	wait(2);
	self.var_c09e6d59 = undefined;
}

