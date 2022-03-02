// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_170a9c130859c688;
#using script_3affe3aaa3f22cb0;
#using script_8210b63db522f15;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_80e2cbde;

/*
	Name: function_89f2df9
	Namespace: namespace_80e2cbde
	Checksum: 0xD5445B69
	Offset: 0x98
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_381cd19e62520883", &__init__, undefined, #"hash_bff403c2cb59a3a");
}

/*
	Name: __init__
	Namespace: namespace_80e2cbde
	Checksum: 0xBD366667
	Offset: 0xE8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_90ee7a97(#"hash_de683235345aa4b", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: namespace_80e2cbde
	Checksum: 0x7E26665
	Offset: 0x128
	Size: 0x2A4
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		callback::on_player_killed(&on_player_killed);
		callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
		namespace_b0722f43::function_2749fcc3(#"hash_6a0d13acf3e5687d", #"hash_5f9831cef8ab9e8d", #"hash_24c9966ffb7a4073", 2);
		namespace_b0722f43::function_2749fcc3(#"hash_33f7121f70c3065f", #"hash_5f9831cef8ab9e8d", #"hash_24c9966ffb7a4073", 2);
		namespace_b0722f43::function_2749fcc3(#"hash_2b546c0315159617", #"hash_5f9831cef8ab9e8d", #"hash_24c9966ffb7a4073", 2);
		namespace_b0722f43::function_2749fcc3(#"hash_183c9fe8af52fac7", #"hash_5f9831cef8ab9e8d", #"hash_24c9966ffb7a4073", 2);
		namespace_b0722f43::function_2749fcc3(#"hash_49e8a607ea22e650", #"hash_5f9831cef8ab9e8d", #"hash_24c9966ffb7a4073", 2);
		namespace_b0722f43::function_2749fcc3(#"hash_66f790c2630deace", #"hash_5f9831cef8ab9e8d", #"hash_24c9966ffb7a4073", 2);
		namespace_b0722f43::function_2749fcc3(#"hash_ca8b234ad1fea38", #"hash_5f9831cef8ab9e8d", #"hash_24c9966ffb7a4073", 2);
		namespace_b0722f43::function_2749fcc3(#"hash_4ee6deffa30cc6e2", #"hash_5f9831cef8ab9e8d", #"hash_24c9966ffb7a4073", 2);
	}
}

/*
	Name: function_1c4b5097
	Namespace: namespace_80e2cbde
	Checksum: 0x28AF1E35
	Offset: 0x3D8
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function function_1c4b5097(item)
{
	var_a6762160 = item.var_a6762160;
	if(var_a6762160.name === #"hash_3a19a30df0f60aa6")
	{
		self function_895b40e4();
	}
}

/*
	Name: on_player_killed
	Namespace: namespace_80e2cbde
	Checksum: 0x4FA67B06
	Offset: 0x438
	Size: 0x194
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
	if(weapon.name != #"eq_acid_bomb" && weapon.name != #"hash_55a4aa4a1077e2cc" && weapon.name != #"hash_c78156ba6aeda14")
	{
		return;
	}
	if(!attacker util::isenemyteam(self.team))
	{
		return;
	}
	if(!attacker character_unlock::function_f0406288(#"hash_de683235345aa4b"))
	{
		return;
	}
	if(!isdefined(attacker.var_bd8f4916))
	{
		attacker.var_bd8f4916 = 0;
	}
	attacker.var_bd8f4916++;
	if(attacker.var_bd8f4916 == 2)
	{
		attacker character_unlock::function_c8beca5e(#"hash_de683235345aa4b", #"hash_5495584ec5e9f348", 1);
	}
}

/*
	Name: function_895b40e4
	Namespace: namespace_80e2cbde
	Checksum: 0x7B905065
	Offset: 0x5D8
	Size: 0x24
	Parameters: 0
	Flags: Linked, Private
*/
function private function_895b40e4()
{
	self playsoundtoplayer(#"hash_70c9b45d9474b631", self);
}

