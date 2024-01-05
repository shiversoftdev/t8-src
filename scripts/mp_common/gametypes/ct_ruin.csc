// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\mp_common\gametypes\ct_ruin_tutorial.csc;
#using scripts\mp_common\gametypes\ct_core.csc;

#namespace ct_ruin;

/*
	Name: main
	Namespace: ct_ruin
	Checksum: 0x8A3F5B58
	Offset: 0xC0
	Size: 0x84
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	ct_core::function_46e95cc7();
	ct_core::function_fa03fc55();
	clientfield::register("scriptmover", "follow_path_fx", 1, 1, "int", &follow_path_fx, 0, 0);
	ct_ruin_tutorial::init();
}

/*
	Name: follow_path_fx
	Namespace: ct_ruin
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

