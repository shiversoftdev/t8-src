// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_trial.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace zm_trial_door_lockdown;

/*
	Name: __init__system__
	Namespace: zm_trial_door_lockdown
	Checksum: 0x9CA5C7C3
	Offset: 0x128
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_trial_door_lockdown", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_trial_door_lockdown
	Checksum: 0xD7889D34
	Offset: 0x170
	Size: 0x124
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!zm_trial::is_trial_mode())
	{
		return;
	}
	clientfield::register("scriptmover", "" + #"zm_trial_door_lockdown", 16000, 1, "int", &zm_trial_door_lockdown, 0, 0);
	level._effect[#"hash_351debe7af1f588b"] = "maps/zm_escape/fx8_flame_wall_64x64";
	level._effect[#"hash_257bf4ae70b5a852"] = "maps/zm_escape/fx8_flame_wall_128x128";
	level._effect[#"hash_3ea271ae7eb7fdce"] = "maps/zm_escape/fx8_flame_wall_256x256";
	zm_trial::register_challenge(#"door_lockdown", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: zm_trial_door_lockdown
	Checksum: 0x52CAAEAA
	Offset: 0x2A0
	Size: 0x14
	Parameters: 2
	Flags: Private
*/
function private on_begin(localclientnum, a_params)
{
}

/*
	Name: on_end
	Namespace: zm_trial_door_lockdown
	Checksum: 0xF594C3AB
	Offset: 0x2C0
	Size: 0xC
	Parameters: 1
	Flags: Private
*/
function private on_end(localclientnum)
{
}

/*
	Name: zm_trial_door_lockdown
	Namespace: zm_trial_door_lockdown
	Checksum: 0xBE5D08EB
	Offset: 0x2D8
	Size: 0x1B6
	Parameters: 7
	Flags: Private
*/
function private zm_trial_door_lockdown(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		v_forward = anglestoforward(self.angles);
		switch(self.model)
		{
			case "collision_player_wall_64x64x10":
			{
				var_b1e1a2db = level._effect[#"hash_351debe7af1f588b"];
				break;
			}
			case "collision_player_wall_128x128x10":
			{
				var_b1e1a2db = level._effect[#"hash_257bf4ae70b5a852"];
				break;
			}
			case "collision_player_wall_256x256x10":
			{
				var_b1e1a2db = level._effect[#"hash_3ea271ae7eb7fdce"];
				break;
			}
			default:
			{
				var_b1e1a2db = level._effect[#"hash_257bf4ae70b5a852"];
				break;
			}
		}
		self.var_958e3374 = playfx(localclientnum, var_b1e1a2db, self.origin - vectorscale((0, 0, 1), 48), v_forward);
	}
	else if(isdefined(self.var_958e3374))
	{
		stopfx(localclientnum, self.var_958e3374);
		self.var_958e3374 = undefined;
	}
}

