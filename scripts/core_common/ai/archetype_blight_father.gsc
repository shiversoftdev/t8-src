// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai\zombie_utility.gsc;
#using script_522aeb6ae906391e;
#using script_59f07c660e6710a5;
#using scripts\core_common\ai\archetype_blight_father_interface.gsc;
#using scripts\core_common\spawner_shared.gsc;

#namespace archetypeblightfather;

/*
	Name: main
	Namespace: archetypeblightfather
	Checksum: 0x8F3D99F6
	Offset: 0x90
	Size: 0x54
	Parameters: 0
	Flags: AutoExec
*/
function autoexec main()
{
	registerbehaviorscriptfunctions();
	spawner::add_archetype_spawn_function(#"blight_father", &function_a27b7fcf);
	blightfatherinterface::registerblightfatherinterfaceattributes();
}

/*
	Name: function_a27b7fcf
	Namespace: archetypeblightfather
	Checksum: 0xF39C1620
	Offset: 0xF0
	Size: 0x4A
	Parameters: 0
	Flags: Linked, Private
*/
function private function_a27b7fcf()
{
	blackboard::createblackboardforentity(self);
	ai::createinterfaceforentity(self);
	self.___archetypeonanimscriptedcallback = &function_aefef9ae;
}

/*
	Name: function_aefef9ae
	Namespace: archetypeblightfather
	Checksum: 0xA5C408E
	Offset: 0x148
	Size: 0xAE
	Parameters: 1
	Flags: Linked, Private
*/
function private function_aefef9ae(entity)
{
	entity.__blackboard = undefined;
	entity function_a27b7fcf();
	if(isdefined(entity.var_506922ab))
	{
		foreach(callback in entity.var_506922ab)
		{
			[[callback]](entity);
		}
	}
}

/*
	Name: registerbehaviorscriptfunctions
	Namespace: archetypeblightfather
	Checksum: 0x80F724D1
	Offset: 0x200
	Size: 0x4
	Parameters: 0
	Flags: Linked, Private
*/
function private registerbehaviorscriptfunctions()
{
}

/*
	Name: spawnblightfather
	Namespace: archetypeblightfather
	Checksum: 0x73605095
	Offset: 0x210
	Size: 0xA8
	Parameters: 2
	Flags: None
*/
function spawnblightfather(spawner, location)
{
	spawner.script_forcespawn = 1;
	entity = zombie_utility::spawn_zombie(spawner, undefined, location);
	if(!isdefined(entity))
	{
		return;
	}
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
	Name: function_ac921de9
	Namespace: archetypeblightfather
	Checksum: 0x41C1FB4D
	Offset: 0x2C0
	Size: 0x24
	Parameters: 1
	Flags: Private
*/
function private function_ac921de9(entity)
{
	entity melee();
}

/*
	Name: function_3e8300e9
	Namespace: archetypeblightfather
	Checksum: 0xB49EBA60
	Offset: 0x2F0
	Size: 0x58
	Parameters: 4
	Flags: Linked
*/
function function_3e8300e9(entity, attribute, oldvalue, value)
{
	if(isdefined(entity.var_80cf70fb))
	{
		entity [[entity.var_80cf70fb]](entity, attribute, oldvalue, value);
	}
}

/*
	Name: function_b95978a7
	Namespace: archetypeblightfather
	Checksum: 0x602F6900
	Offset: 0x350
	Size: 0x58
	Parameters: 4
	Flags: Linked
*/
function function_b95978a7(entity, attribute, oldvalue, value)
{
	if(isdefined(entity.var_11a49434))
	{
		entity [[entity.var_11a49434]](entity, attribute, oldvalue, value);
	}
}

