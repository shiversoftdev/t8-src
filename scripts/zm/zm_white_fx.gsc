// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace zm_white_fx;

/*
	Name: init
	Namespace: zm_white_fx
	Checksum: 0x62C988D1
	Offset: 0x68
	Size: 0x1B2
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level._effect[#"large_ceiling_dust"] = #"hash_32cd6b127f58a7bf";
	level._effect[#"dog_gib"] = #"hash_7d69ee9822b45157";
	level._effect[#"teleport_depart"] = #"hash_1a6b5072e162ccd4";
	level._effect[#"teleport_arrive"] = #"hash_50655ac7dc942305";
	level._effect[#"portal_origin"] = #"hash_71d2bd3bb869430e";
	level._effect[#"portal_dest"] = #"maps/zm_office/fx8_teleporter_destination";
	level._effect[#"poltergeist"] = #"hash_2f079a0d04b14a46";
	level._effect[#"portal_spawn"] = #"maps/zm_office/fx8_teleporter_spawn";
	level._effect[#"portal_despawn"] = #"hash_4a9547ede284b0ba";
}

