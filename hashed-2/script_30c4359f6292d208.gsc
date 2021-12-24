// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_ca2d9d65;

/*
	Name: function_89f2df9
	Namespace: namespace_ca2d9d65
	Checksum: 0xF44498FC
	Offset: 0xD8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_55c97cd74c2ed150", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_ca2d9d65
	Checksum: 0x7B2F8D74
	Offset: 0x120
	Size: 0x7A
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("toplayer", "audio_log_ball_fx", 1, 3, "int", &function_50865dc7, 0, 0);
	level._effect[#"hash_660550377f6cb3e3"] = #"hash_445f04139d92c61b";
}

/*
	Name: function_50865dc7
	Namespace: namespace_ca2d9d65
	Checksum: 0x1683DE33
	Offset: 0x1A8
	Size: 0x154
	Parameters: 7
	Flags: Linked
*/
function function_50865dc7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	a_s_locs = struct::get_array("office_audio_log_schuster");
	foreach(s_loc in a_s_locs)
	{
		if((s_loc.var_614bfc5c + 1) == newval)
		{
			var_a1cf77d2 = util::spawn_model(localclientnum, "tag_origin", s_loc.origin, s_loc.angles);
			break;
		}
	}
	util::playfxontag(localclientnum, level._effect[#"hash_660550377f6cb3e3"], var_a1cf77d2, "tag_origin");
}

