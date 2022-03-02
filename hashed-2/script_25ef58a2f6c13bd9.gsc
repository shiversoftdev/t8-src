// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_24c32478acf44108;
#using script_5660bae5b402a1eb;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_attachments;

/*
	Name: function_89f2df9
	Namespace: zm_attachments
	Checksum: 0xF9C9D52
	Offset: 0xC0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"zm_attachments", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_attachments
	Checksum: 0x2A0DF459
	Offset: 0x108
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_9ff9f642::function_9d45c058(#"hash_72a155025f3da562", 100, 3);
	namespace_9ff9f642::register_slowdown(#"hash_1c9af7bb427952d", 0.85, 1);
	namespace_9ff9f642::register_slowdown(#"hash_1d07249a2211a81d", 0.9, 1);
	namespace_9ff9f642::register_slowdown(#"hash_721bfbe781c0d680", 0.95, 1);
}

/*
	Name: actor_damage_override
	Namespace: zm_attachments
	Checksum: 0x6E973E11
	Offset: 0x1D0
	Size: 0x1A6
	Parameters: 12
	Flags: Linked
*/
function actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(isplayer(attacker) && isdefined(weapon) && meansofdeath !== "MOD_UNKNOWN")
	{
		if(weaponhasattachment(weapon, "uber"))
		{
			switch(weapon.rootweapon.name)
			{
				case "hash_1fc7843987e89a83":
				case "lmg_standard_t8":
				{
					self function_9f8d8c38();
					break;
				}
				case "hash_459f15018585edda":
				case "shotgun_pump_t8":
				{
					if(meansofdeath !== "MOD_BURNED")
					{
						damage = self dragons_breath(attacker, damage, weapon);
					}
					break;
				}
				case "shotgun_semiauto_t8":
				case "hash_713d1e36bd254b65":
				{
					self function_82bca1c7(attacker);
					break;
				}
			}
		}
	}
	return damage;
}

/*
	Name: function_9f8d8c38
	Namespace: zm_attachments
	Checksum: 0x286B9764
	Offset: 0x380
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function function_9f8d8c38()
{
	if(isdefined(self.var_6f84b820))
	{
		switch(self.var_6f84b820)
		{
			case "popcorn":
			case "basic":
			case "enhanced":
			{
				var_3e5502b5 = #"hash_1c9af7bb427952d";
				break;
			}
			case "heavy":
			{
				var_3e5502b5 = #"hash_1d07249a2211a81d";
				break;
			}
			case "miniboss":
			{
				var_3e5502b5 = #"hash_721bfbe781c0d680";
				break;
			}
		}
		if(isdefined(var_3e5502b5))
		{
			self thread namespace_9ff9f642::slowdown(var_3e5502b5);
		}
	}
}

/*
	Name: dragons_breath
	Namespace: zm_attachments
	Checksum: 0x3142BD5
	Offset: 0x470
	Size: 0x1CC
	Parameters: 3
	Flags: Linked
*/
function dragons_breath(e_attacker, n_damage, weapon)
{
	if(!isdefined(self.var_f6291271))
	{
		self.var_f6291271 = [];
	}
	else if(!isarray(self.var_f6291271))
	{
		self.var_f6291271 = array(self.var_f6291271);
	}
	if(isinarray(self.var_f6291271, e_attacker))
	{
		if(self.archetype === #"zombie" && n_damage > self.health)
		{
			self.var_b364c165 = 1;
		}
		return n_damage;
	}
	if(!isdefined(self.var_f6291271))
	{
		self.var_f6291271 = [];
	}
	else if(!isarray(self.var_f6291271))
	{
		self.var_f6291271 = array(self.var_f6291271);
	}
	self.var_f6291271[self.var_f6291271.size] = e_attacker;
	self thread function_ddda26e(e_attacker);
	if(self.archetype === #"zombie")
	{
		n_damage = n_damage + 100;
		if(n_damage < self.health)
		{
			self namespace_9ff9f642::burn(#"hash_72a155025f3da562", e_attacker, weapon);
		}
		else
		{
			self.var_b364c165 = 1;
		}
	}
	else
	{
		n_damage = n_damage + 200;
	}
	return n_damage;
}

/*
	Name: function_ddda26e
	Namespace: zm_attachments
	Checksum: 0x25D04C42
	Offset: 0x648
	Size: 0x44
	Parameters: 1
	Flags: Linked, Private
*/
function private function_ddda26e(e_attacker)
{
	self endon(#"death");
	waitframe(5);
	arrayremovevalue(self.var_f6291271, e_attacker);
}

/*
	Name: function_82bca1c7
	Namespace: zm_attachments
	Checksum: 0x4C2BC472
	Offset: 0x698
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_82bca1c7(e_attacker)
{
	if(e_attacker playerads() == 1)
	{
		if(self.var_6f84b820 === #"basic" || self.var_6f84b820 === #"enhanced" && math::cointoss(10) && distancesquared(self.origin, e_attacker.origin) < 40000)
		{
			self ai::stun(2);
		}
	}
}

