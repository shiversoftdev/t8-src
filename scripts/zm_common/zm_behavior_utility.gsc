// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\core_common\values_shared.gsc;
#using script_522aeb6ae906391e;
#using script_3aa0f32b70d4f7cb;
#using scripts\core_common\ai\archetype_utility.gsc;
#using script_4d85e8de54b02198;
#using script_caf007e2a98afa2;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;

#namespace zm_behavior_utility;

/*
	Name: setupattackproperties
	Namespace: zm_behavior_utility
	Checksum: 0x1C1AF0ED
	Offset: 0xD0
	Size: 0x3A
	Parameters: 0
	Flags: Linked
*/
function setupattackproperties()
{
	self val::reset(#"attack_properties", "ignoreall");
	self.meleeattackdist = 64;
}

/*
	Name: enteredplayablearea
	Namespace: zm_behavior_utility
	Checksum: 0x3D489227
	Offset: 0x118
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function enteredplayablearea()
{
	self zm_spawner::zombie_complete_emerging_into_playable_area();
	self.pushable = 1;
	self setupattackproperties();
}

