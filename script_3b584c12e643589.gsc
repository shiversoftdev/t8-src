// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;
#using scripts\mp_common\item_world.csc;
#using scripts\core_common\struct.csc;

#namespace namespace_d0937679;

/*
	Name: __init__system__
	Namespace: namespace_d0937679
	Checksum: 0x5C02DD36
	Offset: 0xC8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_1f56d362760c2c6b", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_d0937679
	Checksum: 0xCA3DB4B1
	Offset: 0x110
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_fdbdcdfd = (isdefined(getgametypesetting(#"hash_6fbf57e2af153e5f")) ? getgametypesetting(#"hash_6fbf57e2af153e5f") : 0);
	level thread function_61a426a5();
}

/*
	Name: function_61a426a5
	Namespace: namespace_d0937679
	Checksum: 0xA2DF7F99
	Offset: 0x190
	Size: 0x202
	Parameters: 0
	Flags: Linked
*/
function function_61a426a5()
{
	debug_pos = getdvarint(#"hash_79ed3a19e0cdd3c5", -1);
	if(debug_pos < 0)
	{
		debug_pos = undefined;
	}
	zombie_apoc_homunculus = getdynent("zombie_apoc_homunculus");
	if(!isdefined(zombie_apoc_homunculus) && (!(isdefined(level.var_fdbdcdfd) && level.var_fdbdcdfd)))
	{
		return;
	}
	item_world::function_4de3ca98();
	if(isdefined(zombie_apoc_homunculus))
	{
		points = struct::get_array("zombie_apoc_homunculus_point", "targetname");
		if(isdefined(points))
		{
			for(index = 0; index < points.size; index++)
			{
				randindex = function_d59c2d03(points.size);
				var_521b73a = points[index];
				points[index] = points[randindex];
				points[randindex] = var_521b73a;
			}
			randindex = function_d59c2d03(points.size);
			if(isdefined(debug_pos))
			{
				zombie_apoc_homunculus.origin = points[debug_pos].origin;
				zombie_apoc_homunculus.angles = points[debug_pos].angles;
			}
			else
			{
				zombie_apoc_homunculus.origin = points[randindex].origin;
				zombie_apoc_homunculus.angles = points[randindex].angles;
			}
		}
	}
}

