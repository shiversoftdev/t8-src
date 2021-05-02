// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1b905a8474ed2a62;
#using script_3728b3b9606c4299;
#using script_522aeb6ae906391e;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\vehicle_ai_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;

#namespace amws;

/*
	Name: function_89f2df9
	Namespace: amws
	Checksum: 0x3BA5496F
	Offset: 0x220
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"amws", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: amws
	Checksum: 0x7724BFDB
	Offset: 0x268
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function __init__()
{
	spawner::add_archetype_spawn_function(#"amws", &amws_initialize);
}

/*
	Name: amws_initialize
	Namespace: amws
	Checksum: 0x65196629
	Offset: 0x2A8
	Size: 0x2FC
	Parameters: 0
	Flags: None
*/
function amws_initialize()
{
	self useanimtree("generic");
	vehicle::make_targetable(self);
	blackboard::createblackboardforentity(self);
	self blackboard::registervehicleblackboardattributes();
	self.health = self.healthdefault;
	self vehicle::friendly_fire_shield();
	self enableaimassist();
	self setneargoalnotifydist(40);
	self.fovcosine = 0;
	self.fovcosinebusy = 0.574;
	self.vehaircraftcollisionenabled = 1;
	/#
		assert(isdefined(self.scriptbundlesettings));
	#/
	self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
	self.goalradius = 999999;
	self.goalheight = 512;
	self setgoal(self.origin, 0, self.goalradius, self.goalheight);
	self.delete_on_death = 0;
	self.overridevehicledamage = &drone_callback_damage;
	self thread vehicle_ai::nudge_collision();
	self.cobra = 0;
	self asmrequestsubstate(#"locomotion@movement");
	self.variant = "light_weight";
	if(issubstr(self.scriptvehicletype, "pamws"))
	{
		self.variant = "armored";
	}
	else if(issubstr(self.scriptvehicletype, "argos"))
	{
		self.variant = "argos";
		self.var_a8c60b0e = 1;
		self.var_b4c9d62 = 1;
		self.var_527f38dc = 0;
	}
	if(isdefined(self.var_9b4a5686) && self.var_9b4a5686)
	{
		self.var_a8c60b0e = 1;
	}
	self util::cooldown("cobra_up", 10);
	if(isdefined(level.vehicle_initializer_cb))
	{
		[[level.vehicle_initializer_cb]](self);
	}
	self.var_232915af = 1;
	defaultrole();
}

/*
	Name: defaultrole
	Namespace: amws
	Checksum: 0x85C50E09
	Offset: 0x5B0
	Size: 0x2A4
	Parameters: 0
	Flags: None
*/
function defaultrole()
{
	self vehicle_ai::init_state_machine_for_role("default");
	self vehicle_ai::get_state_callbacks("combat").enter_func = &state_combat_enter;
	self vehicle_ai::get_state_callbacks("combat").update_func = &state_combat_update;
	self vehicle_ai::get_state_callbacks("driving").update_func = &state_driving_update;
	self vehicle_ai::get_state_callbacks("emped").update_func = &state_emped_update;
	self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
	if(self.vehicletype != #"archetype_mini_quadtank_mp")
	{
		self vehicle_ai::add_state("stationary", &state_stationary_enter, &state_stationary_update, &state_stationary_exit);
		vehicle_ai::add_interrupt_connection("stationary", "scripted", "enter_scripted");
		vehicle_ai::add_interrupt_connection("stationary", "emped", "emped");
		vehicle_ai::add_interrupt_connection("stationary", "off", "shut_off");
		vehicle_ai::add_interrupt_connection("stationary", "driving", "enter_vehicle");
		vehicle_ai::add_interrupt_connection("stationary", "pain", "pain");
		vehicle_ai::add_utility_connection("stationary", "combat");
		vehicle_ai::add_utility_connection("combat", "stationary");
		self vehicle_ai::startinitialstate("combat");
	}
}

/*
	Name: state_death_update
	Namespace: amws
	Checksum: 0x828BB6EA
	Offset: 0x860
	Size: 0xAC
	Parameters: 1
	Flags: None
*/
function state_death_update(params)
{
	self endon(#"death");
	death_type = vehicle_ai::get_death_type(params);
	if(!isdefined(death_type))
	{
		params.death_type = "gibbed";
		death_type = params.death_type;
	}
	if(death_type === "suicide_crash")
	{
		self death_suicide_crash(params);
	}
	self vehicle_ai::defaultstate_death_update(params);
}

/*
	Name: death_suicide_crash
	Namespace: amws
	Checksum: 0xE2DE9006
	Offset: 0x918
	Size: 0x1CA
	Parameters: 1
	Flags: None
*/
function death_suicide_crash(params)
{
	self endon(#"death");
	goaldir = anglestoforward(self.angles);
	goaldist = randomfloatrange(300, 400);
	goalpos = self.origin + goaldir * goaldist;
	self setmaxspeedscale(880 / self getmaxspeed(1));
	self setmaxaccelerationscale(50 / self getdefaultacceleration());
	self setspeed(self.settings.defaultmovespeed);
	self function_a57c34b7(goalpos, 0);
	self waittill_timeout(3.5, #"near_goal", #"veh_collision");
	self setmaxspeedscale(0.1);
	self setspeed(0.1);
	self vehicle_ai::clearallmovement();
	self vehicle_ai::clearalllookingandtargeting();
	self.death_type = "gibbed";
}

/*
	Name: state_driving_update
	Namespace: amws
	Checksum: 0xB00C316D
	Offset: 0xAF0
	Size: 0xF0
	Parameters: 1
	Flags: None
*/
function state_driving_update(params)
{
	self endon(#"change_state", #"death");
	if(isdefined(self.var_b4c9d62) && self.var_b4c9d62)
	{
		return;
	}
	driver = self getseatoccupant(0);
	if(isplayer(driver))
	{
		while(true)
		{
			driver endon(#"disconnect");
			driver util::waittill_vehicle_move_up_button_pressed();
			if(self.cobra === 0)
			{
				self cobra_raise();
			}
			else
			{
				self cobra_retract();
			}
		}
	}
}

/*
	Name: cobra_raise
	Namespace: amws
	Checksum: 0x9F5DC668
	Offset: 0xBE8
	Size: 0x106
	Parameters: 0
	Flags: None
*/
function cobra_raise()
{
	if(isdefined(self.var_b4c9d62) && self.var_b4c9d62)
	{
		return;
	}
	self.cobra = 1;
	if(isdefined(self.settings.cobra_fx_1) && isdefined(self.settings.cobra_tag_1))
	{
		playfxontag(self.settings.cobra_fx_1, self, self.settings.cobra_tag_1);
	}
	self asmrequestsubstate(#"hash_3e3fc20d5fcbf6e0");
	self vehicle_ai::waittill_asm_complete(#"hash_3e3fc20d5fcbf6e0", 4);
	self laseron();
	if(isdefined(self.var_9b4a5686) && self.var_9b4a5686)
	{
		self.var_a8c60b0e = 0;
	}
}

/*
	Name: cobra_retract
	Namespace: amws
	Checksum: 0xAF490180
	Offset: 0xCF8
	Size: 0xB2
	Parameters: 0
	Flags: None
*/
function cobra_retract()
{
	if(isdefined(self.var_b4c9d62) && self.var_b4c9d62)
	{
		return;
	}
	self.cobra = 0;
	self laseroff();
	self notify(#"disable_lens_flare");
	self asmrequestsubstate(#"locomotion@movement");
	self vehicle_ai::waittill_asm_complete("locomotion@movement", 4);
	if(isdefined(self.var_9b4a5686) && self.var_9b4a5686)
	{
		self.var_a8c60b0e = 1;
	}
}

/*
	Name: state_emped_update
	Namespace: amws
	Checksum: 0xB91EA950
	Offset: 0xDB8
	Size: 0xFC
	Parameters: 1
	Flags: None
*/
function state_emped_update(params)
{
	self endon(#"death", #"change_state");
	angles = self gettagangles("tag_turret");
	self turretsettargetangles(0, (45, angles[1] - self.angles[1], 0));
	angles = self gettagangles("tag_gunner_turret1");
	self turretsettargetangles(1, (45, angles[1] - self.angles[1], 0));
	self vehicle_ai::defaultstate_emped_update(params);
}

/*
	Name: state_stationary_enter
	Namespace: amws
	Checksum: 0xB9C378BE
	Offset: 0xEC0
	Size: 0x44
	Parameters: 1
	Flags: None
*/
function state_stationary_enter(params)
{
	vehicle_ai::clearalllookingandtargeting();
	vehicle_ai::clearallmovement();
	self setbrake(1);
}

/*
	Name: state_stationary_update
	Namespace: amws
	Checksum: 0x976C9E0E
	Offset: 0xF10
	Size: 0x4DC
	Parameters: 1
	Flags: None
*/
function state_stationary_update(params)
{
	self endon(#"death", #"change_state");
	self notify(#"stop_rocket_firing_thread");
	vehicle_ai::clearalllookingandtargeting();
	vehicle_ai::clearallmovement();
	wait(1);
	self cobra_raise();
	mintime = 6;
	maxtime = 12;
	transformwhenenemyclose = randomint(100) < 25;
	losepatienttime = 3 + randomfloat(2);
	starttime = gettime();
	util::cooldown("rocket", 2);
	evade_now = 0;
	while(true)
	{
		evade_now = self.settings.evade_enemies_locked_on_me === 1 && self.locked_on || (self.settings.evade_enemies_locking_on_me === 1 && self.locking_on);
		if(util::timesince(starttime) > maxtime || evade_now)
		{
			break;
		}
		if(isdefined(self.enemy))
		{
			distsqr = distancesquared(self.enemy.origin, self.origin);
			if(util::timesince(starttime) > mintime)
			{
				if(transformwhenenemyclose && distsqr < 200 * 200)
				{
					break;
				}
				if(!self seerecently(self.enemy, losepatienttime))
				{
					break;
				}
			}
			if(self cansee(self.enemy))
			{
				if(function_64609aab(self, self.enemy) !== 1)
				{
					break;
				}
				if(distsqr < self.settings.engagementdistmax * 3 * self.settings.engagementdistmax * 3)
				{
					self turretsettarget(0, self.enemy, vectorscale((0, 0, -1), 5));
					self turretsettarget(1, self.enemy, vectorscale((0, 0, -1), 5));
					if(util::iscooldownready("rocket") && self.turretontarget && self.gib_rocket !== 1 && (!(isdefined(self.var_a8c60b0e) && self.var_a8c60b0e)))
					{
						self thread firerocketlauncher(self.enemy);
						util::cooldown("rocket", self.settings.rocketcooldown);
					}
					var_6d08d874 = self.var_527f38dc;
					if(!isdefined(self.var_527f38dc))
					{
						var_6d08d874 = 1;
					}
					self vehicle_ai::fire_for_time(1, var_6d08d874, self.enemy, 0.5);
				}
				else
				{
					break;
				}
			}
		}
		wait(0.1);
	}
	self notify(#"stop_rocket_firing_thread");
	vehicle_ai::clearalllookingandtargeting();
	vehicle_ai::clearallmovement();
	if(evade_now)
	{
		self wait_evasion_reaction_time();
	}
	else
	{
		self state_stationary_update_wait(0.5);
	}
	self cobra_retract();
	self vehicle_ai::evaluate_connections();
}

/*
	Name: state_stationary_update_wait
	Namespace: amws
	Checksum: 0x79B6829D
	Offset: 0x13F8
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function state_stationary_update_wait(wait_time)
{
	waittill_weapon_lock_or_timeout(wait_time);
}

/*
	Name: state_stationary_exit
	Namespace: amws
	Checksum: 0xF21D6B22
	Offset: 0x1428
	Size: 0x64
	Parameters: 1
	Flags: None
*/
function state_stationary_exit(params)
{
	vehicle_ai::clearalllookingandtargeting();
	vehicle_ai::clearallmovement();
	self setbrake(0);
	self util::cooldown("cobra_up", 10);
}

/*
	Name: state_combat_enter
	Namespace: amws
	Checksum: 0x4F55D6E9
	Offset: 0x1498
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function state_combat_enter(params)
{
	self thread turretfireupdate();
}

/*
	Name: is_ai_using_minigun
	Namespace: amws
	Checksum: 0x7362AB19
	Offset: 0x14C8
	Size: 0x2E
	Parameters: 0
	Flags: None
*/
function is_ai_using_minigun()
{
	return (isdefined(self.settings.ai_uses_minigun) ? self.settings.ai_uses_minigun : 1);
}

/*
	Name: turretfireupdate
	Namespace: amws
	Checksum: 0x301CF474
	Offset: 0x1500
	Size: 0x3B0
	Parameters: 0
	Flags: None
*/
function turretfireupdate()
{
	var_6d08d874 = self.var_527f38dc;
	if(!isdefined(self.var_527f38dc))
	{
		var_6d08d874 = 1;
	}
	weapon = self seatgetweapon(var_6d08d874);
	if(weapon.name == "none")
	{
		return;
	}
	self endon(#"death", #"change_state");
	self turretsetontargettolerance(0, 7);
	self turretsetontargettolerance(1, 7);
	while(true)
	{
		if(self.avoid_shooting_owner === 1 && isdefined(self.owner))
		{
			if(self vehicle_ai::owner_in_line_of_fire())
			{
				wait(0.5);
				continue;
			}
		}
		if(isalive(self) && isdefined(self.enemy) && self cansee(self.enemy) && distancesquared(self.enemy.origin, self.origin) < self.settings.engagementdistmax * 3 * self.settings.engagementdistmax * 3)
		{
			self turretsettarget(var_6d08d874, self.enemy);
			self vehlookat(self.enemy);
			if(self is_ai_using_minigun())
			{
				self setturretspinning(1);
			}
			waitframe(1);
			if(!self.gunner1ontarget)
			{
				wait(0.5);
			}
			if(self.gunner1ontarget)
			{
				if(isdefined(self.enemy) && self cansee(self.enemy))
				{
					self vehicle_ai::fire_for_time(randomfloatrange(self.settings.burstfiredurationmin, self.settings.burstfiredurationmax), var_6d08d874, self.enemy);
				}
				if(self is_ai_using_minigun())
				{
					self setturretspinning(0);
				}
				if(isdefined(self.enemy) && isai(self.enemy))
				{
					wait(randomfloatrange(self.settings.burstfireaidelaymin, self.settings.burstfireaidelaymax));
				}
				else
				{
					wait(randomfloatrange(self.settings.burstfiredelaymin, self.settings.burstfiredelaymax));
				}
			}
			else
			{
				wait(0.5);
			}
		}
		else
		{
			wait(0.4);
		}
	}
}

/*
	Name: state_combat_update
	Namespace: amws
	Checksum: 0xA1AF11DA
	Offset: 0x18B8
	Size: 0x7A0
	Parameters: 1
	Flags: None
*/
function state_combat_update(params)
{
	self endon(#"death", #"change_state");
	lasttimechangeposition = 0;
	self.shouldgotonewposition = 0;
	self.lasttimetargetinsight = 0;
	self.var_23eff037 = 0;
	heatseekingmissile::initlockfield(self);
	self.lock_evading = 0;
	for(;;)
	{
		if(self.lock_evading == 0)
		{
			self setspeed(self.settings.defaultmovespeed);
			self setacceleration((isdefined(self.settings.default_move_acceleration) ? self.settings.default_move_acceleration : 10));
		}
		if(isdefined(self.enemy) && util::iscooldownready("cobra_up") && self.lock_evading == 0)
		{
			var_7e7717c8 = distancesquared(self.enemy.origin, self.origin);
			if(var_7e7717c8 > 200 * 200 && var_7e7717c8 < self.settings.engagementdistmax * 2 * self.settings.engagementdistmax * 2)
			{
				if(function_64609aab(self, self.enemy) === 1)
				{
					self vehicle_ai::evaluate_connections();
				}
			}
		}
		if(isdefined(self.settings.engage_enemies_locked_on_me) && self.settings.engage_enemies_locked_on_me && self.locked_on)
		{
			self.shouldgotonewposition = 1;
		}
		else if(isdefined(self.settings.engage_enemies_locking_on_me) && self.settings.engage_enemies_locking_on_me && self.locking_on)
		{
			self.shouldgotonewposition = 1;
		}
		self.lock_evading = 0;
		if(isdefined(self.settings.evade_enemies_locked_on_me) && self.settings.evade_enemies_locked_on_me)
		{
			self.lock_evading = self.lock_evading | self.locked_on;
		}
		if(isdefined(self.settings.evade_enemies_locking_on_me) && self.settings.evade_enemies_locking_on_me)
		{
			self.lock_evading = self.lock_evading | self.locking_on;
			self.lock_evading = self.lock_evading | self.locking_on_hacking;
		}
		if(isdefined(self.inpain) && self.inpain)
		{
			wait(0.1);
		}
		else if(!isdefined(self.enemy))
		{
			should_slow_down_at_goal = 1;
			if(self.lock_evading)
			{
				self.current_pathto_pos = getnextmoveposition_evasive(self.lock_evading);
				should_slow_down_at_goal = 0;
			}
			else
			{
				self.current_pathto_pos = getnextmoveposition_wander();
			}
			if(isdefined(self.current_pathto_pos))
			{
				if(self function_a57c34b7(self.current_pathto_pos, should_slow_down_at_goal, 1))
				{
					self thread path_update_interrupt_by_attacker();
					self thread path_update_interrupt();
					self vehicle_ai::waittill_pathing_done();
					self notify(#"amws_end_interrupt_watch");
				}
			}
			if(isdefined(self.var_23eff037) && self.var_23eff037)
			{
				self playsound(#"hash_7698127d41537782");
				self.var_23eff037 = 0;
			}
		}
		else if(isalive(self))
		{
			self turretsettarget(0, self.enemy);
			self vehlookat(self.enemy);
			if(self cansee(self.enemy))
			{
				self.lasttimetargetinsight = gettime();
				if(!(isdefined(self.var_23eff037) && self.var_23eff037))
				{
					self playsound(#"hash_7c4742a949425295");
					self.var_23eff037 = 1;
					wait(0.5);
				}
			}
			if(self.shouldgotonewposition == 0)
			{
				if(gettime() > lasttimechangeposition + 1000)
				{
					self.shouldgotonewposition = 1;
				}
				else if(gettime() > self.lasttimetargetinsight + 500)
				{
					self.shouldgotonewposition = 1;
					if(isdefined(self.var_23eff037) && self.var_23eff037)
					{
						self playsound(#"hash_7698127d41537782");
						self.var_23eff037 = 0;
					}
				}
			}
			if(self.shouldgotonewposition)
			{
				should_slow_down_at_goal = 1;
				if(self.lock_evading)
				{
					self.current_pathto_pos = getnextmoveposition_evasive(self.lock_evading);
					should_slow_down_at_goal = 0;
				}
				else
				{
					self.current_pathto_pos = getnextmoveposition_tactical(self.enemy);
				}
				if(isdefined(self.current_pathto_pos))
				{
					if(self function_a57c34b7(self.current_pathto_pos, should_slow_down_at_goal, 1))
					{
						self thread path_update_interrupt_by_attacker();
						self thread path_update_interrupt();
						self vehicle_ai::waittill_pathing_done();
						self notify(#"amws_end_interrupt_watch");
					}
					if(isdefined(self.enemy) && util::iscooldownready("rocket", 0.5) && self cansee(self.enemy) && self.gib_rocket !== 1)
					{
						self thread aim_and_fire_rocket_launcher(0.4);
					}
					lasttimechangeposition = gettime();
					self.shouldgotonewposition = 0;
				}
			}
		}
		self state_combat_update_wait(0.5);
	}
}

/*
	Name: function_64609aab
	Namespace: amws
	Checksum: 0x9A5B04D8
	Offset: 0x2060
	Size: 0x160
	Parameters: 2
	Flags: None
*/
function function_64609aab(entity, enemy)
{
	if(!isdefined(enemy) || !isdefined(entity))
	{
		return 0;
	}
	var_31e097c5 = entity.origin + vectorscale((0, 0, 1), 30);
	v_to_enemy = enemy.origin - entity.origin;
	v_to_enemy = vectornormalize(v_to_enemy);
	var_aae53953 = vectorscale(v_to_enemy, 350);
	var_5d132997 = vectorscale((0, 0, 1), 30);
	var_3a2b9b1a = var_31e097c5 + var_aae53953;
	var_ece22384 = sighttracepassed(var_31e097c5, var_3a2b9b1a, 0, entity, enemy);
	var_1159ae8 = sighttracepassed(var_31e097c5 + var_5d132997, var_3a2b9b1a + var_5d132997, 0, entity, enemy);
	if(var_ece22384 === 0 && var_1159ae8 !== 0)
	{
		return 1;
	}
	return 0;
}

/*
	Name: aim_and_fire_rocket_launcher
	Namespace: amws
	Checksum: 0x5304C34C
	Offset: 0x21C8
	Size: 0xDC
	Parameters: 1
	Flags: None
*/
function aim_and_fire_rocket_launcher(aim_time)
{
	self notify(#"stop_rocket_firing_thread");
	self endon(#"death", #"change_state", #"stop_rocket_firing_thread");
	if(!self.turretontarget)
	{
		wait(aim_time);
	}
	if(isdefined(self.enemy) && self.turretontarget && (!(isdefined(self.var_a8c60b0e) && self.var_a8c60b0e)))
	{
		util::cooldown("rocket", self.settings.rocketcooldown);
		self thread firerocketlauncher(self.enemy);
	}
}

/*
	Name: state_combat_update_wait
	Namespace: amws
	Checksum: 0x4910013
	Offset: 0x22B0
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function state_combat_update_wait(wait_time)
{
	self waittill_weapon_lock_or_timeout(wait_time);
}

/*
	Name: waittill_weapon_lock_or_timeout
	Namespace: amws
	Checksum: 0x3EF5AD6
	Offset: 0x22E0
	Size: 0x1C4
	Parameters: 1
	Flags: None
*/
function waittill_weapon_lock_or_timeout(wait_time)
{
	if(self.lock_evade_now === 1)
	{
		perform_evasion_reaction_wait = 1;
	}
	else
	{
		locked_on_notify = undefined;
		locking_on_notify = undefined;
		reacting_to_locks = self.settings.evade_enemies_locked_on_me === 1 || self.settings.engage_enemies_locked_on_me === 1;
		reacting_to_locking = self.settings.evade_enemies_locking_on_me === 1 || self.settings.engage_enemies_locking_on_me === 1;
		previous_locked_on_to_me = self.locked_on;
		previous_locking_on_to_me = self.locking_on;
		if(reacting_to_locks)
		{
			locked_on_notify = "missle_lock";
		}
		if(reacting_to_locking)
		{
			locking_on_notify = "locking on";
		}
		self waittill_timeout(wait_time, #"damage", locking_on_notify, locked_on_notify);
		locked_on_to_me_just_changed = previous_locked_on_to_me != self.locked_on && self.locked_on;
		locking_on_to_me_just_changed = previous_locking_on_to_me != self.locking_on && self.locking_on;
		perform_evasion_reaction_wait = reacting_to_locks && locked_on_to_me_just_changed || (reacting_to_locking && locking_on_to_me_just_changed);
	}
	if(perform_evasion_reaction_wait)
	{
		self wait_evasion_reaction_time();
	}
}

/*
	Name: wait_evasion_reaction_time
	Namespace: amws
	Checksum: 0xCC25CA2
	Offset: 0x24B0
	Size: 0x74
	Parameters: 0
	Flags: None
*/
function wait_evasion_reaction_time()
{
	wait(randomfloatrange((isdefined(self.settings.enemy_evasion_reaction_time_min) ? self.settings.enemy_evasion_reaction_time_min : 0.1), (isdefined(self.settings.enemy_evasion_reaction_time_max) ? self.settings.enemy_evasion_reaction_time_max : 0.2)));
}

/*
	Name: firerocketlauncher
	Namespace: amws
	Checksum: 0x834F6613
	Offset: 0x2530
	Size: 0x104
	Parameters: 1
	Flags: None
*/
function firerocketlauncher(enemy)
{
	self notify(#"stop_rocket_firing_thread");
	self endon(#"death", #"change_state", #"stop_rocket_firing_thread");
	if(isdefined(enemy))
	{
		self turretsettarget(0, enemy);
		self waittill_timeout(1, #"turret_on_target");
		self playsound(#"hash_713f03be0cf78d55");
		wait(1.2);
		if(self.variant == "armored")
		{
			vehicle_ai::fire_for_rounds(1, 0, enemy);
		}
		else
		{
			vehicle_ai::fire_for_rounds(2, 0, enemy);
		}
	}
}

/*
	Name: getnextmoveposition_wander
	Namespace: amws
	Checksum: 0x1F8CE197
	Offset: 0x2640
	Size: 0x306
	Parameters: 0
	Flags: None
*/
function getnextmoveposition_wander()
{
	if(self.goalforced)
	{
		return self.goalpos;
	}
	querymultiplier = 1.5;
	queryresult = positionquery_source_navigation(self.origin, 80, 500 * querymultiplier, 250, 3 * self.radius * querymultiplier, self, self.radius * querymultiplier);
	if(queryresult.data.size == 0)
	{
		queryresult = positionquery_source_navigation(self.origin, 36, 120, 240, self.radius, self);
	}
	positionquery_filter_distancetogoal(queryresult, self);
	vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
	positionquery_filter_inclaimedlocation(queryresult, self);
	best_point = undefined;
	best_score = 999999;
	foreach(point in queryresult.data)
	{
		randomscore = randomfloatrange(0, 100);
		disttooriginscore = point.disttoorigin2d * 0.2;
		if(point.inclaimedlocation)
		{
			point.score = point.score - 500;
		}
		point.score = point.score + randomscore + disttooriginscore;
		if(point.score > best_score)
		{
			best_score = point.score;
			best_point = point;
		}
	}
	/#
		self.debug_ai_move_to_points_considered = queryresult.data;
	#/
	if(!isdefined(best_point))
	{
		/#
			self.debug_ai_movement_type = "" + queryresult.data.size + "";
		#/
		/#
			self.debug_ai_move_to_point = undefined;
		#/
		return undefined;
	}
	/#
		self.debug_ai_movement_type = "" + queryresult.data.size;
	#/
	/#
		self.debug_ai_move_to_point = best_point.origin;
	#/
	return best_point.origin;
}

/*
	Name: getnextmoveposition_evasive
	Namespace: amws
	Checksum: 0xBC0E1905
	Offset: 0x2950
	Size: 0xA22
	Parameters: 1
	Flags: None
*/
function getnextmoveposition_evasive(client_flags)
{
	/#
		assert(isdefined(client_flags));
	#/
	self setspeed(self.settings.defaultmovespeed * (isdefined(self.settings.lock_evade_speed_boost) ? self.settings.lock_evade_speed_boost : 2));
	self setacceleration((isdefined(self.settings.default_move_acceleration) ? self.settings.default_move_acceleration : 10) * (isdefined(self.settings.lock_evade_acceleration_boost) ? self.settings.lock_evade_acceleration_boost : 2));
	loc_00002B24:
	loc_00002B70:
	queryresult = positionquery_source_navigation(self.origin, (isdefined(self.settings.lock_evade_dist_min) ? self.settings.lock_evade_dist_min : 120), (isdefined(self.settings.lock_evade_dist_max) ? self.settings.lock_evade_dist_max : 360), math::clamp((isdefined(self.settings.lock_evade_dist_half_height) ? self.settings.lock_evade_dist_half_height : 250), 0.1, 99000), (isdefined(self.settings.lock_evade_point_spacing_factor) ? self.settings.lock_evade_point_spacing_factor : 1.5) * self.radius, self);
	positionquery_filter_inclaimedlocation(queryresult, self);
	foreach(point in queryresult.data)
	{
		if(point.inclaimedlocation)
		{
			/#
				if(!isdefined(point._scoredebug))
				{
					point._scoredebug = [];
				}
				if(!isdefined(point._scoredebug[#"inclaimedlocation"]))
				{
					point._scoredebug[#"inclaimedlocation"] = spawnstruct();
				}
				point._scoredebug[#"inclaimedlocation"].score = -500;
				point._scoredebug[#"inclaimedlocation"].var_4b5e0304 = "";
			#/
			point.score = point.score + -500;
		}
	}
	remaining_lock_threats_to_evaluate = 3;
	remaining_flags_to_process = client_flags;
	for(i = 0; remaining_flags_to_process && remaining_lock_threats_to_evaluate > 0 && i < level.players.size; i++)
	{
		attacker = level.players[i];
		if(isdefined(attacker))
		{
			client_flag = 1 << attacker getentitynumber();
			if(client_flag & remaining_flags_to_process)
			{
				positionquery_filter_directness(queryresult, self.origin, attacker.origin);
				foreach(point in queryresult.data)
				{
					abs_directness = abs(point.directness);
					if(abs_directness < 0.2)
					{
						/#
							if(!isdefined(point._scoredebug))
							{
								point._scoredebug = [];
							}
							if(!isdefined(point._scoredebug[#"evading_directness"]))
							{
								point._scoredebug[#"evading_directness"] = spawnstruct();
							}
							point._scoredebug[#"evading_directness"].score = 200;
							point._scoredebug[#"evading_directness"].var_4b5e0304 = "";
						#/
						point.score = point.score + 200;
						continue;
					}
					if(abs_directness > (isdefined(self.settings.lock_evade_enemy_line_of_sight_directness) ? self.settings.lock_evade_enemy_line_of_sight_directness : 0.9))
					{
						/#
							if(!isdefined(point._scoredebug))
							{
								point._scoredebug = [];
							}
							if(!isdefined(point._scoredebug[#"evading_directness_line_of_sight"]))
							{
								point._scoredebug[#"evading_directness_line_of_sight"] = spawnstruct();
							}
							point._scoredebug[#"evading_directness_line_of_sight"].score = -101;
							point._scoredebug[#"evading_directness_line_of_sight"].var_4b5e0304 = "";
						#/
						point.score = point.score + -101;
					}
				}
				~point;
				remaining_flags_to_process = remaining_flags_to_process & client_flag;
				remaining_lock_threats_to_evaluate--;
			}
		}
	}
	positionquery_filter_directness(queryresult, self.origin, self.origin + anglestoforward(self.angles) * 360);
	foreach(point in queryresult.data)
	{
		if(point.directness > 0.5)
		{
			/#
				if(!isdefined(point._scoredebug))
				{
					point._scoredebug = [];
				}
				if(!isdefined(point._scoredebug[#"hash_3c71f4605004afec"]))
				{
					point._scoredebug[#"hash_3c71f4605004afec"] = spawnstruct();
				}
				point._scoredebug[#"hash_3c71f4605004afec"].score = 105;
				point._scoredebug[#"hash_3c71f4605004afec"].var_4b5e0304 = "";
			#/
			point.score = point.score + 105;
		}
	}
	best_point = undefined;
	best_score = 999999;
	foreach(point in queryresult.data)
	{
		if(point.score > best_score)
		{
			best_score = point.score;
			best_point = point;
		}
	}
	self.lock_evade_now = 0;
	self vehicle_ai::positionquery_debugscores(queryresult);
	/#
		self.debug_ai_move_to_points_considered = queryresult.data;
	#/
	if(!isdefined(best_point))
	{
		/#
			self.debug_ai_movement_type = "" + queryresult.data.size + "";
		#/
		/#
			self.debug_ai_move_to_point = undefined;
		#/
		return undefined;
	}
	/#
		self.debug_ai_movement_type = "" + queryresult.data.size;
	#/
	/#
		self.debug_ai_move_to_point = best_point.origin;
	#/
	return best_point.origin;
}

/*
	Name: getnextmoveposition_tactical
	Namespace: amws
	Checksum: 0x65795B1A
	Offset: 0x3380
	Size: 0xC02
	Parameters: 1
	Flags: None
*/
function getnextmoveposition_tactical(enemy)
{
	if(self.goalforced)
	{
		return self.goalpos;
	}
	if(!isdefined(enemy))
	{
		return self.goalpos;
	}
	selfdisttotarget = distance2d(self.origin, enemy.origin);
	gooddist = 0.5 * self.settings.engagementdistmin + self.settings.engagementdistmax;
	tooclosedist = 0.4 * self.settings.engagementdistmin + self.settings.engagementdistmax;
	closedist = 1.2 * gooddist;
	fardist = 3 * gooddist;
	querymultiplier = mapfloat(closedist, fardist, 1, 3, selfdisttotarget);
	prefereddirectness = 0;
	if(selfdisttotarget > gooddist)
	{
		prefereddirectness = mapfloat(closedist, fardist, 0, 1, selfdisttotarget);
	}
	else
	{
		prefereddirectness = mapfloat(tooclosedist * 0.4, tooclosedist, -1, -0.6, selfdisttotarget);
	}
	prefereddistawayfromorigin = 300;
	randomness = 30;
	queryresult = positionquery_source_navigation(self.origin, 80, 500 * querymultiplier, 250, 2 * self.radius * querymultiplier, self, 1 * self.radius * querymultiplier);
	positionquery_filter_directness(queryresult, self.origin, enemy.origin);
	positionquery_filter_distancetogoal(queryresult, self);
	vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
	positionquery_filter_inclaimedlocation(queryresult, self);
	vehicle_ai::positionquery_filter_engagementdist(queryresult, enemy, self.settings.engagementdistmin, self.settings.engagementdistmax);
	if(isdefined(self.avoidentities) && isdefined(self.avoidentitiesdistance))
	{
		vehicle_ai::positionquery_filter_distawayfromtarget(queryresult, self.avoidentities, self.avoidentitiesdistance, -500);
	}
	best_point = undefined;
	best_score = 999999;
	foreach(point in queryresult.data)
	{
		difftoprefereddirectness = abs(point.directness - prefereddirectness);
		directnessscore = mapfloat(0, 1, 100, 0, difftoprefereddirectness);
		if(difftoprefereddirectness > 0.2)
		{
			directnessscore = directnessscore - 200;
		}
		/#
			if(!isdefined(point._scoredebug))
			{
				point._scoredebug = [];
			}
			if(!isdefined(point._scoredebug[#"directnessraw"]))
			{
				point._scoredebug[#"directnessraw"] = spawnstruct();
			}
			point._scoredebug[#"directnessraw"].score = point.directness;
			point._scoredebug[#"directnessraw"].var_4b5e0304 = "";
		#/
		point.score = point.score + point.directness;
		/#
			if(!isdefined(point._scoredebug))
			{
				point._scoredebug = [];
			}
			if(!isdefined(point._scoredebug[#"directness"]))
			{
				point._scoredebug[#"directness"] = spawnstruct();
			}
			point._scoredebug[#"directness"].score = directnessscore;
			point._scoredebug[#"directness"].var_4b5e0304 = "";
		#/
		point.score = point.score + directnessscore;
		/#
			if(!isdefined(point._scoredebug))
			{
				point._scoredebug = [];
			}
			if(!isdefined(point._scoredebug[#"disttoorigin"]))
			{
				point._scoredebug[#"disttoorigin"] = spawnstruct();
			}
			point._scoredebug[#"disttoorigin"].score = mapfloat(0, prefereddistawayfromorigin, 0, 100, point.disttoorigin2d);
			point._scoredebug[#"disttoorigin"].var_4b5e0304 = "";
		#/
		point.score = point.score + mapfloat(0, prefereddistawayfromorigin, 0, 100, point.disttoorigin2d);
		targetdistscore = 0;
		if(point.targetdist < tooclosedist)
		{
			targetdistscore = targetdistscore - 200;
		}
		if(point.inclaimedlocation)
		{
			/#
				if(!isdefined(point._scoredebug))
				{
					point._scoredebug = [];
				}
				if(!isdefined(point._scoredebug[#"inclaimedlocation"]))
				{
					point._scoredebug[#"inclaimedlocation"] = spawnstruct();
				}
				point._scoredebug[#"inclaimedlocation"].score = -500;
				point._scoredebug[#"inclaimedlocation"].var_4b5e0304 = "";
			#/
			point.score = point.score + -500;
		}
		/#
			if(!isdefined(point._scoredebug))
			{
				point._scoredebug = [];
			}
			if(!isdefined(point._scoredebug[#"disttotarget"]))
			{
				point._scoredebug[#"disttotarget"] = spawnstruct();
			}
			point._scoredebug[#"disttotarget"].score = targetdistscore;
			point._scoredebug[#"disttotarget"].var_4b5e0304 = "";
		#/
		point.score = point.score + targetdistscore;
		/#
			if(!isdefined(point._scoredebug))
			{
				point._scoredebug = [];
			}
			if(!isdefined(point._scoredebug[#"random"]))
			{
				point._scoredebug[#"random"] = spawnstruct();
			}
			point._scoredebug[#"random"].score = randomfloatrange(0, randomness);
			point._scoredebug[#"random"].var_4b5e0304 = "";
		#/
		point.score = point.score + randomfloatrange(0, randomness);
		if(point.score > best_score)
		{
			best_score = point.score;
			best_point = point;
		}
	}
	self vehicle_ai::positionquery_debugscores(queryresult);
	/#
		self.debug_ai_move_to_points_considered = queryresult.data;
	#/
	if(!isdefined(best_point))
	{
		/#
			self.debug_ai_movement_type = "" + queryresult.data.size + "";
		#/
		/#
			self.debug_ai_move_to_point = undefined;
		#/
		return undefined;
	}
	/#
		if(isdefined(getdvarint(#"hkai_debugpositionquery", 0)) && getdvarint(#"hkai_debugpositionquery", 0))
		{
			recordline(self.origin, best_point.origin, (0.3, 1, 0));
			recordline(self.origin, enemy.origin, (1, 0, 0.4));
		}
	#/
	/#
		self.debug_ai_movement_type = "" + queryresult.data.size;
	#/
	/#
		self.debug_ai_move_to_point = best_point.origin;
	#/
	return best_point.origin;
}

/*
	Name: path_update_interrupt_by_attacker
	Namespace: amws
	Checksum: 0x2868D87E
	Offset: 0x3F90
	Size: 0x126
	Parameters: 0
	Flags: None
*/
function path_update_interrupt_by_attacker()
{
	self notify(#"path_update_interrupt_by_attacker");
	self endon(#"death", #"change_state", #"near_goal", #"reached_end_node", #"amws_end_interrupt_watch", #"path_update_interrupt_by_attacker");
	self waittill(#"hash_594587fd1093c3b3", #"missile_lock", #"damage");
	if(self.locked_on || self.locking_on)
	{
		/#
			self.debug_ai_move_to_points_considered = [];
		#/
		/#
			self.debug_ai_movement_type = "";
		#/
		/#
			self.debug_ai_move_to_point = undefined;
		#/
		self function_d4c687c9();
		self.lock_evade_now = 1;
	}
	self notify(#"near_goal");
}

/*
	Name: path_update_interrupt
	Namespace: amws
	Checksum: 0x5C735F9D
	Offset: 0x40C0
	Size: 0x224
	Parameters: 0
	Flags: None
*/
function path_update_interrupt()
{
	self notify(#"path_update_interrupt_by_attacker");
	self endon(#"death", #"change_state", #"near_goal", #"reached_end_node", #"amws_end_interrupt_watch", #"path_update_interrupt_by_attacker");
	wait(1);
	while(true)
	{
		if(isdefined(self.current_pathto_pos))
		{
			if(distance2dsquared(self.current_pathto_pos, self.goalpos) > self.goalradius * self.goalradius)
			{
				wait(0.2);
				self notify(#"near_goal");
			}
		}
		if(isdefined(self.enemy))
		{
			if(self cansee(self.enemy) && distance2dsquared(self.origin, self.enemy.origin) < 0.4 * self.settings.engagementdistmin + self.settings.engagementdistmax * 0.4 * self.settings.engagementdistmin + self.settings.engagementdistmax)
			{
				self notify(#"near_goal");
			}
			if(util::iscooldownready("rocket") && util::iscooldownready("rocket_launcher_check"))
			{
				util::cooldown("rocket_launcher_check", 2.5);
				self notify(#"near_goal");
			}
		}
		wait(0.2);
	}
}

/*
	Name: gib
	Namespace: amws
	Checksum: 0xB6A7C6EC
	Offset: 0x42F0
	Size: 0x84
	Parameters: 1
	Flags: None
*/
function gib(attacker)
{
	if(self.gibbed !== 1)
	{
		self vehicle::do_gib_dynents();
		self.gibbed = 1;
		self.death_type = "suicide_crash";
		self kill(self.origin + vectorscale((0, 0, 1), 10), attacker);
	}
}

/*
	Name: drone_callback_damage
	Namespace: amws
	Checksum: 0x8F2DD5FB
	Offset: 0x4380
	Size: 0xD2
	Parameters: 15
	Flags: None
*/
function drone_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal)
{
	idamage = vehicle_ai::shared_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
	return idamage;
}

