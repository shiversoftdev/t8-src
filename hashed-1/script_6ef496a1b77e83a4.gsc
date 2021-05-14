// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_256b8879317373de;
#using script_27c22e1d8df4d852;
#using script_6021ce59143452c3;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\weapons_shared.gsc;
#using scripts\zm_common\zm_perks.gsc;

#namespace namespace_5f71460c;

/*
	Name: function_89f2df9
	Namespace: namespace_5f71460c
	Checksum: 0xA1E45001
	Offset: 0xB8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_6e3eb3affb730b9a", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_5f71460c
	Checksum: 0x24906419
	Offset: 0x100
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	zm_trial::register_challenge(#"hash_376aa98c6fac7859", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_5f71460c
	Checksum: 0xD0582FB9
	Offset: 0x168
	Size: 0x154
	Parameters: 0
	Flags: Linked, Private
*/
private function function_d1de6a85()
{
	level zm_trial::function_2b3a3307(1);
	/#
		assert(isdefined(level.var_b8be892e));
	#/
	foreach(player in getplayers())
	{
		player function_f0b698a7();
		if(!isdefined(player.var_7864a0f6))
		{
			player.var_7864a0f6 = player namespace_b22c99a5::function_3f8a4145(0);
			player function_85611c27();
		}
	}
	callback::on_revived(&function_776fbeaf);
	callback::on_laststand(&function_551412f6);
	namespace_b22c99a5::function_8036c103();
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_5f71460c
	Checksum: 0x651E1DE7
	Offset: 0x2C8
	Size: 0x14C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9e7b3f4d(round_reset)
{
	level zm_trial::function_2b3a3307(0);
	if(!round_reset)
	{
		foreach(player in getplayers())
		{
			/#
				assert(isdefined(player.var_7864a0f6));
			#/
			player namespace_b22c99a5::function_d37a769(player.var_7864a0f6);
			player function_2c0ae6d1();
			player.var_7864a0f6 = undefined;
		}
	}
	callback::function_61f038c(&function_776fbeaf);
	callback::function_53888e7f(&function_551412f6);
	namespace_b22c99a5::function_302c6014();
}

/*
	Name: is_active
	Namespace: namespace_5f71460c
	Checksum: 0x5B76304D
	Offset: 0x420
	Size: 0x7A
	Parameters: 1
	Flags: Linked
*/
function is_active(var_34f09024 = 0)
{
	if(var_34f09024 && zm_trial::function_48736df9(#"hash_376aa98c6fac7859"))
	{
		return 1;
	}
	challenge = zm_trial::function_a36e8c38(#"hash_376aa98c6fac7859");
	return isdefined(challenge);
}

/*
	Name: lose_perk
	Namespace: namespace_5f71460c
	Checksum: 0xBE2C7CD1
	Offset: 0x4A8
	Size: 0x1A2
	Parameters: 1
	Flags: Linked
*/
function lose_perk(perk)
{
	if(!is_active())
	{
		return 0;
	}
	slot = self zm_perks::function_c1efcc57(perk);
	if(slot != -1 && isdefined(self.var_7864a0f6) && (isdefined(self.var_7864a0f6.var_149ec45c[slot]) && self.var_7864a0f6.var_149ec45c[slot]) && !self zm_perks::function_e56d8ef4(perk))
	{
		arrayremovevalue(self.var_cd5d9345, perk, 0);
		self.var_7864a0f6.var_149ec45c[slot] = 0;
		if(!isdefined(self.var_7864a0f6.var_6fdc9c9c))
		{
			self.var_7864a0f6.var_6fdc9c9c = [];
		}
		else if(!isarray(self.var_7864a0f6.var_6fdc9c9c))
		{
			self.var_7864a0f6.var_6fdc9c9c = array(self.var_7864a0f6.var_6fdc9c9c);
		}
		self.var_7864a0f6.var_6fdc9c9c[self.var_7864a0f6.var_6fdc9c9c.size] = slot;
		return 1;
	}
	return 0;
}

/*
	Name: function_776fbeaf
	Namespace: namespace_5f71460c
	Checksum: 0xFEA16EA2
	Offset: 0x658
	Size: 0x112
	Parameters: 1
	Flags: Linked
*/
function function_776fbeaf(s_params)
{
	if(isdefined(self.var_fbc66a96) && self.var_fbc66a96 && isdefined(self.var_7864a0f6) && isarray(self.var_7864a0f6.var_149ec45c) && isarray(self.var_7864a0f6.var_6fdc9c9c))
	{
		foreach(var_224c0c9c in self.var_7864a0f6.var_6fdc9c9c)
		{
			self.var_7864a0f6.var_149ec45c[var_224c0c9c] = 1;
		}
		self.var_7864a0f6.var_6fdc9c9c = undefined;
	}
}

/*
	Name: function_551412f6
	Namespace: namespace_5f71460c
	Checksum: 0x47BD913
	Offset: 0x778
	Size: 0x3E
	Parameters: 0
	Flags: Linked
*/
function function_551412f6()
{
	if(isdefined(self.var_7864a0f6))
	{
		self.var_7864a0f6.var_724d826b = undefined;
		self.var_7864a0f6.var_8dee79a9 = undefined;
		self.var_7864a0f6.var_d3f0257d = undefined;
	}
}

/*
	Name: function_f0b698a7
	Namespace: namespace_5f71460c
	Checksum: 0xD0AE527A
	Offset: 0x7C0
	Size: 0x3A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_f0b698a7()
{
	self player::generate_weapon_data();
	self.var_4a17c2cb = self._generated_weapons;
	self._generated_current_weapon = undefined;
	self._generated_weapons = undefined;
}

/*
	Name: function_85611c27
	Namespace: namespace_5f71460c
	Checksum: 0x99E3999D
	Offset: 0x808
	Size: 0xC4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_85611c27()
{
	if(isdefined(self.var_7864a0f6.additional_primary_weapon))
	{
		foreach(weapondata in self.var_4a17c2cb)
		{
			weapon = weapondata[#"weapon"];
			if(weapon === self.var_7864a0f6.additional_primary_weapon)
			{
				self.var_7864a0f6.var_dd9bd473 = weapondata;
				return;
			}
		}
	}
}

/*
	Name: function_2c0ae6d1
	Namespace: namespace_5f71460c
	Checksum: 0xD6AE20D7
	Offset: 0x8D8
	Size: 0x15E
	Parameters: 0
	Flags: Linked, Private
*/
private function function_2c0ae6d1()
{
	/#
		assert(isdefined(self.var_4a17c2cb));
	#/
	var_4493e3e1 = isarray(self.var_7864a0f6.var_724d826b) && isinarray(self.var_7864a0f6.var_724d826b, #"specialty_additionalprimaryweapon");
	if(var_4493e3e1 || isinarray(self.var_466b927f, #"specialty_additionalprimaryweapon") && isdefined(self.var_7864a0f6.additional_primary_weapon) && isdefined(self.var_7864a0f6.var_dd9bd473) && !self hasweapon(self.var_7864a0f6.additional_primary_weapon))
	{
		self player::weapondata_give(self.var_7864a0f6.var_dd9bd473);
		self namespace_b22c99a5::function_7f999aa0(self.var_7864a0f6);
	}
	self.var_4a17c2cb = undefined;
}

