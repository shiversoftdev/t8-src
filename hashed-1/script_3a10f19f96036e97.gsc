// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_70ab01a7690ea256;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace namespace_2928dd4b;

/*
	Name: function_89f2df9
	Namespace: namespace_2928dd4b
	Checksum: 0xE3ED9B67
	Offset: 0x1A0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_7f773699ffe5f857", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_2928dd4b
	Checksum: 0x97A14862
	Offset: 0x1E8
	Size: 0x22A
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("scriptmover", "flamethrower_tornado_fx", 1, 1, "int", &flamethrower_tornado_fx, 0, 0);
	clientfield::register("toplayer", "hero_flamethrower_vigor_postfx", 1, 1, "counter", &function_d05553c6, 0, 0);
	clientfield::register("toplayer", "flamethrower_wind_blast_flash", -1, 1, "counter", &flamethrower_wind_blast_flash, 0, 0);
	clientfield::register("allplayers", "flamethrower_wind_blast_tu16", 16000, 1, "counter", &flamethrower_wind_blast_flash, 0, 0);
	clientfield::register("toplayer", "flamethrower_tornado_blast_flash", 1, 1, "counter", &flamethrower_tornado_blast_flash, 0, 0);
	level._effect[#"hash_c75ff5d37b8fd"] = #"hash_2f45879d2658065c";
	level._effect[#"hash_365a82419bb9ce57"] = #"hash_312fc9707e06f6f4";
	level._effect[#"hash_34db403668f7f353"] = #"hash_52e3de5257e268c2";
	level._effect[#"hash_215edede52c5ed32"] = #"hash_5c5ffb835c39dce3";
}

/*
	Name: flamethrower_tornado_fx
	Namespace: namespace_2928dd4b
	Checksum: 0x967B6660
	Offset: 0x420
	Size: 0x196
	Parameters: 7
	Flags: Linked
*/
function flamethrower_tornado_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		if(isdefined(self.n_tornado_fx))
		{
			stopfx(localclientnum, self.n_tornado_fx);
		}
		self.n_tornado_fx = util::playfxontag(localclientnum, level._effect[#"hash_c75ff5d37b8fd"], self, "tag_origin");
		if(!isdefined(self.var_180064c2))
		{
			self thread function_ea05550b(localclientnum);
		}
		self thread function_4e325cd6(localclientnum);
	}
	else
	{
		if(isdefined(self.n_tornado_fx))
		{
			stopfx(localclientnum, self.n_tornado_fx);
			self.n_tornado_fx = undefined;
		}
		if(isdefined(self.var_180064c2))
		{
			self playsound(localclientnum, #"hash_51812161eb23c96f");
			self stoploopsound(self.var_180064c2);
			self.var_180064c2 = undefined;
		}
		self notify(#"hash_4a10e61d27734104");
	}
}

/*
	Name: function_ea05550b
	Namespace: namespace_2928dd4b
	Checksum: 0xD22401BF
	Offset: 0x5C0
	Size: 0x8A
	Parameters: 1
	Flags: Linked
*/
function function_ea05550b(localclientnum)
{
	self endon(#"death", #"hash_4a10e61d27734104");
	wait(0.1);
	self playsound(localclientnum, #"hash_2e4b3d95b5a51afa");
	self.var_180064c2 = self playloopsound(#"hash_468cabb7402e170e");
}

/*
	Name: function_4e325cd6
	Namespace: namespace_2928dd4b
	Checksum: 0xDB7BC7DE
	Offset: 0x658
	Size: 0x15C
	Parameters: 7
	Flags: Linked
*/
function function_4e325cd6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	self endon(#"death", #"hash_4a10e61d27734104");
	while(true)
	{
		a_e_players = getlocalplayers();
		foreach(e_player in a_e_players)
		{
			if(!e_player util::function_50ed1561(localclientnum))
			{
				continue;
			}
			if(distance(e_player.origin, self.origin) <= 128)
			{
				e_player playrumbleonentity(localclientnum, "damage_heavy");
			}
		}
		wait(0.25);
	}
}

/*
	Name: function_d05553c6
	Namespace: namespace_2928dd4b
	Checksum: 0x2B30AE5A
	Offset: 0x7C0
	Size: 0x8C
	Parameters: 7
	Flags: Linked, Private
*/
function private function_d05553c6(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newvalue && !namespace_a6aea2c6::is_active(#"hash_65cfe78dc61dd3af"))
	{
		self thread postfx::playpostfxbundle(#"hash_28d2c6df1a547302");
	}
}

/*
	Name: flamethrower_wind_blast_flash
	Namespace: namespace_2928dd4b
	Checksum: 0x7BF9B1E9
	Offset: 0x858
	Size: 0xCC
	Parameters: 7
	Flags: Linked
*/
function flamethrower_wind_blast_flash(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(self zm_utility::function_f8796df3(localclientnum))
	{
		playviewmodelfx(localclientnum, level._effect[#"hash_365a82419bb9ce57"], "tag_flash");
	}
	else
	{
		util::playfxontag(localclientnum, level._effect[#"hash_34db403668f7f353"], self, "tag_flash");
	}
}

/*
	Name: flamethrower_tornado_blast_flash
	Namespace: namespace_2928dd4b
	Checksum: 0x2CAAD5A5
	Offset: 0x930
	Size: 0xCC
	Parameters: 7
	Flags: Linked
*/
function flamethrower_tornado_blast_flash(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(self zm_utility::function_f8796df3(localclientnum))
	{
		playviewmodelfx(localclientnum, level._effect[#"hash_215edede52c5ed32"], "tag_flash");
	}
	else
	{
		util::playfxontag(localclientnum, level._effect[#"hash_215edede52c5ed32"], self, "tag_flash");
	}
}

