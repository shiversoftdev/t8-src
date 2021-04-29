// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_54386dac;

/*
	Name: init_clientfields
	Namespace: namespace_54386dac
	Checksum: 0xCDF18D4A
	Offset: 0xB8
	Size: 0x192
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("scriptmover", "" + #"hash_7327d0447d656234", 1, 1, "int", &function_6799fbc4, 0, 0);
	clientfield::register("item", "" + #"hash_76662556681a502c", 1, 1, "int", &function_e2c78db9, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_59be891b288663cc", 1, 1, "int", &function_41f46060, 0, 0);
	clientfield::register("toplayer", "" + #"hash_257c215ab25a21c5", 1, 1, "counter", &function_b334fc71, 0, 0);
	level._effect[#"hash_7e0daf8faf89bbcf"] = #"hash_1f101b4b415639bb";
}

/*
	Name: function_6799fbc4
	Namespace: namespace_54386dac
	Checksum: 0x3EEA0193
	Offset: 0x258
	Size: 0x176
	Parameters: 7
	Flags: Linked
*/
function function_6799fbc4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		if(!isdefined(level.var_22a393d4))
		{
			level.var_22a393d4 = [];
		}
		else if(!isarray(level.var_22a393d4))
		{
			level.var_22a393d4 = array(level.var_22a393d4);
		}
		if(!isinarray(level.var_22a393d4, self))
		{
			level.var_22a393d4[level.var_22a393d4.size] = self;
		}
		self.var_922c0c5c = &function_c06aed2;
		self.var_ffeecdb6 = &function_59cd4ca1;
		self hide();
	}
	else
	{
		arrayremovevalue(level.var_22a393d4, self);
		self show();
		self notify(#"hash_6ab654a4c018818c");
	}
}

/*
	Name: function_c06aed2
	Namespace: namespace_54386dac
	Checksum: 0x302271C5
	Offset: 0x3D8
	Size: 0x36
	Parameters: 1
	Flags: Linked, Private
*/
private function function_c06aed2(localclientnum)
{
	self show();
	self notify(#"set_visible");
}

/*
	Name: function_59cd4ca1
	Namespace: namespace_54386dac
	Checksum: 0xD0FD499C
	Offset: 0x418
	Size: 0x36
	Parameters: 1
	Flags: Linked, Private
*/
private function function_59cd4ca1(localclientnum)
{
	self hide();
	self notify(#"hash_488fe0f467820fcf");
}

/*
	Name: function_e2c78db9
	Namespace: namespace_54386dac
	Checksum: 0x334D2394
	Offset: 0x458
	Size: 0x112
	Parameters: 7
	Flags: Linked
*/
function function_e2c78db9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(isdefined(self.n_fx_id))
	{
		stopfx(localclientnum, self.n_fx_id);
		self.n_fx_id = undefined;
	}
	if(isdefined(self.var_b3673abf))
	{
		self stoploopsound(self.var_b3673abf);
		self.var_b3673abf = undefined;
	}
	if(newval)
	{
		self.n_fx_id = util::playfxontag(localclientnum, level._effect[#"hash_4d2e5c87bde94856"], self, "tag_origin");
		self.var_b3673abf = self playloopsound(#"hash_2f017f6ef4550155");
	}
}

/*
	Name: function_41f46060
	Namespace: namespace_54386dac
	Checksum: 0x821D1FE3
	Offset: 0x578
	Size: 0xBA
	Parameters: 7
	Flags: Linked
*/
function function_41f46060(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(isdefined(self.var_aa4114ee))
	{
		stopfx(localclientnum, self.var_aa4114ee);
		self.var_aa4114ee = undefined;
	}
	if(newval == 1)
	{
		self.var_aa4114ee = util::playfxontag(localclientnum, level._effect[#"hash_7e0daf8faf89bbcf"], self, "tag_origin");
	}
}

/*
	Name: function_b334fc71
	Namespace: namespace_54386dac
	Checksum: 0xB6F6CA37
	Offset: 0x640
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_b334fc71(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(!function_65b9eb0f(localclientnum))
	{
		self playrumbleonentity(localclientnum, #"hash_2be72209069697d0");
	}
}

