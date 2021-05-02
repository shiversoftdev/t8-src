// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\influencers_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\turret_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_ai_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;

#namespace auto_turret;

/*
	Name: function_89f2df9
	Namespace: auto_turret
	Checksum: 0x2DF9655F
	Offset: 0x200
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"auto_turret", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: auto_turret
	Checksum: 0x8741E4B
	Offset: 0x248
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	vehicle::add_main_callback("auto_turret", &function_f17009ff);
}

/*
	Name: function_b07539aa
	Namespace: auto_turret
	Checksum: 0xA8921290
	Offset: 0x280
	Size: 0x51C
	Parameters: 0
	Flags: None
*/
function function_b07539aa()
{
	self.health = self.healthdefault;
	if(isdefined(self.scriptbundlesettings))
	{
		self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
	}
	else
	{
		self.settings = struct::get_script_bundle("vehiclecustomsettings", "artillerysettings");
	}
	targetoffset = ((isdefined(self.settings.lockon_offsetx) ? self.settings.lockon_offsetx : 0), (isdefined(self.settings.lockon_offsety) ? self.settings.lockon_offsety : 0), (isdefined(self.settings.lockon_offsetz) ? self.settings.lockon_offsetz : 0));
	vehicle::make_targetable(self, targetoffset);
	sightfov = self.settings.sightfov;
	if(!isdefined(sightfov))
	{
		sightfov = 0;
	}
	if(sightfov == 0)
	{
		self.fovcosine = 0;
		self.fovcosinebusy = 0;
	}
	else
	{
		self.fovcosine = cos(sightfov - 0.1);
		self.fovcosinebusy = cos(sightfov - 0.1);
	}
	if(self.settings.disconnectpaths === 1)
	{
		self disconnectpaths(1);
	}
	if(self.settings.ignoreme === 1)
	{
		self val::set(#"auto_turret", "ignoreme", 1);
	}
	if(self.settings.laseron === 1)
	{
		self laseron();
	}
	if(self.settings.disablefiring !== 1)
	{
		self enableaimassist();
	}
	else
	{
		self.nocybercom = 1;
	}
	self.overridevehicledamage = &turretcallback_vehicledamage;
	self.allowfriendlyfiredamageoverride = &turretallowfriendlyfiredamage;
	if(isdefined(self.var_37e3fb9c) && self.var_37e3fb9c)
	{
		self influencers::create_influencer_generic("enemy", self.origin, self.team, 1);
	}
	if(isdefined(self.settings.var_668fd77a) && self.settings.var_668fd77a)
	{
		self clientfield::set("turret_keyline_render", 1);
	}
	if(isdefined(level.vehicle_initializer_cb))
	{
		[[level.vehicle_initializer_cb]](self);
	}
	if(isdefined(self.settings.var_d3cc01c7) && self.settings.var_d3cc01c7 && (!(isdefined(self.var_fcb567c8) && self.var_fcb567c8)))
	{
		if(!isdefined(level.var_c70c6768))
		{
			level.var_c70c6768 = 0;
		}
		else
		{
			level.var_c70c6768 = level.var_c70c6768 + 1;
		}
		self.turret_id = string(level.var_c70c6768);
		badplace_cylinder("turret_bad_place_" + self.turret_id, 0, self.origin, self.settings.var_9493f6dc, self.settings.var_c9c01aa4, #"axis", #"allies", #"neutral");
		self.var_fcb567c8 = 1;
	}
	if(isdefined(self.settings.cleanup_after_time) && self.settings.cleanup_after_time > 0)
	{
		self.cleanup_after_time = self.settings.cleanup_after_time;
	}
	self callback::function_d8abfc3d(#"on_vehicle_killed", &function_3dda565d);
}

/*
	Name: function_f17009ff
	Namespace: auto_turret
	Checksum: 0x5632112D
	Offset: 0x7A8
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function function_f17009ff()
{
	function_b07539aa();
	function_bc23ad6e();
}

/*
	Name: function_bc23ad6e
	Namespace: auto_turret
	Checksum: 0xBD9BCB37
	Offset: 0x7D8
	Size: 0x30C
	Parameters: 0
	Flags: None
*/
function function_bc23ad6e()
{
	self vehicle_ai::init_state_machine_for_role("default");
	self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
	self vehicle_ai::get_state_callbacks("combat").update_func = &function_f2d20a04;
	self vehicle_ai::get_state_callbacks("combat").exit_func = &state_combat_exit;
	self vehicle_ai::get_state_callbacks("off").enter_func = &state_off_enter;
	self vehicle_ai::get_state_callbacks("off").exit_func = &state_off_exit;
	self vehicle_ai::get_state_callbacks("emped").enter_func = &state_emped_enter;
	self vehicle_ai::get_state_callbacks("emped").update_func = &state_emped_update;
	self vehicle_ai::get_state_callbacks("emped").exit_func = &state_emped_exit;
	self vehicle_ai::add_state("unaware", undefined, &state_unaware_update, undefined);
	vehicle_ai::add_interrupt_connection("unaware", "scripted", "enter_scripted");
	vehicle_ai::add_interrupt_connection("unaware", "emped", "emped");
	vehicle_ai::add_interrupt_connection("unaware", "off", "shut_off");
	vehicle_ai::add_interrupt_connection("unaware", "driving", "enter_vehicle");
	vehicle_ai::add_interrupt_connection("unaware", "pain", "pain");
	vehicle_ai::add_utility_connection("unaware", "combat", &should_switch_to_combat);
	vehicle_ai::add_utility_connection("combat", "unaware", &should_switch_to_unaware);
	vehicle_ai::startinitialstate("unaware");
}

/*
	Name: state_death_update
	Namespace: auto_turret
	Checksum: 0x97A4FC13
	Offset: 0xAF0
	Size: 0x1CC
	Parameters: 1
	Flags: None
*/
function state_death_update(params)
{
	self endon(#"death");
	owner = self getvehicleowner();
	if(isdefined(owner))
	{
		self waittill(#"exit_vehicle");
	}
	self setturretspinning(0);
	self turret::toggle_lensflare(0);
	if(isdefined(self.var_fcb567c8) && self.var_fcb567c8)
	{
		badplace_delete("turret_bad_place_" + self.turret_id);
		self.var_fcb567c8 = 0;
	}
	if(target_istarget(self))
	{
		target_remove(self);
	}
	self thread turret_idle_sound_stop();
	self playsound(#"veh_sentry_turret_dmg_hit");
	self.turretrotscale = 2;
	self rest_turret(params.resting_pitch);
	self vehicle_ai::defaultstate_death_update(params);
	if(isdefined(self.settings.var_668fd77a) && self.settings.var_668fd77a)
	{
		self clientfield::set("turret_keyline_render", 0);
	}
}

/*
	Name: should_switch_to_unaware
	Namespace: auto_turret
	Checksum: 0x3D75558F
	Offset: 0xCC8
	Size: 0x5A
	Parameters: 3
	Flags: None
*/
function should_switch_to_unaware(current_state, to_state, connection)
{
	if(!isdefined(self.enemy) || !self seerecently(self.enemy, 1.5))
	{
		return 100;
	}
	return 0;
}

/*
	Name: state_unaware_update
	Namespace: auto_turret
	Checksum: 0x887A3656
	Offset: 0xD30
	Size: 0x268
	Parameters: 1
	Flags: None
*/
function state_unaware_update(params)
{
	self endon(#"death");
	self endon(#"change_state");
	turret_left = 1;
	relativeangle = 0;
	self thread turret_idle_sound();
	self playsound(#"mpl_turret_startup");
	self turretcleartarget(0);
	while(true)
	{
		rotscale = self.settings.scanning_speedscale;
		if(!isdefined(rotscale))
		{
			rotscale = 0.01;
		}
		self.turretrotscale = rotscale;
		scanning_arc = self.settings.scanning_arc;
		if(!isdefined(scanning_arc))
		{
			scanning_arc = 0;
		}
		limits = self getturretlimitsyaw();
		scanning_arc = min(scanning_arc, limits[0] - 0.1);
		scanning_arc = min(scanning_arc, limits[1] - 0.1);
		if(scanning_arc > 179)
		{
			if(self.turretontarget)
			{
				relativeangle = relativeangle + 90;
				if(relativeangle > 180)
				{
					relativeangle = relativeangle - 360;
				}
			}
			scanning_arc = relativeangle;
		}
		else if(self.turretontarget)
		{
			turret_left = !turret_left;
		}
		if(!turret_left)
		{
			scanning_arc = scanning_arc * -1;
		}
		scanning_pitch = self.settings.scanning_pitch;
		if(!isdefined(scanning_pitch))
		{
			scanning_pitch = 0;
		}
		self turretsettargetangles(0, (scanning_pitch, scanning_arc, 0));
		self vehicle_ai::evaluate_connections();
		wait(0.5);
	}
}

/*
	Name: should_switch_to_combat
	Namespace: auto_turret
	Checksum: 0x709649B5
	Offset: 0xFA0
	Size: 0x70
	Parameters: 3
	Flags: None
*/
function should_switch_to_combat(current_state, to_state, connection)
{
	if(isdefined(self.enemy) && isalive(self.enemy) && self cansee(self.enemy))
	{
		return 100;
	}
	return 0;
}

/*
	Name: function_f2d20a04
	Namespace: auto_turret
	Checksum: 0xFDF3E6D3
	Offset: 0x1018
	Size: 0x3E8
	Parameters: 1
	Flags: None
*/
function function_f2d20a04(params)
{
	self endon(#"death");
	self endon(#"change_state");
	if(isdefined(self.enemy))
	{
		sentry_turret_alert_sound();
		wait(0.5);
	}
	while(true)
	{
		if(isdefined(self.enemy) && self cansee(self.enemy))
		{
			self.turretrotscale = 1;
			if(isdefined(self.enemy) && self haspart("tag_minigun_spin"))
			{
				self turretsettarget(0, self.enemy);
				self setturretspinning(1);
				wait(0.5);
			}
			for(i = 0; i < 3; i++)
			{
				if(isdefined(self.enemy) && isalive(self.enemy) && self cansee(self.enemy))
				{
					self turretsettarget(0, self.enemy);
					wait(0.1);
					waittime = randomfloatrange(self.settings.var_ddd34f14, self.settings.var_80f38c52);
					if(self.settings.disablefiring !== 1)
					{
						self sentry_turret_fire_for_time(waittime, self.enemy);
					}
					else
					{
						wait(waittime);
					}
				}
				if(isdefined(self.enemy) && isplayer(self.enemy))
				{
					wait(randomfloatrange(self.settings.var_77e64d20, self.settings.var_d4e8eb34));
					continue;
				}
				wait(randomfloatrange(self.settings.var_dd6ae92f, self.settings.var_be5db78d));
			}
			self setturretspinning(0);
			if(isdefined(self.enemy) && isalive(self.enemy) && self cansee(self.enemy))
			{
				if(isplayer(self.enemy))
				{
					wait(randomfloatrange(0.5, 1.3));
				}
				else
				{
					wait(randomfloatrange(0.5, 1.3) * 2);
				}
			}
		}
		self vehicle_ai::evaluate_connections();
		if(isdefined(self.var_4578b9df) && isdefined(self.var_b7bc4c2f))
		{
			n_cooldown_time = randomfloatrange(self.var_4578b9df, self.var_b7bc4c2f);
		}
		else
		{
			n_cooldown_time = 0.5;
		}
		wait(n_cooldown_time);
	}
}

/*
	Name: state_combat_exit
	Namespace: auto_turret
	Checksum: 0xC32E2CCF
	Offset: 0x1408
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function state_combat_exit(params)
{
	self setturretspinning(0);
}

/*
	Name: sentry_turret_fire_for_time
	Namespace: auto_turret
	Checksum: 0xC48F7FA5
	Offset: 0x1438
	Size: 0x104
	Parameters: 2
	Flags: None
*/
function sentry_turret_fire_for_time(totalfiretime, enemy)
{
	self endon(#"death");
	self endon(#"change_state");
	sentry_turret_alert_sound();
	wait(0.1);
	weapon = self seatgetweapon(0);
	firetime = weapon.firetime;
	time = 0;
	is_minigun = 0;
	while(time < totalfiretime)
	{
		self fireweapon(0, enemy);
		wait(firetime);
		time = time + firetime;
	}
	if(is_minigun)
	{
		self setturretspinning(0);
	}
}

/*
	Name: state_off_enter
	Namespace: auto_turret
	Checksum: 0x86C3F675
	Offset: 0x1548
	Size: 0x54
	Parameters: 1
	Flags: None
*/
function state_off_enter(params)
{
	self vehicle_ai::defaultstate_off_enter(params);
	self.turretrotscale = 0.5;
	self rest_turret(params.resting_pitch);
}

/*
	Name: state_off_exit
	Namespace: auto_turret
	Checksum: 0x6750D844
	Offset: 0x15A8
	Size: 0x54
	Parameters: 1
	Flags: None
*/
function state_off_exit(params)
{
	self vehicle_ai::defaultstate_off_exit(params);
	self.turretrotscale = 1;
	self playsound(#"mpl_turret_startup");
}

/*
	Name: rest_turret
	Namespace: auto_turret
	Checksum: 0xD0D3C94D
	Offset: 0x1608
	Size: 0x94
	Parameters: 1
	Flags: None
*/
function rest_turret(resting_pitch = 0)
{
	angles = self gettagangles("tag_turret") - self.angles;
	self turretsettargetangles(0, (resting_pitch, angles[1], 0));
}

/*
	Name: state_emped_enter
	Namespace: auto_turret
	Checksum: 0xA476CFA8
	Offset: 0x16A8
	Size: 0x154
	Parameters: 1
	Flags: None
*/
function state_emped_enter(params)
{
	self vehicle_ai::defaultstate_emped_enter(params);
	playsoundatposition(#"veh_sentry_turret_emp_down", self.origin);
	self.turretrotscale = 0.5;
	self rest_turret(params.resting_pitch);
	params.laseron = islaseron(self);
	self laseroff();
	self vehicle::lights_off();
	if(!isdefined(self.abnormal_status))
	{
		self.abnormal_status = spawnstruct();
	}
	self.abnormal_status.emped = 1;
	self.abnormal_status.attacker = params.param1;
	self.abnormal_status.inflictor = params.param2;
	self vehicle::toggle_emp_fx(1);
}

/*
	Name: state_emped_update
	Namespace: auto_turret
	Checksum: 0xF74F496A
	Offset: 0x1808
	Size: 0x14C
	Parameters: 1
	Flags: None
*/
function state_emped_update(params)
{
	self endon(#"death");
	self endon(#"change_state");
	time = params.param0;
	/#
		assert(isdefined(time));
	#/
	util::cooldown("emped_timer", time);
	while(!util::iscooldownready("emped_timer"))
	{
		timeleft = max(util::getcooldownleft("emped_timer"), 0.5);
		wait(timeleft);
	}
	self.abnormal_status.emped = 0;
	self vehicle::toggle_emp_fx(0);
	self vehicle_ai::emp_startup_fx();
	self rest_turret(0);
	wait(1);
	self vehicle_ai::evaluate_connections();
}

/*
	Name: state_emped_exit
	Namespace: auto_turret
	Checksum: 0x9A9A84C8
	Offset: 0x1960
	Size: 0x54
	Parameters: 1
	Flags: None
*/
function state_emped_exit(params)
{
	self vehicle_ai::defaultstate_emped_exit(params);
	self.turretrotscale = 1;
	self playsound(#"mpl_turret_startup");
}

/*
	Name: state_scripted_update
	Namespace: auto_turret
	Checksum: 0xB13777AD
	Offset: 0x19C0
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function state_scripted_update(params)
{
	self.turretrotscale = 1;
}

/*
	Name: turretallowfriendlyfiredamage
	Namespace: auto_turret
	Checksum: 0x8CC8EB55
	Offset: 0x19E8
	Size: 0xD6
	Parameters: 4
	Flags: None
*/
function turretallowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon)
{
	if(isdefined(self.owner) && eattacker == self.owner && isdefined(self.settings.friendly_fire) && int(self.settings.friendly_fire) && !weapon.isemp)
	{
		return 1;
	}
	if(isdefined(eattacker) && isdefined(eattacker.archetype) && isdefined(smeansofdeath) && smeansofdeath == "MOD_EXPLOSIVE")
	{
		return 1;
	}
	return 0;
}

/*
	Name: turretcallback_vehicledamage
	Namespace: auto_turret
	Checksum: 0x1283AE36
	Offset: 0x1AC8
	Size: 0xD2
	Parameters: 15
	Flags: None
*/
function turretcallback_vehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal)
{
	idamage = vehicle_ai::shared_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
	return idamage;
}

/*
	Name: sentry_turret_alert_sound
	Namespace: auto_turret
	Checksum: 0x4EABFC09
	Offset: 0x1BA8
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function sentry_turret_alert_sound()
{
	self playsound(#"veh_turret_alert");
}

/*
	Name: turret_idle_sound
	Namespace: auto_turret
	Checksum: 0xC3119396
	Offset: 0x1BD8
	Size: 0x94
	Parameters: 0
	Flags: None
*/
function turret_idle_sound()
{
	if(!isdefined(self.sndloop_ent))
	{
		self.sndloop_ent = spawn("script_origin", self.origin);
		self.sndloop_ent linkto(self);
		self.sndloop_ent playloopsound(#"veh_turret_idle");
		self.sndloop_ent thread function_5d665d67(self);
	}
}

/*
	Name: function_862359b8
	Namespace: auto_turret
	Checksum: 0x3EDDBA13
	Offset: 0x1C78
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function function_862359b8()
{
	self endon(#"death");
	if(isdefined(self))
	{
		self stoploopsound(0.5);
		wait(2);
		if(isdefined(self))
		{
			self delete();
		}
	}
}

/*
	Name: function_5d665d67
	Namespace: auto_turret
	Checksum: 0x4D8A9A04
	Offset: 0x1CE0
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function function_5d665d67(turret)
{
	self endon(#"death");
	turret waittill(#"death");
	self function_862359b8();
}

/*
	Name: turret_idle_sound_stop
	Namespace: auto_turret
	Checksum: 0xF9634717
	Offset: 0x1D38
	Size: 0x3C
	Parameters: 0
	Flags: None
*/
function turret_idle_sound_stop()
{
	self endon(#"death");
	if(isdefined(self.sndloop_ent))
	{
		self.sndloop_ent function_862359b8();
	}
}

/*
	Name: function_3dda565d
	Namespace: auto_turret
	Checksum: 0xAB7AFF32
	Offset: 0x1D80
	Size: 0x44
	Parameters: 1
	Flags: None
*/
function function_3dda565d(params)
{
	if(isdefined(self.vehicletype) && (isdefined(self.var_37e3fb9c) && self.var_37e3fb9c))
	{
		self influencers::remove_influencers();
	}
}

