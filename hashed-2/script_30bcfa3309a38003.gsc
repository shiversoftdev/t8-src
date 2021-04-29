// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_56cb7cd4a61c4db8;
#using script_6f708b088707e166;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_b3ee2bfb;

/*
	Name: main
	Namespace: namespace_b3ee2bfb
	Checksum: 0x8A3F5B58
	Offset: 0xC0
	Size: 0x84
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	namespace_13777bae::function_46e95cc7();
	namespace_13777bae::function_fa03fc55();
	clientfield::register("scriptmover", "follow_path_fx", 1, 1, "int", &follow_path_fx, 0, 0);
	namespace_2885895d::init();
}

/*
	Name: follow_path_fx
	Namespace: namespace_b3ee2bfb
	Checksum: 0xF92CD464
	Offset: 0x150
	Size: 0x94
	Parameters: 7
	Flags: None
*/
function follow_path_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.fx = util::playfxontag(localclientnum, #"zombie/fx_trail_blood_soul_zmb", self, "tag_origin");
	}
	else
	{
		stopfx(localclientnum, self.fx);
	}
}

