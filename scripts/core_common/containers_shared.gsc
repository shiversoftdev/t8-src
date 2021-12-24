// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace ccontainer;

/*
	Name: __constructor
	Namespace: ccontainer
	Checksum: 0x80F724D1
	Offset: 0x180
	Size: 0x4
	Parameters: 0
	Flags: 8
*/
function __constructor()
{
}

/*
	Name: __destructor
	Namespace: ccontainer
	Checksum: 0x80F724D1
	Offset: 0x190
	Size: 0x4
	Parameters: 0
	Flags: 16
*/
function __destructor()
{
}

/*
	Name: init_xmodel
	Namespace: ccontainer
	Checksum: 0x44ECFC2
	Offset: 0x1A0
	Size: 0x5A
	Parameters: 3
	Flags: None
*/
function init_xmodel(str_xmodel = "script_origin", v_origin, v_angles)
{
	self.m_e_container = util::spawn_model(str_xmodel, v_origin, v_angles);
	return self.m_e_container;
}

#namespace containers;

/*
	Name: ccontainer
	Namespace: containers
	Checksum: 0x767F80A7
	Offset: 0x208
	Size: 0xB6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function ccontainer()
{
	classes.ccontainer[0] = spawnstruct();
	classes.ccontainer[0].__vtable[867014925] = &ccontainer::init_xmodel;
	classes.ccontainer[0].__vtable[913321084] = &ccontainer::__destructor;
	classes.ccontainer[0].__vtable[674154906] = &ccontainer::__constructor;
}

/*
	Name: function_89f2df9
	Namespace: containers
	Checksum: 0xD77BE98F
	Offset: 0x2C8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"containers", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: containers
	Checksum: 0xB2BB2BE
	Offset: 0x310
	Size: 0xC2
	Parameters: 0
	Flags: None
*/
function __init__()
{
	a_containers = struct::get_array("scriptbundle_containers", "classname");
	foreach(s_instance in a_containers)
	{
		c_container = s_instance init();
		if(isdefined(c_container))
		{
			s_instance.c_container = c_container;
		}
	}
}

/*
	Name: init
	Namespace: containers
	Checksum: 0x8AA5CE20
	Offset: 0x3E0
	Size: 0x5A
	Parameters: 0
	Flags: None
*/
function init()
{
	if(!isdefined(self.angles))
	{
		self.angles = (0, 0, 0);
	}
	s_bundle = struct::get_script_bundle("containers", self.scriptbundlename);
	return setup_container_scriptbundle(s_bundle, self);
}

/*
	Name: setup_container_scriptbundle
	Namespace: containers
	Checksum: 0x85EE1322
	Offset: 0x448
	Size: 0xC8
	Parameters: 2
	Flags: None
*/
function setup_container_scriptbundle(s_bundle, s_container_instance)
{
	object = new ccontainer();
	[[ object ]]->__constructor();
	c_container = object;
	c_container.m_s_container_bundle = s_bundle;
	c_container.m_s_fxanim_bundle = struct::get_script_bundle("scene", s_bundle.theeffectbundle);
	c_container.m_s_container_instance = s_container_instance;
	self scene::init(s_bundle.theeffectbundle, c_container.m_e_container);
	level thread container_update(c_container);
	return c_container;
}

/*
	Name: container_update
	Namespace: containers
	Checksum: 0xC7085F55
	Offset: 0x518
	Size: 0xFC
	Parameters: 1
	Flags: None
*/
function container_update(c_container)
{
	e_ent = c_container.m_e_container;
	s_bundle = c_container.m_s_container_bundle;
	targetname = c_container.m_s_container_instance.targetname;
	n_radius = s_bundle.trigger_radius;
	e_trigger = create_locker_trigger(c_container.m_s_container_instance.origin, n_radius, "Press [{+activate}] to open");
	e_trigger waittill(#"trigger");
	e_trigger delete();
	scene::play(targetname, "targetname");
}

/*
	Name: create_locker_trigger
	Namespace: containers
	Checksum: 0x96F94458
	Offset: 0x620
	Size: 0x118
	Parameters: 3
	Flags: None
*/
function create_locker_trigger(v_pos, n_radius, str_message)
{
	v_pos = (v_pos[0], v_pos[1], v_pos[2] + 50);
	e_trig = spawn("trigger_radius_use", v_pos, 0, n_radius, 100);
	e_trig triggerignoreteam();
	e_trig setvisibletoall();
	e_trig setteamfortrigger(#"none");
	e_trig usetriggerrequirelookat();
	e_trig setcursorhint("HINT_NOICON");
	e_trig sethintstring(str_message);
	return e_trig;
}

/*
	Name: setup_general_container_bundle
	Namespace: containers
	Checksum: 0xEEE41A95
	Offset: 0x740
	Size: 0x35C
	Parameters: 4
	Flags: None
*/
function setup_general_container_bundle(str_targetname, str_intel_vo, str_narrative_collectable_model, force_open)
{
	s_struct = struct::get(str_targetname, "targetname");
	if(!isdefined(s_struct))
	{
		return;
	}
	level flag::wait_till("all_players_spawned");
	e_trigger = create_locker_trigger(s_struct.origin, 64, "Press [{+activate}] to open");
	if(!isdefined(force_open) || force_open == 0)
	{
		waitresult = undefined;
		waitresult = e_trigger waittill(#"trigger");
		e_who = waitresult.activator;
	}
	else
	{
		rand_time = randomfloatrange(1, 1.5);
		wait(rand_time);
	}
	e_trigger delete();
	level thread scene::play(str_targetname, "targetname");
	if(isdefined(s_struct.a_entity))
	{
		for(i = 0; i < s_struct.a_entity.size; i++)
		{
			s_struct.a_entity[i] notify(#"opened");
		}
	}
	if(isdefined(str_narrative_collectable_model))
	{
		v_pos = s_struct.origin + vectorscale((0, 0, 1), 30);
		if(!isdefined(s_struct.angles))
		{
			v_angles = (0, 0, 0);
		}
		else
		{
			v_angles = s_struct.angles;
		}
		v_angles = (v_angles[0], v_angles[1] + 90, v_angles[2]);
		e_collectable = spawn("script_model", v_pos);
		e_collectable setmodel(#"p7_int_narrative_collectable");
		e_collectable.angles = v_angles;
		wait(1);
		e_trigger = create_locker_trigger(s_struct.origin, 64, "Press [{+activate}] to pickup collectable");
		waitresult = undefined;
		waitresult = e_trigger waittill(#"trigger");
		e_who = waitresult.activator;
		e_trigger delete();
		e_collectable delete();
	}
	if(isdefined(str_intel_vo))
	{
		e_who playsound(str_intel_vo);
	}
}

/*
	Name: setup_locker_double_doors
	Namespace: containers
	Checksum: 0x6EDCEFA5
	Offset: 0xAA8
	Size: 0x166
	Parameters: 3
	Flags: None
*/
function setup_locker_double_doors(str_left_door_name, str_right_door_name, center_point_offset)
{
	a_left_doors = getentarray(str_left_door_name, "targetname");
	if(!isdefined(a_left_doors))
	{
		return;
	}
	a_right_doors = getentarray(str_right_door_name, "targetname");
	if(!isdefined(a_right_doors))
	{
		return;
	}
	for(i = 0; i < a_left_doors.size; i++)
	{
		e_left_door = a_left_doors[i];
		if(isdefined(center_point_offset))
		{
			v_forward = anglestoforward(e_left_door.angles);
			v_search_pos = e_left_door.origin + (v_forward * center_point_offset);
		}
		else
		{
			v_search_pos = e_left_door.origin;
		}
		e_right_door = get_closest_ent_from_array(v_search_pos, a_right_doors);
		level thread create_locker_doors(e_left_door, e_right_door, 120, 0.4);
	}
}

/*
	Name: get_closest_ent_from_array
	Namespace: containers
	Checksum: 0xAB82E45F
	Offset: 0xC18
	Size: 0xAE
	Parameters: 2
	Flags: None
*/
function get_closest_ent_from_array(v_pos, a_ents)
{
	e_closest = undefined;
	n_closest_dist = 9999999;
	for(i = 0; i < a_ents.size; i++)
	{
		dist = distance(v_pos, a_ents[i].origin);
		if(dist < n_closest_dist)
		{
			n_closest_dist = dist;
			e_closest = a_ents[i];
		}
	}
	return e_closest;
}

/*
	Name: create_locker_doors
	Namespace: containers
	Checksum: 0x5E2F8664
	Offset: 0xCD0
	Size: 0x18C
	Parameters: 4
	Flags: None
*/
function create_locker_doors(e_left_door, e_right_door, door_open_angle, door_open_time)
{
	v_locker_pos = (e_left_door.origin + e_right_door.origin) / 2;
	n_trigger_radius = 48;
	e_trigger = create_locker_trigger(v_locker_pos, n_trigger_radius, "Press [{+activate}] to open");
	e_trigger waittill(#"trigger");
	e_left_door playsound(#"evt_cabinet_open");
	v_angle = (e_left_door.angles[0], e_left_door.angles[1] - door_open_angle, e_left_door.angles[2]);
	e_left_door rotateto(v_angle, door_open_time);
	v_angle = (e_right_door.angles[0], e_right_door.angles[1] + door_open_angle, e_right_door.angles[2]);
	e_right_door rotateto(v_angle, door_open_time);
	e_trigger delete();
}

