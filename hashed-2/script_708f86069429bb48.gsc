// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_6ce38ab036223e6e;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_talisman.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_a6ea92eb;

/*
	Name: function_89f2df9
	Namespace: namespace_a6ea92eb
	Checksum: 0x24BE7B42
	Offset: 0xE8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_599f3df5ff5ccbe2", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_a6ea92eb
	Checksum: 0xAE2A2284
	Offset: 0x130
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_talisman::function_88a60d36("talisman_impatient", &function_fd7e329b);
}

/*
	Name: function_fd7e329b
	Namespace: namespace_a6ea92eb
	Checksum: 0x815DCDC6
	Offset: 0x168
	Size: 0x58
	Parameters: 0
	Flags: Linked
*/
function function_fd7e329b()
{
	self endon(#"disconnect");
	self.var_135a4148 = 0;
	while(true)
	{
		self waittill(#"bled_out");
		self thread function_49849a2f();
	}
}

/*
	Name: function_49849a2f
	Namespace: namespace_a6ea92eb
	Checksum: 0x3CC0ADB8
	Offset: 0x1C8
	Size: 0x134
	Parameters: 0
	Flags: Linked
*/
function function_49849a2f()
{
	self endon(#"disconnect", #"end_of_round");
	if(self.var_135a4148 == namespace_a28acff3::get_round_number())
	{
		return;
	}
	if(level.zombie_total <= 3)
	{
		wait(1);
	}
	n_target_kills = level.zombie_player_killed_count + 100;
	while(level.zombie_player_killed_count < n_target_kills && level.zombie_total >= 3)
	{
		waitframe(1);
	}
	self.var_135a4148 = namespace_a28acff3::get_round_number();
	self zm_player::spectator_respawn_player();
	self val::set(#"talisman_impatient", "ignoreme");
	wait(5);
	self val::reset(#"talisman_impatient", "ignoreme");
}

