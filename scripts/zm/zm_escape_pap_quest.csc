// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\util_shared.csc;

#namespace pap_quest;

/*
	Name: init
	Namespace: pap_quest
	Checksum: 0x5D826ED8
	Offset: 0x120
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level._effect[#"lightning_near"] = "maps/zm_escape/fx8_pap_lightning_near";
	level._effect[#"lightning_bridge"] = "maps/zm_escape/fx8_pap_lightning_bridge";
	function_842831cf();
}

/*
	Name: function_842831cf
	Namespace: pap_quest
	Checksum: 0xD66CB6C2
	Offset: 0x190
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_842831cf()
{
	clientfield::register("world", "" + #"hash_3fcd3bbe36f86e4b", 1, 1, "counter", &function_5cb90582, 0, 0);
	clientfield::register("scriptmover", "" + #"lightning_near", 1, 1, "counter", &lightning_near_fx, 0, 0);
}

/*
	Name: lightning_near_fx
	Namespace: pap_quest
	Checksum: 0xD77CCBDC
	Offset: 0x250
	Size: 0xCC
	Parameters: 7
	Flags: Linked
*/
function lightning_near_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(self == level)
	{
		s_lightning_near = struct::get("lightning_near");
		v_origin = s_lightning_near.origin;
	}
	else
	{
		v_origin = self.origin;
	}
	playfx(localclientnum, level._effect[#"lightning_near"], v_origin);
}

/*
	Name: function_5cb90582
	Namespace: pap_quest
	Checksum: 0x7CCFC09E
	Offset: 0x328
	Size: 0xEC
	Parameters: 7
	Flags: Linked
*/
function function_5cb90582(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	s_lightning_bridge = struct::get("lightning_bridge");
	playfx(localclientnum, level._effect[#"lightning_bridge"], s_lightning_bridge.origin, vectornormalize(anglestoforward(s_lightning_bridge.angles)), vectornormalize(anglestoup(s_lightning_bridge.angles)));
}

