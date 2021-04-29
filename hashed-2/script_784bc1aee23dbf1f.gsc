// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_70ab01a7690ea256;
#using scripts\core_common\ai_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace namespace_32e300a;

/*
	Name: function_89f2df9
	Namespace: namespace_32e300a
	Checksum: 0x3FF355A0
	Offset: 0x110
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_20ba676676b7bccf", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_32e300a
	Checksum: 0x59EEFC55
	Offset: 0x158
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("toplayer", "" + #"hash_55539d0cf92a8855", 1, 1, "counter", &function_d05553c6, 0, 0);
	clientfield::register("allplayers", "" + #"hash_13ccfca7b26cec97", 1, 1, "int", &function_ea3e4435, 0, 1);
	clientfield::register("allplayers", "" + #"hash_7e2af117e18cb9fa", 1, 1, "int", &function_29c31d8d, 0, 1);
}

/*
	Name: function_d05553c6
	Namespace: namespace_32e300a
	Checksum: 0x57808ED5
	Offset: 0x270
	Size: 0x8C
	Parameters: 7
	Flags: Linked, Private
*/
private function function_d05553c6(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newvalue && !namespace_a6aea2c6::is_active(#"hash_65cfe78dc61dd3af"))
	{
		self thread postfx::playpostfxbundle(#"hash_4e5b35f770492ddb");
	}
}

/*
	Name: function_ea3e4435
	Namespace: namespace_32e300a
	Checksum: 0xAA508717
	Offset: 0x308
	Size: 0x3B0
	Parameters: 7
	Flags: Linked
*/
function function_ea3e4435(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self.var_d3d459f))
	{
		self.var_d3d459f = [];
	}
	if(!isdefined(self.var_d3d459f[localclientnum]))
	{
		self.var_d3d459f[localclientnum] = [];
	}
	if(newval == 1)
	{
		if(self.weapon !== getweapon(#"hash_6627899099b8a69d"))
		{
			return;
		}
		if(self getlocalclientnumber() === localclientnum)
		{
			self thread postfx::playpostfxbundle(#"hash_34ce6f9f022458f8");
			self thread function_66752a96(localclientnum);
			a_e_players = getlocalplayers();
			foreach(e_player in a_e_players)
			{
				if(!e_player util::function_50ed1561(localclientnum))
				{
					e_player thread zm_utility::function_bb54a31f(localclientnum, #"hash_34ce6f9f022458f8", #"hash_49e404aa0d33e9ac");
				}
			}
		}
		else if(self hasdobj(localclientnum))
		{
			self.var_d3d459f[localclientnum] = playtagfxset(localclientnum, "weapon_katana_smoke_3p", self);
		}
	}
	else if(self getlocalclientnumber() === localclientnum)
	{
		self postfx::stoppostfxbundle(#"hash_34ce6f9f022458f8");
		self thread function_82ee4d9d(localclientnum);
		a_e_players = getlocalplayers();
		foreach(e_player in a_e_players)
		{
			if(!e_player util::function_50ed1561(localclientnum))
			{
				e_player notify(#"hash_49e404aa0d33e9ac");
			}
		}
	}
	else if(isdefined(self.var_d3d459f[localclientnum]))
	{
		foreach(fx in self.var_d3d459f[localclientnum])
		{
			stopfx(localclientnum, fx);
		}
		self.var_d3d459f[localclientnum] = undefined;
	}
}

/*
	Name: function_66752a96
	Namespace: namespace_32e300a
	Checksum: 0xF124441B
	Offset: 0x6C0
	Size: 0xC8
	Parameters: 1
	Flags: Linked, Private
*/
private function function_66752a96(localclientnum)
{
	ai::add_ai_spawn_function(&function_74541167);
	a_ai = getentarraybytype(localclientnum, 15);
	foreach(ai in a_ai)
	{
		ai thread function_74541167(localclientnum);
	}
}

/*
	Name: function_74541167
	Namespace: namespace_32e300a
	Checksum: 0xEBE06A74
	Offset: 0x790
	Size: 0xA2
	Parameters: 1
	Flags: Linked, Private
*/
private function function_74541167(localclientnum)
{
	if(!isdefined(self.var_1030ad00))
	{
		self.var_1030ad00 = [];
	}
	if(!isdefined(self.var_1030ad00[localclientnum]))
	{
		self.var_1030ad00[localclientnum] = [];
	}
	if(!self.var_1030ad00[localclientnum].size && self hasdobj(localclientnum))
	{
		self.var_1030ad00[localclientnum] = playtagfxset(localclientnum, "weapon_katana_zmb_smoke_3p", self);
	}
}

/*
	Name: function_82ee4d9d
	Namespace: namespace_32e300a
	Checksum: 0x15B60D55
	Offset: 0x840
	Size: 0x164
	Parameters: 1
	Flags: Linked, Private
*/
private function function_82ee4d9d(localclientnum)
{
	ai::function_932006d1(&function_74541167);
	a_ai = getentarraybytype(localclientnum, 15);
	foreach(ai in a_ai)
	{
		if(isdefined(ai.var_1030ad00) && isdefined(ai.var_1030ad00[localclientnum]))
		{
			foreach(fx in ai.var_1030ad00[localclientnum])
			{
				killfx(localclientnum, fx);
			}
			ai.var_1030ad00[localclientnum] = undefined;
		}
	}
}

/*
	Name: function_29c31d8d
	Namespace: namespace_32e300a
	Checksum: 0x11AD8F31
	Offset: 0x9B0
	Size: 0x10E
	Parameters: 7
	Flags: Linked
*/
function function_29c31d8d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		if(!isdefined(self.var_7804a42c))
		{
			self playsound(localclientnum, #"hash_74fd1bb2db3d91ee");
			self.var_7804a42c = self playloopsound(#"hash_4f7953dcf02e2ba7");
		}
	}
	else if(isdefined(self.var_7804a42c))
	{
		self playsound(localclientnum, #"hash_76e75d7b16257c11");
		self stoploopsound(self.var_7804a42c);
		self.var_7804a42c = undefined;
	}
}

