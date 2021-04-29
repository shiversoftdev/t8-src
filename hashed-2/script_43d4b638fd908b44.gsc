// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace flowgraph_spawn;

/*
	Name: spawnentityfromspawner
	Namespace: flowgraph_spawn
	Checksum: 0x2F1BAD38
	Offset: 0x68
	Size: 0x7A
	Parameters: 6
	Flags: None
*/
function spawnentityfromspawner(x, sp_spawner, str_targetname, b_force_spawn, b_make_room, b_infinite_spawn)
{
	e_spawned = sp_spawner spawnfromspawner(str_targetname, b_force_spawn, b_make_room, b_infinite_spawn);
	return array(isdefined(e_spawned), e_spawned);
}

