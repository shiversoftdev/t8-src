// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_27c22e1d8df4d852;
#using script_3f9e0dc8454d98e1;
#using script_6021ce59143452c3;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_fcd611c3;

/*
	Name: function_89f2df9
	Namespace: namespace_fcd611c3
	Checksum: 0x1CDF0936
	Offset: 0xE0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_281322718ac3cd88", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_fcd611c3
	Checksum: 0xFEC345DA
	Offset: 0x128
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!namespace_f551babc::function_b47f6aba())
	{
		return;
	}
	namespace_f551babc::register_challenge(#"hash_64d77357e69aee75", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_fcd611c3
	Checksum: 0xBDA37AFA
	Offset: 0x190
	Size: 0x160
	Parameters: 5
	Flags: Linked, Private
*/
private function function_d1de6a85(var_c8a36f90, var_a9dd1993, var_2953986a, var_3790b4e4, var_edc5a14f)
{
	level.var_e91491fb = (isdefined(var_c8a36f90) ? var_c8a36f90 : "movement");
	callback::function_33f0ddd3(&function_33f0ddd3);
	level namespace_f551babc::function_25ee130(1);
	if(level.var_e91491fb === #"prone")
	{
		array::thread_all(getplayers(), &namespace_b22c99a5::function_9bf8e274);
	}
	foreach(player in getplayers())
	{
		player thread function_1633056a(var_a9dd1993, var_2953986a, var_3790b4e4, var_edc5a14f);
	}
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_fcd611c3
	Checksum: 0xC303EABA
	Offset: 0x2F8
	Size: 0x9E
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9e7b3f4d(round_reset)
{
	callback::function_824d206(&function_33f0ddd3);
	level namespace_f551babc::function_25ee130(0);
	if(level.var_e91491fb === #"prone")
	{
		array::thread_all(getplayers(), &namespace_b22c99a5::function_73ff0096);
	}
	level.var_e91491fb = undefined;
}

/*
	Name: is_active
	Namespace: namespace_fcd611c3
	Checksum: 0xDE89C2F9
	Offset: 0x3A0
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function is_active()
{
	s_challenge = namespace_f551babc::function_a36e8c38(#"hash_64d77357e69aee75");
	return isdefined(s_challenge);
}

/*
	Name: function_1633056a
	Namespace: namespace_fcd611c3
	Checksum: 0xE4C08CB1
	Offset: 0x3E0
	Size: 0x2BE
	Parameters: 4
	Flags: Linked, Private
*/
private function function_1633056a(var_a9dd1993, var_2953986a, var_3790b4e4, var_edc5a14f)
{
	self endon(#"disconnect");
	level endon(#"hash_7646638df88a3656");
	if(isdefined(var_a9dd1993))
	{
		var_3b058622 = getweapon(var_a9dd1993);
	}
	if(isdefined(var_2953986a))
	{
		var_4dcaabac = getweapon(var_2953986a);
	}
	if(isdefined(var_3790b4e4))
	{
		var_cdd02bb5 = getweapon(var_3790b4e4);
	}
	if(isdefined(var_edc5a14f))
	{
		var_df94cf3e = getweapon(var_edc5a14f);
	}
	wait(1);
	while(true)
	{
		if(self function_26f124d8() && var_407eb07)
		{
			var_9d590e70 = 1;
			if(isdefined(var_3b058622))
			{
				var_9d590e70 = 0;
				self function_936adaa1(var_3b058622);
			}
			if(isdefined(var_4dcaabac))
			{
				var_9d590e70 = 0;
				self function_936adaa1(var_4dcaabac);
			}
			if(isdefined(var_cdd02bb5))
			{
				var_9d590e70 = 0;
				self function_936adaa1(var_cdd02bb5);
			}
			if(isdefined(var_df94cf3e))
			{
				var_9d590e70 = 0;
				self function_936adaa1(var_df94cf3e);
			}
			if(var_9d590e70)
			{
				var_3940c585 = level.var_e91491fb !== #"prone";
				self namespace_b22c99a5::function_dc0859e(var_3940c585);
			}
			var_407eb07 = 0;
		}
		else if(!self function_26f124d8() && !var_407eb07)
		{
			while(!self function_a39f313c())
			{
				if(self isfiring() && !self ismeleeing())
				{
					break;
				}
				waitframe(1);
			}
			self namespace_b22c99a5::function_bf710271();
			var_407eb07 = 1;
		}
		waitframe(1);
	}
}

/*
	Name: function_936adaa1
	Namespace: namespace_fcd611c3
	Checksum: 0xB575DD11
	Offset: 0x6A8
	Size: 0x110
	Parameters: 1
	Flags: Linked
*/
function function_936adaa1(weapon)
{
	foreach(weapon_inventory in self getweaponslist(1))
	{
		w_root = zm_weapons::function_386dacbc(weapon_inventory);
		if(weapon === w_root)
		{
			self unlockweapon(weapon_inventory);
			if(weapon_inventory.dualwieldweapon != level.weaponnone)
			{
				self unlockweapon(weapon_inventory.dualwieldweapon);
			}
			self namespace_b22c99a5::function_7dbb1712(1);
		}
	}
}

/*
	Name: function_26f124d8
	Namespace: namespace_fcd611c3
	Checksum: 0x5037B6F2
	Offset: 0x7C0
	Size: 0x20C
	Parameters: 0
	Flags: Linked
*/
function function_26f124d8()
{
	if(!isdefined(level.var_e91491fb))
	{
		return 1;
	}
	switch(level.var_e91491fb)
	{
		case "ads":
		{
			var_389b3ef1 = self playerads();
			if(self adsbuttonpressed() && var_389b3ef1 > 0)
			{
				return 1;
			}
			return 0;
		}
		case "jump":
		{
			if(self zm_utility::is_jumping())
			{
				return 1;
			}
			return 0;
		}
		case "slide":
		{
			if(self issliding())
			{
				return 1;
			}
			return 0;
		}
		case "hash_6c6c8f6b349b8751":
		{
			if(self zm_utility::is_jumping() || self issliding())
			{
				return 1;
			}
			return 0;
		}
		case "crouch":
		{
			if(self getstance() === "crouch")
			{
				return 1;
			}
			return 0;
		}
		case "prone":
		{
			if(self getstance() === "prone")
			{
				return 1;
			}
			return 0;
		}
		case "movement":
		default:
		{
			v_velocity = self getvelocity();
			if(length(v_velocity) != 0)
			{
				return 1;
			}
			return 0;
		}
	}
	return 0;
}

/*
	Name: function_33f0ddd3
	Namespace: namespace_fcd611c3
	Checksum: 0x47B89E77
	Offset: 0x9D8
	Size: 0x12C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_33f0ddd3(s_event)
{
	if(s_event.event === "give_weapon")
	{
		if(!self function_26f124d8() && !namespace_2ba51478::function_2ff6913(s_event.weapon))
		{
			self function_28602a03(s_event.weapon, 1, 1);
			if(s_event.weapon.dualwieldweapon != level.weaponnone)
			{
				self function_28602a03(s_event.weapon.dualwieldweapon, 1, 1);
			}
			if(s_event.weapon.altweapon != level.weaponnone)
			{
				self function_28602a03(s_event.weapon.altweapon, 1, 1);
			}
		}
	}
}

