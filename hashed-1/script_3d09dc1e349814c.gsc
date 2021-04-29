// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3c362258ff800237;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_6f53a9bb;

/*
	Name: function_89f2df9
	Namespace: namespace_6f53a9bb
	Checksum: 0x9CA5C7C3
	Offset: 0x128
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_530f1e3dbb50b5f6", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_6f53a9bb
	Checksum: 0xD7889D34
	Offset: 0x170
	Size: 0x124
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!namespace_f551babc::function_b47f6aba())
	{
		return;
	}
	clientfield::register("scriptmover", "" + #"hash_530f1e3dbb50b5f6", 16000, 1, "int", &function_6f53a9bb, 0, 0);
	level._effect[#"hash_351debe7af1f588b"] = "maps/zm_escape/fx8_flame_wall_64x64";
	level._effect[#"hash_257bf4ae70b5a852"] = "maps/zm_escape/fx8_flame_wall_128x128";
	level._effect[#"hash_3ea271ae7eb7fdce"] = "maps/zm_escape/fx8_flame_wall_256x256";
	namespace_f551babc::register_challenge(#"hash_6f720e698e84015d", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_6f53a9bb
	Checksum: 0x52CAAEAA
	Offset: 0x2A0
	Size: 0x14
	Parameters: 2
	Flags: Private
*/
private function function_d1de6a85(localclientnum, a_params)
{
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_6f53a9bb
	Checksum: 0xF594C3AB
	Offset: 0x2C0
	Size: 0xC
	Parameters: 1
	Flags: Private
*/
private function function_9e7b3f4d(localclientnum)
{
}

/*
	Name: function_6f53a9bb
	Namespace: namespace_6f53a9bb
	Checksum: 0xBE5D08EB
	Offset: 0x2D8
	Size: 0x1B6
	Parameters: 7
	Flags: Private
*/
private function function_6f53a9bb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
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

