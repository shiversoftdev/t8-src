// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_158d50d476435605;
#using scripts\core_common\delete.csc;
#using scripts\core_common\dev_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace load;

/*
	Name: function_89f2df9
	Namespace: load
	Checksum: 0xD172C387
	Offset: 0xB8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"load", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: load
	Checksum: 0x4C3E5558
	Offset: 0x100
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(sessionmodeiscampaigngame())
	{
		level.game_mode_suffix = "_cp";
	}
	else if(sessionmodeiszombiesgame())
	{
		level.game_mode_suffix = "_zm";
	}
	else
	{
		level.game_mode_suffix = "_mp";
	}
	/#
		level thread first_frame();
	#/
	apply_mature_filter();
}

/*
	Name: first_frame
	Namespace: load
	Checksum: 0x7E17003D
	Offset: 0x1A8
	Size: 0x26
	Parameters: 0
	Flags: None
*/
function first_frame()
{
	/#
		level.first_frame = 1;
		waitframe(1);
		level.first_frame = undefined;
	#/
}

/*
	Name: apply_mature_filter
	Namespace: load
	Checksum: 0x2AFB7175
	Offset: 0x1D8
	Size: 0xA8
	Parameters: 0
	Flags: Linked
*/
function apply_mature_filter()
{
	if(!util::is_mature())
	{
		a_mature_models = findstaticmodelindexarray("mature_content");
		foreach(model in a_mature_models)
		{
			hidestaticmodel(model);
		}
	}
}

/*
	Name: art_review
	Namespace: load
	Checksum: 0xB16884E9
	Offset: 0x288
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function art_review()
{
	if(getdvarint(#"art_review", 0))
	{
		level waittill(#"forever");
	}
}

