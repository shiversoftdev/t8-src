// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\gestures.gsc;
#using scripts\core_common\killcam_shared.gsc;
#using scripts\core_common\popups_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\mp_common\draft.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\mp_common\util.gsc;

#namespace menus;

/*
	Name: function_89f2df9
	Namespace: menus
	Checksum: 0xC2DB4088
	Offset: 0x280
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"menus", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: menus
	Checksum: 0xA496EDE7
	Offset: 0x2C8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_start_gametype(&init);
	callback::on_connect(&on_player_connect);
	callback::on_menu_response(&on_menu_response);
}

/*
	Name: init
	Namespace: menus
	Checksum: 0x9191A0B6
	Offset: 0x338
	Size: 0x1D2
	Parameters: 0
	Flags: Linked
*/
function init()
{
	game.menu = [];
	game.menu[#"menu_start_menu"] = "StartMenu_Main";
	game.menu[#"menu_team"] = "ChangeTeam";
	game.menu[#"menu_class"] = "class";
	game.menu[#"menu_changeclass"] = "PositionDraft";
	game.menu[#"menu_changeclass_offline"] = "PositionDraft";
	foreach(str_team in level.teams)
	{
		game.menu["menu_changeclass_" + str_team] = "PositionDraft";
	}
	game.menu[#"menu_controls"] = "ingame_controls";
	game.menu[#"menu_options"] = "ingame_options";
	game.menu[#"menu_leavegame"] = "popup_leavegame";
}

/*
	Name: on_player_connect
	Namespace: menus
	Checksum: 0x7CE467B0
	Offset: 0x518
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	self.menu_response_callbacks = [];
	self callback::function_d8abfc3d(#"hash_4e1a50a35ec44bcc", &on_menu_response);
	self thread function_8e00969();
}

/*
	Name: on_menu_response
	Namespace: menus
	Checksum: 0xA0B0FB4B
	Offset: 0x578
	Size: 0x734
	Parameters: 1
	Flags: Linked
*/
function on_menu_response(params)
{
	menu = params.menu;
	response = params.response;
	intpayload = params.intpayload;
	if(isdefined(self.menu_response_callbacks[menu]))
	{
		self thread [[self.menu_response_callbacks[menu]]](response, intpayload);
	}
	if(response == "back")
	{
		self closeingamemenu();
		if(level.console)
		{
			if(menu == game.menu[#"menu_changeclass"] || menu == game.menu[#"menu_changeclass_offline"] || menu == game.menu[#"menu_team"] || menu == game.menu[#"menu_controls"])
			{
				if(isdefined(level.teams[self.pers[#"team"]]))
				{
					self openmenu(game.menu[#"menu_start_menu"]);
				}
			}
		}
		return;
	}
	if(menu == "changeteam" && level.allow_teamchange)
	{
		self closeingamemenu();
		self openmenu(game.menu[#"menu_team"]);
	}
	if(response == "endgame")
	{
		if(level.splitscreen)
		{
			level.skipvote = 1;
			if(!level.gameended)
			{
				level thread globallogic::forceend();
			}
		}
		return;
	}
	if(response == "killserverpc")
	{
		level thread globallogic::killserverpc();
		return;
	}
	if(response == "endround")
	{
		if(function_f99d2668())
		{
			level.var_67a68459 = 1;
		}
		if(!level.gameended)
		{
			self globallogic::gamehistoryplayerquit();
			level thread globallogic::forceend();
		}
		else if(!function_8b1a219a())
		{
			self closeingamemenu();
		}
		if(function_f99d2668())
		{
			level notify(#"hash_197c640e2f684a74");
		}
		else
		{
			self iprintln(#"hash_6e4cedc56165f367");
		}
		return;
	}
	if(response == "autocontrol")
	{
		self [[level.autocontrolplayer]]();
		return;
	}
	if(response == #"hash_37a46164a47ed885")
	{
		self killcam::start_deathcam();
		return;
	}
	if(response == #"hash_aa9fde2b084d482")
	{
		self.sessionstate = "spectator";
		self.spectatorclient = -1;
		self.killcamentity = -1;
		self.archivetime = 0;
		self.psoffsettime = 0;
		self.spectatekillcam = 0;
		return;
	}
	if(menu == game.menu[#"menu_team"] && level.allow_teamchange)
	{
		switch(response)
		{
			case "autoassign":
			{
				self [[level.autoassign]](1, undefined);
				break;
			}
			case "spectator":
			{
				self [[level.spectator]]();
				break;
			}
			default:
			{
				self [[level.teammenu]](response);
				break;
			}
		}
	}
	else if(menu == game.menu[#"menu_changeclass"] || menu == game.menu[#"menu_changeclass_offline"])
	{
		if(response == "changecharacter" || response == "randomcharacter" || response == "ready" || response == "opendraft" || response == "closedraft")
		{
			self [[level.draftmenu]](response, intpayload);
		}
		else if(response == "change_specialist")
		{
			self [[level.var_2a43ad89]](intpayload);
		}
		else if(response == "weapon_updated")
		{
			if(self.dead !== 1 && self.health != 0)
			{
				self iprintlnbold(game.strings[#"hash_b71875e85956ea"]);
			}
		}
		else if(response != "cancel")
		{
			if(response == "draft")
			{
				characterindex = intpayload;
				draft::select_character(characterindex, 0, 0);
				return;
			}
			self [[level.curclass]](response, undefined, 1);
		}
	}
	else if(menu == "spectate")
	{
		player = util::getplayerfromclientnum(intpayload);
		if(isdefined(player))
		{
			self setcurrentspectatorclient(player);
		}
	}
	else if(menu == "sprays_and_gestures")
	{
		/#
			iprintlnbold("" + intpayload);
		#/
	}
	else if(menu == "callout_items")
	{
		function_2d1eb0ec(intpayload);
	}
}

/*
	Name: function_2d1eb0ec
	Namespace: menus
	Checksum: 0x219AE83
	Offset: 0xCB8
	Size: 0x4DE
	Parameters: 1
	Flags: Linked
*/
function function_2d1eb0ec(intpayload)
{
	if(!isdefined(level.var_4a38c46e))
	{
		level.var_4a38c46e = getscriptbundlelist(#"hash_1499732db058e6fb");
	}
	var_a4d879fa = intpayload % 100;
	var_f4cd8d56 = int(intpayload / 100) % 10;
	var_5f6c1c04 = int(intpayload / 1000);
	callout = getscriptbundle(level.var_4a38c46e[var_a4d879fa]);
	var_e7a0076b = callout.title;
	if(var_f4cd8d56 == 1)
	{
		var_e7a0076b = (isdefined(callout.var_82887152) ? callout.var_82887152 : callout.var_799fa983);
	}
	else if(var_f4cd8d56 == 2)
	{
		var_e7a0076b = callout.var_3c799f50;
	}
	if(isdefined(callout))
	{
		if(!isdefined(self.calloutspamtimeout))
		{
			self.calloutspamtimeout = 0;
		}
		time = gettime();
		if(self.calloutspamtimeout > time)
		{
			return;
		}
		if(callout.name == "sgc_warzone_item")
		{
			var_5f6c1c04 = self.var_cc586562;
			if(!isdefined(var_5f6c1c04) || var_5f6c1c04 == #"")
			{
				return;
			}
		}
		var_23c35f9c = (isdefined(level.var_ac6052e9) ? [[level.var_ac6052e9]]("calloutSpamThreshold", 0) : 0);
		if(!isdefined(self.lastcallouttime))
		{
			self.lastcallouttime = 0;
		}
		if(self.lastcallouttime > time)
		{
			self.var_1e13a12++;
		}
		else
		{
			self.var_1e13a12 = 0;
		}
		if(self.var_1e13a12 >= var_23c35f9c)
		{
			self.calloutspamtimeout = time + int((isdefined(level.var_ac6052e9) ? [[level.var_ac6052e9]]("calloutSpamTimeout", 0) : 0) * 1000);
		}
		weapon = self getcurrentweapon();
		var_2cf49821 = isdefined(weapon) && weapon.var_2cf49821;
		if(!var_2cf49821 && self function_7cadec11() && !self isinfreefall() && !self function_9a0edd92() && !self inlaststand() && isalive(self))
		{
			gesture = undefined;
			if(isdefined(callout.var_17d07d2d) && var_f4cd8d56 == 1)
			{
				gesture = self gestures::function_c77349d4(callout.var_17d07d2d);
			}
			else if(isdefined(callout.var_981c6467))
			{
				gesture = self gestures::function_c77349d4(callout.var_981c6467);
			}
			if(isdefined(gesture))
			{
				self gestures::function_b204f6e3(gesture, undefined, 0);
			}
		}
		team = self.pers[#"team"];
		popups::displayteammessagetoteam(var_e7a0076b, self, team, var_5f6c1c04, 1);
		if(isdefined(level.var_17d1b660))
		{
			self thread [[level.var_17d1b660]](callout, var_e7a0076b != callout.title);
		}
		self.lastcallouttime = time + int((isdefined(level.var_ac6052e9) ? [[level.var_ac6052e9]]("calloutSpamTimeWindow", 0) : 0) * 1000);
	}
}

/*
	Name: function_8e00969
	Namespace: menus
	Checksum: 0xDE53988E
	Offset: 0x11A0
	Size: 0x96
	Parameters: 0
	Flags: Linked
*/
function function_8e00969()
{
	self endon(#"disconnect", #"death");
	if(function_8b1a219a() && function_f99d2668())
	{
		while(true)
		{
			if(self function_1b011462())
			{
				function_2d1eb0ec(31);
			}
			waitframe(1);
		}
	}
}

/*
	Name: register_menu_response_callback
	Namespace: menus
	Checksum: 0xF9ED237B
	Offset: 0x1240
	Size: 0x3E
	Parameters: 2
	Flags: Linked
*/
function register_menu_response_callback(menu, callback)
{
	if(!isdefined(self.menu_response_callbacks))
	{
		self.menu_response_callbacks = [];
	}
	self.menu_response_callbacks[menu] = callback;
}

