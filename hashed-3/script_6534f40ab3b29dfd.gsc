// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_e18ec19b;

/*
	Name: function_89f2df9
	Namespace: namespace_e18ec19b
	Checksum: 0x8E251982
	Offset: 0x120
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_56a68c2250d5f4e3", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_e18ec19b
	Checksum: 0x53A431DD
	Offset: 0x168
	Size: 0x35A
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("actor", "" + #"hash_7792af358100c735", 1, 1, "int", &function_33f1dd99, 0, 0);
	clientfield::register("toplayer", "" + #"hash_f2d0b920043dbbd", 1, 1, "counter", &function_87d68f99, 0, 0);
	clientfield::register("world", "" + #"attic_room", 1, 1, "int", &attic_room, 0, 0);
	clientfield::register("world", "" + #"hash_5474fbb93aebbb65", 1, 1, "int", &function_e6ce9708, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_46dbc12bdc275121", 1, 1, "int", &function_a1c1c77c, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_59623b8b4fc694c8", 1, 2, "int", &function_db9b47b5, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_ce418c45d804842", 1, 1, "counter", &function_2f00e842, 0, 0);
	level._effect[#"hash_7184fc7d78dcf1c0"] = #"hash_73000f9a6abd5658";
	level._effect[#"hash_20080a107a8533e"] = #"hash_7965ec9e0938553f";
	level._effect[#"hash_693856e4806af4dc"] = #"hash_2844b7026fd0f451";
	level._effect[#"hash_7792af358100c735"] = #"hash_3d18884453d39646";
	level._effect[#"light_red"] = #"hash_6fdf0d26a4ab7a7";
}

/*
	Name: function_87d68f99
	Namespace: namespace_e18ec19b
	Checksum: 0x988B7DF9
	Offset: 0x4D0
	Size: 0x84
	Parameters: 7
	Flags: Linked
*/
function function_87d68f99(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	self thread postfx::playpostfxbundle(#"hash_114ea20734e794cf");
	playsound(localclientnum, #"hash_307805bbe1d946b", (0, 0, 0));
}

/*
	Name: function_33f1dd99
	Namespace: namespace_e18ec19b
	Checksum: 0x35A2E68A
	Offset: 0x560
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_33f1dd99(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_7792af358100c735"], self, "j_spine_4");
}

/*
	Name: function_e6ce9708
	Namespace: namespace_e18ec19b
	Checksum: 0x8EBC1BE4
	Offset: 0x5E0
	Size: 0x84
	Parameters: 7
	Flags: Linked
*/
function function_e6ce9708(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		function_a5777754(localclientnum, "broom_closet");
	}
	else
	{
		function_73b1f242(localclientnum, "broom_closet");
	}
}

/*
	Name: attic_room
	Namespace: namespace_e18ec19b
	Checksum: 0x645089DF
	Offset: 0x670
	Size: 0x84
	Parameters: 7
	Flags: Linked
*/
function attic_room(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		function_a5777754(localclientnum, "back_room");
	}
	else
	{
		function_73b1f242(localclientnum, "back_room");
	}
}

/*
	Name: function_a1c1c77c
	Namespace: namespace_e18ec19b
	Checksum: 0xDC56D60
	Offset: 0x700
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_a1c1c77c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_7184fc7d78dcf1c0"], self, "tag_origin");
}

/*
	Name: function_db9b47b5
	Namespace: namespace_e18ec19b
	Checksum: 0x9BFD671F
	Offset: 0x780
	Size: 0x1C6
	Parameters: 7
	Flags: Linked
*/
function function_db9b47b5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self.var_2d6d5baa = util::playfxontag(localclientnum, level._effect[#"light_red"], self, "tag_eye_rt");
		self.var_ab585fc = util::playfxontag(localclientnum, level._effect[#"light_red"], self, "tag_eye_lt");
	}
	else if(newval == 2)
	{
		self.var_a25a09ff = util::playfxontag(localclientnum, level._effect[#"hash_20080a107a8533e"], self, "tag_origin");
	}
	else if(isdefined(self.var_2d6d5baa))
	{
		killfx(localclientnum, self.var_2d6d5baa);
		self.var_2d6d5baa = undefined;
	}
	if(isdefined(self.var_ab585fc))
	{
		killfx(localclientnum, self.var_ab585fc);
		self.var_ab585fc = undefined;
	}
	if(isdefined(self.var_a25a09ff))
	{
		stopfx(localclientnum, self.var_a25a09ff);
		self.var_a25a09ff = undefined;
	}
}

/*
	Name: function_2f00e842
	Namespace: namespace_e18ec19b
	Checksum: 0x19DBAA89
	Offset: 0x950
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_2f00e842(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_693856e4806af4dc"], self, "tag_origin");
}

