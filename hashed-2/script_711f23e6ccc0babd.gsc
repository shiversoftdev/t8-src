// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_3417f8d2;

/*
	Name: function_89f2df9
	Namespace: namespace_3417f8d2
	Checksum: 0xDB1799E7
	Offset: 0xA8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_684e9a488b07947", &init, undefined, undefined);
}

/*
	Name: init
	Namespace: namespace_3417f8d2
	Checksum: 0x2CCEA48E
	Offset: 0xF0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function init()
{
	init_fx();
	init_clientfields();
}

/*
	Name: init_fx
	Namespace: namespace_3417f8d2
	Checksum: 0xCFAF2D85
	Offset: 0x120
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function init_fx()
{
	level._effect[#"hash_5cd079f7090da957"] = #"hash_468f18455c9e9e0f";
}

/*
	Name: init_clientfields
	Namespace: namespace_3417f8d2
	Checksum: 0xB44615A9
	Offset: 0x160
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("scriptmover", "" + #"hash_671ee63741834a25", 1, 1, "int", &function_c95aa114, 0, 0);
}

/*
	Name: function_c95aa114
	Namespace: namespace_3417f8d2
	Checksum: 0x49582040
	Offset: 0x1C8
	Size: 0xBC
	Parameters: 7
	Flags: Linked
*/
function function_c95aa114(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self.blinking_fx = util::playfxontag(localclientnum, level._effect[#"hash_5cd079f7090da957"], self, "tag_light");
	}
	else if(isdefined(self.blinking_fx))
	{
		deletefx(localclientnum, self.blinking_fx);
	}
}

