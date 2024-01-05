// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace clientfield;

/*
	Name: register
	Namespace: clientfield
	Checksum: 0xFFF629EC
	Offset: 0x90
	Size: 0x74
	Parameters: 8
	Flags: Linked
*/
function register(str_pool_name, str_name, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new)
{
	registerclientfield(str_pool_name, str_name, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new);
}

/*
	Name: register_luielem
	Namespace: clientfield
	Checksum: 0x3D67865A
	Offset: 0x110
	Size: 0x8C
	Parameters: 8
	Flags: Linked
*/
function register_luielem(unique_name, field_name, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new)
{
	registerclientfield("clientuimodel", (("luielement." + unique_name) + ".") + field_name, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new);
}

/*
	Name: register_bgcache
	Namespace: clientfield
	Checksum: 0xC0D5C26F
	Offset: 0x1A8
	Size: 0x6C
	Parameters: 7
	Flags: Linked
*/
function register_bgcache(poolname, var_b693fec6, uniqueid, version, func_callback, b_host, b_callback_for_zero_when_new)
{
	function_3ff577e6(poolname, var_b693fec6, uniqueid, version, func_callback, b_host, b_callback_for_zero_when_new);
}

/*
	Name: get
	Namespace: clientfield
	Checksum: 0x8946CA47
	Offset: 0x220
	Size: 0x42
	Parameters: 1
	Flags: Linked
*/
function get(field_name)
{
	if(self == level)
	{
		return codegetworldclientfield(field_name);
	}
	return codegetclientfield(self, field_name);
}

/*
	Name: get_to_player
	Namespace: clientfield
	Checksum: 0x497546DF
	Offset: 0x270
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function get_to_player(field_name)
{
	return codegetplayerstateclientfield(self, field_name);
}

/*
	Name: get_player_uimodel
	Namespace: clientfield
	Checksum: 0xCB9A60C7
	Offset: 0x2A0
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function get_player_uimodel(field_name)
{
	return codegetuimodelclientfield(self, field_name);
}

/*
	Name: function_f7ae6994
	Namespace: clientfield
	Checksum: 0x271A755B
	Offset: 0x2D0
	Size: 0x42
	Parameters: 2
	Flags: None
*/
function function_f7ae6994(unique_name, str_field_name)
{
	return codegetuimodelclientfield(self, (("luielement." + unique_name) + ".") + str_field_name);
}

