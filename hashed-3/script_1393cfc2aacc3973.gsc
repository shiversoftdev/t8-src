// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_14c378fe;

/*
	Name: function_89f2df9
	Namespace: namespace_14c378fe
	Checksum: 0x52B1DAAE
	Offset: 0x168
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_5bea4c43846046ef", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_14c378fe
	Checksum: 0x3241BB37
	Offset: 0x1B0
	Size: 0x14C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(getgametypesetting(#"hash_2992e3d39d55b312")) && getgametypesetting(#"hash_2992e3d39d55b312")))
	{
		return;
	}
	clientfield::register("allplayers", "hasspectrebody", 16000, 1, "int", &function_14430aff, 0, 0);
	clientfield::register("toplayer", "spectrebladebonus", 16000, 1, "int", &function_4695335, 0, 0);
	clientfield::register("clientuimodel", "hudItems.isSpectre", 16000, 1, "int", undefined, 0, 0);
	clientfield::register("world", "showSpectreSwordBeams", 16000, 1, "int", undefined, 0, 0);
}

/*
	Name: function_14430aff
	Namespace: namespace_14c378fe
	Checksum: 0x9A6FBB72
	Offset: 0x308
	Size: 0x2A4
	Parameters: 7
	Flags: Linked
*/
function function_14430aff(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self notify(#"hash_2e4cc87f4b3a6396");
	self endon(#"death", #"hash_2e4cc87f4b3a6396");
	if(bwastimejump || bnewent)
	{
		if(self function_d2503806(#"hash_79bdfb09e317953"))
		{
			self function_f6e99a8d(#"hash_79bdfb09e317953");
		}
		return;
	}
	if(self ishidden())
	{
		return;
	}
	if(!self function_d2503806(#"hash_79bdfb09e317953"))
	{
		self function_bf9d3071(#"hash_79bdfb09e317953");
		if(function_5c10bd79(localclientnum) == self)
		{
			playsound(localclientnum, #"hash_2a2ce981dd655c9d");
		}
		else
		{
			self playsound(localclientnum, #"hash_15fe9b5adcf69ee1");
		}
	}
	self thread function_49c88376(localclientnum, newval);
	wait(0.5);
	if(self function_d2503806(#"hash_79bdfb09e317953"))
	{
		if(self ishidden())
		{
			self function_f6e99a8d(#"hash_79bdfb09e317953");
		}
		else
		{
			self function_5d482e78(#"hash_79bdfb09e317953");
			if(function_5c10bd79(localclientnum) == self)
			{
				playsound(localclientnum, #"hash_1e69f4ab3ad9d506");
			}
			else
			{
				self playsound(localclientnum, #"hash_6920e6c1de254c0a");
			}
		}
	}
}

/*
	Name: function_49c88376
	Namespace: namespace_14c378fe
	Checksum: 0x1E8D82A6
	Offset: 0x5B8
	Size: 0xCC
	Parameters: 2
	Flags: Linked, Private
*/
private function function_49c88376(localclientnum, value)
{
	self endon(#"death");
	if(!value && function_5c10bd79(localclientnum) == self)
	{
		wait(0.3);
		if(self hasdobj(localclientnum))
		{
			playtagfxset(localclientnum, "tagfx8_plyr_spectre_transformation_wz_1p", self);
		}
	}
	else
	{
		wait(0.1);
		if(self hasdobj(localclientnum))
		{
			playtagfxset(localclientnum, "tagfx8_plyr_spectre_transformation_wz_3p", self);
		}
	}
}

/*
	Name: function_4695335
	Namespace: namespace_14c378fe
	Checksum: 0xF4404C02
	Offset: 0x690
	Size: 0xA4
	Parameters: 7
	Flags: Linked, Private
*/
private function function_4695335(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		playsound(localclientnum, #"hash_11ab19e8dda10854");
		if(!self function_d2503806(#"hash_62ee6965d1ee1724"))
		{
			self function_bf9d3071(#"hash_62ee6965d1ee1724");
		}
	}
}

