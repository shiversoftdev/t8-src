// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1da833573eb80e61;
#using script_2feaeed9ab01d6f7;
#using scripts\core_common\multi_extracam.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\character_customization.csc;
#using scripts\core_common\struct.csc;

class cluielem 
{
	var var_47d8642e;
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: cluielem
		Checksum: 0x80F724D1
		Offset: 0x2640
		Size: 0x4
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cluielem
		Checksum: 0x80F724D1
		Offset: 0x2A28
		Size: 0x4
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: get_data
		Namespace: cluielem
		Checksum: 0xBBFCD106
		Offset: 0x29C0
		Size: 0x5A
		Parameters: 2
		Flags: Linked
	*/
	function get_data(localclientnum, field)
	{
		/#
			assert(var_47d8642e, "");
		#/
		return function_88759655(localclientnum, var_47e79fc, field);
	}

	/*
		Name: set_data
		Namespace: cluielem
		Checksum: 0xDFD2CDB7
		Offset: 0x2950
		Size: 0x64
		Parameters: 3
		Flags: Linked
	*/
	function set_data(localclientnum, field, value)
	{
		/#
			assert(var_47d8642e, "");
		#/
		function_bcc2134a(localclientnum, var_47e79fc, field, value);
	}

	/*
		Name: close
		Namespace: cluielem
		Checksum: 0x34DE8D6
		Offset: 0x28F0
		Size: 0x54
		Parameters: 1
		Flags: Linked
	*/
	function close(localclientnum)
	{
		/#
			assert(var_47d8642e, "");
		#/
		closeluielem(localclientnum, var_47e79fc);
	}

	/*
		Name: is_open
		Namespace: cluielem
		Checksum: 0x885EA434
		Offset: 0x2890
		Size: 0x52
		Parameters: 1
		Flags: Linked
	*/
	function is_open(localclientnum)
	{
		/#
			assert(var_47d8642e, "");
		#/
		return isluielemopen(localclientnum, var_47e79fc);
	}

	/*
		Name: open
		Namespace: cluielem
		Checksum: 0x237B563F
		Offset: 0x2818
		Size: 0x6C
		Parameters: 2
		Flags: Linked
	*/
	function open(localclientnum, menu_name)
	{
		/#
			assert(var_47d8642e, "");
		#/
		openluielem(localclientnum, menu_name, var_47e79fc);
		[[ self ]]->function_fa582112(localclientnum);
	}

	/*
		Name: function_fa582112
		Namespace: cluielem
		Checksum: 0xBECC2060
		Offset: 0x27D8
		Size: 0x34
		Parameters: 1
		Flags: Linked
	*/
	function function_fa582112(localclientnum)
	{
		/#
			assert(var_47d8642e, "");
		#/
	}

	/*
		Name: register_clientside
		Namespace: cluielem
		Checksum: 0xDB389259
		Offset: 0x27A8
		Size: 0x26
		Parameters: 1
		Flags: Linked
	*/
	function register_clientside(uid)
	{
		self.var_47e79fc = uid;
		self.var_47d8642e = 1;
	}

	/*
		Name: function_dcb34c80
		Namespace: cluielem
		Checksum: 0xCDF44B94
		Offset: 0x2710
		Size: 0x8C
		Parameters: 3
		Flags: Linked
	*/
	function function_dcb34c80(var_2a0de052, field_name, version)
	{
		/#
			assert(!var_47d8642e, "");
		#/
		clientfield::register_bgcache("clientuimodel", var_2a0de052, (("luielement." + var_47e79fc) + ".") + field_name, version, undefined, 0, 0);
	}

	/*
		Name: add_clientfield
		Namespace: cluielem
		Checksum: 0x6DF9DD22
		Offset: 0x2680
		Size: 0x84
		Parameters: 5
		Flags: Linked
	*/
	function add_clientfield(field_name, version, bits, type, callback)
	{
		/#
			assert(!var_47d8642e, "");
		#/
		clientfield::register_luielem(var_47e79fc, field_name, version, bits, type, callback, 0, 0);
	}

	/*
		Name: setup_clientfields
		Namespace: cluielem
		Checksum: 0xF4A31FEA
		Offset: 0x2650
		Size: 0x26
		Parameters: 1
		Flags: Linked
	*/
	function setup_clientfields(uid)
	{
		self.var_47e79fc = uid;
		self.var_47d8642e = 0;
	}

}

#namespace lui;

/*
	Name: __init__system__
	Namespace: lui
	Checksum: 0x38946C01
	Offset: 0x1C8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"lui_shared", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: lui
	Checksum: 0x46A44F90
	Offset: 0x210
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.client_menus = associativearray();
	level.var_a14cc36b = associativearray();
	callback::on_localclient_connect(&on_player_connect);
	full_screen_black::register("full_screen_black");
	initial_black::register("initial_black");
}

/*
	Name: on_player_connect
	Namespace: lui
	Checksum: 0x61A2D184
	Offset: 0x2A8
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function on_player_connect(localclientnum)
{
	level thread client_menus(localclientnum);
}

/*
	Name: initmenudata
	Namespace: lui
	Checksum: 0x5E7AC0C8
	Offset: 0x2D8
	Size: 0x56
	Parameters: 1
	Flags: Linked
*/
function initmenudata(localclientnum)
{
	/#
		assert(!isdefined(level.client_menus[localclientnum]));
	#/
	level.client_menus[localclientnum] = associativearray();
}

/*
	Name: createextracamxcamdata
	Namespace: lui
	Checksum: 0x53A7793D
	Offset: 0x338
	Size: 0x186
	Parameters: 7
	Flags: None
*/
function createextracamxcamdata(menu_name, localclientnum, extracam_index, target_name, xcam, sub_xcam, xcam_frame)
{
	/#
		assert(isdefined(level.client_menus[localclientnum][menu_name]));
	#/
	menu_data = level.client_menus[localclientnum][menu_name];
	extracam_data = {#xcam_frame:xcam_frame, #sub_xcam:sub_xcam, #xcam:xcam, #target_name:target_name, #extracam_index:extracam_index, #menu_name:menu_name};
	if(!isdefined(menu_data.extra_cams))
	{
		menu_data.extra_cams = [];
	}
	else if(!isarray(menu_data.extra_cams))
	{
		menu_data.extra_cams = array(menu_data.extra_cams);
	}
	menu_data.extra_cams[menu_data.extra_cams.size] = extracam_data;
}

/*
	Name: createcustomextracamxcamdata
	Namespace: lui
	Checksum: 0xA9DCF3F0
	Offset: 0x4C8
	Size: 0x12E
	Parameters: 4
	Flags: None
*/
function createcustomextracamxcamdata(menu_name, localclientnum, extracam_index, camera_function)
{
	/#
		assert(isdefined(level.client_menus[localclientnum][menu_name]));
	#/
	menu_data = level.client_menus[localclientnum][menu_name];
	extracam_data = {#camera_function:camera_function, #extracam_index:extracam_index};
	if(!isdefined(menu_data.extra_cams))
	{
		menu_data.extra_cams = [];
	}
	else if(!isarray(menu_data.extra_cams))
	{
		menu_data.extra_cams = array(menu_data.extra_cams);
	}
	menu_data.extra_cams[menu_data.extra_cams.size] = extracam_data;
}

/*
	Name: addmenuexploders
	Namespace: lui
	Checksum: 0x9DF80CBD
	Offset: 0x600
	Size: 0x1F6
	Parameters: 3
	Flags: None
*/
function addmenuexploders(menu_name, localclientnum, exploder)
{
	/#
		assert(isdefined(level.client_menus[localclientnum][menu_name]));
	#/
	menu_data = level.client_menus[localclientnum][menu_name];
	if(isarray(exploder))
	{
		foreach(expl in exploder)
		{
			if(!isdefined(menu_data.exploders))
			{
				menu_data.exploders = [];
			}
			else if(!isarray(menu_data.exploders))
			{
				menu_data.exploders = array(menu_data.exploders);
			}
			menu_data.exploders[menu_data.exploders.size] = expl;
		}
	}
	else
	{
		if(!isdefined(menu_data.exploders))
		{
			menu_data.exploders = [];
		}
		else if(!isarray(menu_data.exploders))
		{
			menu_data.exploders = array(menu_data.exploders);
		}
		menu_data.exploders[menu_data.exploders.size] = exploder;
	}
}

/*
	Name: linktocustomcharacter
	Namespace: lui
	Checksum: 0xC9F77DC1
	Offset: 0x800
	Size: 0x176
	Parameters: 4
	Flags: Linked
*/
function linktocustomcharacter(menu_name, localclientnum, target_name, alt_render_mode = 1)
{
	/#
		assert(isdefined(level.client_menus[localclientnum][menu_name]));
	#/
	menu_data = level.client_menus[localclientnum][menu_name];
	/#
		assert(!isdefined(menu_data.custom_character));
	#/
	model = getent(localclientnum, target_name, "targetname");
	if(!isdefined(model))
	{
		model = util::spawn_model(localclientnum, "tag_origin");
		model.targetname = target_name;
	}
	model useanimtree("all_player");
	menu_data.custom_character = character_customization::function_dd295310(model, localclientnum, alt_render_mode);
	model hide();
	return menu_data.custom_character;
}

/*
	Name: getcharacterdataformenu
	Namespace: lui
	Checksum: 0x56898A71
	Offset: 0x980
	Size: 0x52
	Parameters: 2
	Flags: Linked
*/
function getcharacterdataformenu(menu_name, localclientnum)
{
	if(isdefined(level.client_menus[localclientnum][menu_name]))
	{
		return level.client_menus[localclientnum][menu_name].custom_character;
	}
	return undefined;
}

/*
	Name: function_e41243c1
	Namespace: lui
	Checksum: 0xB0D18591
	Offset: 0x9E0
	Size: 0x5A
	Parameters: 1
	Flags: Linked
*/
function function_e41243c1(var_e953aca6)
{
	if(!isdefined(var_e953aca6))
	{
		return array();
	}
	if(isarray(var_e953aca6))
	{
		return var_e953aca6;
	}
	return array(var_e953aca6);
}

/*
	Name: createcameramenu
	Namespace: lui
	Checksum: 0xEF99F1A0
	Offset: 0xA48
	Size: 0x1C2
	Parameters: 10
	Flags: Linked
*/
function createcameramenu(menu_name, localclientnum, target_name, xcam, sub_xcam, xcam_frame = undefined, var_1f199068 = undefined, var_2c679be0 = undefined, lerp_time = 0, lut_index = 0)
{
	/#
		assert(!isdefined(level.client_menus[localclientnum][menu_name]));
	#/
	level.client_menus[localclientnum][menu_name] = {#hash_e57ed98b:[], #lut_index:lut_index, #lerp_time:lerp_time, #hash_2c679be0:function_e41243c1(var_2c679be0), #hash_1f199068:function_e41243c1(var_1f199068), #xcam_frame:xcam_frame, #sub_xcam:sub_xcam, #xcam:xcam, #target_name:target_name, #menu_name:menu_name};
	return level.client_menus[localclientnum][menu_name];
}

/*
	Name: function_9d7ab167
	Namespace: lui
	Checksum: 0xFA915D3F
	Offset: 0xC18
	Size: 0x132
	Parameters: 9
	Flags: Linked
*/
function function_9d7ab167(menu_name, localclientnum, session_mode, target_name, xcam, sub_xcam, xcam_frame = undefined, lerp_time = 0, lut_index = 0)
{
	/#
		assert(isdefined(level.client_menus[localclientnum][menu_name]));
	#/
	level.client_menus[localclientnum][menu_name].var_e57ed98b[session_mode] = {#lut_index:lut_index, #lerp_time:lerp_time, #xcam_frame:xcam_frame, #sub_xcam:sub_xcam, #xcam:xcam, #target_name:target_name};
}

/*
	Name: createcustomcameramenu
	Namespace: lui
	Checksum: 0x19E8A101
	Offset: 0xD58
	Size: 0x15A
	Parameters: 7
	Flags: Linked
*/
function createcustomcameramenu(menu_name, localclientnum, camera_function, has_state, var_1f199068 = undefined, var_2c679be0 = undefined, lut_index = 0)
{
	/#
		assert(!isdefined(level.client_menus[localclientnum][menu_name]));
	#/
	level.client_menus[localclientnum][menu_name] = {#lut_index:lut_index, #hash_2c679be0:function_e41243c1(var_2c679be0), #hash_1f199068:function_e41243c1(var_1f199068), #has_state:has_state, #camera_function:camera_function, #menu_name:menu_name};
	return level.client_menus[localclientnum][menu_name];
}

/*
	Name: setup_menu
	Namespace: lui
	Checksum: 0xDAE62470
	Offset: 0xEC0
	Size: 0x7D8
	Parameters: 3
	Flags: Linked
*/
function setup_menu(localclientnum, menu_data, previous_menu)
{
	if(isdefined(menu_data))
	{
		new_menu = level.client_menus[localclientnum][menu_data.menu_name];
	}
	if(isdefined(previous_menu) && isdefined(level.client_menus[localclientnum][previous_menu.menu_name]))
	{
		previous_menu_info = level.client_menus[localclientnum][previous_menu.menu_name];
		if(isdefined(previous_menu_info.var_2c679be0))
		{
			foreach(fn in previous_menu_info.var_2c679be0)
			{
				level thread [[fn]](localclientnum, previous_menu_info);
			}
		}
		if(isdefined(previous_menu_info.extra_cams))
		{
			foreach(extracam_data in previous_menu_info.extra_cams)
			{
				multi_extracam::extracam_reset_index(localclientnum, extracam_data.extracam_index);
			}
		}
		level notify(previous_menu.menu_name + "_closed");
		if(isdefined(previous_menu_info.camera_function))
		{
			stopmaincamxcam(localclientnum);
		}
		else if(isdefined(previous_menu_info.xcam))
		{
			stopmaincamxcam(localclientnum);
		}
		if(isdefined(previous_menu_info.custom_character) && (!isdefined(new_menu) || previous_menu_info.custom_character !== new_menu.custom_character))
		{
			[[ previous_menu_info.custom_character ]]->hide_model();
			[[ previous_menu_info.custom_character ]]->function_39a68bf2();
		}
		if(isdefined(previous_menu_info.exploders))
		{
			foreach(exploder in previous_menu_info.exploders)
			{
				killradiantexploder(localclientnum, exploder);
			}
		}
	}
	if(isdefined(new_menu))
	{
		if(isdefined(new_menu.custom_character))
		{
			[[ new_menu.custom_character ]]->show_model();
		}
		if(isdefined(new_menu.exploders))
		{
			foreach(exploder in new_menu.exploders)
			{
				playradiantexploder(localclientnum, exploder);
			}
		}
		if(isdefined(new_menu.lut_index))
		{
			setdvar(#"vc_lut", new_menu.lut_index);
		}
		if(isdefined(new_menu.camera_function))
		{
			if(new_menu.has_state === 1)
			{
				level thread [[new_menu.camera_function]](localclientnum, menu_data.menu_name, menu_data.state);
			}
			else
			{
				level thread [[new_menu.camera_function]](localclientnum, menu_data.menu_name);
			}
		}
		else if(isdefined(new_menu.xcam))
		{
			camera_data = (isdefined(new_menu.var_e57ed98b[currentsessionmode()]) ? new_menu.var_e57ed98b[currentsessionmode()] : new_menu);
			camera_ent = struct::get(camera_data.target_name);
			if(isdefined(camera_ent))
			{
				playmaincamxcam(localclientnum, camera_data.xcam, camera_data.lerp_time, camera_data.sub_xcam, "", camera_ent.origin, camera_ent.angles);
			}
		}
		if(isdefined(new_menu.var_1f199068))
		{
			if(isdefined(menu_data.charactermode) && isdefined(new_menu.custom_character))
			{
				[[ new_menu.custom_character ]]->set_character_mode(menu_data.charactermode);
			}
			foreach(fn in new_menu.var_1f199068)
			{
				level thread [[fn]](localclientnum, new_menu);
			}
		}
		if(isdefined(new_menu.extra_cams))
		{
			foreach(extracam_data in new_menu.extra_cams)
			{
				if(isdefined(extracam_data.camera_function))
				{
					if(new_menu.has_state === 1)
					{
						level thread [[extracam_data.camera_function]](localclientnum, menu_data.menu_name, extracam_data, menu_data.state);
					}
					else
					{
						level thread [[extracam_data.camera_function]](localclientnum, menu_data.menu_name, extracam_data);
					}
					continue;
				}
				camera_ent = multi_extracam::extracam_init_index(localclientnum, extracam_data.target_name, extracam_data.extracam_index);
				if(isdefined(camera_ent))
				{
					if(isdefined(extracam_data.xcam_frame))
					{
						camera_ent playextracamxcam(extracam_data.xcam, 0, extracam_data.sub_xcam, extracam_data.xcam_frame);
						continue;
					}
					camera_ent playextracamxcam(extracam_data.xcam, 0, extracam_data.sub_xcam);
				}
			}
		}
	}
}

/*
	Name: function_afb6dd92
	Namespace: lui
	Checksum: 0xEB446262
	Offset: 0x16A0
	Size: 0x174
	Parameters: 2
	Flags: Linked
*/
function function_afb6dd92(localclientnum, menu_data)
{
	if(isdefined(menu_data))
	{
		new_menu = level.client_menus[localclientnum][menu_data.menu_name];
	}
	if(isdefined(new_menu))
	{
		if(isdefined(new_menu.camera_function) && new_menu.has_state === 1)
		{
			level thread [[new_menu.camera_function]](localclientnum, menu_data.menu_name, menu_data.state);
		}
		if(isdefined(new_menu.extra_cams))
		{
			foreach(extracam_data in new_menu.extra_cams)
			{
				if(isdefined(extracam_data.camera_function) && new_menu.has_state === 1)
				{
					level thread [[extracam_data.camera_function]](localclientnum, menu_data.menu_name, extracam_data, menu_data.state);
				}
			}
		}
	}
}

/*
	Name: client_menus
	Namespace: lui
	Checksum: 0xDD8ACB09
	Offset: 0x1820
	Size: 0x450
	Parameters: 1
	Flags: Linked
*/
function client_menus(localclientnum)
{
	level endon(#"disconnect");
	level.var_a14cc36b[localclientnum] = array();
	clientmenustack = level.var_a14cc36b[localclientnum];
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill("menu_change" + localclientnum);
		menu_name = waitresult.menu;
		status = waitresult.status;
		state = waitresult.state;
		menu_index = undefined;
		for(i = 0; i < clientmenustack.size; i++)
		{
			if(clientmenustack[i].menu_name == menu_name)
			{
				menu_index = i;
				break;
			}
		}
		if(status === "closeToMenu" && isdefined(menu_index))
		{
			topmenu = undefined;
			for(i = 0; i < menu_index; i++)
			{
				popped = array::pop(clientmenustack, 0, 0);
				if(!isdefined(topmenu))
				{
					topmenu = popped;
				}
			}
			setup_menu(localclientnum, clientmenustack[0], topmenu);
			continue;
		}
		statechange = isdefined(menu_index) && status !== "closed" && clientmenustack[menu_index].state !== state && (!(!isdefined(clientmenustack[menu_index].state) && !isdefined(state)));
		updateonly = statechange && menu_index !== 0;
		if(updateonly)
		{
			clientmenustack[i].state = state;
		}
		else
		{
			if(status === "closed" && isdefined(menu_index))
			{
				/#
					/#
						assert(menu_index == 0);
					#/
				#/
				if(menu_index == 0)
				{
					popped = array::pop(clientmenustack, 0, 0);
					setup_menu(localclientnum, clientmenustack[0], popped);
				}
			}
			else
			{
				if(status === "opened" && !isdefined(menu_index))
				{
					menu_data = spawnstruct();
					menu_data.menu_name = menu_name;
					menu_data.state = state;
					if(isdefined(waitresult.mode))
					{
						menu_data.charactermode = waitresult.mode;
					}
					lastmenu = (clientmenustack.size > 0 ? clientmenustack[0] : undefined);
					setup_menu(localclientnum, menu_data, lastmenu);
					array::push_front(clientmenustack, menu_data);
				}
				else if(isdefined(menu_index) && statechange)
				{
					/#
						assert(menu_index == 0);
					#/
					clientmenustack[0].state = state;
					function_afb6dd92(localclientnum, clientmenustack[0]);
				}
			}
		}
	}
}

/*
	Name: is_current_menu
	Namespace: lui
	Checksum: 0xF487D22B
	Offset: 0x1C78
	Size: 0xB4
	Parameters: 3
	Flags: Linked
*/
function is_current_menu(localclientnum, menu_name, state = undefined)
{
	if(!isdefined(level.var_a14cc36b[localclientnum]) || level.var_a14cc36b[localclientnum].size == 0)
	{
		return 0;
	}
	return level.var_a14cc36b[localclientnum][0].menu_name === menu_name && (!isdefined(state) || level.var_a14cc36b[localclientnum][0].state === state);
}

/*
	Name: screen_fade
	Namespace: lui
	Checksum: 0xD098DC2D
	Offset: 0x1D38
	Size: 0x134
	Parameters: 5
	Flags: Linked
*/
function screen_fade(n_time, n_target_alpha = 1, n_start_alpha = 0, str_color = "black", b_force_close_menu = 0)
{
	if(self == level)
	{
		foreach(player in level.players)
		{
			player thread _screen_fade(n_time, n_target_alpha, n_start_alpha, str_color, b_force_close_menu);
		}
	}
	else
	{
		self thread _screen_fade(n_time, n_target_alpha, n_start_alpha, str_color, b_force_close_menu);
	}
}

/*
	Name: screen_fade_out
	Namespace: lui
	Checksum: 0xC79AF91D
	Offset: 0x1E78
	Size: 0x3A
	Parameters: 2
	Flags: Linked
*/
function screen_fade_out(n_time, str_color)
{
	screen_fade(n_time, 1, 0, str_color, 0);
	wait(n_time);
}

/*
	Name: screen_fade_in
	Namespace: lui
	Checksum: 0x78285D5A
	Offset: 0x1EC0
	Size: 0x42
	Parameters: 2
	Flags: Linked
*/
function screen_fade_in(n_time, str_color)
{
	screen_fade(n_time, 0, 1, str_color, 1);
	wait(n_time);
}

/*
	Name: screen_close_menu
	Namespace: lui
	Checksum: 0x63A734A5
	Offset: 0x1F10
	Size: 0xA4
	Parameters: 0
	Flags: None
*/
function screen_close_menu()
{
	if(self == level)
	{
		foreach(player in level.players)
		{
			player thread _screen_close_menu();
		}
	}
	else
	{
		self thread _screen_close_menu();
	}
}

/*
	Name: _screen_close_menu
	Namespace: lui
	Checksum: 0xF49B81D1
	Offset: 0x1FC0
	Size: 0xFC
	Parameters: 0
	Flags: Linked, Private
*/
function private _screen_close_menu()
{
	self notify(#"_screen_fade");
	self endon(#"_screen_fade");
	self endon(#"disconnect");
	if(isdefined(self.screen_fade_menus))
	{
		str_menu = "FullScreenBlack";
		if(isdefined(self.screen_fade_menus[str_menu]))
		{
			closeluimenu(self.localclientnum, self.screen_fade_menus[str_menu].lui_menu);
			self.screen_fade_menus[str_menu] = undefined;
		}
		str_menu = "FullScreenWhite";
		if(isdefined(self.screen_fade_menus[str_menu]))
		{
			closeluimenu(self.localclientnum, self.screen_fade_menus[str_menu].lui_menu);
			self.screen_fade_menus[str_menu] = undefined;
		}
	}
}

/*
	Name: _screen_fade
	Namespace: lui
	Checksum: 0xDFEDE2E4
	Offset: 0x20C8
	Size: 0x3DC
	Parameters: 5
	Flags: Linked, Private
*/
function private _screen_fade(n_time, n_target_alpha, n_start_alpha, v_color, b_force_close_menu)
{
	self notify(#"_screen_fade");
	self endon(#"_screen_fade");
	self endon(#"disconnect");
	self endon(#"death");
	if(!isdefined(self.screen_fade_menus))
	{
		self.screen_fade_menus = [];
	}
	if(!isdefined(v_color))
	{
		v_color = (0, 0, 0);
	}
	n_time_ms = int(int(n_time * 1000));
	str_menu = "FullScreenBlack";
	if(isstring(v_color))
	{
		switch(v_color)
		{
			case "black":
			{
				v_color = (0, 0, 0);
				break;
			}
			case "white":
			{
				v_color = (1, 1, 1);
				break;
			}
			default:
			{
				/#
					assertmsg("");
				#/
			}
		}
	}
	lui_menu = "";
	if(isdefined(self.screen_fade_menus[str_menu]))
	{
		s_menu = self.screen_fade_menus[str_menu];
		lui_menu = s_menu.lui_menu;
		closeluimenu(self.localclientnum, lui_menu);
		n_start_alpha = lerpfloat(s_menu.n_start_alpha, s_menu.n_target_alpha, gettime() - s_menu.n_start_time);
	}
	lui_menu = createluimenu(self.localclientnum, str_menu);
	self.screen_fade_menus[str_menu] = spawnstruct();
	self.screen_fade_menus[str_menu].lui_menu = lui_menu;
	self.screen_fade_menus[str_menu].n_start_alpha = n_start_alpha;
	self.screen_fade_menus[str_menu].n_target_alpha = n_target_alpha;
	self.screen_fade_menus[str_menu].n_target_time = n_time_ms;
	self.screen_fade_menus[str_menu].n_start_time = gettime();
	self set_color(lui_menu, v_color);
	setluimenudata(self.localclientnum, lui_menu, "startAlpha", n_start_alpha);
	setluimenudata(self.localclientnum, lui_menu, "endAlpha", n_target_alpha);
	setluimenudata(self.localclientnum, lui_menu, "fadeOverTime", n_time_ms);
	openluimenu(self.localclientnum, lui_menu);
	wait(n_time);
	if(b_force_close_menu || n_target_alpha == 0)
	{
		closeluimenu(self.localclientnum, self.screen_fade_menus[str_menu].lui_menu);
		self.screen_fade_menus[str_menu] = undefined;
	}
}

/*
	Name: set_color
	Namespace: lui
	Checksum: 0x95628F47
	Offset: 0x24B0
	Size: 0xA4
	Parameters: 2
	Flags: Linked
*/
function set_color(menu, color)
{
	setluimenudata(self.localclientnum, menu, "red", color[0]);
	setluimenudata(self.localclientnum, menu, "green", color[1]);
	setluimenudata(self.localclientnum, menu, "blue", color[2]);
}

/*
	Name: function_b48acaf1
	Namespace: lui
	Checksum: 0x137769A5
	Offset: 0x2560
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_b48acaf1(uid)
{
	elem = new cluielem();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: add_clientfield
	Namespace: lui
	Checksum: 0x9DDF6A36
	Offset: 0x25A8
	Size: 0x4C
	Parameters: 5
	Flags: None
*/
function add_clientfield(field_name, version, bits, type, callback)
{
	[[ self ]]->add_clientfield(field_name, version, bits, type, callback);
}

/*
	Name: function_dcb34c80
	Namespace: lui
	Checksum: 0x50AC51B3
	Offset: 0x2600
	Size: 0x34
	Parameters: 3
	Flags: None
*/
function function_dcb34c80(var_2a0de052, field_name, version)
{
	[[ self ]]->function_dcb34c80(var_2a0de052, field_name, version);
}

