// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\exploder_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_140c66e4;

/*
	Name: init
	Namespace: namespace_140c66e4
	Checksum: 0xA9C84429
	Offset: 0xD8
	Size: 0x10A
	Parameters: 0
	Flags: Linked
*/
function init()
{
	clientfield::register("actor", "boiling_trap_death_fx", 16000, 1, "int", &boiling_trap_death_fx, 0, 0);
	level._effect[#"hash_74231fd5ca0777d5"] = #"hash_4a3e0ecc06d7f471";
	level._effect[#"hash_9264b27ed7a10ae"] = #"hash_326e8ad99fb9a4d2";
	level._effect[#"hash_6f73421e00853979"] = #"hash_26ef50e01d7e97e5";
	level._effect[#"hash_2d586022ea5a3e3e"] = #"hash_5591c8559d52363a";
}

/*
	Name: boiling_trap_death_fx
	Namespace: namespace_140c66e4
	Checksum: 0xB5577B31
	Offset: 0x1F0
	Size: 0x22E
	Parameters: 7
	Flags: Linked
*/
function boiling_trap_death_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		self.var_5f1a7000 = util::playfxontag(localclientnum, level._effect[#"hash_74231fd5ca0777d5"], self, "j_elbow_le");
		self.var_259cede3 = util::playfxontag(localclientnum, level._effect[#"hash_9264b27ed7a10ae"], self, "j_elbow_ri");
		self.var_6aafc213 = util::playfxontag(localclientnum, level._effect[#"hash_6f73421e00853979"], self, "j_head");
		self.var_895fc896 = util::playfxontag(localclientnum, level._effect[#"hash_2d586022ea5a3e3e"], self, "j_spine4");
	}
	else if(isdefined(self.var_5f1a7000))
	{
		stopfx(localclientnum, self.var_5f1a7000);
		self.var_5f1a7000 = undefined;
	}
	if(isdefined(self.var_259cede3))
	{
		stopfx(localclientnum, self.var_259cede3);
		self.var_259cede3 = undefined;
	}
	if(isdefined(self.var_6aafc213))
	{
		stopfx(localclientnum, self.var_6aafc213);
		self.var_6aafc213 = undefined;
	}
	if(isdefined(self.var_895fc896))
	{
		stopfx(localclientnum, self.var_895fc896);
		self.var_895fc896 = undefined;
	}
}

