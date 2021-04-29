// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace zm_game_module_utility;

/*
	Name: move_ring
	Namespace: zm_game_module_utility
	Checksum: 0x41AAF03A
	Offset: 0x88
	Size: 0x12A
	Parameters: 1
	Flags: None
*/
function move_ring(ring)
{
	positions = struct::get_array(ring.target, "targetname");
	positions = array::randomize(positions);
	level endon(#"end_game");
	while(true)
	{
		foreach(position in positions)
		{
			self moveto(position.origin, randomintrange(30, 45));
			self waittill(#"movedone");
		}
	}
}

/*
	Name: rotate_ring
	Namespace: zm_game_module_utility
	Checksum: 0xA7A41002
	Offset: 0x1C0
	Size: 0x6E
	Parameters: 1
	Flags: None
*/
function rotate_ring(forward)
{
	level endon(#"end_game");
	dir = -360;
	if(forward)
	{
		dir = 360;
	}
	while(true)
	{
		self rotateyaw(dir, 9);
		wait(9);
	}
}

