// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace loot;

/*
	Name: function_13afbf2d
	Namespace: loot
	Checksum: 0x8DD87028
	Offset: 0x68
	Size: 0x10C
	Parameters: 2
	Flags: None
*/
function function_13afbf2d(lootid, name)
{
	if(!isplayer(self))
	{
		return;
	}
	player = self;
	eventparams = {#pos_z:player.origin[2], #pos_y:player.origin[1], #pos_x:player.origin[0], #gametime:function_f8d53445(), #hash_ac352d59:name, #loot_id:lootid};
	function_92d1707f(#"hash_6e269493db33fcf7", eventparams);
}

