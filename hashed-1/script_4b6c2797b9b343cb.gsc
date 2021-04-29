// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14d2d89964cae0b1;
#using script_ac6a30f1991e105;
#using scripts\core_common\ai_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace zodcompanionclientutils;

/*
	Name: function_89f2df9
	Namespace: zodcompanionclientutils
	Checksum: 0xD370C438
	Offset: 0x160
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_zod_companion", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zodcompanionclientutils
	Checksum: 0x407DB045
	Offset: 0x1A8
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("allplayers", "being_robot_revived", 1, 1, "int", &play_revival_fx, 0, 0);
	ai::add_archetype_spawn_function(#"zod_companion", &zodcompanionspawnsetup);
	level._effect[#"fx_dest_robot_head_sparks"] = "destruct/fx_dest_robot_head_sparks";
	level._effect[#"fx_dest_robot_body_sparks"] = "destruct/fx_dest_robot_body_sparks";
	level._effect[#"companion_revive_effect"] = "zombie/fx_robot_helper_revive_player_zod_zmb";
	ai::add_archetype_spawn_function(#"robot", &zodcompanionspawnsetup);
}

/*
	Name: zodcompanionspawnsetup
	Namespace: zodcompanionclientutils
	Checksum: 0xA916EB4A
	Offset: 0x2D8
	Size: 0x12C
	Parameters: 1
	Flags: Linked, Private
*/
private function zodcompanionspawnsetup(localclientnum)
{
	entity = self;
	gibclientutils::addgibcallback(localclientnum, entity, 8, &zodcompanionheadgibfx);
	gibclientutils::addgibcallback(localclientnum, entity, 8, &_gibcallback);
	gibclientutils::addgibcallback(localclientnum, entity, 16, &_gibcallback);
	gibclientutils::addgibcallback(localclientnum, entity, 32, &_gibcallback);
	gibclientutils::addgibcallback(localclientnum, entity, 128, &_gibcallback);
	gibclientutils::addgibcallback(localclientnum, entity, 256, &_gibcallback);
	fxclientutils::playfxbundle(localclientnum, entity, entity.fxdef);
}

/*
	Name: zodcompanionheadgibfx
	Namespace: zodcompanionclientutils
	Checksum: 0xFD825A4B
	Offset: 0x410
	Size: 0x10C
	Parameters: 3
	Flags: Linked
*/
function zodcompanionheadgibfx(localclientnum, entity, gibflag)
{
	if(!isdefined(entity) || !entity isai() || !isalive(entity))
	{
		return;
	}
	if(isdefined(entity.mindcontrolheadfx))
	{
		stopfx(localclientnum, entity.mindcontrolheadfx);
		entity.mindcontrolheadfx = undefined;
	}
	entity.headgibfx = util::playfxontag(localclientnum, level._effect[#"fx_dest_robot_head_sparks"], entity, "j_neck");
	playsound(0, #"prj_bullet_impact_robot_headshot", entity.origin);
}

/*
	Name: zodcompaniondamagedfx
	Namespace: zodcompanionclientutils
	Checksum: 0xC41CCA11
	Offset: 0x528
	Size: 0x9E
	Parameters: 2
	Flags: None
*/
function zodcompaniondamagedfx(localclientnum, entity)
{
	if(!isdefined(entity) || !entity isai() || !isalive(entity))
	{
		return;
	}
	entity.damagedfx = util::playfxontag(localclientnum, level._effect[#"fx_dest_robot_body_sparks"], entity, "j_spine4");
}

/*
	Name: zodcompanionclearfx
	Namespace: zodcompanionclientutils
	Checksum: 0xC5AE02E2
	Offset: 0x5D0
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function zodcompanionclearfx(localclientnum, entity)
{
	if(!isdefined(entity) || !entity isai())
	{
		return;
	}
}

/*
	Name: _gibcallback
	Namespace: zodcompanionclientutils
	Checksum: 0x52E182EE
	Offset: 0x618
	Size: 0xBA
	Parameters: 3
	Flags: Linked, Private
*/
private function _gibcallback(localclientnum, entity, gibflag)
{
	if(!isdefined(entity) || !entity isai())
	{
		return;
	}
	switch(gibflag)
	{
		case 8:
		{
			break;
		}
		case 16:
		{
			break;
		}
		case 32:
		{
			break;
		}
		case 128:
		{
			break;
		}
		case 256:
		{
			break;
		}
	}
}

/*
	Name: play_revival_fx
	Namespace: zodcompanionclientutils
	Checksum: 0x80816E53
	Offset: 0x6E0
	Size: 0xF2
	Parameters: 7
	Flags: Linked
*/
function play_revival_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.robot_revival_fx) && oldval == 1 && newval == 0)
	{
		stopfx(localclientnum, self.robot_revival_fx);
	}
	if(newval === 1)
	{
		self playsound(0, #"evt_civil_protector_revive_plr");
		self.robot_revival_fx = util::playfxontag(localclientnum, level._effect[#"companion_revive_effect"], self, "j_spineupper");
	}
}

