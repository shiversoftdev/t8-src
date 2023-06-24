// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm.csc;

#namespace zombie_dog_util;

/*
	Name: __init__system__
	Namespace: zombie_dog_util
	Checksum: 0xBC038C3D
	Offset: 0x148
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zombie_dog_util", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zombie_dog_util
	Checksum: 0x6825A180
	Offset: 0x190
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_dog_fx();
	clientfield::register("actor", "dog_fx", 1, 1, "int", &dog_fx, 0, 0);
	clientfield::register("actor", "dog_spawn_fx", 1, 1, "counter", &dog_spawn_fx, 0, 0);
	clientfield::register("world", "dog_round_fog_bank", 1, 1, "int", &dog_round_fog_bank, 0, 0);
}

/*
	Name: init_dog_fx
	Namespace: zombie_dog_util
	Checksum: 0x7ED781B4
	Offset: 0x288
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
	Namespace: zombie_dog_util
	Checksum: 0xD79DA4F5
	Offset: 0x418
	Size: 0x46C
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
		self._eyeglow_fx_override = level._effect[#"dog_eye_glow"];
		self zm::createzombieeyes(localclientnum);
		self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, zm::get_eyeball_on_luminance(), self zm::get_eyeball_color());
		if(!isdefined(self.var_93471229))
		{
			self.var_93471229 = [];
		}
		if(isdefined(level.var_17c4823f) && !isdefined(self.var_a9305c6e))
		{
			self.var_a9305c6e = self playloopsound(level.var_17c4823f);
		}
		array::add(self.var_93471229, util::playfxontag(localclientnum, level._effect[#"hash_808a86715bfac90"], self, "j_neck_end"));
		array::add(self.var_93471229, util::playfxontag(localclientnum, level._effect[#"hash_5e4d4083a69396b8"], self, "j_tail0"));
		array::add(self.var_93471229, util::playfxontag(localclientnum, level._effect[#"hash_5e4d4083a69396b8"], self, "j_tail1"));
		array::add(self.var_93471229, util::playfxontag(localclientnum, level._effect[#"hash_33fd6545401e3622"], self, "j_spine2"));
		array::add(self.var_93471229, util::playfxontag(localclientnum, level._effect[#"hash_63f497890003547"], self, "j_neck"));
		array::add(self.var_93471229, util::playfxontag(localclientnum, level._effect[#"hash_55d6ab2c7eecbad4"], self, "tag_eye"));
	}
	else
	{
		if(isdefined(self.var_a9305c6e))
		{
			self stoploopsound(self.var_a9305c6e);
		}
		self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, zm::get_eyeball_off_luminance(), self zm::get_eyeball_color());
		self zm::deletezombieeyes(localclientnum);
		if(isdefined(self.var_93471229))
		{
			foreach(fxhandle in self.var_93471229)
			{
				deletefx(localclientnum, fxhandle);
			}
		}
		util::playfxontag(localclientnum, level._effect[#"dog_gib"], self, "j_spine2");
	}
}

/*
	Name: dog_spawn_fx
	Namespace: zombie_dog_util
	Checksum: 0x43F919DB
	Offset: 0x890
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function dog_spawn_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	util::playfxontag(localclientnum, level._effect[#"lightning_dog_spawn"], self, "j_spine2");
}

/*
	Name: dog_round_fog_bank
	Namespace: zombie_dog_util
	Checksum: 0xACAA680
	Offset: 0x910
	Size: 0xD4
	Parameters: 7
	Flags: Linked
*/
function dog_round_fog_bank(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		e_player = getlocalplayers()[localclientnum];
		e_player thread function_33593a44(localclientnum, 1, 2);
	}
	else
	{
		e_player = getlocalplayers()[localclientnum];
		e_player thread function_33593a44(localclientnum, 2, 1);
	}
}

/*
	Name: function_33593a44
	Namespace: zombie_dog_util
	Checksum: 0xA2CFAE5F
	Offset: 0x9F0
	Size: 0x198
	Parameters: 4
	Flags: Linked, Private
*/
function private function_33593a44(localclientnum, var_312d65d1, var_68f7ce2e, n_time = 3)
{
	self notify("3fd20b4701c90c8f");
	self endon("3fd20b4701c90c8f");
	n_blend = 0;
	n_increment = 1 / (n_time / 0.05);
	if(var_312d65d1 == 1 && var_68f7ce2e == 2)
	{
		while(n_blend < 1)
		{
			function_be93487f(localclientnum, var_312d65d1 | var_68f7ce2e, 1 - n_blend, n_blend, 0, 0);
			n_blend = n_blend + n_increment;
			wait(0.05);
		}
	}
	else if(var_312d65d1 == 2 && var_68f7ce2e == 1)
	{
		while(n_blend < 1)
		{
			function_be93487f(localclientnum, var_312d65d1 | var_68f7ce2e, n_blend, 1 - n_blend, 0, 0);
			n_blend = n_blend + n_increment;
			wait(0.05);
		}
	}
}

