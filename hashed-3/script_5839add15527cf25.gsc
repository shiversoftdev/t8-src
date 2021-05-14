// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_27c22e1d8df4d852;
#using script_6021ce59143452c3;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_pack_a_punch_util.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_84030cfb;

/*
	Name: function_89f2df9
	Namespace: namespace_84030cfb
	Checksum: 0x270957B5
	Offset: 0x108
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_5c0d913682a01d67", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_84030cfb
	Checksum: 0x6236B414
	Offset: 0x150
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
	zm_trial::register_challenge(#"weapon_rotation", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_84030cfb
	Checksum: 0xF74C5B6F
	Offset: 0x1B8
	Size: 0x550
	Parameters: 2
	Flags: Linked, Private
*/
private function function_d1de6a85(var_44c4c23d, var_bd332e71)
{
	self.var_ea033f4a = [];
	n_interval = zm_trial::function_5769f26a(var_44c4c23d);
	self.var_bd332e71 = zm_trial::function_5769f26a(var_bd332e71);
	self.var_44c4c23d = n_interval;
	callback::on_spawned(&on_player_spawned);
	foreach(weapon in getarraykeys(level.zombie_weapons))
	{
		if(weapon != level.weaponnone && !weapon.isriotshield && !weapon.isgadget && weapon.weapclass != "melee" && !function_873de196(weapon))
		{
			if(!isdefined(self.var_ea033f4a))
			{
				self.var_ea033f4a = [];
			}
			else if(!isarray(self.var_ea033f4a))
			{
				self.var_ea033f4a = array(self.var_ea033f4a);
			}
			if(!isinarray(self.var_ea033f4a, weapon))
			{
				self.var_ea033f4a[self.var_ea033f4a.size] = weapon;
			}
		}
	}
	foreach(weapon in getarraykeys(level.zombie_weapons_upgraded))
	{
		if(weapon != level.weaponnone && !weapon.isriotshield && !function_873de196(weapon))
		{
			if(!isdefined(self.var_ea033f4a))
			{
				self.var_ea033f4a = [];
			}
			else if(!isarray(self.var_ea033f4a))
			{
				self.var_ea033f4a = array(self.var_ea033f4a);
			}
			if(!isinarray(self.var_ea033f4a, weapon))
			{
				self.var_ea033f4a[self.var_ea033f4a.size] = weapon;
			}
		}
	}
	foreach(weapon in getarraykeys(level.zombie_weapons_upgraded))
	{
		if(weapon != level.weaponnone && !weapon.isriotshield && math::cointoss() && !function_873de196(weapon))
		{
			if(!isdefined(self.var_ea033f4a))
			{
				self.var_ea033f4a = [];
			}
			else if(!isarray(self.var_ea033f4a))
			{
				self.var_ea033f4a = array(self.var_ea033f4a);
			}
			self.var_ea033f4a[self.var_ea033f4a.size] = weapon;
		}
	}
	level zm_trial::function_44200d07(1);
	self.var_f0966a0b = [];
	self.var_6b31b86f = [];
	self.var_45de08d7 = [];
	foreach(e_player in getplayers())
	{
		e_player namespace_b22c99a5::function_9bf8e274();
		self.var_f0966a0b[e_player.clientid] = [];
		self thread take_player_weapons(n_interval, e_player);
	}
}

/*
	Name: take_player_weapons
	Namespace: namespace_84030cfb
	Checksum: 0x8294003C
	Offset: 0x710
	Size: 0x32C
	Parameters: 2
	Flags: Linked
*/
function take_player_weapons(n_interval, e_player)
{
	e_player notify(#"hash_c1ae406f049058a");
	e_player endon(#"disconnect", #"hash_c1ae406f049058a");
	level endon(#"hash_7646638df88a3656");
	if(!e_player zm_laststand::laststand_has_players_weapons_returned())
	{
		e_player waittill(#"hash_9b426cce825928d");
	}
	if(isdefined(e_player.var_9b0383f5) && e_player.var_9b0383f5)
	{
		e_player waittill(#"hash_1ac4338b0d419091");
	}
	a_weap = e_player getweaponslistprimaries();
	foreach(weapon in a_weap)
	{
		if(!(isdefined(e_player.var_a14d2a24) && e_player.var_a14d2a24))
		{
			if(!isdefined(self.var_f0966a0b[e_player.clientid]))
			{
				self.var_f0966a0b[e_player.clientid] = [];
			}
			else if(!isarray(self.var_f0966a0b[e_player.clientid]))
			{
				self.var_f0966a0b[e_player.clientid] = array(self.var_f0966a0b[e_player.clientid]);
			}
			self.var_f0966a0b[e_player.clientid][self.var_f0966a0b[e_player.clientid].size] = weapon;
			if(isdefined(e_player aat::getaatonweapon(weapon)))
			{
				self.var_6b31b86f[string(e_player.clientid) + weapon.name] = e_player aat::getaatonweapon(weapon);
			}
			self.var_45de08d7[string(e_player.clientid) + weapon.name] = e_player zm_pap_util::function_83c29ddb(weapon);
		}
		e_player takeweapon(weapon);
	}
	e_player.var_a14d2a24 = 1;
	self thread function_413cffae(n_interval, e_player);
}

/*
	Name: function_873de196
	Namespace: namespace_84030cfb
	Checksum: 0x1F7DC90A
	Offset: 0xA48
	Size: 0x54
	Parameters: 1
	Flags: Linked, Private
*/
private function function_873de196(weapon)
{
	if(weapon.ischargeshot && (!isdefined(weapon.var_3d85028) || weapon.var_3d85028 == level.weaponnone))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_84030cfb
	Checksum: 0xE697005C
	Offset: 0xAA8
	Size: 0x102
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9e7b3f4d(round_reset)
{
	level zm_trial::function_44200d07(0);
	callback::remove_on_spawned(&on_player_spawned);
	foreach(e_player in level.players)
	{
		if(self.var_bd332e71)
		{
			e_player thread return_weapon(self);
		}
		else
		{
			e_player enableweaponcycling();
		}
		e_player namespace_b22c99a5::function_73ff0096();
		e_player.var_a14d2a24 = undefined;
	}
}

/*
	Name: on_player_spawned
	Namespace: namespace_84030cfb
	Checksum: 0x7296B751
	Offset: 0xBB8
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	s_trial = zm_trial::function_a36e8c38(#"weapon_rotation");
	if(isdefined(s_trial))
	{
		s_trial thread take_player_weapons(s_trial.var_44c4c23d, self);
	}
}

/*
	Name: return_weapon
	Namespace: namespace_84030cfb
	Checksum: 0xDA4EA140
	Offset: 0xC20
	Size: 0x24A
	Parameters: 1
	Flags: Linked, Private
*/
private function return_weapon(var_8ac27ae7)
{
	level endon(#"end_game");
	self endon(#"disconnect");
	self function_27cd9d6();
	self val::reset("weapon_rotation", "disable_weapons");
	self enableweaponcycling();
	if(isdefined(self.var_89d523af))
	{
		self takeweapon(self.var_89d523af);
	}
	foreach(weapon in var_8ac27ae7.var_f0966a0b[self.clientid])
	{
		self zm_weapons::weapon_give(weapon);
		if(isdefined(var_8ac27ae7.var_6b31b86f[string(self.clientid) + weapon.name]))
		{
			self aat::acquire(weapon, var_8ac27ae7.var_6b31b86f[string(self.clientid) + weapon.name].name);
		}
		if(var_8ac27ae7.var_45de08d7[string(self.clientid) + weapon.name] > 0)
		{
			self zm_pap_util::repack_weapon(weapon, var_8ac27ae7.var_45de08d7[string(self.clientid) + weapon.name]);
		}
	}
	self.var_89d523af = undefined;
}

/*
	Name: function_413cffae
	Namespace: namespace_84030cfb
	Checksum: 0xF4EE0C98
	Offset: 0xE78
	Size: 0x294
	Parameters: 2
	Flags: Linked, Private
*/
private function function_413cffae(n_interval, e_player)
{
	e_player notify(#"hash_14795fd12c6dae32");
	level endon(#"hash_7646638df88a3656");
	e_player endon(#"disconnect", #"hash_14795fd12c6dae32");
	while(true)
	{
		e_player function_27cd9d6(0.15);
		do
		{
			weapon = array::random(self.var_ea033f4a);
		}
		while(e_player hasweapon(weapon));
		e_player zm_weapons::weapon_give(weapon);
		e_player.var_89d523af = weapon;
		if(zm_weapons::is_weapon_upgraded(weapon))
		{
			if(math::cointoss())
			{
				if(zm_weapons::weapon_supports_aat(weapon))
				{
					e_player thread aat::acquire(weapon);
					e_player zm_pap_util::repack_weapon(weapon, function_21a3a673(1, 4));
				}
			}
		}
		e_player val::reset("weapon_rotation", "disable_weapons");
		wait(n_interval);
		e_player function_27cd9d6();
		e_player val::set("weapon_rotation", "disable_weapons", 1);
		e_player function_27cd9d6(0.15);
		a_weap = e_player getweaponslistprimaries();
		foreach(weapon in a_weap)
		{
			e_player takeweapon(weapon);
		}
	}
}

/*
	Name: function_579553d8
	Namespace: namespace_84030cfb
	Checksum: 0x45E69197
	Offset: 0x1118
	Size: 0xF2
	Parameters: 1
	Flags: None
*/
function function_579553d8(n_interval)
{
	/#
		self notify("");
		self endon("");
		level endon(#"hash_7646638df88a3656", #"end_game");
		while(true)
		{
			debug2dtext((8, 400, 0), "" + n_interval, undefined, undefined, undefined, 1);
			waitframe(1);
			n_interval = n_interval - float(function_60d95f53()) / 1000;
			n_interval = math::clamp(n_interval, 0, 999);
		}
	#/
}

/*
	Name: function_27cd9d6
	Namespace: namespace_84030cfb
	Checksum: 0x54556445
	Offset: 0x1218
	Size: 0x126
	Parameters: 1
	Flags: Linked
*/
function function_27cd9d6(var_41f1a085 = 0)
{
	self endon(#"disconnect", #"hash_14795fd12c6dae32");
	level endon(#"hash_7646638df88a3656");
	n_time = 0;
	while(!isalive(self) || self laststand::player_is_in_laststand() || self isusingoffhand() || self function_55acff10() || self zm_laststand::is_reviving_any() || n_time < var_41f1a085)
	{
		waitframe(1);
		n_time = n_time + float(function_60d95f53()) / 1000;
	}
}

