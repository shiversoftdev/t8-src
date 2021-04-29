// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_6d7d84509b62f422;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\hud_util_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_2c9e6caa;

/*
	Name: function_89f2df9
	Namespace: namespace_2c9e6caa
	Checksum: 0x9F6C52F4
	Offset: 0xF8
	Size: 0x54
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_431ed482b5f316ae", &__init__, &__main__, #"hash_12378771db09fde7");
}

/*
	Name: __init__
	Namespace: namespace_2c9e6caa
	Checksum: 0x72D1DB19
	Offset: 0x158
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.zm_location = zm_location::register("zm_location");
	callback::on_connect(&on_player_connect);
	callback::on_spawned(&on_player_spawned);
}

/*
	Name: __main__
	Namespace: namespace_2c9e6caa
	Checksum: 0x80F724D1
	Offset: 0x1C8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: on_player_connect
	Namespace: namespace_2c9e6caa
	Checksum: 0x80F724D1
	Offset: 0x1D8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
}

/*
	Name: on_player_spawned
	Namespace: namespace_2c9e6caa
	Checksum: 0x693CC272
	Offset: 0x1E8
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	self endon(#"disconnect");
	if(level.zm_location zm_location::is_open(self))
	{
		level.zm_location zm_location::close(self);
	}
	self.var_b3122c84 = #"";
	util::wait_network_frame();
	if(isdefined(self))
	{
		self function_84c3e8e6();
	}
}

/*
	Name: function_84c3e8e6
	Namespace: namespace_2c9e6caa
	Checksum: 0xE5D89FFC
	Offset: 0x290
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_84c3e8e6()
{
	if(!level.zm_location zm_location::is_open(self))
	{
		level.zm_location zm_location::open(self, 0);
	}
}

/*
	Name: function_29780fb5
	Namespace: namespace_2c9e6caa
	Checksum: 0xC9361A59
	Offset: 0x2E0
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function function_29780fb5(location)
{
	self.var_5417136 = location;
	if(level.zm_location zm_location::is_open(self))
	{
		level.zm_location zm_location::function_e967988b(self, location);
		if(self.var_b3122c84 != location)
		{
			self.var_b3122c84 = location;
			self thread zm_audio::function_a3c4af48(location);
		}
	}
}

