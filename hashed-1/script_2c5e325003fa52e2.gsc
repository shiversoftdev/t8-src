// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_652cf01d4f20aeb5;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm\zm_orange_util.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_f93d2fa1;

/*
	Name: init
	Namespace: namespace_f93d2fa1
	Checksum: 0xB8D5EAF6
	Offset: 0x108
	Size: 0x184
	Parameters: 0
	Flags: None
*/
function init()
{
	var_a017eb40 = struct::get_array("snowball_pile");
	foreach(var_b85ff151 in var_a017eb40)
	{
		if(isdefined(var_b85ff151.model))
		{
			var_b85ff151.e_model = util::spawn_model(var_b85ff151.model, var_b85ff151.origin, var_b85ff151.angles);
		}
		var_b85ff151 zm_unitrigger::create(&function_dd028fcb, 64);
		var_b85ff151.s_unitrigger.origin = var_b85ff151.s_unitrigger.origin + vectorscale((0, 0, 1), 32);
		var_b85ff151 thread function_608b90b4();
		var_b85ff151.var_1c1b4398 = 0;
	}
	if(zm_utility::function_3bff983f())
	{
		callback::on_spawned(&function_e1b7c710);
	}
}

/*
	Name: function_dd028fcb
	Namespace: namespace_f93d2fa1
	Checksum: 0x9E251094
	Offset: 0x298
	Size: 0xB0
	Parameters: 1
	Flags: Private
*/
private function function_dd028fcb(e_player)
{
	var_d49d10b0 = e_player namespace_2ba51478::get_player_lethal_grenade();
	if(var_d49d10b0 === level.weaponnone)
	{
		return 0;
	}
	if(level flag::get(#"hash_5e095d53ae9513f5"))
	{
		self sethintstring(#"hash_7a1ce549121dd33f");
		return 1;
	}
	self sethintstring(#"hash_16b4b2b59405ab16");
	return 1;
}

/*
	Name: function_608b90b4
	Namespace: namespace_f93d2fa1
	Checksum: 0xF130CDC1
	Offset: 0x358
	Size: 0xC6
	Parameters: 0
	Flags: Private
*/
private function function_608b90b4()
{
	self endon(#"end_game");
	while(true)
	{
		var_385703b7 = undefined;
		var_385703b7 = self waittill(#"trigger_activated");
		e_player = var_385703b7.e_who;
		e_player function_79ef6b93();
		if(!isdefined(e_player.var_61fca2c3) || e_player.var_61fca2c3 == 0)
		{
			e_player thread namespace_3263198e::function_51b752a9("vox_snowball_pickup");
			e_player.var_61fca2c3 = 1;
		}
	}
}

/*
	Name: function_79ef6b93
	Namespace: namespace_f93d2fa1
	Checksum: 0xED3A49B0
	Offset: 0x428
	Size: 0x3FC
	Parameters: 0
	Flags: None
*/
function function_79ef6b93()
{
	var_d49d10b0 = self namespace_2ba51478::get_player_lethal_grenade();
	self playsound("fly_pickup_snowball");
	if(isdefined(self.var_3b55baa1) && (var_d49d10b0 == level.var_ad5d43cf || var_d49d10b0 == level.var_f8934665 || var_d49d10b0 == level.var_bf70d56c || var_d49d10b0 == level.var_d879215))
	{
		if(level flag::get(#"hash_5e095d53ae9513f5"))
		{
			if(var_d49d10b0 == level.var_ad5d43cf || var_d49d10b0 == level.var_f8934665)
			{
				if(level flag::get(#"extra_snowballs"))
				{
					self zm_weapons::weapon_give(level.var_d879215, 1, 0);
				}
				else
				{
					self zm_weapons::weapon_give(level.var_bf70d56c, 1, 0);
				}
			}
			else if(level flag::get(#"extra_snowballs") && var_d49d10b0 == level.var_bf70d56c)
			{
				self zm_weapons::weapon_give(level.var_d879215, 1, 0);
			}
		}
		else if(level flag::get(#"extra_snowballs") && var_d49d10b0 == level.var_ad5d43cf)
		{
			self zm_weapons::weapon_give(level.var_f8934665, 1, 0);
		}
		var_bcd1c2ff = self gadgetgetslot(var_d49d10b0);
		self gadgetpowerreset(var_bcd1c2ff, 0);
		self thread function_76e94d52();
	}
	else
	{
		self.var_3b55baa1 = var_d49d10b0;
		var_bcd1c2ff = self gadgetgetslot(var_d49d10b0);
		self.var_e01bb56 = self gadgetpowerget(var_bcd1c2ff);
		if(level flag::get(#"hash_5e095d53ae9513f5"))
		{
			if(level flag::get(#"extra_snowballs"))
			{
				self zm_weapons::weapon_give(level.var_d879215, 1, 0);
			}
			else
			{
				self zm_weapons::weapon_give(level.var_bf70d56c, 1, 0);
			}
		}
		else if(level flag::get(#"extra_snowballs"))
		{
			self zm_weapons::weapon_give(level.var_f8934665, 1, 0);
		}
		else
		{
			self zm_weapons::weapon_give(level.var_ad5d43cf, 1, 0);
		}
		self thread function_76e94d52();
		self callback::on_laststand(&function_3bb2f43b);
	}
}

/*
	Name: function_3bb2f43b
	Namespace: namespace_f93d2fa1
	Checksum: 0x39A047EC
	Offset: 0x830
	Size: 0xFC
	Parameters: 0
	Flags: None
*/
function function_3bb2f43b()
{
	if(isdefined(self.var_3b55baa1) && isdefined(self.var_e01bb56) && self function_75a76099())
	{
		self namespace_2ba51478::set_player_lethal_grenade(self.var_3b55baa1);
		self zm_weapons::weapon_give(self.var_3b55baa1, 1, 0);
		var_bcd1c2ff = self gadgetgetslot(self.var_3b55baa1);
		self gadgetpowerset(var_bcd1c2ff, self.var_e01bb56);
		self.var_3b55baa1 = undefined;
		self.var_e01bb56 = undefined;
		self notify(#"hash_2ef9a0f78a628812");
		self callback::function_53888e7f(&function_3bb2f43b);
	}
}

/*
	Name: function_76e94d52
	Namespace: namespace_f93d2fa1
	Checksum: 0xDA2E3AE7
	Offset: 0x938
	Size: 0x27C
	Parameters: 0
	Flags: None
*/
function function_76e94d52()
{
	self notify(#"hash_2ef9a0f78a628812");
	self endon(#"hash_2ef9a0f78a628812");
	self endon(#"death");
	level endon(#"end_game");
	while(true)
	{
		var_d49d10b0 = self namespace_2ba51478::get_player_lethal_grenade();
		if(self function_75a76099())
		{
			var_d8b1f3e3 = self getweaponammoclip(var_d49d10b0);
			if(self getweaponammoclip(var_d49d10b0) <= 0)
			{
				wait(1);
				if(isdefined(self.var_3b55baa1) && isdefined(self.var_e01bb56) && self function_75a76099())
				{
					self namespace_2ba51478::set_player_lethal_grenade(self.var_3b55baa1);
					self zm_weapons::weapon_give(self.var_3b55baa1, 1, 0);
					var_bcd1c2ff = self gadgetgetslot(self.var_3b55baa1);
					self gadgetpowerset(var_bcd1c2ff, self.var_e01bb56);
					self.var_3b55baa1 = undefined;
					self.var_e01bb56 = undefined;
					self function_820a63e9(var_bcd1c2ff, 1);
					wait(1);
					self function_820a63e9(var_bcd1c2ff, 0);
					self callback::function_53888e7f(&function_3bb2f43b);
					self notify(#"hash_2ef9a0f78a628812");
				}
			}
		}
		else if(self.var_3b55baa1 == getweapon(#"music_box"))
		{
			namespace_5449c7ba::function_96d95cf5();
		}
		self.var_3b55baa1 = undefined;
		self.var_e01bb56 = undefined;
		self notify(#"hash_2ef9a0f78a628812");
		wait(0.5);
	}
}

/*
	Name: function_75a76099
	Namespace: namespace_f93d2fa1
	Checksum: 0xD38C33D0
	Offset: 0xBC0
	Size: 0x88
	Parameters: 0
	Flags: None
*/
function function_75a76099()
{
	var_d49d10b0 = self namespace_2ba51478::get_player_lethal_grenade();
	if(isdefined(var_d49d10b0) && (var_d49d10b0 == level.var_ad5d43cf || var_d49d10b0 == level.var_f8934665 || var_d49d10b0 == level.var_bf70d56c || var_d49d10b0 == level.var_d879215))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_e1b7c710
	Namespace: namespace_f93d2fa1
	Checksum: 0x623232E5
	Offset: 0xC50
	Size: 0x12E
	Parameters: 0
	Flags: None
*/
function function_e1b7c710()
{
	self endon(#"death");
	level flag::wait_till_any(array("round_reset", #"hash_6acab8bde7078239"));
	if(isdefined(self.var_3b55baa1) && isdefined(self.var_e01bb56) && self function_75a76099())
	{
		self namespace_2ba51478::set_player_lethal_grenade(self.var_3b55baa1);
		self zm_weapons::weapon_give(self.var_3b55baa1, 1, 0);
		var_bcd1c2ff = self gadgetgetslot(self.var_3b55baa1);
		self gadgetpowerset(var_bcd1c2ff, self.var_e01bb56);
		self.var_3b55baa1 = undefined;
		self.var_e01bb56 = undefined;
		self notify(#"hash_2ef9a0f78a628812");
	}
}

