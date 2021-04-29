// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.gsc;

#namespace sound;

/*
	Name: loop_fx_sound
	Namespace: sound
	Checksum: 0x6717A610
	Offset: 0xA0
	Size: 0x94
	Parameters: 3
	Flags: Linked
*/
function loop_fx_sound(alias, origin, ender)
{
	org = spawn("script_origin", (0, 0, 0));
	if(isdefined(ender))
	{
		thread loop_delete(ender, org);
		self endon(ender);
	}
	org.origin = origin;
	org playloopsound(alias);
}

/*
	Name: loop_delete
	Namespace: sound
	Checksum: 0x82F719F8
	Offset: 0x140
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function loop_delete(ender, ent)
{
	ent endon(#"death");
	self waittill(ender);
	ent delete();
}

/*
	Name: play_in_space
	Namespace: sound
	Checksum: 0x9E5649D0
	Offset: 0x198
	Size: 0xC4
	Parameters: 3
	Flags: Linked
*/
function play_in_space(alias, origin, master)
{
	org = spawn("script_origin", (0, 0, 1));
	if(!isdefined(origin))
	{
		origin = self.origin;
	}
	org.origin = origin;
	org playsoundwithnotify(alias, "sounddone");
	org waittill(#"sounddone");
	if(isdefined(org))
	{
		org delete();
	}
}

/*
	Name: loop_on_tag
	Namespace: sound
	Checksum: 0x3014F258
	Offset: 0x268
	Size: 0x154
	Parameters: 3
	Flags: Linked
*/
function loop_on_tag(alias, tag, bstopsoundondeath)
{
	org = spawn("script_origin", (0, 0, 0));
	org endon(#"death");
	if(!isdefined(bstopsoundondeath))
	{
		bstopsoundondeath = 1;
	}
	if(bstopsoundondeath)
	{
		thread util::delete_on_death(org);
	}
	if(isdefined(tag))
	{
		org linkto(self, tag, (0, 0, 0), (0, 0, 0));
	}
	else
	{
		org.origin = self.origin;
		org.angles = self.angles;
		org linkto(self);
	}
	org playloopsound(alias);
	self waittill("stop sound" + alias);
	org stoploopsound(alias);
	org delete();
}

/*
	Name: play_on_tag
	Namespace: sound
	Checksum: 0xE7F6ADDB
	Offset: 0x3C8
	Size: 0x19C
	Parameters: 3
	Flags: Linked
*/
function play_on_tag(alias, tag, ends_on_death)
{
	org = spawn("script_origin", (0, 0, 0));
	org endon(#"death");
	thread delete_on_death_wait(org, "sounddone");
	if(isdefined(tag))
	{
		org.origin = self gettagorigin(tag);
		org linkto(self, tag, (0, 0, 0), (0, 0, 0));
	}
	else
	{
		org.origin = self.origin;
		org.angles = self.angles;
		org linkto(self);
	}
	org playsoundwithnotify(alias, "sounddone");
	if(isdefined(ends_on_death))
	{
		/#
			assert(ends_on_death, "");
		#/
		wait_for_sounddone_or_death(org);
		waitframe(1);
	}
	else
	{
		org waittill(#"sounddone");
	}
	org delete();
}

/*
	Name: play_on_entity
	Namespace: sound
	Checksum: 0x731142E
	Offset: 0x570
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function play_on_entity(alias)
{
	play_on_tag(alias);
}

/*
	Name: wait_for_sounddone_or_death
	Namespace: sound
	Checksum: 0xA5B9F5D
	Offset: 0x5A0
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function wait_for_sounddone_or_death(org)
{
	self endon(#"death");
	org waittill(#"sounddone");
}

/*
	Name: stop_loop_on_entity
	Namespace: sound
	Checksum: 0x6EE192C8
	Offset: 0x5E0
	Size: 0x20
	Parameters: 1
	Flags: None
*/
function stop_loop_on_entity(alias)
{
	self notify("stop sound" + alias);
}

/*
	Name: loop_on_entity
	Namespace: sound
	Checksum: 0x7E39A716
	Offset: 0x608
	Size: 0x14C
	Parameters: 2
	Flags: None
*/
function loop_on_entity(alias, offset)
{
	org = spawn("script_origin", (0, 0, 0));
	org endon(#"death");
	thread util::delete_on_death(org);
	if(isdefined(offset))
	{
		org.origin = self.origin + offset;
		org.angles = self.angles;
		org linkto(self);
	}
	else
	{
		org.origin = self.origin;
		org.angles = self.angles;
		org linkto(self);
	}
	org playloopsound(alias);
	self waittill("stop sound" + alias);
	org stoploopsound(0.1);
	org delete();
}

/*
	Name: loop_in_space
	Namespace: sound
	Checksum: 0x3AB53778
	Offset: 0x760
	Size: 0xC4
	Parameters: 3
	Flags: None
*/
function loop_in_space(alias, origin, ender)
{
	org = spawn("script_origin", (0, 0, 1));
	if(!isdefined(origin))
	{
		origin = self.origin;
	}
	org.origin = origin;
	org playloopsound(alias);
	level waittill(ender);
	org stoploopsound();
	wait(0.1);
	org delete();
}

/*
	Name: delete_on_death_wait
	Namespace: sound
	Checksum: 0x16912007
	Offset: 0x830
	Size: 0x5C
	Parameters: 2
	Flags: Linked
*/
function delete_on_death_wait(ent, sounddone)
{
	ent endon(#"death");
	self waittill(#"death");
	if(isdefined(ent))
	{
		ent delete();
	}
}

/*
	Name: play_on_players
	Namespace: sound
	Checksum: 0xEF994A01
	Offset: 0x898
	Size: 0x17E
	Parameters: 2
	Flags: None
*/
function play_on_players(sound, team)
{
	/#
		assert(isdefined(level.players));
	#/
	if(level.splitscreen)
	{
		if(isdefined(level.players[0]))
		{
			level.players[0] playlocalsound(sound);
		}
	}
	else if(isdefined(team))
	{
		for(i = 0; i < level.players.size; i++)
		{
			player = level.players[i];
			if(isdefined(player.pers[#"team"]) && player.pers[#"team"] == team)
			{
				player playlocalsound(sound);
			}
		}
	}
	else
	{
		for(i = 0; i < level.players.size; i++)
		{
			level.players[i] playlocalsound(sound);
		}
	}
}

