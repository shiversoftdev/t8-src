// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_170a9c130859c688;
#using script_3affe3aaa3f22cb0;
#using script_8210b63db522f15;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_ecd99d8c;

/*
	Name: function_89f2df9
	Namespace: namespace_ecd99d8c
	Checksum: 0x391264FE
	Offset: 0xC0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_1783c105c1611e5b", &__init__, undefined, #"hash_56d6c8ec5d78c182");
}

/*
	Name: __init__
	Namespace: namespace_ecd99d8c
	Checksum: 0x7BF7CD36
	Offset: 0x110
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_90ee7a97(#"hash_1b0f5f13a087c3d3", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: namespace_ecd99d8c
	Checksum: 0xCC8A7D04
	Offset: 0x150
	Size: 0x2A4
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		callback::on_player_killed(&on_player_killed);
		callback::add_callback(#"hash_3b891b6daa75c782", &function_1c4b5097);
		namespace_b0722f43::function_2749fcc3(#"hash_6a0d13acf3e5687d", #"hash_5f9831cef8ab9e8d", #"hash_24c9956ffb7a3ec0", 2);
		namespace_b0722f43::function_2749fcc3(#"hash_33f7121f70c3065f", #"hash_5f9831cef8ab9e8d", #"hash_24c9956ffb7a3ec0", 2);
		namespace_b0722f43::function_2749fcc3(#"hash_2b546c0315159617", #"hash_5f9831cef8ab9e8d", #"hash_24c9956ffb7a3ec0", 2);
		namespace_b0722f43::function_2749fcc3(#"hash_183c9fe8af52fac7", #"hash_5f9831cef8ab9e8d", #"hash_24c9956ffb7a3ec0", 2);
		namespace_b0722f43::function_2749fcc3(#"hash_49e8a607ea22e650", #"hash_5f9831cef8ab9e8d", #"hash_24c9956ffb7a3ec0", 2);
		namespace_b0722f43::function_2749fcc3(#"hash_66f790c2630deace", #"hash_5f9831cef8ab9e8d", #"hash_24c9956ffb7a3ec0", 2);
		namespace_b0722f43::function_2749fcc3(#"hash_ca8b234ad1fea38", #"hash_5f9831cef8ab9e8d", #"hash_24c9956ffb7a3ec0", 2);
		namespace_b0722f43::function_2749fcc3(#"hash_4ee6deffa30cc6e2", #"hash_5f9831cef8ab9e8d", #"hash_24c9956ffb7a3ec0", 2);
	}
}

/*
	Name: function_1c4b5097
	Namespace: namespace_ecd99d8c
	Checksum: 0xE370B5BE
	Offset: 0x400
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function function_1c4b5097(item)
{
	var_a6762160 = item.var_a6762160;
	if(var_a6762160.name === #"hash_4da28db320e11353")
	{
		self thread function_895b40e4();
	}
}

/*
	Name: on_player_killed
	Namespace: namespace_ecd99d8c
	Checksum: 0x2903079
	Offset: 0x460
	Size: 0x104
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
	mod = self.laststandparams.smeansofdeath;
	if(!isplayer(attacker))
	{
		return;
	}
	if(mod != "MOD_GRENADE" && mod != "MOD_GRENADE_SPLASH")
	{
		return;
	}
	if(!attacker util::isenemyteam(self.team))
	{
		return;
	}
	if(!attacker character_unlock::function_f0406288(#"hash_1b0f5f13a087c3d3"))
	{
		return;
	}
	attacker character_unlock::function_c8beca5e(#"hash_1b0f5f13a087c3d3", #"hash_557b228047615fb0", 1);
}

/*
	Name: function_895b40e4
	Namespace: namespace_ecd99d8c
	Checksum: 0xB3F17BA1
	Offset: 0x570
	Size: 0x24
	Parameters: 0
	Flags: Linked, Private
*/
private function function_895b40e4()
{
	self playsoundtoplayer(#"hash_40bb133320e319b6", self);
}

