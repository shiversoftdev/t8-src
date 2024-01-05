// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\wz_common\character_unlock.gsc;
#using scripts\mp_common\item_world_fixup.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace character_unlock_stanton;

/*
	Name: __init__system__
	Namespace: character_unlock_stanton
	Checksum: 0xD5445B69
	Offset: 0x98
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_stanton", &__init__, undefined, #"character_unlock_stanton_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_stanton
	Checksum: 0xBD366667
	Offset: 0xE8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"stanton_unlock", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_stanton
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
		item_world_fixup::function_2749fcc3(#"hash_6a0d13acf3e5687d", #"hash_5f9831cef8ab9e8d", #"hash_24c9966ffb7a4073", 2);
		item_world_fixup::function_2749fcc3(#"hash_33f7121f70c3065f", #"hash_5f9831cef8ab9e8d", #"hash_24c9966ffb7a4073", 2);
		item_world_fixup::function_2749fcc3(#"hash_2b546c0315159617", #"hash_5f9831cef8ab9e8d", #"hash_24c9966ffb7a4073", 2);
		item_world_fixup::function_2749fcc3(#"hash_183c9fe8af52fac7", #"hash_5f9831cef8ab9e8d", #"hash_24c9966ffb7a4073", 2);
		item_world_fixup::function_2749fcc3(#"hash_49e8a607ea22e650", #"hash_5f9831cef8ab9e8d", #"hash_24c9966ffb7a4073", 2);
		item_world_fixup::function_2749fcc3(#"zombie_stash_graveyard_quest", #"hash_5f9831cef8ab9e8d", #"hash_24c9966ffb7a4073", 2);
		item_world_fixup::function_2749fcc3(#"hash_ca8b234ad1fea38", #"hash_5f9831cef8ab9e8d", #"hash_24c9966ffb7a4073", 2);
		item_world_fixup::function_2749fcc3(#"hash_4ee6deffa30cc6e2", #"hash_5f9831cef8ab9e8d", #"hash_24c9966ffb7a4073", 2);
	}
}

/*
	Name: function_1c4b5097
	Namespace: character_unlock_stanton
	Checksum: 0x28AF1E35
	Offset: 0x3D8
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function function_1c4b5097(item)
{
	var_a6762160 = item.var_a6762160;
	if(var_a6762160.name === #"cu14_item")
	{
		self function_895b40e4();
	}
}

/*
	Name: on_player_killed
	Namespace: character_unlock_stanton
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
	if(weapon.name != #"eq_acid_bomb" && weapon.name != #"wraith_fire_fire" && weapon.name != #"eq_wraith_fire")
	{
		return;
	}
	if(!attacker util::isenemyteam(self.team))
	{
		return;
	}
	if(!attacker character_unlock::function_f0406288(#"stanton_unlock"))
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
		attacker character_unlock::function_c8beca5e(#"stanton_unlock", #"hash_5495584ec5e9f348", 1);
	}
}

/*
	Name: function_895b40e4
	Namespace: character_unlock_stanton
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

