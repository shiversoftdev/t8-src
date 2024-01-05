// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\flowgraph\flowgraph_core.csc;

#namespace flowgraph_trigger;

/*
	Name: ontriggerentered
	Namespace: flowgraph_trigger
	Checksum: 0xC9A372E
	Offset: 0x70
	Size: 0xA0
	Parameters: 2
	Flags: None
*/
function ontriggerentered(x, e_trigger)
{
	e_trigger endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = e_trigger waittill(#"trigger");
		e_entity = waitresult.activator;
		self flowgraph::kick(array(1, e_entity));
	}
}

