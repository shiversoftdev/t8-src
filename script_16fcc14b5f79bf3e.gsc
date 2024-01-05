// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\zm_red_main_quest.gsc;
#using scripts\zm_common\zm_ui_inventory.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_efec71f7;

/*
	Name: __init__system__
	Namespace: namespace_efec71f7
	Checksum: 0xE552E8F9
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_3db89e7dfe4633b0", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_efec71f7
	Checksum: 0x3E514D2C
	Offset: 0xE0
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!zm_trial::is_trial_mode())
	{
		return;
	}
	zm_trial::register_challenge(#"hash_285312733a97eea3", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: namespace_efec71f7
	Checksum: 0x9F359C0E
	Offset: 0x148
	Size: 0x64
	Parameters: 0
	Flags: Linked, Private
*/
function private on_begin()
{
	level zm_ui_inventory::function_7df6bb60(#"zm_red_objective_progress", 5);
	if(!(isdefined(level.var_4e4909a6) && level.var_4e4909a6))
	{
		level thread function_57755268();
	}
}

/*
	Name: on_end
	Namespace: namespace_efec71f7
	Checksum: 0x897829D7
	Offset: 0x1B8
	Size: 0x66
	Parameters: 1
	Flags: Linked, Private
*/
function private on_end(round_reset)
{
	if(!round_reset)
	{
		if(!(isdefined(level.var_84199d1) && level.var_84199d1))
		{
			zm_trial::fail(undefined, getplayers());
		}
	}
	level.var_84199d1 = undefined;
}

/*
	Name: function_57755268
	Namespace: namespace_efec71f7
	Checksum: 0x8282395F
	Offset: 0x228
	Size: 0xA0
	Parameters: 0
	Flags: Linked
*/
function function_57755268()
{
	level endon(#"end_game");
	level.var_4e4909a6 = 1;
	zm_red_main_quest::play_think();
	zm_red_main_quest::play_cleanup(0, 0);
	level.var_84199d1 = 1;
	level.var_4e4909a6 = undefined;
	level endon(#"hash_7646638df88a3656");
	wait(5);
	level notify(#"kill_round_wait");
}

