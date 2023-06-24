// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_maptable.csc;
#using scripts\core_common\system_shared.csc;

#namespace zm_weap_bowie;

/*
	Name: __init__system__
	Namespace: zm_weap_bowie
	Checksum: 0x54A035E9
	Offset: 0xF8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"bowie_knife", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_weap_bowie
	Checksum: 0x80F724D1
	Offset: 0x148
	Size: 0x4
	Parameters: 0
	Flags: Linked, Private
*/
function private __init__()
{
}

/*
	Name: __main__
	Namespace: zm_weap_bowie
	Checksum: 0xBFA561A4
	Offset: 0x158
	Size: 0xC6
	Parameters: 0
	Flags: Linked, Private
*/
function private __main__()
{
	level.var_8e4168e9 = "bowie_knife";
	level.var_63af3e00 = "bowie_flourish";
	var_57858dd5 = "zombie_fists_bowie";
	if(zm_maptable::get_story() == 1)
	{
		level.var_8e4168e9 = "bowie_knife_story_1";
		level.var_63af3e00 = "bowie_flourish_story_1";
		var_57858dd5 = "zombie_fists_bowie_story_1";
	}
	level.w_bowie_knife = getweapon(hash(level.var_8e4168e9));
}

