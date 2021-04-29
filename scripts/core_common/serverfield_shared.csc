// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace serverfield;

/*
	Name: register
	Namespace: serverfield
	Checksum: 0x4F160982
	Offset: 0x68
	Size: 0x44
	Parameters: 4
	Flags: Linked
*/
function register(str_name, n_version, n_bits, str_type)
{
	serverfieldregister(str_name, n_version, n_bits, str_type);
}

/*
	Name: set
	Namespace: serverfield
	Checksum: 0xB5633523
	Offset: 0xB8
	Size: 0x2C
	Parameters: 2
	Flags: None
*/
function set(str_field_name, n_value)
{
	serverfieldsetval(self, str_field_name, n_value);
}

/*
	Name: get
	Namespace: serverfield
	Checksum: 0x78ECBEF5
	Offset: 0xF0
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function get(field_name)
{
	return serverfieldgetvalue(self, field_name);
}

