// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace namespace_2cbb6c62;

/*
	Name: function_89f2df9
	Namespace: namespace_2cbb6c62
	Checksum: 0xF1B63F5A
	Offset: 0x180
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_4b8517108556612", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_2cbb6c62
	Checksum: 0x2EBAFA7B
	Offset: 0x1C8
	Size: 0x134
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_25c1f211 = getweapon(#"ww_tesla_sniper_t8");
	level.var_77b3abb1 = getweapon(#"ww_tesla_sniper_upgraded_t8");
	level.var_490afdb9 = array(undefined, "zm_weapons/fx8_ww_tesla_sniper_bulb_d", "zm_weapons/fx8_ww_tesla_sniper_bulb_c", "zm_weapons/fx8_ww_tesla_sniper_bulb_b", "zm_weapons/fx8_ww_tesla_sniper_bulb_a");
	clientfield::register("toplayer", "" + #"hash_3aad9502fc3b54f2", 24000, 1, "int", &function_87dc06ae, 0, 0);
	clientfield::register("actor", "zm_weapons/fx8_ww_tesla_sniper_impact_lg", 24000, 1, "counter", &function_190ae9a1, 0, 0);
}

/*
	Name: function_190ae9a1
	Namespace: namespace_2cbb6c62
	Checksum: 0xED4242F
	Offset: 0x308
	Size: 0xBC
	Parameters: 7
	Flags: Linked, Private
*/
function private function_190ae9a1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	origin = self gettagorigin("j_spine4");
	if(isdefined(self) && newval && isdefined(origin))
	{
		playfx(localclientnum, "zm_weapons/fx8_ww_tesla_sniper_impact_lg", self gettagorigin("j_spine4"));
	}
}

/*
	Name: function_87dc06ae
	Namespace: namespace_2cbb6c62
	Checksum: 0xCB9DFC58
	Offset: 0x3D0
	Size: 0x8C
	Parameters: 7
	Flags: Linked
*/
function function_87dc06ae(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self thread function_2d6416dc(localclientnum);
	}
	else
	{
		self notify(#"hash_319d2bba47dac2c4");
		self function_a6907b54(localclientnum);
	}
}

/*
	Name: function_2d6416dc
	Namespace: namespace_2cbb6c62
	Checksum: 0xA6D379D8
	Offset: 0x468
	Size: 0x242
	Parameters: 1
	Flags: Linked
*/
function function_2d6416dc(localclientnum)
{
	self endon(#"death", #"hash_319d2bba47dac2c4");
	w_current = getcurrentweapon(localclientnum);
	n_clip_size = w_current.clipsize;
	if(!isdefined(n_clip_size) || n_clip_size == 0)
	{
		if(w_current === level.var_77b3abb1)
		{
			n_clip_size = 16;
		}
		else
		{
			n_clip_size = 8;
		}
	}
	if(!isdefined(self.var_7ad5becf))
	{
		self.var_7ad5becf = [];
	}
	while(true)
	{
		wait(0.1);
		if(viewmodelhastag(localclientnum, "tag_flash"))
		{
			n_ammo = getweaponammoclip(localclientnum, w_current);
			var_b59ce28 = n_ammo / n_clip_size;
			var_7ec33855 = int(ceil(var_b59ce28 * 4));
			for(i = 1; i <= 4; i++)
			{
				if(i <= var_7ec33855 && !isdefined(self.var_7ad5becf[i]))
				{
					self.var_7ad5becf[i] = playviewmodelfx(localclientnum, level.var_490afdb9[i], "tag_flash");
				}
				if(i > var_7ec33855 && isdefined(self.var_7ad5becf[i]))
				{
					deletefx(localclientnum, self.var_7ad5becf[i], 1);
					self.var_7ad5becf[i] = undefined;
				}
			}
		}
	}
}

/*
	Name: function_a6907b54
	Namespace: namespace_2cbb6c62
	Checksum: 0x1EAB2C20
	Offset: 0x6B8
	Size: 0x7E
	Parameters: 1
	Flags: Linked
*/
function function_a6907b54(localclientnum)
{
	for(i = 1; i <= 4; i++)
	{
		if(isdefined(self.var_7ad5becf[i]))
		{
			deletefx(localclientnum, self.var_7ad5becf[i], 1);
			self.var_7ad5becf[i] = undefined;
		}
	}
}

