// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace sound;

/*
	Name: loop_fx_sound
	Namespace: sound
	Checksum: 0xD25D581C
	Offset: 0x78
	Size: 0x8C
	Parameters: 4
	Flags: Linked
*/
function loop_fx_sound(clientnum, alias, origin, ender)
{
	sound_entity = spawn(clientnum, origin, "script_origin");
	if(isdefined(ender))
	{
		thread loop_delete(ender, sound_entity);
		self endon(ender);
	}
	sound_entity playloopsound(alias);
}

/*
	Name: play_in_space
	Namespace: sound
	Checksum: 0xED035404
	Offset: 0x110
	Size: 0x3C
	Parameters: 3
	Flags: Linked
*/
function play_in_space(localclientnum, alias, origin)
{
	playsound(localclientnum, alias, origin);
}

/*
	Name: loop_delete
	Namespace: sound
	Checksum: 0xAD47D65D
	Offset: 0x158
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function loop_delete(ender, sound_entity)
{
	self waittill(ender);
	sound_entity delete();
}

/*
	Name: play_on_client
	Namespace: sound
	Checksum: 0xF4E54231
	Offset: 0x198
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function play_on_client(sound_alias)
{
	players = level.localplayers;
	playsound(0, sound_alias, players[0].origin);
}

/*
	Name: loop_on_client
	Namespace: sound
	Checksum: 0x52AA2A42
	Offset: 0x1F0
	Size: 0x82
	Parameters: 4
	Flags: None
*/
function loop_on_client(sound_alias, min_delay, max_delay, end_on)
{
	players = level.localplayers;
	if(isdefined(end_on))
	{
		level endon(end_on);
	}
	for(;;)
	{
		play_on_client(sound_alias);
		wait(min_delay + randomfloat(max_delay));
	}
}

