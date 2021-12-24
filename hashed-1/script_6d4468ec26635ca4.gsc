// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_65d4fc42e5e94766;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\death_circle.gsc;
#using scripts\core_common\infection.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace wave_spawn;

/*
	Name: function_89f2df9
	Namespace: wave_spawn
	Checksum: 0xF93E3A8D
	Offset: 0x108
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"wave_spawn", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: wave_spawn
	Checksum: 0x623F2EC3
	Offset: 0x150
	Size: 0x194
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.wave_spawn = (isdefined(getgametypesetting(#"hash_6f135d596eeee7a")) ? getgametypesetting(#"hash_6f135d596eeee7a") : 0);
	if(level.wave_spawn)
	{
		level.takelivesondeath = 1;
		level.var_a5f54d9f = 1;
		level callback::add_callback(#"hash_e702d557e24bb6", &function_a7ed6d54);
		level callback::add_callback(#"hash_3be1213f454fa90e", &function_301b775b);
		level callback::add_callback(#"hash_7fc21de2eaebdb3b", &function_832ecb3d);
		level callback::add_callback(#"hash_405e46788e83af41", &function_1540761c);
		level callback::add_callback(#"hash_7912e21750e4010d", &function_a27362d0);
		level callback::on_player_killed(&function_14a68e0b);
	}
}

/*
	Name: function_301b775b
	Namespace: wave_spawn
	Checksum: 0xF3BBB75E
	Offset: 0x2F0
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_301b775b()
{
	if(clientfield::function_6b3b55da("hudItems.warzone.waveRespawnTimer"))
	{
		time = int(gettime() + (int(level.waverespawndelay * 1000)));
		level clientfield::set_world_uimodel("hudItems.warzone.waveRespawnTimer", time);
	}
}

/*
	Name: function_a27362d0
	Namespace: wave_spawn
	Checksum: 0x7FCD50D2
	Offset: 0x380
	Size: 0xF0
	Parameters: 1
	Flags: Linked, Private
*/
private function function_a27362d0(params)
{
	if(level.var_52b56362 >= (level.var_fb91af8.size - 2))
	{
		foreach(player in getplayers())
		{
			if(isdefined(player) && !infection::function_74650d7())
			{
				player clientfield::set_player_uimodel("hudItems.playerCanRedeploy", 0);
			}
			player thread function_ca1398a7();
		}
	}
}

/*
	Name: function_ca1398a7
	Namespace: wave_spawn
	Checksum: 0xB8A64861
	Offset: 0x478
	Size: 0x110
	Parameters: 0
	Flags: Linked
*/
function function_ca1398a7()
{
	if(!isplayer(self))
	{
		return;
	}
	self endon(#"disconnect");
	if(!isdefined(self.pers) || !isdefined(self.pers[#"lives"]))
	{
		return;
	}
	weapon = getweapon(#"bare_hands");
	count = 0;
	lives = self.pers[#"lives"] - 1;
	while(count < lives && isdefined(self))
	{
		count++;
		scoreevents::processscoreevent(#"hash_7e277ffa73b4760b", self, undefined, weapon);
	}
}

/*
	Name: function_1540761c
	Namespace: wave_spawn
	Checksum: 0x2A9C43DF
	Offset: 0x590
	Size: 0x9E
	Parameters: 1
	Flags: Linked
*/
function function_1540761c(params)
{
	if(!level.var_d8958e58 || level.var_fb91af8.size <= 0)
	{
		return;
	}
	if(infection::function_74650d7())
	{
		return;
	}
	time = death_circle::function_49443399();
	level.var_75db41a7 = gettime() + (int((time - level.waverespawndelay) * 1000));
}

/*
	Name: function_832ecb3d
	Namespace: wave_spawn
	Checksum: 0x2165AE5
	Offset: 0x638
	Size: 0x90
	Parameters: 1
	Flags: Linked
*/
function function_832ecb3d(params)
{
	foreach(player in getplayers())
	{
		player clientfield::set_player_uimodel("hudItems.playerCanRedeploy", 0);
	}
}

/*
	Name: function_a7ed6d54
	Namespace: wave_spawn
	Checksum: 0x283FA084
	Offset: 0x6D0
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function function_a7ed6d54(params)
{
	player = params.player;
	if(isdefined(player) && isdefined(player.pers) && isdefined(player.pers[#"lives"]))
	{
		player spawn::function_1390f875(player.pers[#"lives"]);
	}
}

/*
	Name: function_14a68e0b
	Namespace: wave_spawn
	Checksum: 0x5D01CE21
	Offset: 0x770
	Size: 0x124
	Parameters: 0
	Flags: Linked, Private
*/
private function function_14a68e0b()
{
	if(isdefined(level.var_1766510) && level.var_1766510)
	{
		return;
	}
	level.var_1766510 = 1;
	wavedelay = level.waverespawndelay;
	if(wavedelay)
	{
		foreach(team, _ in level.teams)
		{
			level.wavedelay[team] = wavedelay;
			level.lastwave[team] = 0;
		}
		level thread [[level.wavespawntimer]]();
		level clientfield::set_world_uimodel("hudItems.warzone.collapseCount", level.var_fb91af8.size - 1);
	}
}

