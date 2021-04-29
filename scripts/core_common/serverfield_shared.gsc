// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace serverfield;

/*
	Name: register
	Namespace: serverfield
	Checksum: 0x6FDAB05
	Offset: 0x68
	Size: 0x54
	Parameters: 5
	Flags: Linked
*/
function register(str_name, n_version, n_bits, str_type, func_callback)
{
	serverfieldregister(str_name, n_version, n_bits, str_type, func_callback);
}

/*
	Name: get
	Namespace: serverfield
	Checksum: 0xEDDFD86F
	Offset: 0xC8
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function get(field_name)
{
	return serverfieldgetvalue(self, field_name);
}

