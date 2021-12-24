// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\multi_extracam.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace weapon_customization_icon;

/*
	Name: function_89f2df9
	Namespace: weapon_customization_icon
	Checksum: 0x7714083D
	Offset: 0x170
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"weapon_customization_icon", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: weapon_customization_icon
	Checksum: 0x4C250FF8
	Offset: 0x1B8
	Size: 0x66
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.extra_cam_wc_paintjob_icon = [];
	level.extra_cam_wc_variant_icon = [];
	level.extra_cam_render_wc_paintjobicon_func_callback = &process_wc_paintjobicon_extracam_request;
	level.extra_cam_render_wc_varianticon_func_callback = &process_wc_varianticon_extracam_request;
	level.weaponcustomizationiconsetup = &wc_icon_setup;
}

/*
	Name: wc_icon_setup
	Namespace: weapon_customization_icon
	Checksum: 0xFB74AC3F
	Offset: 0x228
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function wc_icon_setup(localclientnum)
{
	level.extra_cam_wc_paintjob_icon[localclientnum] = spawnstruct();
	level.extra_cam_wc_variant_icon[localclientnum] = spawnstruct();
	level thread update_wc_icon_extracam(localclientnum);
}

/*
	Name: update_wc_icon_extracam
	Namespace: weapon_customization_icon
	Checksum: 0x3CD87D98
	Offset: 0x2A0
	Size: 0x90
	Parameters: 1
	Flags: Linked
*/
function update_wc_icon_extracam(localclientnum)
{
	level endon(#"disconnect");
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill("process_wc_icon_extracam_" + localclientnum);
		setup_wc_weapon_model(localclientnum, waitresult.icon);
		setup_wc_extracam_settings(localclientnum, waitresult.icon);
	}
}

/*
	Name: wait_for_extracam_close
	Namespace: weapon_customization_icon
	Checksum: 0x6E55DE47
	Offset: 0x338
	Size: 0x8C
	Parameters: 3
	Flags: Linked
*/
function wait_for_extracam_close(localclientnum, camera_ent, extracam_data_struct)
{
	level waittill((("render_complete_" + localclientnum) + "_") + extracam_data_struct.extracamindex);
	multi_extracam::extracam_reset_index(localclientnum, extracam_data_struct.extracamindex);
	if(isdefined(extracam_data_struct.weapon_script_model))
	{
		extracam_data_struct.weapon_script_model delete();
	}
}

/*
	Name: getxcam
	Namespace: weapon_customization_icon
	Checksum: 0xD36D9C95
	Offset: 0x3D0
	Size: 0x7A
	Parameters: 2
	Flags: Linked
*/
function getxcam(weapon_name, camera)
{
	xcam = getweaponxcam(weapon_name, camera);
	if(!isdefined(xcam))
	{
		xcam = getweaponxcam(getweapon(#"ar_damage"), camera);
	}
	return xcam;
}

/*
	Name: setup_wc_extracam_settings
	Namespace: weapon_customization_icon
	Checksum: 0xF0983F4F
	Offset: 0x458
	Size: 0x32C
	Parameters: 2
	Flags: Linked
*/
function setup_wc_extracam_settings(localclientnum, extracam_data_struct)
{
	/#
		assert(isdefined(extracam_data_struct.jobindex));
	#/
	if(!isdefined(level.camera_ents))
	{
		level.camera_ents = [];
	}
	initializedextracam = 0;
	camera_ent = (isdefined(level.camera_ents[localclientnum]) ? level.camera_ents[localclientnum][extracam_data_struct.extracamindex] : undefined);
	if(!isdefined(camera_ent))
	{
		initializedextracam = 1;
		if(isdefined(struct::get("weapon_icon_staging")))
		{
			camera_ent = multi_extracam::extracam_init_index(localclientnum, "weapon_icon_staging", extracam_data_struct.extracamindex);
		}
		else
		{
			camera_ent = multi_extracam::extracam_init_item(localclientnum, get_safehouse_position_struct(), extracam_data_struct.extracamindex);
		}
	}
	/#
		assert(isdefined(camera_ent));
	#/
	if(!isdefined(camera_ent))
	{
		return;
	}
	extracam_data_struct.subxcam = "cam_icon";
	if(extracam_data_struct.loadoutslot == "default_camo_render")
	{
		extracam_data_struct.xcam = "ui_cam_icon_camo_export";
	}
	else
	{
		extracam_data_struct.xcam = getxcam(extracam_data_struct.current_weapon, "cam_icon_weapon");
	}
	if(!isdefined(extracam_data_struct.xcam))
	{
		extracam_data_struct.xcam = "ui_cam_icon_camo_export";
	}
	position = extracam_data_struct.weapon_position;
	camera_ent playextracamxcam(extracam_data_struct.xcam, 0, extracam_data_struct.subxcam, extracam_data_struct.notetrack, position.origin, position.angles, extracam_data_struct.weapon_script_model, position.origin, position.angles);
	while(!extracam_data_struct.weapon_script_model isstreamed())
	{
		waitframe(1);
	}
	if(extracam_data_struct.loadoutslot == "default_camo_render")
	{
		wait(0.5);
	}
	else
	{
		level waittill_timeout(5, "paintshop_ready_" + extracam_data_struct.jobindex);
	}
	setextracamrenderready(extracam_data_struct.jobindex);
	extracam_data_struct.jobindex = undefined;
	if(initializedextracam)
	{
		level thread wait_for_extracam_close(localclientnum, camera_ent, extracam_data_struct);
	}
}

/*
	Name: set_wc_icon_weapon_options
	Namespace: weapon_customization_icon
	Checksum: 0xAD5C529F
	Offset: 0x790
	Size: 0x11C
	Parameters: 2
	Flags: Linked
*/
function set_wc_icon_weapon_options(weapon_options_param, extracam_data_struct)
{
	weapon_options = strtok(weapon_options_param, ",");
	if(isdefined(weapon_options) && isdefined(extracam_data_struct.weapon_script_model))
	{
		var_eb2e3f90 = 0;
		if(isdefined(weapon_options[3]))
		{
			var_eb2e3f90 = int(weapon_options[3]);
		}
		extracam_data_struct.weapon_script_model setweaponrenderoptions(int(weapon_options[0]), int(weapon_options[1]), var_eb2e3f90, 0, 0, int(weapon_options[2]), extracam_data_struct.paintjobslot, 1, extracam_data_struct.isfilesharepreview);
	}
}

/*
	Name: spawn_weapon_model
	Namespace: weapon_customization_icon
	Checksum: 0x7AC84F5A
	Offset: 0x8B8
	Size: 0x78
	Parameters: 3
	Flags: Linked
*/
function spawn_weapon_model(localclientnum, origin, angles)
{
	weapon_model = spawn(localclientnum, origin, "script_model");
	if(isdefined(angles))
	{
		weapon_model.angles = angles;
	}
	weapon_model sethighdetail();
	return weapon_model;
}

/*
	Name: get_safehouse_position_struct
	Namespace: weapon_customization_icon
	Checksum: 0xA093BBC4
	Offset: 0x938
	Size: 0x86
	Parameters: 0
	Flags: Linked
*/
function get_safehouse_position_struct()
{
	position = spawnstruct();
	position.angles = (0, 0, 0);
	switch(util::function_53bbf9d2())
	{
		default:
		{
			position.origin = (191, 113, -2550);
			break;
		}
	}
	return position;
}

/*
	Name: setup_wc_weapon_model
	Namespace: weapon_customization_icon
	Checksum: 0xE2BCEA93
	Offset: 0x9C8
	Size: 0x174
	Parameters: 2
	Flags: Linked
*/
function setup_wc_weapon_model(localclientnum, extracam_data_struct)
{
	base_weapon_slot = extracam_data_struct.loadoutslot;
	weapon_name = extracam_data_struct.weapon;
	weapon_options_param = extracam_data_struct.weaponoptions;
	if(isdefined(weapon_name))
	{
		position = struct::get("weapon_icon_staging");
		if(!isdefined(position))
		{
			position = get_safehouse_position_struct();
		}
		if(!isdefined(extracam_data_struct.weapon_script_model))
		{
			extracam_data_struct.weapon_script_model = spawn_weapon_model(localclientnum, position.origin, position.angles);
		}
		extracam_data_struct.current_weapon = getweapon(weapon_name);
		extracam_data_struct.weapon_script_model useweaponmodel(extracam_data_struct.current_weapon);
		extracam_data_struct.weapon_position = position;
		if(isdefined(weapon_options_param) && weapon_options_param != "none")
		{
			set_wc_icon_weapon_options(weapon_options_param, extracam_data_struct);
		}
	}
}

/*
	Name: process_wc_paintjobicon_extracam_request
	Namespace: weapon_customization_icon
	Checksum: 0x382889C3
	Offset: 0xB48
	Size: 0x15E
	Parameters: 8
	Flags: Linked
*/
function process_wc_paintjobicon_extracam_request(localclientnum, extracamindex, jobindex, weaponoptions, weapon, loadoutslot, paintjobslot, isfilesharepreview)
{
	level.extra_cam_wc_paintjob_icon[localclientnum].jobindex = jobindex;
	level.extra_cam_wc_paintjob_icon[localclientnum].extracamindex = extracamindex;
	level.extra_cam_wc_paintjob_icon[localclientnum].weaponoptions = weaponoptions;
	level.extra_cam_wc_paintjob_icon[localclientnum].weapon = weapon;
	level.extra_cam_wc_paintjob_icon[localclientnum].loadoutslot = loadoutslot;
	level.extra_cam_wc_paintjob_icon[localclientnum].paintjobslot = paintjobslot;
	level.extra_cam_wc_paintjob_icon[localclientnum].notetrack = "paintjobpreview";
	level.extra_cam_wc_paintjob_icon[localclientnum].isfilesharepreview = isfilesharepreview;
	level notify("process_wc_icon_extracam_" + localclientnum, {#icon:level.extra_cam_wc_paintjob_icon[localclientnum]});
}

/*
	Name: process_wc_varianticon_extracam_request
	Namespace: weapon_customization_icon
	Checksum: 0x89185953
	Offset: 0xCB0
	Size: 0x15E
	Parameters: 8
	Flags: Linked
*/
function process_wc_varianticon_extracam_request(localclientnum, extracamindex, jobindex, weaponoptions, weapon, loadoutslot, paintjobslot, isfilesharepreview)
{
	level.extra_cam_wc_variant_icon[localclientnum].jobindex = jobindex;
	level.extra_cam_wc_variant_icon[localclientnum].extracamindex = extracamindex;
	level.extra_cam_wc_variant_icon[localclientnum].weaponoptions = weaponoptions;
	level.extra_cam_wc_variant_icon[localclientnum].weapon = weapon;
	level.extra_cam_wc_variant_icon[localclientnum].loadoutslot = loadoutslot;
	level.extra_cam_wc_variant_icon[localclientnum].paintjobslot = paintjobslot;
	level.extra_cam_wc_variant_icon[localclientnum].notetrack = "variantpreview";
	level.extra_cam_wc_variant_icon[localclientnum].isfilesharepreview = isfilesharepreview;
	level notify("process_wc_icon_extracam_" + localclientnum, {#icon:level.extra_cam_wc_variant_icon[localclientnum]});
}

