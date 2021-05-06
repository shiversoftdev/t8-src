// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace perplayer;

/*
	Name: init
	Namespace: perplayer
	Checksum: 0xBFEAA76D
	Offset: 0x68
	Size: 0xA6
	Parameters: 3
	Flags: None
*/
function init(id, playerbegincallback, playerendcallback)
{
	handler = spawnstruct();
	handler.id = id;
	handler.playerbegincallback = playerbegincallback;
	handler.playerendcallback = playerendcallback;
	handler.enabled = 0;
	handler.players = [];
	thread onplayerconnect(handler);
	level.handlerglobalflagval = 0;
	return handler;
}

/*
	Name: enable
	Namespace: perplayer
	Checksum: 0xB7FC6C56
	Offset: 0x118
	Size: 0x12E
	Parameters: 1
	Flags: None
*/
function enable(handler)
{
	if(handler.enabled)
	{
		return;
	}
	handler.enabled = 1;
	level.handlerglobalflagval++;
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		players[i].handlerflagval = level.handlerglobalflagval;
	}
	players = handler.players;
	for(i = 0; i < players.size; i++)
	{
		if(players[i].handlerflagval != level.handlerglobalflagval)
		{
			continue;
		}
		if(players[i].handlers[handler.id].ready)
		{
			players[i] handleplayer(handler);
		}
	}
}

/*
	Name: disable
	Namespace: perplayer
	Checksum: 0xE7A88493
	Offset: 0x250
	Size: 0x12E
	Parameters: 1
	Flags: None
*/
function disable(handler)
{
	if(!handler.enabled)
	{
		return;
	}
	handler.enabled = 0;
	level.handlerglobalflagval++;
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		players[i].handlerflagval = level.handlerglobalflagval;
	}
	players = handler.players;
	for(i = 0; i < players.size; i++)
	{
		if(players[i].handlerflagval != level.handlerglobalflagval)
		{
			continue;
		}
		if(players[i].handlers[handler.id].ready)
		{
			players[i] unhandleplayer(handler, 0, 0);
		}
	}
}

/*
	Name: onplayerconnect
	Namespace: perplayer
	Checksum: 0xDC130D0E
	Offset: 0x388
	Size: 0x190
	Parameters: 1
	Flags: None
*/
function onplayerconnect(handler)
{
	for(;;)
	{
		waitresult = undefined;
		waitresult = level waittill(#"connecting");
		player = waitresult.player;
		if(!isdefined(player.handlers))
		{
			player.handlers = [];
		}
		player.handlers[handler.id] = spawnstruct();
		player.handlers[handler.id].ready = 0;
		player.handlers[handler.id].handled = 0;
		player.handlerflagval = -1;
		handler.players[handler.players.size] = player;
		player thread onplayerdisconnect(handler);
		player thread onplayerspawned(handler);
		player thread onjoinedteam(handler);
		player thread onjoinedspectators(handler);
		player thread onplayerkilled(handler);
	}
}

/*
	Name: onplayerdisconnect
	Namespace: perplayer
	Checksum: 0xF11EDE5F
	Offset: 0x520
	Size: 0xC4
	Parameters: 1
	Flags: None
*/
function onplayerdisconnect(handler)
{
	self waittill(#"disconnect");
	newplayers = [];
	for(i = 0; i < handler.players.size; i++)
	{
		if(handler.players[i] != self)
		{
			newplayers[newplayers.size] = handler.players[i];
		}
	}
	handler.players = newplayers;
	self thread unhandleplayer(handler, 1, 1);
}

/*
	Name: onjoinedteam
	Namespace: perplayer
	Checksum: 0x47FD0F93
	Offset: 0x5F0
	Size: 0x58
	Parameters: 1
	Flags: None
*/
function onjoinedteam(handler)
{
	self endon(#"disconnect");
	for(;;)
	{
		self waittill(#"joined_team");
		self thread unhandleplayer(handler, 1, 0);
	}
}

/*
	Name: onjoinedspectators
	Namespace: perplayer
	Checksum: 0xF7E0EEC6
	Offset: 0x650
	Size: 0x58
	Parameters: 1
	Flags: None
*/
function onjoinedspectators(handler)
{
	self endon(#"disconnect");
	for(;;)
	{
		self waittill(#"joined_spectators");
		self thread unhandleplayer(handler, 1, 0);
	}
}

/*
	Name: onplayerspawned
	Namespace: perplayer
	Checksum: 0xAE2E8752
	Offset: 0x6B0
	Size: 0x50
	Parameters: 1
	Flags: None
*/
function onplayerspawned(handler)
{
	self endon(#"disconnect");
	for(;;)
	{
		self waittill(#"spawned_player");
		self thread handleplayer(handler);
	}
}

/*
	Name: onplayerkilled
	Namespace: perplayer
	Checksum: 0xFCD5E688
	Offset: 0x708
	Size: 0x58
	Parameters: 1
	Flags: None
*/
function onplayerkilled(handler)
{
	self endon(#"disconnect");
	for(;;)
	{
		self waittill(#"killed_player");
		self thread unhandleplayer(handler, 1, 0);
	}
}

/*
	Name: handleplayer
	Namespace: perplayer
	Checksum: 0x8B4FC72D
	Offset: 0x768
	Size: 0x98
	Parameters: 1
	Flags: None
*/
function handleplayer(handler)
{
	self.handlers[handler.id].ready = 1;
	if(!handler.enabled)
	{
		return;
	}
	if(self.handlers[handler.id].handled)
	{
		return;
	}
	self.handlers[handler.id].handled = 1;
	self thread [[handler.playerbegincallback]]();
}

/*
	Name: unhandleplayer
	Namespace: perplayer
	Checksum: 0x68A75847
	Offset: 0x808
	Size: 0xB4
	Parameters: 3
	Flags: None
*/
function unhandleplayer(handler, unsetready, disconnected)
{
	if(!disconnected && unsetready)
	{
		self.handlers[handler.id].ready = 0;
	}
	if(!self.handlers[handler.id].handled)
	{
		return;
	}
	if(!disconnected)
	{
		self.handlers[handler.id].handled = 0;
	}
	self thread [[handler.playerendcallback]](disconnected);
}

