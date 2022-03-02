// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\renderoverridebundle.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace namespace_96bb7ff1;

/*
	Name: function_89f2df9
	Namespace: namespace_96bb7ff1
	Checksum: 0xD27F4C76
	Offset: 0x188
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_25e55405f08016db", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_96bb7ff1
	Checksum: 0xB7662FC7
	Offset: 0x1D0
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(getdvarint(#"hash_4e1190045ef3588b", 0))
	{
		function_27473e44();
	}
}

/*
	Name: function_27473e44
	Namespace: namespace_96bb7ff1
	Checksum: 0x3004A709
	Offset: 0x218
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function function_27473e44()
{
	zm_perks::register_perk_clientfields(#"hash_4519dc1d3ac79139", &function_37236662, &function_6705773b);
	zm_perks::register_perk_init_thread(#"hash_4519dc1d3ac79139", &init);
	zm_perks::function_b60f4a9f(#"hash_4519dc1d3ac79139", #"hash_4d317eb82b267b50", "zombie/fx8_perk_altar_symbol_ambient_blood_wolf", #"hash_75ec38c3f3487d5");
	zm_perks::function_f3c80d73("zombie_perk_bottle_wolf_protector", "zombie_perk_totem_wolf_protector");
}

/*
	Name: init
	Namespace: namespace_96bb7ff1
	Checksum: 0x48FF17F8
	Offset: 0x300
	Size: 0x92
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level._effect[#"hash_7e57e8f68ea37ffa"] = #"hash_66c3b340356c182b";
	level._effect[#"hash_2b6b5aa12ed687c5"] = #"hash_6ded6189669f2669";
	level._effect[#"hash_674126a125f46aae"] = #"hash_1d5598025e3875a8";
}

/*
	Name: function_37236662
	Namespace: namespace_96bb7ff1
	Checksum: 0xF6688075
	Offset: 0x3A0
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_37236662()
{
	clientfield::register("actor", "wolf_protector_fx", 20000, 1, "int", &wolf_protector_fx, 0, 0);
	clientfield::register("actor", "wolf_protector_spawn_fx", 20000, 1, "counter", &wolf_protector_spawn_fx, 0, 0);
}

/*
	Name: function_6705773b
	Namespace: namespace_96bb7ff1
	Checksum: 0x80F724D1
	Offset: 0x440
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_6705773b()
{
}

/*
	Name: wolf_protector_fx
	Namespace: namespace_96bb7ff1
	Checksum: 0xF8E8577E
	Offset: 0x450
	Size: 0x204
	Parameters: 7
	Flags: Linked
*/
function wolf_protector_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::waittill_dobj(localclientnum);
	if(!isdefined(self))
	{
		return;
	}
	self renderoverridebundle::function_c8d97b8e(localclientnum, #"hash_5d0631b016d4fe26", #"hash_5afb2d74423459bf");
	forcestreamxmodel(self.model);
	if(newval === 1)
	{
		self setdrawname(#"hash_3de0e353449c8994", 1);
		self._eyeglow_fx_override = level._effect[#"hash_7e57e8f68ea37ffa"];
		self._eyeglow_tag_override = "tag_eye";
		self zm::createzombieeyes(localclientnum);
		self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, zm::get_eyeball_on_luminance(), self zm::get_eyeball_color());
	}
	else
	{
		self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, zm::get_eyeball_off_luminance(), self zm::get_eyeball_color());
		self zm::deletezombieeyes(localclientnum);
		util::playfxontag(localclientnum, level._effect[#"hash_674126a125f46aae"], self, "j_spine4");
	}
}

/*
	Name: wolf_protector_spawn_fx
	Namespace: namespace_96bb7ff1
	Checksum: 0xFAC4E3E6
	Offset: 0x660
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function wolf_protector_spawn_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_2b6b5aa12ed687c5"], self, "j_spine4");
}

