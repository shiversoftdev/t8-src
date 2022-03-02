// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f27a7b2232674db;
#using script_64ab2b950d85b8ad;
#using script_673e73d0695d82b8;
#using script_6b993fdc7adc35ec;
#using script_6de2f7255a97ab00;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_d5f5717f;

/*
	Name: function_89f2df9
	Namespace: namespace_d5f5717f
	Checksum: 0xFB4C20F7
	Offset: 0x108
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_2cc19c7ccaa4e97f", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_d5f5717f
	Checksum: 0xF21F5840
	Offset: 0x150
	Size: 0x242
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_58608935 = (isdefined(getgametypesetting(#"hash_5faa7b70e6eb1e2d")) ? getgametypesetting(#"hash_5faa7b70e6eb1e2d") : 0);
	if(!(isdefined(level.var_58608935) && level.var_58608935))
	{
		return;
	}
	/#
		assert(level.var_58608935 <= 8);
	#/
	clientfield::register("allplayers", "ishighvaluetarget", 16000, 1, "int");
	callback::add_callback(#"hash_405e46788e83af41", &function_77a44aec);
	callback::add_callback(#"hash_7912e21750e4010d", &function_77a44aec);
	callback::add_callback(#"hash_65626f47d6c0717c", &function_9141be4e);
	callback::on_player_killed_with_params(&function_3f8e4156);
	callback::on_disconnect(&on_player_disconnect);
	level.var_45c1873e = [];
	for(i = 0; i < 8; i++)
	{
		level.var_45c1873e[i][#"indicator"] = spectrerisingindicator::register("SpectreRisingIndicator_" + i);
		level.var_45c1873e[i][#"clientnum"] = -1;
	}
}

/*
	Name: function_fbb8f1d1
	Namespace: namespace_d5f5717f
	Checksum: 0xF51B8516
	Offset: 0x3A0
	Size: 0x90
	Parameters: 0
	Flags: Linked, Private
*/
function private function_fbb8f1d1()
{
	if(!isplayer(self))
	{
		return;
	}
	if(isdefined(getgametypesetting(#"hash_2992e3d39d55b312")) && getgametypesetting(#"hash_2992e3d39d55b312"))
	{
		return self clientfield::get("hasspectrebody");
	}
	return 1;
}

/*
	Name: function_77a44aec
	Namespace: namespace_d5f5717f
	Checksum: 0x6E8B6EB6
	Offset: 0x438
	Size: 0x6F8
	Parameters: 0
	Flags: Linked, Private
*/
function private function_77a44aec()
{
	possibletargets = [];
	foreach(player in getplayers())
	{
		if(player clientfield::get("ishighvaluetarget"))
		{
			player clientfield::set("ishighvaluetarget", 0);
			if(isalive(player))
			{
				player playsoundtoplayer(#"hash_321dbeea036e0e68", player);
				player luinotifyevent(#"hash_6b67aa04e378d681", 1, 12);
				namespace_8f74625a::function_1b48df6d(player.origin);
			}
			continue;
		}
		if(!isalive(player) || player inlaststand() || player function_fbb8f1d1())
		{
			continue;
		}
		possibletargets[possibletargets.size] = player;
	}
	targetcount = 0;
	var_1ac2b0cd = [];
	while(possibletargets.size > 0 && targetcount < level.var_58608935)
	{
		topplayers = function_f81eaa29(possibletargets);
		while(topplayers.size > 0 && targetcount < level.var_58608935)
		{
			var_6e9efb43 = level.var_45c1873e[targetcount];
			targetcount++;
			randomindex = randomint(topplayers.size);
			player = topplayers[randomindex];
			player clientfield::set("ishighvaluetarget", 1);
			player playsoundtoplayer(#"hash_6d40de6f3e747fb1", player);
			player luinotifyevent(#"hash_6b67aa04e378d681", 1, 10);
			var_6e9efb43[#"clientnum"] = player getentitynumber();
			foreach(other_player in getplayers())
			{
				if(!var_6e9efb43[#"indicator"] spectrerisingindicator::is_open(other_player))
				{
					var_6e9efb43[#"indicator"] spectrerisingindicator::open(other_player);
				}
				var_d1a98222 = 1;
				if(other_player.team == player.team)
				{
					var_d1a98222 = 0;
				}
				var_6e9efb43[#"indicator"] spectrerisingindicator::function_3b7b386a(other_player, var_6e9efb43[#"clientnum"]);
				var_6e9efb43[#"indicator"] spectrerisingindicator::function_7f5a9fed(other_player, var_d1a98222);
			}
			arrayinsert(var_1ac2b0cd, player, var_1ac2b0cd.size);
			arrayremovevalue(topplayers, player);
			arrayremovevalue(possibletargets, player);
		}
	}
	for(i = targetcount + 1; i < level.var_45c1873e.size; i++)
	{
		var_6e9efb43 = level.var_45c1873e[i];
		var_6e9efb43[#"clientnum"] = -1;
		foreach(player in getplayers())
		{
			if(var_6e9efb43[#"indicator"] spectrerisingindicator::is_open(player))
			{
				var_6e9efb43[#"indicator"] spectrerisingindicator::close(player);
			}
		}
	}
	foreach(player in getplayers())
	{
		if(player function_fbb8f1d1())
		{
			foreach(target in var_1ac2b0cd)
			{
				if(target.team != player.team)
				{
					player luinotifyevent(#"hash_6b67aa04e378d681", 1, 9);
					break;
				}
			}
		}
	}
}

/*
	Name: function_f81eaa29
	Namespace: namespace_d5f5717f
	Checksum: 0x3FD6ED6E
	Offset: 0xB38
	Size: 0xC6
	Parameters: 1
	Flags: Linked, Private
*/
function private function_f81eaa29(players)
{
	mostkills = 0;
	topplayers = [];
	foreach(player in players)
	{
		if(player.kills > mostkills)
		{
			mostkills = player.kills;
			topplayers = [];
		}
		topplayers[topplayers.size] = player;
	}
	return topplayers;
}

/*
	Name: function_9141be4e
	Namespace: namespace_d5f5717f
	Checksum: 0xD2AD37EA
	Offset: 0xC08
	Size: 0x92
	Parameters: 0
	Flags: Linked, Private
*/
function private function_9141be4e()
{
	if(!self clientfield::get("ishighvaluetarget") || !isdefined(self.laststandparams))
	{
		return;
	}
	attacker = self.laststandparams.attacker;
	if(!isplayer(attacker))
	{
		return;
	}
	self.laststandparams.var_c30b803b = attacker function_fbb8f1d1();
}

/*
	Name: function_3f8e4156
	Namespace: namespace_d5f5717f
	Checksum: 0x11C0E43F
	Offset: 0xCA8
	Size: 0x2BC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_3f8e4156(params)
{
	if(!self clientfield::get("ishighvaluetarget"))
	{
		return;
	}
	self clientfield::set("ishighvaluetarget", 0);
	clientnum = self getentitynumber();
	foreach(var_6e9efb43 in level.var_45c1873e)
	{
		if(clientnum == var_6e9efb43[#"clientnum"])
		{
			foreach(player in getplayers())
			{
				var_6e9efb43[#"indicator"] spectrerisingindicator::function_7f5a9fed(player, 0);
			}
			var_6e9efb43[#"clientnum"] = -1;
		}
	}
	attacker = params.eattacker;
	if(isdefined(params.laststandparams))
	{
		if(!(isdefined(params.laststandparams.var_c30b803b) && params.laststandparams.var_c30b803b))
		{
			return;
		}
		attacker = params.laststandparams.attacker;
	}
	if(!isplayer(attacker) || attacker.team == self.team || !attacker function_fbb8f1d1())
	{
		return;
	}
	attacker playsoundtoplayer(#"hash_619bf069e410b863", attacker);
	attacker luinotifyevent(#"hash_6b67aa04e378d681", 1, 11);
	namespace_8f74625a::function_1b48df6d(attacker.origin);
}

/*
	Name: on_player_disconnect
	Namespace: namespace_d5f5717f
	Checksum: 0xE5915992
	Offset: 0xF70
	Size: 0x196
	Parameters: 0
	Flags: Linked, Private
*/
function private on_player_disconnect()
{
	if(!self clientfield::get("ishighvaluetarget"))
	{
		return;
	}
	self clientfield::set("ishighvaluetarget", 0);
	clientnum = self getentitynumber();
	foreach(var_6e9efb43 in level.var_45c1873e)
	{
		if(clientnum == var_6e9efb43[#"clientnum"])
		{
			foreach(player in getplayers())
			{
				var_6e9efb43[#"indicator"] spectrerisingindicator::function_7f5a9fed(player, 0);
			}
			var_6e9efb43[#"clientnum"] = -1;
		}
	}
}

