// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1b10fdf0addd52e;
#using script_1b905a8474ed2a62;
#using script_3f9e0dc8454d98e1;
#using script_4d85e8de54b02198;
#using script_522aeb6ae906391e;
#using script_58c342edd81589fb;
#using script_59f07c660e6710a5;
#using script_7e59d7bba853fe4b;
#using script_db06eb511bd9b36;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\statemachine_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_ai_shared.gsc;
#using scripts\core_common\vehicle_death_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace bat;

/*
	Name: function_89f2df9
	Namespace: bat
	Checksum: 0xEE82E95D
	Offset: 0x278
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"bat", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: bat
	Checksum: 0x7209ED3F
	Offset: 0x2C0
	Size: 0x1A4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	vehicle::add_main_callback("bat", &function_6c223039);
	spawner::function_89a2cd87(#"bat", &function_141c342b);
	namespace_3fffba66::function_cfca77a7(#"hash_6937d645fe2be5b5", #"hash_791d597ac0457860", undefined, 0, undefined, undefined);
	level thread function_1b029905();
	namespace_c3287616::register_archetype(#"bat", &function_84cd2223, &function_9471b7f9, &function_2e37549f, 25);
	zm_score::function_e5d6e6dd(#"bat", 60);
	clientfield::register("vehicle", "bat_transform_fx", 8000, 1, "int");
	level.var_ada76657 = getentarray("zombie_bat_spawner", "script_noteworthy");
	/#
		zm_devgui::function_c7dd7a17("");
	#/
}

/*
	Name: function_6c223039
	Namespace: bat
	Checksum: 0xBAD5B947
	Offset: 0x470
	Size: 0x26C
	Parameters: 0
	Flags: Linked
*/
function function_6c223039()
{
	self useanimtree("generic");
	function_d648a30();
	self.b_ignore_cleanup = 1;
	self.var_5dd07a80 = 1;
	self.var_232915af = 1;
	self.var_68139d12 = 1;
	self.nodamagefeedback = 1;
	self vehicle::friendly_fire_shield();
	self enableaimassist();
	self setneargoalnotifydist(25);
	self setdrawinfrared(1);
	self.fovcosine = 0;
	self.fovcosinebusy = 0;
	self.vehaircraftcollisionenabled = 1;
	/#
		assert(isdefined(self.scriptbundlesettings));
	#/
	self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
	self.goalradius = 999999;
	self.goalheight = 512;
	self.var_ec0d66ce = 0.5 * self.settings.engagementdistmin + self.settings.engagementdistmax;
	self.var_ff6d7c88 = self.var_ec0d66ce * self.var_ec0d66ce;
	self thread vehicle_ai::nudge_collision();
	var_134ac8f9 = int(namespace_e0710ee6::function_8d44707e(0));
	var_134ac8f9 = var_134ac8f9 * (isdefined(level.var_570d178a) ? level.var_570d178a : 1);
	self.health = int(var_134ac8f9);
	self.maxhealth = int(var_134ac8f9);
	defaultrole();
	target_set(self);
}

/*
	Name: function_141c342b
	Namespace: bat
	Checksum: 0x927E09A5
	Offset: 0x6E8
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_141c342b()
{
	var_134ac8f9 = int(namespace_e0710ee6::function_8d44707e(0));
	var_134ac8f9 = var_134ac8f9 * (isdefined(level.var_570d178a) ? level.var_570d178a : 1);
	self.health = int(var_134ac8f9);
	self.maxhealth = int(var_134ac8f9);
	self disableaimassist();
	self zm_score::function_82732ced();
}

/*
	Name: function_ab7568e0
	Namespace: bat
	Checksum: 0xDF98B135
	Offset: 0x7B0
	Size: 0x8E
	Parameters: 0
	Flags: Linked
*/
function function_ab7568e0()
{
	self endon(#"change_state", #"death");
	while(true)
	{
		if(self function_c48c2d66() && self vehicle_ai::get_current_state() != "transform")
		{
			self thread vehicle_ai::set_state("transform");
		}
		waitframe(1);
	}
}

/*
	Name: function_ea8fc463
	Namespace: bat
	Checksum: 0xD3035048
	Offset: 0x848
	Size: 0xC8
	Parameters: 1
	Flags: Linked, Private
*/
private function function_ea8fc463(target)
{
	if(!isdefined(target) || !isalive(target))
	{
		return 0;
	}
	if(isplayer(target) && (target.sessionstate == "spectator" || target.sessionstate == "intermission"))
	{
		return 0;
	}
	if(isdefined(target.ignoreme) && target.ignoreme || target isnotarget())
	{
		return 0;
	}
	return 1;
}

/*
	Name: gettarget
	Namespace: bat
	Checksum: 0xB89F49DE
	Offset: 0x918
	Size: 0x10C
	Parameters: 0
	Flags: Linked, Private
*/
private function gettarget()
{
	targets = getplayers();
	var_2d605ac5 = targets[0];
	for(i = 0; i < targets.size; i++)
	{
		if(!isdefined(targets[i].hunted_by))
		{
			targets[i].hunted_by = 0;
		}
		if(!function_ea8fc463(targets[i]))
		{
			continue;
		}
		if(!function_ea8fc463(var_2d605ac5) || targets[i].hunted_by < var_2d605ac5.hunted_by)
		{
			var_2d605ac5 = targets[i];
		}
	}
	if(function_ea8fc463(var_2d605ac5))
	{
		return var_2d605ac5;
	}
}

/*
	Name: function_1076a2e0
	Namespace: bat
	Checksum: 0xE5F1119E
	Offset: 0xA30
	Size: 0x120
	Parameters: 0
	Flags: Linked, Private
*/
private function function_1076a2e0()
{
	self endon(#"change_state", #"death");
	while(true)
	{
		if(isdefined(self.ignoreall) && self.ignoreall)
		{
			wait(0.5);
			continue;
		}
		if(function_ea8fc463(self.var_c4e19d3))
		{
			wait(0.5);
			continue;
		}
		target = gettarget();
		if(!isdefined(target))
		{
			self.var_c4e19d3 = undefined;
		}
		else
		{
			self.var_c4e19d3 = target;
			self.var_c4e19d3.hunted_by = self.var_c4e19d3.hunted_by + 1;
			self vehlookat(self.var_c4e19d3);
			self turretsettarget(0, self.var_c4e19d3);
		}
		wait(0.5);
	}
}

/*
	Name: function_776e45e5
	Namespace: bat
	Checksum: 0x48E2CF49
	Offset: 0xB58
	Size: 0x1E8
	Parameters: 0
	Flags: Private
*/
private function function_776e45e5()
{
	self endon(#"change_state", #"death");
	self waittill_timeout(10, #"reached_end_node");
	while(true)
	{
		players = getplayers();
		var_3ada9d08 = 0;
		foreach(player in players)
		{
			if(self seerecently(player, 30))
			{
				var_3ada9d08 = 1;
				break;
			}
		}
		if(gettime() - self.spawn_time > 10000 && !var_3ada9d08 && (!(isdefined(self.var_894194a9) && self.var_894194a9)))
		{
			self.var_d880e556 = 1;
			if(!level flag::get("special_round"))
			{
				while(!isdefined(ai))
				{
					waitframe(1);
					ai = function_2e37549f(1);
				}
				ai.health = self.health;
			}
			self namespace_57ff8cbb::cleanup_zombie();
			return;
		}
		wait(1);
	}
}

/*
	Name: function_d648a30
	Namespace: bat
	Checksum: 0x3084B4AE
	Offset: 0xD48
	Size: 0x4C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_d648a30()
{
	blackboard::createblackboardforentity(self);
	self blackboard::registervehicleblackboardattributes();
	ai::createinterfaceforentity(self);
}

/*
	Name: defaultrole
	Namespace: bat
	Checksum: 0xBEDE9C32
	Offset: 0xDA0
	Size: 0x134
	Parameters: 0
	Flags: Linked
*/
function defaultrole()
{
	statemachine = self vehicle_ai::init_state_machine_for_role("default");
	self vehicle_ai::get_state_callbacks("combat").enter_func = &state_combat_enter;
	self vehicle_ai::get_state_callbacks("combat").update_func = &state_combat_update;
	self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
	statemachine statemachine::add_state("transform", &function_9071e5a9, &function_47c795bc, &function_db99ddec);
	self vehicle_ai::call_custom_add_state_callbacks();
	vehicle_ai::startinitialstate("combat");
}

/*
	Name: function_9122b0e5
	Namespace: bat
	Checksum: 0x80508C2A
	Offset: 0xEE0
	Size: 0x22
	Parameters: 0
	Flags: None
*/
function function_9122b0e5()
{
	return self ai::get_behavior_attribute("firing_rate");
}

#namespace namespace_726d8173;

/*
	Name: __constructor
	Namespace: namespace_726d8173
	Checksum: 0x45EEFFAF
	Offset: 0xF10
	Size: 0x26
	Parameters: 0
	Flags: Linked, 8
*/
function __constructor()
{
	self.origin = undefined;
	self.mover = undefined;
	self.var_f11f68fb = undefined;
}

/*
	Name: __destructor
	Namespace: namespace_726d8173
	Checksum: 0x80F724D1
	Offset: 0xF40
	Size: 0x4
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
}

#namespace bat;

/*
	Name: function_726d8173
	Namespace: bat
	Checksum: 0x853D44F3
	Offset: 0xF50
	Size: 0x86
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_726d8173()
{
	classes.var_726d8173[0] = spawnstruct();
	classes.var_726d8173[0].__vtable[913321084] = &namespace_726d8173::__destructor;
	classes.var_726d8173[0].__vtable[674154906] = &namespace_726d8173::__constructor;
}

/*
	Name: function_607df9c6
	Namespace: bat
	Checksum: 0x541C5390
	Offset: 0xFE0
	Size: 0x2C4
	Parameters: 1
	Flags: Linked
*/
function function_607df9c6(ai)
{
	if(isdefined(level.var_45827161) && isdefined(level.var_45827161[level.round_number]))
	{
		ai.var_ba75c6dc = 1;
	}
	if(isdefined(ai.var_e21c1964) && ai.var_e21c1964)
	{
		return;
	}
	actors = getentitiesinradius(ai.origin, 80, 15);
	foreach(actor in actors)
	{
		if(actor.team !== level.zombie_team || actor.archetype !== #"zombie")
		{
			continue;
		}
		actor zombie_utility::setup_zombie_knockdown(ai);
	}
	ai.var_e21c1964 = 1;
	var_cd1cfeed = ai animmappingsearch(#"hash_605e435c80f0d33b");
	pos = physicstrace(ai.origin, ai.origin + vectorscale((0, 0, -1), 10000), vectorscale((-1, -1, -1), 2), vectorscale((1, 1, 1), 2), ai, 1);
	pos = pos[#"position"];
	if(isdefined(level.var_84b2907f))
	{
		level thread [[level.var_84b2907f]](ai);
	}
	if(isdefined(var_cd1cfeed))
	{
		if(isdefined(pos))
		{
			ai animation::play(var_cd1cfeed, pos, ai.angles, 1, 0.2, 0.1, undefined, undefined, undefined, 0);
		}
		else
		{
			ai animation::play(var_cd1cfeed, ai.origin, ai.angles, 1, 0.2, 0.1, undefined, undefined, undefined, 0);
		}
	}
}

/*
	Name: function_1b029905
	Namespace: bat
	Checksum: 0x1FDCF8D2
	Offset: 0x12B0
	Size: 0xD4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_1b029905()
{
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(#"transformation_complete");
		if(waitresult.id === #"hash_791d597ac0457860" && isdefined(waitresult.data))
		{
			newai = waitresult.var_944250d2[0];
			newai.maxhealth = newai.maxhealth * waitresult.data.var_f11f68fb;
			newai.health = newai.maxhealth;
		}
		wait(0.1);
	}
}

/*
	Name: function_1fff2d
	Namespace: bat
	Checksum: 0x31212AD8
	Offset: 0x1390
	Size: 0x2AE
	Parameters: 0
	Flags: Linked
*/
function function_1fff2d()
{
	pos = physicstrace(self.origin, self.origin + vectorscale((0, 0, -1), 10000), vectorscale((-1, -1, -1), 2), vectorscale((1, 1, 1), 2), self, 1);
	if(isdefined(pos) && isdefined(pos[#"position"]) && !isdefined(pos[#"entity"]))
	{
		pos = pos[#"position"];
		/#
			recordline(self.origin, pos, (0, 1, 1), "");
			recordsphere(pos, 8, (0, 1, 1), "");
		#/
		var_491fd46e = getclosestpointonnavmesh(pos, 256, 30);
		if(isdefined(var_491fd46e))
		{
			pos = physicstrace(var_491fd46e + vectorscale((0, 0, 1), 70), var_491fd46e + vectorscale((0, 0, -1), 70), vectorscale((-1, -1, -1), 2), vectorscale((1, 1, 1), 2), self, 1);
			pos = pos[#"position"];
			/#
				recordline(pos, var_491fd46e, (0, 0, 1), "");
				recordsphere(var_491fd46e, 8, (0, 0, 1), "");
			#/
			if(isdefined(pos))
			{
				scriptmodel = util::spawn_model("tag_origin", self.origin, self.angles);
				if(isdefined(scriptmodel))
				{
					object = new var_726d8173();
					[[ object ]]->__constructor();
					self.ai.var_15916e52 = object;
					self.ai.var_15916e52.pos = pos;
					self.ai.var_15916e52.mover = scriptmodel;
					return 1;
				}
			}
		}
	}
	return 0;
}

/*
	Name: function_c48c2d66
	Namespace: bat
	Checksum: 0x1A402B88
	Offset: 0x1648
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function function_c48c2d66()
{
	if(isdefined(self.var_d880e556) && self.var_d880e556)
	{
		return 0;
	}
	if(namespace_3fffba66::function_abf1dcb4(#"hash_791d597ac0457860"))
	{
		return 0;
	}
	if(!isdefined(self.spawn_time))
	{
		return 0;
	}
	if(gettime() - self.spawn_time < 3500)
	{
		return 0;
	}
	if(self isplayinganimscripted())
	{
		return 0;
	}
	if(function_1fff2d())
	{
		/#
			assert(isdefined(self.ai.var_15916e52));
		#/
		return 1;
	}
	return 0;
}

/*
	Name: function_9071e5a9
	Namespace: bat
	Checksum: 0x23043E2F
	Offset: 0x1728
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function function_9071e5a9(params)
{
	self.takedamage = 0;
	self.var_894194a9 = 1;
}

/*
	Name: function_630752f6
	Namespace: bat
	Checksum: 0xD97C57B5
	Offset: 0x1758
	Size: 0x92
	Parameters: 1
	Flags: Linked
*/
function function_630752f6(notifyhash)
{
	if(isdefined(self) && isdefined(self.ai) && isdefined(self.ai.var_15916e52) && isdefined(self.ai.var_15916e52.mover))
	{
		self.ai.var_15916e52.mover delete();
		self.ai.var_15916e52 = undefined;
	}
}

/*
	Name: function_88d81715
	Namespace: bat
	Checksum: 0xFFB23779
	Offset: 0x17F8
	Size: 0x34
	Parameters: 0
	Flags: Linked, Private
*/
private function function_88d81715()
{
	self endon(#"death");
	wait(1.5);
	self ghost();
}

/*
	Name: function_47c795bc
	Namespace: bat
	Checksum: 0xD0778B10
	Offset: 0x1838
	Size: 0x374
	Parameters: 1
	Flags: Linked
*/
function function_47c795bc(params)
{
	self endon_callback(&function_630752f6, #"death", #"state_change");
	/#
		assert(isdefined(self.ai.var_15916e52));
	#/
	self.ai.var_15916e52.var_f11f68fb = self.var_b008e588;
	var_d1ba5d77 = self.ai.var_15916e52.pos;
	mover = self.ai.var_15916e52.mover;
	tagorigin = self.origin;
	var_4edd9b4 = self gettagorigin("j_spine4");
	offset = var_4edd9b4 - tagorigin;
	timescale = 0.4;
	movetime = getanimlength(self animmappingsearch(#"hash_68965c4716ebbf8b")) * timescale;
	mover enablelinkto();
	self linkto(mover, "tag_origin", offset, (0, 0, 0));
	self asmrequestsubstate(#"hash_4bea3500eb31dd8b");
	self thread function_88d81715();
	acceleration = 0.3;
	mover moveto(self.origin + vectorscale((0, 0, 1), 30), 0.6, acceleration);
	mover waittill(#"movedone");
	waittime = 0.1;
	wait(waittime);
	acceleration = 0.6;
	mover moveto(var_d1ba5d77, movetime, acceleration);
	mover waittill(#"movedone");
	self clientfield::set("bat_transform_fx", 1);
	self.overridevehicledamage = undefined;
	namespace_3fffba66::function_9acf76e6(self, #"hash_791d597ac0457860", &function_607df9c6, 0);
	radiusdamage(self.origin, 200, 15, 5, self);
	self.ai.var_15916e52 = undefined;
	if(isdefined(mover))
	{
		mover delete();
	}
	wait(1);
	self delete();
}

/*
	Name: function_db99ddec
	Namespace: bat
	Checksum: 0x3243027F
	Offset: 0x1BB8
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function function_db99ddec(params)
{
}

/*
	Name: state_death_update
	Namespace: bat
	Checksum: 0xABB40D8
	Offset: 0x1BD0
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function state_death_update(params)
{
	self endon(#"death");
	self asmrequestsubstate(#"death@stationary");
	if(isdefined(self.var_c4e19d3) && isdefined(self.var_c4e19d3.hunted_by))
	{
		self.var_c4e19d3.hunted_by--;
	}
	self vehicle_death::death_fx();
	self val::set(#"hash_cee3dc3b4fd296b", #"hide", 2);
	wait(1);
	self delete();
}

/*
	Name: state_combat_enter
	Namespace: bat
	Checksum: 0x1D8280FA
	Offset: 0x1CB8
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function state_combat_enter(params)
{
	self thread function_1076a2e0();
	self thread function_2b369c9f();
	self thread function_ab7568e0();
	/#
		self thread function_66d3e7c2();
	#/
}

/*
	Name: function_2b369c9f
	Namespace: bat
	Checksum: 0x92D02B8F
	Offset: 0x1D30
	Size: 0x96
	Parameters: 0
	Flags: Linked
*/
function function_2b369c9f()
{
	self endon(#"change_state", #"death");
	while(true)
	{
		if(self.ai.var_e7d26c0f > 3)
		{
			if(isdefined(level.var_d9f4b654))
			{
				self.ai.var_e7d26c0f = 0;
				[[level.var_d9f4b654]](self);
			}
		}
		wait(1);
	}
}

/*
	Name: function_1c4cd527
	Namespace: bat
	Checksum: 0x9872FAA2
	Offset: 0x1DD0
	Size: 0x2D6
	Parameters: 6
	Flags: Linked
*/
function function_1c4cd527(origin, owner, innerradius, outerradius, halfheight, spacing)
{
	queryresult = positionquery_source_navigation(origin, innerradius, outerradius, halfheight, spacing, "navvolume_small", spacing);
	positionquery_filter_sight(queryresult, origin, self geteye() - self.origin, self, 0, owner);
	foreach(point in queryresult.data)
	{
		if(!point.visibility)
		{
			/#
				if(!isdefined(point._scoredebug))
				{
					point._scoredebug = [];
				}
				if(!isdefined(point._scoredebug[#"hash_3f8a9579ce4600de"]))
				{
					point._scoredebug[#"hash_3f8a9579ce4600de"] = spawnstruct();
				}
				point._scoredebug[#"hash_3f8a9579ce4600de"].score = -5000;
				point._scoredebug[#"hash_3f8a9579ce4600de"].var_4b5e0304 = "";
			#/
			point.score = point.score + -5000;
		}
	}
	if(queryresult.data.size > 0)
	{
		vehicle_ai::positionquery_postprocess_sortscore(queryresult);
		self vehicle_ai::positionquery_debugscores(queryresult);
		foreach(point in queryresult.data)
		{
			if(isdefined(point.origin))
			{
				goal = point.origin;
				break;
			}
		}
	}
	return goal;
}

/*
	Name: function_8550e9be
	Namespace: bat
	Checksum: 0xA9F866CD
	Offset: 0x20B0
	Size: 0x136
	Parameters: 1
	Flags: Linked
*/
function function_8550e9be(enemy)
{
	protectdest = undefined;
	if(isdefined(enemy))
	{
		groundpos = getclosestpointonnavmesh(enemy.origin, 10000);
		if(isdefined(groundpos))
		{
			self.var_d6acaac4 = groundpos;
			pos = groundpos + (0, 0, randomintrange(100, 150));
			pos = getclosestpointonnavvolume(pos, "navvolume_small", 2000);
			if(isdefined(pos))
			{
				var_3a364b6c = distance(self.origin, pos);
				if(var_3a364b6c > 500)
				{
					protectdest = function_1c4cd527(pos, enemy, 200, 350, 24, 48);
					if(isdefined(protectdest))
					{
						self.var_c8c5a7d3 = protectdest;
					}
				}
			}
		}
	}
	return protectdest;
}

/*
	Name: function_66d3e7c2
	Namespace: bat
	Checksum: 0x87A4DFC7
	Offset: 0x21F0
	Size: 0xCE
	Parameters: 0
	Flags: None
*/
function function_66d3e7c2()
{
	self endon(#"death");
	while(true)
	{
		if(isdefined(self.var_c8c5a7d3))
		{
			/#
				recordsphere(self.var_c8c5a7d3, 8, (0, 0, 1), "");
			#/
			if(isdefined(self.var_d6acaac4))
			{
				/#
					recordsphere(self.var_c8c5a7d3, 8, (0, 1, 0), "");
					recordline(self.var_c8c5a7d3, self.var_d6acaac4, (0, 1, 0), "");
				#/
			}
		}
		waitframe(1);
	}
}

/*
	Name: state_combat_update
	Namespace: bat
	Checksum: 0xA812E480
	Offset: 0x22C8
	Size: 0x1E8
	Parameters: 1
	Flags: Linked
*/
function state_combat_update(params)
{
	self endon(#"change_state", #"death");
	self asmrequestsubstate(#"locomotion@movement");
	for(;;)
	{
		if(isdefined(self.ignoreall) && self.ignoreall)
		{
			wait(1);
			continue;
		}
		if(!ispointinnavvolume(self.origin, "navvolume_small"))
		{
			var_f524eafc = getclosestpointonnavvolume(self.origin, "navvolume_small", 2000);
			if(isdefined(var_f524eafc))
			{
				self.origin = var_f524eafc;
			}
		}
		if(!isdefined(self.var_c4e19d3))
		{
			self function_a57c34b7(self.origin, 1, 1);
		}
		protectdest = function_8550e9be(self.var_c4e19d3);
		if(isdefined(protectdest))
		{
			path = function_ae7a8634(self.origin, protectdest, self);
			if(isdefined(path) && path.status === "succeeded")
			{
				self.ai.var_e7d26c0f = 0;
				self function_a57c34b7(protectdest, 1, 1);
			}
			else
			{
				self.ai.var_e7d26c0f++;
			}
		}
		wait(randomintrange(3, 5));
	}
}

/*
	Name: function_84cd2223
	Namespace: bat
	Checksum: 0x329EB9BA
	Offset: 0x24B8
	Size: 0x7A
	Parameters: 1
	Flags: Linked
*/
function function_84cd2223(var_dbce0c44)
{
	var_a87aeae6 = 30;
	var_a1737466 = randomfloatrange(0.02, 0.03);
	return min(var_a87aeae6, int(level.zombie_total * var_a1737466));
}

/*
	Name: function_9471b7f9
	Namespace: bat
	Checksum: 0x427B4020
	Offset: 0x2540
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_9471b7f9()
{
	ai = function_2e37549f();
	if(isdefined(ai))
	{
		level.zombie_total--;
		return 1;
	}
	return 0;
}

/*
	Name: function_2e37549f
	Namespace: bat
	Checksum: 0x56AADB1D
	Offset: 0x2588
	Size: 0x1DC
	Parameters: 3
	Flags: Linked
*/
function function_2e37549f(b_force_spawn = 0, var_eb3a8721, n_round_number)
{
	if(!b_force_spawn && !function_96578f39())
	{
		return undefined;
	}
	if(isdefined(var_eb3a8721))
	{
		s_spawn_loc = var_eb3a8721;
	}
	else if(isdefined(level.var_29a8e07))
	{
		s_spawn_loc = [[level.var_29a8e07]]();
	}
	else if(isdefined(level.zm_loc_types[#"bat_location"]) && level.zm_loc_types[#"bat_location"].size > 0)
	{
		s_spawn_loc = array::random(level.zm_loc_types[#"bat_location"]);
	}
	if(!isdefined(s_spawn_loc))
	{
		return undefined;
	}
	ai = zombie_utility::spawn_zombie(level.var_ada76657[0], undefined, undefined, n_round_number);
	if(isdefined(ai))
	{
		ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
		ai thread zombie_utility::round_spawn_failsafe();
		ai.origin = s_spawn_loc.origin;
		if(isdefined(s_spawn_loc.angles))
		{
			ai.angles = s_spawn_loc.angles;
		}
		if(isdefined(level.var_d9334d8b))
		{
			ai thread [[level.var_d9334d8b]](s_spawn_loc);
		}
	}
	return ai;
}

/*
	Name: function_96578f39
	Namespace: bat
	Checksum: 0xD0BC2BA6
	Offset: 0x2770
	Size: 0xBA
	Parameters: 0
	Flags: Linked
*/
function function_96578f39()
{
	var_7d706b3f = function_2ffae59e();
	var_1a68bbce = function_133e1e25();
	if(!(isdefined(level.var_2b94ce72) && level.var_2b94ce72) && (isdefined(level.var_15747fb1) && level.var_15747fb1) || var_7d706b3f >= var_1a68bbce || !level flag::get("spawn_zombies"))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_133e1e25
	Namespace: bat
	Checksum: 0xBDFE9A14
	Offset: 0x2838
	Size: 0xAA
	Parameters: 0
	Flags: Linked
*/
function function_133e1e25()
{
	n_player_count = zm_utility::function_a2541519(level.players.size);
	switch(n_player_count)
	{
		case 1:
		{
			return 3;
			break;
		}
		case 2:
		{
			return 5;
			break;
		}
		case 3:
		{
			return 7;
			break;
		}
		case 4:
		{
			return 10;
			break;
		}
	}
}

/*
	Name: function_2ffae59e
	Namespace: bat
	Checksum: 0xC5AE7340
	Offset: 0x28F0
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_2ffae59e()
{
	var_e7a26429 = getaiarchetypearray(#"bat");
	var_7d706b3f = var_e7a26429.size;
	foreach(var_51fe0ded in var_e7a26429)
	{
		if(!isalive(var_51fe0ded))
		{
			var_7d706b3f--;
		}
	}
	return var_7d706b3f;
}

