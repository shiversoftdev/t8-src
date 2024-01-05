// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\math_shared.gsc;

#namespace zm_weap_molotov;

/*
	Name: __init__system__
	Namespace: zm_weap_molotov
	Checksum: 0x70F70EAB
	Offset: 0x98
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"molotov_zm", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_weap_molotov
	Checksum: 0x1315E9C2
	Offset: 0xE8
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function __init__()
{
	zm::register_actor_damage_callback(&function_32766bb7);
}

/*
	Name: __main__
	Namespace: zm_weap_molotov
	Checksum: 0x22F4C70C
	Offset: 0x118
	Size: 0x62
	Parameters: 0
	Flags: None
*/
function __main__()
{
	level._effect[#"hash_5dfe974bf370a5f4"] = #"zm_weapons/fx8_equip_mltv_fire_human_torso_loop_zm";
	level._effect[#"hash_31b6cc906e6d0ae0"] = #"hash_3937ef26298b6caf";
}

/*
	Name: function_32766bb7
	Namespace: zm_weap_molotov
	Checksum: 0x29EDC8A3
	Offset: 0x188
	Size: 0x1EE
	Parameters: 12
	Flags: None
*/
function function_32766bb7(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(isweapon(weapon))
	{
		switch(weapon.name)
		{
			case "molotov_fire_tall":
			case "molotov_fire":
			case "eq_molotov_extra":
			case "molotov_fire_wall":
			case "molotov_fire_small":
			case "eq_molotov":
			case "molotov_steam":
			{
				if(meansofdeath === "MOD_GRENADE")
				{
					if(self.archetype == #"zombie" && damage <= self.health)
					{
						return self.health;
					}
				}
				self.weapon_specific_fire_death_torso_fx = level._effect[#"hash_5dfe974bf370a5f4"];
				self.weapon_specific_fire_death_sm_fx = level._effect[#"hash_5dfe974bf370a5f4"];
				var_5d7b4163 = zm_equipment::function_379f6b5d(damage, 3, 0.3, 4, 14);
				return var_5d7b4163;
				break;
			}
		}
	}
	return -1;
}

