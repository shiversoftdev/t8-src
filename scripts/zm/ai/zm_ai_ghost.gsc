// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_loadout.gsc;
#using script_178024232e91b0a1;
#using scripts\zm\ai\zm_ai_ghost_interface.gsc;
#using script_2c5daa95f8fec03c;
#using scripts\core_common\ai\archetype_mocomps_utility.gsc;
#using script_35598499769dbb3d;
#using script_3819e7a1427df6d2;
#using script_3aa0f32b70d4f7cb;
#using scripts\core_common\ai\zombie_utility.gsc;
#using script_41fe08c37d53a635;
#using script_489b835a247c990e;
#using script_4bf952f6ba31bb17;
#using script_4d85e8de54b02198;
#using script_522aeb6ae906391e;
#using scripts\core_common\status_effects\status_effect_util.gsc;
#using script_59f07c660e6710a5;
#using scripts\core_common\ai\archetype_utility.gsc;
#using script_71dfbfdfba4489a0;
#using script_7b7ed6e4bc963a51;
#using script_caf007e2a98afa2;
#using script_db06eb511bd9b36;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\fx_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_behavior.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_hero_weapon.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_ai_ghost;

/*
	Name: __init__system__
	Namespace: zm_ai_ghost
	Checksum: 0x34AFB20D
	Offset: 0x248
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_ai_ghost", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_ai_ghost
	Checksum: 0x93985552
	Offset: 0x298
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	spawner::add_archetype_spawn_function(#"ghost", &function_cc3e52ff);
	spawner::add_archetype_spawn_function(#"ghost", &function_fe6a9772);
	zm_ai_ghost_interface::function_fd76c3b();
}

/*
	Name: __main__
	Namespace: zm_ai_ghost
	Checksum: 0x80F724D1
	Offset: 0x318
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: function_cc3e52ff
	Namespace: zm_ai_ghost
	Checksum: 0x47A8FD4F
	Offset: 0x328
	Size: 0x4A
	Parameters: 0
	Flags: Linked
*/
function function_cc3e52ff()
{
	blackboard::createblackboardforentity(self);
	ai::createinterfaceforentity(self);
	self.___archetypeonanimscriptedcallback = &function_f093c843;
}

/*
	Name: function_f093c843
	Namespace: zm_ai_ghost
	Checksum: 0xD353F921
	Offset: 0x380
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_f093c843(entity)
{
	entity.__blackboard = undefined;
	entity function_cc3e52ff();
}

/*
	Name: function_fe6a9772
	Namespace: zm_ai_ghost
	Checksum: 0x141D032E
	Offset: 0x3B8
	Size: 0x122
	Parameters: 0
	Flags: Linked, Private
*/
function private function_fe6a9772()
{
	self setblackboardattribute("_locomotion_speed", "locomotion_speed_walk");
	if(!isdefined(self.zombie_arms_position))
	{
		if(randomint(2) == 0)
		{
			self.zombie_arms_position = "up";
		}
		else
		{
			self.zombie_arms_position = "down";
		}
	}
	self.zombie_move_speed = "walk";
	self.variant_type = randomint(level.zm_variant_type_max[self.zombie_move_speed][self.zombie_arms_position]);
	self.zombie_think_done = 1;
	self setavoidancemask("avoid none");
	self collidewithactors(0);
	self setplayercollision(0);
	self.var_ccefa6dd = 1;
}

/*
	Name: function_cea6c2e0
	Namespace: zm_ai_ghost
	Checksum: 0x7EB0B731
	Offset: 0x4E8
	Size: 0x7C
	Parameters: 4
	Flags: Linked
*/
function function_cea6c2e0(entity, attribute, oldvalue, value)
{
	if(value === 1)
	{
		entity setblackboardattribute("_locomotion_speed", "locomotion_speed_run");
	}
	else
	{
		entity setblackboardattribute("_locomotion_speed", "locomotion_speed_walk");
	}
}

