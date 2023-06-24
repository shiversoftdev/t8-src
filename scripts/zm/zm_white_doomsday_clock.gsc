// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace zm_white_doomsday_clock;

/*
	Name: init
	Namespace: zm_white_doomsday_clock
	Checksum: 0xD9491CF8
	Offset: 0xB8
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level thread function_c720fa94();
}

/*
	Name: function_c720fa94
	Namespace: zm_white_doomsday_clock
	Checksum: 0x2A2E0A59
	Offset: 0xE0
	Size: 0x78
	Parameters: 0
	Flags: Linked
*/
function function_c720fa94()
{
	var_e323931b = getent("e_doomsday_clock_min_hand", "targetname");
	var_e323931b.position = 0;
	while(true)
	{
		level waittill(#"update_doomsday_clock");
		level thread update_doomsday_clock(var_e323931b);
	}
}

/*
	Name: update_doomsday_clock
	Namespace: zm_white_doomsday_clock
	Checksum: 0x39652C57
	Offset: 0x160
	Size: 0x15E
	Parameters: 1
	Flags: Linked
*/
function update_doomsday_clock(var_e323931b)
{
	while(var_e323931b.is_updating === 1)
	{
		wait(0.05);
	}
	var_e323931b.is_updating = 1;
	if(var_e323931b.position == 0)
	{
		var_e323931b.position = 3;
		var_e323931b rotatepitch(-90, 1);
		var_e323931b playsound("zmb_clock_hand");
		var_e323931b waittill(#"rotatedone");
		var_e323931b playsound("zmb_clock_chime");
	}
	else
	{
		var_e323931b.position--;
		var_e323931b rotatepitch(30, 1);
		var_e323931b playsound("zmb_clock_hand");
		var_e323931b waittill(#"rotatedone");
	}
	level notify(#"nuke_clock_moved");
	var_e323931b.is_updating = 0;
}

