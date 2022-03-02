// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_3f9e0dc8454d98e1;
#using script_47fb62300ac0bd60;
#using script_6e3c826b1814cab6;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\match_record.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_stats.gsc;

#namespace zm_talisman;

/*
	Name: init
	Namespace: zm_talisman
	Checksum: 0x2DED06B8
	Offset: 0x100
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function init()
{
	callback::on_connect(&on_player_connect);
	callback::on_disconnect(&on_player_disconnect);
}

/*
	Name: on_player_connect
	Namespace: zm_talisman
	Checksum: 0xF3ECAA86
	Offset: 0x150
	Size: 0x2EC
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	var_e18c5d7 = self zm_loadout::function_2dfb9150("talisman1");
	s_talisman = getunlockableiteminfofromindex(var_e18c5d7, 4);
	var_ea4558f5 = function_b143666d(var_e18c5d7, 4);
	n_remaining = 0;
	if(isdefined(s_talisman))
	{
		if(!isdefined(var_ea4558f5.var_14c94e49))
		{
			var_ea4558f5.var_14c94e49 = 0;
		}
		s_talisman.rarity = var_ea4558f5.var_14c94e49;
		n_remaining = self function_bd6a3188(s_talisman.var_3cf2d21);
	}
	var_88049519 = 0;
	if(isdefined(s_talisman) && namespace_59ff1d6c::function_ff4557dc(s_talisman) && n_remaining > 0)
	{
		var_240061ef = s_talisman.var_3cf2d21;
		if(isdefined(level.var_e1074d3e[var_240061ef]))
		{
			if(isdefined(level.var_e1074d3e[var_240061ef].activate_talisman) && (!(isdefined(level.var_e1074d3e[var_240061ef].is_activated[self.clientid]) && level.var_e1074d3e[var_240061ef].is_activated[self.clientid])))
			{
				self thread function_954b9083(var_240061ef);
				self thread [[level.var_e1074d3e[var_240061ef].activate_talisman]]();
				level.var_e1074d3e[var_240061ef].is_activated[self.clientid] = 1;
				self recordmapevent(30, gettime(), self.origin, level.round_number, s_talisman.var_2f8e25b8, (isdefined(self.health) ? self.health : 0));
				var_88049519 = 1;
			}
		}
	}
	else if(isdefined(s_talisman))
	{
		if(n_remaining > 0)
		{
			self thread namespace_59ff1d6c::function_2717f4b3();
		}
		else
		{
			self match_record::set_player_stat("boas_no_talisman", 1);
		}
	}
	self clientfield::set_player_uimodel("ZMInvTalisman.show", (var_88049519 ? 1 : 0));
}

/*
	Name: on_player_disconnect
	Namespace: zm_talisman
	Checksum: 0xFEB53DD2
	Offset: 0x448
	Size: 0x142
	Parameters: 0
	Flags: Linked
*/
function on_player_disconnect()
{
	if(!isdefined(self.clientid))
	{
		return;
	}
	var_e18c5d7 = self zm_loadout::function_2dfb9150("talisman1");
	s_talisman = getunlockableiteminfofromindex(var_e18c5d7, 4);
	var_ea4558f5 = function_b143666d(var_e18c5d7, 4);
	if(isdefined(s_talisman))
	{
		var_240061ef = s_talisman.var_3cf2d21;
		if(isdefined(level.var_e1074d3e[var_240061ef]))
		{
			if(isdefined(level.var_e1074d3e[var_240061ef].activate_talisman) && (isdefined(level.var_e1074d3e[var_240061ef].is_activated[self.clientid]) && level.var_e1074d3e[var_240061ef].is_activated[self.clientid]))
			{
				level.var_e1074d3e[var_240061ef].is_activated[self.clientid] = 0;
			}
		}
	}
}

/*
	Name: function_88a60d36
	Namespace: zm_talisman
	Checksum: 0x203E3EE
	Offset: 0x598
	Size: 0xF2
	Parameters: 2
	Flags: Linked
*/
function function_88a60d36(var_240061ef, activate_talisman)
{
	/#
		assert(isdefined(var_240061ef), "");
	#/
	/#
		assert(isdefined(activate_talisman), "");
	#/
	if(!isdefined(level.var_e1074d3e))
	{
		level.var_e1074d3e = [];
	}
	if(!isdefined(level.var_e1074d3e[var_240061ef]))
	{
		level.var_e1074d3e[var_240061ef] = spawnstruct();
		level.var_e1074d3e[var_240061ef].activate_talisman = activate_talisman;
		level.var_e1074d3e[var_240061ef].is_activated = array();
	}
}

/*
	Name: function_954b9083
	Namespace: zm_talisman
	Checksum: 0x13F1EC65
	Offset: 0x698
	Size: 0xFC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_954b9083(var_240061ef)
{
	level endon(#"game_ended");
	self endon(#"disconnect");
	level waittill(#"start_zombie_round_logic");
	wait(getdvarint(#"hash_4e0eefe07702cb87", 60));
	self stats::inc_stat(#"hash_2718ba6536e331ce", var_240061ef, #"used", #"statvalue", 1);
	self zm_stats::increment_challenge_stat(#"hash_6a8397235f934872");
	self reportlootconsume(var_240061ef, 1);
}

