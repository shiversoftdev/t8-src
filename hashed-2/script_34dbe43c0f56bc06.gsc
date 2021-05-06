// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_170a9c130859c688;
#using script_3affe3aaa3f22cb0;
#using script_8210b63db522f15;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_1b05e45a;

/*
	Name: function_89f2df9
	Namespace: namespace_1b05e45a
	Checksum: 0xEBC9D2C9
	Offset: 0x98
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_17e03a4259356820", &__init__, undefined, #"hash_5f58ed4c79d56e3d");
}

/*
	Name: __init__
	Namespace: namespace_1b05e45a
	Checksum: 0x47B24855
	Offset: 0xE8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_90ee7a97(#"hash_f1156c5f8b9f0e8", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: namespace_1b05e45a
	Checksum: 0x29DA0348
	Offset: 0x128
	Size: 0x274
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		callback::on_player_killed(&on_player_killed);
		namespace_b0722f43::function_2749fcc3(#"hash_6a0d13acf3e5687d", #"hash_5f9831cef8ab9e8d", #"hash_24bfa06ffb71fcec", 2);
		namespace_b0722f43::function_2749fcc3(#"hash_33f7121f70c3065f", #"hash_5f9831cef8ab9e8d", #"hash_24bfa06ffb71fcec", 2);
		namespace_b0722f43::function_2749fcc3(#"hash_2b546c0315159617", #"hash_5f9831cef8ab9e8d", #"hash_24bfa06ffb71fcec", 2);
		namespace_b0722f43::function_2749fcc3(#"hash_183c9fe8af52fac7", #"hash_5f9831cef8ab9e8d", #"hash_24bfa06ffb71fcec", 2);
		namespace_b0722f43::function_2749fcc3(#"hash_49e8a607ea22e650", #"hash_5f9831cef8ab9e8d", #"hash_24bfa06ffb71fcec", 2);
		namespace_b0722f43::function_2749fcc3(#"hash_66f790c2630deace", #"hash_5f9831cef8ab9e8d", #"hash_24bfa06ffb71fcec", 2);
		namespace_b0722f43::function_2749fcc3(#"hash_ca8b234ad1fea38", #"hash_5f9831cef8ab9e8d", #"hash_24bfa06ffb71fcec", 2);
		namespace_b0722f43::function_2749fcc3(#"hash_4ee6deffa30cc6e2", #"hash_5f9831cef8ab9e8d", #"hash_24bfa06ffb71fcec", 2);
	}
}

/*
	Name: on_player_killed
	Namespace: namespace_1b05e45a
	Checksum: 0x7100ADD4
	Offset: 0x3A8
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function on_player_killed()
{
	if(!isdefined(self.laststandparams))
	{
		return;
	}
	attacker = self.laststandparams.attacker;
	weapon = self.laststandparams.sweapon;
	if(!isplayer(attacker) || !isdefined(weapon))
	{
		return;
	}
	if(weapon.name != #"hatchet")
	{
		return;
	}
	if(!attacker util::isenemyteam(self.team))
	{
		return;
	}
	if(!attacker character_unlock::function_f0406288(#"hash_f1156c5f8b9f0e8"))
	{
		return;
	}
	attacker character_unlock::function_c8beca5e(#"hash_f1156c5f8b9f0e8", #"hash_1493c49bbdfb17ad", 1);
}

