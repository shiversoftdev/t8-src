// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_61a734c95edc17aa;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_score.gsc;

#namespace namespace_626b0a08;

/*
	Name: function_89f2df9
	Namespace: namespace_626b0a08
	Checksum: 0x8244F3BE
	Offset: 0xB8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_177ea318753f5418", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: namespace_626b0a08
	Checksum: 0x11E3193A
	Offset: 0x108
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"hash_177ea318753f5418", "activated", 1, undefined, undefined, &validation, &activation);
	bgb_pack::function_9d4db403(#"hash_177ea318753f5418", 5);
	bgb_pack::function_430d063b(#"hash_177ea318753f5418");
	bgb_pack::function_a1194b9a(#"hash_177ea318753f5418");
	bgb_pack::function_4de6c08a(#"hash_177ea318753f5418");
}

/*
	Name: activation
	Namespace: namespace_626b0a08
	Checksum: 0x527DA651
	Offset: 0x210
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function activation()
{
	self zm_score::minus_to_player_score(500);
	self thread bgb::function_c6cd71d5("bonus_points_player_shared");
}

/*
	Name: validation
	Namespace: namespace_626b0a08
	Checksum: 0x12CD187A
	Offset: 0x258
	Size: 0x40
	Parameters: 0
	Flags: Linked
*/
function validation()
{
	if(self zm_score::can_player_purchase(500) && self bgb::function_9d8118f5())
	{
		return true;
	}
	return false;
}

