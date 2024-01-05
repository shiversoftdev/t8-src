// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace flowgraph_sound;

/*
	Name: playsoundaliasatposition
	Namespace: flowgraph_sound
	Checksum: 0x8A6C7A8B
	Offset: 0x68
	Size: 0x38
	Parameters: 3
	Flags: None
*/
function playsoundaliasatposition(x, snd_name, v_position)
{
	playsoundatposition(snd_name, v_position);
	return true;
}

