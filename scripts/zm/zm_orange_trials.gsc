// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\trials\zm_trial_orange_open_all_doors.gsc;
#using scripts\zm\zm_orange_trial_lighthouse_beam.gsc;
#using script_3d07a022f5c96f45;
#using script_4f1abd7be75f8a2f;
#using script_4109fe9f86c53247;
#using scripts\zm\zm_orange_trial_shoot_from_water.gsc;
#using scripts\zm_common\trials\zm_trial_upgrade_multiple.gsc;
#using scripts\zm_common\trials\zm_trial_flag_check.gsc;
#using scripts\zm_common\trials\zm_trial_special_enemy.gsc;
#using scripts\zm_common\trials\zm_trial_safe_zone.gsc;
#using scripts\zm_common\trials\zm_trial_restrict_loadout.gsc;
#using script_ddbbb750404a64b;
#using scripts\zm_common\trials\zm_trial_magicbox_hunt.gsc;
#using script_67da0c3654a906b6;
#using scripts\zm_common\trials\zm_trial_disable_regen.gsc;
#using script_28bfe6df1650ab79;
#using scripts\zm_common\trials\zm_trial_defend_area.gsc;
#using scripts\zm_common\trials\zm_trial_acquire_weapon.gsc;
#using scripts\zm\zm_orange_snowball_piles.gsc;
#using scripts\zm\zm_orange_water.gsc;
#using scripts\zm\zm_orange_mq_hell.gsc;
#using scripts\zm\zm_orange_special_rounds.gsc;
#using scripts\zm_common\bgbs\zm_bgb_anywhere_but_here.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\zm_common\zm_bgb_pack.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\music_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\array_shared.gsc;

#namespace zm_orange_trials;

/*
	Name: preload
	Namespace: zm_orange_trials
	Checksum: 0xFEF028B3
	Offset: 0x248
	Size: 0xDE
	Parameters: 0
	Flags: None
*/
function preload()
{
	clientfield::register("scriptmover", "" + #"hash_71906a124221219", 24000, 1, "int");
	clientfield::register("scriptmover", "" + #"trials_lighthouse_beam", 24000, 1, "int");
	level flag::init(#"hash_4466889733a90df2");
	level flag::init(#"hash_198bc172b5af7f25");
	level.var_43216bdf = &function_ff59ba7a;
}

/*
	Name: main
	Namespace: zm_orange_trials
	Checksum: 0x23B058A
	Offset: 0x330
	Size: 0x83C
	Parameters: 0
	Flags: None
*/
function main()
{
	level endon(#"end_game");
	level.var_3c9cfd6f = 1;
	zm_player::register_player_damage_callback(&function_dcebc908);
	while(true)
	{
		level waittill(#"hash_5d42d8ee7a08b543");
		switch(level.round_number)
		{
			case 2:
			{
				level flag::set("fasttravel_disabled");
				level thread clientfield::set("dog_round_fog_bank", 1);
				break;
			}
			case 3:
			{
				level thread clientfield::set("dog_round_fog_bank", 0);
				break;
			}
			case 17:
			{
				level thread function_b93ad88d();
				level.var_f6f7a368 = 3;
				level notify(#"hash_39b6629ce957cce9");
				break;
			}
			case 19:
			{
				level thread clientfield::set("dog_round_fog_bank", 1);
				break;
			}
			case 20:
			{
				level thread clientfield::set("dog_round_fog_bank", 0);
				break;
			}
			case 28:
			{
				level flag::set(#"hash_17b882aed4431728");
				level flag::set(#"hash_16c15e4538336bb5");
				level thread function_53a1ecb9();
				break;
			}
			case 29:
			{
				level thread function_ff0b7907();
				break;
			}
			case 30:
			{
				if(level.var_c3a029eb === 1)
				{
					level thread function_ff0b7907();
				}
				break;
			}
		}
		if(level.var_c3a029eb === 1)
		{
			foreach(e_player in getplayers())
			{
				e_player.var_36a93d1 = 0;
			}
			level.var_c3a029eb = 0;
		}
		level waittill(#"hash_7646638df88a3656");
		if(level.var_c3a029eb === 1 && level.round_number >= 29)
		{
			level thread lui::screen_flash(0.2, 3, 0.5, 1, "black");
			wait(0.2);
			foreach(player in getplayers())
			{
				player clientfield::set_to_player("" + #"hash_78b8d89d34b32241", 0);
			}
			level flag::clear(#"hash_4466889733a90df2");
			foreach(var_59bd23de in level.var_eb7fcc70)
			{
				var_59bd23de hide();
				var_59bd23de notsolid();
			}
			setlightingstate(0);
			level clientfield::set("" + #"lava_control", 0);
			level clientfield::set("" + #"hash_5e69ee96304ec40b", 0);
			level.var_71435e8 = 0;
			level flag::clear(#"hash_198bc172b5af7f25");
			level flag::clear(#"hash_69a9d00e65ee6c40");
		}
		level flag::clear("fasttravel_disabled");
		level flag::clear(#"hash_16c15e4538336bb5");
		level flag::clear(#"hash_17b882aed4431728");
		foreach(player in getplayers())
		{
			if(player.var_7dc2d507 === 1)
			{
				waitframe(2);
				player notify(#"hash_53bfad7081c69dee");
				player.var_7dc2d507 = 0;
				player zm_orange_water::function_46c3bbf7();
				player clientfield::set("" + #"hash_55543319943057f1", 0);
				player clientfield::set_to_player("" + #"hash_5160727729fd57a2", 0);
				player clientfield::set_to_player("" + #"hash_603fc9d210bdbc4d", 1);
				waitframe(2);
				player clientfield::set_to_player("" + #"hash_603fc9d210bdbc4d", 0);
				if(isdefined(player.t_ice))
				{
					player.t_ice delete();
					player.t_ice = undefined;
				}
				player clientfield::set_to_player("" + #"hash_13f1aaee7ebf9986", 0);
				waitframe(2);
				player thread zm_orange_water::function_ea0c7ed8();
			}
			player allowmelee(1);
		}
	}
}

/*
	Name: function_ff59ba7a
	Namespace: zm_orange_trials
	Checksum: 0x60E10458
	Offset: 0xB78
	Size: 0x17C
	Parameters: 1
	Flags: None
*/
function function_ff59ba7a(is_game_over)
{
	level.var_c3a029eb = 1;
	foreach(player in getplayers())
	{
		if(isdefined(player.var_3b55baa1) && isdefined(player.var_e01bb56) && player zm_orange_snowball_piles::function_75a76099())
		{
			player zm_loadout::set_player_lethal_grenade(player.var_3b55baa1);
			player zm_weapons::weapon_give(player.var_3b55baa1, 1, 0);
			n_slot = player gadgetgetslot(player.var_3b55baa1);
			player gadgetpowerset(n_slot, player.var_e01bb56);
			player.var_3b55baa1 = undefined;
			player.var_e01bb56 = undefined;
			player notify(#"grenade_change");
		}
	}
}

/*
	Name: function_b4bd25ef
	Namespace: zm_orange_trials
	Checksum: 0x8E2B10A2
	Offset: 0xD00
	Size: 0x794
	Parameters: 0
	Flags: None
*/
function function_b4bd25ef()
{
	switch(level.round_number)
	{
		case 1:
		{
			if(self.b_in_water === 1)
			{
				self enableoffhandspecial();
				self enableoffhandweapons();
				foreach(weapon in self getweaponslist(1))
				{
					self unlockweapon(weapon);
					if(weapon.isdualwield && weapon.dualwieldweapon != level.weaponnone)
					{
						self unlockweapon(weapon.dualwieldweapon);
					}
				}
			}
			break;
		}
		case 3:
		{
			if(isdefined(level.var_526d919))
			{
				self zm_trial_restrict_loadout::function_f0e03d3(0);
				foreach(weapon in self getweaponslist(1))
				{
					if(isdefined(level.var_526d919[weapon.name]))
					{
						self unlockweapon(weapon);
						if(weapon.isdualwield && weapon.dualwieldweapon != level.weaponnone)
						{
							self unlockweapon(weapon.dualwieldweapon);
						}
					}
				}
			}
			break;
		}
		case 16:
		{
			if(isdefined(level.var_526d919))
			{
				self zm_trial_restrict_loadout::function_f0e03d3(0);
				foreach(weapon in self getweaponslist(1))
				{
					if(isdefined(level.var_526d919[weapon.name]))
					{
						self unlockweapon(weapon);
						if(weapon.isdualwield && weapon.dualwieldweapon != level.weaponnone)
						{
							self unlockweapon(weapon.dualwieldweapon);
						}
					}
				}
			}
			break;
		}
		case 19:
		{
			if(isdefined(level.var_526d919))
			{
				if(self zm_orange_snowball_piles::function_75a76099())
				{
					foreach(weapon in self getweaponslist(1))
					{
						if(isdefined(level.var_526d919[weapon.name]))
						{
							self unlockweapon(weapon);
						}
					}
					level zm_trial::function_cd75b690(0);
				}
				else
				{
					level zm_trial::function_cd75b690(1);
				}
			}
			break;
		}
		case 21:
		{
			if(self zm_orange_trial_lighthouse_beam::function_91f0d131())
			{
				self enableoffhandspecial();
				self enableoffhandweapons();
				w_current = self getcurrentweapon();
				self unlockweapon(w_current);
			}
			break;
		}
		case 27:
		{
			if(isdefined(level.var_526d919))
			{
				self zm_trial_restrict_loadout::function_f0e03d3(0);
				foreach(weapon in self getweaponslist(1))
				{
					if(isdefined(level.var_526d919[weapon.name]))
					{
						self unlockweapon(weapon);
						if(weapon.isdualwield && weapon.dualwieldweapon != level.weaponnone)
						{
							self unlockweapon(weapon.dualwieldweapon);
						}
					}
				}
			}
			break;
		}
		default:
		{
			self allowmelee(1);
			self enableoffhandspecial();
			self enableoffhandweapons();
			foreach(weapon in self getweaponslist(1))
			{
				self unlockweapon(weapon);
			}
			self zm_trial_util::function_73ff0096();
			break;
		}
	}
	self bgb_pack::function_ac9cb612(0);
	self.var_be3224e6 = 0;
	self bgb::resume_weapon_cycling();
	self enableoffhandweapons();
	self enableoffhandspecial();
}

/*
	Name: function_ff0b7907
	Namespace: zm_orange_trials
	Checksum: 0x4442EF2F
	Offset: 0x14A0
	Size: 0x2D4
	Parameters: 0
	Flags: None
*/
function function_ff0b7907()
{
	level clientfield::set("" + #"hash_72b5b0359ca48427", 1);
	playsoundatposition(#"hash_431cadb65b1777ce", (0, 0, 0));
	level thread lui::screen_flash(0.2, 0.5, 1, 0.8, "white");
	wait(0.2);
	setlightingstate(1);
	level clientfield::set("" + #"lava_control", 1);
	level clientfield::set("" + #"hash_5e69ee96304ec40b", 1);
	if(!level flag::get(#"hash_4466889733a90df2"))
	{
		level flag::set(#"hash_4466889733a90df2");
		foreach(var_59bd23de in level.var_eb7fcc70)
		{
			var_59bd23de show();
			var_59bd23de solid();
		}
		level.var_71435e8 = 1;
		if(level.var_43c25ad2 !== 1)
		{
			array::thread_all(level.var_35e33dbe, &zm_orange_mq_hell::function_a8fd16d0);
			level.var_43c25ad2 = 1;
		}
		level flag::set(#"hash_198bc172b5af7f25");
		level flag::set(#"hash_69a9d00e65ee6c40");
	}
	array::run_all(getplayers(), &function_7206d28);
}

/*
	Name: function_7206d28
	Namespace: zm_orange_trials
	Checksum: 0x64DB86F8
	Offset: 0x1780
	Size: 0x1BC
	Parameters: 0
	Flags: None
*/
function function_7206d28()
{
	self.var_36a93d1 = 0;
	self clientfield::set_to_player("" + #"hash_13f1aaee7ebf9986", 0);
	if(self.var_7dc2d507 === 1)
	{
		self notify(#"hash_53bfad7081c69dee");
		self.var_7dc2d507 = 0;
		self zm_orange_water::function_46c3bbf7();
		self clientfield::set("" + #"hash_55543319943057f1", 0);
		self clientfield::set_to_player("" + #"hash_5160727729fd57a2", 0);
		self clientfield::set_to_player("" + #"hash_603fc9d210bdbc4d", 1);
		waitframe(2);
		self clientfield::set_to_player("" + #"hash_603fc9d210bdbc4d", 0);
		if(isdefined(self.t_ice))
		{
			self.t_ice delete();
			self.t_ice = undefined;
		}
		self clientfield::set_to_player("" + #"hash_13f1aaee7ebf9986", 0);
	}
	self clientfield::set_to_player("" + #"hash_78b8d89d34b32241", 1);
}

/*
	Name: function_b93ad88d
	Namespace: zm_orange_trials
	Checksum: 0xA8C9B9ED
	Offset: 0x1948
	Size: 0x66
	Parameters: 0
	Flags: None
*/
function function_b93ad88d()
{
	level endon(#"hash_2f8bcdedfd04a879");
	level.zones[#"ice_floe"].is_enabled = 0;
	wait(1);
	level.zones[#"ice_floe"].is_enabled = 1;
}

/*
	Name: function_53a1ecb9
	Namespace: zm_orange_trials
	Checksum: 0x74F7F77C
	Offset: 0x19B8
	Size: 0x7C
	Parameters: 0
	Flags: None
*/
function function_53a1ecb9()
{
	level endon(#"hash_7646638df88a3656");
	level waittill(#"hash_715188521b564b16");
	ai = zombie_utility::spawn_zombie(level.zombie_spawners[0], undefined);
	if(isdefined(ai))
	{
		ai thread blood_buff();
	}
}

/*
	Name: blood_buff
	Namespace: zm_orange_trials
	Checksum: 0x791891D6
	Offset: 0x1A40
	Size: 0x23C
	Parameters: 0
	Flags: None
*/
function blood_buff()
{
	self notify("6c9578c1610db2cd");
	self endon("6c9578c1610db2cd");
	self val::set(#"bludy", "takedamage", 0);
	self val::set(#"bludy", "allowdeath", 0);
	level.e_bludy = self;
	self.var_e1cad99d = 3;
	self.team = #"team3";
	self.var_d45ca662 = 1;
	self.b_ignore_cleanup = 1;
	self.ignoreme = 1;
	self.ignore_nuke = 1;
	self.ignore_all_poi = 1;
	self.var_38255de6 = 1;
	self.instakill_func = &zm_powerups::function_16c2586a;
	wait(0.5);
	while(!isdefined(self) || (isdefined(self) && !isalive(self)))
	{
		waitframe(1);
	}
	self thread function_8532d13f();
	self zombie_utility::set_zombie_run_cycle("run");
	level waittill(#"hash_7646638df88a3656");
	self val::reset(#"bludy", "takedamage");
	self val::reset(#"bludy", "allowdeath");
	if(isdefined(self))
	{
		level.var_4adebdfc unlink();
		level.var_4adebdfc.origin = level.var_63a35083[0].origin;
		self zombie_utility::zombie_head_gib();
	}
}

/*
	Name: function_8532d13f
	Namespace: zm_orange_trials
	Checksum: 0xD85ED267
	Offset: 0x1C88
	Size: 0xFC
	Parameters: 0
	Flags: None
*/
function function_8532d13f()
{
	self endon(#"death");
	if(isdefined(level.var_4adebdfc))
	{
		level.var_4adebdfc clientfield::set("" + #"hash_10906b9ce905bda8", 0);
	}
	wait(3);
	origin = self gettagorigin("j_spine4");
	level.var_4adebdfc.origin = origin;
	level.var_4adebdfc linkto(self, "j_spine4");
	level.var_4adebdfc clientfield::set("" + #"hash_10906b9ce905bda8", level.var_9e3c632e);
}

/*
	Name: function_dcebc908
	Namespace: zm_orange_trials
	Checksum: 0x5ECA80FA
	Offset: 0x1D90
	Size: 0xB8
	Parameters: 10
	Flags: Private
*/
function private function_dcebc908(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime)
{
	if(isdefined(eattacker) && (isdefined(eattacker.var_e1cad99d) && eattacker.var_e1cad99d))
	{
		return int(ceil(idamage * eattacker.var_e1cad99d));
	}
	return -1;
}

