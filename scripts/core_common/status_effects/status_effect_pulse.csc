// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\filter_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\audio_shared.csc;

#namespace status_effect_pulse;

/*
	Name: __init__system__
	Namespace: status_effect_pulse
	Checksum: 0x68D993BA
	Offset: 0xB8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"status_effect_pulse", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: status_effect_pulse
	Checksum: 0xB84E94FB
	Offset: 0x100
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("toplayer", "pulsed", 1, 1, "int", &on_pulsed_change, 0, 0);
}

/*
	Name: on_pulsed_change
	Namespace: status_effect_pulse
	Checksum: 0xFA36BCA6
	Offset: 0x158
	Size: 0xA4
	Parameters: 7
	Flags: Linked
*/
function on_pulsed_change(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	localplayer = function_5c10bd79(localclientnum);
	if(newval == 1)
	{
		self start_pulse_effects(localplayer);
	}
	else
	{
		self stop_pulse_effects(localplayer, oldval);
	}
}

/*
	Name: start_pulse_effects
	Namespace: status_effect_pulse
	Checksum: 0xBA864091
	Offset: 0x208
	Size: 0xBC
	Parameters: 2
	Flags: Linked
*/
function start_pulse_effects(localplayer, bwastimejump = 0)
{
	filter::init_filter_tactical(localplayer);
	filter::enable_filter_tactical(localplayer, 2);
	filter::set_filter_tactical_amount(localplayer, 2, 1);
	if(!bwastimejump)
	{
		playsound(0, #"mpl_plr_emp_activate", (0, 0, 0));
	}
	audio::playloopat("mpl_plr_emp_looper", (0, 0, 0));
}

/*
	Name: stop_pulse_effects
	Namespace: status_effect_pulse
	Checksum: 0xF073487C
	Offset: 0x2D0
	Size: 0xB4
	Parameters: 3
	Flags: Linked
*/
function stop_pulse_effects(localplayer, oldval, bwastimejump = 0)
{
	filter::init_filter_tactical(localplayer);
	filter::disable_filter_tactical(localplayer, 2);
	if(oldval != 0 && !bwastimejump)
	{
		playsound(0, #"mpl_plr_emp_deactivate", (0, 0, 0));
	}
	audio::stoploopat("mpl_plr_emp_looper", (0, 0, 0));
}

