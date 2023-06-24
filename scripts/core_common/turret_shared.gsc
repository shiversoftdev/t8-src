// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\vehicleriders_shared.gsc;

#namespace turret;

/*
	Name: __init__system__
	Namespace: turret
	Checksum: 0x4C7C43AE
	Offset: 0x2C0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"turret", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: turret
	Checksum: 0xFCD986F3
	Offset: 0x308
	Size: 0x4E
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("vehicle", "toggle_lensflare", 1, 1, "int");
	level._turrets = spawnstruct();
}

/*
	Name: get_weapon
	Namespace: turret
	Checksum: 0x3D0ADBF9
	Offset: 0x360
	Size: 0x5A
	Parameters: 1
	Flags: Linked
*/
function get_weapon(n_index = 0)
{
	if(!isalive(self))
	{
		return level.weaponnone;
	}
	w_weapon = self seatgetweapon(n_index);
	return w_weapon;
}

/*
	Name: get_parent
	Namespace: turret
	Checksum: 0xC096F671
	Offset: 0x3C8
	Size: 0x2A
	Parameters: 1
	Flags: None
*/
function get_parent(n_index)
{
	return _get_turret_data(n_index).e_parent;
}

/*
	Name: laser_death_watcher
	Namespace: turret
	Checksum: 0xD934A1F8
	Offset: 0x400
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function laser_death_watcher()
{
	self notify(#"laser_death_thread_stop");
	self endon(#"laser_death_thread_stop");
	self waittill(#"death");
	if(isdefined(self))
	{
		self laseroff();
	}
}

/*
	Name: enable_laser
	Namespace: turret
	Checksum: 0x3645CF9A
	Offset: 0x460
	Size: 0xA6
	Parameters: 2
	Flags: None
*/
function enable_laser(b_enable, n_index)
{
	if(b_enable)
	{
		_get_turret_data(n_index).has_laser = 1;
		self laseron();
		self thread laser_death_watcher();
	}
	else
	{
		_get_turret_data(n_index).has_laser = undefined;
		self laseroff();
		self notify(#"laser_death_thread_stop");
	}
}

/*
	Name: watch_for_flash
	Namespace: turret
	Checksum: 0xDF1F675B
	Offset: 0x510
	Size: 0xAA
	Parameters: 0
	Flags: Linked
*/
function watch_for_flash()
{
	self endon(#"watch_for_flash_and_stun", #"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"flashbang");
		self notify(#"damage", {#weapon:"flash_grenade", #attacker:waitresult.attacker, #amount:1});
	}
}

/*
	Name: watch_for_flash_and_stun
	Namespace: turret
	Checksum: 0xAFFA479C
	Offset: 0x5C8
	Size: 0xFA
	Parameters: 1
	Flags: Linked
*/
function watch_for_flash_and_stun(n_index)
{
	self notify(#"watch_for_flash_and_stun_end");
	self endon(#"watch_for_flash_and_stun", #"death");
	self thread watch_for_flash();
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		if(waitresult.weapon.dostun)
		{
			if(isdefined(self.stunned))
			{
				continue;
			}
			self.stunned = 1;
			stop(n_index, 1);
			wait(randomfloatrange(5, 7));
			self.stunned = undefined;
		}
	}
}

/*
	Name: emp_watcher
	Namespace: turret
	Checksum: 0x80105F35
	Offset: 0x6D0
	Size: 0x148
	Parameters: 1
	Flags: Linked
*/
function emp_watcher(n_index)
{
	self notify(#"emp_thread_stop");
	self endon(#"emp_thread_stop", #"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		if(waitresult.weapon.isemp)
		{
			if(isdefined(self.emped))
			{
				continue;
			}
			self.emped = 1;
			if(isdefined(_get_turret_data(n_index).has_laser))
			{
				self laseroff();
			}
			stop(n_index, 1);
			wait(randomfloatrange(5, 7));
			self.emped = undefined;
			if(isdefined(_get_turret_data(n_index).has_laser))
			{
				self laseron();
			}
		}
	}
}

/*
	Name: enable_emp
	Namespace: turret
	Checksum: 0x14ABCC2E
	Offset: 0x820
	Size: 0x86
	Parameters: 2
	Flags: None
*/
function enable_emp(b_enable, n_index)
{
	if(b_enable)
	{
		_get_turret_data(n_index).can_emp = 1;
		self thread emp_watcher(n_index);
	}
	else
	{
		_get_turret_data(n_index).can_emp = undefined;
		self notify(#"emp_thread_stop");
	}
}

/*
	Name: set_team
	Namespace: turret
	Checksum: 0x593AB284
	Offset: 0x8B0
	Size: 0x3E
	Parameters: 2
	Flags: Linked
*/
function set_team(str_team, n_index)
{
	_get_turret_data(n_index).str_team = str_team;
	self.team = str_team;
}

/*
	Name: get_team
	Namespace: turret
	Checksum: 0x82D68A71
	Offset: 0x8F8
	Size: 0x66
	Parameters: 1
	Flags: None
*/
function get_team(n_index)
{
	str_team = undefined;
	s_turret = _get_turret_data(n_index);
	str_team = self.team;
	if(!isdefined(s_turret.str_team))
	{
		s_turret.str_team = str_team;
	}
	return str_team;
}

/*
	Name: is_turret_enabled
	Namespace: turret
	Checksum: 0x436D5550
	Offset: 0x968
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function is_turret_enabled(n_index)
{
	return _get_turret_data(n_index).is_enabled;
}

/*
	Name: does_need_user
	Namespace: turret
	Checksum: 0xF6100C34
	Offset: 0x9A0
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function does_need_user(n_index)
{
	return isdefined(_get_turret_data(n_index).b_needs_user) && _get_turret_data(n_index).b_needs_user;
}

/*
	Name: does_have_user
	Namespace: turret
	Checksum: 0xDEF6431B
	Offset: 0x9F8
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function does_have_user(n_index)
{
	return isalive(get_user(n_index));
}

/*
	Name: get_user
	Namespace: turret
	Checksum: 0xF882E4D7
	Offset: 0xA38
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function get_user(n_index)
{
	return self getseatoccupant(n_index);
}

/*
	Name: _set_turret_needs_user
	Namespace: turret
	Checksum: 0x11C2D81F
	Offset: 0xA68
	Size: 0x8A
	Parameters: 2
	Flags: Linked
*/
function _set_turret_needs_user(n_index, b_needs_user)
{
	s_turret = _get_turret_data(n_index);
	if(b_needs_user)
	{
		s_turret.b_needs_user = 1;
		self thread watch_for_flash_and_stun(n_index);
	}
	else
	{
		self notify(#"watch_for_flash_and_stun_end");
		s_turret.b_needs_user = 0;
	}
}

/*
	Name: _wait_for_current_user_to_finish
	Namespace: turret
	Checksum: 0x4948FADA
	Offset: 0xB00
	Size: 0x50
	Parameters: 1
	Flags: None
*/
function _wait_for_current_user_to_finish(n_index)
{
	self endon(#"death");
	while(isalive(get_user(n_index)))
	{
		waitframe(1);
	}
}

/*
	Name: is_current_user
	Namespace: turret
	Checksum: 0x12D9C88
	Offset: 0xB58
	Size: 0x5A
	Parameters: 2
	Flags: None
*/
function is_current_user(ai_user, n_index)
{
	ai_current_user = get_user(n_index);
	return isalive(ai_current_user) && ai_user == ai_current_user;
}

/*
	Name: set_burst_parameters
	Namespace: turret
	Checksum: 0x993CCBDE
	Offset: 0xBC0
	Size: 0x8E
	Parameters: 5
	Flags: None
*/
function set_burst_parameters(n_fire_min, n_fire_max, n_wait_min, n_wait_max, n_index)
{
	s_turret = _get_turret_data(n_index);
	s_turret.n_burst_fire_min = n_fire_min;
	s_turret.n_burst_fire_max = n_fire_max;
	s_turret.n_burst_wait_min = n_wait_min;
	s_turret.n_burst_wait_max = n_wait_max;
}

/*
	Name: set_torso_targetting
	Namespace: turret
	Checksum: 0xBBEB7D39
	Offset: 0xC58
	Size: 0x56
	Parameters: 2
	Flags: Linked
*/
function set_torso_targetting(n_index, n_torso_targetting_offset = -12)
{
	s_turret = _get_turret_data(n_index);
	s_turret.n_torso_targetting_offset = n_torso_targetting_offset;
}

/*
	Name: set_target_leading
	Namespace: turret
	Checksum: 0x3040AA17
	Offset: 0xCB8
	Size: 0x56
	Parameters: 2
	Flags: Linked
*/
function set_target_leading(n_index, n_target_leading_factor = 0.1)
{
	s_turret = _get_turret_data(n_index);
	s_turret.n_target_leading_factor = n_target_leading_factor;
}

/*
	Name: set_on_target_angle
	Namespace: turret
	Checksum: 0xE7C7D72A
	Offset: 0xD18
	Size: 0x6C
	Parameters: 2
	Flags: Linked
*/
function set_on_target_angle(n_angle, n_index)
{
	s_turret = _get_turret_data(n_index);
	if(!isdefined(n_angle))
	{
		if(s_turret.str_guidance_type != "none")
		{
			n_angle = 10;
		}
		else
		{
			n_angle = 2;
		}
	}
}

/*
	Name: set_target
	Namespace: turret
	Checksum: 0x462EEBE8
	Offset: 0xD90
	Size: 0xF2
	Parameters: 3
	Flags: Linked
*/
function set_target(e_target, v_offset, n_index)
{
	self endon(#"death");
	s_turret = _get_turret_data(n_index);
	if(!isdefined(v_offset))
	{
		v_offset = _get_default_target_offset(e_target, n_index);
	}
	if(!isdefined(n_index) || n_index == 0)
	{
		self turretsettarget(0, e_target, v_offset);
	}
	else
	{
		self turretsettarget(n_index, e_target, v_offset);
	}
	s_turret.e_target = e_target;
	s_turret.e_last_target = e_target;
	s_turret.v_offset = v_offset;
}

/*
	Name: _get_default_target_offset
	Namespace: turret
	Checksum: 0x3D65DE5D
	Offset: 0xE90
	Size: 0x286
	Parameters: 2
	Flags: Linked
*/
function _get_default_target_offset(e_target, n_index)
{
	s_turret = _get_turret_data(n_index);
	if(s_turret.str_weapon_type == "bullet")
	{
		if(isdefined(e_target))
		{
			if(isplayer(e_target))
			{
				z_offset = randomintrange(40, 50);
			}
			else
			{
				if(e_target.type === "human")
				{
					z_offset = randomintrange(20, 60);
				}
				else
				{
					if(e_target.type === "robot")
					{
						z_offset = randomintrange(40, 60);
					}
					else if(issentient(self) && issentient(e_target))
					{
						z_offset = (isvehicle(e_target) ? 0 : (isdefined(s_turret.n_torso_targetting_offset) ? s_turret.n_torso_targetting_offset : 0));
					}
				}
			}
			if(isdefined(e_target.z_target_offset_override))
			{
				if(!isdefined(z_offset))
				{
					z_offset = 0;
				}
				z_offset = z_offset + e_target.z_target_offset_override;
			}
		}
	}
	if(!isdefined(z_offset))
	{
		z_offset = 0;
	}
	v_offset = (0, 0, z_offset);
	if((isdefined(s_turret.n_target_leading_factor) ? s_turret.n_target_leading_factor : 0) != 0 && isdefined(e_target) && issentient(self) && issentient(e_target) && !isvehicle(e_target))
	{
		velocity = e_target getvelocity();
		v_offset = v_offset + (velocity * s_turret.n_target_leading_factor);
	}
	return v_offset;
}

/*
	Name: get_target
	Namespace: turret
	Checksum: 0xC502C007
	Offset: 0x1120
	Size: 0xB2
	Parameters: 1
	Flags: Linked
*/
function get_target(n_index)
{
	if(isdefined(_get_turret_data(n_index).e_target) && (isdefined(_get_turret_data(n_index).e_target.ignoreme) && _get_turret_data(n_index).e_target.ignoreme))
	{
		clear_target(n_index);
	}
	return _get_turret_data(n_index).e_target;
}

/*
	Name: is_target
	Namespace: turret
	Checksum: 0x6441951B
	Offset: 0x11E0
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function is_target(e_target, n_index)
{
	e_current_target = get_target(n_index);
	if(isdefined(e_current_target))
	{
		return e_current_target == e_target;
	}
	return 0;
}

/*
	Name: clear_target
	Namespace: turret
	Checksum: 0xA261652C
	Offset: 0x1238
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function clear_target(n_index)
{
	s_turret = _get_turret_data(n_index);
	s_turret flag::clear("turret manual");
	s_turret.e_next_target = undefined;
	s_turret.e_target = undefined;
	if(!isdefined(n_index) || n_index == 0)
	{
		self turretcleartarget(0);
	}
	else
	{
		self turretcleartarget(n_index);
	}
}

/*
	Name: set_min_target_distance_squared
	Namespace: turret
	Checksum: 0x51E53702
	Offset: 0x12F0
	Size: 0x46
	Parameters: 2
	Flags: None
*/
function set_min_target_distance_squared(n_distance_squared, n_index)
{
	s_turret = _get_turret_data(n_index);
	s_turret.n_min_target_distance_squared = n_distance_squared;
}

/*
	Name: fire
	Namespace: turret
	Checksum: 0x70093A68
	Offset: 0x1340
	Size: 0x15A
	Parameters: 1
	Flags: Linked
*/
function fire(n_index)
{
	s_turret = _get_turret_data(n_index);
	/#
		assert(isdefined(n_index) && n_index >= 0, "");
	#/
	if(n_index == 0)
	{
		self fireweapon(0, s_turret.e_target);
	}
	else
	{
		ai_current_user = get_user(n_index);
		if(isdefined(ai_current_user) && (isdefined(ai_current_user.is_disabled) && ai_current_user.is_disabled))
		{
			return;
		}
		if(isdefined(s_turret.e_target))
		{
			self turretsettarget(n_index, s_turret.e_target, s_turret.v_offset);
		}
		self fireweapon(n_index, s_turret.e_target, s_turret.v_offset, s_turret.e_parent);
	}
	s_turret.n_last_fire_time = gettime();
}

/*
	Name: stop
	Namespace: turret
	Checksum: 0x27BCC625
	Offset: 0x14A8
	Size: 0xB8
	Parameters: 2
	Flags: Linked
*/
function stop(n_index, b_clear_target = 0)
{
	s_turret = _get_turret_data(n_index);
	s_turret.e_next_target = undefined;
	s_turret.e_target = undefined;
	s_turret flag::clear("turret manual");
	if(b_clear_target)
	{
		clear_target(n_index);
	}
	self notify("_stop_turret" + _index(n_index));
}

/*
	Name: fire_for_time
	Namespace: turret
	Checksum: 0x23AAF71C
	Offset: 0x1568
	Size: 0x1B8
	Parameters: 2
	Flags: Linked
*/
function fire_for_time(n_time, n_index = 0)
{
	/#
		assert(isdefined(n_time), "");
	#/
	self endon(#"death", #"drone_death", "_stop_turret" + _index(n_index), "turret_disabled" + _index(n_index));
	self notify("_fire_turret_for_time" + _index(n_index));
	self endon("_fire_turret_for_time" + _index(n_index));
	b_fire_forever = 0;
	if(n_time < 0)
	{
		b_fire_forever = 1;
	}
	else
	{
		/#
			w_weapon = get_weapon(n_index);
			assert(n_time >= w_weapon.firetime, (("" + n_time) + "") + w_weapon.firetime);
		#/
		/#
		#/
	}
	while(n_time > 0 || b_fire_forever)
	{
		n_burst_time = _burst_fire(n_time, n_index);
		if(!b_fire_forever)
		{
			n_time = n_time - n_burst_time;
		}
	}
}

/*
	Name: shoot_at_target
	Namespace: turret
	Checksum: 0x66EC6AB3
	Offset: 0x1728
	Size: 0xF4
	Parameters: 5
	Flags: Linked
*/
function shoot_at_target(e_target, n_time, v_offset, n_index, b_just_once)
{
	/#
		assert(isdefined(e_target), "");
	#/
	self endon(#"drone_death", #"death");
	s_turret = _get_turret_data(n_index);
	s_turret flag::set("turret manual");
	_shoot_turret_at_target(e_target, n_time, v_offset, n_index, b_just_once);
	s_turret flag::clear("turret manual");
}

/*
	Name: _shoot_turret_at_target
	Namespace: turret
	Checksum: 0xC9E4C4DE
	Offset: 0x1828
	Size: 0x174
	Parameters: 5
	Flags: Linked
*/
function _shoot_turret_at_target(e_target, n_time, v_offset, n_index, b_just_once)
{
	self endon(#"drone_death", #"death", "_stop_turret" + _index(n_index), "turret_disabled" + _index(n_index));
	self notify("_shoot_turret_at_target" + _index(n_index));
	self endon("_shoot_turret_at_target" + _index(n_index));
	if(n_time == -1)
	{
		e_target endon(#"death");
	}
	if(!isdefined(b_just_once))
	{
		b_just_once = 0;
	}
	set_target(e_target, v_offset, n_index);
	if(!isdefined(self.aim_only_no_shooting))
	{
		_waittill_turret_on_target(e_target, n_index);
		if(b_just_once)
		{
			fire(n_index);
		}
		else
		{
			fire_for_time(n_time, n_index);
		}
	}
}

/*
	Name: _waittill_turret_on_target
	Namespace: turret
	Checksum: 0x5713DCB8
	Offset: 0x19A8
	Size: 0xA2
	Parameters: 2
	Flags: Linked
*/
function _waittill_turret_on_target(e_target, n_index)
{
	do
	{
		wait((isdefined(self.waittill_turret_on_target_delay) ? self.waittill_turret_on_target_delay : 0.5));
		if(!isdefined(n_index) || n_index == 0)
		{
			self waittill(#"turret_on_target");
		}
		else
		{
			self waittill(#"gunner_turret_on_target");
		}
	}
	while(isdefined(e_target) && !can_hit_target(e_target, n_index));
}

/*
	Name: shoot_at_target_once
	Namespace: turret
	Checksum: 0xFACBE260
	Offset: 0x1A58
	Size: 0x44
	Parameters: 3
	Flags: None
*/
function shoot_at_target_once(e_target, v_offset, n_index)
{
	shoot_at_target(e_target, 0, v_offset, n_index, 1);
}

/*
	Name: enable
	Namespace: turret
	Checksum: 0x758E261B
	Offset: 0x1AA8
	Size: 0xFC
	Parameters: 3
	Flags: Linked
*/
function enable(n_index, b_user_required, v_offset)
{
	if(isalive(self) && !is_turret_enabled(n_index))
	{
		_get_turret_data(n_index).is_enabled = 1;
		self thread _turret_think(n_index, v_offset);
		self notify("turret_enabled" + _index(n_index));
		if(isdefined(b_user_required) && !b_user_required)
		{
			_set_turret_needs_user(n_index, 0);
		}
		else
		{
			_set_turret_needs_user(n_index, 1);
		}
	}
}

/*
	Name: enable_auto_use
	Namespace: turret
	Checksum: 0xDAC9F67D
	Offset: 0x1BB0
	Size: 0x2A
	Parameters: 1
	Flags: None
*/
function enable_auto_use(b_enable = 1)
{
	self.script_auto_use = b_enable;
}

/*
	Name: disable_ai_getoff
	Namespace: turret
	Checksum: 0x7254919D
	Offset: 0x1BE8
	Size: 0x42
	Parameters: 2
	Flags: None
*/
function disable_ai_getoff(n_index, b_disable = 1)
{
	_get_turret_data(n_index).disable_ai_getoff = b_disable;
}

/*
	Name: disable
	Namespace: turret
	Checksum: 0xA2294072
	Offset: 0x1C38
	Size: 0x90
	Parameters: 1
	Flags: Linked
*/
function disable(n_index)
{
	if(is_turret_enabled(n_index))
	{
		_drop_turret(n_index);
		clear_target(n_index);
		_get_turret_data(n_index).is_enabled = 0;
		self notify("turret_disabled" + _index(n_index));
	}
}

/*
	Name: pause
	Namespace: turret
	Checksum: 0xDF1A4F1B
	Offset: 0x1CD0
	Size: 0xC4
	Parameters: 2
	Flags: None
*/
function pause(time, n_index)
{
	s_turret = _get_turret_data(n_index);
	if(time > 0)
	{
		time = int(time * 1000);
	}
	if(isdefined(s_turret.pause))
	{
		s_turret.pause_time = s_turret.pause_time + time;
	}
	else
	{
		s_turret.pause = 1;
		s_turret.pause_time = time;
		stop(n_index);
	}
}

/*
	Name: unpause
	Namespace: turret
	Checksum: 0x24E46EB2
	Offset: 0x1DA0
	Size: 0x3A
	Parameters: 1
	Flags: None
*/
function unpause(n_index)
{
	s_turret = _get_turret_data(n_index);
	s_turret.pause = undefined;
}

/*
	Name: _turret_think
	Namespace: turret
	Checksum: 0x8B6C0047
	Offset: 0x1DE8
	Size: 0x496
	Parameters: 2
	Flags: Linked
*/
function _turret_think(n_index, v_offset)
{
	turret_think_time = max(1.5, get_weapon(n_index).firetime);
	no_target_start_time = 0;
	self endon(#"death", "turret_disabled" + _index(n_index));
	self notify("_turret_think" + _index(n_index));
	self endon("_turret_think" + _index(n_index));
	/#
		self thread _debug_turret_think(n_index);
	#/
	self thread _turret_health_monitor(n_index);
	s_turret = _get_turret_data(n_index);
	if(isdefined(s_turret.has_laser))
	{
		self laseron();
	}
	while(true)
	{
		s_turret flag::wait_till_clear("turret manual");
		n_time_now = gettime();
		if(self _check_for_paused(n_index) || isdefined(self.emped) || isdefined(self.stunned))
		{
			wait(turret_think_time);
			continue;
		}
		if(!isdefined(s_turret.e_target) || s_turret.e_target.health < 0)
		{
			stop(n_index);
		}
		e_original_next_target = s_turret.e_next_target;
		s_turret.e_next_target = _get_best_target(n_index);
		if(isdefined(s_turret.e_next_target))
		{
			no_target_start_time = 0;
			if(_user_check(n_index))
			{
				self thread _shoot_turret_at_target(s_turret.e_next_target, turret_think_time, v_offset, n_index);
				if(s_turret.e_next_target !== e_original_next_target)
				{
					self notify(#"has_new_target", {#target:s_turret.e_next_target});
				}
			}
		}
		else
		{
			if(!isdefined(self.do_not_clear_targets_during_think) || !self.do_not_clear_targets_during_think)
			{
				clear_target(n_index);
			}
			if(no_target_start_time == 0)
			{
				no_target_start_time = n_time_now;
			}
			target_wait_time = n_time_now - no_target_start_time;
			if(isdefined(s_turret.occupy_no_target_time))
			{
				occupy_time = s_turret.occupy_no_target_time;
			}
			else
			{
				occupy_time = 3600;
			}
			if(!(isdefined(s_turret.disable_ai_getoff) && s_turret.disable_ai_getoff))
			{
				bwasplayertarget = isdefined(s_turret.e_last_target) && s_turret.e_last_target.health > 0 && isplayer(s_turret.e_last_target);
				if(bwasplayertarget)
				{
					occupy_time = occupy_time / 4;
				}
			}
			else
			{
				bwasplayertarget = 0;
			}
			if(target_wait_time >= occupy_time)
			{
				_drop_turret(n_index, !bwasplayertarget);
			}
		}
		if(!(isdefined(s_turret.disable_ai_getoff) && s_turret.disable_ai_getoff) && _has_nearby_player_enemy(n_index, self))
		{
			_drop_turret(n_index, 0);
		}
		wait(turret_think_time);
	}
}

/*
	Name: _turret_health_monitor
	Namespace: turret
	Checksum: 0x5DEF2A2F
	Offset: 0x2288
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function _turret_health_monitor(n_index)
{
	self endon(#"death");
	waitframe(1);
	_turret_health_monitor_loop(n_index);
	self disable(n_index);
}

/*
	Name: _turret_health_monitor_loop
	Namespace: turret
	Checksum: 0xC30AF2A3
	Offset: 0x22E8
	Size: 0x88
	Parameters: 1
	Flags: Linked
*/
function _turret_health_monitor_loop(n_index)
{
	self endon(#"death", "turret_disabled" + _index(n_index));
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"broken");
		if(waitresult.type === ("turret_destroyed_" + n_index))
		{
			return;
		}
	}
}

/*
	Name: _has_nearby_player_enemy
	Namespace: turret
	Checksum: 0x45B6F9F7
	Offset: 0x2378
	Size: 0x1D6
	Parameters: 2
	Flags: Linked
*/
function _has_nearby_player_enemy(index, turret)
{
	has_nearby_enemy = 0;
	time = gettime();
	ai_user = turret get_user(index);
	if(!isdefined(ai_user))
	{
		return has_nearby_enemy;
	}
	if(!isdefined(turret.next_nearby_enemy_time))
	{
		turret.next_nearby_enemy_time = time;
	}
	if(time >= turret.next_nearby_enemy_time)
	{
		players = getplayers();
		foreach(player in players)
		{
			if(!util::function_fbce7263(turret.team, player.team))
			{
				continue;
			}
			if((abs(ai_user.origin[2] - player.origin[2])) <= 60 && distance2dsquared(ai_user.origin, player.origin) <= (300 * 300))
			{
				has_nearby_enemy = 1;
				break;
			}
		}
		turret.next_nearby_enemy_time = time + 1000;
	}
	return has_nearby_enemy;
}

/*
	Name: _listen_for_damage_on_actor
	Namespace: turret
	Checksum: 0xF5CD1848
	Offset: 0x2558
	Size: 0x11A
	Parameters: 2
	Flags: None
*/
function _listen_for_damage_on_actor(ai_user, n_index)
{
	self endon(#"death");
	ai_user endon(#"death");
	self endon("turret_disabled" + _index(n_index), "_turret_think" + _index(n_index), #"exit_vehicle");
	while(true)
	{
		waitresult = undefined;
		waitresult = ai_user waittill(#"damage");
		s_turret = _get_turret_data(n_index);
		if(isdefined(s_turret))
		{
			if(!isdefined(s_turret.e_next_target) && !isdefined(s_turret.e_target))
			{
				s_turret.e_last_target = waitresult.attacker;
			}
		}
	}
}

/*
	Name: _waittill_user_change
	Namespace: turret
	Checksum: 0x78D6C8A6
	Offset: 0x2680
	Size: 0xD4
	Parameters: 1
	Flags: None
*/
function _waittill_user_change(n_index)
{
	ai_user = self getseatoccupant(n_index);
	if(isalive(ai_user))
	{
		if(isactor(ai_user))
		{
			ai_user endon(#"death");
		}
		else if(util::function_8e89351(ai_user))
		{
			self notify("turret_disabled" + _index(n_index));
		}
	}
	self util::waittill_either("exit_vehicle", "enter_vehicle");
}

/*
	Name: _check_for_paused
	Namespace: turret
	Checksum: 0xA937CE4
	Offset: 0x2760
	Size: 0xB8
	Parameters: 1
	Flags: Linked
*/
function _check_for_paused(n_index)
{
	s_turret = _get_turret_data(n_index);
	s_turret.pause_start_time = gettime();
	while(isdefined(s_turret.pause))
	{
		if(s_turret.pause_time > 0)
		{
			time = gettime();
			paused_time = time - s_turret.pause_start_time;
			if(paused_time > s_turret.pause_time)
			{
				s_turret.pause = undefined;
				return true;
			}
		}
		waitframe(1);
	}
	return false;
}

/*
	Name: _drop_turret
	Namespace: turret
	Checksum: 0xFF3F0426
	Offset: 0x2820
	Size: 0xDC
	Parameters: 2
	Flags: Linked
*/
function _drop_turret(n_index, bexitifautomatedonly)
{
	ai_user = get_user(n_index);
	if(isalive(ai_user) && !isbot(ai_user) && !isplayer(ai_user) && (isdefined(ai_user.turret_auto_use) && ai_user.turret_auto_use || (!(isdefined(bexitifautomatedonly) && bexitifautomatedonly))))
	{
		vehicle::get_out(self, ai_user, "gunner1");
	}
}

/*
	Name: does_have_target
	Namespace: turret
	Checksum: 0xF2283D6
	Offset: 0x2908
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function does_have_target(n_index)
{
	return isdefined(_get_turret_data(n_index).e_next_target);
}

/*
	Name: _user_check
	Namespace: turret
	Checksum: 0xE7D0E6F0
	Offset: 0x2940
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function _user_check(n_index)
{
	s_turret = _get_turret_data(n_index);
	if(does_need_user(n_index))
	{
		b_has_user = does_have_user(n_index);
		return b_has_user;
	}
	return 1;
}

/*
	Name: _debug_turret_think
	Namespace: turret
	Checksum: 0x42443A91
	Offset: 0x29C0
	Size: 0x31E
	Parameters: 1
	Flags: None
*/
function _debug_turret_think(n_index)
{
	/#
		self endon(#"death", "" + _index(n_index), "" + _index(n_index));
		s_turret = _get_turret_data(n_index);
		v_color = (0, 0, 1);
		while(true)
		{
			if(!getdvarint(#"g_debugturrets", 0))
			{
				wait(0.2);
				continue;
			}
			has_target = isdefined(get_target(n_index));
			if(does_need_user(n_index) && !does_have_user(n_index) || !has_target)
			{
				v_color = (1, 1, 0);
			}
			else
			{
				v_color = (0, 1, 0);
			}
			str_team = get_team(n_index);
			if(!isdefined(str_team))
			{
				str_team = "";
			}
			str_target = "";
			e_target = s_turret.e_next_target;
			if(isdefined(e_target))
			{
				if(isactor(e_target))
				{
					str_target = str_target + "";
				}
				else
				{
					if(isplayer(e_target))
					{
						str_target = str_target + "";
					}
					else
					{
						if(isvehicle(e_target))
						{
							str_target = str_target + "";
						}
						else
						{
							if(isdefined(e_target.targetname) && e_target.targetname == "")
							{
								str_target = str_target + "";
							}
							else if(isdefined(e_target.classname))
							{
								str_target = str_target + e_target.classname;
							}
						}
					}
				}
			}
			else
			{
				str_target = str_target + "";
			}
			str_debug = (((self getentnum() + "") + str_team) + "") + str_target;
			record3dtext(str_debug, self.origin, v_color, "", self);
			waitframe(1);
		}
	#/
}

/*
	Name: _get_turret_data
	Namespace: turret
	Checksum: 0xB2DC4554
	Offset: 0x2CE8
	Size: 0x92
	Parameters: 1
	Flags: Linked
*/
function _get_turret_data(n_index)
{
	s_turret = undefined;
	if(isvehicle(self))
	{
		if(isdefined(self.a_turrets) && isdefined(self.a_turrets[n_index]))
		{
			s_turret = self.a_turrets[n_index];
		}
	}
	else
	{
		s_turret = self._turret;
	}
	if(!isdefined(s_turret))
	{
		s_turret = _init_turret(n_index);
	}
	return s_turret;
}

/*
	Name: has_turret
	Namespace: turret
	Checksum: 0x2CE37226
	Offset: 0x2D88
	Size: 0x34
	Parameters: 1
	Flags: None
*/
function has_turret(n_index)
{
	if(isdefined(self.a_turrets) && isdefined(self.a_turrets[n_index]))
	{
		return true;
	}
	return false;
}

/*
	Name: _update_turret_arcs
	Namespace: turret
	Checksum: 0x4CB4CBE0
	Offset: 0x2DC8
	Size: 0xAE
	Parameters: 1
	Flags: Linked
*/
function _update_turret_arcs(n_index)
{
	s_turret = _get_turret_data(n_index);
	s_turret.rightarc = s_turret.w_weapon.rightarc;
	s_turret.leftarc = s_turret.w_weapon.leftarc;
	s_turret.toparc = s_turret.w_weapon.toparc;
	s_turret.bottomarc = s_turret.w_weapon.bottomarc;
}

/*
	Name: _init_turret
	Namespace: turret
	Checksum: 0x400F1E24
	Offset: 0x2E80
	Size: 0x1B0
	Parameters: 1
	Flags: Linked
*/
function _init_turret(n_index = 0)
{
	self endon(#"death");
	w_weapon = get_weapon(n_index);
	if(w_weapon.name == #"none")
	{
		/#
			assertmsg("");
		#/
		return;
	}
	util::waittill_asset_loaded("xmodel", self.model);
	s_turret = _init_vehicle_turret(n_index);
	s_turret.w_weapon = w_weapon;
	_update_turret_arcs(n_index);
	s_turret.is_enabled = 0;
	s_turret.e_parent = self;
	s_turret.e_target = undefined;
	s_turret.b_ignore_line_of_sight = 0;
	s_turret.v_offset = (0, 0, 0);
	s_turret.n_burst_fire_time = 0;
	s_turret.str_weapon_type = w_weapon.type;
	s_turret.str_guidance_type = w_weapon.guidedmissiletype;
	set_on_target_angle(undefined, n_index);
	s_turret flag::init("turret manual");
	return s_turret;
}

/*
	Name: _init_vehicle_turret
	Namespace: turret
	Checksum: 0x6889C107
	Offset: 0x3038
	Size: 0x250
	Parameters: 1
	Flags: Linked
*/
function _init_vehicle_turret(n_index)
{
	/#
		assert(isdefined(n_index) && n_index >= 0, "");
	#/
	s_turret = spawnstruct();
	switch(n_index)
	{
		case 0:
		{
			s_turret.str_tag_flash = "tag_flash";
			s_turret.str_tag_pivot = "tag_barrel";
			break;
		}
		case 1:
		{
			s_turret.str_tag_flash = "tag_gunner_flash1";
			s_turret.str_tag_pivot = "tag_gunner_barrel1";
			break;
		}
		case 2:
		{
			s_turret.str_tag_flash = "tag_gunner_flash2";
			s_turret.str_tag_pivot = "tag_gunner_barrel2";
			break;
		}
		case 3:
		{
			s_turret.str_tag_flash = "tag_gunner_flash3";
			s_turret.str_tag_pivot = "tag_gunner_barrel3";
			break;
		}
		case 4:
		{
			s_turret.str_tag_flash = "tag_gunner_flash4";
			s_turret.str_tag_pivot = "tag_gunner_barrel4";
			break;
		}
	}
	if(self.vehicleclass === "helicopter")
	{
		s_turret.e_trace_ignore = self;
	}
	if(!isdefined(self.a_turrets))
	{
		self.a_turrets = [];
	}
	self.a_turrets[n_index] = s_turret;
	if(n_index > 0)
	{
		tag_origin = self gettagorigin(_get_gunner_tag_for_turret_index(n_index));
		if(isdefined(tag_origin))
		{
			_set_turret_needs_user(n_index, 1);
		}
	}
	return s_turret;
}

/*
	Name: _burst_fire
	Namespace: turret
	Checksum: 0x6A927691
	Offset: 0x3290
	Size: 0x1F2
	Parameters: 2
	Flags: Linked
*/
function _burst_fire(n_max_time, n_index)
{
	self endon(#"terminate_all_turrets_firing");
	if(n_max_time < 0)
	{
		n_max_time = 9999;
	}
	s_turret = _get_turret_data(n_index);
	n_burst_time = _get_burst_fire_time(n_index);
	n_burst_wait = _get_burst_wait_time(n_index);
	if(!isdefined(n_burst_time) || n_burst_time > n_max_time)
	{
		n_burst_time = n_max_time;
	}
	if(s_turret.n_burst_fire_time >= n_burst_time)
	{
		s_turret.n_burst_fire_time = 0;
		n_time_since_last_shot = (float(gettime() - s_turret.n_last_fire_time)) / 1000;
		if(n_time_since_last_shot < n_burst_wait)
		{
			wait(n_burst_wait - n_time_since_last_shot);
		}
	}
	else
	{
		n_burst_time = n_burst_time - s_turret.n_burst_fire_time;
	}
	w_weapon = get_weapon(n_index);
	n_fire_time = w_weapon.firetime;
	n_total_time = 0;
	while(n_total_time < n_burst_time)
	{
		fire(n_index);
		n_total_time = n_total_time + n_fire_time;
		s_turret.n_burst_fire_time = s_turret.n_burst_fire_time + n_fire_time;
		wait(n_fire_time);
	}
	if(n_burst_wait > 0)
	{
		wait(n_burst_wait);
	}
	return n_burst_time + n_burst_wait;
}

/*
	Name: _get_burst_fire_time
	Namespace: turret
	Checksum: 0xAD8BD058
	Offset: 0x3490
	Size: 0xF2
	Parameters: 1
	Flags: Linked
*/
function _get_burst_fire_time(n_index)
{
	s_turret = _get_turret_data(n_index);
	n_time = undefined;
	if(isdefined(s_turret.n_burst_fire_min) && isdefined(s_turret.n_burst_fire_max))
	{
		if(s_turret.n_burst_fire_min == s_turret.n_burst_fire_max)
		{
			n_time = s_turret.n_burst_fire_min;
		}
		else
		{
			n_time = randomfloatrange(s_turret.n_burst_fire_min, s_turret.n_burst_fire_max);
		}
	}
	else if(isdefined(s_turret.n_burst_fire_max))
	{
		n_time = randomfloatrange(0, s_turret.n_burst_fire_max);
	}
	return n_time;
}

/*
	Name: _get_burst_wait_time
	Namespace: turret
	Checksum: 0xCAC5077
	Offset: 0x3590
	Size: 0xF2
	Parameters: 1
	Flags: Linked
*/
function _get_burst_wait_time(n_index)
{
	s_turret = _get_turret_data(n_index);
	n_time = 0;
	if(isdefined(s_turret.n_burst_wait_min) && isdefined(s_turret.n_burst_wait_max))
	{
		if(s_turret.n_burst_wait_min == s_turret.n_burst_wait_max)
		{
			n_time = s_turret.n_burst_wait_min;
		}
		else
		{
			n_time = randomfloatrange(s_turret.n_burst_wait_min, s_turret.n_burst_wait_max);
		}
	}
	else if(isdefined(s_turret.n_burst_wait_max))
	{
		n_time = randomfloatrange(0, s_turret.n_burst_wait_max);
	}
	return n_time;
}

/*
	Name: _index
	Namespace: turret
	Checksum: 0xF5F33DDD
	Offset: 0x3690
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function _index(n_index)
{
	return (isdefined(n_index) ? "" + n_index : "");
}

/*
	Name: _get_best_target
	Namespace: turret
	Checksum: 0xE5BFAE35
	Offset: 0x36C8
	Size: 0xE6
	Parameters: 1
	Flags: Linked
*/
function _get_best_target(n_index)
{
	e_best_target = undefined;
	self util::function_c596f193();
	switch(n_index)
	{
		case 0:
		{
			e_best_target = self.enemy;
			break;
		}
		case 1:
		{
			e_best_target = self.gunner1enemy;
			break;
		}
		case 2:
		{
			e_best_target = self.gunner2enemy;
			break;
		}
		case 3:
		{
			e_best_target = self.gunner3enemy;
			break;
		}
		case 4:
		{
			e_best_target = self.gunner4enemy;
			break;
		}
	}
	return e_best_target;
}

/*
	Name: can_hit_target
	Namespace: turret
	Checksum: 0xB2F1A1AA
	Offset: 0x37B8
	Size: 0x16A
	Parameters: 2
	Flags: Linked
*/
function can_hit_target(e_target, n_index)
{
	s_turret = _get_turret_data(n_index);
	v_offset = _get_default_target_offset(e_target, n_index);
	b_current_target = is_target(e_target, n_index);
	if(isdefined(e_target) && (isdefined(e_target.ignoreme) && e_target.ignoreme))
	{
		return 0;
	}
	b_trace_passed = 1;
	if(!s_turret.b_ignore_line_of_sight)
	{
		b_trace_passed = trace_test(e_target, v_offset - (0, 0, (isvehicle(e_target) ? 0 : (isdefined(s_turret.n_torso_targetting_offset) ? s_turret.n_torso_targetting_offset : 0))), n_index);
	}
	if(b_current_target && !b_trace_passed && !isdefined(s_turret.n_time_lose_sight))
	{
		s_turret.n_time_lose_sight = gettime();
	}
	return b_trace_passed;
}

/*
	Name: trace_test
	Namespace: turret
	Checksum: 0x5A53A8C5
	Offset: 0x3930
	Size: 0x28E
	Parameters: 3
	Flags: Linked
*/
function trace_test(e_target, v_offset = (0, 0, 0), n_index)
{
	if(isdefined(self.good_old_style_turret_tracing))
	{
		s_turret = _get_turret_data(n_index);
		v_start_org = self gettagorigin(s_turret.str_tag_pivot);
		if(e_target sightconetrace(v_start_org, self) > 0.2)
		{
			v_target = e_target.origin + v_offset;
			v_start_org = v_start_org + ((vectornormalize(v_target - v_start_org)) * 50);
			a_trace = bullettrace(v_start_org, v_target, 1, s_turret.e_trace_ignore, 0, 1);
			if(a_trace[#"fraction"] > 0.6)
			{
				return true;
			}
		}
		return false;
	}
	s_turret = _get_turret_data(n_index);
	v_start_org = self gettagorigin(s_turret.str_tag_pivot);
	v_target = e_target.origin + v_offset;
	if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame() && isplayer(e_target))
	{
		v_target = e_target getshootatpos();
	}
	if(distancesquared(v_start_org, v_target) < 10000)
	{
		return true;
	}
	v_dir_to_target = vectornormalize(v_target - v_start_org);
	v_start_org = v_start_org + (v_dir_to_target * 50);
	v_target = v_target - (v_dir_to_target * 75);
	if(sighttracepassed(v_start_org, v_target, 0, self, e_target))
	{
		return true;
	}
	return false;
}

/*
	Name: set_ignore_line_of_sight
	Namespace: turret
	Checksum: 0xBB58C08E
	Offset: 0x3BC8
	Size: 0x46
	Parameters: 2
	Flags: None
*/
function set_ignore_line_of_sight(b_ignore, n_index)
{
	s_turret = _get_turret_data(n_index);
	s_turret.b_ignore_line_of_sight = b_ignore;
}

/*
	Name: set_occupy_no_target_time
	Namespace: turret
	Checksum: 0xD67F117B
	Offset: 0x3C18
	Size: 0x46
	Parameters: 2
	Flags: None
*/
function set_occupy_no_target_time(time, n_index)
{
	s_turret = _get_turret_data(n_index);
	s_turret.occupy_no_target_time = time;
}

/*
	Name: toggle_lensflare
	Namespace: turret
	Checksum: 0x95320DCA
	Offset: 0x3C68
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function toggle_lensflare(bool)
{
	self clientfield::set("toggle_lensflare", bool);
}

/*
	Name: track_lens_flare
	Namespace: turret
	Checksum: 0xC156A4DE
	Offset: 0x3CA0
	Size: 0x15C
	Parameters: 0
	Flags: None
*/
function track_lens_flare()
{
	self endon(#"death");
	self notify(#"disable_lens_flare");
	self endon(#"disable_lens_flare");
	while(true)
	{
		e_target = self turretgettarget(0);
		if(self.turretontarget && (isdefined(e_target) && isplayer(e_target)))
		{
			if(isdefined(self gettagorigin("TAG_LASER")))
			{
				e_target util::waittill_player_looking_at(self gettagorigin("TAG_LASER"), 90);
				if(isdefined(e_target))
				{
					self toggle_lensflare(1);
					e_target util::waittill_player_not_looking_at(self gettagorigin("TAG_LASER"));
				}
				self toggle_lensflare(0);
			}
		}
		wait(0.5);
	}
}

/*
	Name: _get_gunner_tag_for_turret_index
	Namespace: turret
	Checksum: 0xBDB19F1F
	Offset: 0x3E08
	Size: 0xAA
	Parameters: 1
	Flags: Linked
*/
function _get_gunner_tag_for_turret_index(n_index)
{
	switch(n_index)
	{
		case 1:
		{
			return "tag_gunner1";
		}
		case 2:
		{
			return "tag_gunner2";
		}
		case 3:
		{
			return "tag_gunner3";
		}
		case 4:
		{
			return "tag_gunner4";
		}
		default:
		{
			/#
				assertmsg("");
			#/
		}
	}
}

