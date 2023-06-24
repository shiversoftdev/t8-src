// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_spawner.gsc;

#namespace namespace_ca8676a3;

/*
	Name: __init__system__
	Namespace: namespace_ca8676a3
	Checksum: 0x4041B5EE
	Offset: 0x110
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_217942543a3e669b", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_ca8676a3
	Checksum: 0xD32C139B
	Offset: 0x160
	Size: 0x7E
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	spawner::add_archetype_spawn_function(#"zod_companion", &function_10c92445);
	zm::function_84d343d(#"hash_680d9169c5e72bdc", &function_f1be5640);
	level.var_af29d768 = &function_80bc397d;
}

/*
	Name: __main__
	Namespace: namespace_ca8676a3
	Checksum: 0x80F724D1
	Offset: 0x1E8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: function_10c92445
	Namespace: namespace_ca8676a3
	Checksum: 0x957BDDA7
	Offset: 0x1F8
	Size: 0x9C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_10c92445()
{
	self.ignore_nuke = 1;
	self.ignore_all_poi = 1;
	self.instakill_func = &zm_powerups::function_16c2586a;
	self.var_69bfb00a = &function_188e5077;
	self.var_594b7855 = 1;
	if(isdefined(level.var_777acf92))
	{
		self thread function_65ed0370(level.var_777acf92.origin, level.var_777acf92.angles);
	}
}

/*
	Name: function_188e5077
	Namespace: namespace_ca8676a3
	Checksum: 0xCBE69EDA
	Offset: 0x2A0
	Size: 0x34
	Parameters: 1
	Flags: Linked, Private
*/
function private function_188e5077(angles)
{
	self thread animation::play("ai_t8_zm_mannequin_ally_stn_exposed_revive", self, angles, 1);
}

/*
	Name: function_65ed0370
	Namespace: namespace_ca8676a3
	Checksum: 0x7ADC5E21
	Offset: 0x2E0
	Size: 0x84
	Parameters: 2
	Flags: Linked
*/
function function_65ed0370(origin, angles)
{
	self endon(#"death");
	self forceteleport(origin, angles);
	self orientmode("face default");
	self animation::play("ai_t8_zm_mannequin_ally_intro");
}

/*
	Name: function_f1be5640
	Namespace: namespace_ca8676a3
	Checksum: 0x36DC1B6A
	Offset: 0x370
	Size: 0x1C6
	Parameters: 12
	Flags: Linked
*/
function function_f1be5640(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	n_base_damage = self.maxhealth;
	if(isdefined(meansofdeath) && meansofdeath != "MOD_MELEE")
	{
		n_base_damage = n_base_damage / 4;
	}
	var_7e0e6341 = self ai::function_9139c839();
	if(isdefined(var_7e0e6341))
	{
		var_b1c1c5cf = var_7e0e6341.damagescale;
		if(var_b1c1c5cf > 0 && var_b1c1c5cf < 1)
		{
			var_64cc5e50 = 1 / var_b1c1c5cf;
			n_base_damage = n_base_damage * var_64cc5e50;
		}
	}
	if(isdefined(self.var_6f84b820))
	{
		switch(self.var_6f84b820)
		{
			case "heavy":
			{
				n_base_damage = n_base_damage * 0.2;
				break;
			}
			case "miniboss":
			{
				n_base_damage = n_base_damage * 0.1;
				break;
			}
			case "boss":
			{
				n_base_damage = n_base_damage * 0.05;
				break;
			}
			default:
			{
				break;
			}
		}
	}
	return n_base_damage;
}

/*
	Name: function_80bc397d
	Namespace: namespace_ca8676a3
	Checksum: 0x5D9FD1D6
	Offset: 0x540
	Size: 0x9C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_80bc397d()
{
	var_8f538918 = getaiarchetypearray(#"zod_companion");
	if(var_8f538918.size == 0 && (level.players.size == 1 || (isdefined(self.var_20f86af4) && self.var_20f86af4)))
	{
		self thread zm_laststand::wait_and_revive();
	}
	else
	{
		self thread zm_laststand::function_3699b145();
	}
}

