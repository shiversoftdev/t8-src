// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_256b8879317373de;
#using script_2dc48f46bfeac894;
#using script_56ca01b3b31455b5;
#using script_57f7003580bb15e0;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace gadget_health_regen;

/*
	Name: function_89f2df9
	Namespace: gadget_health_regen
	Checksum: 0x5AC9CAC
	Offset: 0x120
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"gadget_health_regen", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: gadget_health_regen
	Checksum: 0x22657A4A
	Offset: 0x168
	Size: 0x194
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	ability_player::register_gadget_activation_callbacks(23, &gadget_health_regen_on, &gadget_health_regen_off);
	ability_player::register_gadget_possession_callbacks(23, &gadget_health_regen_on_give, &gadget_health_regen_on_take);
	clientfield::register("toplayer", "healthregen", 1, 1, "int");
	clientfield::register("clientuimodel", "hudItems.healingActive", 1, 1, "int");
	clientfield::register("clientuimodel", "hudItems.numHealthPickups", 1, 2, "int");
	callback::on_spawned(&on_player_spawned);
	callback::on_player_damage(&on_player_damage);
	callback::add_callback(#"hash_4acc79bbf6402a39", &function_d3805306);
	callback::add_callback(#"hash_24e698e565a21a44", &function_f52ee680);
}

/*
	Name: function_d3805306
	Namespace: gadget_health_regen
	Checksum: 0x9F13064B
	Offset: 0x308
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_d3805306(var_756fda07)
{
	if(isdefined(var_756fda07.var_29f71617) && var_756fda07.var_29f71617)
	{
		self function_aba28004();
	}
}

/*
	Name: function_f52ee680
	Namespace: gadget_health_regen
	Checksum: 0x93021940
	Offset: 0x358
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_f52ee680()
{
	self function_aba28004();
}

/*
	Name: gadget_health_regen_on_give
	Namespace: gadget_health_regen
	Checksum: 0xE3E84814
	Offset: 0x380
	Size: 0x8C
	Parameters: 2
	Flags: Linked
*/
function gadget_health_regen_on_give(slot, weapon)
{
	self.gadget_health_regen_slot = slot;
	self.gadget_health_regen_weapon = weapon;
	weapon.ignore_grenade = 1;
	if(isdefined(weapon) && weapon.var_44377ea6)
	{
		self player::function_9080887a(weapon.var_44377ea6);
	}
	else
	{
		self player::function_9080887a();
	}
}

/*
	Name: gadget_health_regen_on_take
	Namespace: gadget_health_regen
	Checksum: 0x9B9FD1DD
	Offset: 0x418
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function gadget_health_regen_on_take(slot, weapon)
{
	self.gadget_health_regen_slot = undefined;
	self player::function_9080887a();
}

/*
	Name: on_player_spawned
	Namespace: gadget_health_regen
	Checksum: 0x7E56149A
	Offset: 0x458
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	self function_d91a057d();
}

/*
	Name: function_ddfdddb1
	Namespace: gadget_health_regen
	Checksum: 0xD2FFD10C
	Offset: 0x480
	Size: 0x78
	Parameters: 0
	Flags: Linked
*/
function function_ddfdddb1()
{
	if(sessionmodeismultiplayergame() || function_f99d2668())
	{
		self clientfield::set_to_player("healthregen", 1);
	}
	if(isdefined(level.var_5568effe))
	{
		[[level.var_5568effe]](self);
	}
}

/*
	Name: function_1e02d458
	Namespace: gadget_health_regen
	Checksum: 0xF3CF12BD
	Offset: 0x500
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_1e02d458()
{
	self clientfield::set_player_uimodel("hudItems.healingActive", 1);
}

/*
	Name: function_7993d50e
	Namespace: gadget_health_regen
	Checksum: 0x5B320B25
	Offset: 0x530
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function function_7993d50e()
{
	if(!isdefined(self) || !isdefined(self.heal))
	{
		return;
	}
	self.heal.var_a1cac2f1 = 0;
	self.heal.enabled = 0;
	self.heal.var_bc840360 = 0;
	self notify(#"healing_disabled");
	self player::function_9080887a();
	self clientfield::set_player_uimodel("hudItems.healingActive", 0);
	if(sessionmodeismultiplayergame() || function_f99d2668())
	{
		self clientfield::set_to_player("healthregen", 0);
	}
}

/*
	Name: function_34daf34a
	Namespace: gadget_health_regen
	Checksum: 0xD527478F
	Offset: 0x620
	Size: 0xD4
	Parameters: 2
	Flags: Linked
*/
function function_34daf34a(slot, weapon)
{
	if(self function_cd5fec49())
	{
		return;
	}
	if(weapon === getweapon(#"hash_767346e10a003f67"))
	{
		self function_bc0ce7d5(slot, weapon);
	}
	else
	{
		self function_ddfdddb1();
		self thread enable_healing_after_wait(slot, weapon, getdvarfloat(#"hash_57be38bf0a00809d", 0), 0.5, self);
	}
}

/*
	Name: function_bc0ce7d5
	Namespace: gadget_health_regen
	Checksum: 0xE2771450
	Offset: 0x700
	Size: 0x158
	Parameters: 2
	Flags: Linked
*/
function function_bc0ce7d5(slot, weapon)
{
	var_1594ab5 = self function_941ed5d6();
	for(i = 0; i < 4; i++)
	{
		if(isalive(var_1594ab5[i]))
		{
			if(isdefined(var_1594ab5[i].laststand) && var_1594ab5[i].laststand)
			{
				if(isdefined(var_1594ab5[i].var_84c0402e))
				{
					var_1594ab5[i].bleedout_time = var_1594ab5[i].var_84c0402e;
				}
			}
			else
			{
				var_1594ab5[i] function_ddfdddb1();
				var_1594ab5[i] thread enable_healing_after_wait(slot, weapon, getdvarfloat(#"hash_57be38bf0a00809d", 0), 0.5, self);
			}
		}
	}
}

/*
	Name: function_941ed5d6
	Namespace: gadget_health_regen
	Checksum: 0x7267D3B2
	Offset: 0x860
	Size: 0x5A
	Parameters: 0
	Flags: Linked
*/
function function_941ed5d6()
{
	if(isdefined(self.team))
	{
		var_1594ab5 = getplayers(self.team, self.origin, 1500);
	}
	else
	{
		var_1594ab5 = array(self);
	}
	return var_1594ab5;
}

/*
	Name: gadget_health_regen_on
	Namespace: gadget_health_regen
	Checksum: 0xCC2A95E9
	Offset: 0x8C8
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function gadget_health_regen_on(slot, weapon)
{
	if(function_f99d2668())
	{
		self.var_eedfcc6e = gettime();
	}
	else
	{
		function_34daf34a(slot, weapon);
	}
}

/*
	Name: gadget_health_regen_off
	Namespace: gadget_health_regen
	Checksum: 0x7F2D88FA
	Offset: 0x920
	Size: 0x106
	Parameters: 2
	Flags: Linked
*/
function gadget_health_regen_off(slot, weapon)
{
	if(!function_f99d2668())
	{
	}
	else if(isdefined(self.var_eedfcc6e))
	{
		var_d9dbb072 = 0;
		var_406dcd04 = self function_c1b7eefa(weapon);
		if(var_406dcd04 > 0)
		{
			var_d9dbb072 = weapon.gadget_powermax / var_406dcd04;
		}
		if(int(var_d9dbb072 * 1000) + self.var_eedfcc6e <= gettime() + 100)
		{
			function_34daf34a(slot, weapon);
		}
		else
		{
			self gadgetpowerset(slot, weapon.gadget_powermax);
		}
		self.var_eedfcc6e = undefined;
	}
}

/*
	Name: enable_healing_after_wait
	Namespace: gadget_health_regen
	Checksum: 0x286200B4
	Offset: 0xA30
	Size: 0xEC
	Parameters: 5
	Flags: Linked
*/
function enable_healing_after_wait(slot, weapon, wait_time, var_5818bd22, player)
{
	self notify(#"healing_preamble");
	self.heal.var_a1cac2f1 = gettime() + var_5818bd22;
	waitresult = undefined;
	waitresult = self waittill_timeout(wait_time, #"death", #"disconnect", #"healing_disabled", #"healing_preamble");
	if(waitresult._notify != "timeout")
	{
		return;
	}
	self enable_healing(slot, weapon, player);
}

/*
	Name: enable_healing
	Namespace: gadget_health_regen
	Checksum: 0x59FCE749
	Offset: 0xB28
	Size: 0x41C
	Parameters: 3
	Flags: Linked
*/
function enable_healing(slot, weapon, player)
{
	if(self function_cd5fec49())
	{
		return;
	}
	self function_1e02d458();
	if(isdefined(weapon) && weapon.var_44377ea6)
	{
		self player::function_9080887a(weapon.var_44377ea6);
	}
	else
	{
		self player::function_9080887a();
	}
	var_bc840360 = self.health;
	if(isdefined(self.var_9cd2c51d))
	{
		if(!self.heal.enabled)
		{
			self.var_9cd2c51d.var_c54af9a9 = gettime();
			self.var_9cd2c51d.var_6e219f3c = self.health;
		}
	}
	if(self.heal.enabled)
	{
		var_bc840360 = (isdefined(self.heal.var_bc840360) ? self.heal.var_bc840360 : self.health);
	}
	if(weapon.heal)
	{
		max_health = self.maxhealth;
		if(weapon.var_44377ea6)
		{
			max_health = weapon.var_44377ea6;
		}
		self.heal.var_bc840360 = math::clamp(weapon.heal + var_bc840360, 0, max_health);
		if(self.heal.var_bc840360 == 0)
		{
			return;
		}
	}
	else
	{
		self.heal.var_bc840360 = 0;
	}
	if(weapon.var_4465ef1e > 0)
	{
		heal_ammount = weapon.heal;
		if(heal_ammount <= 0 && isdefined(self.var_66cb03ad))
		{
			heal_ammount = self.var_66cb03ad;
		}
		self.heal.rate = heal_ammount / float(weapon.var_4465ef1e) / 1000;
	}
	else
	{
		self.heal.rate = 0;
	}
	self function_820a63e9(slot, 1);
	if(isdefined(level.var_d3b4a4db) && self === player)
	{
		self [[level.var_d3b4a4db]]();
	}
	if(isdefined(self.var_121392a1))
	{
		foreach(se in self.var_121392a1)
		{
			params = se.var_4f6b79a4;
			if(params.var_abac379d === 1)
			{
				status_effect::function_408158ef(params.var_67e2281d, params.var_18d16a6b);
			}
		}
	}
	self.heal.enabled = 1;
	self callback::function_d8abfc3d(#"hash_25663702210244cc", &function_4e449209);
	if(isdefined(self.health) && isdefined(self.var_66cb03ad) && self.health >= self.var_66cb03ad)
	{
		self function_4e449209();
	}
}

/*
	Name: function_d91a057d
	Namespace: gadget_health_regen
	Checksum: 0xAE28CD3C
	Offset: 0xF50
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function function_d91a057d(slot = ability_util::gadget_slot_for_type(23))
{
	if(isdefined(slot))
	{
		self function_820a63e9(slot, 0);
	}
	if(is_healing())
	{
		self function_7993d50e();
	}
}

/*
	Name: is_healing
	Namespace: gadget_health_regen
	Checksum: 0x8CC2AD99
	Offset: 0xFD8
	Size: 0x42
	Parameters: 0
	Flags: Linked
*/
function is_healing()
{
	return isdefined(self) && isdefined(self.heal) && (isdefined(self.heal.enabled) && self.heal.enabled);
}

/*
	Name: function_4e449209
	Namespace: gadget_health_regen
	Checksum: 0xBA7028B6
	Offset: 0x1028
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function function_4e449209()
{
	self endon(#"disconnect");
	if(isdefined(self))
	{
		self.heal.var_a1cac2f1 = 0;
		if(isdefined(level.var_d9ae19f0))
		{
			level [[level.var_d9ae19f0]](self);
		}
		self callback::function_52ac9652(#"hash_25663702210244cc", &function_4e449209);
		if(self is_healing())
		{
			if(isdefined(level.var_da2d586a) && !isdefined(self.var_c443b227))
			{
				self [[level.var_da2d586a]]();
			}
		}
		self function_d91a057d();
	}
}

/*
	Name: on_player_damage
	Namespace: gadget_health_regen
	Checksum: 0x42D67DF3
	Offset: 0x1120
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function on_player_damage(params)
{
	if(!isdefined(self.gadget_health_regen_slot))
	{
		return;
	}
	if(!self is_healing())
	{
		return;
	}
	attacker = params.eattacker;
	if(self function_dafd9cd(attacker) == 0)
	{
		damage = params.idamage;
		self.heal.var_bc840360 = math::clamp(self.heal.var_bc840360 - damage, 0, self.heal.var_bc840360);
		return;
	}
	function_18e0320b();
}

/*
	Name: function_aba28004
	Namespace: gadget_health_regen
	Checksum: 0xDC70AB5A
	Offset: 0x1200
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_aba28004()
{
	if(!isplayer(self))
	{
		return;
	}
	self function_18e0320b();
}

/*
	Name: function_18e0320b
	Namespace: gadget_health_regen
	Checksum: 0x1DCCA095
	Offset: 0x1240
	Size: 0x34
	Parameters: 0
	Flags: Linked, Private
*/
private function function_18e0320b()
{
	if(self is_healing())
	{
		self function_d91a057d();
	}
}

/*
	Name: function_dafd9cd
	Namespace: gadget_health_regen
	Checksum: 0x7FBA8CE9
	Offset: 0x1280
	Size: 0x52
	Parameters: 1
	Flags: Linked, Private
*/
private function function_dafd9cd(attacker)
{
	if(gettime() < self.heal.var_a1cac2f1)
	{
		return 0;
	}
	if(isdefined(level.deathcircle) && level.deathcircle === attacker)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_831bf182
	Namespace: gadget_health_regen
	Checksum: 0xE580AAA2
	Offset: 0x12E0
	Size: 0x4A
	Parameters: 0
	Flags: Linked
*/
function function_831bf182()
{
	var_6b3b55da = isdefined(self.gadget_health_regen_slot);
	if(!var_6b3b55da || "ammo" == self.gadget_health_regen_weapon.var_11389297)
	{
		return 0;
	}
	return var_6b3b55da;
}

/*
	Name: power_off
	Namespace: gadget_health_regen
	Checksum: 0x2C6DC656
	Offset: 0x1338
	Size: 0x3C
	Parameters: 0
	Flags: None
*/
function power_off()
{
	if(self function_831bf182())
	{
		self gadgetpowerset(self.gadget_health_regen_slot, 0);
	}
}

/*
	Name: power_on
	Namespace: gadget_health_regen
	Checksum: 0xFCBBA9EC
	Offset: 0x1380
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function power_on()
{
	if(self function_831bf182())
	{
		self gadgetpowerset(self.gadget_health_regen_slot, self.gadget_health_regen_weapon.gadget_powermax);
	}
}

