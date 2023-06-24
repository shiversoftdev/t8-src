// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\trials\zm_trial_reset_loadout.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_perks.gsc;

#namespace zm_perk_bandolier;

/*
	Name: __init__system__
	Namespace: zm_perk_bandolier
	Checksum: 0x728B343C
	Offset: 0x150
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_bandolier", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_bandolier
	Checksum: 0x3B8762F5
	Offset: 0x198
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_27473e44();
}

/*
	Name: function_27473e44
	Namespace: zm_perk_bandolier
	Checksum: 0xD1F47881
	Offset: 0x1B8
	Size: 0x194
	Parameters: 0
	Flags: Linked
*/
function function_27473e44()
{
	zm_perks::register_perk_basic_info(#"specialty_extraammo", #"perk_bandolier", 3000, #"zombie/perk_bandolier", getweapon("zombie_perk_bottle_bandolier"), getweapon("zombie_perk_totem_bandolier"), #"zmperksbandolier");
	zm_perks::register_perk_precache_func(#"specialty_extraammo", &function_8c3e9b8b);
	zm_perks::register_perk_clientfields(#"specialty_extraammo", &perk_register_clientfield, &perk_set_clientfield);
	zm_perks::register_perk_machine(#"specialty_extraammo", &perk_machine_setup);
	zm_perks::register_perk_host_migration_params(#"specialty_extraammo", "vending_bandolier", "sleight_light");
	zm_perks::register_perk_threads(#"specialty_extraammo", &give_perk, &take_perk);
}

/*
	Name: function_8c3e9b8b
	Namespace: zm_perk_bandolier
	Checksum: 0xACD5566C
	Offset: 0x358
	Size: 0xE6
	Parameters: 0
	Flags: Linked
*/
function function_8c3e9b8b()
{
	if(isdefined(level.var_51552992))
	{
		[[level.var_51552992]]();
		return;
	}
	level.machine_assets[#"specialty_extraammo"] = spawnstruct();
	level.machine_assets[#"specialty_extraammo"].weapon = getweapon("zombie_perk_bottle_bandolier");
	level.machine_assets[#"specialty_extraammo"].off_model = "p7_zm_vending_sleight";
	level.machine_assets[#"specialty_extraammo"].on_model = "p7_zm_vending_sleight";
}

/*
	Name: perk_register_clientfield
	Namespace: zm_perk_bandolier
	Checksum: 0x80F724D1
	Offset: 0x448
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function perk_register_clientfield()
{
}

/*
	Name: perk_set_clientfield
	Namespace: zm_perk_bandolier
	Checksum: 0x93608F67
	Offset: 0x458
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function perk_set_clientfield(state)
{
}

/*
	Name: perk_machine_setup
	Namespace: zm_perk_bandolier
	Checksum: 0x9D0ADBF2
	Offset: 0x470
	Size: 0xB6
	Parameters: 4
	Flags: Linked
*/
function perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound = "mus_perks_speed_jingle";
	use_trigger.script_string = "bandolier_perk";
	use_trigger.script_label = "mus_perks_speed_sting";
	use_trigger.target = "vending_bandolier";
	perk_machine.script_string = "bandolier_perk";
	perk_machine.targetname = "vending_bandolier";
	if(isdefined(bump_trigger))
	{
		bump_trigger.script_string = "bandolier_perk";
	}
}

/*
	Name: give_perk
	Namespace: zm_perk_bandolier
	Checksum: 0xA07E3F9C
	Offset: 0x530
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function give_perk()
{
	self set_ammo();
}

/*
	Name: take_perk
	Namespace: zm_perk_bandolier
	Checksum: 0xE8E0620
	Offset: 0x558
	Size: 0x3C
	Parameters: 4
	Flags: Linked
*/
function take_perk(b_pause, str_perk, str_result, n_slot)
{
	self set_ammo(0);
}

/*
	Name: set_ammo
	Namespace: zm_perk_bandolier
	Checksum: 0x97CB415F
	Offset: 0x5A0
	Size: 0x1E0
	Parameters: 1
	Flags: Linked
*/
function set_ammo(b_max_ammo = 1)
{
	a_weapons = self getweaponslistprimaries();
	foreach(weapon in a_weapons)
	{
		if(weaponhasattachment(weapon, "uber") && weapon.statname == #"smg_capacity_t8")
		{
			continue;
		}
		if(weapon !== self.laststandpistol)
		{
			if(b_max_ammo)
			{
				var_67f27715 = weapon.maxammo - weapon.startammo;
				var_45193587 = self getweaponammostock(weapon);
				if(zm_trial_reset_loadout::is_active(1))
				{
					var_88f48290 = 0;
				}
				else
				{
					var_88f48290 = var_45193587 + var_67f27715;
				}
				self setweaponammostock(weapon, var_88f48290);
				continue;
			}
			if(self getweaponammostock(weapon) > weapon.startammo)
			{
				self setweaponammostock(weapon, weapon.startammo);
			}
		}
	}
}

