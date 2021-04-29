// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\math_shared.gsc;

#namespace face;

/*
	Name: saygenericdialogue
	Namespace: face
	Checksum: 0x29D674DD
	Offset: 0x108
	Size: 0x144
	Parameters: 1
	Flags: None
*/
function saygenericdialogue(typestring)
{
	if(level.disablegenericdialog)
	{
		return;
	}
	switch(typestring)
	{
		case "attack":
		{
			importance = 0.5;
			break;
		}
		case "swing":
		{
			importance = 0.5;
			typestring = "attack";
			break;
		}
		case "flashbang":
		{
			importance = 0.7;
			break;
		}
		case "pain_small":
		{
			importance = 0.4;
			break;
		}
		case "pain_bullet":
		{
			wait(0.01);
			importance = 0.4;
			break;
		}
		default:
		{
			/#
				println("" + typestring);
			#/
			importance = 0.3;
			break;
		}
	}
	saygenericdialoguewithimportance(typestring, importance);
}

/*
	Name: saygenericdialoguewithimportance
	Namespace: face
	Checksum: 0xCAEF3E10
	Offset: 0x258
	Size: 0xB4
	Parameters: 2
	Flags: Linked
*/
function saygenericdialoguewithimportance(typestring, importance)
{
	soundalias = "dds_";
	if(isdefined(self.dds_characterid))
	{
		soundalias = soundalias + self.dds_characterid;
	}
	else
	{
		/#
			println("");
		#/
		return;
	}
	soundalias = soundalias + "_" + typestring;
	if(soundexists(soundalias))
	{
		self thread playfacethread(undefined, soundalias, importance);
	}
}

/*
	Name: setidlefacedelayed
	Namespace: face
	Checksum: 0xAB2E56FD
	Offset: 0x318
	Size: 0x1E
	Parameters: 1
	Flags: None
*/
function setidlefacedelayed(facialanimationarray)
{
	self.a.idleface = facialanimationarray;
}

/*
	Name: setidleface
	Namespace: face
	Checksum: 0xB91AFA6D
	Offset: 0x340
	Size: 0x44
	Parameters: 1
	Flags: None
*/
function setidleface(facialanimationarray)
{
	if(!anim.usefacialanims)
	{
		return;
	}
	self.a.idleface = facialanimationarray;
	self playidleface();
}

/*
	Name: sayspecificdialogue
	Namespace: face
	Checksum: 0xB9A0D28F
	Offset: 0x390
	Size: 0x6C
	Parameters: 7
	Flags: None
*/
function sayspecificdialogue(facialanim, soundalias, importance, notifystring, waitornot, timetowait, player_or_team)
{
	self thread playfacethread(facialanim, soundalias, importance, notifystring, waitornot, timetowait, player_or_team);
}

/*
	Name: playidleface
	Namespace: face
	Checksum: 0xB620A197
	Offset: 0x408
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function playidleface()
{
}

/*
	Name: playfacethread
	Namespace: face
	Checksum: 0x9F881CE9
	Offset: 0x418
	Size: 0x6FE
	Parameters: 7
	Flags: Linked
*/
function playfacethread(facialanim, str_script_alias, importance, notifystring, waitornot, timetowait, player_or_team)
{
	self endon(#"death");
	if(!isdefined(str_script_alias))
	{
		wait(1);
		self notify(notifystring);
		return;
	}
	str_notify_alias = str_script_alias;
	if(!isdefined(level.numberofimportantpeopletalking))
	{
		level.numberofimportantpeopletalking = 0;
	}
	if(!isdefined(level.talknotifyseed))
	{
		level.talknotifyseed = 0;
	}
	if(!isdefined(notifystring))
	{
		notifystring = "PlayFaceThread " + str_script_alias;
	}
	if(!isdefined(self.a))
	{
		self.a = spawnstruct();
	}
	if(!isdefined(self.a.facialsounddone))
	{
		self.a.facialsounddone = 1;
	}
	if(!isdefined(self.istalking))
	{
		self.istalking = 0;
	}
	if(self.istalking)
	{
		if(isdefined(self.a.currentdialogimportance))
		{
			if(importance < self.a.currentdialogimportance)
			{
				wait(1);
				self notify(notifystring);
				return;
			}
			if(importance == self.a.currentdialogimportance)
			{
				if(self.a.facialsoundalias == str_script_alias)
				{
					return;
				}
				/#
					println("" + self.a.facialsoundalias + "" + str_script_alias);
				#/
				while(self.istalking)
				{
					self waittill(#"hash_53464a658a055815");
				}
			}
		}
		else
		{
			/#
				println("" + self.a.facialsoundalias + "" + str_script_alias);
			#/
			self stopsound(self.a.facialsoundalias);
			self notify(#"hash_5d02e24cebf138cb");
			while(self.istalking)
			{
				self waittill(#"hash_53464a658a055815");
			}
		}
	}
	/#
		assert(self.a.facialsounddone);
	#/
	/#
		assert(self.a.facialsoundalias == undefined);
	#/
	/#
		assert(self.a.facialsoundnotify == undefined);
	#/
	/#
		assert(self.a.currentdialogimportance == undefined);
	#/
	/#
		assert(!self.istalking);
	#/
	self notify(#"bc_interrupt");
	self.istalking = 1;
	self.a.facialsounddone = 0;
	self.a.facialsoundnotify = notifystring;
	self.a.facialsoundalias = str_script_alias;
	self.a.currentdialogimportance = importance;
	if(importance == 1)
	{
		level.numberofimportantpeopletalking = level.numberofimportantpeopletalking + 1;
	}
	/#
		if(level.numberofimportantpeopletalking > 1)
		{
			println("" + str_script_alias);
		}
	#/
	uniquenotify = notifystring + " " + level.talknotifyseed;
	level.talknotifyseed = level.talknotifyseed + 1;
	if(isdefined(level.scr_sound) && isdefined(level.scr_sound[#"generic"]))
	{
		str_vox_file = level.scr_sound[#"generic"][str_script_alias];
	}
	if(!isdefined(str_vox_file) && soundexists(str_script_alias))
	{
		str_vox_file = str_script_alias;
	}
	if(isdefined(str_vox_file))
	{
		if(soundexists(str_vox_file))
		{
			if(isdefined(player_or_team))
			{
				self thread _play_sound_to_player_with_notify(str_vox_file, player_or_team, uniquenotify);
			}
			else if(isdefined(self gettagorigin("J_Head")))
			{
				self playsoundwithnotify(str_vox_file, uniquenotify, "J_Head");
			}
			else
			{
				self playsoundwithnotify(str_vox_file, uniquenotify);
			}
		}
		println("" + str_script_alias + "");
		self thread _missing_dialog(str_script_alias, str_vox_file, uniquenotify);
	}
	else
	{
		self thread _temp_dialog(str_script_alias, uniquenotify);
	}
	self waittill(#"death", #"hash_5d02e24cebf138cb", uniquenotify);
	if(importance == 1)
	{
		level.numberofimportantpeopletalking = level.numberofimportantpeopletalking - 1;
		level.importantpeopletalkingtime = gettime();
	}
	if(isdefined(self))
	{
		self.istalking = 0;
		self.a.facialsounddone = 1;
		self.a.facialsoundnotify = undefined;
		self.a.facialsoundalias = undefined;
		self.a.currentdialogimportance = undefined;
		self.lastsaytime = gettime();
	}
	self notify(#"hash_53464a658a055815", {#vo_line:str_notify_alias});
	self notify(notifystring);
}

/*
	Name: _play_sound_to_player_with_notify
	Namespace: face
	Checksum: 0x8D79F8BA
	Offset: 0xB20
	Size: 0xFC
	Parameters: 3
	Flags: Linked
*/
function _play_sound_to_player_with_notify(soundalias, player_or_team, uniquenotify)
{
	self endon(#"death");
	if(isplayer(player_or_team))
	{
		player_or_team endon(#"death");
		self playsoundtoplayer(soundalias, player_or_team);
	}
	else if(isstring(player_or_team))
	{
		self playsoundtoteam(soundalias, player_or_team);
	}
	n_playbacktime = soundgetplaybacktime(soundalias);
	if(n_playbacktime > 0)
	{
		wait(n_playbacktime * 0.001);
	}
	else
	{
		wait(1);
	}
	self notify(uniquenotify);
}

/*
	Name: _temp_dialog
	Namespace: face
	Checksum: 0xC3E7D4ED
	Offset: 0xC28
	Size: 0x33C
	Parameters: 3
	Flags: Linked, Private
*/
private function _temp_dialog(str_line, uniquenotify, b_missing_vo = 0)
{
	setdvar(#"bgcache_disablewarninghints", 1);
	if(!b_missing_vo && isdefined(self.propername))
	{
		str_line = self.propername + ": " + str_line;
	}
	foreach(player in level.players)
	{
		if(!isdefined(player getluimenu("TempDialog")))
		{
			player openluimenu("TempDialog");
		}
		player setluimenudata(player getluimenu("TempDialog"), #"dialogtext", str_line);
		if(b_missing_vo)
		{
			player setluimenudata(player getluimenu("TempDialog"), #"title", "MISSING VO SOUND");
			continue;
		}
		player setluimenudata(player getluimenu("TempDialog"), #"title", "TEMP VO");
	}
	n_wait_time = strtok(str_line, " ").size - 1 / 2;
	n_wait_time = math::clamp(n_wait_time, 2, 5);
	self waittill_timeout(n_wait_time, #"death", #"hash_5d02e24cebf138cb");
	foreach(player in level.players)
	{
		if(isdefined(player getluimenu("TempDialog")))
		{
			player closeluimenu(player getluimenu("TempDialog"));
		}
	}
	setdvar(#"bgcache_disablewarninghints", 0);
	self notify(uniquenotify);
}

/*
	Name: _missing_dialog
	Namespace: face
	Checksum: 0xB8554E4C
	Offset: 0xF70
	Size: 0x54
	Parameters: 3
	Flags: Private
*/
private function _missing_dialog(str_script_alias, str_vox_file, uniquenotify)
{
	_temp_dialog("script id: " + str_script_alias + " sound alias: " + str_vox_file, uniquenotify, 1);
}

/*
	Name: playface_waitfornotify
	Namespace: face
	Checksum: 0x62164A60
	Offset: 0xFD0
	Size: 0x5A
	Parameters: 3
	Flags: None
*/
function playface_waitfornotify(waitforstring, notifystring, killmestring)
{
	self endon(#"death", killmestring);
	self waittill(waitforstring);
	self.a.facewaitforresult = "notify";
	self notify(notifystring);
}

/*
	Name: playface_waitfortime
	Namespace: face
	Checksum: 0x8D0CE4C9
	Offset: 0x1038
	Size: 0x56
	Parameters: 3
	Flags: None
*/
function playface_waitfortime(time, notifystring, killmestring)
{
	self endon(#"death", killmestring);
	wait(time);
	self.a.facewaitforresult = "time";
	self notify(notifystring);
}

