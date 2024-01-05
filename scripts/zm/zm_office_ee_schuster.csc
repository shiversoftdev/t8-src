// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace zm_office_ee_schuster;

/*
	Name: __init__system__
	Namespace: zm_office_ee_schuster
	Checksum: 0xF44498FC
	Offset: 0xD8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_office_ee_schuster", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_office_ee_schuster
	Checksum: 0x7B2F8D74
	Offset: 0x120
	Size: 0x7A
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("toplayer", "audio_log_ball_fx", 1, 3, "int", &function_50865dc7, 0, 0);
	level._effect[#"audio_ball"] = #"hash_445f04139d92c61b";
}

/*
	Name: function_50865dc7
	Namespace: zm_office_ee_schuster
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
	util::playfxontag(localclientnum, level._effect[#"audio_ball"], var_a1cf77d2, "tag_origin");
}

