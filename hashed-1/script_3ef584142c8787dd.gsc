// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_59f07c660e6710a5;
#using script_638bbfbdda7eff95;
#using script_6809bf766eba194a;

#namespace civilianinterface;

/*
	Name: registercivilianinterfaceattributes
	Namespace: civilianinterface
	Checksum: 0x68503044
	Offset: 0xA0
	Size: 0x1DC
	Parameters: 0
	Flags: Linked
*/
function registercivilianinterfaceattributes()
{
	ai::registermatchedinterface(#"civilian", #"disablearrivals", 0, array(1, 0), &aiutility::arrivalattributescallback);
	ai::registermatchedinterface(#"civilian", #"hash_78e762abc4fbf1de", "calm", array("calm", "panic", "riot", "run"));
	ai::registermatchedinterface(#"civilian", #"auto_escape", 1, array(1, 0));
	ai::registermatchedinterface(#"civilian", #"auto_wander", 1, array(1, 0));
	ai::registermatchedinterface(#"civilian", #"usegrenades", 1, array(1, 0));
	ai::registerentityinterface(#"civilian", #"follow", undefined, &archetypecivilian::function_49d80e54);
}

