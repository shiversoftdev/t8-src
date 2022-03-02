// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\exploder_shared.gsc;

#namespace flowgraph_fx;

/*
	Name: playfxatposition
	Namespace: flowgraph_fx
	Checksum: 0xC0C4AF23
	Offset: 0x70
	Size: 0x50
	Parameters: 5
	Flags: None
*/
function playfxatposition(x, fx_effect, v_position, v_forward, v_up)
{
	playfx(fx_effect, v_position, v_forward, v_up);
	return true;
}

/*
	Name: function_f4373d13
	Namespace: flowgraph_fx
	Checksum: 0x2C7D6DD6
	Offset: 0xC8
	Size: 0x60
	Parameters: 6
	Flags: None
*/
function function_f4373d13(x, fx_effect, v_offset, v_forward, v_up, var_a1a2ff27)
{
	playfxoncamera(fx_effect, v_offset, v_forward, v_up, var_a1a2ff27);
	return true;
}

#namespace namespace_84ba1809;

/*
	Name: playexploder
	Namespace: namespace_84ba1809
	Checksum: 0x3A53782D
	Offset: 0x130
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function playexploder(x, str_name)
{
	exploder::exploder(str_name);
	return true;
}

/*
	Name: stopexploder
	Namespace: namespace_84ba1809
	Checksum: 0xADCB168E
	Offset: 0x168
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function stopexploder(x, str_name)
{
	exploder::stop_exploder(str_name);
	return true;
}

/*
	Name: killexploder
	Namespace: namespace_84ba1809
	Checksum: 0x2D7CC2AB
	Offset: 0x1A0
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function killexploder(x, str_name)
{
	exploder::kill_exploder(str_name);
	return true;
}

