// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\player\player_stats.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\medals_shared.gsc;
#using scripts\core_common\persistence_shared.gsc;
#using scripts\core_common\rank_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace popups;

/*
	Name: __init__system__
	Namespace: popups
	Checksum: 0x542923DC
	Offset: 0xA8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"popups", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: popups
	Checksum: 0x3D5D368C
	Offset: 0xF0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_start_gametype(&init);
}

/*
	Name: init
	Namespace: popups
	Checksum: 0xFCAA3E7C
	Offset: 0x120
	Size: 0x1EC
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level.contractsettings = spawnstruct();
	level.contractsettings.waittime = 4.2;
	level.killstreaksettings = spawnstruct();
	level.killstreaksettings.waittime = 3;
	level.ranksettings = spawnstruct();
	level.ranksettings.waittime = 3;
	level.startmessage = spawnstruct();
	level.startmessagedefaultduration = 2;
	level.endmessagedefaultduration = 2;
	level.challengesettings = spawnstruct();
	level.challengesettings.waittime = 3;
	level.teammessage = spawnstruct();
	level.teammessage.waittime = 3;
	level.momentumnotifywaittime = 0;
	level.momentumnotifywaitlasttime = 0;
	level.teammessagequeuemax = 8;
	/#
		level thread popupsfromconsole();
		level thread devgui_notif_init();
	#/
	callback::on_connecting(&on_player_connect);
	callback::add_callback(#"team_message", &function_fad72726);
}

/*
	Name: on_player_connect
	Namespace: popups
	Checksum: 0xC42636DC
	Offset: 0x318
	Size: 0x62
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	if(isdefined(self) && !function_3132f113(self))
	{
		self.resetgameoverhudrequired = 0;
		if(!level.hardcoremode)
		{
			if(shoulddisplayteammessages())
			{
				self.teammessagequeue = [];
			}
		}
	}
}

/*
	Name: devgui_notif_getgunleveltablename
	Namespace: popups
	Checksum: 0x3FE6C46D
	Offset: 0x388
	Size: 0x62
	Parameters: 0
	Flags: None
*/
function devgui_notif_getgunleveltablename()
{
	/#
		if(sessionmodeiscampaigngame())
		{
			return #"gamedata/weapons/cp/cp_gunlevels.csv";
		}
		if(sessionmodeiszombiesgame())
		{
			return #"gamedata/weapons/zm/zm_gunlevels.csv";
		}
		return #"gamedata/weapons/mp/mp_gunlevels.csv";
	#/
}

/*
	Name: devgui_notif_getchallengestablecount
	Namespace: popups
	Checksum: 0x7822CFC1
	Offset: 0x3F8
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function devgui_notif_getchallengestablecount()
{
	/#
		if(sessionmodeiscampaigngame())
		{
			return 4;
		}
		if(sessionmodeiszombiesgame())
		{
			return 4;
		}
		return 6;
	#/
}

/*
	Name: devgui_notif_getchallengestablename
	Namespace: popups
	Checksum: 0xDE4BDD44
	Offset: 0x450
	Size: 0x98
	Parameters: 1
	Flags: None
*/
function devgui_notif_getchallengestablename(tableid)
{
	/#
		if(sessionmodeiscampaigngame())
		{
			return (#"gamedata/stats/cp/statsmilestones" + tableid) + "";
		}
		if(sessionmodeiszombiesgame())
		{
			return (#"gamedata/stats/zm/statsmilestones" + tableid) + "";
		}
		return (#"gamedata/stats/mp/statsmilestones" + tableid) + "";
	#/
}

/*
	Name: devgui_create_weapon_levels_table
	Namespace: popups
	Checksum: 0x6EC6BD75
	Offset: 0x4F8
	Size: 0x18A
	Parameters: 0
	Flags: None
*/
function devgui_create_weapon_levels_table()
{
	/#
		level.tbl_weaponids = [];
		for(i = 0; i < 1024; i++)
		{
			iteminfo = getunlockableiteminfofromindex(i, 0);
			if(isdefined(iteminfo))
			{
				group_s = iteminfo.itemgroupname;
				if(issubstr(group_s, "") || group_s == "")
				{
					reference_s = iteminfo.namehash;
					if(reference_s != "")
					{
						level.tbl_weaponids[i][#"reference"] = reference_s;
						level.tbl_weaponids[i][#"group"] = group_s;
						level.tbl_weaponids[i][#"count"] = iteminfo.count;
						level.tbl_weaponids[i][#"attachment"] = iteminfo.attachments;
					}
				}
			}
		}
	#/
}

/*
	Name: devgui_notif_init
	Namespace: popups
	Checksum: 0x661F9D
	Offset: 0x690
	Size: 0x124
	Parameters: 0
	Flags: None
*/
function devgui_notif_init()
{
	/#
		setdvar(#"scr_notif_devgui_rank", 0);
		setdvar(#"scr_notif_devgui_gun_lvl_xp", 0);
		setdvar(#"scr_notif_devgui_gun_lvl_attachment_index", 0);
		setdvar(#"scr_notif_devgui_gun_lvl_item_index", 0);
		setdvar(#"scr_notif_devgui_gun_lvl_rank_id", 0);
		if(isdedicated())
		{
			return;
		}
		if(getdvarint(#"hash_300689cb3bb5ab4d", 0) > 0)
		{
			return;
		}
		util::add_devgui("", "");
		level thread function_a65863ce();
	#/
}

/*
	Name: function_a65863ce
	Namespace: popups
	Checksum: 0xC1F3F5
	Offset: 0x7C0
	Size: 0x84
	Parameters: 0
	Flags: None
*/
function function_a65863ce()
{
	/#
		level endon(#"game_ended");
		while(true)
		{
			if(getdvarint(#"hash_300689cb3bb5ab4d", 0) > 0)
			{
				util::remove_devgui("");
				function_ac0bfb9c();
				return;
			}
			wait(1);
		}
	#/
}

/*
	Name: function_ac0bfb9c
	Namespace: popups
	Checksum: 0x8E75D4E
	Offset: 0x850
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function function_ac0bfb9c()
{
	/#
		level thread notif_devgui_rank();
		level thread notif_devgui_gun_rank();
		if(!sessionmodeiscampaigngame())
		{
			level thread notif_devgui_challenges();
		}
	#/
}

/*
	Name: notif_devgui_rank
	Namespace: popups
	Checksum: 0x8C2C4E9D
	Offset: 0x8B8
	Size: 0x10C
	Parameters: 0
	Flags: None
*/
function notif_devgui_rank()
{
	/#
		if(!isdefined(level.ranktable))
		{
			return;
		}
		notif_rank_devgui_base = "";
		for(i = 1; i < level.ranktable.size; i++)
		{
			display_level = i + 1;
			if(display_level < 10)
			{
				display_level = "" + display_level;
			}
			util::waittill_can_add_debug_command();
			adddebugcommand(((((((notif_rank_devgui_base + display_level) + "") + "") + "") + "") + i) + "");
		}
		waitframe(1);
		level thread notif_devgui_rank_up_think();
	#/
}

/*
	Name: notif_devgui_rank_up_think
	Namespace: popups
	Checksum: 0xAC0884C2
	Offset: 0x9D0
	Size: 0xCE
	Parameters: 0
	Flags: None
*/
function notif_devgui_rank_up_think()
{
	/#
		for(;;)
		{
			rank_number = getdvarint(#"scr_notif_devgui_rank", 0);
			if(rank_number == 0)
			{
				waitframe(1);
				continue;
			}
			level.players[0] rank::codecallback_rankup({#unlock_tokens_added:1, #prestige:0, #rank:rank_number});
			setdvar(#"scr_notif_devgui_rank", 0);
			wait(1);
		}
	#/
}

/*
	Name: notif_devgui_gun_rank
	Namespace: popups
	Checksum: 0x2E2D0FAE
	Offset: 0xAA8
	Size: 0x9A4
	Parameters: 0
	Flags: None
*/
function notif_devgui_gun_rank()
{
	/#
		notif_gun_rank_devgui_base = "";
		gunlevel_rankid_col = 0;
		gunlevel_gunref_col = 2;
		gunlevel_attachment_unlock_col = 3;
		gunlevel_xpgained_col = 4;
		level flag::wait_till("");
		if(!isdefined(level.tbl_weaponids))
		{
			devgui_create_weapon_levels_table();
		}
		if(!isdefined(level.tbl_weaponids))
		{
			return;
		}
		a_weapons = [];
		a_weapons[#"assault"] = [];
		a_weapons[#"tactical"] = [];
		a_weapons[#"smg"] = [];
		a_weapons[#"lmg"] = [];
		a_weapons[#"shotgun"] = [];
		a_weapons[#"sniper"] = [];
		a_weapons[#"pistol"] = [];
		a_weapons[#"launcher"] = [];
		a_weapons[#"knife"] = [];
		gun_levels_table = devgui_notif_getgunleveltablename();
		foreach(weapon in level.tbl_weaponids)
		{
			gun = [];
			gun[#"ref"] = weapon[#"reference"];
			gun[#"itemindex"] = getitemindexfromref(weapon[#"reference"]);
			gun[#"attachments"] = [];
			gun_weapon_attachments = weapon[#"attachment"];
			if(isdefined(gun_weapon_attachments) && isarray(gun_weapon_attachments))
			{
				foreach(attachment in gun_weapon_attachments)
				{
					gun[#"attachments"][attachment] = [];
					gun[#"attachments"][attachment][#"itemindex"] = getattachmenttableindex(attachment);
					gun[#"attachments"][attachment][#"rankid"] = tablelookup(gun_levels_table, gunlevel_gunref_col, gun[#"ref"], gunlevel_attachment_unlock_col, attachment, gunlevel_rankid_col);
					gun[#"attachments"][attachment][#"xp"] = tablelookup(gun_levels_table, gunlevel_gunref_col, gun[#"ref"], gunlevel_attachment_unlock_col, attachment, gunlevel_xpgained_col);
				}
			}
			switch(weapon[#"group"])
			{
				case "weapon_pistol":
				{
					if(weapon[#"reference"] != "")
					{
						arrayinsert(a_weapons[#"pistol"], gun, 0);
					}
					break;
				}
				case "weapon_launcher":
				{
					arrayinsert(a_weapons[#"launcher"], gun, 0);
					break;
				}
				case "weapon_assault":
				{
					arrayinsert(a_weapons[#"assault"], gun, 0);
					break;
				}
				case "weapon_tactical":
				{
					arrayinsert(a_weapons[#"tactical"], gun, 0);
					break;
				}
				case "weapon_smg":
				{
					arrayinsert(a_weapons[#"smg"], gun, 0);
					break;
				}
				case "weapon_lmg":
				{
					arrayinsert(a_weapons[#"lmg"], gun, 0);
					break;
				}
				case "weapon_cqb":
				{
					arrayinsert(a_weapons[#"shotgun"], gun, 0);
					break;
				}
				case "weapon_sniper":
				{
					arrayinsert(a_weapons[#"sniper"], gun, 0);
					break;
				}
				case "weapon_knife":
				{
					arrayinsert(a_weapons[#"knife"], gun, 0);
					break;
				}
				default:
				{
					break;
				}
			}
		}
		foreach(group_name, gun_group in a_weapons)
		{
			foreach(gun, attachment_group in gun_group)
			{
				foreach(attachment, attachment_data in attachment_group[#"attachments"])
				{
					devgui_cmd_gun_path = (((notif_gun_rank_devgui_base + function_9e72a96(group_name)) + "") + function_9e72a96(gun_group[gun][#"ref"]) + "") + function_9e72a96(attachment);
					util::waittill_can_add_debug_command();
					adddebugcommand(((((((((((((((((((devgui_cmd_gun_path + "") + "") + "") + "") + "") + attachment_data[#"xp"]) + "") + "") + "") + attachment_data[#"itemindex"]) + "") + "") + "") + gun_group[gun][#"itemindex"]) + "") + "") + "") + attachment_data[#"rankid"]) + "");
				}
			}
			waitframe(1);
		}
		level thread notif_devgui_gun_level_think();
	#/
}

/*
	Name: notif_devgui_gun_level_think
	Namespace: popups
	Checksum: 0x1F6CF9C9
	Offset: 0x1458
	Size: 0x1C6
	Parameters: 0
	Flags: None
*/
function notif_devgui_gun_level_think()
{
	/#
		for(;;)
		{
			weapon_item_index = getdvarint(#"scr_notif_devgui_gun_lvl_item_index", 0);
			if(weapon_item_index == 0)
			{
				waitframe(1);
				continue;
			}
			xp_reward = getdvarint(#"scr_notif_devgui_gun_lvl_xp", 0);
			attachment_index = getdvarint(#"scr_notif_devgui_gun_lvl_attachment_index", 0);
			rank_id = getdvarint(#"scr_notif_devgui_gun_lvl_rank_id", 0);
			level.players[0] persistence::codecallback_gunchallengecomplete({#rank_id:rank_id, #item_index:weapon_item_index, #attachment_index:attachment_index, #reward:xp_reward});
			setdvar(#"scr_notif_devgui_gun_lvl_xp", 0);
			setdvar(#"scr_notif_devgui_gun_lvl_attachment_index", 0);
			setdvar(#"scr_notif_devgui_gun_lvl_item_index", 0);
			setdvar(#"scr_notif_devgui_gun_lvl_rank_id", 0);
			wait(1);
		}
	#/
}

/*
	Name: notif_devgui_challenges
	Namespace: popups
	Checksum: 0xE11AA88C
	Offset: 0x1628
	Size: 0x324
	Parameters: 0
	Flags: None
*/
function notif_devgui_challenges()
{
	/#
		notif_challenges_devgui_base = "";
		for(i = 1; i <= devgui_notif_getchallengestablecount(); i++)
		{
			tablename = devgui_notif_getchallengestablename(i);
			rows = tablelookuprowcount(tablename);
			for(j = 1; j < rows; j++)
			{
				challengeid = tablelookupcolumnforrow(tablename, j, 0);
				if(challengeid != "" && strisint(tablelookupcolumnforrow(tablename, j, 0)))
				{
					challengestring = tablelookupcolumnforrow(tablename, j, 5);
					type = tablelookupcolumnforrow(tablename, j, 3);
					challengetier = int(tablelookupcolumnforrow(tablename, j, 1));
					challengetierstring = "" + challengetier;
					if(challengetier < 10)
					{
						challengetierstring = "" + challengetier;
					}
					name = tablelookupcolumnforrow(tablename, j, 5);
					devgui_cmd_challenge_path = (((((notif_challenges_devgui_base + function_9e72a96(type)) + "") + function_9e72a96(name) + "") + challengetierstring) + "") + challengeid;
					util::waittill_can_add_debug_command();
					adddebugcommand(((((((((((devgui_cmd_challenge_path + "") + "") + "") + "") + "") + j) + "") + "") + "") + i) + "");
					if(int(challengeid) % 10)
					{
						waitframe(1);
					}
				}
			}
		}
		level thread notif_devgui_challenges_think();
	#/
}

/*
	Name: notif_devgui_challenges_think
	Namespace: popups
	Checksum: 0xD51F906A
	Offset: 0x1958
	Size: 0x42E
	Parameters: 0
	Flags: None
*/
function notif_devgui_challenges_think()
{
	/#
		setdvar(#"scr_notif_devgui_challenge_row", 0);
		setdvar(#"scr_notif_devgui_challenge_table", 0);
		for(;;)
		{
			row = getdvarint(#"scr_notif_devgui_challenge_row", 0);
			table = getdvarint(#"scr_notif_devgui_challenge_table", 0);
			if(table < 1 || table > devgui_notif_getchallengestablecount())
			{
				waitframe(1);
				continue;
			}
			player = level.players[0];
			tablename = devgui_notif_getchallengestablename(table);
			if(row < 1 || row > tablelookuprowcount(tablename))
			{
				waitframe(1);
				continue;
			}
			type = tablelookupcolumnforrow(tablename, row, 3);
			itemindex = 0;
			if(type == "")
			{
				type = 0;
			}
			else
			{
				if(type == "")
				{
					itemindex = 4;
					type = 3;
				}
				else
				{
					if(type == "")
					{
						itemindex = 1;
						type = 4;
					}
					else
					{
						if(type == "")
						{
							type = 2;
						}
						else
						{
							if(type == "")
							{
								type = 5;
							}
							else
							{
								itemindex = getdvarint(#"scr_challenge_itemindex", 0);
								if(itemindex == 0)
								{
									currentweaponname = player.currentweapon.name;
									itemindex = getitemindexfromref(currentweaponname);
									if(itemindex == 0)
									{
										itemindex = 225;
									}
								}
								type = 1;
							}
						}
					}
				}
			}
			xpreward = int(tablelookupcolumnforrow(tablename, row, 6));
			challengeid = int(tablelookupcolumnforrow(tablename, row, 0));
			maxvalue = int(tablelookupcolumnforrow(tablename, row, 2));
			player persistence::codecallback_challengecomplete({#challenge_index:challengeid, #item_index:itemindex, #challenge_type:type, #table_number:table - 1, #row:row, #max:maxvalue, #reward:xpreward});
			setdvar(#"scr_notif_devgui_challenge_row", 0);
			setdvar(#"scr_notif_devgui_challenge_table", 0);
			wait(1);
		}
	#/
}

/*
	Name: popupsfromconsole
	Namespace: popups
	Checksum: 0xC2DEA989
	Offset: 0x1D90
	Size: 0x808
	Parameters: 0
	Flags: None
*/
function popupsfromconsole()
{
	/#
		while(true)
		{
			timeout = getdvarfloat(#"scr_popuptime", 1);
			if(timeout == 0)
			{
				timeout = 1;
			}
			wait(timeout);
			medal = getdvarint(#"scr_popupmedal", 0);
			challenge = getdvarint(#"scr_popupchallenge", 0);
			rank = getdvarint(#"scr_popuprank", 0);
			gun = getdvarint(#"scr_popupgun", 0);
			contractpass = getdvarint(#"scr_popupcontractpass", 0);
			contractfail = getdvarint(#"scr_popupcontractfail", 0);
			gamemodemsg = getdvarint(#"scr_gamemodeslideout", 0);
			teammsg = getdvarint(#"scr_teamslideout", 0);
			challengeindex = getdvarint(#"scr_challengeindex", 1);
			for(i = 0; i < medal; i++)
			{
				level.players[0] medals::codecallback_medal({#medal_index:2});
			}
			for(i = 0; i < challenge; i++)
			{
				level.players[0] persistence::codecallback_challengecomplete({#challenge_index:18, #item_index:0, #challenge_type:0, #table_numuber:0, #row:19, #max:10, #reward:1000});
				level.players[0] persistence::codecallback_challengecomplete({#challenge_index:20, #item_index:0, #challenge_type:0, #table_number:0, #row:21, #max:1, #reward:1000});
				rewardxp = 500;
				maxval = 1;
				row = 1;
				tablenumber = 0;
				challengetype = 1;
				itemindex = 111;
				challengeindex = 0;
				maxval = 50;
				row = 1;
				tablenumber = 2;
				challengetype = 1;
				itemindex = 20;
				challengeindex = 512;
				maxval = 150;
				row = 100;
				tablenumber = 2;
				challengetype = 4;
				itemindex = 1;
				challengeindex = 611;
				level.players[0] persistence::codecallback_challengecomplete({#challenge_index:challengeindex, #item_index:itemindex, #challenge_type:challengetype, #table_number:tablenumber, #row:row, #max:maxval, #reward:rewardxp});
			}
			for(i = 0; i < rank; i++)
			{
				level.players[0] rank::codecallback_rankup({#unlock_tokens_added:1, #prestige:0, #rank:4});
			}
			for(i = 0; i < gun; i++)
			{
				level.players[0] persistence::codecallback_gunchallengecomplete({#rank_id:0, #item_index:25, #attachment_index:20, #reward:0});
			}
			for(i = 0; i < teammsg; i++)
			{
				player = level.players[0];
				if(isdefined(level.players[1]))
				{
					player = level.players[1];
				}
				level.players[0] displayteammessagetoall(#"hash_286f843fea185e5", player);
			}
			reset = getdvarint(#"scr_popupreset", 1);
			if(reset)
			{
				if(medal)
				{
					setdvar(#"scr_popupmedal", 0);
				}
				if(challenge)
				{
					setdvar(#"scr_popupchallenge", 0);
				}
				if(gun)
				{
					setdvar(#"scr_popupgun", 0);
				}
				if(rank)
				{
					setdvar(#"scr_popuprank", 0);
				}
				if(contractpass)
				{
					setdvar(#"scr_popupcontractpass", 0);
				}
				if(contractfail)
				{
					setdvar(#"scr_popupcontractfail", 0);
				}
				if(gamemodemsg)
				{
					setdvar(#"scr_gamemodeslideout", 0);
				}
				if(teammsg)
				{
					setdvar(#"scr_teamslideout", 0);
				}
			}
		}
	#/
}

/*
	Name: displaykillstreakteammessagetoall
	Namespace: popups
	Checksum: 0xB9366C52
	Offset: 0x25A0
	Size: 0x84
	Parameters: 2
	Flags: None
*/
function displaykillstreakteammessagetoall(killstreak, player)
{
	if(!isdefined(level.killstreaks[killstreak]))
	{
		return;
	}
	if(!isdefined(level.killstreaks[killstreak].var_43279ec9))
	{
		return;
	}
	message = level.killstreaks[killstreak].var_43279ec9;
	self displayteammessagetoall(message, player);
}

/*
	Name: displaykillstreakhackedteammessagetoall
	Namespace: popups
	Checksum: 0x49075A05
	Offset: 0x2630
	Size: 0x84
	Parameters: 2
	Flags: None
*/
function displaykillstreakhackedteammessagetoall(killstreak, player)
{
	if(!isdefined(level.killstreaks[killstreak]))
	{
		return;
	}
	if(!isdefined(level.killstreaks[killstreak].hackedtext))
	{
		return;
	}
	message = level.killstreaks[killstreak].hackedtext;
	self displayteammessagetoall(message, player);
}

/*
	Name: shoulddisplayteammessages
	Namespace: popups
	Checksum: 0x35504952
	Offset: 0x26C0
	Size: 0x36
	Parameters: 0
	Flags: Linked
*/
function shoulddisplayteammessages()
{
	if(level.hardcoremode == 1 || level.splitscreen == 1)
	{
		return false;
	}
	return true;
}

/*
	Name: function_eb9328f3
	Namespace: popups
	Checksum: 0x353F4578
	Offset: 0x2700
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_eb9328f3()
{
	self notify(#"hash_d7033aab931511e");
	self callback::callback(#"team_message");
}

/*
	Name: displayteammessagetoall
	Namespace: popups
	Checksum: 0x7CC544D4
	Offset: 0x2740
	Size: 0x136
	Parameters: 2
	Flags: Linked
*/
function displayteammessagetoall(message, player)
{
	if(!shoulddisplayteammessages())
	{
		return;
	}
	for(i = 0; i < level.players.size; i++)
	{
		cur_player = level.players[i];
		if(cur_player isempjammed())
		{
			continue;
		}
		size = cur_player.teammessagequeue.size;
		if(size >= level.teammessagequeuemax)
		{
			continue;
		}
		cur_player.teammessagequeue[size] = spawnstruct();
		cur_player.teammessagequeue[size].message = message;
		cur_player.teammessagequeue[size].player = player;
		cur_player function_eb9328f3();
	}
}

/*
	Name: displayteammessagetoteam
	Namespace: popups
	Checksum: 0xD5C1DB8F
	Offset: 0x2880
	Size: 0x20E
	Parameters: 6
	Flags: None
*/
function displayteammessagetoteam(message, player, team, optionalarg, var_3d4cfe83, var_cf88c427 = 0)
{
	if(!shoulddisplayteammessages())
	{
		return;
	}
	for(i = 0; i < level.players.size; i++)
	{
		cur_player = level.players[i];
		if(cur_player.team != team)
		{
			continue;
		}
		if(cur_player isempjammed())
		{
			continue;
		}
		size = cur_player.teammessagequeue.size;
		if(size >= level.teammessagequeuemax)
		{
			continue;
		}
		cur_player.teammessagequeue[size] = spawnstruct();
		cur_player.teammessagequeue[size].message = message;
		cur_player.teammessagequeue[size].player = player;
		cur_player.teammessagequeue[size].optionalarg = optionalarg;
		cur_player.teammessagequeue[size].var_3d4cfe83 = var_3d4cfe83;
		cur_player.teammessagequeue[size].var_cf88c427 = var_cf88c427;
		callback::callback(#"hash_41781454d98b676a", cur_player.teammessagequeue[size]);
		cur_player function_eb9328f3();
	}
}

/*
	Name: function_fad72726
	Namespace: popups
	Checksum: 0x185D3DD1
	Offset: 0x2A98
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_fad72726()
{
	if(!shoulddisplayteammessages())
	{
		return;
	}
	function_921657e4();
}

/*
	Name: function_921657e4
	Namespace: popups
	Checksum: 0xC7B1537D
	Offset: 0x2AD0
	Size: 0x1C8
	Parameters: 0
	Flags: Linked
*/
function function_921657e4()
{
	while(self.teammessagequeue.size > 0)
	{
		nextnotifydata = self.teammessagequeue[0];
		arrayremoveindex(self.teammessagequeue, 0, 0);
		if(!isdefined(nextnotifydata.player) || !isplayer(nextnotifydata.player))
		{
			continue;
		}
		if(self isempjammed())
		{
			continue;
		}
		notifyhash = #"player_callout";
		if(isdefined(nextnotifydata.var_3d4cfe83) && nextnotifydata.var_3d4cfe83)
		{
			notifyhash = #"hash_22b5b25be43ad2d7";
		}
		else if(isdefined(nextnotifydata.var_cf88c427) && nextnotifydata.var_cf88c427)
		{
			notifyhash = #"hash_2a3c608f65b1cead";
		}
		if(isdefined(nextnotifydata.optionalarg))
		{
			self luinotifyevent(notifyhash, 3, nextnotifydata.message, nextnotifydata.player getentitynumber(), nextnotifydata.optionalarg);
		}
		else
		{
			self luinotifyevent(notifyhash, 2, nextnotifydata.message, nextnotifydata.player getentitynumber());
		}
	}
}

