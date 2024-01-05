// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\audio_shared.csc;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\struct.csc;

#namespace zm_audio;

/*
	Name: __init__system__
	Namespace: zm_audio
	Checksum: 0x18EC45E
	Offset: 0x270
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_audio", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_audio
	Checksum: 0x402B3676
	Offset: 0x2B8
	Size: 0x1EC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("allplayers", "charindex", 1, 4, "int", &charindex_cb, 0, 1);
	clientfield::register("toplayer", "isspeaking", 1, 1, "int", &isspeaking_cb, 0, 1);
	if(!isdefined(level.exert_sounds))
	{
		level.exert_sounds = [];
	}
	level.exert_sounds[0][#"playerbreathinsound"] = "vox_exert_generic_inhale";
	level.exert_sounds[0][#"playerbreathoutsound"] = "vox_exert_generic_exhale";
	level.exert_sounds[0][#"playerbreathgaspsound"] = "vox_exert_generic_exhale";
	level.exert_sounds[0][#"falldamage"] = "vox_exert_generic_pain";
	level.exert_sounds[0][#"mantlesoundplayer"] = "vox_exert_generic_mantle";
	level.exert_sounds[0][#"meleeswipesoundplayer"] = "vox_exert_generic_knifeswipe";
	level.exert_sounds[0][#"dtplandsoundplayer"] = "vox_exert_generic_pain";
	callback::on_spawned(&on_player_spawned);
}

/*
	Name: on_player_spawned
	Namespace: zm_audio
	Checksum: 0x2F228697
	Offset: 0x4B0
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function on_player_spawned(localclientnum)
{
}

/*
	Name: delay_set_exert_id
	Namespace: zm_audio
	Checksum: 0xE99750D4
	Offset: 0x4C8
	Size: 0x46
	Parameters: 1
	Flags: Linked
*/
function delay_set_exert_id(newval)
{
	self endon(#"death");
	self endon(#"sndendexertoverride");
	wait(0.5);
	self.player_exert_id = newval;
}

/*
	Name: charindex_cb
	Namespace: zm_audio
	Checksum: 0xEBBAA601
	Offset: 0x518
	Size: 0xA4
	Parameters: 7
	Flags: Linked
*/
function charindex_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!bnewent)
	{
		self.player_exert_id = newval;
		self._first_frame_exert_id_recieved = 1;
		self notify(#"sndendexertoverride");
	}
	else if(!isdefined(self._first_frame_exert_id_recieved))
	{
		self._first_frame_exert_id_recieved = 1;
		self thread delay_set_exert_id(newval);
	}
}

/*
	Name: isspeaking_cb
	Namespace: zm_audio
	Checksum: 0x180474E9
	Offset: 0x5C8
	Size: 0x62
	Parameters: 7
	Flags: Linked
*/
function isspeaking_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!bnewent)
	{
		self.isspeaking = newval;
	}
	else
	{
		self.isspeaking = 0;
	}
}

/*
	Name: zmbmuslooper
	Namespace: zm_audio
	Checksum: 0x91C0C4BC
	Offset: 0x638
	Size: 0x9C
	Parameters: 0
	Flags: None
*/
function zmbmuslooper()
{
	ent = spawn(0, (0, 0, 0), "script_origin");
	playsound(0, #"mus_zmb_gamemode_start", (0, 0, 0));
	wait(10);
	ent playloopsound(#"mus_zmb_gamemode_loop", 0.05);
	ent thread waitfor_music_stop();
}

/*
	Name: waitfor_music_stop
	Namespace: zm_audio
	Checksum: 0x218E8FE5
	Offset: 0x6E0
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function waitfor_music_stop()
{
	level waittill(#"stpm");
	self stopallloopsounds(0.1);
	playsound(0, #"mus_zmb_gamemode_end", (0, 0, 0));
	wait(1);
	self delete();
}

/*
	Name: playerfalldamagesound
	Namespace: zm_audio
	Checksum: 0x32F8F65E
	Offset: 0x768
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function playerfalldamagesound(client_num, firstperson)
{
	self playerexert(client_num, "falldamage");
}

/*
	Name: clientvoicesetup
	Namespace: zm_audio
	Checksum: 0x41DA7534
	Offset: 0x7A8
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function clientvoicesetup()
{
	localclientnum = self getlocalclientnumber();
	self thread audio_player_connect(localclientnum);
}

/*
	Name: audio_player_connect
	Namespace: zm_audio
	Checksum: 0xF4EACFBB
	Offset: 0x7F0
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function audio_player_connect(localclientnum)
{
	var_3d2dc382 = array("playerbreathinsound", "playerbreathoutsound", "playerbreathgaspsound", "mantlesoundplayer", "meleeswipesoundplayer");
	self thread sndvonotifyplain(localclientnum, var_3d2dc382);
	self thread sndvonotifydtp(localclientnum, "dtplandsoundplayer");
}

/*
	Name: sndvonotifyplain
	Namespace: zm_audio
	Checksum: 0xB9228368
	Offset: 0x888
	Size: 0xA8
	Parameters: 2
	Flags: Linked
*/
function sndvonotifyplain(localclientnum, var_3d2dc382)
{
	self notify("68e9879d130dec7b");
	self endon("68e9879d130dec7b");
	self endon(#"death");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(var_3d2dc382);
		if(isdefined(self.is_player_zombie) && self.is_player_zombie)
		{
			continue;
		}
		self playerexert(localclientnum, s_result._notify);
	}
}

/*
	Name: playerexert
	Namespace: zm_audio
	Checksum: 0xAD503C93
	Offset: 0x938
	Size: 0x1CC
	Parameters: 2
	Flags: Linked
*/
function playerexert(localclientnum, exert)
{
	if(isdefined(self.isspeaking) && self.isspeaking == 1)
	{
		return;
	}
	if(isdefined(self.beast_mode) && self.beast_mode)
	{
		return;
	}
	if(exert === "meleeswipesoundplayer")
	{
		if(function_42e50d5())
		{
			return;
		}
	}
	id = level.exert_sounds[0][exert];
	if(isarray(level.exert_sounds[0][exert]))
	{
		id = array::random(level.exert_sounds[0][exert]);
	}
	if(isdefined(self.player_exert_id) && isarray(level.exert_sounds) && isarray(level.exert_sounds[self.player_exert_id]))
	{
		if(isarray(level.exert_sounds[self.player_exert_id][exert]))
		{
			id = array::random(level.exert_sounds[self.player_exert_id][exert]);
		}
		else
		{
			id = level.exert_sounds[self.player_exert_id][exert];
		}
	}
	if(isdefined(id))
	{
		self playsound(localclientnum, id);
	}
}

/*
	Name: function_42e50d5
	Namespace: zm_audio
	Checksum: 0x1B8CAF77
	Offset: 0xB10
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_42e50d5()
{
	if(isdefined(self.weapon))
	{
		switch(self.weapon.name)
		{
			case "hero_scepter_lv3":
			case "hero_scepter_lv2":
			case "hero_scepter_lv1":
			{
				return true;
			}
		}
	}
	return false;
}

/*
	Name: sndvonotifydtp
	Namespace: zm_audio
	Checksum: 0x9F39B390
	Offset: 0xB80
	Size: 0x70
	Parameters: 2
	Flags: Linked
*/
function sndvonotifydtp(localclientnum, notifystring)
{
	self notify("50ec137dd0562c2");
	self endon("50ec137dd0562c2");
	self endon(#"death");
	while(true)
	{
		self waittill(notifystring);
		self playerexert(localclientnum, notifystring);
	}
}

/*
	Name: sndmeleeswipe
	Namespace: zm_audio
	Checksum: 0xF7E74401
	Offset: 0xBF8
	Size: 0x1D0
	Parameters: 2
	Flags: None
*/
function sndmeleeswipe(localclientnum, notifystring)
{
	self endon(#"death");
	for(;;)
	{
		self waittill(notifystring);
		currentweapon = getcurrentweapon(localclientnum);
		if(isdefined(level.sndnomeleeonclient) && level.sndnomeleeonclient)
		{
			return;
		}
		if(isdefined(self.is_player_zombie) && self.is_player_zombie)
		{
			playsound(0, #"zmb_melee_whoosh_zmb_plr", self.origin);
			continue;
		}
		if(currentweapon.statname === #"bowie_knife")
		{
			playsound(0, #"zmb_bowie_swing_plr", self.origin);
			continue;
		}
		if(currentweapon.name == "spoon_zm_alcatraz")
		{
			playsound(0, #"zmb_spoon_swing_plr", self.origin);
			continue;
		}
		if(currentweapon.name == "spork_zm_alcatraz")
		{
			playsound(0, #"zmb_spork_swing_plr", self.origin);
			continue;
		}
		playsound(0, #"zmb_melee_whoosh_plr", self.origin);
	}
}

/*
	Name: end_gameover_snapshot
	Namespace: zm_audio
	Checksum: 0xF31BB026
	Offset: 0xDD0
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function end_gameover_snapshot()
{
	level waittill(#"demo_jump", #"demo_player_switch", #"snd_clear_script_duck");
	wait(1);
	audio::snd_set_snapshot("default");
	level thread gameover_snapshot();
}

/*
	Name: gameover_snapshot
	Namespace: zm_audio
	Checksum: 0x2D37CFE5
	Offset: 0xE50
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function gameover_snapshot()
{
	level waittill(#"zesn");
	audio::snd_set_snapshot("zmb_game_over");
	level thread end_gameover_snapshot();
}

/*
	Name: sndzmblaststand
	Namespace: zm_audio
	Checksum: 0x137EF6AE
	Offset: 0xEA8
	Size: 0x10E
	Parameters: 7
	Flags: Linked
*/
function sndzmblaststand(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		playsound(localclientnum, #"hash_5e980fdf2497d9a1", (0, 0, 0));
		self.var_63de16a = self playloopsound(#"hash_7b41cf42e1b9847b");
		self.inlaststand = 1;
	}
	else if(isdefined(self.inlaststand) && self.inlaststand)
	{
		playsound(localclientnum, #"hash_1526662237d7780f", (0, 0, 0));
		self stoploopsound(self.var_63de16a);
		self.inlaststand = 0;
	}
}

