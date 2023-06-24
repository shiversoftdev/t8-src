// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_4c5c4a64a59247a2;
#using script_59f07c660e6710a5;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\colors_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;

#namespace ai;

/*
	Name: set_pacifist
	Namespace: ai
	Checksum: 0x4332BD5E
	Offset: 0x2F8
	Size: 0x4A
	Parameters: 1
	Flags: None
*/
function set_pacifist(val)
{
	/#
		assert(issentient(self), "");
	#/
	self.pacifist = val;
}

/*
	Name: disable_pain
	Namespace: ai
	Checksum: 0x3DB0A3EB
	Offset: 0x350
	Size: 0x3E
	Parameters: 0
	Flags: Linked
*/
function disable_pain()
{
	/#
		assert(isalive(self), "");
	#/
	self.allowpain = 0;
}

/*
	Name: enable_pain
	Namespace: ai
	Checksum: 0x167E16CB
	Offset: 0x398
	Size: 0x42
	Parameters: 0
	Flags: Linked
*/
function enable_pain()
{
	/#
		assert(isalive(self), "");
	#/
	self.allowpain = 1;
}

/*
	Name: gun_remove
	Namespace: ai
	Checksum: 0x2384F092
	Offset: 0x3E8
	Size: 0x3A
	Parameters: 0
	Flags: Linked
*/
function gun_remove()
{
	self shared::placeweaponon(self.weapon, "none");
	self.gun_removed = 1;
}

/*
	Name: gun_switchto
	Namespace: ai
	Checksum: 0x3B8D4CBF
	Offset: 0x430
	Size: 0x2C
	Parameters: 2
	Flags: Linked
*/
function gun_switchto(weapon, whichhand)
{
	self shared::placeweaponon(weapon, whichhand);
}

/*
	Name: gun_recall
	Namespace: ai
	Checksum: 0x5AF21EC7
	Offset: 0x468
	Size: 0x36
	Parameters: 0
	Flags: Linked
*/
function gun_recall()
{
	self shared::placeweaponon(self.primaryweapon, "right");
	self.gun_removed = undefined;
}

/*
	Name: set_behavior_attribute
	Namespace: ai
	Checksum: 0x84462FF5
	Offset: 0x4A8
	Size: 0xAC
	Parameters: 2
	Flags: Linked
*/
function set_behavior_attribute(attribute, value)
{
	if(isdefined(level.b_gmodifier_only_humans) && level.b_gmodifier_only_humans || (isdefined(level.b_gmodifier_only_robots) && level.b_gmodifier_only_robots))
	{
		if(has_behavior_attribute(attribute))
		{
			setaiattribute(self, attribute, value);
		}
	}
	else
	{
		setaiattribute(self, attribute, value);
	}
}

/*
	Name: get_behavior_attribute
	Namespace: ai
	Checksum: 0x2DACFB20
	Offset: 0x560
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function get_behavior_attribute(attribute)
{
	return getaiattribute(self, attribute);
}

/*
	Name: has_behavior_attribute
	Namespace: ai
	Checksum: 0xE8915617
	Offset: 0x590
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function has_behavior_attribute(attribute)
{
	return hasaiattribute(self, attribute);
}

/*
	Name: is_dead_sentient
	Namespace: ai
	Checksum: 0x69588695
	Offset: 0x5C0
	Size: 0x46
	Parameters: 0
	Flags: Linked
*/
function is_dead_sentient()
{
	if(issentient(self) && !isalive(self))
	{
		return true;
	}
	return false;
}

/*
	Name: waittill_dead
	Namespace: ai
	Checksum: 0x2CCE341B
	Offset: 0x610
	Size: 0x1F8
	Parameters: 3
	Flags: Linked
*/
function waittill_dead(guys, num, timeoutlength)
{
	allalive = 1;
	for(i = 0; i < guys.size; i++)
	{
		if(isalive(guys[i]))
		{
			continue;
		}
		allalive = 0;
		break;
	}
	/#
		assert(allalive, "");
	#/
	if(!allalive)
	{
		newarray = [];
		for(i = 0; i < guys.size; i++)
		{
			if(isalive(guys[i]))
			{
				newarray[newarray.size] = guys[i];
			}
		}
		guys = newarray;
	}
	ent = spawnstruct();
	if(isdefined(timeoutlength))
	{
		ent endon(#"thread_timed_out");
		ent thread waittill_dead_timeout(timeoutlength);
	}
	ent.count = guys.size;
	if(isdefined(num) && num < ent.count)
	{
		ent.count = num;
	}
	array::thread_all(guys, &waittill_dead_thread, ent);
	while(ent.count > 0)
	{
		ent waittill(#"waittill_dead guy died");
	}
}

/*
	Name: waittill_dead_or_dying
	Namespace: ai
	Checksum: 0x30728A53
	Offset: 0x810
	Size: 0x178
	Parameters: 3
	Flags: None
*/
function waittill_dead_or_dying(guys, num, timeoutlength)
{
	newarray = [];
	for(i = 0; i < guys.size; i++)
	{
		if(isalive(guys[i]))
		{
			newarray[newarray.size] = guys[i];
		}
	}
	guys = newarray;
	ent = spawnstruct();
	if(isdefined(timeoutlength))
	{
		ent endon(#"thread_timed_out");
		ent thread waittill_dead_timeout(timeoutlength);
	}
	ent.count = guys.size;
	if(isdefined(num) && num < ent.count)
	{
		ent.count = num;
	}
	array::thread_all(guys, &waittill_dead_or_dying_thread, ent);
	while(ent.count > 0)
	{
		ent waittill(#"waittill_dead_guy_dead_or_dying");
	}
}

/*
	Name: waittill_dead_thread
	Namespace: ai
	Checksum: 0x942B5254
	Offset: 0x990
	Size: 0x48
	Parameters: 1
	Flags: Linked, Private
*/
function private waittill_dead_thread(ent)
{
	self waittill(#"death");
	ent.count--;
	ent notify(#"waittill_dead guy died");
}

/*
	Name: waittill_dead_or_dying_thread
	Namespace: ai
	Checksum: 0xB08F5631
	Offset: 0x9E0
	Size: 0x58
	Parameters: 1
	Flags: Linked
*/
function waittill_dead_or_dying_thread(ent)
{
	self util::waittill_either("death", "pain_death");
	ent.count--;
	ent notify(#"waittill_dead_guy_dead_or_dying");
}

/*
	Name: waittill_dead_timeout
	Namespace: ai
	Checksum: 0x413A5C28
	Offset: 0xA40
	Size: 0x26
	Parameters: 1
	Flags: Linked
*/
function waittill_dead_timeout(timeoutlength)
{
	wait(timeoutlength);
	self notify(#"thread_timed_out");
}

/*
	Name: wait_for_shoot
	Namespace: ai
	Checksum: 0x3973E06D
	Offset: 0xA70
	Size: 0x8E
	Parameters: 0
	Flags: Linked, Private
*/
function private wait_for_shoot()
{
	self endon(#"stop_shoot_at_target", #"death");
	if(isvehicle(self) || isbot(self))
	{
		self waittill(#"weapon_fired");
	}
	else
	{
		self waittill(#"shoot");
	}
	self.start_duration_comp = 1;
}

/*
	Name: shoot_at_target
	Namespace: ai
	Checksum: 0x227037BF
	Offset: 0xB08
	Size: 0x3E4
	Parameters: 6
	Flags: None
*/
function shoot_at_target(mode, target, tag, duration, sethealth, ignorefirstshotwait)
{
	self endon(#"death", #"stop_shoot_at_target");
	/#
		assert(isdefined(target), "");
	#/
	/#
		assert(isdefined(mode), "");
	#/
	mode_flag = mode === "normal" || mode === "shoot_until_target_dead" || mode === "kill_within_time";
	/#
		assert(mode_flag, "");
	#/
	if(isdefined(duration))
	{
		/#
			assert(duration >= 0, "");
		#/
	}
	else
	{
		duration = 0;
	}
	if(isdefined(sethealth) && isdefined(target))
	{
		target.health = sethealth;
	}
	if(!isdefined(target) || (mode === "shoot_until_target_dead" && target.health <= 0))
	{
		return;
	}
	if(isdefined(tag) && tag != "")
	{
		self setentitytarget(target, 1, tag);
	}
	else
	{
		self setentitytarget(target, 1);
	}
	self.start_duration_comp = 0;
	switch(mode)
	{
		case "normal":
		{
			break;
		}
		case "shoot_until_target_dead":
		{
			duration = -1;
			break;
		}
		case "kill_within_time":
		{
			target damagemode("next_shot_kills");
			break;
		}
	}
	if(isvehicle(self))
	{
		self util::clearallcooldowns();
	}
	if(ignorefirstshotwait === 1)
	{
		self.start_duration_comp = 1;
	}
	else
	{
		self thread wait_for_shoot();
	}
	if(isdefined(duration) && isdefined(target) && target.health > 0)
	{
		if(duration >= 0)
		{
			elapsed = 0;
			while(isdefined(target) && target.health > 0 && elapsed <= duration)
			{
				elapsed = elapsed + 0.05;
				if(!(isdefined(self.start_duration_comp) && self.start_duration_comp))
				{
					elapsed = 0;
				}
				waitframe(1);
			}
			if(isdefined(target) && mode == "kill_within_time")
			{
				self.perfectaim = 1;
				self.aim_set_by_shoot_at_target = 1;
				target waittill(#"death");
			}
		}
		else if(duration == -1)
		{
			target waittill(#"death");
		}
	}
	stop_shoot_at_target();
}

/*
	Name: stop_shoot_at_target
	Namespace: ai
	Checksum: 0x8EB3DCDB
	Offset: 0xEF8
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function stop_shoot_at_target()
{
	self clearentitytarget();
	if(isdefined(self.aim_set_by_shoot_at_target) && self.aim_set_by_shoot_at_target)
	{
		self.perfectaim = 0;
		self.aim_set_by_shoot_at_target = 0;
	}
	self notify(#"stop_shoot_at_target");
}

/*
	Name: wait_until_done_speaking
	Namespace: ai
	Checksum: 0x97C39A68
	Offset: 0xF60
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function wait_until_done_speaking()
{
	self endon(#"death");
	while(self.isspeaking)
	{
		waitframe(1);
	}
}

/*
	Name: set_goal
	Namespace: ai
	Checksum: 0xACD6E858
	Offset: 0xF98
	Size: 0x120
	Parameters: 3
	Flags: None
*/
function set_goal(value, key = "targetname", b_force = 0)
{
	goal = getnode(value, key);
	if(isdefined(goal))
	{
		self setgoal(goal, b_force);
	}
	else
	{
		goal = getent(value, key);
		if(isdefined(goal))
		{
			self setgoal(goal, b_force);
		}
		else
		{
			goal = struct::get(value, key);
			if(isdefined(goal))
			{
				self setgoal(goal.origin, b_force);
			}
		}
	}
	return goal;
}

/*
	Name: force_goal
	Namespace: ai
	Checksum: 0xB2DD8A3F
	Offset: 0x10C0
	Size: 0xCC
	Parameters: 5
	Flags: Linked
*/
function force_goal(goto, b_shoot = 1, str_end_on, b_keep_colors = 0, b_should_sprint = 0)
{
	self endon(#"death");
	s_tracker = spawnstruct();
	self thread _force_goal(s_tracker, goto, b_shoot, str_end_on, b_keep_colors, b_should_sprint);
	s_tracker waittill(#"done");
}

/*
	Name: _force_goal
	Namespace: ai
	Checksum: 0xE2045A01
	Offset: 0x1198
	Size: 0x4A0
	Parameters: 6
	Flags: Linked
*/
function _force_goal(s_tracker, goto, b_shoot = 1, str_end_on, b_keep_colors = 0, b_should_sprint = 0)
{
	self endon(#"death");
	self notify(#"new_force_goal");
	flagsys::wait_till_clear("force_goal");
	flagsys::set(#"force_goal");
	color_enabled = 0;
	if(!b_keep_colors)
	{
		if(isdefined(colors::get_force_color()))
		{
			color_enabled = 1;
			self colors::disable();
		}
	}
	allowpain = self.allowpain;
	ignoresuppression = self.ignoresuppression;
	grenadeawareness = self.grenadeawareness;
	if(!b_shoot)
	{
		self val::set(#"ai_forcegoal", "ignoreall", 1);
	}
	else if(self has_behavior_attribute("move_mode"))
	{
		var_a5151bf = self get_behavior_attribute("move_mode");
		self set_behavior_attribute("move_mode", "rambo");
	}
	if(b_should_sprint && self has_behavior_attribute("sprint"))
	{
		self set_behavior_attribute("sprint", 1);
	}
	self.ignoresuppression = 1;
	self.grenadeawareness = 0;
	self val::set(#"ai_forcegoal", "ignoreme", 1);
	self disable_pain();
	if(!isplayer(self))
	{
		self pushplayer(1);
	}
	if(isdefined(goto))
	{
		self setgoal(goto, 1);
	}
	self waittill(#"goal", #"new_force_goal", str_end_on);
	if(color_enabled)
	{
		colors::enable();
	}
	if(!isplayer(self))
	{
		self pushplayer(0);
	}
	self clearforcedgoal();
	self val::reset(#"ai_forcegoal", "ignoreme");
	self val::reset(#"ai_forcegoal", "ignoreall");
	if(isdefined(allowpain) && allowpain)
	{
		self enable_pain();
	}
	if(self has_behavior_attribute("sprint"))
	{
		self set_behavior_attribute("sprint", 0);
	}
	if(isdefined(var_a5151bf))
	{
		self set_behavior_attribute("move_mode", var_a5151bf);
	}
	self.ignoresuppression = ignoresuppression;
	self.grenadeawareness = grenadeawareness;
	flagsys::clear(#"force_goal");
	s_tracker notify(#"done");
}

/*
	Name: stoppainwaitinterval
	Namespace: ai
	Checksum: 0x72E6F44A
	Offset: 0x1640
	Size: 0x16
	Parameters: 0
	Flags: None
*/
function stoppainwaitinterval()
{
	self notify(#"painwaitintervalremove");
}

/*
	Name: _allowpainrestore
	Namespace: ai
	Checksum: 0xC9EF83AD
	Offset: 0x1660
	Size: 0x46
	Parameters: 0
	Flags: Linked, Private
*/
function private _allowpainrestore()
{
	self endon(#"death");
	self waittill(#"painwaitintervalremove", #"painwaitinterval");
	self.allowpain = 1;
}

/*
	Name: painwaitinterval
	Namespace: ai
	Checksum: 0x6E1A3A4C
	Offset: 0x16B0
	Size: 0xF6
	Parameters: 1
	Flags: None
*/
function painwaitinterval(msec)
{
	self endon(#"death");
	self notify(#"painwaitinterval");
	self endon(#"painwaitinterval", #"painwaitintervalremove");
	self thread _allowpainrestore();
	if(!isdefined(msec) || msec < 20)
	{
		msec = 20;
	}
	while(isalive(self))
	{
		self waittill(#"pain");
		self.allowpain = 0;
		wait(float(msec) / 1000);
		self.allowpain = 1;
	}
}

/*
	Name: patrol
	Namespace: ai
	Checksum: 0xD0D28E47
	Offset: 0x17B0
	Size: 0x598
	Parameters: 1
	Flags: None
*/
function patrol(start_path_node)
{
	self endon(#"death", #"stop_patrolling");
	/#
		assert(isdefined(start_path_node), self.targetname + "");
	#/
	if(start_path_node.type === #"bad node")
	{
		/#
			errormsg = (((("" + start_path_node.targetname) + "") + int(start_path_node.origin[0]) + "") + int(start_path_node.origin[1]) + "") + int(start_path_node.origin[2]) + "";
			iprintln(errormsg);
		#/
		return;
	}
	/#
		assert(start_path_node.type === #"path" || isdefined(start_path_node.scriptbundlename), ("" + start_path_node.targetname) + "");
	#/
	self notify(#"go_to_spawner_target");
	self.target = undefined;
	self.old_goal_radius = self.goalradius;
	self.goalradius = 16;
	self thread end_patrol_on_enemy_targetting();
	self.currentgoal = start_path_node;
	self.patroller = 1;
	while(true)
	{
		if(isdefined(self.currentgoal.type) && self.currentgoal.type == "Path")
		{
			if(self has_behavior_attribute("patrol"))
			{
				self set_behavior_attribute("patrol", 1);
			}
			self setgoal(self.currentgoal, 1);
			self waittill(#"goal");
			if(isdefined(self.currentgoal.script_notify))
			{
				self notify(self.currentgoal.script_notify);
				level notify(self.currentgoal.script_notify);
			}
			if(isdefined(self.currentgoal.script_flag_set))
			{
				flag = self.currentgoal.script_flag_set;
				if(!isdefined(level.flag[flag]))
				{
					level flag::init(flag);
				}
				level flag::set(flag);
			}
			if(isdefined(self.currentgoal.script_flag_wait))
			{
				flag = self.currentgoal.script_flag_wait;
				/#
					assert(isdefined(level.flag[flag]), "" + flag);
				#/
				level flag::wait_till(flag);
			}
			if(!isdefined(self.currentgoal.script_wait_min))
			{
				self.currentgoal.script_wait_min = 0;
			}
			if(!isdefined(self.currentgoal.script_wait_max))
			{
				self.currentgoal.script_wait_max = 0;
			}
			/#
				assert(self.currentgoal.script_wait_min <= self.currentgoal.script_wait_max, "" + self.currentgoal.targetname);
			#/
			if(!isdefined(self.currentgoal.scriptbundlename))
			{
				wait_variability = self.currentgoal.script_wait_max - self.currentgoal.script_wait_min;
				wait_time = self.currentgoal.script_wait_min + randomfloat(wait_variability);
				self notify(#"patrol_goal", {#node:self.currentgoal});
				wait(wait_time);
			}
			else
			{
				self scene::play(self.currentgoal.scriptbundlename, self);
			}
		}
		else if(isdefined(self.currentgoal.scriptbundlename))
		{
			self.currentgoal scene::play(self.currentgoal.scriptbundlename, self);
		}
		self patrol_next_node();
	}
}

/*
	Name: patrol_next_node
	Namespace: ai
	Checksum: 0x20DF654
	Offset: 0x1D50
	Size: 0x10A
	Parameters: 0
	Flags: Linked
*/
function patrol_next_node()
{
	target_nodes = [];
	target_scenes = [];
	if(isdefined(self.currentgoal.target))
	{
		target_nodes = getnodearray(self.currentgoal.target, "targetname");
		target_scenes = struct::get_array(self.currentgoal.target, "targetname");
	}
	if(target_nodes.size == 0 && target_scenes.size == 0)
	{
		self end_and_clean_patrol_behaviors();
	}
	else
	{
		if(target_nodes.size != 0)
		{
			self.currentgoal = array::random(target_nodes);
		}
		else
		{
			self.currentgoal = array::random(target_scenes);
		}
	}
}

/*
	Name: end_patrol_on_enemy_targetting
	Namespace: ai
	Checksum: 0xDFDC3ED1
	Offset: 0x1E68
	Size: 0x68
	Parameters: 0
	Flags: Linked
*/
function end_patrol_on_enemy_targetting()
{
	self endon(#"death", #"alerted");
	while(true)
	{
		if(isdefined(self.should_stop_patrolling) && self.should_stop_patrolling)
		{
			self end_and_clean_patrol_behaviors();
		}
		wait(0.1);
	}
}

/*
	Name: end_and_clean_patrol_behaviors
	Namespace: ai
	Checksum: 0x9ABF254F
	Offset: 0x1ED8
	Size: 0xD6
	Parameters: 0
	Flags: Linked
*/
function end_and_clean_patrol_behaviors()
{
	if(isdefined(self.currentgoal) && isdefined(self.currentgoal.scriptbundlename))
	{
		self stopanimscripted();
	}
	if(self has_behavior_attribute("patrol"))
	{
		self set_behavior_attribute("patrol", 0);
	}
	if(isdefined(self.old_goal_radius))
	{
		self.goalradius = self.old_goal_radius;
	}
	self clearforcedgoal();
	self notify(#"stop_patrolling");
	self.patroller = undefined;
	self notify(#"alerted");
}

/*
	Name: bloody_death
	Namespace: ai
	Checksum: 0x16151B6D
	Offset: 0x1FB8
	Size: 0x2BC
	Parameters: 2
	Flags: None
*/
function bloody_death(n_delay, hit_loc)
{
	self endon(#"death");
	if(!isdefined(self))
	{
		return;
	}
	/#
		assert(isactor(self));
	#/
	/#
		assert(isalive(self));
	#/
	if(isdefined(self.__bloody_death) && self.__bloody_death)
	{
		return;
	}
	self.__bloody_death = 1;
	if(isdefined(n_delay))
	{
		wait(n_delay);
	}
	if(!isdefined(self) || !isalive(self))
	{
		return;
	}
	if(isdefined(hit_loc))
	{
		/#
			assert(isinarray(array("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""), hit_loc), "");
		#/
	}
	else
	{
		hit_loc = array::random(array("helmet", "head", "neck", "torso_upper", "torso_mid", "torso_lower", "right_arm_upper", "left_arm_upper", "right_arm_lower", "left_arm_lower", "right_hand", "left_hand", "right_leg_upper", "left_leg_upper", "right_leg_lower", "left_leg_lower", "right_foot", "left_foot", "gun", "riotshield"));
	}
	self dodamage(self.health + 100, self.origin, undefined, undefined, hit_loc);
}

/*
	Name: shouldregisterclientfieldforarchetype
	Namespace: ai
	Checksum: 0x1A2B21E0
	Offset: 0x2280
	Size: 0x52
	Parameters: 1
	Flags: None
*/
function shouldregisterclientfieldforarchetype(archetype)
{
	if(isdefined(level.clientfieldaicheck) && level.clientfieldaicheck && !isarchetypeloaded(archetype))
	{
		return false;
	}
	return true;
}

/*
	Name: set_protect_ent
	Namespace: ai
	Checksum: 0x23548FD5
	Offset: 0x22E0
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function set_protect_ent(entity)
{
	if(!isdefined(entity.protect_tactical_influencer) && sessionmodeiscampaigngame())
	{
		teammask = util::getteammask(self.team);
		entity.protect_tactical_influencer = createtacticalinfluencer("protect_entity_influencer_def", entity, teammask);
	}
	self.protectent = entity;
	if(isactor(self))
	{
		self setblackboardattribute("_defend", "defend_enabled");
	}
}

/*
	Name: set_group_protect_ent
	Namespace: ai
	Checksum: 0xD1954C28
	Offset: 0x23B8
	Size: 0x10C
	Parameters: 2
	Flags: None
*/
function set_group_protect_ent(e_ent_to_protect, defend_volume_name_or_ent)
{
	a_defenders = self;
	if(!isdefined(a_defenders))
	{
		a_defenders = [];
	}
	else if(!isarray(a_defenders))
	{
		a_defenders = array(a_defenders);
	}
	if(isstring(defend_volume_name_or_ent))
	{
		vol_defend = getent(defend_volume_name_or_ent, "targetname");
	}
	else if(isentity(defend_volume_name_or_ent))
	{
		vol_defend = defend_volume_name_or_ent;
	}
	array::run_all(a_defenders, &setgoal, vol_defend, 1);
	array::thread_all(a_defenders, &set_protect_ent, e_ent_to_protect);
}

/*
	Name: remove_protect_ent
	Namespace: ai
	Checksum: 0x8F0A619F
	Offset: 0x24D0
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function remove_protect_ent()
{
	self.protectent = undefined;
	if(isactor(self))
	{
		self setblackboardattribute("_defend", "defend_disabled");
	}
}

/*
	Name: t_cylinder
	Namespace: ai
	Checksum: 0x641DA8BC
	Offset: 0x2528
	Size: 0x9A
	Parameters: 3
	Flags: Linked
*/
function t_cylinder(origin, radius, halfheight)
{
	struct = spawnstruct();
	struct.type = 1;
	struct.origin = origin;
	struct.radius = float(radius);
	struct.halfheight = float(halfheight);
	return struct;
}

/*
	Name: function_470c0597
	Namespace: ai
	Checksum: 0x5CDBA6B9
	Offset: 0x25D0
	Size: 0xF2
	Parameters: 3
	Flags: Linked
*/
function function_470c0597(center, halfsize, angles)
{
	/#
		assert(isvec(center));
	#/
	/#
		assert(isvec(halfsize));
	#/
	/#
		assert(isvec(angles));
	#/
	struct = spawnstruct();
	struct.type = 2;
	struct.center = center;
	struct.halfsize = halfsize;
	struct.angles = angles;
	return struct;
}

/*
	Name: function_c2ee22a3
	Namespace: ai
	Checksum: 0xB08EC032
	Offset: 0x26D0
	Size: 0x19C
	Parameters: 1
	Flags: None
*/
function function_c2ee22a3(active)
{
	self endon(#"death");
	if(active === 1)
	{
		self clearenemy();
		self.var_62376916 = 1;
		if(self has_behavior_attribute("patrol"))
		{
			self set_behavior_attribute("patrol", 1);
		}
		fov = 0.7;
		var_672a1bab = 1000000;
		self function_aa4579e2(fov, var_672a1bab);
		while(isdefined(self) && self.var_62376916 === 1 && !isdefined(self.enemy))
		{
			wait(0.25);
		}
	}
	self.var_62376916 = 0;
	if(self has_behavior_attribute("patrol"))
	{
		self set_behavior_attribute("patrol", 0);
	}
	fov = 0;
	var_672a1bab = 64000000;
	if(isdefined(self.sightdistance))
	{
		var_672a1bab = self.sightdistance * self.sightdistance;
	}
	self function_aa4579e2(0, 64000000);
}

/*
	Name: function_aa4579e2
	Namespace: ai
	Checksum: 0x5370A5CD
	Offset: 0x2878
	Size: 0x2E
	Parameters: 2
	Flags: Linked
*/
function function_aa4579e2(fovcosine, maxsightdistsqrd)
{
	self.fovcosine = fovcosine;
	self.maxsightdistsqrd = maxsightdistsqrd;
}

/*
	Name: function_1628d95b
	Namespace: ai
	Checksum: 0xF0DA50E8
	Offset: 0x28B0
	Size: 0x270
	Parameters: 3
	Flags: Linked
*/
function function_1628d95b(cansee = 0, var_9a21f98d = 1, var_2dd9c403 = self.origin)
{
	var_56203bf4 = function_4d8c71ce(util::get_enemy_team(self.team), #"team3");
	nearesttarget = undefined;
	var_46e1d165 = undefined;
	foreach(target in var_56203bf4)
	{
		if(!isalive(target) || (isdefined(target.var_becd4d91) && target.var_becd4d91) || target function_41b04632())
		{
			continue;
		}
		if(cansee && var_9a21f98d)
		{
			if(!self cansee(target))
			{
				continue;
			}
		}
		else if(cansee && !var_9a21f98d)
		{
			targetpoint = (isdefined(target.var_88f8feeb) ? target.var_88f8feeb : target getcentroid());
			if(!sighttracepassed(self geteye(), targetpoint, 0, target))
			{
				continue;
			}
		}
		distsq = distancesquared(var_2dd9c403, target.origin);
		if(!isdefined(nearesttarget) || distsq < var_46e1d165)
		{
			nearesttarget = target;
			var_46e1d165 = distsq;
		}
	}
	return nearesttarget;
}

/*
	Name: function_31a31a25
	Namespace: ai
	Checksum: 0xF4C0A12E
	Offset: 0x2B28
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function function_31a31a25(var_9a21f98d = 1)
{
	return function_1628d95b(1, var_9a21f98d);
}

/*
	Name: function_41b04632
	Namespace: ai
	Checksum: 0x501DBA3F
	Offset: 0x2B68
	Size: 0x48
	Parameters: 0
	Flags: Linked
*/
function function_41b04632()
{
	return isdefined(self.targetname) && self.targetname == "destructible" && !isdefined(getent(self.target, "targetname"));
}

/*
	Name: function_63734291
	Namespace: ai
	Checksum: 0x4CE51463
	Offset: 0x2BB8
	Size: 0x110
	Parameters: 1
	Flags: None
*/
function function_63734291(enemy)
{
	if(!isdefined(enemy))
	{
		return false;
	}
	var_aba9ee4c = 1;
	if(isdefined(self.var_ffa507cd))
	{
		var_e1ea86de = self.var_ffa507cd;
		if(var_e1ea86de < randomfloat(1))
		{
			var_aba9ee4c = 0;
		}
	}
	if(var_aba9ee4c && isvehicle(enemy) && (!(isdefined(enemy.var_c95dcb15) && enemy.var_c95dcb15)))
	{
		dist_squared = distancesquared(self.origin, enemy.origin);
		if(dist_squared >= 562500)
		{
			enemy notify(#"hash_4853a85e5ddc4a47");
			return true;
		}
	}
	return false;
}

/*
	Name: stun
	Namespace: ai
	Checksum: 0x67C7FDA9
	Offset: 0x2CD0
	Size: 0xD6
	Parameters: 1
	Flags: Linked
*/
function stun(duration = self.var_95d94ac4)
{
	if(!isdefined(duration) || (!(isdefined(self.var_28aab32a) && self.var_28aab32a)) || (isdefined(self.var_c2986b66) && self.var_c2986b66) || (isdefined(self.var_b736fc8b) && self.var_b736fc8b))
	{
		return;
	}
	end_time = gettime() + (int(duration * 1000));
	if(isdefined(self.var_3d461e6f) && self.var_3d461e6f > end_time)
	{
		return;
	}
	self.var_3d461e6f = end_time;
}

/*
	Name: is_stunned
	Namespace: ai
	Checksum: 0x69B5623A
	Offset: 0x2DB0
	Size: 0x1E
	Parameters: 0
	Flags: Linked
*/
function is_stunned()
{
	return isdefined(self.var_3d461e6f) && gettime() < self.var_3d461e6f;
}

/*
	Name: function_62795e55
	Namespace: ai
	Checksum: 0x7A8993C3
	Offset: 0x2DD8
	Size: 0xE
	Parameters: 0
	Flags: Linked
*/
function function_62795e55()
{
	self.var_3d461e6f = undefined;
}

/*
	Name: function_9139c839
	Namespace: ai
	Checksum: 0x431D9DF1
	Offset: 0x2DF0
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function function_9139c839()
{
	if(!isdefined(self.var_76167463))
	{
		if(isdefined(self.aisettingsbundle))
		{
			settingsbundle = self.aisettingsbundle;
		}
		else
		{
			if(isspawner(self) && isdefined(self.aitype))
			{
				settingsbundle = function_edf479a3(self.aitype);
			}
			else if(isvehicle(self) && isdefined(self.scriptbundlesettings))
			{
				settingsbundle = getscriptbundle(self.scriptbundlesettings).aisettingsbundle;
			}
		}
		if(!isdefined(settingsbundle))
		{
			return undefined;
		}
		self.var_76167463 = settingsbundle;
		if(!isdefined(level.var_e3a467cf))
		{
			level.var_e3a467cf = [];
		}
		if(!isdefined(level.var_e3a467cf[self.var_76167463]))
		{
			level.var_e3a467cf[self.var_76167463] = getscriptbundle(self.var_76167463);
		}
	}
	return level.var_e3a467cf[self.var_76167463];
}

/*
	Name: function_71919555
	Namespace: ai
	Checksum: 0x2BE5A6AF
	Offset: 0x2F40
	Size: 0x9E
	Parameters: 2
	Flags: None
*/
function function_71919555(var_45302432, fieldname)
{
	if(!isdefined(level.var_e3a467cf))
	{
		level.var_e3a467cf = [];
	}
	if(!isdefined(level.var_e3a467cf[var_45302432]))
	{
		level.var_e3a467cf[var_45302432] = getscriptbundle(var_45302432);
	}
	if(isdefined(level.var_e3a467cf[var_45302432]))
	{
		return level.var_e3a467cf[var_45302432].(fieldname);
	}
	return undefined;
}

