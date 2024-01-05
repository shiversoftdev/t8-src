// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_652cf01d4f20aeb5;
#using scripts\core_common\flag_shared.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\zm\zm_orange_util.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace zm_orange_snowball_piles;

/*
	Name: init
	Namespace: zm_orange_snowball_piles
	Checksum: 0xB8D5EAF6
	Offset: 0x108
	Size: 0x184
	Parameters: 0
	Flags: None
*/
function init()
{
	a_s_snowball_piles = struct::get_array("snowball_pile");
	foreach(s_snowball_pile in a_s_snowball_piles)
	{
		if(isdefined(s_snowball_pile.model))
		{
			s_snowball_pile.e_model = util::spawn_model(s_snowball_pile.model, s_snowball_pile.origin, s_snowball_pile.angles);
		}
		s_snowball_pile zm_unitrigger::create(&function_dd028fcb, 64);
		s_snowball_pile.s_unitrigger.origin = s_snowball_pile.s_unitrigger.origin + vectorscale((0, 0, 1), 32);
		s_snowball_pile thread function_608b90b4();
		s_snowball_pile.var_1c1b4398 = 0;
	}
	if(zm_utility::is_trials())
	{
		callback::on_spawned(&function_e1b7c710);
	}
}

/*
	Name: function_dd028fcb
	Namespace: zm_orange_snowball_piles
	Checksum: 0x9E251094
	Offset: 0x298
	Size: 0xB0
	Parameters: 1
	Flags: Private
*/
function private function_dd028fcb(e_player)
{
	var_d49d10b0 = e_player zm_loadout::get_player_lethal_grenade();
	if(var_d49d10b0 === level.weaponnone)
	{
		return false;
	}
	if(level flag::get(#"hash_5e095d53ae9513f5"))
	{
		self sethintstring(#"hash_7a1ce549121dd33f");
		return true;
	}
	self sethintstring(#"hash_16b4b2b59405ab16");
	return true;
}

/*
	Name: function_608b90b4
	Namespace: zm_orange_snowball_piles
	Checksum: 0xF130CDC1
	Offset: 0x358
	Size: 0xC6
	Parameters: 0
	Flags: Private
*/
function private function_608b90b4()
{
	self endon(#"end_game");
	while(true)
	{
		s_notify = undefined;
		s_notify = self waittill(#"trigger_activated");
		e_player = s_notify.e_who;
		e_player function_79ef6b93();
		if(!isdefined(e_player.var_61fca2c3) || e_player.var_61fca2c3 == 0)
		{
			e_player thread zm_orange_util::function_51b752a9("vox_snowball_pickup");
			e_player.var_61fca2c3 = 1;
		}
	}
}

/*
	Name: function_79ef6b93
	Namespace: zm_orange_snowball_piles
	Checksum: 0xED3A49B0
	Offset: 0x428
	Size: 0x3FC
	Parameters: 0
	Flags: None
*/
function function_79ef6b93()
{
	var_d49d10b0 = self zm_loadout::get_player_lethal_grenade();
	self playsound("fly_pickup_snowball");
	if(isdefined(self.var_3b55baa1) && (var_d49d10b0 == level.w_snowball || var_d49d10b0 == level.var_f8934665 || var_d49d10b0 == level.var_bf70d56c || var_d49d10b0 == level.var_d879215))
	{
		if(level flag::get(#"hash_5e095d53ae9513f5"))
		{
			if(var_d49d10b0 == level.w_snowball || var_d49d10b0 == level.var_f8934665)
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
		else if(level flag::get(#"extra_snowballs") && var_d49d10b0 == level.w_snowball)
		{
			self zm_weapons::weapon_give(level.var_f8934665, 1, 0);
		}
		n_slot = self gadgetgetslot(var_d49d10b0);
		self gadgetpowerreset(n_slot, 0);
		self thread function_76e94d52();
	}
	else
	{
		self.var_3b55baa1 = var_d49d10b0;
		n_slot = self gadgetgetslot(var_d49d10b0);
		self.var_e01bb56 = self gadgetpowerget(n_slot);
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
		else
		{
			if(level flag::get(#"extra_snowballs"))
			{
				self zm_weapons::weapon_give(level.var_f8934665, 1, 0);
			}
			else
			{
				self zm_weapons::weapon_give(level.w_snowball, 1, 0);
			}
		}
		self thread function_76e94d52();
		self callback::on_laststand(&function_3bb2f43b);
	}
}

/*
	Name: function_3bb2f43b
	Namespace: zm_orange_snowball_piles
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
		self zm_loadout::set_player_lethal_grenade(self.var_3b55baa1);
		self zm_weapons::weapon_give(self.var_3b55baa1, 1, 0);
		n_slot = self gadgetgetslot(self.var_3b55baa1);
		self gadgetpowerset(n_slot, self.var_e01bb56);
		self.var_3b55baa1 = undefined;
		self.var_e01bb56 = undefined;
		self notify(#"grenade_change");
		self callback::remove_on_laststand(&function_3bb2f43b);
	}
}

/*
	Name: function_76e94d52
	Namespace: zm_orange_snowball_piles
	Checksum: 0xDA2E3AE7
	Offset: 0x938
	Size: 0x27C
	Parameters: 0
	Flags: None
*/
function function_76e94d52()
{
	self notify(#"grenade_change");
	self endon(#"grenade_change");
	self endon(#"death");
	level endon(#"end_game");
	while(true)
	{
		var_d49d10b0 = self zm_loadout::get_player_lethal_grenade();
		if(self function_75a76099())
		{
			var_d8b1f3e3 = self getweaponammoclip(var_d49d10b0);
			if(self getweaponammoclip(var_d49d10b0) <= 0)
			{
				wait(1);
				if(isdefined(self.var_3b55baa1) && isdefined(self.var_e01bb56) && self function_75a76099())
				{
					self zm_loadout::set_player_lethal_grenade(self.var_3b55baa1);
					self zm_weapons::weapon_give(self.var_3b55baa1, 1, 0);
					n_slot = self gadgetgetslot(self.var_3b55baa1);
					self gadgetpowerset(n_slot, self.var_e01bb56);
					self.var_3b55baa1 = undefined;
					self.var_e01bb56 = undefined;
					self function_820a63e9(n_slot, 1);
					wait(1);
					self function_820a63e9(n_slot, 0);
					self callback::remove_on_laststand(&function_3bb2f43b);
					self notify(#"grenade_change");
				}
			}
		}
		else
		{
			if(self.var_3b55baa1 == getweapon(#"music_box"))
			{
				namespace_5449c7ba::function_96d95cf5();
			}
			self.var_3b55baa1 = undefined;
			self.var_e01bb56 = undefined;
			self notify(#"grenade_change");
		}
		wait(0.5);
	}
}

/*
	Name: function_75a76099
	Namespace: zm_orange_snowball_piles
	Checksum: 0xD38C33D0
	Offset: 0xBC0
	Size: 0x88
	Parameters: 0
	Flags: None
*/
function function_75a76099()
{
	var_d49d10b0 = self zm_loadout::get_player_lethal_grenade();
	if(isdefined(var_d49d10b0) && (var_d49d10b0 == level.w_snowball || var_d49d10b0 == level.var_f8934665 || var_d49d10b0 == level.var_bf70d56c || var_d49d10b0 == level.var_d879215))
	{
		return true;
	}
	return false;
}

/*
	Name: function_e1b7c710
	Namespace: zm_orange_snowball_piles
	Checksum: 0x623232E5
	Offset: 0xC50
	Size: 0x12E
	Parameters: 0
	Flags: None
*/
function function_e1b7c710()
{
	self endon(#"death");
	level flag::wait_till_any(array("round_reset", #"trial_failed"));
	if(isdefined(self.var_3b55baa1) && isdefined(self.var_e01bb56) && self function_75a76099())
	{
		self zm_loadout::set_player_lethal_grenade(self.var_3b55baa1);
		self zm_weapons::weapon_give(self.var_3b55baa1, 1, 0);
		n_slot = self gadgetgetslot(self.var_3b55baa1);
		self gadgetpowerset(n_slot, self.var_e01bb56);
		self.var_3b55baa1 = undefined;
		self.var_e01bb56 = undefined;
		self notify(#"grenade_change");
	}
}

