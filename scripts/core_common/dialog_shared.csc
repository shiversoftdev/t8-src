// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;

#namespace dialog_shared;

/*
	Name: __init__system__
	Namespace: dialog_shared
	Checksum: 0xF531AC2
	Offset: 0x2A8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"dialog_shared", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: dialog_shared
	Checksum: 0x272E127E
	Offset: 0x2F0
	Size: 0x2C4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.mpboostresponse = [];
	level.mpboostresponse[#"battery"] = "Battery";
	level.mpboostresponse[#"buffassault"] = "BuffAssault";
	level.mpboostresponse[#"engineer"] = "Engineer";
	level.mpboostresponse[#"firebreak"] = "Firebreak";
	level.mpboostresponse[#"nomad"] = "Nomad";
	level.mpboostresponse[#"prophet"] = "Prophet";
	level.mpboostresponse[#"recon"] = "Recon";
	level.mpboostresponse[#"ruin"] = "Ruin";
	level.mpboostresponse[#"seraph"] = "Seraph";
	level.mpboostresponse[#"swatpolice"] = "SwatPolice";
	level.mpboostresponse[#"spectre"] = "Spectre";
	level.mpboostresponse[#"reaper"] = "Reaper";
	level.mpboostresponse[#"outrider"] = "Outrider";
	level.clientvoicesetup = &client_voice_setup;
	clientfield::register("world", "boost_number", 1, 2, "int", &set_boost_number, 1, 1);
	clientfield::register("allplayers", "play_boost", 1, 2, "int", &play_boost_vox, 1, 0);
}

/*
	Name: client_voice_setup
	Namespace: dialog_shared
	Checksum: 0xFCC20286
	Offset: 0x5C0
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function client_voice_setup(localclientnum)
{
	self thread snipervonotify(localclientnum, "playerbreathinsound", "exertSniperHold");
	self thread snipervonotify(localclientnum, "playerbreathoutsound", "exertSniperExhale");
	self thread snipervonotify(localclientnum, "playerbreathgaspsound", "exertSniperGasp");
}

/*
	Name: snipervonotify
	Namespace: dialog_shared
	Checksum: 0xD1C62D0C
	Offset: 0x650
	Size: 0x98
	Parameters: 3
	Flags: Linked
*/
function snipervonotify(localclientnum, notifystring, dialogkey)
{
	self endon(#"death");
	for(;;)
	{
		self waittill(notifystring);
		if(isunderwater(localclientnum))
		{
			return;
		}
		dialogalias = self get_player_dialog_alias(dialogkey);
		if(isdefined(dialogalias))
		{
			self playsound(0, dialogalias);
		}
	}
}

/*
	Name: set_boost_number
	Namespace: dialog_shared
	Checksum: 0x859898C9
	Offset: 0x6F0
	Size: 0x4A
	Parameters: 7
	Flags: Linked
*/
function set_boost_number(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	level.boostnumber = newval;
}

/*
	Name: play_boost_vox
	Namespace: dialog_shared
	Checksum: 0x721FF995
	Offset: 0x748
	Size: 0x14C
	Parameters: 7
	Flags: Linked
*/
function play_boost_vox(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	localplayerteam = function_73f4b33(localclientnum);
	entitynumber = self getentitynumber();
	if(newval == 0 || self.team != localplayerteam || level._sndnextsnapshot != "mpl_prematch" || level.booststartentnum === entitynumber || level.boostresponseentnum === entitynumber)
	{
		return;
	}
	if(newval == 1)
	{
		level.booststartentnum = entitynumber;
		self thread play_boost_start_vox(localclientnum);
	}
	else if(newval == 2)
	{
		level.boostresponseentnum = entitynumber;
		self thread play_boost_start_response_vox(localclientnum);
	}
}

/*
	Name: play_boost_start_vox
	Namespace: dialog_shared
	Checksum: 0x237922FF
	Offset: 0x8A0
	Size: 0x124
	Parameters: 1
	Flags: Linked
*/
function play_boost_start_vox(localclientnum)
{
	self endon(#"death");
	wait(2);
	playbackid = self play_dialog("boostStart" + level.boostnumber, localclientnum);
	if(isdefined(playbackid) && playbackid >= 0)
	{
		while(soundplaying(playbackid))
		{
			wait(0.05);
		}
	}
	wait(0.5);
	level.booststartresponse = ("boostStartResp" + level.mpboostresponse[self getmpdialogname()]) + level.boostnumber;
	if(isdefined(level.boostresponseentnum))
	{
		responder = getentbynum(localclientnum, level.boostresponseentnum);
		if(isdefined(responder))
		{
			responder thread play_boost_start_response_vox(localclientnum);
		}
	}
}

/*
	Name: play_boost_start_response_vox
	Namespace: dialog_shared
	Checksum: 0x9E540CB7
	Offset: 0x9D0
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function play_boost_start_response_vox(localclientnum)
{
	self endon(#"death");
	if(!isdefined(level.booststartresponse) || !self function_83973173())
	{
		return;
	}
	self play_dialog(level.booststartresponse, localclientnum);
}

/*
	Name: dialog_chance
	Namespace: dialog_shared
	Checksum: 0x6FB5506E
	Offset: 0xA48
	Size: 0x80
	Parameters: 1
	Flags: Linked
*/
function dialog_chance(chancekey)
{
	dialogchance = mpdialog_value(chancekey);
	if(!isdefined(dialogchance) || dialogchance <= 0)
	{
		return 0;
	}
	if(dialogchance >= 100)
	{
		return 1;
	}
	return randomint(100) < dialogchance;
}

/*
	Name: function_ad01601e
	Namespace: dialog_shared
	Checksum: 0xBFD7DB35
	Offset: 0xAD0
	Size: 0x124
	Parameters: 1
	Flags: Linked
*/
function function_ad01601e(characterindex)
{
	characterfields = getcharacterfields(characterindex, currentsessionmode());
	if(isdefined(characterfields) && isdefined(characterfields.mpdialog))
	{
		dialogbundle = struct::get_script_bundle("mpdialog_player", characterfields.mpdialog);
		alias = get_dialog_bundle_alias(dialogbundle, "characterSelect");
		if(isdefined(level.var_aefa616f) && level.var_aefa616f && dialog_chance("characterSelectMaldivesChance"))
		{
			alias = get_dialog_bundle_alias(dialogbundle, "maldivesCharacterSelectOverride");
		}
		if(isdefined(alias))
		{
			self playsound(undefined, alias);
		}
	}
}

/*
	Name: get_commander_dialog_alias
	Namespace: dialog_shared
	Checksum: 0x636A43E8
	Offset: 0xC00
	Size: 0x5A
	Parameters: 2
	Flags: None
*/
function get_commander_dialog_alias(commandername, dialogkey)
{
	if(!isdefined(commandername))
	{
		return;
	}
	commanderbundle = struct::get_script_bundle("mpdialog_commander", commandername);
	return get_dialog_bundle_alias(commanderbundle, dialogkey);
}

/*
	Name: get_dialog_bundle_alias
	Namespace: dialog_shared
	Checksum: 0x44927C66
	Offset: 0xC68
	Size: 0x84
	Parameters: 2
	Flags: Linked
*/
function get_dialog_bundle_alias(dialogbundle, dialogkey)
{
	if(!isdefined(dialogbundle) || !isdefined(dialogkey))
	{
		return undefined;
	}
	dialogalias = dialogbundle.(dialogkey);
	if(!isdefined(dialogalias))
	{
		return;
	}
	voiceprefix = dialogbundle.("voiceprefix");
	if(isdefined(voiceprefix))
	{
		dialogalias = voiceprefix + dialogalias;
	}
	return dialogalias;
}

/*
	Name: mpdialog_value
	Namespace: dialog_shared
	Checksum: 0x66E5A3B3
	Offset: 0xCF8
	Size: 0x86
	Parameters: 2
	Flags: Linked
*/
function mpdialog_value(mpdialogkey, defaultvalue)
{
	if(!isdefined(mpdialogkey))
	{
		return defaultvalue;
	}
	mpdialog = struct::get_script_bundle("mpdialog", "mpdialog_default");
	if(!isdefined(mpdialog))
	{
		return defaultvalue;
	}
	structvalue = mpdialog.(mpdialogkey);
	if(!isdefined(structvalue))
	{
		return defaultvalue;
	}
	return structvalue;
}

/*
	Name: get_player_dialog_alias
	Namespace: dialog_shared
	Checksum: 0x19A2F629
	Offset: 0xD88
	Size: 0x112
	Parameters: 2
	Flags: Linked
*/
function get_player_dialog_alias(dialogkey, meansofdeath = undefined)
{
	if(!isdefined(self))
	{
		return undefined;
	}
	bundlename = self getmpdialogname();
	if(isdefined(meansofdeath) && meansofdeath == "MOD_META" && (isdefined(self.pers[#"changed_specialist"]) ? self.pers[#"changed_specialist"] : 0))
	{
		bundlename = self.var_89c4a60f;
	}
	if(!isdefined(bundlename))
	{
		return undefined;
	}
	playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
	if(!isdefined(playerbundle))
	{
		return undefined;
	}
	return get_dialog_bundle_alias(playerbundle, dialogkey);
}

/*
	Name: play_dialog
	Namespace: dialog_shared
	Checksum: 0xFC505BB5
	Offset: 0xEA8
	Size: 0x14A
	Parameters: 2
	Flags: Linked
*/
function play_dialog(dialogkey, localclientnum)
{
	if(!isdefined(dialogkey) || !isdefined(localclientnum))
	{
		return -1;
	}
	dialogalias = self get_player_dialog_alias(dialogkey);
	if(!isdefined(dialogalias))
	{
		return -1;
	}
	soundpos = (self.origin[0], self.origin[1], self.origin[2] + 60);
	if(!function_65b9eb0f(localclientnum))
	{
		return self playsound(undefined, dialogalias, soundpos);
	}
	voicebox = spawn(localclientnum, self.origin, "script_model");
	self thread update_voice_origin(voicebox);
	voicebox thread delete_after(10);
	return voicebox playsound(undefined, dialogalias, soundpos);
}

/*
	Name: update_voice_origin
	Namespace: dialog_shared
	Checksum: 0x57295727
	Offset: 0x1000
	Size: 0x4A
	Parameters: 1
	Flags: Linked
*/
function update_voice_origin(voicebox)
{
	while(true)
	{
		wait(0.1);
		if(!isdefined(self) || !isdefined(voicebox))
		{
			return;
		}
		voicebox.origin = self.origin;
	}
}

/*
	Name: delete_after
	Namespace: dialog_shared
	Checksum: 0x7AB4A552
	Offset: 0x1058
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function delete_after(waittime)
{
	wait(waittime);
	self delete();
}

