// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_c402654;

/*
	Name: function_89f2df9
	Namespace: namespace_c402654
	Checksum: 0xA93CF59
	Offset: 0x120
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_29467933d0da473b", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_c402654
	Checksum: 0x837F2A35
	Offset: 0x168
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_dog_fx();
	clientfield::register("actor", "dog_fx", 15000, 1, "int", &dog_fx, 0, 0);
	clientfield::register("actor", "dog_spawn_fx", 15000, 1, "counter", &dog_spawn_fx, 0, 0);
}

/*
	Name: init_dog_fx
	Namespace: namespace_c402654
	Checksum: 0x4510B12
	Offset: 0x218
	Size: 0x182
	Parameters: 0
	Flags: Linked
*/
function init_dog_fx()
{
	level._effect[#"dog_eye_glow"] = #"hash_70696527ecb861ae";
	level._effect[#"hash_55d6ab2c7eecbad4"] = #"hash_249f091d13da3663";
	level._effect[#"hash_808a86715bfac90"] = #"hash_78f02617f4f71d8a";
	level._effect[#"hash_5e4d4083a69396b8"] = #"hash_36a9dd505e78a";
	level._effect[#"hash_33fd6545401e3622"] = #"hash_39b25de05718b20c";
	level._effect[#"hash_63f497890003547"] = #"hash_3055dc23ae9ca695";
	level._effect[#"dog_gib"] = #"hash_529c1a5672216926";
	level._effect[#"lightning_dog_spawn"] = #"hash_50a6b2497d454910";
}

/*
	Name: dog_fx
	Namespace: namespace_c402654
	Checksum: 0x334EB110
	Offset: 0x3A8
	Size: 0x3CC
	Parameters: 7
	Flags: Linked
*/
function dog_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::waittill_dobj(localclientnum);
	if(!isdefined(self))
	{
		return;
	}
	if(newval)
	{
		if(!isdefined(self.var_93471229))
		{
			self.var_93471229 = [];
		}
		array::add(self.var_93471229, util::playfxontag(localclientnum, level._effect[#"hash_808a86715bfac90"], self, "j_neck_end"));
		array::add(self.var_93471229, util::playfxontag(localclientnum, level._effect[#"hash_5e4d4083a69396b8"], self, "j_tail0"));
		array::add(self.var_93471229, util::playfxontag(localclientnum, level._effect[#"hash_5e4d4083a69396b8"], self, "j_tail1"));
		array::add(self.var_93471229, util::playfxontag(localclientnum, level._effect[#"hash_33fd6545401e3622"], self, "j_spine2"));
		array::add(self.var_93471229, util::playfxontag(localclientnum, level._effect[#"hash_63f497890003547"], self, "j_neck"));
		array::add(self.var_93471229, util::playfxontag(localclientnum, level._effect[#"hash_55d6ab2c7eecbad4"], self, "tag_eye"));
		array::add(self.var_93471229, util::playfxontag(localclientnum, level._effect[#"dog_eye_glow"], self, "j_eyeball_le"));
		self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1, 1);
	}
	else if(isdefined(self.var_93471229))
	{
		foreach(fxhandle in self.var_93471229)
		{
			deletefx(localclientnum, fxhandle);
		}
	}
	util::playfxontag(localclientnum, level._effect[#"dog_gib"], self, "j_spine2");
	physicsexplosionsphere(localclientnum, self.origin, 150, 0, 0.15);
}

/*
	Name: dog_spawn_fx
	Namespace: namespace_c402654
	Checksum: 0x9936920C
	Offset: 0x780
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function dog_spawn_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	util::playfxontag(localclientnum, level._effect[#"lightning_dog_spawn"], self, "j_spine2");
}

