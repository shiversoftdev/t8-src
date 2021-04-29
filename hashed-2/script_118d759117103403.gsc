// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\scene_shared.csc;

#namespace flowgraph_scene;

/*
	Name: playscenefunc
	Namespace: flowgraph_scene
	Checksum: 0x12330EC0
	Offset: 0x70
	Size: 0x84
	Parameters: 4
	Flags: None
*/
function playscenefunc(x, e_entity, sb_name, b_thread)
{
	target = e_entity;
	if(!isdefined(target))
	{
		target = level;
	}
	if(b_thread)
	{
		target thread scene::play(sb_name);
	}
	else
	{
		target scene::play(sb_name);
	}
}

