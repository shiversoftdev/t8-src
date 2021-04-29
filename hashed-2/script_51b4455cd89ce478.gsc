// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.csc;

#namespace flowgraph_entity;

/*
	Name: isentitydefinedfunc
	Namespace: flowgraph_entity
	Checksum: 0xE1C0E729
	Offset: 0x80
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function isentitydefinedfunc(e_entity)
{
	return isdefined(e_entity);
}

/*
	Name: getentityorigin
	Namespace: flowgraph_entity
	Checksum: 0x5037688B
	Offset: 0x98
	Size: 0x16
	Parameters: 1
	Flags: None
*/
function getentityorigin(e_entity)
{
	return e_entity.origin;
}

/*
	Name: getentityangles
	Namespace: flowgraph_entity
	Checksum: 0xA07A6756
	Offset: 0xB8
	Size: 0x16
	Parameters: 1
	Flags: None
*/
function getentityangles(e_entity)
{
	return e_entity.angles;
}

/*
	Name: lerpshaderconstantovertime
	Namespace: flowgraph_entity
	Checksum: 0xE069FDC8
	Offset: 0xD8
	Size: 0x2C2
	Parameters: 12
	Flags: None
*/
function lerpshaderconstantovertime(x, e_entity, i_script_vector, f_start_x, f_start_y, f_start_z, f_start_w, f_end_x, f_end_y, f_end_z, f_end_w, f_time)
{
	e_entity endon(#"death");
	e_entity util::waittill_dobj(self.owner.localclientnum);
	if(!isdefined(e_entity))
	{
		return;
	}
	if(!isdefined(f_start_x))
	{
		f_start_x = 0;
	}
	if(!isdefined(f_start_y))
	{
		f_start_y = 0;
	}
	if(!isdefined(f_start_z))
	{
		f_start_z = 0;
	}
	if(!isdefined(f_start_w))
	{
		f_start_w = 0;
	}
	if(!isdefined(f_end_x))
	{
		f_end_x = 0;
	}
	if(!isdefined(f_end_y))
	{
		f_end_y = 0;
	}
	if(!isdefined(f_end_z))
	{
		f_end_z = 0;
	}
	if(!isdefined(f_end_w))
	{
		f_end_w = 0;
	}
	s_timer = util::new_timer(self.owner.localclientnum);
	do
	{
		util::server_wait(self.owner.localclientnum, 0.11);
		n_current_time = s_timer util::get_time_in_seconds();
		n_lerp_val = n_current_time / f_time;
		n_delta_val_x = lerpfloat(f_start_x, f_end_x, n_lerp_val);
		n_delta_val_y = lerpfloat(f_start_y, f_end_y, n_lerp_val);
		n_delta_val_z = lerpfloat(f_start_z, f_end_z, n_lerp_val);
		n_delta_val_w = lerpfloat(f_start_w, f_end_w, n_lerp_val);
		e_entity mapshaderconstant(self.owner.localclientnum, 0, "scriptVector" + i_script_vector, n_delta_val_x, n_delta_val_y, n_delta_val_z, n_delta_val_w);
	}
	while(n_current_time < f_time);
}

/*
	Name: function_fd19ef53
	Namespace: flowgraph_entity
	Checksum: 0x8D0A9C2
	Offset: 0x3A8
	Size: 0x20
	Parameters: 2
	Flags: None
*/
function function_fd19ef53(e_entity, str_field)
{
	return e_entity.(str_field);
}

/*
	Name: function_7e40ae2d
	Namespace: flowgraph_entity
	Checksum: 0xB84AEB99
	Offset: 0x3D0
	Size: 0x3A
	Parameters: 4
	Flags: None
*/
function function_7e40ae2d(x, e_entity, str_field, var_b8003601)
{
	e_entity.(str_field) = var_b8003601;
	return 1;
}

