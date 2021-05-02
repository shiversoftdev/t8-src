// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace string;

/*
	Name: rjust
	Namespace: string
	Checksum: 0x81475491
	Offset: 0x68
	Size: 0x90
	Parameters: 3
	Flags: None
*/
function rjust(str_input, n_length, str_fill)
{
	/#
		if(!isdefined(str_fill))
		{
			str_fill = "";
		}
		str_input = (isdefined(str_input) ? "" + str_input : "");
		n_fill_length = n_length - str_input.size;
		str_fill = fill(n_fill_length, str_fill);
		return str_fill + str_input;
	#/
}

/*
	Name: ljust
	Namespace: string
	Checksum: 0x4FE19ED2
	Offset: 0x108
	Size: 0x90
	Parameters: 3
	Flags: None
*/
function ljust(str_input, n_length, str_fill)
{
	/#
		if(!isdefined(str_fill))
		{
			str_fill = "";
		}
		str_input = (isdefined(str_input) ? "" + str_input : "");
		n_fill_length = n_length - str_input.size;
		str_fill = fill(n_fill_length, str_fill);
		return str_input + str_fill;
	#/
}

/*
	Name: fill
	Namespace: string
	Checksum: 0x1B87DCF
	Offset: 0x1A8
	Size: 0xAC
	Parameters: 2
	Flags: None
*/
function fill(n_length, str_fill)
{
	/#
		if(!isdefined(str_fill) || str_fill == "")
		{
			str_fill = "";
		}
		str_return = "";
		while(n_length > 0)
		{
			str = getsubstr(str_fill, 0, n_length);
			n_length = n_length - str.size;
			str_return = str_return + str;
		}
		return str_return;
	#/
}

