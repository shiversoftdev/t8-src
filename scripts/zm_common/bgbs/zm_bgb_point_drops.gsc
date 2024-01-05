// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_bgb_pack.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace zm_bgb_point_drops;

/*
	Name: __init__system__
	Namespace: zm_bgb_point_drops
	Checksum: 0x8244F3BE
	Offset: 0xB8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_bgb_point_drops", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_point_drops
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
	bgb::register(#"zm_bgb_point_drops", "activated", 1, undefined, undefined, &validation, &activation);
	bgb_pack::function_9d4db403(#"zm_bgb_point_drops", 5);
	bgb_pack::function_430d063b(#"zm_bgb_point_drops");
	bgb_pack::function_a1194b9a(#"zm_bgb_point_drops");
	bgb_pack::function_4de6c08a(#"zm_bgb_point_drops");
}

/*
	Name: activation
	Namespace: zm_bgb_point_drops
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
	Namespace: zm_bgb_point_drops
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

