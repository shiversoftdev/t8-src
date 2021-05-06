// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_16b1c195c0b9a9c;
#using script_31e56101095f174b;
#using script_39c61335d85620af;
#using script_3d2e260ec67fded8;
#using script_7312bc36741c9418;

#namespace namespace_939fc294;

/*
	Name: function_ce59625f
	Namespace: namespace_939fc294
	Checksum: 0x49D2C99E
	Offset: 0xA8
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function function_ce59625f(team)
{
	planner = plannerutility::createplannerfromasset("mp_koth_squad.ai_htn");
	return planner;
}

