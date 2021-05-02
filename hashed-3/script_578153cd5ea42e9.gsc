// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_perks.gsc;

#namespace namespace_b7d493c4;

/*
	Name: function_89f2df9
	Namespace: namespace_b7d493c4
	Checksum: 0x871EEDC6
	Offset: 0x88
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_62d99633cc457fde", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_b7d493c4
	Checksum: 0xDD4F03A0
	Offset: 0xD8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_bf3cfde4();
}

/*
	Name: __main__
	Namespace: namespace_b7d493c4
	Checksum: 0x80F724D1
	Offset: 0xF8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: function_bf3cfde4
	Namespace: namespace_b7d493c4
	Checksum: 0xACD2B246
	Offset: 0x108
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_bf3cfde4()
{
	zm_perks::function_7f42e14e(#"hash_6ca140703a87cd09", "mod_slider", #"hash_63e46074d37d524b", #"specialty_phdflopper", 4500);
	zm_perks::register_perk_threads(#"hash_6ca140703a87cd09", &function_6a308c34, &function_ea0dd5e6);
}

/*
	Name: function_6a308c34
	Namespace: namespace_b7d493c4
	Checksum: 0xD6B2F1F7
	Offset: 0x1A8
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_6a308c34()
{
	self thread function_815172d1();
}

/*
	Name: function_ea0dd5e6
	Namespace: namespace_b7d493c4
	Checksum: 0x355A5777
	Offset: 0x1D0
	Size: 0x3E
	Parameters: 4
	Flags: Linked
*/
function function_ea0dd5e6(b_pause, str_perk, str_result, var_bcd1c2ff)
{
	self notify(#"hash_19d583212e9b3200");
	self.var_af850774 = undefined;
}

/*
	Name: function_815172d1
	Namespace: namespace_b7d493c4
	Checksum: 0x799F7398
	Offset: 0x218
	Size: 0x110
	Parameters: 0
	Flags: Linked
*/
function function_815172d1()
{
	self endon(#"disconnect", #"hash_19d583212e9b3200");
	var_be3643e6 = 0;
	while(true)
	{
		self.var_e9571d8b = undefined;
		while(!self isonground())
		{
			if(!var_be3643e6)
			{
				var_be3643e6 = 1;
				self.var_af850774 = 0;
				var_62a70da1 = self.origin[2];
			}
			else if(var_62a70da1 < self.origin[2])
			{
				var_62a70da1 = self.origin[2];
			}
			waitframe(1);
		}
		if(var_be3643e6)
		{
			self.var_e9571d8b = max(0, var_62a70da1 - self.origin[2]);
			var_be3643e6 = 0;
			waitframe(1);
		}
		waitframe(1);
	}
}

