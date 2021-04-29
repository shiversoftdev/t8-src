// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f9e0dc8454d98e1;
#using script_fb16bd158a3e3e7;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_spawner.gsc;

#namespace namespace_3da77d43;

/*
	Name: function_89f2df9
	Namespace: namespace_3da77d43
	Checksum: 0xAEF80383
	Offset: 0x1A0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_52dccf7e9237dda5", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_3da77d43
	Checksum: 0xB5C8D4C6
	Offset: 0x1F0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_9c732a0a();
}

/*
	Name: __main__
	Namespace: namespace_3da77d43
	Checksum: 0x80F724D1
	Offset: 0x210
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: function_9c732a0a
	Namespace: namespace_3da77d43
	Checksum: 0x36033FD5
	Offset: 0x220
	Size: 0x23C
	Parameters: 0
	Flags: Linked
*/
function function_9c732a0a()
{
	if(function_8b1a219a())
	{
		zm_perks::register_perk_basic_info(#"specialty_shield", #"hash_2d1dfb82ebcbdb7d", 2500, #"hash_61f2a9db3bdc745a", getweapon("zombie_perk_bottle_tortoise"), getweapon("zombie_perk_totem_tortoise"), #"hash_2dd9d538ca5bc2d6");
	}
	else
	{
		zm_perks::register_perk_basic_info(#"specialty_shield", #"hash_2d1dfb82ebcbdb7d", 2500, #"hash_2e1b0028aad4722e", getweapon("zombie_perk_bottle_tortoise"), getweapon("zombie_perk_totem_tortoise"), #"hash_2dd9d538ca5bc2d6");
	}
	zm_perks::register_perk_precache_func(#"specialty_shield", &function_1441654f);
	zm_perks::register_perk_clientfields(#"specialty_shield", &function_2ebeec84, &function_9b64bd1b);
	zm_perks::register_perk_machine(#"specialty_shield", &function_c282add5, &function_3cc019d7);
	zm_perks::register_perk_host_migration_params(#"specialty_shield", "p7_zm_vending_nuke", "divetonuke_light");
	zm_perks::register_perk_threads(#"specialty_shield", &function_f8196ccf, &function_b754923d);
}

/*
	Name: function_3cc019d7
	Namespace: namespace_3da77d43
	Checksum: 0x80F724D1
	Offset: 0x468
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_3cc019d7()
{
}

/*
	Name: function_1441654f
	Namespace: namespace_3da77d43
	Checksum: 0x522B5A7C
	Offset: 0x478
	Size: 0xBE
	Parameters: 0
	Flags: Linked
*/
function function_1441654f()
{
	level.machine_assets[#"specialty_shield"] = spawnstruct();
	level.machine_assets[#"specialty_shield"].weapon = getweapon("zombie_perk_bottle_tortoise");
	level.machine_assets[#"specialty_shield"].off_model = "p7_zm_vending_nuke";
	level.machine_assets[#"specialty_shield"].on_model = "p7_zm_vending_nuke";
}

/*
	Name: function_2ebeec84
	Namespace: namespace_3da77d43
	Checksum: 0xD17D2409
	Offset: 0x540
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_2ebeec84()
{
	clientfield::register("allplayers", "perk_tortoise_explosion", 1, 1, "counter");
}

/*
	Name: function_9b64bd1b
	Namespace: namespace_3da77d43
	Checksum: 0x1AC30970
	Offset: 0x580
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function function_9b64bd1b(state)
{
}

/*
	Name: function_c282add5
	Namespace: namespace_3da77d43
	Checksum: 0x7E8200BC
	Offset: 0x598
	Size: 0xB6
	Parameters: 4
	Flags: Linked
*/
function function_c282add5(use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound = "mus_perks_phd_jingle";
	use_trigger.script_string = "divetonuke_perk";
	use_trigger.script_label = "mus_perks_phd_sting";
	use_trigger.target = "vending_divetonuke";
	perk_machine.script_string = "divetonuke_perk";
	perk_machine.targetname = "vending_divetonuke";
	if(isdefined(bump_trigger))
	{
		bump_trigger.script_string = "divetonuke_perk";
	}
}

/*
	Name: function_f8196ccf
	Namespace: namespace_3da77d43
	Checksum: 0xF6B084E5
	Offset: 0x658
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function function_f8196ccf()
{
	self.var_27aeb716 = &function_81058b09;
}

/*
	Name: function_b754923d
	Namespace: namespace_3da77d43
	Checksum: 0x615F78A7
	Offset: 0x680
	Size: 0x2E
	Parameters: 4
	Flags: Linked
*/
function function_b754923d(b_pause, str_perk, str_result, var_bcd1c2ff)
{
	self.var_27aeb716 = undefined;
}

/*
	Name: function_81058b09
	Namespace: namespace_3da77d43
	Checksum: 0x5DE31F3F
	Offset: 0x6B8
	Size: 0x330
	Parameters: 1
	Flags: Linked
*/
function function_81058b09(var_d92ac80e)
{
	a_ai = self function_bdda420f(self.origin, 320);
	a_ai = arraysortclosest(a_ai, self.origin);
	if(namespace_6b49f66b::is_active())
	{
		a_ai = [];
	}
	foreach(ai in a_ai)
	{
		if(ai.health <= 1200)
		{
			ai.marked_for_death = 1;
		}
	}
	self playsound(#"hash_14f5104610856f3e");
	self thread explosion_fx();
	v_explosion_origin = self.origin;
	foreach(ai in a_ai)
	{
		if(!isalive(ai))
		{
			continue;
		}
		ai.var_cbfc5f6e = 1;
		ai dodamage(1200, v_explosion_origin, self, self, "none", "MOD_EXPLOSIVE", 0, var_d92ac80e);
		if(isalive(ai))
		{
			if(ai.var_6f84b820 === #"heavy" || ai.var_6f84b820 === #"miniboss")
			{
				if(!(isdefined(ai.knockdown) && ai.knockdown))
				{
					ai ai::stun();
				}
			}
			else
			{
				ai zombie_utility::setup_zombie_knockdown(v_explosion_origin);
			}
		}
		else if(isdefined(ai) && (ai.var_6f84b820 === #"basic" || ai.var_6f84b820 === #"enhanced"))
		{
			ai zm_spawner::zombie_explodes_intopieces(0);
		}
		if(isdefined(ai))
		{
			ai.var_cbfc5f6e = undefined;
		}
		waitframe(1);
	}
}

/*
	Name: explosion_fx
	Namespace: namespace_3da77d43
	Checksum: 0x804CDD76
	Offset: 0x9F0
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function explosion_fx()
{
	self endon(#"death");
	wait(0.3);
	self clientfield::increment("perk_tortoise_explosion");
}

