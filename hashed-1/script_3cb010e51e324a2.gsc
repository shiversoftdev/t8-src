// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace namespace_bb20e441;

/*
	Name: function_89f2df9
	Namespace: namespace_bb20e441
	Checksum: 0xAEC9531D
	Offset: 0xB0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"ray_gun_mk2y", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_bb20e441
	Checksum: 0x61698A79
	Offset: 0xF8
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level._effect[#"hash_7772ff2676425bfb"] = #"hash_1993197e5796e1a3";
	level._effect[#"hash_776cf326763ddbe9"] = #"hash_198c2d7e5790e4f1";
	clientfield::register("allplayers", "" + #"ray_gun_mk2y_charged", 20000, 1, "int", &function_e1fdbb4b, 0, 0);
}

/*
	Name: function_e1fdbb4b
	Namespace: namespace_bb20e441
	Checksum: 0xF6E1A6B6
	Offset: 0x1B8
	Size: 0x112
	Parameters: 7
	Flags: Linked
*/
function function_e1fdbb4b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_92a2b5f2))
	{
		killfx(localclientnum, self.var_92a2b5f2);
		self.var_92a2b5f2 = undefined;
	}
	if(newval == 1)
	{
		if(self zm_utility::function_f8796df3(localclientnum))
		{
			self.var_92a2b5f2 = playviewmodelfx(localclientnum, level._effect[#"hash_7772ff2676425bfb"], "tag_flash");
		}
		else
		{
			self.var_92a2b5f2 = util::playfxontag(localclientnum, level._effect[#"hash_776cf326763ddbe9"], self, "tag_flash");
		}
	}
}

