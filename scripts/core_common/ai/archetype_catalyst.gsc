// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai\archetype_catalyst_interface.gsc;
#using script_3aa0f32b70d4f7cb;
#using scripts\core_common\ai\zombie_utility.gsc;
#using script_4bf952f6ba31bb17;
#using script_522aeb6ae906391e;
#using script_59f07c660e6710a5;
#using scripts\core_common\spawner_shared.gsc;

#namespace archetypecatalyst;

/*
	Name: main
	Namespace: archetypecatalyst
	Checksum: 0xE5E05C1
	Offset: 0xE8
	Size: 0x84
	Parameters: 0
	Flags: AutoExec
*/
function autoexec main()
{
	registerbehaviorscriptfunctions();
	spawner::add_archetype_spawn_function(#"catalyst", &function_728127b);
	spawner::add_archetype_spawn_function(#"catalyst", &function_5608540a);
	catalystinterface::registercatalystinterfaceattributes();
}

/*
	Name: registerbehaviorscriptfunctions
	Namespace: archetypecatalyst
	Checksum: 0x448CD60E
	Offset: 0x178
	Size: 0x9C
	Parameters: 0
	Flags: Linked, Private
*/
function private registerbehaviorscriptfunctions()
{
	/#
		assert(isscriptfunctionptr(&iscatalyst));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"iscatalyst", &iscatalyst);
	animationstatenetwork::registeranimationmocomp("mocomp_teleport_traversal@catalyst", &function_720a0584, undefined, undefined);
}

/*
	Name: iscatalyst
	Namespace: archetypecatalyst
	Checksum: 0x858B4BF7
	Offset: 0x220
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function iscatalyst(entity)
{
	return self.archetype === #"catalyst";
}

/*
	Name: function_5608540a
	Namespace: archetypecatalyst
	Checksum: 0x20BC78CB
	Offset: 0x250
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_5608540a()
{
	self.zombie_move_speed = "walk";
	var_9d3ec6f = [];
	var_9d3ec6f[#"catalyst_corrosive"] = 1;
	var_9d3ec6f[#"catalyst_electric"] = 3;
	var_9d3ec6f[#"catalyst_plasma"] = 2;
	var_9d3ec6f[#"catalyst_water"] = 4;
	if(isdefined(self.var_9fde8624) && isdefined(var_9d3ec6f[self.var_9fde8624]))
	{
		function_27c82a36(self, var_9d3ec6f[self.var_9fde8624]);
	}
}

/*
	Name: function_728127b
	Namespace: archetypecatalyst
	Checksum: 0x2704D28A
	Offset: 0x320
	Size: 0x4A
	Parameters: 0
	Flags: Linked, Private
*/
function private function_728127b()
{
	blackboard::createblackboardforentity(self);
	ai::createinterfaceforentity(self);
	self.___archetypeonanimscriptedcallback = &function_dc16721f;
}

/*
	Name: function_27c82a36
	Namespace: archetypecatalyst
	Checksum: 0x3326CB6F
	Offset: 0x378
	Size: 0x150
	Parameters: 2
	Flags: Linked
*/
function function_27c82a36(entity, catalyst_type)
{
	entity function_b7e4069(catalyst_type);
	if(isdefined(level.var_f6d5bd0c))
	{
		if(level.var_f6d5bd0c[0].size > 0)
		{
			foreach(spawn_func in level.var_f6d5bd0c[0])
			{
				entity [[spawn_func]]();
			}
		}
		if(level.var_f6d5bd0c[catalyst_type].size > 0)
		{
			foreach(spawn_func in level.var_f6d5bd0c[catalyst_type])
			{
				entity [[spawn_func]]();
			}
		}
	}
	return entity;
}

/*
	Name: function_84c6177b
	Namespace: archetypecatalyst
	Checksum: 0x8B67624E
	Offset: 0x4D0
	Size: 0xE0
	Parameters: 3
	Flags: None
*/
function function_84c6177b(spawner, catalyst_type, location)
{
	spawner.script_forcespawn = 1;
	entity = zombie_utility::spawn_zombie(spawner, undefined, location);
	if(!isdefined(entity))
	{
		return;
	}
	if(isdefined(entity.catalyst_type))
	{
		return;
	}
	entity = function_27c82a36(entity, catalyst_type);
	if(!isdefined(location.angles))
	{
		angles = (0, 0, 0);
	}
	else
	{
		angles = location.angles;
	}
	entity forceteleport(location.origin, angles);
	return entity;
}

/*
	Name: function_b7e4069
	Namespace: archetypecatalyst
	Checksum: 0x767B1E4F
	Offset: 0x5B8
	Size: 0x1A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_b7e4069(catalyst_type)
{
	self.catalyst_type = catalyst_type;
}

/*
	Name: function_dc16721f
	Namespace: archetypecatalyst
	Checksum: 0x1556F580
	Offset: 0x5E0
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_dc16721f(entity)
{
	entity.__blackboard = undefined;
	entity function_728127b();
}

/*
	Name: function_8f9b9d24
	Namespace: archetypecatalyst
	Checksum: 0x54F8AC86
	Offset: 0x618
	Size: 0xD4
	Parameters: 2
	Flags: Linked
*/
function function_8f9b9d24(catalyst_type, func)
{
	if(!isdefined(level.var_f6d5bd0c))
	{
		level.var_f6d5bd0c = [];
		level.var_f6d5bd0c[0] = [];
		level.var_f6d5bd0c[1] = [];
		level.var_f6d5bd0c[3] = [];
		level.var_f6d5bd0c[2] = [];
		level.var_f6d5bd0c[4] = [];
	}
	if(isdefined(level.var_f6d5bd0c[catalyst_type]))
	{
		level.var_f6d5bd0c[catalyst_type][level.var_f6d5bd0c[catalyst_type].size] = func;
	}
}

/*
	Name: function_720a0584
	Namespace: archetypecatalyst
	Checksum: 0xAC3D2535
	Offset: 0x6F8
	Size: 0x194
	Parameters: 5
	Flags: Linked
*/
function function_720a0584(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity orientmode("face angle", entity.angles[1]);
	entity animmode("normal");
	if(isdefined(entity.traverseendnode))
	{
		/#
			print3d(entity.traversestartnode.origin, "", (1, 0, 0), 1, 1, 60);
			print3d(entity.traverseendnode.origin, "", (0, 1, 0), 1, 1, 60);
			line(entity.traversestartnode.origin, entity.traverseendnode.origin, (0, 1, 0), 1, 0, 60);
		#/
		entity forceteleport(entity.traverseendnode.origin, entity.traverseendnode.angles, 0);
	}
}

