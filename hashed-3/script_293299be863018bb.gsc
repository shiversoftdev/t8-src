// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_6a3f43063dfd1bdc;
#using script_6c5b51f98cd04fa3;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace namespace_6f62781f;

/*
	Name: init
	Namespace: namespace_6f62781f
	Checksum: 0x291F700C
	Offset: 0xC0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function init()
{
	init_flags();
	function_88d1bd71();
}

/*
	Name: init_flags
	Namespace: namespace_6f62781f
	Checksum: 0x1C04090A
	Offset: 0xF0
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function init_flags()
{
	level flag::init(#"hash_3e2d063d97c06905");
	level flag::init(#"hash_8987a45b2eda7c4");
	level flag::init(#"hash_743603caa0ee0976");
	level flag::init(#"hash_370781d7705e4e18");
	level flag::init(#"hash_3b152242499836c8");
}

/*
	Name: function_88d1bd71
	Namespace: namespace_6f62781f
	Checksum: 0x8024A27B
	Offset: 0x1A0
	Size: 0x26C
	Parameters: 0
	Flags: Linked
*/
function function_88d1bd71()
{
	level.var_51acdb19 = getent("dempsey_grenade", "targetname");
	level.var_a7a99ef1 = struct::get(#"hash_5720572540b41747");
	level.var_cd51aa28 = 0;
	level.var_440b230b = 0;
	namespace_ee206246::register(#"hash_63dc1e557f49595f", #"step_1", #"hash_4d540289d82df269", &function_4c20829a, &function_37518cc4);
	namespace_ee206246::register(#"hash_63dc1e557f49595f", #"step_2", #"hash_4d53ff89d82ded50", &function_ec156b93, &function_44101788);
	namespace_ee206246::register(#"hash_63dc1e557f49595f", #"step_3", #"hash_4d540089d82def03", &function_f2757dee, &function_cc61f0a3);
	namespace_ee206246::register(#"hash_63dc1e557f49595f", #"step_4", #"hash_4d540589d82df782", &function_29f2b66e, &function_4cf57214);
	namespace_ee206246::register(#"hash_63dc1e557f49595f", #"step_5", #"hash_4d540689d82df935", &function_b7f1e7df, &function_2c09c7d2);
	namespace_ee206246::start(#"hash_63dc1e557f49595f");
}

/*
	Name: function_4c20829a
	Namespace: namespace_6f62781f
	Checksum: 0x283A5D36
	Offset: 0x418
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_4c20829a(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level flag::wait_till(#"hash_5df188993c013698");
		level.var_51acdb19 thread grenade_watcher();
		level flag::wait_till(#"hash_3e2d063d97c06905");
	}
}

/*
	Name: function_37518cc4
	Namespace: namespace_6f62781f
	Checksum: 0x3136A84D
	Offset: 0x490
	Size: 0xB4
	Parameters: 2
	Flags: Linked
*/
function function_37518cc4(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level.var_cd51aa28 = 1;
		level flag::set(#"hash_3e2d063d97c06905");
	}
	else
	{
		level.var_cd51aa28 = 1;
		playsoundatposition(#"hash_259ff339b748935e", level.var_a7a99ef1.origin);
		level waittill(#"hash_4a19fd40add44b83");
	}
}

/*
	Name: function_ec156b93
	Namespace: namespace_6f62781f
	Checksum: 0xC4021A
	Offset: 0x550
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_ec156b93(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level.var_51acdb19 thread grenade_watcher();
		level flag::wait_till(#"hash_8987a45b2eda7c4");
	}
}

/*
	Name: function_44101788
	Namespace: namespace_6f62781f
	Checksum: 0xFBB98501
	Offset: 0x5A8
	Size: 0xB4
	Parameters: 2
	Flags: Linked
*/
function function_44101788(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level.var_cd51aa28 = 2;
		level flag::set(#"hash_8987a45b2eda7c4");
	}
	else
	{
		level.var_cd51aa28 = 2;
		playsoundatposition(#"hash_68bbb4ef1a9d22af", level.var_a7a99ef1.origin);
		level waittill(#"hash_4a19fd40add44b83");
	}
}

/*
	Name: function_f2757dee
	Namespace: namespace_6f62781f
	Checksum: 0x154040E8
	Offset: 0x668
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_f2757dee(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level.var_51acdb19 thread grenade_watcher();
		level flag::wait_till(#"hash_743603caa0ee0976");
	}
}

/*
	Name: function_cc61f0a3
	Namespace: namespace_6f62781f
	Checksum: 0x58A0EBDF
	Offset: 0x6C0
	Size: 0xB4
	Parameters: 2
	Flags: Linked
*/
function function_cc61f0a3(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level.var_cd51aa28 = 3;
		level flag::set(#"hash_743603caa0ee0976");
	}
	else
	{
		level.var_cd51aa28 = 3;
		playsoundatposition(#"hash_5c206c7dd64ec92c", level.var_a7a99ef1.origin);
		level waittill(#"hash_4a19fd40add44b83");
	}
}

/*
	Name: function_29f2b66e
	Namespace: namespace_6f62781f
	Checksum: 0xA5FAA66
	Offset: 0x780
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_29f2b66e(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level.var_51acdb19 thread grenade_watcher();
		level flag::wait_till(#"hash_370781d7705e4e18");
	}
}

/*
	Name: function_4cf57214
	Namespace: namespace_6f62781f
	Checksum: 0x92FCB0F
	Offset: 0x7D8
	Size: 0xB4
	Parameters: 2
	Flags: Linked
*/
function function_4cf57214(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level.var_cd51aa28 = 4;
		level flag::set(#"hash_370781d7705e4e18");
	}
	else
	{
		level.var_cd51aa28 = 4;
		playsoundatposition(#"hash_2c8959d200afc735", level.var_a7a99ef1.origin);
		level waittill(#"hash_4a19fd40add44b83");
	}
}

/*
	Name: function_b7f1e7df
	Namespace: namespace_6f62781f
	Checksum: 0x8F4A57E7
	Offset: 0x898
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_b7f1e7df(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level.var_51acdb19 thread grenade_watcher();
		level flag::wait_till(#"hash_3b152242499836c8");
	}
}

/*
	Name: function_2c09c7d2
	Namespace: namespace_6f62781f
	Checksum: 0x21C50B19
	Offset: 0x8F0
	Size: 0xD4
	Parameters: 2
	Flags: Linked
*/
function function_2c09c7d2(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level.var_cd51aa28 = 5;
		level flag::set(#"hash_3b152242499836c8");
	}
	else
	{
		level.var_cd51aa28 = 5;
		namespace_509a75d1::function_e308175e(#"hash_3bd00f2e3293cc1a", level.var_a7a99ef1.origin);
		wait(1);
		namespace_509a75d1::function_e308175e(#"hash_63eaabff22eb9bab", level.var_a7a99ef1.origin);
	}
}

/*
	Name: grenade_watcher
	Namespace: namespace_6f62781f
	Checksum: 0xA73F42E4
	Offset: 0x9D0
	Size: 0x208
	Parameters: 0
	Flags: Linked
*/
function grenade_watcher()
{
	level endon(#"end_game");
	self endon(#"hash_6bd75ef75b59f0b9");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		if(waitresult.mod === "MOD_GRENADE_SPLASH" && level.var_440b230b < level.round_number)
		{
			switch(level.var_cd51aa28)
			{
				case 0:
				{
					level flag::set(#"hash_3e2d063d97c06905");
					self notify(#"hash_6bd75ef75b59f0b9");
				}
				case 1:
				{
					level flag::set(#"hash_8987a45b2eda7c4");
					self notify(#"hash_6bd75ef75b59f0b9");
				}
				case 2:
				{
					level flag::set(#"hash_743603caa0ee0976");
					self notify(#"hash_6bd75ef75b59f0b9");
				}
				case 3:
				{
					level flag::set(#"hash_370781d7705e4e18");
					self notify(#"hash_6bd75ef75b59f0b9");
				}
				case 4:
				{
					level flag::set(#"hash_3b152242499836c8");
					self notify(#"hash_6bd75ef75b59f0b9");
				}
			}
			level.var_440b230b = level.round_number;
		}
		waitframe(1);
	}
}

