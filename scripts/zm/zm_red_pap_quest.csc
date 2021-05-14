// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_b4ea833c;

/*
	Name: function_842831cf
	Namespace: namespace_b4ea833c
	Checksum: 0x2D5016C6
	Offset: 0xF0
	Size: 0x352
	Parameters: 0
	Flags: Linked
*/
function function_842831cf()
{
	clientfield::register("scriptmover", "" + #"hash_38dbf4f346c0b609", -15000, 1, "counter", &function_56b9111c, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_9055852bfeb9f00", -15000, 1, "counter", &function_f2332be2, 0, 0);
	clientfield::register("scriptmover", "" + #"crystal_explosion", 16000, 1, "counter", &crystal_explosion_func, 0, 0);
	clientfield::register("vehicle", "" + #"hash_68f13836e5123974", 16000, 1, "counter", &function_417c12e1, 0, 0);
	clientfield::register("toplayer", "" + #"hash_687fbbd292ea6be0", 16000, 1, "int", &function_5783c958, 0, 0);
	clientfield::register("toplayer", "" + #"hash_25518e9ed7ed3a00", 16000, 1, "int", &function_e83bf3a, 0, 0);
	clientfield::register("toplayer", "" + #"hash_63d76935e1b33990", 16000, 1, "int", &function_11d62eb0, 0, 0);
	clientfield::register("world", "" + #"hash_28eb5e403f599ce2", 17000, 1, "int", &function_6c40f793, 0, 0);
	level._effect[#"hash_38dbf4f346c0b609"] = #"hash_66e87f89740f4b2c";
	level._effect[#"crystal_explosion"] = #"hash_6e87fbd77320ada5";
	level._effect[#"hash_641b95473df6f630"] = #"hash_1a06427eff8dfe13";
}

/*
	Name: function_56b9111c
	Namespace: namespace_b4ea833c
	Checksum: 0x6DA124C0
	Offset: 0x450
	Size: 0x3C
	Parameters: 7
	Flags: Linked
*/
function function_56b9111c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
}

/*
	Name: function_f2332be2
	Namespace: namespace_b4ea833c
	Checksum: 0xBBDBD950
	Offset: 0x498
	Size: 0x3C
	Parameters: 7
	Flags: Linked
*/
function function_f2332be2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
}

/*
	Name: function_11d62eb0
	Namespace: namespace_b4ea833c
	Checksum: 0x2D6025E5
	Offset: 0x4E0
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function function_11d62eb0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self thread postfx::playpostfxbundle(#"pstfx_watertransition");
	}
	else
	{
		self thread postfx::exitpostfxbundle(#"pstfx_watertransition");
	}
}

/*
	Name: function_e83bf3a
	Namespace: namespace_b4ea833c
	Checksum: 0x95BF318B
	Offset: 0x580
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function function_e83bf3a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self thread postfx::playpostfxbundle(#"hash_3b0eec5d73aa6243");
	}
	else
	{
		self thread postfx::exitpostfxbundle(#"hash_3b0eec5d73aa6243");
	}
}

/*
	Name: function_417c12e1
	Namespace: namespace_b4ea833c
	Checksum: 0xB20E224E
	Offset: 0x620
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_417c12e1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self util::playfxontag(localclientnum, level._effect[#"hash_38dbf4f346c0b609"], self, "tag_origin");
}

/*
	Name: crystal_explosion_func
	Namespace: namespace_b4ea833c
	Checksum: 0xABC79EEC
	Offset: 0x6A0
	Size: 0x9C
	Parameters: 7
	Flags: Linked
*/
function crystal_explosion_func(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self util::playfxontag(localclientnum, level._effect[#"crystal_explosion"], self, "tag_origin");
	playsound(localclientnum, #"hash_66b733441d74cd21", self.origin);
}

/*
	Name: function_5783c958
	Namespace: namespace_b4ea833c
	Checksum: 0x445DAEFE
	Offset: 0x748
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function function_5783c958(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self thread postfx::playpostfxbundle(#"pstfx_shock_charge");
	}
	else
	{
		self thread postfx::exitpostfxbundle(#"pstfx_shock_charge");
	}
}

/*
	Name: function_6c40f793
	Namespace: namespace_b4ea833c
	Checksum: 0xAC7A16B1
	Offset: 0x7E8
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function function_6c40f793(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		forcestreamxmodel(#"hash_d8483cb5cc65489");
	}
	else
	{
		stopforcestreamingxmodel(#"hash_d8483cb5cc65489");
	}
}

