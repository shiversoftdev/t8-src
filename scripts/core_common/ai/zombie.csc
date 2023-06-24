// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14d2d89964cae0b1;
#using script_ac6a30f1991e105;
#using scripts\core_common\ai_shared.csc;
#using scripts\core_common\clientfield_shared.csc;

#namespace zombie;

/*
	Name: main
	Namespace: zombie
	Checksum: 0x969AD952
	Offset: 0xD0
	Size: 0x124
	Parameters: 0
	Flags: AutoExec
*/
function autoexec main()
{
	level._effect[#"zombie_special_day_effect"] = #"hash_7a37324c1988abb5";
	ai::add_archetype_spawn_function(#"zombie", &zombieclientutils::zombie_override_burn_fx);
	ai::add_archetype_spawn_function(#"zombie", &zombieclientutils::zombiespawnsetup);
	clientfield::register("actor", "zombie", 1, 1, "int", &zombieclientutils::zombiehandler, 0, 0);
	clientfield::register("actor", "zombie_special_day", 1, 1, "counter", &zombieclientutils::zombiespecialdayeffectshandler, 0, 0);
}

#namespace zombieclientutils;

/*
	Name: zombiehandler
	Namespace: zombieclientutils
	Checksum: 0xF8BC8A95
	Offset: 0x200
	Size: 0x17C
	Parameters: 7
	Flags: Linked
*/
function zombiehandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	entity = self;
	if(isdefined(entity.archetype) && entity.archetype != #"zombie")
	{
		return;
	}
	if(!isdefined(entity.initializedgibcallbacks) || !entity.initializedgibcallbacks)
	{
		entity.initializedgibcallbacks = 1;
		gibclientutils::addgibcallback(localclientnum, entity, 8, &_gibcallback);
		gibclientutils::addgibcallback(localclientnum, entity, 16, &_gibcallback);
		gibclientutils::addgibcallback(localclientnum, entity, 32, &_gibcallback);
		gibclientutils::addgibcallback(localclientnum, entity, 128, &_gibcallback);
		gibclientutils::addgibcallback(localclientnum, entity, 256, &_gibcallback);
	}
}

/*
	Name: _gibcallback
	Namespace: zombieclientutils
	Checksum: 0x94437C6
	Offset: 0x388
	Size: 0xFA
	Parameters: 3
	Flags: Linked, Private
*/
function private _gibcallback(localclientnum, entity, gibflag)
{
	switch(gibflag)
	{
		case 8:
		{
			playsound(0, #"zmb_zombie_head_gib", self.origin + vectorscale((0, 0, 1), 60));
			break;
		}
		case 16:
		case 32:
		case 128:
		case 256:
		{
			playsound(0, #"zmb_death_gibs", self.origin + vectorscale((0, 0, 1), 30));
			break;
		}
	}
}

/*
	Name: zombiespecialdayeffectshandler
	Namespace: zombieclientutils
	Checksum: 0x856553CB
	Offset: 0x490
	Size: 0x104
	Parameters: 7
	Flags: Linked
*/
function zombiespecialdayeffectshandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	entity = self;
	if(isdefined(entity.archetype) && entity.archetype != #"zombie")
	{
		return;
	}
	origin = entity gettagorigin("j_spine4");
	fx = playfx(localclientnum, level._effect[#"zombie_special_day_effect"], origin);
	setfxignorepause(localclientnum, fx, 1);
}

/*
	Name: zombie_override_burn_fx
	Namespace: zombieclientutils
	Checksum: 0x5F01B077
	Offset: 0x5A0
	Size: 0x212
	Parameters: 1
	Flags: Linked
*/
function zombie_override_burn_fx(localclientnum)
{
	if(sessionmodeiszombiesgame())
	{
		if(!isdefined(self._effect))
		{
			self._effect = [];
		}
		level._effect[#"fire_zombie_j_elbow_le_loop"] = #"fire/fx_fire_ai_human_arm_left_loop";
		level._effect[#"fire_zombie_j_elbow_ri_loop"] = #"fire/fx_fire_ai_human_arm_right_loop";
		level._effect[#"fire_zombie_j_shoulder_le_loop"] = #"fire/fx_fire_ai_human_arm_left_loop";
		level._effect[#"fire_zombie_j_shoulder_ri_loop"] = #"fire/fx_fire_ai_human_arm_right_loop";
		level._effect[#"fire_zombie_j_spine4_loop"] = #"fire/fx_fire_ai_human_torso_loop";
		level._effect[#"fire_zombie_j_hip_le_loop"] = #"fire/fx_fire_ai_human_hip_left_loop";
		level._effect[#"fire_zombie_j_hip_ri_loop"] = #"fire/fx_fire_ai_human_hip_right_loop";
		level._effect[#"fire_zombie_j_knee_le_loop"] = #"fire/fx_fire_ai_human_leg_left_loop";
		level._effect[#"fire_zombie_j_knee_ri_loop"] = #"fire/fx_fire_ai_human_leg_right_loop";
		level._effect[#"fire_zombie_j_head_loop"] = #"fire/fx_fire_ai_human_head_loop";
	}
}

/*
	Name: zombiespawnsetup
	Namespace: zombieclientutils
	Checksum: 0xA9701B77
	Offset: 0x7C0
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function zombiespawnsetup(localclientnum)
{
	fxclientutils::playfxbundle(localclientnum, self, self.fxdef);
}

