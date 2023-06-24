// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai\zombie_utility.gsc;
#using script_6951ea86fdae9ae0;
#using scripts\zm_common\trials\zm_trial_restrict_loadout.gsc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\visionset_mgr_shared.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_net.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_perk_electric_cherry;

/*
	Name: __init__system__
	Namespace: zm_perk_electric_cherry
	Checksum: 0xA7B9BA2
	Offset: 0x300
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_electric_cherry", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_electric_cherry
	Checksum: 0x5CEAE96F
	Offset: 0x348
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	enable_electric_cherry_perk_for_level();
}

/*
	Name: enable_electric_cherry_perk_for_level
	Namespace: zm_perk_electric_cherry
	Checksum: 0xB61D9437
	Offset: 0x368
	Size: 0x274
	Parameters: 0
	Flags: Linked
*/
function enable_electric_cherry_perk_for_level()
{
	if(function_8b1a219a())
	{
		zm_perks::register_perk_basic_info(#"specialty_electriccherry", #"perk_electric_cherry", 3000, #"hash_2355bebe5034477a", getweapon("zombie_perk_bottle_cherry"), getweapon("zombie_perk_totem_electric_burst"), #"zmperkselectricburst");
	}
	else
	{
		zm_perks::register_perk_basic_info(#"specialty_electriccherry", #"perk_electric_cherry", 3000, #"zombie/perk_electric_cherry", getweapon("zombie_perk_bottle_cherry"), getweapon("zombie_perk_totem_electric_burst"), #"zmperkselectricburst");
	}
	zm_perks::register_perk_precache_func(#"specialty_electriccherry", &electric_cherry_precache);
	zm_perks::register_perk_clientfields(#"specialty_electriccherry", &electric_cherry_register_clientfield, &electric_cherry_set_clientfield);
	zm_perks::register_perk_machine(#"specialty_electriccherry", &electric_cherry_perk_machine_setup);
	zm_perks::register_perk_host_migration_params(#"specialty_electriccherry", "vending_electriccherry", "electric_cherry_light");
	zm_perks::register_perk_threads(#"specialty_electriccherry", &electric_cherry_reload_attack, &electric_cherry_perk_lost);
	if(isdefined(level.custom_electric_cherry_perk_threads) && level.custom_electric_cherry_perk_threads)
	{
		level thread [[level.custom_electric_cherry_perk_threads]]();
	}
	init_electric_cherry();
}

/*
	Name: electric_cherry_precache
	Namespace: zm_perk_electric_cherry
	Checksum: 0xFFDF593F
	Offset: 0x5E8
	Size: 0x10E
	Parameters: 0
	Flags: Linked
*/
function electric_cherry_precache()
{
	if(isdefined(level.electric_cherry_precache_override_func))
	{
		[[level.electric_cherry_precache_override_func]]();
		return;
	}
	level._effect[#"electric_cherry_light"] = #"hash_1442db17b83460ad";
	level.machine_assets[#"specialty_electriccherry"] = spawnstruct();
	level.machine_assets[#"specialty_electriccherry"].weapon = getweapon("zombie_perk_bottle_cherry");
	level.machine_assets[#"specialty_electriccherry"].off_model = "p7_zm_vending_nuke";
	level.machine_assets[#"specialty_electriccherry"].on_model = "p7_zm_vending_nuke";
}

/*
	Name: electric_cherry_register_clientfield
	Namespace: zm_perk_electric_cherry
	Checksum: 0x80F724D1
	Offset: 0x700
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function electric_cherry_register_clientfield()
{
}

/*
	Name: electric_cherry_set_clientfield
	Namespace: zm_perk_electric_cherry
	Checksum: 0x843EFA63
	Offset: 0x710
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function electric_cherry_set_clientfield(state)
{
}

/*
	Name: electric_cherry_perk_machine_setup
	Namespace: zm_perk_electric_cherry
	Checksum: 0x9428C492
	Offset: 0x728
	Size: 0xB6
	Parameters: 4
	Flags: Linked
*/
function electric_cherry_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound = "mus_perks_stamin_jingle";
	use_trigger.script_string = "marathon_perk";
	use_trigger.script_label = "mus_perks_stamin_sting";
	use_trigger.target = "vending_marathon";
	perk_machine.script_string = "marathon_perk";
	perk_machine.targetname = "vending_marathon";
	if(isdefined(bump_trigger))
	{
		bump_trigger.script_string = "marathon_perk";
	}
}

/*
	Name: init_electric_cherry
	Namespace: zm_perk_electric_cherry
	Checksum: 0x7AB4150B
	Offset: 0x7E8
	Size: 0x164
	Parameters: 0
	Flags: Linked
*/
function init_electric_cherry()
{
	level._effect[#"electric_cherry_explode"] = #"hash_413a313438a3a4e1";
	level.custom_laststand_func = &electric_cherry_laststand;
	zombie_utility::set_zombie_var(#"tesla_head_gib_chance", 50);
	clientfield::register("allplayers", "electric_cherry_reload_fx", 1, 2, "int");
	clientfield::register("actor", "tesla_death_fx", 1, 1, "int");
	clientfield::register("vehicle", "tesla_death_fx_veh", 1, 1, "int");
	clientfield::register("actor", "tesla_shock_eyes_fx", 1, 1, "int");
	clientfield::register("vehicle", "tesla_shock_eyes_fx_veh", 1, 1, "int");
}

/*
	Name: electric_cherry_host_migration_func
	Namespace: zm_perk_electric_cherry
	Checksum: 0xCE75935D
	Offset: 0x958
	Size: 0xF0
	Parameters: 0
	Flags: None
*/
function electric_cherry_host_migration_func()
{
	a_electric_cherry_perk_machines = getentarray("vending_electriccherry", "targetname");
	foreach(perk_machine in a_electric_cherry_perk_machines)
	{
		if(isdefined(perk_machine.model) && perk_machine.model == "p7_zm_vending_nuke")
		{
			perk_machine zm_perks::perk_fx(undefined, 1);
			perk_machine thread zm_perks::perk_fx("electriccherry");
		}
	}
}

/*
	Name: electric_cherry_laststand
	Namespace: zm_perk_electric_cherry
	Checksum: 0xFD6134E8
	Offset: 0xA50
	Size: 0x28E
	Parameters: 0
	Flags: Linked
*/
function electric_cherry_laststand()
{
	self endon(#"disconnect");
	visionsetlaststand("zombie_last_stand", 1);
	if(isdefined(self))
	{
		playfx(level._effect[#"electric_cherry_explode"], self.origin);
		self playsound(#"hash_75ba32e48680203a");
		self notify(#"electric_cherry_start");
		waitframe(1);
		a_zombies = zombie_utility::get_round_enemy_array();
		a_zombies = util::get_array_of_closest(self.origin, a_zombies, undefined, undefined, 500);
		for(i = 0; i < a_zombies.size; i++)
		{
			if(isalive(self) && isalive(a_zombies[i]) && !zm_trial_restrict_loadout::is_active())
			{
				if(a_zombies[i].health <= 1000)
				{
					a_zombies[i] thread electric_cherry_death_fx();
					if(isdefined(self.cherry_kills))
					{
						self.cherry_kills++;
					}
					self zm_score::add_to_player_score(40);
				}
				else
				{
					a_zombies[i] thread electric_cherry_stun();
					a_zombies[i] thread electric_cherry_shock_fx();
				}
				wait(0.1);
				if(isalive(self) && isalive(a_zombies[i]))
				{
					a_zombies[i] dodamage(1000, self.origin, self, self, "none", "MOD_UNKNOWN", 0, level.var_78032351);
				}
			}
		}
		self notify(#"electric_cherry_end");
	}
}

/*
	Name: electric_cherry_death_fx
	Namespace: zm_perk_electric_cherry
	Checksum: 0xDFC2162B
	Offset: 0xCE8
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function electric_cherry_death_fx()
{
	self endon(#"death");
	if(!(isdefined(self.head_gibbed) && self.head_gibbed))
	{
		if(isvehicle(self))
		{
			self clientfield::set("tesla_shock_eyes_fx_veh", 1);
		}
		else
		{
			self clientfield::set("tesla_shock_eyes_fx", 1);
		}
	}
	else
	{
		if(isvehicle(self))
		{
			self clientfield::set("tesla_death_fx_veh", 1);
		}
		else
		{
			self clientfield::set("tesla_death_fx", 1);
		}
	}
}

/*
	Name: electric_cherry_shock_fx
	Namespace: zm_perk_electric_cherry
	Checksum: 0x445F7CC0
	Offset: 0xDE0
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function electric_cherry_shock_fx()
{
	self endon(#"death");
	if(isvehicle(self))
	{
		self clientfield::set("tesla_shock_eyes_fx_veh", 1);
	}
	else
	{
		self clientfield::set("tesla_shock_eyes_fx", 1);
	}
	self waittill(#"stun_fx_end");
	if(isvehicle(self))
	{
		self clientfield::set("tesla_shock_eyes_fx_veh", 0);
	}
	else
	{
		self clientfield::set("tesla_shock_eyes_fx", 0);
	}
}

/*
	Name: electric_cherry_stun
	Namespace: zm_perk_electric_cherry
	Checksum: 0x1A0C0CA5
	Offset: 0xEC8
	Size: 0x106
	Parameters: 0
	Flags: Linked
*/
function electric_cherry_stun()
{
	self notify(#"stun_zombie");
	self endon(#"death", #"stun_zombie");
	if(self.health <= 0)
	{
		/#
			iprintln("");
		#/
		return;
	}
	self ai::stun(4);
	self val::set(#"electric_cherry_stun", "ignoreall", 1);
	wait(4);
	if(isdefined(self))
	{
		self ai::function_62795e55();
		self val::reset(#"electric_cherry_stun", "ignoreall");
		self notify(#"stun_fx_end");
	}
}

/*
	Name: electric_cherry_reload_attack
	Namespace: zm_perk_electric_cherry
	Checksum: 0xF1B1E23
	Offset: 0xFD8
	Size: 0x572
	Parameters: 0
	Flags: Linked
*/
function electric_cherry_reload_attack()
{
	self endon(#"disconnect", #"specialty_electriccherry" + "_take");
	self.wait_on_reload = [];
	self.consecutive_electric_cherry_attacks = 0;
	while(true)
	{
		self waittill(#"reload_start");
		current_weapon = self getcurrentweapon();
		if(isinarray(self.wait_on_reload, current_weapon))
		{
			continue;
		}
		if(current_weapon.isabilityweapon)
		{
			continue;
		}
		if(namespace_fcd611c3::is_active() && !self namespace_fcd611c3::function_26f124d8())
		{
			continue;
		}
		self.wait_on_reload[self.wait_on_reload.size] = current_weapon;
		self.consecutive_electric_cherry_attacks++;
		n_clip_current = self getweaponammoclip(current_weapon);
		n_clip_max = self getweaponammoclipsize(current_weapon);
		if(n_clip_max <= 0)
		{
			continue;
		}
		n_fraction = n_clip_current / n_clip_max;
		perk_radius = math::linear_map(n_fraction, 1, 0, 32, 128);
		perk_dmg = math::linear_map(n_fraction, 1, 0, 1, 1045);
		self thread check_for_reload_complete(current_weapon);
		if(isdefined(self))
		{
			switch(self.consecutive_electric_cherry_attacks)
			{
				case 0:
				case 1:
				{
					n_zombie_limit = undefined;
					break;
				}
				case 2:
				{
					n_zombie_limit = 8;
					break;
				}
				case 3:
				{
					n_zombie_limit = 4;
					break;
				}
				case 4:
				{
					n_zombie_limit = 2;
					break;
				}
				default:
				{
					n_zombie_limit = 0;
				}
			}
			self thread electric_cherry_cooldown_timer(current_weapon);
			if(isdefined(n_zombie_limit) && n_zombie_limit == 0)
			{
				continue;
			}
			self thread electric_cherry_reload_fx(n_fraction);
			self notify(#"electric_cherry_start");
			self playsound(#"hash_75ba32e48680203a");
			a_zombies = getaiteamarray(level.zombie_team);
			a_zombies = util::get_array_of_closest(self.origin, a_zombies, undefined, undefined, perk_radius);
			n_zombies_hit = 0;
			for(i = 0; i < a_zombies.size; i++)
			{
				if(isalive(self) && isalive(a_zombies[i]) && !zm_trial_restrict_loadout::is_active())
				{
					if(isdefined(n_zombie_limit))
					{
						if(n_zombies_hit < n_zombie_limit)
						{
							n_zombies_hit++;
						}
						else
						{
							break;
						}
					}
					if(a_zombies[i].health <= perk_dmg)
					{
						a_zombies[i] thread electric_cherry_death_fx();
						if(isdefined(self.cherry_kills))
						{
							self.cherry_kills++;
						}
						self zm_score::add_to_player_score(40);
					}
					else
					{
						if(!isdefined(a_zombies[i].is_brutus))
						{
							a_zombies[i] thread electric_cherry_stun();
						}
						a_zombies[i] thread electric_cherry_shock_fx();
					}
					wait(0.1);
					if(isdefined(a_zombies[i]) && isalive(a_zombies[i]))
					{
						a_zombies[i] dodamage(perk_dmg, self.origin, self, self, "none", "MOD_UNKNOWN", 0, level.var_78032351);
					}
				}
			}
			self notify(#"electric_cherry_end");
		}
	}
}

/*
	Name: electric_cherry_cooldown_timer
	Namespace: zm_perk_electric_cherry
	Checksum: 0x115DC519
	Offset: 0x1558
	Size: 0xC6
	Parameters: 1
	Flags: Linked
*/
function electric_cherry_cooldown_timer(current_weapon)
{
	self notify(#"electric_cherry_cooldown_started");
	self endon(#"disconnect", #"electric_cherry_cooldown_started");
	n_reload_time = 0.25;
	if(self hasperk(#"specialty_fastreload"))
	{
		n_reload_time = n_reload_time * getdvarfloat(#"perk_weapreloadmultiplier", 0);
	}
	n_cooldown_time = n_reload_time + 3;
	wait(n_cooldown_time);
	self.consecutive_electric_cherry_attacks = 0;
}

/*
	Name: check_for_reload_complete
	Namespace: zm_perk_electric_cherry
	Checksum: 0x7596F430
	Offset: 0x1628
	Size: 0xD8
	Parameters: 1
	Flags: Linked
*/
function check_for_reload_complete(weapon)
{
	self endon(#"disconnect", "player_lost_weapon_" + weapon.name);
	self thread weapon_replaced_monitor(weapon);
	while(true)
	{
		self waittill(#"reload", #"hash_278526d0bbdb4ce7");
		current_weapon = self getcurrentweapon();
		if(current_weapon == weapon)
		{
			arrayremovevalue(self.wait_on_reload, weapon);
			self notify("weapon_reload_complete_" + weapon.name);
			break;
		}
	}
}

/*
	Name: weapon_replaced_monitor
	Namespace: zm_perk_electric_cherry
	Checksum: 0x56C7E357
	Offset: 0x1708
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function weapon_replaced_monitor(weapon)
{
	self endon(#"disconnect", "weapon_reload_complete_" + weapon.name);
	while(true)
	{
		self waittill(#"weapon_change");
		primaryweapons = self getweaponslistprimaries();
		if(!isinarray(primaryweapons, weapon))
		{
			self notify("player_lost_weapon_" + weapon.name);
			arrayremovevalue(self.wait_on_reload, weapon);
			break;
		}
	}
}

/*
	Name: electric_cherry_reload_fx
	Namespace: zm_perk_electric_cherry
	Checksum: 0xB1757E05
	Offset: 0x17D0
	Size: 0xEC
	Parameters: 1
	Flags: Linked
*/
function electric_cherry_reload_fx(n_fraction)
{
	self endon(#"disconnect");
	if(n_fraction >= 0.67)
	{
		self clientfield::set("electric_cherry_reload_fx", 1);
	}
	else
	{
		if(n_fraction >= 0.33 && n_fraction < 0.67)
		{
			self clientfield::set("electric_cherry_reload_fx", 2);
		}
		else
		{
			self clientfield::set("electric_cherry_reload_fx", 3);
		}
	}
	wait(1);
	self clientfield::set("electric_cherry_reload_fx", 0);
}

/*
	Name: electric_cherry_perk_lost
	Namespace: zm_perk_electric_cherry
	Checksum: 0x923F1A53
	Offset: 0x18C8
	Size: 0x40
	Parameters: 4
	Flags: Linked
*/
function electric_cherry_perk_lost(b_pause, str_perk, str_result, n_slot)
{
	self notify(#"specialty_electriccherry" + "_take");
}

