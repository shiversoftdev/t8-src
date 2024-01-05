// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\killstreaks\mp\killstreakrules.gsc;
#using scripts\killstreaks\mp\killstreak_vehicle.gsc;
#using scripts\mp_common\gametypes\globallogic_score.gsc;
#using scripts\mp_common\gametypes\globallogic_audio.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\killstreaks\killstreaks_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace killstreaks;

/*
	Name: __init__system__
	Namespace: killstreaks
	Checksum: 0xA58DDA1C
	Offset: 0x128
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"killstreaks", &__init__, undefined, #"weapons");
}

/*
	Name: __init__
	Namespace: killstreaks
	Checksum: 0xE8C29138
	Offset: 0x178
	Size: 0x96
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
	killstreak_vehicle::init();
	killstreakrules::init();
	callback::on_start_gametype(&init);
	level.var_1492d026 = &play_killstreak_start_dialog;
	level.var_bdff8e21 = getgametypesetting(#"hash_2560dae45cc112e3");
}

/*
	Name: init
	Namespace: killstreaks
	Checksum: 0x2C7F6091
	Offset: 0x218
	Size: 0x23C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	/#
		level.killstreak_init_start_time = getmillisecondsraw();
		thread debug_ricochet_protection();
	#/
	function_447e6858();
	level.var_b0dc03c7 = &function_395f82d0;
	level.play_killstreak_firewall_being_hacked_dialog = &function_427f6a2e;
	level.play_killstreak_firewall_hacked_dialog = &function_6fa91236;
	level.play_killstreak_being_hacked_dialog = &function_1cd175ba;
	level.play_killstreak_hacked_dialog = &function_520a5752;
	level.play_killstreak_start_dialog = &function_7bed52a;
	level.play_pilot_dialog_on_owner = &function_9716fce9;
	level.play_pilot_dialog = &function_f6370f75;
	level.play_destroyed_dialog_on_owner = &function_6a5cc212;
	level.play_taacom_dialog_response_on_owner = &function_3cf68327;
	level.play_taacom_dialog = &function_3d6e0cd9;
	level.var_514f9d20 = &function_b11487a4;
	level.var_9f8e080d = &function_ed335136;
	level.var_19a15e42 = &function_daabc818;
	callback::callback(#"hash_45f35669076bc317");
	/#
		level.killstreak_init_end_time = getmillisecondsraw();
		elapsed_time = level.killstreak_init_end_time - level.killstreak_init_start_time;
		println(("" + elapsed_time) + "");
		level thread killstreak_debug_think();
	#/
}

/*
	Name: function_395f82d0
	Namespace: killstreaks
	Checksum: 0xD2D098F3
	Offset: 0x460
	Size: 0x4C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_395f82d0(killstreaktype)
{
	globallogic_score::_setplayermomentum(self, self.momentum - self function_dceb5542(level.killstreaks[killstreaktype].itemindex));
}

/*
	Name: function_427f6a2e
	Namespace: killstreaks
	Checksum: 0x649695A3
	Offset: 0x4B8
	Size: 0x5C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_427f6a2e(killstreaktype, killstreakid)
{
	if(self killstreak_dialog_queued("firewallBeingHacked", killstreaktype, killstreakid))
	{
		return;
	}
	self globallogic_audio::play_taacom_dialog("firewallBeingHacked", killstreaktype, killstreakid);
}

/*
	Name: function_6fa91236
	Namespace: killstreaks
	Checksum: 0x8456247F
	Offset: 0x520
	Size: 0x5C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_6fa91236(killstreaktype, killstreakid)
{
	if(self killstreak_dialog_queued("firewallHacked", killstreaktype, killstreakid))
	{
		return;
	}
	self globallogic_audio::play_taacom_dialog("firewallHacked", killstreaktype, killstreakid);
}

/*
	Name: function_1cd175ba
	Namespace: killstreaks
	Checksum: 0x876C8C01
	Offset: 0x588
	Size: 0x5C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_1cd175ba(killstreaktype, killstreakid)
{
	if(self killstreak_dialog_queued("beingHacked", killstreaktype, killstreakid))
	{
		return;
	}
	self globallogic_audio::play_taacom_dialog("beingHacked", killstreaktype, killstreakid);
}

/*
	Name: function_520a5752
	Namespace: killstreaks
	Checksum: 0xDB728374
	Offset: 0x5F0
	Size: 0x134
	Parameters: 3
	Flags: Linked, Private
*/
function private function_520a5752(killstreaktype, killstreakid, hacker)
{
	self globallogic_audio::flush_killstreak_dialog_on_player(killstreakid);
	self globallogic_audio::play_taacom_dialog("hacked", killstreaktype);
	excludeself = [];
	excludeself[0] = self;
	if(level.teambased)
	{
		globallogic_audio::leader_dialog(level.killstreaks[killstreaktype].hackeddialogkey, self.team, excludeself);
		globallogic_audio::leader_dialog_for_other_teams(level.killstreaks[killstreaktype].hackedstartdialogkey, self.team, undefined, killstreakid);
	}
	else
	{
		self globallogic_audio::leader_dialog_on_player(level.killstreaks[killstreaktype].hackeddialogkey);
		hacker globallogic_audio::leader_dialog_on_player(level.killstreaks[killstreaktype].hackedstartdialogkey);
	}
}

/*
	Name: function_7bed52a
	Namespace: killstreaks
	Checksum: 0xA1D648A4
	Offset: 0x730
	Size: 0x274
	Parameters: 3
	Flags: Linked, Private
*/
function private function_7bed52a(killstreaktype, team, killstreakid)
{
	if(!isdefined(killstreaktype) || !isdefined(killstreakid))
	{
		return;
	}
	self notify("killstreak_start_" + killstreaktype);
	self notify("killstreak_start_inventory_" + killstreaktype);
	excludeself = [];
	excludeself[0] = self;
	if(level.teambased)
	{
		if(!isdefined(self.currentkillstreakdialog) && isdefined(level.var_cb4eb1d1))
		{
			self thread [[level.var_cb4eb1d1]](level.killstreaks[killstreaktype].requestdialogkey, level.killstreaks[killstreaktype].var_3b69c05b);
		}
		if(isdefined(level.killstreakrules[killstreaktype]) && level.killstreakrules[killstreaktype].curteam[team] > 1)
		{
			globallogic_audio::leader_dialog_for_other_teams(level.killstreaks[killstreaktype].enemystartmultipledialogkey, team, undefined, killstreakid);
		}
		else
		{
			globallogic_audio::leader_dialog_for_other_teams(level.killstreaks[killstreaktype].enemystartdialogkey, team, undefined, killstreakid);
		}
	}
	else
	{
		if(!isdefined(self.currentkillstreakdialog) && isdefined(level.killstreaks[killstreaktype].requestdialogkey) && isdefined(level.heroplaydialog))
		{
			self thread [[level.heroplaydialog]](level.killstreaks[killstreaktype].requestdialogkey);
		}
		if(isdefined(level.killstreakrules[killstreaktype]) && level.killstreakrules[killstreaktype].cur > 1)
		{
			globallogic_audio::leader_dialog_for_other_teams(level.killstreaks[killstreaktype].enemystartmultipledialogkey, team, undefined, killstreakid);
		}
		else
		{
			globallogic_audio::leader_dialog(level.killstreaks[killstreaktype].enemystartdialogkey, undefined, excludeself, undefined, killstreakid);
		}
	}
}

/*
	Name: function_6a5cc212
	Namespace: killstreaks
	Checksum: 0xE6C99B48
	Offset: 0x9B0
	Size: 0x8C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_6a5cc212(killstreaktype, killstreakid)
{
	if(!isdefined(self.owner) || !isdefined(self.team) || self.team != self.owner.team)
	{
		return;
	}
	self.owner globallogic_audio::flush_killstreak_dialog_on_player(killstreakid);
	self.owner globallogic_audio::play_taacom_dialog("destroyed", killstreaktype);
}

/*
	Name: function_9716fce9
	Namespace: killstreaks
	Checksum: 0x365276D5
	Offset: 0xA48
	Size: 0xA4
	Parameters: 3
	Flags: Linked, Private
*/
function private function_9716fce9(dialogkey, killstreaktype, killstreakid)
{
	if(!isdefined(self.owner) || !isdefined(self.owner.team) || !isdefined(self.team) || self.team != self.owner.team)
	{
		return;
	}
	self.owner play_pilot_dialog(dialogkey, killstreaktype, killstreakid, self.pilotindex);
}

/*
	Name: function_f6370f75
	Namespace: killstreaks
	Checksum: 0x58F4E813
	Offset: 0xAF8
	Size: 0x5C
	Parameters: 4
	Flags: Linked, Private
*/
function private function_f6370f75(dialogkey, killstreaktype, killstreakid, pilotindex)
{
	if(!isdefined(killstreaktype) || !isdefined(pilotindex))
	{
		return;
	}
	self globallogic_audio::killstreak_dialog_on_player(dialogkey, killstreaktype, killstreakid, pilotindex);
}

/*
	Name: function_3d6e0cd9
	Namespace: killstreaks
	Checksum: 0x1924FA22
	Offset: 0xB60
	Size: 0x6C
	Parameters: 7
	Flags: Linked, Private
*/
function private function_3d6e0cd9(dialogkey, killstreaktype, killstreakid, var_46bd7973, var_8a6b001a, weapon, priority)
{
	self globallogic_audio::play_taacom_dialog(dialogkey, killstreaktype, killstreakid, var_46bd7973, var_8a6b001a, weapon, priority);
}

/*
	Name: function_3cf68327
	Namespace: killstreaks
	Checksum: 0x3F1FAE91
	Offset: 0xBD8
	Size: 0xBC
	Parameters: 3
	Flags: Linked, Private
*/
function private function_3cf68327(dialogkey, killstreaktype, killstreakid)
{
	/#
		assert(isdefined(dialogkey));
	#/
	/#
		assert(isdefined(killstreaktype));
	#/
	if(!isdefined(self.owner) || !isdefined(self.team) || self.team != self.owner.team)
	{
		return;
	}
	self.owner play_taacom_dialog_response(dialogkey, killstreaktype, killstreakid, self.pilotindex);
}

/*
	Name: function_ed335136
	Namespace: killstreaks
	Checksum: 0xEA438470
	Offset: 0xCA0
	Size: 0x54
	Parameters: 5
	Flags: Linked, Private
*/
function private function_ed335136(dialogkey, skipteam, objectivekey, killstreakid, dialogbufferkey)
{
	globallogic_audio::leader_dialog_for_other_teams(dialogkey, skipteam, objectivekey, killstreakid, dialogbufferkey);
}

/*
	Name: function_b11487a4
	Namespace: killstreaks
	Checksum: 0xA590059C
	Offset: 0xD00
	Size: 0x5C
	Parameters: 6
	Flags: Linked, Private
*/
function private function_b11487a4(dialogkey, team, excludelist, objectivekey, killstreakid, dialogbufferkey)
{
	globallogic_audio::leader_dialog(dialogkey, team, excludelist, objectivekey, killstreakid, dialogbufferkey);
}

/*
	Name: function_daabc818
	Namespace: killstreaks
	Checksum: 0x26F87A47
	Offset: 0xD68
	Size: 0x44
	Parameters: 4
	Flags: Linked, Private
*/
function private function_daabc818(event, player, victim, weapon)
{
	scoreevents::processscoreevent(event, player, victim, weapon);
}

