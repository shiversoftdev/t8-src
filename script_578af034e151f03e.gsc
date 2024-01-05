// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace namespace_6a81d072;

/*
	Name: init_pentagon_box_screens
	Namespace: namespace_6a81d072
	Checksum: 0x341184D3
	Offset: 0x398
	Size: 0x276
	Parameters: 0
	Flags: Linked
*/
function init_pentagon_box_screens()
{
	level._pentagon_fire_sale = array("p8_zm_off_monitor_security_screen_sale_01", "p8_zm_off_monitor_security_screen_sale_02");
	level.magic_box_tv_off = array("p8_zm_off_monitor_security_screen_off");
	level.magic_box_tv_on = array("p8_zm_off_monitor_security_screen_on");
	level.magic_box_tv_lobby_1 = array("p8_zm_off_monitor_security_screen_lobby", "p8_zm_off_monitor_security_screen_lobby_01");
	level.magic_box_tv_lobby_2 = array("p8_zm_off_monitor_security_screen_lobby", "p8_zm_off_monitor_security_screen_lobby_02");
	level.var_ffdbb303 = array("p8_zm_off_monitor_security_screen_lobby", "p8_zm_off_monitor_security_screen_lobby_03");
	level.magic_box_tv_warroom_1 = array("p8_zm_off_monitor_security_screen_warroom", "p8_zm_off_monitor_security_screen_warroom_01");
	level.var_a47d347b = array("p8_zm_off_monitor_security_screen_warroom", "p8_zm_off_monitor_security_screen_warroom_02");
	level.var_f32c51dc = array("p8_zm_off_monitor_security_screen_warroom", "p8_zm_off_monitor_security_screen_warroom_03");
	level.magic_box_tv_labs_1 = array("p8_zm_off_monitor_security_screen_labs", "p8_zm_off_monitor_security_screen_labs_01");
	level.magic_box_tv_labs_2 = array("p8_zm_off_monitor_security_screen_labs", "p8_zm_off_monitor_security_screen_labs_02");
	level.magic_box_tv_labs_3 = array("p8_zm_off_monitor_security_screen_labs", "p8_zm_off_monitor_security_screen_labs_03");
	level.magic_box_tv_random = array("p8_zm_off_monitor_security_screen_logo");
	level.open_chest_location = array(level.magic_box_tv_lobby_1, level.magic_box_tv_lobby_2, level.var_ffdbb303, level.magic_box_tv_warroom_1, level.var_a47d347b, level.var_f32c51dc, level.magic_box_tv_labs_1, level.magic_box_tv_labs_2, level.magic_box_tv_labs_3);
	level._custom_box_monitor = &function_d531af7d;
}

/*
	Name: function_d531af7d
	Namespace: namespace_6a81d072
	Checksum: 0x70A95389
	Offset: 0x618
	Size: 0x15E
	Parameters: 2
	Flags: Linked
*/
function function_d531af7d(client_num, state)
{
	function_349aed4a(client_num);
	if(state == "n")
	{
		if(level._power_on == 0)
		{
			screen_to_display = level.magic_box_tv_off;
		}
		else
		{
			screen_to_display = level.magic_box_tv_on;
		}
	}
	else
	{
		if(state == "f")
		{
			screen_to_display = level._pentagon_fire_sale;
		}
		else
		{
			array_number = int(state);
			screen_to_display = level.open_chest_location[array_number];
		}
	}
	stop_notify = "stop_tv_swap";
	for(i = 0; i < level.var_c1947c95[client_num].size; i++)
	{
		tele = level.var_c1947c95[client_num][i];
		tele notify(stop_notify);
		wait(0.2);
		tele thread function_ecd6c9b9(screen_to_display, "stop_tv_swap");
	}
}

/*
	Name: function_349aed4a
	Namespace: namespace_6a81d072
	Checksum: 0xD2C2AA99
	Offset: 0x780
	Size: 0xF6
	Parameters: 1
	Flags: Linked
*/
function function_349aed4a(client_num)
{
	if(!isdefined(level.var_c1947c95))
	{
		level.var_c1947c95 = [];
	}
	if(isdefined(level.var_c1947c95[client_num]))
	{
		return;
	}
	level.var_c1947c95[client_num] = getentarray(client_num, "model_pentagon_box_screens", "script_noteworthy");
	for(i = 0; i < level.var_c1947c95[client_num].size; i++)
	{
		tele = level.var_c1947c95[client_num][i];
		tele setmodel(level.magic_box_tv_off[0]);
		wait(0.1);
	}
}

/*
	Name: function_ecd6c9b9
	Namespace: namespace_6a81d072
	Checksum: 0x85960F2C
	Offset: 0x880
	Size: 0xF0
	Parameters: 2
	Flags: Linked
*/
function function_ecd6c9b9(model_array, endon_notify)
{
	self endon(endon_notify);
	while(true)
	{
		for(i = 0; i < model_array.size; i++)
		{
			self setmodel(model_array[i]);
			wait(3);
		}
		if(6 > randomint(100) && isdefined(level.magic_box_tv_random))
		{
			self setmodel(level.magic_box_tv_random[randomint(level.magic_box_tv_random.size)]);
			wait(2);
		}
		wait(1);
	}
}

