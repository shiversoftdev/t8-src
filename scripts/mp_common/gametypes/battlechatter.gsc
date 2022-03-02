// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1ead38ea12d4eaa8;
#using script_3f27a7b2232674db;
#using script_5399f402045d7abd;
#using script_6c8abe14025b47c4;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\mp_common\gametypes\globallogic_audio.gsc;
#using scripts\mp_common\gametypes\globallogic_utils.gsc;
#using scripts\mp_common\gametypes\match.gsc;

#namespace battlechatter;

/*
	Name: function_89f2df9
	Namespace: battlechatter
	Checksum: 0x9500F5E3
	Offset: 0xBD8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"battlechatter", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: battlechatter
	Checksum: 0x6C1E5889
	Offset: 0xC20
	Size: 0xD5E
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	/#
		level thread devgui_think();
	#/
	callback::on_joined_team(&on_joined_team);
	callback::on_spawned(&on_player_spawned);
	level.heroplaydialog = &play_dialog;
	level.var_9082a3b6 = &function_bf68a5ab;
	level.var_e2fff792 = &function_f57e565f;
	level.var_9f155bf4 = &pain_vox;
	level.playgadgetready = &play_gadget_ready;
	level.playgadgetactivate = &play_gadget_activate;
	level.var_228e8cd6 = &function_916b4c72;
	level.var_7b83b300 = &function_cad61ec;
	level.playgadgetsuccess = &play_gadget_success;
	level.var_ac6052e9 = &mpdialog_value;
	level.var_d2600afc = &function_f5c48bfa;
	level.var_b42019ef = &function_4fb91bc7;
	level.playpromotionreaction = &play_promotion_reaction;
	level.var_cb4eb1d1 = &function_fff18afc;
	level.var_cef454e8 = &function_9a20c887;
	level.var_c08cd9fa = &function_1d4b0ec0;
	level.var_da2d586a = &function_78c16252;
	level.var_17d1b660 = &function_e3ebbf87;
	level.var_5568effe = &function_30146e82;
	level.var_ee30f81d = &function_e9f06034;
	level.var_ddfd70d = &function_95e44f78;
	if(!isdefined(level.var_cddcf1e3))
	{
		level.var_cddcf1e3 = undefined;
	}
	if(!isdefined(level.var_abaf1ec9))
	{
		level.var_abaf1ec9 = undefined;
	}
	level.bcsounds = [];
	level.bcsounds[#"incoming_alert"] = [];
	level.bcsounds[#"incoming_alert"][#"frag_grenade"] = "incomingFrag";
	level.bcsounds[#"incoming_alert"][#"incendiary_grenade"] = "incomingIncendiary";
	level.bcsounds[#"incoming_alert"][#"sticky_grenade"] = "incomingSemtex";
	level.bcsounds[#"incoming_alert"][#"eq_sticky_grenade"] = "incomingSemtex";
	level.bcsounds[#"incoming_alert"][#"launcher_standard"] = "threatRpg";
	level.bcsounds[#"incoming_delay"] = [];
	level.bcsounds[#"incoming_delay"][#"frag_grenade"] = "fragGrenadeDelay";
	level.bcsounds[#"incoming_delay"][#"incendiary_grenade"] = "incendiaryGrenadeDelay";
	level.bcsounds[#"incoming_alert"][#"sticky_grenade"] = "semtexDelay";
	level.bcsounds[#"incoming_alert"][#"eq_sticky_grenade"] = "semtexDelay";
	level.bcsounds[#"incoming_delay"][#"launcher_standard"] = "missileDelay";
	level.bcsounds[#"kill_dialog"] = [];
	level.bcsounds[#"kill_dialog"][#"battery"] = "killBattery";
	level.bcsounds[#"kill_dialog"][#"buffassault"] = "killBuffAssault";
	level.bcsounds[#"kill_dialog"][#"engineer"] = "killEngineer";
	level.bcsounds[#"kill_dialog"][#"firebreak"] = "killFirebreak";
	level.bcsounds[#"kill_dialog"][#"nomad"] = "killNomad";
	level.bcsounds[#"kill_dialog"][#"prophet"] = "killProphet";
	level.bcsounds[#"kill_dialog"][#"recon"] = "killRecon";
	level.bcsounds[#"kill_dialog"][#"ruin"] = "killRuin";
	level.bcsounds[#"kill_dialog"][#"seraph"] = "killSeraph";
	level.bcsounds[#"kill_dialog"][#"swatpolice"] = "killSwatPolice";
	level.bcsounds[#"kill_dialog"][#"zero"] = "killZero";
	level.bcsounds[#"kill_dialog"][#"outrider"] = "killOutrider";
	level.bcsounds[#"kill_dialog"][#"reaper"] = "killReaper";
	level.bcsounds[#"kill_dialog"][#"spectre"] = "killSpectre";
	if(level.teambased && !isdefined(game.boostplayerspicked))
	{
		game.boostplayerspicked = [];
		foreach(team, _ in level.teams)
		{
			game.boostplayerspicked[team] = 0;
		}
	}
	level.allowbattlechatter[#"bc"] = getgametypesetting(#"allowbattlechatter");
	level thread pick_boost_number();
	keycounts = [];
	playerdialogbundles = struct::get_script_bundles("mpdialog_player");
	foreach(bundle in playerdialogbundles)
	{
		count_keys(keycounts, bundle, "killGeneric");
		count_keys(keycounts, bundle, "killSniper");
		count_keys(keycounts, bundle, "killBattery");
		count_keys(keycounts, bundle, "killBuffAssault");
		count_keys(keycounts, bundle, "killEngineer");
		count_keys(keycounts, bundle, "killFirebreak");
		count_keys(keycounts, bundle, "killNomad");
		count_keys(keycounts, bundle, "killProphet");
		count_keys(keycounts, bundle, "killRecon");
		count_keys(keycounts, bundle, "killRuin");
		count_keys(keycounts, bundle, "killSeraph");
		count_keys(keycounts, bundle, "killSwatPolice");
		count_keys(keycounts, bundle, "killZero");
		count_keys(keycounts, bundle, "killOutrider");
		count_keys(keycounts, bundle, "killReaper");
		count_keys(keycounts, bundle, "killSpectre");
		if(keycounts[bundle.name].size == 0)
		{
			keycounts[bundle.name] = undefined;
		}
	}
	level.var_f53efe5c = keycounts;
	if(function_f99d2668())
	{
		level.var_f53efe5c = undefined;
	}
	mpdialog = struct::get_script_bundle("mpdialog", "mpdialog_default");
	if(!isdefined(mpdialog))
	{
		mpdialog = spawnstruct();
	}
	level.allowspecialistdialog = (isdefined(mpdialog.enableherodialog) ? mpdialog.enableherodialog : 0) && (isdefined(level.allowbattlechatter[#"bc"]) && level.allowbattlechatter[#"bc"]);
	level.playstartconversation = (isdefined(mpdialog.enableconversation) ? mpdialog.enableconversation : 0) && (isdefined(level.allowbattlechatter[#"bc"]) && level.allowbattlechatter[#"bc"]);
	level.var_bd715920 = &function_e44c3a3c;
}

/*
	Name: function_e9f06034
	Namespace: battlechatter
	Checksum: 0x55816367
	Offset: 0x1988
	Size: 0x114
	Parameters: 2
	Flags: Linked
*/
function function_e9f06034(player, var_cda945ba)
{
	if(player hasperk(#"specialty_quieter"))
	{
		return;
	}
	playerbundle = function_58c93260(player);
	if(!isdefined(playerbundle))
	{
		return;
	}
	if(var_cda945ba && isdefined(playerbundle.exertemergegasp))
	{
		self thread function_a48c33ff(playerbundle.exertemergegasp, 22, mpdialog_value("playerExertBuffer", 0));
	}
	else if(!var_cda945ba && isdefined(playerbundle.exertemergebreath))
	{
		self thread function_a48c33ff(playerbundle.exertemergebreath, 22, mpdialog_value("playerExertBuffer", 0));
	}
}

/*
	Name: function_30146e82
	Namespace: battlechatter
	Checksum: 0x55F1310F
	Offset: 0x1AA8
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function function_30146e82(player)
{
	if(player hasperk(#"specialty_quieter"))
	{
		return;
	}
	bundlename = self getmpdialogname();
	if(!isdefined(bundlename))
	{
		return;
	}
	playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
	if(!isdefined(playerbundle))
	{
		return;
	}
	dialogkey = playerbundle.var_b12a1e12;
	if(isdefined(dialogkey))
	{
		self.var_6765d33e = 1;
		self thread function_a48c33ff(dialogkey, 18);
	}
}

/*
	Name: pick_boost_number
	Namespace: battlechatter
	Checksum: 0x1EFDDA6
	Offset: 0x1B80
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function pick_boost_number()
{
	wait(5);
	level clientfield::set("boost_number", randomint(4));
}

/*
	Name: on_joined_team
	Namespace: battlechatter
	Checksum: 0xFAA37321
	Offset: 0x1BC8
	Size: 0x25E
	Parameters: 1
	Flags: Linked
*/
function on_joined_team(params)
{
	self endon(#"disconnect");
	teammask = getteammask(self.team);
	teamindex = 0;
	while(teammask > 1)
	{
		teammask = teammask >> 1;
		teamindex++;
	}
	if(teamindex % 2)
	{
		self set_blops_dialog();
	}
	else
	{
		self set_cdp_dialog();
	}
	self globallogic_audio::flush_dialog();
	if(!(isdefined(level.inprematchperiod) && level.inprematchperiod) && (!(isdefined(self.pers[#"playedgamemode"]) && self.pers[#"playedgamemode"])) && isdefined(level.leaderdialog))
	{
		if(level.hardcoremode)
		{
			if(globallogic_utils::function_308e3379())
			{
				self globallogic_audio::leader_dialog_on_player(level.leaderdialog.var_d04b3734, undefined, undefined, undefined, 1);
			}
			else
			{
				self globallogic_audio::leader_dialog_on_player(level.leaderdialog.starthcgamedialog, undefined, undefined, undefined, 1);
			}
		}
		else
		{
			if(globallogic_utils::function_308e3379())
			{
				self globallogic_audio::leader_dialog_on_player(level.leaderdialog.var_f6fda321, undefined, undefined, undefined, 1);
			}
			else
			{
				self globallogic_audio::leader_dialog_on_player(level.leaderdialog.startgamedialog, undefined, undefined, undefined, 1);
			}
		}
		self.pers[#"playedgamemode"] = 1;
	}
}

/*
	Name: set_blops_dialog
	Namespace: battlechatter
	Checksum: 0xA97DA865
	Offset: 0x1E30
	Size: 0x68
	Parameters: 0
	Flags: Linked
*/
function set_blops_dialog()
{
	self.pers[#"mptaacom"] = "blops_taacom";
	self.pers[#"mpcommander"] = "blops_commander";
	if(isdefined(level.var_cddcf1e3))
	{
		self [[level.var_cddcf1e3]]();
	}
}

/*
	Name: set_cdp_dialog
	Namespace: battlechatter
	Checksum: 0x1098D8BD
	Offset: 0x1EA0
	Size: 0x68
	Parameters: 0
	Flags: Linked
*/
function set_cdp_dialog()
{
	self.pers[#"mptaacom"] = "cdp_taacom";
	self.pers[#"mpcommander"] = "cdp_commander";
	if(isdefined(level.var_abaf1ec9))
	{
		self [[level.var_abaf1ec9]]();
	}
}

/*
	Name: on_player_spawned
	Namespace: battlechatter
	Checksum: 0x50B242F4
	Offset: 0x1F10
	Size: 0x1A4
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	self.enemythreattime = 0;
	self.heartbeatsnd = 0;
	self.soundmod = "player";
	self.voxunderwatertime = 0;
	self.voxemergebreath = 0;
	self.voxdrowning = 0;
	self.pilotisspeaking = 0;
	self.playingdialog = 0;
	self.playinggadgetreadydialog = 0;
	self.var_6765d33e = 0;
	self.playedgadgetsuccess = 1;
	self callback::add_callback("weapon_melee", &function_59f9cdab);
	self callback::add_callback("weapon_melee_charge", &function_59f9cdab);
	if(level.splitscreen || !level.allowbattlechatter[#"bc"])
	{
		return;
	}
	self thread grenade_tracking();
	self thread missile_tracking();
	self thread sticky_grenade_tracking();
	self thread function_44b5e397();
	self thread function_7139078d();
	if(level.teambased)
	{
		self thread enemy_threat();
	}
}

/*
	Name: function_58c93260
	Namespace: battlechatter
	Checksum: 0xD9BCFA84
	Offset: 0x20C0
	Size: 0x86
	Parameters: 1
	Flags: Linked
*/
function function_58c93260(player)
{
	if(!isplayer(player))
	{
		return undefined;
	}
	bundlename = player getmpdialogname();
	if(!isdefined(bundlename))
	{
		return undefined;
	}
	playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
	if(!isdefined(playerbundle))
	{
		return undefined;
	}
	return playerbundle;
}

/*
	Name: function_af2bf286
	Namespace: battlechatter
	Checksum: 0x6AAB3DFA
	Offset: 0x2150
	Size: 0x398
	Parameters: 1
	Flags: Linked
*/
function function_af2bf286(player)
{
	self notify("40dcec56538c25e1");
	self endon("40dcec56538c25e1");
	self endon(#"death", #"disconnect", #"weapon_change");
	level endon(#"game_ended");
	var_8e76086 = mpdialog_value("warmachineThreatMinDistance", 100);
	var_8e76086 = var_8e76086 * var_8e76086;
	while(true)
	{
		waitresult = undefined;
		waitresult = player waittill(#"weapon_fired");
		if(!isdefined(player))
		{
			return;
		}
		playerdirection = anglestoforward(player.angles);
		var_29b9ab2b = player geteye();
		enemies = self function_bdda420f(self.origin, mpdialog_value("warmachineThreatMaxDistance", 500));
		if(isarray(enemies) && enemies.size > 0)
		{
			foreach(enemy in enemies)
			{
				if(!isplayer(enemy) || enemy hasperk(#"specialty_quieter"))
				{
					continue;
				}
				directiontoenemy = vectornormalize(enemy.origin - self.origin);
				dot = vectordot(directiontoenemy, playerdirection);
				if(dot < mpdialog_value("warmachineThreatDotMin", 0.5))
				{
					continue;
				}
				if(distancesquared(enemy.origin, player.origin) < var_8e76086)
				{
					continue;
				}
				enemyeye = enemy geteye();
				if(!sighttracepassed(enemyeye, var_29b9ab2b, 1, enemy))
				{
					continue;
				}
				var_114baca3 = function_58c93260(enemy);
				if(!isdefined(var_114baca3))
				{
					continue;
				}
				dialogkey = var_114baca3.var_6582a778;
				if(!isdefined(dialogkey))
				{
					continue;
				}
				enemy thread function_a48c33ff(dialogkey, 2, undefined, undefined);
				break;
			}
		}
	}
}

/*
	Name: function_44b5e397
	Namespace: battlechatter
	Checksum: 0xD4C054E9
	Offset: 0x24F0
	Size: 0x366
	Parameters: 0
	Flags: Linked
*/
function function_44b5e397()
{
	self endon(#"death", #"disconnect");
	level endon(#"game_ended");
	self notify("3a7ae30337ee24bf");
	self endon("3a7ae30337ee24bf");
	if(isdefined(self.currentweapon))
	{
		nextweapon = self.currentweapon;
	}
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"weapon_change");
		if(waitresult.weapon == getweapon(#"hero_pineapplegun"))
		{
			self thread function_af2bf286(self);
		}
		if(isdefined(waitresult.weapon) && isweapon(waitresult.weapon))
		{
			nextweapon = waitresult.weapon;
		}
		else
		{
			nextweapon = self.currentweapon;
		}
		if(isdefined(nextweapon) && (nextweapon.name == "sig_buckler_dw" || nextweapon.name == "sig_buckler_turret") && (self.currentweapon.name == "sig_buckler_dw" || self.currentweapon.name == "sig_buckler_turret"))
		{
			continue;
		}
		if(nextweapon.name == "none")
		{
			continue;
		}
		self.var_3528f7e9 = 0;
		self.var_87b1ba00 = 0;
		if(self hasperk(#"specialty_quieter"))
		{
			continue;
		}
		bundlename = self getmpdialogname();
		if(!isdefined(bundlename))
		{
			continue;
		}
		playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
		if(!isdefined(playerbundle))
		{
			continue;
		}
		switch(nextweapon.name)
		{
			case "hero_pineapplegun":
			{
				dialogkey = playerbundle.warmachineweaponuse;
				break;
			}
			case "shock_rifle":
			{
				dialogkey = playerbundle.tempestweaponuse;
				break;
			}
			case "sig_lmg":
			{
				if(waitresult.last_weapon.name != #"hash_772f4afd37e876a1")
				{
					dialogkey = playerbundle.scytheweaponuse;
				}
				break;
			}
			case "hash_40380537847df901":
			{
				dialogkey = playerbundle.sparrowweaponuse;
				break;
			}
		}
		if(isdefined(dialogkey))
		{
			self thread function_a48c33ff(dialogkey, 2, undefined, undefined);
			dialogkey = undefined;
		}
	}
}

/*
	Name: dialog_chance
	Namespace: battlechatter
	Checksum: 0x8145AD4F
	Offset: 0x2860
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
	Name: mpdialog_value
	Namespace: battlechatter
	Checksum: 0x92389948
	Offset: 0x28E8
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
	Name: pain_vox
	Namespace: battlechatter
	Checksum: 0xB79FE15D
	Offset: 0x2978
	Size: 0x336
	Parameters: 2
	Flags: Linked
*/
function pain_vox(meansofdeath, weapon)
{
	if(self.var_f16a71ae === 1)
	{
		return;
	}
	if(meansofdeath == "MOD_DEATH_CIRCLE" || meansofdeath == "MOD_BLED_OUT")
	{
		return;
	}
	bundlename = self getmpdialogname();
	if(!isdefined(bundlename))
	{
		return;
	}
	playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
	if(!isdefined(playerbundle))
	{
		return;
	}
	if(dialog_chance("smallPainChance"))
	{
		if(meansofdeath == "MOD_DROWN")
		{
			dialogkey = playerbundle.exertpaindrowning;
			self.voxdrowning = 1;
		}
		else
		{
			if(meansofdeath == "MOD_DOT" || meansofdeath == "MOD_DOT_SELF")
			{
				if(!isdefined(self.var_dbffaa32))
				{
					return;
				}
				if(isdefined(weapon))
				{
					if(weapon.doesfiredamage)
					{
						dialogkey = playerbundle.var_c3b67de0;
					}
				}
				else
				{
					dialogkey = playerbundle.exertpaindamagetick;
				}
			}
			else
			{
				if(meansofdeath == "MOD_FALLING")
				{
					if(self hasperk(#"specialty_quieter"))
					{
						return;
					}
					dialogkey = playerbundle.exertpainfalling;
				}
				else
				{
					if(meansofdeath == "MOD_BURNED")
					{
						dialogkey = playerbundle.var_c3b67de0;
					}
					else
					{
						if(meansofdeath == "MOD_ELECTROCUTED")
						{
							dialogkey = playerbundle.var_68bb30c1;
						}
						else
						{
							if(self isplayerunderwater())
							{
								dialogkey = playerbundle.exertpainunderwater;
							}
							else
							{
								if(meansofdeath == "MOD_MELEE")
								{
									dialogkey = playerbundle.var_b801796c;
								}
								else
								{
									if(isdefined(weapon))
									{
										if(weapon.name == "shock_rifle")
										{
											dialogkey = playerbundle.exertdeathelectrocuted;
										}
									}
									if(!isdefined(dialogkey))
									{
										dialogkey = playerbundle.exertpain;
									}
								}
							}
						}
					}
				}
			}
		}
		exertbuffer = mpdialog_value("playerExertBuffer", 0);
		if(isdefined(self.var_1ba38d8b) && (gettime() - self.var_1ba38d8b) < (int(exertbuffer * 1000)))
		{
			return;
		}
		self thread function_a48c33ff(dialogkey, 30, exertbuffer);
		self.var_6765d33e = 1;
		self.var_1ba38d8b = gettime();
	}
}

/*
	Name: function_78c16252
	Namespace: battlechatter
	Checksum: 0xC418B2BF
	Offset: 0x2CB8
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function function_78c16252()
{
	bundlename = self getmpdialogname();
	if(!isdefined(bundlename))
	{
		return;
	}
	playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
	if(!isdefined(playerbundle))
	{
		return;
	}
	dialogkey = playerbundle.exertfullyhealedbreath;
	if(isdefined(dialogkey))
	{
		self thread function_a48c33ff(dialogkey, 16);
	}
}

/*
	Name: on_player_suicide_or_team_kill
	Namespace: battlechatter
	Checksum: 0xFB7136AF
	Offset: 0x2D60
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function on_player_suicide_or_team_kill(player, type)
{
	self endon(#"death");
	level endon(#"game_ended");
	waittillframeend();
	if(!level.teambased)
	{
		return;
	}
}

/*
	Name: on_player_near_explodable
	Namespace: battlechatter
	Checksum: 0x4D751DE8
	Offset: 0x2DB8
	Size: 0x3A
	Parameters: 2
	Flags: Linked
*/
function on_player_near_explodable(object, type)
{
	self endon(#"death");
	level endon(#"game_ended");
}

/*
	Name: function_551980b7
	Namespace: battlechatter
	Checksum: 0x727E57A4
	Offset: 0x2E00
	Size: 0x2EC
	Parameters: 1
	Flags: Linked
*/
function function_551980b7(dialogname)
{
	if(!level.allowspecialistdialog || !isdefined(dialogname))
	{
		return;
	}
	if(!isdefined(self) || !isplayer(self))
	{
		return;
	}
	bundlename = self getmpdialogname();
	if(!isdefined(bundlename))
	{
		return;
	}
	playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
	if(!isdefined(playerbundle))
	{
		return;
	}
	switch(dialogname)
	{
		case "battery":
		{
			dialogkey = playerbundle.var_15dfa8ec;
			break;
		}
		case "buffassault":
		{
			dialogkey = playerbundle.var_f33cef89;
			break;
		}
		case "engineer":
		{
			dialogkey = playerbundle.var_41e91a42;
			break;
		}
		case "firebreak":
		{
			dialogkey = playerbundle.var_f671ae19;
			break;
		}
		case "nomad":
		{
			dialogkey = playerbundle.var_928f03c4;
			break;
		}
		case "outrider":
		{
			dialogkey = playerbundle.var_decbe599;
			break;
		}
		case "prophet":
		{
			dialogkey = playerbundle.var_443d5083;
			break;
		}
		case "reaper":
		{
			dialogkey = playerbundle.var_a8809c1c;
			break;
		}
		case "recon":
		{
			dialogkey = playerbundle.var_f3745d99;
			break;
		}
		case "ruin":
		{
			dialogkey = playerbundle.var_1bfb0e39;
			break;
		}
		case "seraph":
		{
			dialogkey = playerbundle.var_f072d2d2;
			break;
		}
		case "spectre":
		{
			dialogkey = playerbundle.var_5fdf57ca;
			break;
		}
		case "swatpolice":
		{
			dialogkey = playerbundle.var_aa447d74;
			break;
		}
		case "zero":
		{
			dialogkey = playerbundle.var_53f12400;
			break;
		}
	}
	if(isdefined(dialogkey))
	{
		self thread function_a48c33ff(dialogkey, 2, undefined, undefined);
	}
}

/*
	Name: function_7139078d
	Namespace: battlechatter
	Checksum: 0x53D87648
	Offset: 0x30F8
	Size: 0x3A6
	Parameters: 0
	Flags: Linked
*/
function function_7139078d()
{
	self endon(#"death", #"disconnect");
	level endon(#"game_ended");
	self notify("6b96a91e5ff2b8a7");
	self endon("6b96a91e5ff2b8a7");
	while(true)
	{
		result = undefined;
		result = self waittill(#"bulletwhizby");
		if(self hasperk(#"specialty_quieter"))
		{
			continue;
		}
		if(!isdefined(result.suppressor) || (isdefined(result.suppressor.suppressor.var_87b1ba00) ? result.suppressor.var_87b1ba00 : 0))
		{
			continue;
		}
		if(isdefined(result.suppressor.currentweapon) && isplayer(result.suppressor))
		{
			bundlename = self getmpdialogname();
			if(!isdefined(bundlename))
			{
				continue;
			}
			playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
			if(!isdefined(playerbundle))
			{
				continue;
			}
			switch(result.suppressor.currentweapon.name)
			{
				case "hero_annihilator":
				{
					dialogkey = playerbundle.var_93ef961;
					break;
				}
			}
		}
		else
		{
			if(isdefined(result.suppressor.turretweapon))
			{
				if(result.suppressor.turretweapon.name == #"hash_36a6454f13b54f18")
				{
					result.suppressor.var_87b1ba00 = 1;
					self play_killstreak_threat(result.suppressor.killstreaktype);
				}
			}
			else if(isdefined(result.suppressor.weapon))
			{
				if(isdefined(level.var_24de8afe) && isdefined(result.suppressor.ai) && (isdefined(result.suppressor.ai.swat_gunner) && result.suppressor.ai.swat_gunner) && result.suppressor.weapon.name == #"hash_6c1be4b025206124")
				{
					result.suppressor [[level.var_24de8afe]](self, result.suppressor.script_owner);
					result.suppressor.var_87b1ba00 = 1;
				}
			}
		}
		if(!isdefined(dialogkey))
		{
			continue;
		}
		self thread function_a48c33ff(dialogkey, 2, undefined, undefined);
		dialogkey = undefined;
	}
}

/*
	Name: function_bd715920
	Namespace: battlechatter
	Checksum: 0xFE634EFD
	Offset: 0x34A8
	Size: 0x6FA
	Parameters: 5
	Flags: Linked
*/
function function_bd715920(var_28b40381, attacker, var_87017634, var_d963f0cf, timedelay)
{
	if(!level.allowspecialistdialog || !isdefined(self) || !isplayer(self))
	{
		return;
	}
	if((isdefined(self.var_87b1ba00) ? self.var_87b1ba00 : 0) || (isdefined(var_d963f0cf.var_87b1ba00) ? var_d963f0cf.var_87b1ba00 : 0) || !isdefined(var_28b40381))
	{
		return;
	}
	switch(var_28b40381.name)
	{
		case "sig_buckler_dw":
		case "gadget_vision_pulse":
		case "sig_buckler_turret":
		{
			var_4a247dec = 1;
			break;
		}
		case "eq_tripwire":
		case "hash_f525ab9cc66c061":
		case "gadget_supplypod":
		case "hash_21b346649d376bf3":
		case "dog_ai_defaultmelee":
		case "eq_concertina_wire":
		case "trophy_system":
		{
			var_2f741f8e = 1;
			break;
		}
		case "eq_hawk":
		case "frag_grenade":
		case "eq_swat_grenade":
		case "hash_3f62a872201cd1ce":
		case "hash_5825488ac68418af":
		case "eq_cluster_semtex_grenade":
		case "eq_slow_grenade":
		case "eq_molotov":
		case "concussion_grenade":
		{
			var_4a247dec = 1;
			var_2f741f8e = 1;
			break;
		}
		case "hero_flamethrower":
		case "gadget_radiation_field":
		{
			var_4e424b8b = 1;
			break;
		}
		case "ability_smart_cover":
		case "sig_blade":
		case "hash_4bb2d7f789b561eb":
		{
			var_2f741f8e = 1;
			var_4e424b8b = 0;
			var_494ab587 = 1;
			break;
		}
		default:
		{
			return;
		}
	}
	if((isdefined(var_4a247dec) ? var_4a247dec : 0))
	{
		if(isdefined(attacker) && isplayer(attacker) && !attacker hasperk(#"specialty_quieter"))
		{
			if((isdefined(var_2f741f8e) ? var_2f741f8e : 0))
			{
				var_d963f0cf.var_87b1ba00 = 1;
			}
			else
			{
				self.var_87b1ba00 = 1;
			}
			attacker function_95e44f78(var_28b40381, timedelay);
			return;
		}
	}
	else if(isdefined(var_87017634))
	{
		players = self getenemies();
		allyradius = mpdialog_value("enemyContactAllyRadius", 0);
		enemydistance = mpdialog_value("enemyContactDistance", 0);
		foreach(player in players)
		{
			if(!isplayer(player) || player hasperk(#"specialty_quieter"))
			{
				continue;
			}
			if(isdefined(attacker) && isplayer(attacker) && player == attacker)
			{
				continue;
			}
			if((isdefined(var_4e424b8b) ? var_4e424b8b : 0))
			{
				if(distancesquared(var_87017634, player.origin) < allyradius * allyradius)
				{
					if((isdefined(var_494ab587) ? var_494ab587 : 0))
					{
						relativepos = vectornormalize(player.origin - var_87017634);
						dir = anglestoforward(self getplayerangles());
						dotproduct = vectordot(relativepos, dir);
						if(dotproduct > 0)
						{
							continue;
						}
					}
					else
					{
						continue;
					}
				}
			}
			if(distancesquared(var_87017634, player.origin) > enemydistance * enemydistance)
			{
				continue;
			}
			eyepoint = player geteye();
			relativepos = vectornormalize(var_87017634 - eyepoint);
			dir = anglestoforward(player getplayerangles());
			dotproduct = vectordot(relativepos, dir);
			if(dotproduct > 0)
			{
				if(sighttracepassed(var_87017634, eyepoint, 1, player, var_d963f0cf))
				{
					if((isdefined(var_2f741f8e) ? var_2f741f8e : 0))
					{
						var_d963f0cf.var_87b1ba00 = 1;
					}
					else
					{
						self.var_87b1ba00 = 1;
					}
					player function_95e44f78(var_28b40381, timedelay);
					return;
				}
			}
		}
	}
}

/*
	Name: function_95e44f78
	Namespace: battlechatter
	Checksum: 0x5A203E53
	Offset: 0x3BB0
	Size: 0x4A4
	Parameters: 2
	Flags: Linked, Private
*/
function private function_95e44f78(weapon, timedelay)
{
	bundlename = self getmpdialogname();
	if(!isdefined(bundlename))
	{
		return;
	}
	playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
	if(!isdefined(playerbundle))
	{
		return;
	}
	switch(weapon.name)
	{
		case "sig_buckler_dw":
		case "sig_buckler_turret":
		{
			dialogkey = playerbundle.var_fa5db24c;
			break;
		}
		case "eq_concertina_wire":
		{
			dialogkey = playerbundle.var_b51a051a;
			break;
		}
		case "eq_slow_grenade":
		case "concussion_grenade":
		{
			dialogkey = playerbundle.var_b5677849;
			break;
		}
		case "hash_52aca7c35be649b8":
		case "gadget_cleanse":
		{
			dialogkey = playerbundle.var_d04c6a79;
			break;
		}
		case "dog_ai_defaultmelee":
		{
			dialogkey = playerbundle.var_35e44265;
			break;
		}
		case "eq_swat_grenade":
		case "hash_3f62a872201cd1ce":
		case "hash_5825488ac68418af":
		{
			dialogkey = playerbundle.var_29a98af1;
			break;
		}
		case "frag_grenade":
		{
			dialogkey = playerbundle.var_1d37ae8b;
			break;
		}
		case "hash_4bb2d7f789b561eb":
		{
			dialogkey = playerbundle.var_1d06de0e;
			break;
		}
		case "hero_flamethrower":
		{
			dialogkey = playerbundle.var_3f4a1443;
			break;
		}
		case "gadget_radiation_field":
		{
			dialogkey = playerbundle.var_e6d1c1e3;
			break;
		}
		case "ability_smart_cover":
		{
			dialogkey = playerbundle.var_efb67b32;
			break;
		}
		case "gadget_supplypod":
		{
			dialogkey = playerbundle.var_2339275b;
			break;
		}
		case "trophy_system":
		{
			dialogkey = playerbundle.var_d3d0cdde;
			break;
		}
		case "gadget_vision_pulse":
		{
			dialogkey = playerbundle.var_23824a56;
			break;
		}
		case "eq_cluster_semtex_grenade":
		{
			dialogkey = playerbundle.var_606d0b06;
			break;
		}
		case "eq_tripwire":
		{
			dialogkey = playerbundle.var_6f89cd5;
			break;
		}
		case "gadget_spawnbeacon":
		{
			dialogkey = playerbundle.var_1b7e4074;
			break;
		}
		case "eq_molotov":
		{
			dialogkey = playerbundle.var_c4b4c50e;
			break;
		}
		case "hash_21b346649d376bf3":
		{
			dialogkey = playerbundle.var_27b0d135;
			break;
		}
		case "gadget_icepick":
		{
			dialogkey = playerbundle.var_e21e8b0a;
			break;
		}
		case "eq_hawk":
		{
			dialogkey = playerbundle.var_f1416960;
			break;
		}
		case "sig_blade":
		{
			dialogkey = playerbundle.var_4ef902be;
			break;
		}
		case "eq_smoke":
		{
			dialogkey = playerbundle.var_cfc7adfb;
			break;
		}
		case "sig_lmg":
		{
			dialogkey = playerbundle.var_b50819f2;
			break;
		}
		case "hash_f525ab9cc66c061":
		{
			dialogkey = playerbundle.var_c41dc169;
			break;
		}
		default:
		{
			return;
		}
	}
	self thread function_5896274(timedelay, dialogkey, 2, undefined, undefined, "disconnect");
}

/*
	Name: enemy_threat
	Namespace: battlechatter
	Checksum: 0xEA7D96B1
	Offset: 0x4060
	Size: 0x52E
	Parameters: 0
	Flags: Linked
*/
function enemy_threat()
{
	self endon(#"death");
	level endon(#"game_ended");
	while(true)
	{
		self waittill(#"weapon_ads");
		if(self hasperk(#"specialty_quieter"))
		{
			continue;
		}
		if((self.enemythreattime + (int(mpdialog_value("enemyContactInterval", 0) * 1000))) >= gettime())
		{
			continue;
		}
		eyepoint = self geteye();
		dir = anglestoforward(self getplayerangles());
		dir = dir * mpdialog_value("enemyContactDistance", 0);
		endpoint = eyepoint + dir;
		traceresult = bullettrace(eyepoint, endpoint, 1, self);
		if(isdefined(traceresult[#"entity"]) && util::function_fbce7263(traceresult[#"entity"].team, self.team))
		{
			if(traceresult[#"entity"].classname == "player")
			{
				if(!traceresult[#"entity"].var_9ee835dc === 1)
				{
					playerweapon = undefined;
					if(isdefined(traceresult[#"entity"].weapon))
					{
						playerweapon = traceresult[#"entity"].weapon;
					}
					else if(isdefined(traceresult[#"entity"].currentweapon))
					{
						playerweapon = traceresult[#"entity"].currentweapon;
					}
					if(isdefined(traceresult[#"entity"].killstreaktype) && !isarray(traceresult[#"entity"].killstreaktype))
					{
						self play_killstreak_threat(traceresult[#"entity"].killstreaktype);
						traceresult[#"entity"].var_9ee835dc = 1;
						self.enemythreattime = gettime();
					}
					else
					{
						if(isdefined(playerweapon) && (isplayer(traceresult[#"entity"]) || isdefined(traceresult[#"entity"].owner)))
						{
							var_24d3b6ca = (isplayer(traceresult[#"entity"]) ? traceresult[#"entity"] : traceresult[#"entity"].owner);
							var_24d3b6ca function_bd715920(playerweapon, self, traceresult[#"entity"].origin, traceresult[#"entity"]);
							traceresult[#"entity"].var_9ee835dc = 1;
							self.enemythreattime = gettime();
						}
						else if(dialog_chance("enemyContactChance"))
						{
							if(dialog_chance("enemyHeroContactChance"))
							{
								self function_551980b7(traceresult[#"entity"] getmpdialogname());
							}
							else
							{
								self thread play_dialog("threatInfantry", 2);
							}
							level notify(#"level_enemy_spotted", self.team);
							self.enemythreattime = gettime();
						}
					}
				}
			}
		}
	}
}

/*
	Name: killed_by_sniper
	Namespace: battlechatter
	Checksum: 0x91D9224D
	Offset: 0x4598
	Size: 0x2E6
	Parameters: 1
	Flags: Linked
*/
function killed_by_sniper(sniper)
{
	if(!isdefined(sniper) || !isdefined(self) || !level.teambased || !level.allowspecialistdialog)
	{
		return;
	}
	self endon(#"disconnect");
	sniper endon(#"disconnect");
	level endon(#"game_ended");
	waittillframeend();
	if(dialog_chance("sniperKillChance"))
	{
		closest_ally = self get_closest_player_ally(0);
		allyradius = mpdialog_value("sniperKillAllyRadius", 0);
		if(isdefined(closest_ally) && distancesquared(self.origin, closest_ally.origin) < (allyradius * allyradius))
		{
			bundlename = closest_ally getmpdialogname();
			if(!isdefined(bundlename))
			{
				return;
			}
			playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
			if(!isdefined(playerbundle))
			{
				return;
			}
			closest_ally thread function_a48c33ff(playerbundle.threatsniper, 2);
			sniper.spottedtime = gettime();
			sniper.spottedby = [];
			players = self get_friendly_players();
			players = arraysort(players, self.origin);
			voiceradius = mpdialog_value("playerVoiceRadius", 0);
			voiceradiussq = voiceradius * voiceradius;
			foreach(player in players)
			{
				if(distancesquared(closest_ally.origin, player.origin) <= voiceradiussq)
				{
					sniper.spottedby[sniper.spottedby.size] = player;
				}
			}
		}
	}
}

/*
	Name: function_d804d2f0
	Namespace: battlechatter
	Checksum: 0x678AED65
	Offset: 0x4888
	Size: 0x1C2
	Parameters: 3
	Flags: Linked
*/
function function_d804d2f0(var_70b80ca6, player, allyradiussq)
{
	if(!isdefined(player) || !isdefined(player.origin) || !isdefined(var_70b80ca6) || !isdefined(var_70b80ca6.origin) || !isalive(player) || player.sessionstate != "playing" || player.playingdialog || player isplayerunderwater() || player isremotecontrolling() || player isinvehicle() || player isweaponviewonlylinked() || player == var_70b80ca6 || player.team != var_70b80ca6.team || player.playerrole == var_70b80ca6.playerrole || player hasperk(#"specialty_quieter"))
	{
		return false;
	}
	distsq = distancesquared(var_70b80ca6.origin, player.origin);
	if(distsq > allyradiussq)
	{
		return false;
	}
	return true;
}

/*
	Name: function_db89c38f
	Namespace: battlechatter
	Checksum: 0x4F28C9C2
	Offset: 0x4A58
	Size: 0xFC
	Parameters: 2
	Flags: None
*/
function function_db89c38f(var_70b80ca6, allyradiussq)
{
	allies = [];
	foreach(player in level.players)
	{
		if(!function_d804d2f0(var_70b80ca6, player, allyradiussq))
		{
			continue;
		}
		allies[allies.size] = player;
	}
	allies = arraysort(allies, var_70b80ca6.origin);
	if(!isdefined(allies) || allies.size == 0)
	{
		return undefined;
	}
	return allies[0];
}

/*
	Name: function_e6457410
	Namespace: battlechatter
	Checksum: 0x61B61C
	Offset: 0x4B60
	Size: 0x994
	Parameters: 4
	Flags: Linked
*/
function function_e6457410(attacker, victim, weapon, inflictor)
{
	if(!isdefined(attacker) || !isplayer(attacker) || attacker hasperk(#"specialty_quieter"))
	{
		return false;
	}
	if(!isdefined(weapon) || !isplayer(victim))
	{
		return false;
	}
	var_17a094cf = undefined;
	var_cf38843b = undefined;
	mpdialog = struct::get_script_bundle("mpdialog", "mpdialog_default");
	if(!isdefined(mpdialog))
	{
		mpdialog = spawnstruct();
	}
	relativepos = vectornormalize(victim.origin - attacker.origin);
	dir = anglestoforward(attacker getplayerangles());
	dotproduct = vectordot(dir, relativepos);
	switch(weapon.name)
	{
		case "hero_annihilator":
		{
			attacker.var_3528f7e9 = (isdefined(attacker.var_3528f7e9) ? attacker.var_3528f7e9 : 0) + 1;
			if(attacker.var_3528f7e9 == (isdefined(mpdialog.var_6bb5d97b) ? mpdialog.var_6bb5d97b : 0))
			{
				var_17a094cf = 1;
			}
			break;
		}
		case "sig_buckler_dw":
		case "sig_buckler_turret":
		{
			attacker.var_3528f7e9 = (isdefined(attacker.var_3528f7e9) ? attacker.var_3528f7e9 : 0) + 1;
			if(attacker.var_3528f7e9 == (isdefined(mpdialog.var_a4237278) ? mpdialog.var_a4237278 : 0))
			{
				var_17a094cf = 1;
			}
			break;
		}
		case "claymore":
		{
			if(dotproduct > 0 && sighttracepassed(attacker geteye(), victim geteye(), 1, attacker, victim))
			{
				var_17a094cf = 1;
			}
			break;
		}
		case "dog_ai_defaultmelee":
		{
			if(!isdefined(inflictor))
			{
				return;
			}
			inflictor.var_3528f7e9 = (isdefined(inflictor.var_3528f7e9) ? inflictor.var_3528f7e9 : 0) + 1;
			if(!isdefined(inflictor.var_9b453b02) && inflictor.var_3528f7e9 > (isdefined(mpdialog.var_fad241c2) ? mpdialog.var_fad241c2 : 0) && dotproduct > 0 && sighttracepassed(attacker geteye(), victim geteye(), 1, attacker, victim))
			{
				var_17a094cf = 1;
				inflictor.var_9b453b02 = 1;
			}
			break;
		}
		case "hero_flamethrower":
		{
			attacker.var_3528f7e9 = (isdefined(attacker.var_3528f7e9) ? attacker.var_3528f7e9 : 0) + 1;
			if(attacker.var_3528f7e9 == (isdefined(mpdialog.var_f221b000) ? mpdialog.var_f221b000 : 0))
			{
				var_17a094cf = 1;
			}
			break;
		}
		case "hash_4bb2d7f789b561eb":
		{
			attacker.var_3528f7e9 = (isdefined(attacker.var_3528f7e9) ? attacker.var_3528f7e9 : 0) + 1;
			if(attacker.var_3528f7e9 == (isdefined(mpdialog.var_b7ee7b18) ? mpdialog.var_b7ee7b18 : 0))
			{
				var_17a094cf = 1;
			}
			break;
		}
		case "gun_mini_turret":
		{
			if(!isdefined(inflictor))
			{
				return;
			}
			inflictor.var_3528f7e9 = (isdefined(inflictor.var_3528f7e9) ? inflictor.var_3528f7e9 : 0) + 1;
			if(!isdefined(inflictor.var_9b453b02) && inflictor.var_3528f7e9 > (isdefined(mpdialog.var_34807e8c) ? mpdialog.var_34807e8c : 0) && dotproduct > 0 && sighttracepassed(attacker geteye(), victim geteye(), 1, attacker, victim))
			{
				var_17a094cf = 1;
				inflictor.var_9b453b02 = 1;
			}
			break;
		}
		case "hash_40380537847df901":
		{
			attacker.var_3528f7e9 = (isdefined(attacker.var_3528f7e9) ? attacker.var_3528f7e9 : 0) + 1;
			if(attacker.var_3528f7e9 == (isdefined(mpdialog.var_269d71a4) ? mpdialog.var_269d71a4 : 0))
			{
				var_17a094cf = 1;
			}
			break;
		}
		case "sig_lmg":
		case "hash_772f4afd37e876a1":
		{
			attacker.var_eefb1fd3 = (isdefined(attacker.var_eefb1fd3) ? attacker.var_eefb1fd3 : 0) + 1;
			if(attacker.var_eefb1fd3 == (isdefined(mpdialog.var_2c044553) ? mpdialog.var_2c044553 : 0))
			{
				var_17a094cf = 1;
			}
			break;
		}
		case "shock_rifle":
		{
			attacker.var_3528f7e9 = (isdefined(attacker.var_3528f7e9) ? attacker.var_3528f7e9 : 0) + 1;
			if(attacker.var_3528f7e9 == (isdefined(mpdialog.var_9460505c) ? mpdialog.var_9460505c : 0))
			{
				var_17a094cf = 1;
			}
			break;
		}
		case "eq_tripwire":
		{
			if(dotproduct > 0 && sighttracepassed(attacker geteye(), victim geteye(), 1, attacker, victim))
			{
				var_17a094cf = 1;
			}
			break;
		}
		case "hero_pineapplegun":
		{
			attacker.var_3528f7e9 = (isdefined(attacker.var_3528f7e9) ? attacker.var_3528f7e9 : 0) + 1;
			if(attacker.var_3528f7e9 == (isdefined(mpdialog.var_902e1bba) ? mpdialog.var_902e1bba : 0))
			{
				var_17a094cf = 1;
			}
			break;
		}
		case "sig_blade":
		{
			attacker.var_3528f7e9 = (isdefined(attacker.var_3528f7e9) ? attacker.var_3528f7e9 : 0) + 1;
			if(attacker.var_3528f7e9 == (isdefined(mpdialog.var_66388426) ? mpdialog.var_66388426 : 0))
			{
				var_17a094cf = 1;
			}
			break;
		}
		default:
		{
			break;
		}
	}
	if(isdefined(var_17a094cf))
	{
		attacker function_18aba49d(0, weapon, undefined);
		return true;
	}
	return false;
}

/*
	Name: player_killed
	Namespace: battlechatter
	Checksum: 0xFBB5A158
	Offset: 0x5500
	Size: 0x28C
	Parameters: 5
	Flags: Linked
*/
function player_killed(attacker, killstreaktype, einflictor, weapon, mod)
{
	if(!level.teambased || !level.allowspecialistdialog)
	{
		return;
	}
	if(self === attacker)
	{
		return;
	}
	waittillframeend();
	if(isdefined(attacker) && isplayer(attacker) && !attacker hasperk(#"specialty_quieter"))
	{
		if(weapon.name == #"dog_ai_defaultmelee" && isdefined(einflictor))
		{
			attacker function_bd715920(weapon, self, einflictor.origin, einflictor);
		}
		else if(weapon.name == #"hero_flamethrower" || weapon.name == #"sig_blade")
		{
			attacker function_bd715920(weapon, self, attacker.origin, attacker);
		}
	}
	if(isdefined(killstreaktype))
	{
		if(!isdefined(level.killstreaks[killstreaktype]) || !isdefined(level.killstreaks[killstreaktype].threatonkill) || !level.killstreaks[killstreaktype].threatonkill || !dialog_chance("killstreakKillChance"))
		{
			return;
		}
		ally = self get_closest_player_ally(0);
		allyradius = mpdialog_value("killstreakKillAllyRadius", 0);
		if(isdefined(ally) && distancesquared(self.origin, ally.origin) < (allyradius * allyradius))
		{
			ally play_killstreak_threat(killstreaktype);
		}
	}
}

/*
	Name: function_7c107ed4
	Namespace: battlechatter
	Checksum: 0x4D33BAD4
	Offset: 0x5798
	Size: 0x2FE
	Parameters: 4
	Flags: Linked
*/
function function_7c107ed4(attacker, weapon, victim, inflictor)
{
	if(!dialog_chance("specialKillChance") || !isdefined(victim))
	{
		return undefined;
	}
	dialogkey = undefined;
	if(isdefined(victim.currentweapon) && isdefined(victim.currentweapon.name))
	{
		switch(victim.currentweapon.name)
		{
			case "hero_annihilator":
			{
				dialogkey = "annihilatorDestroyed";
				break;
			}
			case "sig_buckler_dw":
			case "sig_buckler_turret":
			{
				dialogkey = "battleShieldWeaponDestroyed";
				break;
			}
			case "hash_40380537847df901":
			{
				dialogkey = "sparrowWeaponDestroyed";
				break;
			}
			case "hero_pineapplegun":
			{
				dialogkey = "warmachineWeaponDestroyed";
				break;
			}
			case "shock_rifle":
			{
				dialogkey = "tempestWeaponDestroyed";
				break;
			}
			case "hero_flamethrower":
			{
				dialogkey = "purifierWeaponDestroyed";
				break;
			}
			case "gadget_icepick":
			{
				dialogkey = "icePickWeaponDestroyed";
				break;
			}
			case "sig_blade":
			{
				dialogkey = "armBladeWeaponDestroyed";
				break;
			}
			case "sig_lmg":
			case "hash_772f4afd37e876a1":
			{
				dialogkey = "scytheWeaponDestroyed";
				break;
			}
		}
	}
	if(!isdefined(dialogkey) && isdefined(victim.heroability) && isdefined(victim.heroability.name))
	{
		heroabilitywasactiverecently = isdefined(victim.heroabilityactive) || (isdefined(victim.heroabilitydectivatetime) && victim.heroabilitydectivatetime > (gettime() - 3000));
		if(heroabilitywasactiverecently)
		{
			switch(victim.heroability.name)
			{
				case "hash_4bb2d7f789b561eb":
				{
					dialogkey = "gravitySlamWeaponDestroyed";
					break;
				}
				case "hash_3a19c6a9c8caef33":
				{
					dialogkey = "grappleGunWeaponDestroyed";
					break;
				}
				case "gadget_radiation_field":
				{
					dialogkey = "radiationFieldWeaponDestroyed";
					break;
				}
			}
		}
	}
	return dialogkey;
}

/*
	Name: function_a43a3519
	Namespace: battlechatter
	Checksum: 0xAD7F8845
	Offset: 0x5AA0
	Size: 0x23C
	Parameters: 2
	Flags: Linked
*/
function function_a43a3519(waittime, gadgetweapon)
{
	wait(waittime + 0.1);
	if(!isdefined(self) || !isdefined(self.var_f6201e80) || !isplayer(self.var_f6201e80) || self.var_f6201e80 hasperk(#"specialty_quieter"))
	{
		return;
	}
	while(self.var_f6201e80.playingdialog === 1)
	{
		wait(0.3);
		if(!isdefined(self) || !isdefined(self.var_f6201e80))
		{
			return;
		}
	}
	allyradiussq = mpdialog_value("SuccessReactionRadius", 500) * mpdialog_value("SuccessReactionRadius", 500);
	if(isdefined(self.var_f6201e80) && function_d804d2f0(self, self.var_f6201e80, allyradiussq))
	{
		var_8a6b001a = self.var_f6201e80;
	}
	if(!isdefined(var_8a6b001a))
	{
		return;
	}
	bundlename = var_8a6b001a getmpdialogname();
	if(!isdefined(bundlename))
	{
		return;
	}
	playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
	if(!isdefined(playerbundle))
	{
		return;
	}
	switch(gadgetweapon.name)
	{
		case "hash_638e1f0905f293cf":
		{
			dialogkey = playerbundle.var_9b5a2501;
			break;
		}
		default:
		{
			return;
		}
	}
	if(isdefined(dialogkey))
	{
		var_8a6b001a function_a48c33ff(dialogkey, 2, undefined, undefined);
	}
}

/*
	Name: function_f5c48bfa
	Namespace: battlechatter
	Checksum: 0x1D468F6
	Offset: 0x5CE8
	Size: 0x3EC
	Parameters: 4
	Flags: Linked
*/
function function_f5c48bfa(attacker, owner, gadgetweapon, attackerweapon)
{
	if(!level.allowspecialistdialog || !isdefined(attacker) || !isplayer(attacker) || attacker hasperk(#"specialty_quieter"))
	{
		return;
	}
	if(!isdefined(gadgetweapon) || (isdefined(owner) && owner == attacker))
	{
		return;
	}
	if(isdefined(attackerweapon) && isdefined(killstreaks::get_from_weapon(attackerweapon)))
	{
		return;
	}
	bundlename = attacker getmpdialogname();
	if(!isdefined(bundlename))
	{
		return;
	}
	playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
	if(!isdefined(playerbundle))
	{
		return;
	}
	dialogkey = undefined;
	var_45a3f7df = 0;
	switch(gadgetweapon.name)
	{
		case "eq_sensor":
		{
			dialogkey = playerbundle.var_6f728fb2;
			break;
		}
		case "gadget_spawnbeacon":
		{
			dialogkey = playerbundle.var_d2fd550a;
			break;
		}
		case "claymore":
		{
			dialogkey = playerbundle.var_827669e9;
			break;
		}
		case "eq_concertina_wire":
		{
			dialogkey = playerbundle.var_e4bd50dc;
			break;
		}
		case "gun_mini_turret":
		{
			dialogkey = playerbundle.var_1b6223ae;
			break;
		}
		case "dog_ai_defaultmelee":
		{
			dialogkey = playerbundle.dogweapondestroyed;
			break;
		}
		case "hash_638e1f0905f293cf":
		{
			dialogkey = playerbundle.var_e79fdef1;
			var_45a3f7df = 1;
			break;
		}
		case "ability_smart_cover":
		{
			dialogkey = playerbundle.var_1ab815cb;
			break;
		}
		case "gadget_supplypod":
		{
			dialogkey = playerbundle.var_e5b03ad2;
			break;
		}
		case "eq_tripwire":
		{
			dialogkey = playerbundle.var_63661ff;
			break;
		}
		case "trophy_system":
		{
			dialogkey = playerbundle.var_faa66cb4;
			break;
		}
		case "hash_21b346649d376bf3":
		{
			dialogkey = playerbundle.var_bbc9856;
			break;
		}
		case "eq_hawk":
		{
			dialogkey = playerbundle.var_d11f02f1;
			break;
		}
		case "hash_f525ab9cc66c061":
		{
			dialogkey = playerbundle.var_987d028;
			break;
		}
		default:
		{
			return;
		}
	}
	attacker thread function_5896274(mpdialog_value("enemyKillDelay", 0), dialogkey, 2, undefined, undefined, "cancel_kill_dialog");
	if(var_45a3f7df)
	{
		attacker thread function_a43a3519(mpdialog_value("enemyKillDelay", 0), gadgetweapon);
	}
}

/*
	Name: say_kill_battle_chatter
	Namespace: battlechatter
	Checksum: 0x74A07E3D
	Offset: 0x60E0
	Size: 0x4C4
	Parameters: 5
	Flags: Linked
*/
function say_kill_battle_chatter(attacker, weapon, victim, inflictor, meansofdeath)
{
	if(!level.allowspecialistdialog)
	{
		return;
	}
	if(!isdefined(attacker) || !isplayer(attacker) || !isalive(attacker) || attacker isremotecontrolling() || attacker isinvehicle() || attacker isweaponviewonlylinked() || attacker hasperk(#"specialty_quieter") || !isdefined(victim) || !isplayer(victim))
	{
		return;
	}
	if(isdefined(meansofdeath) && (meansofdeath == "MOD_MELEE" && weapon.name != #"sig_blade") || meansofdeath == "MOD_MELEE_WEAPON_BUTT" && weapon != getweapon("dog_ai_defaultmelee"))
	{
		return;
	}
	if(isdefined(inflictor) && inflictor.classname != "worldspawn" && !isplayer(inflictor) && inflictor.birthtime < attacker.spawntime)
	{
		return;
	}
	if(isdefined(inflictor) && (isdefined(inflictor.var_259f6c17) && inflictor.var_259f6c17))
	{
		var_857133db = 1;
	}
	var_25db02aa = victim function_e6457410(attacker, victim, weapon, inflictor);
	if(var_25db02aa || weapon.skipbattlechatterkill)
	{
		return;
	}
	killdialog = function_7c107ed4(attacker, weapon, victim, inflictor);
	if(!isdefined(killdialog) && dialog_chance("enemyKillChance"))
	{
		if(isdefined(victim.spottedtime) && (victim.spottedtime + mpdialog_value("enemySniperKillTime", 0)) >= gettime() && array::contains(victim.spottedby, attacker) && dialog_chance("enemySniperKillChance"))
		{
			killdialog = attacker get_random_key("killSniper");
		}
		else
		{
			if(dialog_chance("enemyHeroKillChance"))
			{
				victimdialogname = victim getmpdialogname();
				if(isdefined(victimdialogname) && isdefined(level.bcsounds[#"kill_dialog"][victimdialogname]))
				{
					killdialog = attacker get_random_key(level.bcsounds[#"kill_dialog"][victimdialogname]);
				}
				else
				{
					killdialog = attacker get_random_key("killGeneric");
				}
			}
			else
			{
				killdialog = attacker get_random_key("killGeneric");
			}
		}
	}
	victim.spottedtime = undefined;
	victim.spottedby = undefined;
	if(!isdefined(killdialog) || (isdefined(var_857133db) ? var_857133db : 0))
	{
		return;
	}
	attacker thread wait_play_dialog(mpdialog_value("enemyKillDelay", 0), killdialog, 2, undefined, victim, "cancel_kill_dialog");
}

/*
	Name: grenade_tracking
	Namespace: battlechatter
	Checksum: 0xE1863ED2
	Offset: 0x65B0
	Size: 0x3F8
	Parameters: 0
	Flags: Linked
*/
function grenade_tracking()
{
	self endon(#"death");
	level endon(#"game_ended");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"grenade_fire");
		grenade = waitresult.projectile;
		weapon = waitresult.weapon;
		if(isdefined(weapon) && isdefined(weapon.name))
		{
			switch(weapon.name)
			{
				case "frag_grenade":
				case "eq_swat_grenade":
				case "hash_5825488ac68418af":
				case "eq_cluster_semtex_grenade":
				case "eq_slow_grenade":
				case "eq_molotov":
				case "concussion_grenade":
				{
					waitresult = undefined;
					waitresult = grenade waittilltimeout(0.3, #"death");
					if(waitresult._notify == "death" || !isdefined(grenade))
					{
						continue;
					}
					enemies = self function_bdda420f(grenade.origin, 250);
					if(isarray(enemies) && enemies.size > 0)
					{
						foreach(enemy in enemies)
						{
							if(!isplayer(enemy) || enemy hasperk(#"specialty_quieter"))
							{
								continue;
							}
							self function_bd715920(weapon, enemy, grenade.origin, grenade);
							continue;
						}
					}
				}
				default:
				{
					continue;
				}
			}
		}
		if(!isdefined(grenade.weapon) || !isdefined(grenade.weapon.rootweapon) || !dialog_chance("incomingProjectileChance"))
		{
			continue;
		}
		dialogkey = level.bcsounds[#"incoming_alert"][grenade.weapon.rootweapon.name];
		if(isdefined(dialogkey))
		{
			waittime = mpdialog_value(level.bcsounds[#"incoming_delay"][grenade.weapon.rootweapon.name], float(function_60d95f53()) / 1000);
			level thread incoming_projectile_alert(self, grenade, dialogkey, waittime);
		}
	}
}

/*
	Name: missile_tracking
	Namespace: battlechatter
	Checksum: 0x86DE8314
	Offset: 0x69B0
	Size: 0x1C8
	Parameters: 0
	Flags: Linked
*/
function missile_tracking()
{
	self endon(#"death");
	level endon(#"game_ended");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"missile_fire");
		missile = waitresult.projectile;
		weapon = waitresult.weapon;
		if(!isdefined(missile.item) || !isdefined(missile.item.rootweapon) || !dialog_chance("incomingProjectileChance"))
		{
			continue;
		}
		dialogkey = level.bcsounds[#"incoming_alert"][missile.item.rootweapon.name];
		if(isdefined(dialogkey))
		{
			waittime = mpdialog_value(level.bcsounds[#"incoming_delay"][missile.item.rootweapon.name], float(function_60d95f53()) / 1000);
			level thread incoming_projectile_alert(self, missile, dialogkey, waittime);
		}
	}
}

/*
	Name: incoming_projectile_alert
	Namespace: battlechatter
	Checksum: 0xDCB21221
	Offset: 0x6B80
	Size: 0x192
	Parameters: 4
	Flags: Linked
*/
function incoming_projectile_alert(thrower, projectile, dialogkey, waittime)
{
	level endon(#"game_ended");
	if(waittime <= 0)
	{
		/#
			assert(waittime > 0, "");
		#/
		return;
	}
	while(true)
	{
		wait(waittime);
		if(waittime > 0.2)
		{
			waittime = waittime / 2;
		}
		if(!isdefined(projectile))
		{
			return;
		}
		if(!isdefined(thrower) || thrower.team == #"spectator")
		{
			return;
		}
		if(level.players.size)
		{
			closest_enemy = thrower get_closest_player_enemy(projectile.origin);
			incomingprojectileradius = mpdialog_value("incomingProjectileRadius", 0);
			if(isdefined(closest_enemy) && distancesquared(projectile.origin, closest_enemy.origin) < (incomingprojectileradius * incomingprojectileradius))
			{
				closest_enemy thread play_dialog(dialogkey, 6);
				return;
			}
		}
	}
}

/*
	Name: sticky_grenade_tracking
	Namespace: battlechatter
	Checksum: 0x700B9C6E
	Offset: 0x6D20
	Size: 0x1F0
	Parameters: 0
	Flags: Linked
*/
function sticky_grenade_tracking()
{
	self endon(#"death");
	level endon(#"game_ended");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"grenade_stuck");
		grenade = waitresult.projectile;
		var_76d5e4ce = isalive(self) && isplayer(self) && !self hasperk(#"specialty_quieter");
		if(var_76d5e4ce && isdefined(grenade) && isdefined(grenade.weapon))
		{
			if(grenade.weapon.rootweapon.name == "sticky_grenade" || grenade.weapon.rootweapon.name == "eq_sticky_grenade" || grenade.weapon.rootweapon.name == "eq_cluster_semtex_grenade")
			{
				bundlename = self getmpdialogname();
				if(!isdefined(bundlename))
				{
					continue;
				}
				playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
				if(!isdefined(playerbundle))
				{
					continue;
				}
				self thread function_a48c33ff(playerbundle.stucksticky, 6);
			}
		}
	}
}

/*
	Name: heavy_weapon_success_reaction
	Namespace: battlechatter
	Checksum: 0x1E78670
	Offset: 0x6F18
	Size: 0x38C
	Parameters: 0
	Flags: None
*/
function heavy_weapon_success_reaction()
{
	self endon(#"death");
	level endon(#"game_ended");
	if(!level.teambased || !level.allowspecialistdialog)
	{
		return;
	}
	allies = [];
	allyradiussq = mpdialog_value("playerVoiceRadius", 0);
	allyradiussq = allyradiussq * allyradiussq;
	foreach(player in level.players)
	{
		if(!isdefined(player) || !isalive(player) || player.sessionstate != "playing" || player == self || player hasperk(#"specialty_quieter") || util::function_fbce7263(player.team, self.team))
		{
			continue;
		}
		distsq = distancesquared(self.origin, player.origin);
		if(distsq > allyradiussq)
		{
			continue;
		}
		allies[allies.size] = player;
	}
	wait(mpdialog_value("enemyKillDelay", 0) + 0.1);
	while(self.playingdialog)
	{
		wait(0.5);
	}
	allies = arraysort(allies, self.origin);
	foreach(player in allies)
	{
		if(!isalive(player) || player.sessionstate != "playing" || player.playingdialog || player isplayerunderwater() || player isremotecontrolling() || player isinvehicle() || player isweaponviewonlylinked())
		{
			continue;
		}
		distsq = distancesquared(self.origin, player.origin);
		if(distsq > allyradiussq)
		{
			break;
		}
		player play_dialog("heroWeaponSuccessReaction", 2);
		break;
	}
}

/*
	Name: play_promotion_reaction
	Namespace: battlechatter
	Checksum: 0x319334EB
	Offset: 0x72B0
	Size: 0x324
	Parameters: 0
	Flags: Linked
*/
function play_promotion_reaction()
{
	if(!level.allowspecialistdialog || !isdefined(self) || !isplayer(self) || self hasperk(#"specialty_quieter"))
	{
		return;
	}
	self endon(#"death");
	level endon(#"game_ended");
	if(!level.teambased)
	{
		return;
	}
	wait(9);
	players = self get_friendly_players();
	players = arraysort(players, self.origin);
	selfdialog = self getmpdialogname();
	voiceradius = mpdialog_value("playerVoiceRadius", 0);
	voiceradiussq = voiceradius * voiceradius;
	foreach(player in players)
	{
		if(player == self || player getmpdialogname() == selfdialog || !player can_play_dialog(1) || distancesquared(self.origin, player.origin) >= voiceradiussq || player hasperk(#"specialty_quieter"))
		{
			continue;
		}
		dialogalias = player get_player_dialog_alias("promotionReaction", undefined);
		if(!isdefined(dialogalias))
		{
			continue;
		}
		ally = player;
		break;
	}
	if(isdefined(ally))
	{
		if(ally haspart("J_Head"))
		{
			ally playsoundontag(dialogalias, "J_Head", undefined, self);
		}
		else
		{
			ally playsoundontag(dialogalias, "tag_origin", undefined, self);
		}
		ally thread wait_dialog_buffer(mpdialog_value("playerDialogBuffer", 0));
	}
}

/*
	Name: gametype_specific_battle_chatter
	Namespace: battlechatter
	Checksum: 0x2A8C776B
	Offset: 0x75E0
	Size: 0x3A
	Parameters: 2
	Flags: None
*/
function gametype_specific_battle_chatter(event, team)
{
	self endon(#"death");
	level endon(#"game_ended");
}

/*
	Name: play_death_vox
	Namespace: battlechatter
	Checksum: 0xB2B82C92
	Offset: 0x7628
	Size: 0x164
	Parameters: 4
	Flags: Linked
*/
function play_death_vox(body, attacker, weapon, meansofdeath)
{
	dialogkey = self get_death_vox(weapon, meansofdeath);
	if(function_8b1a219a())
	{
		playerbundle = self function_deea4cc2(meansofdeath);
		if(isdefined(playerbundle) && isdefined(dialogkey))
		{
			var_27e6026e = function_5d15920e(dialogkey, playerbundle);
			entitynumber = self getentitynumber();
			body function_661a6cc1(var_27e6026e, entitynumber);
		}
	}
	else if(isdefined(dialogkey))
	{
		if(body haspart("J_Head"))
		{
			body playsoundontag(dialogkey, "J_Head");
		}
		else
		{
			body playsoundontag(dialogkey, "tag_origin");
		}
	}
}

/*
	Name: function_deea4cc2
	Namespace: battlechatter
	Checksum: 0x1BC4E4B7
	Offset: 0x7798
	Size: 0xDA
	Parameters: 1
	Flags: Linked
*/
function function_deea4cc2(meansofdeath)
{
	bundlename = self getmpdialogname();
	if(!isdefined(bundlename))
	{
		return;
	}
	if(isdefined(meansofdeath) && meansofdeath == "MOD_META" && isdefined(self.pers) && (isdefined(self.pers[#"changed_specialist"]) ? self.pers[#"changed_specialist"] : 0))
	{
		bundlename = self.var_89c4a60f;
	}
	playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
	return playerbundle;
}

/*
	Name: function_5d15920e
	Namespace: battlechatter
	Checksum: 0xBB82E0EA
	Offset: 0x7880
	Size: 0x14E
	Parameters: 2
	Flags: Linked
*/
function function_5d15920e(dialogkey, playerbundle)
{
	if(dialogkey === playerbundle.exertdeathdrowned)
	{
		return "MOD_DROWN";
	}
	if(dialogkey === playerbundle.var_44d86dec)
	{
		return "MOD_EXPLOSIVE";
	}
	if(dialogkey === playerbundle.exertdeathburned)
	{
		return "MOD_BURNED";
	}
	if(dialogkey === playerbundle.exertdeathstabbed)
	{
		return "MOD_MELEE_WEAPON_BUTT";
	}
	if(dialogkey === playerbundle.var_207908de)
	{
		return "MOD_HEAD_SHOT";
	}
	if(dialogkey === playerbundle.var_1dfcabbd)
	{
		return "MOD_FALLING";
	}
	if(dialogkey === playerbundle.exertdeath)
	{
		return "MOD_UNKNOWN";
	}
	if(dialogkey === playerbundle.var_48305ed9)
	{
		return "MOD_DOT_SELF";
	}
	if(dialogkey === playerbundle.var_f8b4bcc1)
	{
		return "MOD_DOT";
	}
	if(dialogkey === playerbundle.exertdeathstabbed)
	{
		return "MOD_MELEE_ASSASSINATE";
	}
	if(dialogkey === playerbundle.exertdeathelectrocuted)
	{
		return "MOD_ELECTROCUTED";
	}
	return "MOD_UNKNOWN";
}

/*
	Name: get_death_vox
	Namespace: battlechatter
	Checksum: 0x6614E6D3
	Offset: 0x79D8
	Size: 0x3C6
	Parameters: 2
	Flags: Linked
*/
function get_death_vox(weapon, meansofdeath)
{
	bundlename = self getmpdialogname();
	if(!isdefined(bundlename))
	{
		return;
	}
	if(isdefined(meansofdeath) && meansofdeath == "MOD_META" && isdefined(self.pers) && (isdefined(self.pers[#"changed_specialist"]) ? self.pers[#"changed_specialist"] : 0))
	{
		bundlename = self.var_89c4a60f;
	}
	playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
	if(!isdefined(playerbundle))
	{
		return;
	}
	if(self isplayerunderwater())
	{
		return playerbundle.exertdeathdrowned;
	}
	if(self weapon_utils::isexplosivedamage(meansofdeath))
	{
		return playerbundle.var_44d86dec;
	}
	if(isdefined(meansofdeath))
	{
		switch(meansofdeath)
		{
			case "mod_burned":
			{
				return playerbundle.exertdeathburned;
			}
			case "mod_melee_weapon_butt":
			{
				if(weapon.rootweapon.name == #"ar_stealth_t8" || weapon.rootweapon.name == #"pistol_standard_t8")
				{
					if(weaponhasattachment(weapon, "uber"))
					{
						return playerbundle.exertdeathstabbed;
					}
				}
				return playerbundle.var_53f25688;
			}
			case "mod_head_shot":
			{
				return playerbundle.var_207908de;
			}
			case "mod_trigger_hurt":
			{
				if(self getvelocity()[2] < -100)
				{
					return playerbundle.var_1dfcabbd;
				}
				else
				{
					return playerbundle.exertdeath;
				}
			}
			case "mod_drown":
			{
				return playerbundle.exertdeathdrowned;
			}
			case "mod_dot":
			{
				if(weapon == getweapon(#"gadget_radiation_field"))
				{
					if(isdefined(self.suicide) && self.suicide)
					{
						return playerbundle.var_48305ed9;
					}
					else
					{
						return playerbundle.var_f8b4bcc1;
					}
				}
				if(weapon.doesfiredamage)
				{
					return playerbundle.exertdeathburned;
				}
				break;
			}
		}
	}
	if(isdefined(weapon) && meansofdeath !== "MOD_MELEE_WEAPON_BUTT")
	{
		switch(weapon.rootweapon.name)
		{
			case "knife_loadout":
			case "hatchet":
			{
				return playerbundle.exertdeathstabbed;
			}
			case "melee_slaybell_t8":
			{
				return playerbundle.var_53f25688;
			}
			case "shock_rifle":
			{
				return playerbundle.exertdeathelectrocuted;
			}
		}
	}
	return playerbundle.exertdeath;
}

/*
	Name: function_9a20c887
	Namespace: battlechatter
	Checksum: 0x367602D5
	Offset: 0x7DA8
	Size: 0x154
	Parameters: 1
	Flags: Linked
*/
function function_9a20c887(var_27347352)
{
	if(!level.allowspecialistdialog || !isdefined(self) || !isplayer(self) || self hasperk(#"specialty_quieter"))
	{
		return;
	}
	if(!isdefined(var_27347352) || !isdefined(self.team) || !isdefined(var_27347352.team) || !isdefined(var_27347352.killstreaktype))
	{
		return;
	}
	if(util::function_fbce7263(self.team, var_27347352.team) && (!(isdefined(var_27347352.var_9ee835dc) && var_27347352.var_9ee835dc)))
	{
		closest_ally = self get_closest_player_ally(0);
		if(!isdefined(closest_ally))
		{
			return;
		}
		var_27347352.var_9ee835dc = 1;
		self play_killstreak_threat(var_27347352.killstreaktype);
	}
}

/*
	Name: play_killstreak_threat
	Namespace: battlechatter
	Checksum: 0xA051D68F
	Offset: 0x7F08
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function play_killstreak_threat(killstreaktype)
{
	if(!level.allowspecialistdialog || !isdefined(self) || !isplayer(self) || self hasperk(#"specialty_quieter"))
	{
		return;
	}
	if(!isdefined(killstreaktype) || !isdefined(level.killstreaks[killstreaktype]))
	{
		return;
	}
	self thread play_dialog(level.killstreaks[killstreaktype].threatdialogkey, 2);
}

/*
	Name: function_dd6a6012
	Namespace: battlechatter
	Checksum: 0x64CDB76F
	Offset: 0x7FD0
	Size: 0xE4
	Parameters: 2
	Flags: Linked
*/
function function_dd6a6012(killstreaktype, weapon)
{
	if(!level.allowspecialistdialog || !isdefined(self) || !isplayer(self) || self hasperk(#"specialty_quieter"))
	{
		return;
	}
	if(!isdefined(killstreaktype) || !isdefined(level.killstreaks[killstreaktype]) || !isdefined(weapon) || isdefined(killstreaks::get_from_weapon(weapon)))
	{
		return;
	}
	self thread play_dialog(level.killstreaks[killstreaktype].var_2729ed45);
}

/*
	Name: wait_play_dialog
	Namespace: battlechatter
	Checksum: 0x22095FCA
	Offset: 0x80C0
	Size: 0xAC
	Parameters: 6
	Flags: Linked
*/
function wait_play_dialog(waittime, dialogkey, dialogflags, dialogbuffer, enemy, endnotify)
{
	self endon(#"death");
	level endon(#"game_ended");
	if(isdefined(waittime) && waittime > 0)
	{
		if(isdefined(endnotify))
		{
			self endon(endnotify);
		}
		wait(waittime);
	}
	self thread play_dialog(dialogkey, dialogflags, dialogbuffer, enemy);
}

/*
	Name: function_f57e565f
	Namespace: battlechatter
	Checksum: 0x6F130C71
	Offset: 0x8178
	Size: 0x1EC
	Parameters: 3
	Flags: Linked
*/
function function_f57e565f(dialogkey, entity, waittime)
{
	self endon(#"death");
	level endon(#"game_ended");
	if(!isdefined(self) || (isdefined(self.playingdialog) && self.playingdialog) || !isplayer(self) || !isdefined(entity) || (self == entity && self isplayerunderwater()) || !isplayer(entity))
	{
		return;
	}
	dialogalias = entity get_player_dialog_alias(dialogkey, undefined);
	if(isdefined(waittime) && waittime > 0)
	{
		wait(waittime);
		if(!isdefined(self) || (isdefined(self.playingdialog) && self.playingdialog) || !isplayer(self) || !isdefined(entity) || (self == entity && self isplayerunderwater()) || !isplayer(entity))
		{
			return;
		}
	}
	if(isdefined(dialogalias))
	{
		self playsoundtoplayer(dialogalias, self);
		self thread wait_dialog_buffer(mpdialog_value("killstreakDialogBuffer", 0));
	}
}

/*
	Name: function_1339f3f3
	Namespace: battlechatter
	Checksum: 0xCBF26F14
	Offset: 0x8370
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_1339f3f3(tag = "J_Head")
{
	return self hasdobj() && self haspart(tag);
}

/*
	Name: play_dialog
	Namespace: battlechatter
	Checksum: 0xEAB3EC8E
	Offset: 0x83C8
	Size: 0x34C
	Parameters: 4
	Flags: Linked
*/
function play_dialog(dialogkey, dialogflags, dialogbuffer, enemy)
{
	self endon(#"death");
	level endon(#"game_ended");
	if(!isdefined(dialogkey) || !isplayer(self) || !isalive(self) || level.gameended)
	{
		return;
	}
	if(!isdefined(dialogflags))
	{
		dialogflags = 0;
	}
	if(!level.allowspecialistdialog && (dialogflags & 16) == 0)
	{
		return;
	}
	if(self hasperk(#"specialty_quieter"))
	{
		return;
	}
	if(!isdefined(dialogbuffer))
	{
		dialogbuffer = mpdialog_value("playerDialogBuffer", 0);
	}
	dialogalias = self get_player_dialog_alias(dialogkey, undefined);
	if(!isdefined(dialogalias))
	{
		return;
	}
	if(self isplayerunderwater() && !dialogflags & 8)
	{
		return;
	}
	if(isdefined(self.playingdialog) && self.playingdialog)
	{
		if(!dialogflags & 4)
		{
			return;
		}
		self stopsounds();
		waitframe(1);
	}
	if(dialogflags & 32)
	{
		self.playinggadgetreadydialog = 1;
	}
	if(dialogflags & 64)
	{
		if(!isdefined(self.stolendialogindex))
		{
			self.stolendialogindex = 0;
		}
		dialogalias = (dialogalias + "_0") + self.stolendialogindex;
		self.stolendialogindex++;
		self.stolendialogindex = self.stolendialogindex % 4;
	}
	if(dialogflags & 2)
	{
		if(self function_1339f3f3())
		{
			self playsoundontag(dialogalias, "J_Head");
		}
	}
	else
	{
		if(dialogflags & 1)
		{
			if(self function_1339f3f3())
			{
				if(isdefined(enemy))
				{
					self playsoundontag(dialogalias, "J_Head", self.team, enemy);
				}
				else
				{
					self playsoundontag(dialogalias, "J_Head", self.team);
				}
			}
		}
		else
		{
			self playlocalsound(dialogalias);
		}
	}
	self notify(#"played_dialog");
	self thread wait_dialog_buffer(dialogbuffer);
}

/*
	Name: function_5896274
	Namespace: battlechatter
	Checksum: 0x10DF2601
	Offset: 0x8720
	Size: 0xAC
	Parameters: 6
	Flags: Linked
*/
function function_5896274(waittime, dialogalias, dialogflags, dialogbuffer, enemy, endnotify)
{
	self endon(#"death");
	level endon(#"game_ended");
	if(isdefined(waittime) && waittime > 0)
	{
		if(isdefined(endnotify))
		{
			self endon(endnotify);
		}
		wait(waittime);
	}
	self thread function_a48c33ff(dialogalias, dialogflags, dialogbuffer, enemy);
}

/*
	Name: function_a48c33ff
	Namespace: battlechatter
	Checksum: 0x7A430AB7
	Offset: 0x87D8
	Size: 0x2EC
	Parameters: 4
	Flags: Linked
*/
function function_a48c33ff(dialogalias, dialogflags, dialogbuffer, enemy)
{
	self endon(#"death");
	var_c84adc7e = !function_f99d2668() || !isdefined(dialogflags) || dialogflags & 128;
	if(!var_c84adc7e)
	{
		level endon(#"game_ended");
	}
	if(!isdefined(dialogalias) || !isplayer(self) || !isalive(self) || (level.gameended && !var_c84adc7e))
	{
		return;
	}
	if(!isdefined(dialogflags))
	{
		dialogflags = 0;
	}
	if(!level.allowspecialistdialog && (dialogflags & 16) == 0)
	{
		return;
	}
	if(!isdefined(dialogbuffer))
	{
		dialogbuffer = mpdialog_value("playerDialogBuffer", 0);
	}
	if(self isplayerunderwater() && !dialogflags & 8)
	{
		return;
	}
	if(isdefined(self.playingdialog) && self.playingdialog)
	{
		if(!dialogflags & 4)
		{
			return;
		}
		self stopsounds();
		waitframe(1);
	}
	if(dialogflags & 32)
	{
		self.playinggadgetreadydialog = 1;
	}
	if(dialogflags & 2)
	{
		if(self function_1339f3f3())
		{
			self playsoundontag(dialogalias, "J_Head");
		}
	}
	else
	{
		if(dialogflags & 1)
		{
			if(self function_1339f3f3())
			{
				if(isdefined(enemy))
				{
					self playsoundontag(dialogalias, "J_Head", self.team, enemy);
				}
				else
				{
					self playsoundontag(dialogalias, "J_Head", self.team);
				}
			}
		}
		else
		{
			self playlocalsound(dialogalias);
		}
	}
	self notify(#"played_dialog");
	self thread wait_dialog_buffer(dialogbuffer);
}

/*
	Name: wait_dialog_buffer
	Namespace: battlechatter
	Checksum: 0x51DFDCBA
	Offset: 0x8AD0
	Size: 0x9E
	Parameters: 1
	Flags: Linked
*/
function wait_dialog_buffer(dialogbuffer)
{
	self endon(#"death", #"played_dialog", #"stop_dialog");
	level endon(#"game_ended");
	self.playingdialog = 1;
	if(isdefined(dialogbuffer) && dialogbuffer > 0)
	{
		wait(dialogbuffer);
	}
	self.playingdialog = 0;
	self.var_6765d33e = 0;
	self.playinggadgetreadydialog = 0;
}

/*
	Name: stop_dialog
	Namespace: battlechatter
	Checksum: 0xA1F2EDB4
	Offset: 0x8B78
	Size: 0x4E
	Parameters: 0
	Flags: Linked
*/
function stop_dialog()
{
	self notify(#"stop_dialog");
	self stopsounds();
	self.playingdialog = 0;
	self.var_6765d33e = 0;
	self.playinggadgetreadydialog = 0;
}

/*
	Name: wait_playback_time
	Namespace: battlechatter
	Checksum: 0x439D7995
	Offset: 0x8BD0
	Size: 0xC
	Parameters: 1
	Flags: None
*/
function wait_playback_time(soundalias)
{
}

/*
	Name: get_player_dialog_alias
	Namespace: battlechatter
	Checksum: 0xC9EB86C6
	Offset: 0x8BE8
	Size: 0x112
	Parameters: 2
	Flags: Linked
*/
function get_player_dialog_alias(dialogkey, meansofdeath)
{
	if(!isplayer(self))
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
	return globallogic_audio::get_dialog_bundle_alias(playerbundle, dialogkey);
}

/*
	Name: count_keys
	Namespace: battlechatter
	Checksum: 0x1118CA7E
	Offset: 0x8D08
	Size: 0xF8
	Parameters: 3
	Flags: Linked
*/
function count_keys(keycounts, bundle, dialogkey)
{
	i = 0;
	field = dialogkey + i;
	fieldvalue = bundle.(field);
	while(isdefined(fieldvalue))
	{
		aliasarray[i] = fieldvalue;
		i++;
		field = dialogkey + i;
		fieldvalue = bundle.(field);
	}
	if(!isdefined(keycounts[bundle.name]))
	{
		keycounts[bundle.name] = [];
	}
	keycounts[bundle.name][dialogkey] = (i == 0 ? undefined : i);
}

/*
	Name: get_random_key
	Namespace: battlechatter
	Checksum: 0x30D8E844
	Offset: 0x8E08
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function get_random_key(dialogkey)
{
	bundlename = self getmpdialogname();
	if(!isdefined(bundlename))
	{
		return undefined;
	}
	if(!isdefined(level.var_f53efe5c[bundlename]) || !isdefined(level.var_f53efe5c[bundlename][dialogkey]) || level.var_f53efe5c[bundlename][dialogkey] == 0)
	{
		return dialogkey;
	}
	return dialogkey + randomint(level.var_f53efe5c[bundlename][dialogkey]);
}

/*
	Name: play_gadget_ready
	Namespace: battlechatter
	Checksum: 0x7C8D5AC6
	Offset: 0x8ED0
	Size: 0x92C
	Parameters: 2
	Flags: Linked
*/
function play_gadget_ready(weapon, userflip = 0)
{
	if(!level.allowspecialistdialog || !isdefined(self) || !isplayer(self) || self hasperk(#"specialty_quieter"))
	{
		return;
	}
	if(!isdefined(weapon) || (gettime() - (isdefined(level.starttime) ? level.starttime : 0)) < (int(mpdialog_value("readyAudioDelay", 0) * 1000)))
	{
		return;
	}
	dialogkey = undefined;
	bundlename = self getmpdialogname();
	if(!isdefined(bundlename))
	{
		return;
	}
	playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
	if(!isdefined(playerbundle))
	{
		return;
	}
	switch(weapon.name)
	{
		case "hero_annihilator":
		{
			dialogkey = playerbundle.annihilatorweaponready;
			break;
		}
		case "sig_buckler_dw":
		case "hero_minigun":
		{
			dialogkey = playerbundle.var_bde3e948;
			break;
		}
		case "eq_localheal":
		{
			dialogkey = playerbundle.var_9a9ffda6;
			break;
		}
		case "hash_52aca7c35be649b8":
		case "gadget_cleanse":
		{
			dialogkey = playerbundle.var_45c0f5db;
			break;
		}
		case "ability_dog":
		{
			dialogkey = playerbundle.var_f484179b;
			break;
		}
		case "hash_4bb2d7f789b561eb":
		{
			dialogkey = playerbundle.var_ce2beea1;
			break;
		}
		case "shock_rifle":
		{
			dialogkey = playerbundle.tempestweaponready;
			break;
		}
		case "sig_minigun":
		{
			dialogkey = playerbundle.var_4630d039;
			break;
		}
		case "gadget_spawnbeacon":
		{
			dialogkey = playerbundle.var_d294848f;
			break;
		}
		case "ability_smart_cover":
		{
			dialogkey = playerbundle.var_47d3c3bd;
			break;
		}
		case "hash_2ce2e438ecd6b2d2":
		{
			dialogkey = playerbundle.var_7b1fe307;
			break;
		}
		case "hero_flamethrower":
		{
			dialogkey = playerbundle.purifierweaponready;
			break;
		}
		case "gadget_radiation_field":
		{
			dialogkey = playerbundle.var_a9a63fa;
			break;
		}
		case "hash_40380537847df901":
		{
			dialogkey = playerbundle.sparrowweaponready;
			break;
		}
		case "eq_hawk":
		{
			dialogkey = playerbundle.var_e230637d;
			break;
		}
		case "gadget_supplypod":
		{
			dialogkey = playerbundle.var_ade452b2;
			break;
		}
		case "gadget_vision_pulse":
		{
			dialogkey = playerbundle.visionpulseabilityready;
			break;
		}
		case "hero_pineapplegun":
		{
			dialogkey = playerbundle.warmachineweaponready;
			break;
		}
		case "eq_swat_grenade":
		case "hash_3f62a872201cd1ce":
		case "hash_5825488ac68418af":
		{
			dialogkey = playerbundle.var_cb080e91;
			break;
		}
		case "eq_cluster_semtex_grenade":
		{
			dialogkey = playerbundle.var_1497b2f4;
			break;
		}
		case "eq_concertina_wire":
		{
			dialogkey = playerbundle.var_b55793d6;
			break;
		}
		case "hash_4a4ba36128b6582f":
		{
			dialogkey = playerbundle.var_486b28c0;
			break;
		}
		case "eq_sensor":
		{
			dialogkey = playerbundle.var_e4a019a;
			break;
		}
		case "eq_tripwire":
		{
			dialogkey = playerbundle.var_3a5a4e80;
			break;
		}
		case "gadget_icepick":
		{
			dialogkey = playerbundle.var_a2661f2f;
			break;
		}
		case "hash_21b346649d376bf3":
		{
			dialogkey = playerbundle.var_8610c190;
			break;
		}
		case "sig_blade":
		{
			dialogkey = playerbundle.var_cb504af2;
			break;
		}
		case "eq_smoke":
		{
			dialogkey = playerbundle.var_7b1fe307;
			break;
		}
		case "sig_lmg":
		{
			dialogkey = playerbundle.scytheweaponready;
			break;
		}
		case "hash_f525ab9cc66c061":
		{
			dialogkey = playerbundle.var_30130c75;
			break;
		}
		default:
		{
			return;
		}
	}
	if(!(isdefined(self.isthief) && self.isthief) && (!(isdefined(self.isroulette) && self.isroulette)))
	{
		self thread function_a48c33ff(dialogkey, 2);
		return;
	}
	waittime = 0;
	dialogflags = 32;
	if(userflip)
	{
		minwaittime = 0;
		if(self.playinggadgetreadydialog)
		{
			self stop_dialog();
			minwaittime = float(function_60d95f53()) / 1000;
		}
		if(isdefined(self.isthief) && self.isthief)
		{
			delaykey = "thiefFlipDelay";
		}
		else
		{
			delaykey = "rouletteFlipDelay";
		}
		waittime = mpdialog_value(delaykey, minwaittime);
		dialogflags = dialogflags + 64;
	}
	else
	{
		if(isdefined(self.isthief) && self.isthief)
		{
			generickey = playerbundle.thiefweaponready;
			repeatkey = playerbundle.thiefweaponrepeat;
			repeatthresholdkey = "thiefRepeatThreshold";
			chancekey = "thiefReadyChance";
			delaykey = "thiefRevealDelay";
		}
		else
		{
			generickey = playerbundle.rouletteabilityready;
			repeatkey = playerbundle.rouletteabilityrepeat;
			repeatthresholdkey = "rouletteRepeatThreshold";
			chancekey = "rouletteReadyChance";
			delaykey = "rouletteRevealDelay";
		}
		if(randomint(100) < mpdialog_value(chancekey, 0))
		{
			dialogkey = generickey;
		}
		else
		{
			waittime = mpdialog_value(delaykey, 0);
			if(self.laststolengadget === weapon && (self.laststolengadgettime + (int(mpdialog_value(repeatthresholdkey, 0) * 1000))) > gettime())
			{
				dialogkey = repeatkey;
			}
			else
			{
				dialogflags = dialogflags + 64;
			}
		}
	}
	self.laststolengadget = weapon;
	self.laststolengadgettime = gettime();
	if(waittime)
	{
		self notify(#"cancel_kill_dialog");
	}
	self thread function_5896274(waittime, dialogkey, dialogflags, undefined, undefined, undefined);
}

/*
	Name: function_1d4b0ec0
	Namespace: battlechatter
	Checksum: 0x6F2762E2
	Offset: 0x9808
	Size: 0x17C
	Parameters: 2
	Flags: Linked
*/
function function_1d4b0ec0(dogstate, dog)
{
	if(!level.allowspecialistdialog)
	{
		return;
	}
	if(!isdefined(dogstate))
	{
		return;
	}
	if(!isdefined(self.script_owner) || !isplayer(self.script_owner) || self.script_owner hasperk(#"specialty_quieter"))
	{
		return;
	}
	bundlename = self.script_owner getmpdialogname();
	if(!isdefined(bundlename))
	{
		return;
	}
	playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
	if(!isdefined(playerbundle))
	{
		return;
	}
	dialogkey = undefined;
	switch(dogstate)
	{
		case 0:
		{
			dialogkey = playerbundle.var_499ffcee;
			break;
		}
		case 1:
		{
			dialogkey = playerbundle.var_38ab9818;
			break;
		}
		default:
		{
			return;
		}
	}
	self.script_owner thread function_a48c33ff(dialogkey);
}

/*
	Name: function_e3ebbf87
	Namespace: battlechatter
	Checksum: 0x28D7D433
	Offset: 0x9990
	Size: 0x14F4
	Parameters: 2
	Flags: Linked
*/
function function_e3ebbf87(var_aa988d26, var_c1132df6)
{
	if(!isdefined(var_aa988d26) || !isdefined(self) || !isplayer(self))
	{
		return;
	}
	self notify("2f5480a370bfcd30");
	self endon("2f5480a370bfcd30");
	self endon(#"death", #"disconnect");
	if(!function_f99d2668())
	{
		level endon(#"game_ended");
	}
	waittime = mpdialog_value("calloutTriggerDelay", 0);
	wait(waittime);
	if(!isdefined(self) || !isplayer(self) || self isplayerunderwater())
	{
		return;
	}
	specialistname = self getmpdialogname();
	if(!isdefined(specialistname) || (isdefined(self.playingdialog) && self.playingdialog))
	{
		return;
	}
	if(isdefined(var_c1132df6) && var_c1132df6)
	{
		switch(specialistname)
		{
			case "battery":
			{
				dialogalias = var_aa988d26.var_80407c8f;
				break;
			}
			case "buffassault":
			{
				dialogalias = var_aa988d26.var_a5004222;
				break;
			}
			case "engineer":
			{
				dialogalias = var_aa988d26.var_aa265686;
				break;
			}
			case "firebreak":
			{
				dialogalias = var_aa988d26.var_3b7efe03;
				break;
			}
			case "nomad":
			{
				dialogalias = var_aa988d26.var_cf76a9bd;
				break;
			}
			case "outrider":
			{
				dialogalias = var_aa988d26.var_f09797b3;
				break;
			}
			case "prophet":
			{
				dialogalias = var_aa988d26.var_f3279c55;
				break;
			}
			case "reaper":
			{
				dialogalias = var_aa988d26.var_ca5f991e;
				break;
			}
			case "recon":
			{
				dialogalias = var_aa988d26.var_211d2d38;
				break;
			}
			case "ruin":
			{
				dialogalias = var_aa988d26.var_1ef4fd08;
				break;
			}
			case "seraph":
			{
				dialogalias = var_aa988d26.var_e995b5b2;
				break;
			}
			case "spectre":
			{
				dialogalias = var_aa988d26.var_b9953afb;
				break;
			}
			case "swatpolice":
			{
				dialogalias = var_aa988d26.var_c4f44015;
				break;
			}
			case "hash_12196c2957bbed75":
			{
				dialogalias = var_aa988d26.var_8f349bdf;
				break;
			}
			case "hash_3f57def1d8fe2fc9":
			{
				dialogalias = var_aa988d26.var_4aa5fa49;
				break;
			}
			case "hash_670bb663c887a446":
			{
				dialogalias = var_aa988d26.var_60412044;
				break;
			}
			case "hash_2a7f0b8ac199ecc4":
			{
				dialogalias = var_aa988d26.var_4b5e1168;
				break;
			}
			case "hudson":
			{
				dialogalias = var_aa988d26.var_48d23194;
				break;
			}
			case "hash_4aa849dab9aaf091":
			{
				dialogalias = var_aa988d26.var_6fb717e9;
				break;
			}
			case "mason":
			{
				dialogalias = var_aa988d26.var_432508cc;
				break;
			}
			case "hash_5d13dabfea862471":
			{
				dialogalias = var_aa988d26.var_321df77f;
				break;
			}
			case "menendez":
			{
				dialogalias = var_aa988d26.var_53d583e7;
				break;
			}
			case "replacer":
			{
				dialogalias = var_aa988d26.var_cab536f0;
				break;
			}
			case "reznov":
			{
				dialogalias = var_aa988d26.var_1c943309;
				break;
			}
			case "hash_3c598ee278fd6042":
			{
				dialogalias = var_aa988d26.var_6b2e4d03;
				break;
			}
			case "sergei":
			{
				dialogalias = var_aa988d26.var_c1466c1d;
				break;
			}
			case "trejo":
			{
				dialogalias = var_aa988d26.var_c1466c1d;
				break;
			}
			case "weaver":
			{
				dialogalias = var_aa988d26.var_d5e3a527;
				break;
			}
			case "woods":
			{
				dialogalias = var_aa988d26.var_46584bcd;
				break;
			}
			case "hash_7126a3eb1fbc97c7":
			{
				dialogalias = var_aa988d26.var_46584bcd;
				break;
			}
			case "yuri":
			{
				dialogalias = var_aa988d26.var_c5c64fea;
				break;
			}
			case "hash_6becd1d9b42235f":
			{
				dialogalias = var_aa988d26.var_b37a5347;
				break;
			}
			case "brutus":
			{
				dialogalias = var_aa988d26.var_42e6fafc;
				break;
			}
			case "dempsey":
			case "hash_6baa6fd645c39e13":
			{
				dialogalias = var_aa988d26.var_4045f08d;
				break;
			}
			case "hash_23b4b1996e6d8717":
			{
				dialogalias = var_aa988d26.var_2b93306e;
				break;
			}
			case "marlton":
			{
				dialogalias = var_aa988d26.var_a59c420;
				break;
			}
			case "misty":
			{
				dialogalias = var_aa988d26.var_6bc7d2e1;
				break;
			}
			case "nikolai":
			case "hash_77d5002dc06ba8cd":
			{
				dialogalias = var_aa988d26.var_9ed1fc02;
				break;
			}
			case "hash_5d7fb8a5f9783ac7":
			{
				dialogalias = var_aa988d26.var_a4215642;
				break;
			}
			case "hash_30e2c95a219f969":
			{
				dialogalias = var_aa988d26.var_9f201adb;
				break;
			}
			case "hash_515d2feae8c86daa":
			{
				dialogalias = var_aa988d26.var_ce6ec646;
				break;
			}
			case "hash_2e260fd4586f092a":
			{
				dialogalias = var_aa988d26.var_94a73557;
				break;
			}
			case "hash_53c0d6c8c24fa6be":
			case "richtofen":
			{
				dialogalias = var_aa988d26.var_72259d2c;
				break;
			}
			case "russman":
			{
				dialogalias = var_aa988d26.var_5d2187b6;
				break;
			}
			case "hash_323155d0bfdb52df":
			{
				dialogalias = var_aa988d26.var_89123a37;
				break;
			}
			case "hash_1eb9968c75952fa3":
			{
				dialogalias = var_aa988d26.var_d9461c0d;
				break;
			}
			case "shaw":
			{
				dialogalias = var_aa988d26.var_85592cb6;
				break;
			}
			case "stuhlinger":
			{
				dialogalias = var_aa988d26.var_35982a38;
				break;
			}
			case "hash_2241635d7c733b4e":
			case "takeo":
			{
				dialogalias = var_aa988d26.var_2d671c2b;
				break;
			}
			case "hash_7a2dd4ef19b80f32":
			{
				dialogalias = var_aa988d26.var_d9286c13;
				break;
			}
			case "hash_6fd25b2f51ddd9e0":
			{
				dialogalias = var_aa988d26.var_330f1168;
				break;
			}
			case "hash_504698da24dbe4bd":
			{
				dialogalias = var_aa988d26.var_eb1d0a0f;
				break;
			}
			case "hash_27a6844285d32238":
			{
				dialogalias = var_aa988d26.var_e45c0917;
				break;
			}
			case "hash_27a6874285d32751":
			{
				dialogalias = var_aa988d26.var_e0ec221f;
				break;
			}
			case "hash_27a6864285d3259e":
			{
				dialogalias = var_aa988d26.var_73a6dac1;
				break;
			}
			case "hash_27a6894285d32ab7":
			{
				dialogalias = var_aa988d26.var_f41f1940;
				break;
			}
			case "hash_18ce722545297238":
			{
				dialogalias = var_aa988d26.var_92fcd922;
				break;
			}
			case "hash_5bc153ee98d24c01":
			{
				dialogalias = var_aa988d26.var_efb78ea3;
				break;
			}
			case "hash_81dd0a524c1e033":
			{
				dialogalias = var_aa988d26.var_a7c0131a;
				break;
			}
			case "hash_81dd1a524c1e1e6":
			{
				dialogalias = var_aa988d26.var_c97b2728;
				break;
			}
			case "hash_81dd2a524c1e399":
			{
				dialogalias = var_aa988d26.var_bd4b3225;
				break;
			}
			case "hash_81dd3a524c1e54c":
			{
				dialogalias = var_aa988d26.var_63a86387;
				break;
			}
			case "hash_7e9e791e2f1f1a7c":
			{
				dialogalias = var_aa988d26.var_e8e7012b;
				break;
			}
			case "hash_704e3fad37eb453c":
			{
				dialogalias = var_aa988d26.var_63d7db94;
				break;
			}
			case "hash_7ef5cbd378f6506c":
			{
				dialogalias = var_aa988d26.var_105e5d33;
				break;
			}
			default:
			{
				return;
			}
		}
	}
	else
	{
		switch(specialistname)
		{
			case "battery":
			{
				dialogalias = var_aa988d26.var_4ecb4e64;
				break;
			}
			case "buffassault":
			{
				dialogalias = var_aa988d26.var_903053f4;
				break;
			}
			case "engineer":
			{
				dialogalias = var_aa988d26.var_f5e77f05;
				break;
			}
			case "firebreak":
			{
				dialogalias = var_aa988d26.var_ea3c9565;
				break;
			}
			case "nomad":
			{
				dialogalias = var_aa988d26.var_20c482a5;
				break;
			}
			case "outrider":
			{
				dialogalias = var_aa988d26.var_87c8ec66;
				break;
			}
			case "prophet":
			{
				dialogalias = var_aa988d26.var_b8de476c;
				break;
			}
			case "reaper":
			{
				dialogalias = var_aa988d26.var_64a03a3e;
				break;
			}
			case "recon":
			{
				dialogalias = var_aa988d26.var_88484588;
				break;
			}
			case "ruin":
			{
				dialogalias = var_aa988d26.var_fa4018ce;
				break;
			}
			case "seraph":
			{
				dialogalias = var_aa988d26.var_a221d9a2;
				break;
			}
			case "spectre":
			{
				dialogalias = var_aa988d26.var_d7fde75f;
				break;
			}
			case "swatpolice":
			{
				dialogalias = var_aa988d26.var_7ac02231;
				break;
			}
			case "zero":
			{
				dialogalias = var_aa988d26.var_ebb4b55;
				break;
			}
			case "hash_12196c2957bbed75":
			{
				dialogalias = var_aa988d26.var_f449ccb6;
				break;
			}
			case "hash_3f57def1d8fe2fc9":
			{
				dialogalias = var_aa988d26.var_1411ad27;
				break;
			}
			case "hash_670bb663c887a446":
			{
				dialogalias = var_aa988d26.var_f0be54bd;
				break;
			}
			case "hash_2a7f0b8ac199ecc4":
			{
				dialogalias = var_aa988d26.var_1d9994d5;
				break;
			}
			case "hudson":
			{
				dialogalias = var_aa988d26.var_236ed551;
				break;
			}
			case "hash_4aa849dab9aaf091":
			{
				dialogalias = var_aa988d26.var_609b5733;
				break;
			}
			case "mason":
			{
				dialogalias = var_aa988d26.var_36156b4;
				break;
			}
			case "hash_5d13dabfea862471":
			{
				dialogalias = var_aa988d26.var_e7c3ff0b;
				break;
			}
			case "menendez":
			{
				dialogalias = var_aa988d26.var_af7dd877;
				break;
			}
			case "replacer":
			{
				dialogalias = var_aa988d26.var_5e46d9cc;
				break;
			}
			case "reznov":
			{
				dialogalias = var_aa988d26.var_d5950da8;
				break;
			}
			case "hash_3c598ee278fd6042":
			{
				dialogalias = var_aa988d26.var_9e49481e;
				break;
			}
			case "sergei":
			{
				dialogalias = var_aa988d26.var_6f74d606;
				break;
			}
			case "trejo":
			{
				dialogalias = var_aa988d26.var_8420517a;
				break;
			}
			case "weaver":
			{
				dialogalias = var_aa988d26.var_efe1407c;
				break;
			}
			case "woods":
			{
				dialogalias = var_aa988d26.var_86f07f8a;
				break;
			}
			case "hash_7126a3eb1fbc97c7":
			{
				dialogalias = var_aa988d26.var_e5b468ae;
				break;
			}
			case "yuri":
			{
				dialogalias = var_aa988d26.var_be14530f;
				break;
			}
			case "hash_6becd1d9b42235f":
			{
				dialogalias = var_aa988d26.var_69d3e46;
				break;
			}
			case "brutus":
			{
				dialogalias = var_aa988d26.var_c691fc24;
				break;
			}
			case "dempsey":
			case "hash_6baa6fd645c39e13":
			{
				dialogalias = var_aa988d26.var_8b897e74;
				break;
			}
			case "hash_23b4b1996e6d8717":
			{
				dialogalias = var_aa988d26.var_45341635;
				break;
			}
			case "marlton":
			{
				dialogalias = var_aa988d26.var_88c12253;
				break;
			}
			case "misty":
			{
				dialogalias = var_aa988d26.var_ff5cea3b;
				break;
			}
			case "nikolai":
			case "hash_77d5002dc06ba8cd":
			{
				dialogalias = var_aa988d26.var_27bc4433;
				break;
			}
			case "hash_5d7fb8a5f9783ac7":
			{
				dialogalias = var_aa988d26.var_95a03453;
				break;
			}
			case "hash_30e2c95a219f969":
			{
				dialogalias = var_aa988d26.var_69033114;
				break;
			}
			case "hash_515d2feae8c86daa":
			{
				dialogalias = var_aa988d26.var_d56828f1;
				break;
			}
			case "hash_2e260fd4586f092a":
			{
				dialogalias = var_aa988d26.var_33edc6fa;
				break;
			}
			case "hash_53c0d6c8c24fa6be":
			case "richtofen":
			{
				dialogalias = var_aa988d26.var_af612a6d;
				break;
			}
			case "russman":
			{
				dialogalias = var_aa988d26.var_53de84dc;
				break;
			}
			case "hash_323155d0bfdb52df":
			{
				dialogalias = var_aa988d26.var_38efdc20;
				break;
			}
			case "hash_1eb9968c75952fa3":
			{
				dialogalias = var_aa988d26.var_71422e;
				break;
			}
			case "shaw":
			{
				dialogalias = var_aa988d26.var_beab1094;
				break;
			}
			case "stuhlinger":
			{
				dialogalias = var_aa988d26.var_c9e3892;
				break;
			}
			case "hash_2241635d7c733b4e":
			case "takeo":
			{
				dialogalias = var_aa988d26.var_b3201047;
				break;
			}
			case "hash_7a2dd4ef19b80f32":
			{
				dialogalias = var_aa988d26.var_6e548d8e;
				break;
			}
			case "hash_6fd25b2f51ddd9e0":
			{
				dialogalias = var_aa988d26.var_63dc7b96;
				break;
			}
			case "hash_504698da24dbe4bd":
			{
				dialogalias = var_aa988d26.var_afc5e0c1;
				break;
			}
			case "hash_27a6844285d32238":
			{
				dialogalias = var_aa988d26.var_891c58d0;
				break;
			}
			case "hash_27a6874285d32751":
			{
				dialogalias = var_aa988d26.var_2f702d3e;
				break;
			}
			case "hash_27a6864285d3259e":
			{
				dialogalias = var_aa988d26.var_1e68d30e;
				break;
			}
			case "hash_27a6894285d32ab7":
			{
				dialogalias = var_aa988d26.var_68ef0dd5;
				break;
			}
			case "hash_18ce722545297238":
			{
				dialogalias = var_aa988d26.var_19e39499;
				break;
			}
			case "hash_5bc153ee98d24c01":
			{
				dialogalias = var_aa988d26.var_de7a214a;
				break;
			}
			case "hash_81dd0a524c1e033":
			{
				dialogalias = var_aa988d26.var_53c80d60;
				break;
			}
			case "hash_81dd1a524c1e1e6":
			{
				dialogalias = var_aa988d26.var_6db249ec;
				break;
			}
			case "hash_81dd2a524c1e399":
			{
				dialogalias = var_aa988d26.var_cf970750;
				break;
			}
			case "hash_81dd3a524c1e54c":
			{
				dialogalias = var_aa988d26.var_ff548dc3;
				break;
			}
			case "hash_7e9e791e2f1f1a7c":
			{
				dialogalias = var_aa988d26.var_80c17c05;
				break;
			}
			case "hash_704e3fad37eb453c":
			{
				dialogalias = var_aa988d26.var_5bdd23de;
				break;
			}
			case "hash_7ef5cbd378f6506c":
			{
				dialogalias = var_aa988d26.var_8702f696;
				break;
			}
			default:
			{
				return;
			}
		}
	}
	if(isdefined(dialogalias))
	{
		dialogbuffer = mpdialog_value("calloutDialogBuffer", 0);
		self thread function_a48c33ff(dialogalias, 146, dialogbuffer);
	}
}

/*
	Name: function_fff18afc
	Namespace: battlechatter
	Checksum: 0x643CA0DC
	Offset: 0xAE90
	Size: 0x124
	Parameters: 2
	Flags: Linked
*/
function function_fff18afc(dialogkey, var_4d5833c)
{
	if(!level.allowspecialistdialog || !isdefined(self) || !isplayer(self))
	{
		return;
	}
	if(!isdefined(dialogkey) || self isplayerunderwater())
	{
		return;
	}
	dialogbuffer = mpdialog_value("killstreakDialogBuffer", 0);
	if(!self hasperk(#"specialty_quieter"))
	{
		self play_dialog(dialogkey, 6, dialogbuffer, undefined);
	}
	var_cf210c5b = self get_player_dialog_alias(var_4d5833c, undefined);
	if(isdefined(var_cf210c5b))
	{
		self function_253c2ba4(var_cf210c5b, dialogbuffer);
	}
}

/*
	Name: function_cad61ec
	Namespace: battlechatter
	Checksum: 0x1C1B41FD
	Offset: 0xAFC0
	Size: 0x254
	Parameters: 1
	Flags: Linked
*/
function function_cad61ec(weapon)
{
	if(!level.allowspecialistdialog || !isdefined(self) || !isplayer(self))
	{
		return;
	}
	if(!isdefined(weapon) || !isalive(self) || level.gameended || self isplayerunderwater())
	{
		return;
	}
	bundlename = self getmpdialogname();
	if(!isdefined(bundlename))
	{
		return;
	}
	playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
	if(!isdefined(playerbundle))
	{
		return;
	}
	switch(weapon.name)
	{
		case "eq_concertina_wire":
		{
			dialogkey = playerbundle.var_6d3b52e5;
			var_4d031df6 = playerbundle.var_45efe6f7;
			break;
		}
		case "ability_smart_cover":
		{
			dialogkey = playerbundle.var_906d49a;
			var_4d031df6 = playerbundle.var_918699f4;
			break;
		}
		case "gadget_spawnbeacon":
		{
			dialogkey = playerbundle.var_41c2519b;
			var_4d031df6 = playerbundle.var_9a961aab;
			break;
		}
		case "gadget_supplypod":
		{
			dialogkey = playerbundle.var_7d3aa98a;
			var_4d031df6 = playerbundle.var_c1e8f95f;
			break;
		}
		default:
		{
			return;
		}
	}
	if(!self hasperk(#"specialty_quieter"))
	{
		self thread function_a48c33ff(dialogkey, 2, undefined, undefined);
	}
	if(isdefined(var_4d031df6))
	{
		self function_253c2ba4(var_4d031df6, undefined);
	}
}

/*
	Name: function_916b4c72
	Namespace: battlechatter
	Checksum: 0x4C416A6
	Offset: 0xB220
	Size: 0x2D4
	Parameters: 1
	Flags: Linked
*/
function function_916b4c72(weapon)
{
	if(!level.allowspecialistdialog || !isdefined(self) || !isplayer(self) || self hasperk(#"specialty_quieter"))
	{
		return;
	}
	if(!isdefined(weapon) || !isalive(self) || level.gameended || (isdefined(self.var_8720dd77) ? self.var_8720dd77 : 0) > gettime() || self isplayerunderwater())
	{
		return;
	}
	bundlename = self getmpdialogname();
	if(!isdefined(bundlename))
	{
		return;
	}
	playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
	if(!isdefined(playerbundle))
	{
		return;
	}
	switch(weapon.name)
	{
		case "eq_concertina_wire":
		{
			dialogkey = playerbundle.var_4ecee308;
			break;
		}
		case "dog_ai_defaultmelee":
		{
			dialogkey = playerbundle.var_e489dc9d;
			break;
		}
		case "eq_localheal":
		{
			dialogkey = playerbundle.var_73b6ded8;
			break;
		}
		case "ability_smart_cover":
		{
			dialogkey = playerbundle.var_2ece98;
			break;
		}
		case "gadget_spawnbeacon":
		{
			dialogkey = playerbundle.var_dbac4c7d;
			break;
		}
		case "gadget_supplypod":
		{
			dialogkey = playerbundle.var_56487ba6;
			break;
		}
		default:
		{
			return;
		}
	}
	if(isdefined(dialogkey))
	{
		self.var_8720dd77 = gettime() + (int(mpdialog_value("useFailDelay", 5) * 1000));
		self playsoundtoplayer(dialogkey, self);
		self thread wait_dialog_buffer(mpdialog_value("playerDialogBuffer", 0));
	}
}

/*
	Name: function_94b5718c
	Namespace: battlechatter
	Checksum: 0x7E281008
	Offset: 0xB500
	Size: 0xF2
	Parameters: 1
	Flags: Linked
*/
function function_94b5718c(entity)
{
	selfeye = self geteyeapprox();
	foreach(enemy in get_enemy_players())
	{
		if(!isdefined(enemy))
		{
			continue;
		}
		enemyeye = enemy geteyeapprox();
		if(sighttracepassed(selfeye, enemyeye, 0, enemy))
		{
			return enemy;
		}
	}
	return undefined;
}

/*
	Name: play_gadget_activate
	Namespace: battlechatter
	Checksum: 0xF3A33169
	Offset: 0xB600
	Size: 0x804
	Parameters: 1
	Flags: Linked
*/
function play_gadget_activate(weapon)
{
	if(!level.allowspecialistdialog || !isdefined(self) || !isplayer(self))
	{
		return;
	}
	if(!isdefined(weapon) || self isplayerunderwater())
	{
		return;
	}
	bundlename = self getmpdialogname();
	if(!isdefined(bundlename))
	{
		return;
	}
	playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
	if(!isdefined(playerbundle))
	{
		return;
	}
	dialogkey = undefined;
	dialogflags = 2;
	switch(weapon.name)
	{
		case "hero_annihilator":
		{
			dialogkey = playerbundle.annihilatorweaponuse;
			break;
		}
		case "sig_buckler_dw":
		{
			dialogkey = playerbundle.var_f32e2;
			break;
		}
		case "hash_52aca7c35be649b8":
		case "gadget_cleanse":
		{
			dialogkey = playerbundle.var_2292382;
			break;
		}
		case "hatchet":
		{
			dialogkey = playerbundle.var_8ba3822;
			break;
		}
		case "eq_slow_grenade":
		case "concussion_grenade":
		{
			dialogkey = playerbundle.var_426ce83a;
			break;
		}
		case "eq_swat_grenade":
		case "hash_3f62a872201cd1ce":
		case "hash_5825488ac68418af":
		{
			dialogkey = playerbundle.var_b3d4d56b;
			break;
		}
		case "frag_grenade":
		{
			dialogkey = playerbundle.var_2f65caf3;
			break;
		}
		case "hash_3a19c6a9c8caef33":
		{
			dialogkey = playerbundle.var_a97283ea;
			dialogbuffer = 0.05;
			break;
		}
		case "hash_4bb2d7f789b561eb":
		{
			if(grapple::function_d79e9bb5(self, undefined, undefined, undefined))
			{
				dialogkey = playerbundle.var_71187505;
				dialogflags = (dialogflags | 6) | 16;
				dialogbuffer = 0.05;
				self.var_6765d33e = 1;
			}
			break;
		}
		case "eq_localheal":
		{
			if(self.var_b6971302 === 1)
			{
				dialogkey = playerbundle.var_f0bfec90;
				var_4d031df6 = playerbundle.var_6cf57d59;
				self.var_b6971302 = undefined;
			}
			else
			{
				return;
			}
			break;
		}
		case "mini_turret":
		{
			dialogkey = playerbundle.var_80253e65;
			break;
		}
		case "eq_molotov":
		{
			dialogkey = playerbundle.var_e324183;
			break;
		}
		case "hash_2ce2e438ecd6b2d2":
		{
			dialogkey = playerbundle.p8_chi_fuel_tank_large_01_catwalk_ladder_ring01;
			break;
		}
		case "hero_flamethrower":
		{
			self function_bd715920(weapon, self, self.origin, self);
			dialogkey = playerbundle.purifierweaponuse;
			break;
		}
		case "gadget_radiation_field":
		{
			dialogkey = playerbundle.var_44c8bf55;
			break;
		}
		case "hash_4a4ba36128b6582f":
		{
			dialogkey = playerbundle.var_931b8099;
			break;
		}
		case "eq_cluster_semtex_grenade":
		{
			dialogkey = playerbundle.var_da293cfd;
			break;
		}
		case "eq_sensor":
		{
			dialogkey = playerbundle.var_8a8c748;
			var_4d031df6 = playerbundle.var_15990d1b;
			break;
		}
		case "eq_tripwire":
		{
			if((isdefined(self.var_9e50f96) ? self.var_9e50f96 : 0) + (float(mpdialog_value("tripwireUseCooldown", 0)) / 1000) < gettime())
			{
				dialogkey = playerbundle.var_9ee8c066;
				self.var_9e50f96 = gettime();
			}
			break;
		}
		case "trophy_system":
		{
			dialogkey = playerbundle.var_6505d47a;
			break;
		}
		case "gadget_vision_pulse":
		{
			dialogkey = playerbundle.visionpulseabilityuse;
			var_4d031df6 = playerbundle.var_8c880e98;
			break;
		}
		case "gadget_spawnbeacon":
		{
			var_3bf73cf3 = function_94b5718c(self);
			if(isdefined(var_3bf73cf3))
			{
				var_3bf73cf3 function_95e44f78(weapon, 0);
			}
			break;
		}
		case "hash_21b346649d376bf3":
		{
			dialogkey = playerbundle.var_cfa272a3;
			var_4d031df6 = playerbundle.var_b004cb37;
			var_3bf73cf3 = function_94b5718c(self);
			if(isdefined(var_3bf73cf3))
			{
				var_3bf73cf3 function_95e44f78(weapon, 0);
			}
			break;
		}
		case "gadget_icepick":
		{
			var_3bf73cf3 = function_94b5718c(self);
			if(isdefined(var_3bf73cf3))
			{
				var_3bf73cf3 function_95e44f78(weapon, 0);
			}
			break;
		}
		case "eq_hawk":
		{
			dialogkey = playerbundle.var_ce864f4c;
			break;
		}
		case "sig_blade":
		{
			dialogkey = playerbundle.var_4acffa3b;
			var_4d031df6 = playerbundle.var_3922bf3e;
			break;
		}
		case "sig_lmg":
		{
			dialogkey = playerbundle.var_d30ab48d;
			break;
		}
		case "hash_f525ab9cc66c061":
		{
			dialogkey = playerbundle.var_6ca16623;
			break;
		}
		case "eq_smoke":
		{
			dialogkey = playerbundle.p8_chi_fuel_tank_large_01_catwalk_ladder_ring01;
			var_4d031df6 = playerbundle.var_54bd09ab;
			var_3bf73cf3 = function_94b5718c(self);
			if(isdefined(var_3bf73cf3))
			{
				var_3bf73cf3 function_95e44f78(weapon, 0);
			}
			break;
		}
		default:
		{
			return;
		}
	}
	if(!self hasperk(#"specialty_quieter"))
	{
		self thread function_a48c33ff(dialogkey, dialogflags, dialogbuffer, undefined);
	}
	if(isdefined(var_4d031df6))
	{
		self function_253c2ba4(var_4d031df6, dialogbuffer);
	}
}

/*
	Name: function_bf68a5ab
	Namespace: battlechatter
	Checksum: 0xDE8E5F8B
	Offset: 0xBE10
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function function_bf68a5ab(var_4d5833c)
{
	if(!isdefined(self) || !isplayer(self) || !level.allowspecialistdialog)
	{
		return;
	}
	dialogalias = self get_player_dialog_alias(var_4d5833c, undefined);
	self function_253c2ba4(dialogalias, undefined);
}

/*
	Name: function_253c2ba4
	Namespace: battlechatter
	Checksum: 0xCBC23040
	Offset: 0xBEA0
	Size: 0x298
	Parameters: 2
	Flags: Linked, Private
*/
function private function_253c2ba4(var_cf210c5b, dialogbuffer)
{
	if(!level.allowspecialistdialog || !isdefined(self) || !isplayer(self) || !isdefined(var_cf210c5b))
	{
		return;
	}
	if(!isdefined(dialogbuffer))
	{
		dialogbuffer = mpdialog_value("playerDialogBuffer", 0);
	}
	teamarray = getplayers(self.team);
	if(self hasperk(#"specialty_quieter"))
	{
		arrayremovevalue(teamarray, self, 0);
	}
	else
	{
		localplayers = getplayers(self.team, self.origin, 1200);
		foreach(localplayer in localplayers)
		{
			arrayremovevalue(teamarray, localplayer, 0);
		}
	}
	foreach(player in teamarray)
	{
		if(!isdefined(player) || !isalive(player) || (isdefined(player.playingdialog) && player.playingdialog && (!(isdefined(player.var_6765d33e) && player.var_6765d33e))))
		{
			continue;
		}
		player.var_6765d33e = 0;
		player playsoundtoplayer(var_cf210c5b, player);
		player thread wait_dialog_buffer(dialogbuffer);
	}
}

/*
	Name: play_gadget_success
	Namespace: battlechatter
	Checksum: 0x82C0039E
	Offset: 0xC140
	Size: 0x28C
	Parameters: 4
	Flags: Linked
*/
function play_gadget_success(weapon, waitkey, victim, var_5d738b56)
{
	if(!level.allowspecialistdialog || !isdefined(self) || !isplayer(self) || self hasperk(#"specialty_quieter"))
	{
		return;
	}
	if(!isdefined(weapon) || !level.teambased)
	{
		return;
	}
	bundlename = self getmpdialogname();
	if(!isdefined(bundlename))
	{
		return;
	}
	playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
	if(!isdefined(playerbundle))
	{
		return;
	}
	var_2c976a90 = 0;
	switch(weapon.name)
	{
		case "eq_hawk":
		case "gadget_supplypod":
		case "gadget_vision_pulse":
		case "eq_localheal":
		case "eq_sensor":
		case "hash_23dd6039fe2f36c6":
		case "eq_swat_grenade":
		case "hash_3a19c6a9c8caef33":
		case "hash_3f62a872201cd1ce":
		case "eq_smoke":
		case "eq_concertina_wire":
		case "hash_52aca7c35be649b8":
		case "hash_5825488ac68418af":
		case "eq_molotov":
		case "gadget_cleanse":
		case "gadget_radiation_field":
		case "gadget_icepick":
		{
			var_2c976a90 = 1;
			break;
		}
		default:
		{
			return;
		}
	}
	if(var_2c976a90 === 1)
	{
		self.playedgadgetsuccess = 1;
		self function_18aba49d(0, weapon, var_5d738b56);
	}
}

/*
	Name: function_4fb91bc7
	Namespace: battlechatter
	Checksum: 0x6D645E06
	Offset: 0xC3D8
	Size: 0x5C6
	Parameters: 3
	Flags: Linked
*/
function function_4fb91bc7(weapon, var_df17fa82, var_53c10ed8)
{
	if(!isdefined(weapon) || !isdefined(var_df17fa82) || !isplayer(var_df17fa82) || !isdefined(self) || !isplayer(self))
	{
		return;
	}
	switch(weapon.name)
	{
		case "hash_21b346649d376bf3":
		{
			var_60d3002f = "jammerWeaponHacked";
			break;
		}
		case "eq_tripwire":
		{
			var_60d3002f = "meshMineWeaponHacked";
			var_b3fe42a9 = 1;
			break;
		}
		case "hash_4a4ba36128b6582f":
		{
			var_60d3002f = "seekerMineWeaponHacked";
			var_b3fe42a9 = 1;
			break;
		}
		case "eq_sensor":
		{
			var_60d3002f = "sensorDartHacked";
			var_b3fe42a9 = 1;
			break;
		}
		case "ability_smart_cover":
		case "hash_1fb0b26684caee0f":
		{
			var_60d3002f = "smartCoverHacked";
			var_b3fe42a9 = 1;
			break;
		}
		case "gadget_spawnbeacon":
		{
			var_60d3002f = "spawnBeaconHacked";
			break;
		}
		case "gadget_supplypod":
		{
			var_60d3002f = "supplyPodHacked";
			var_b3fe42a9 = 1;
			break;
		}
		case "trophy_system":
		{
			var_60d3002f = "trophyWeaponHacked";
			var_b3fe42a9 = 1;
			break;
		}
		case "hash_459c0007ec5e2470":
		case "ac130":
		{
			var_60d3002f = "ac130Hacked";
			break;
		}
		case "tank_robot":
		case "inventory_tank_robot":
		case "ai_tank_marker":
		{
			var_60d3002f = "aiTankHacked";
			var_b3fe42a9 = 1;
			break;
		}
		case "cobra_20mm_comlink":
		case "helicopter_comlink":
		case "inventory_helicopter_comlink":
		{
			var_60d3002f = "attackChopperHacked";
			break;
		}
		case "counteruav":
		{
			var_60d3002f = "cuavHacked";
			var_b3fe42a9 = 1;
			break;
		}
		case "dart":
		case "inventory_dart":
		{
			var_60d3002f = "dartHacked";
			break;
		}
		case "drone_squadron":
		case "hash_3447a6457d26a42e":
		{
			var_60d3002f = "droneSquadHacked";
			var_b3fe42a9 = 1;
			break;
		}
		case "recon_car":
		case "inventory_recon_car":
		{
			var_60d3002f = "reconCarHacked";
			break;
		}
		case "remote_missile":
		case "inventory_remote_missile":
		{
			var_60d3002f = "hellstormHacked";
			break;
		}
		case "inventory_planemortar":
		case "planemortar":
		{
			var_60d3002f = "lightningStrikeHacked";
			break;
		}
		case "overwatch_helicopter":
		case "hash_74ea4af18853e9af":
		{
			var_60d3002f = "overwatchHelicopterHacked";
			break;
		}
		case "hash_4307d5aaa7ce21d4":
		case "straferun":
		{
			var_60d3002f = "strafeRunHacked";
			break;
		}
		case "supplydrop":
		{
			var_60d3002f = "supplyDropHacked";
			var_b3fe42a9 = 1;
			break;
		}
		case "uav":
		{
			var_60d3002f = "uavHacked";
			var_b3fe42a9 = 1;
			break;
		}
		case "ultimate_turret":
		case "inventory_ultimate_turret":
		{
			var_60d3002f = "sentryHacked";
			var_b3fe42a9 = 1;
			break;
		}
	}
	if(!isdefined(var_60d3002f))
	{
		return;
	}
	if((isdefined(self.var_d6422943) ? self.var_d6422943 : 0) > gettime())
	{
		self thread killstreaks::play_taacom_dialog(var_60d3002f);
	}
	else
	{
		if(var_b3fe42a9 === 1)
		{
			if(var_53c10ed8 === 1)
			{
				self thread killstreaks::play_taacom_dialog(var_60d3002f, undefined, undefined, 5, var_df17fa82, weapon);
			}
			else
			{
				self thread killstreaks::play_taacom_dialog(var_60d3002f, undefined, undefined, 3, var_df17fa82, weapon);
			}
		}
		else
		{
			self thread killstreaks::play_taacom_dialog(var_60d3002f, undefined, undefined, 4, var_df17fa82);
		}
		var_fc9a842 = mpdialog_value("taacomHackedReplyCooldownSec", 0);
		self.var_d6422943 = gettime() + (int(var_fc9a842 * 1000));
	}
}

/*
	Name: play_throw_hatchet
	Namespace: battlechatter
	Checksum: 0x4A94A834
	Offset: 0xC9A8
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function play_throw_hatchet()
{
	self.var_6765d33e = 1;
	self thread play_dialog("exertAxeThrow", 22, mpdialog_value("playerExertBuffer", 0));
}

/*
	Name: function_59f9cdab
	Namespace: battlechatter
	Checksum: 0xF6CB22C1
	Offset: 0xCA00
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function function_59f9cdab()
{
	bundlename = self getmpdialogname();
	if(!isdefined(bundlename))
	{
		return;
	}
	playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
	if(!isdefined(playerbundle))
	{
		return;
	}
	if(isdefined(self.currentweapon))
	{
		if(self.currentweapon === getweapon(#"hash_68a980198a51e72b"))
		{
			return;
		}
	}
	self thread function_a48c33ff(playerbundle.var_1ca33ad4, 22, mpdialog_value("playerExertBuffer", 0));
}

/*
	Name: get_enemy_players
	Namespace: battlechatter
	Checksum: 0x6DB26A2C
	Offset: 0xCAE0
	Size: 0x192
	Parameters: 0
	Flags: Linked
*/
function get_enemy_players()
{
	players = [];
	if(level.teambased)
	{
		foreach(team, _ in level.teams)
		{
			if(team == self.team)
			{
				continue;
			}
			foreach(player in level.aliveplayers[team])
			{
				players[players.size] = player;
			}
		}
	}
	else
	{
		foreach(player in level.activeplayers)
		{
			if(player != self)
			{
				players[players.size] = player;
			}
		}
	}
	return players;
}

/*
	Name: get_friendly_players
	Namespace: battlechatter
	Checksum: 0x7A5B2CA3
	Offset: 0xCC80
	Size: 0xD0
	Parameters: 0
	Flags: Linked
*/
function get_friendly_players()
{
	players = [];
	if(level.teambased && isdefined(self.team) && isdefined(level.aliveplayers))
	{
		foreach(player in level.aliveplayers[self.team])
		{
			players[players.size] = player;
		}
	}
	else
	{
		players[0] = self;
	}
	return players;
}

/*
	Name: can_play_dialog
	Namespace: battlechatter
	Checksum: 0xA62E4235
	Offset: 0xCD58
	Size: 0x100
	Parameters: 1
	Flags: Linked
*/
function can_play_dialog(teamonly)
{
	if(!isplayer(self) || !isalive(self) || self.playingdialog === 1 || self isplayerunderwater() || self isremotecontrolling() || self isinvehicle() || self isweaponviewonlylinked())
	{
		return false;
	}
	if(isdefined(teamonly) && !teamonly && self hasperk(#"specialty_quieter"))
	{
		return false;
	}
	return true;
}

/*
	Name: get_closest_player_enemy
	Namespace: battlechatter
	Checksum: 0xA887944B
	Offset: 0xCE60
	Size: 0xE6
	Parameters: 2
	Flags: Linked
*/
function get_closest_player_enemy(origin = self.origin, teamonly)
{
	players = self get_enemy_players();
	players = arraysort(players, origin);
	foreach(player in players)
	{
		if(!player can_play_dialog(teamonly))
		{
			continue;
		}
		return player;
	}
	return undefined;
}

/*
	Name: get_closest_player_ally
	Namespace: battlechatter
	Checksum: 0xEE30DC9B
	Offset: 0xCF50
	Size: 0xF2
	Parameters: 1
	Flags: Linked
*/
function get_closest_player_ally(teamonly)
{
	if(!level.teambased)
	{
		return undefined;
	}
	players = self get_friendly_players();
	players = arraysort(players, self.origin);
	foreach(player in players)
	{
		if(player == self || !player can_play_dialog(teamonly))
		{
			continue;
		}
		return player;
	}
	return undefined;
}

/*
	Name: check_boost_start_conversation
	Namespace: battlechatter
	Checksum: 0x3148F3AA
	Offset: 0xD050
	Size: 0x1B2
	Parameters: 0
	Flags: None
*/
function check_boost_start_conversation()
{
	if(!level.playstartconversation)
	{
		return;
	}
	if(!level.inprematchperiod || !level.teambased || game.boostplayerspicked[self.team])
	{
		return;
	}
	players = self get_friendly_players();
	array::add(players, self, 0);
	players = array::randomize(players);
	playerindex = 1;
	foreach(player in players)
	{
		playerdialog = player getmpdialogname();
		for(i = playerindex; i < players.size; i++)
		{
			playeri = players[i];
			if(playerdialog != playeri getmpdialogname())
			{
				pick_boost_players(player, playeri);
				return;
			}
		}
		playerindex++;
	}
}

/*
	Name: pick_boost_players
	Namespace: battlechatter
	Checksum: 0xCCEB773B
	Offset: 0xD210
	Size: 0x72
	Parameters: 2
	Flags: Linked
*/
function pick_boost_players(player1, player2)
{
	player1 clientfield::set("play_boost", 1);
	player2 clientfield::set("play_boost", 2);
	game.boostplayerspicked[player1.team] = 1;
}

/*
	Name: game_end_vox
	Namespace: battlechatter
	Checksum: 0xDEFD3AD0
	Offset: 0xD290
	Size: 0x1E8
	Parameters: 1
	Flags: None
*/
function game_end_vox(winner)
{
	if(!level.allowspecialistdialog)
	{
		return;
	}
	foreach(player in level.players)
	{
		if(player issplitscreen())
		{
			continue;
		}
		bundlename = player getmpdialogname();
		if(!isdefined(bundlename))
		{
			return;
		}
		playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
		if(!isdefined(playerbundle))
		{
			return;
		}
		if(match::function_5f24faac("tie"))
		{
			dialogkey = playerbundle.boostdraw;
		}
		else
		{
			if(isdefined(winner) && (level.teambased && isdefined(level.teams[winner]) && player.pers[#"team"] == winner) || (!level.teambased && player == winner))
			{
				dialogkey = playerbundle.boostwin;
			}
			else
			{
				dialogkey = playerbundle.boostloss;
			}
		}
		if(isdefined(dialogkey))
		{
			player playlocalsound(dialogkey);
		}
	}
}

/*
	Name: function_72b65730
	Namespace: battlechatter
	Checksum: 0x4073C1BD
	Offset: 0xD480
	Size: 0xBC
	Parameters: 0
	Flags: None
*/
function function_72b65730()
{
	bundlename = self getmpdialogname();
	if(!isdefined(bundlename))
	{
		return;
	}
	playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
	if(!isdefined(playerbundle))
	{
		return;
	}
	dialogkey = playerbundle.var_96b4150c;
	waittime = mpdialog_value("playerExertBuffer", 0);
	thread function_5896274(waittime, dialogkey, 2);
}

/*
	Name: function_e44c3a3c
	Namespace: battlechatter
	Checksum: 0x47FA3B06
	Offset: 0xD548
	Size: 0x54
	Parameters: 5
	Flags: Linked
*/
function function_e44c3a3c(weapon, attacker, var_87017634, var_d963f0cf, timedelay)
{
	self function_bd715920(weapon, attacker, var_87017634, var_d963f0cf, timedelay);
}

/*
	Name: devgui_think
	Namespace: battlechatter
	Checksum: 0x289AB8EE
	Offset: 0xD5A8
	Size: 0x408
	Parameters: 0
	Flags: None
*/
function devgui_think()
{
	/#
		setdvar(#"devgui_mpdialog", "");
		setdvar(#"testalias_player", "");
		setdvar(#"testalias_taacom", "");
		setdvar(#"testalias_commander", "");
		while(true)
		{
			wait(1);
			player = util::gethostplayer();
			if(!isdefined(player))
			{
				continue;
			}
			spacing = getdvarfloat(#"testdialog_spacing", 0.25);
			switch(getdvarstring(#"devgui_mpdialog", ""))
			{
				case "hash_7912e80189f9c6":
				{
					player thread test_player_dialog(0);
					player thread test_taacom_dialog(spacing);
					player thread test_commander_dialog(2 * spacing);
					break;
				}
				case "hash_69c6be086f76a9d4":
				{
					player thread test_player_dialog(0);
					player thread test_commander_dialog(spacing);
					break;
				}
				case "hash_3af5f0a904b3f8fa":
				{
					player thread test_other_dialog(0);
					player thread test_commander_dialog(spacing);
					break;
				}
				case "hash_32945da5f7ac491":
				{
					player thread test_taacom_dialog(0);
					player thread test_commander_dialog(spacing);
					break;
				}
				case "hash_597b27a5c8857d19":
				{
					player thread test_player_dialog(0);
					player thread test_taacom_dialog(spacing);
					break;
				}
				case "hash_74f798193af006b3":
				{
					player thread test_other_dialog(0);
					player thread test_taacom_dialog(spacing);
					break;
				}
				case "hash_5bd6a2c5d0ff3cb2":
				{
					player thread test_other_dialog(0);
					player thread test_player_dialog(spacing);
					break;
				}
				case "hash_4a5a66c89be92eb":
				{
					player thread play_conv_self_other();
					break;
				}
				case "hash_18683ef7652f40ed":
				{
					player thread play_conv_other_self();
					break;
				}
				case "hash_2b559b1a5e81715f":
				{
					player thread play_conv_other_other();
					break;
				}
			}
			setdvar(#"devgui_mpdialog", "");
		}
	#/
}

/*
	Name: test_other_dialog
	Namespace: battlechatter
	Checksum: 0x1660CC85
	Offset: 0xD9B8
	Size: 0xE2
	Parameters: 1
	Flags: None
*/
function test_other_dialog(delay)
{
	/#
		players = arraysort(level.players, self.origin);
		foreach(player in players)
		{
			if(player != self && isalive(player))
			{
				player thread test_player_dialog(delay);
				return;
			}
		}
	#/
}

/*
	Name: test_player_dialog
	Namespace: battlechatter
	Checksum: 0xBEA9FAE9
	Offset: 0xDAA8
	Size: 0x64
	Parameters: 1
	Flags: None
*/
function test_player_dialog(delay)
{
	/#
		if(!isdefined(delay))
		{
			delay = 0;
		}
		wait(delay);
		self playsoundontag(getdvarstring(#"testalias_player", ""), "");
	#/
}

/*
	Name: test_taacom_dialog
	Namespace: battlechatter
	Checksum: 0x46C688EA
	Offset: 0xDB18
	Size: 0x5C
	Parameters: 1
	Flags: None
*/
function test_taacom_dialog(delay)
{
	/#
		if(!isdefined(delay))
		{
			delay = 0;
		}
		wait(delay);
		self playlocalsound(getdvarstring(#"testalias_taacom", ""));
	#/
}

/*
	Name: test_commander_dialog
	Namespace: battlechatter
	Checksum: 0x44526A02
	Offset: 0xDB80
	Size: 0x5C
	Parameters: 1
	Flags: None
*/
function test_commander_dialog(delay)
{
	/#
		if(!isdefined(delay))
		{
			delay = 0;
		}
		wait(delay);
		self playlocalsound(getdvarstring(#"testalias_commander", ""));
	#/
}

/*
	Name: play_test_dialog
	Namespace: battlechatter
	Checksum: 0x30F41745
	Offset: 0xDBE8
	Size: 0x54
	Parameters: 1
	Flags: None
*/
function play_test_dialog(dialogkey)
{
	/#
		dialogalias = self get_player_dialog_alias(dialogkey, undefined);
		self playsoundontag(dialogalias, "");
	#/
}

/*
	Name: response_key
	Namespace: battlechatter
	Checksum: 0xE6A1B674
	Offset: 0xDC48
	Size: 0x10A
	Parameters: 0
	Flags: None
*/
function response_key()
{
	/#
		switch(self getmpdialogname())
		{
			case "spectre":
			{
				return "";
			}
			case "battery":
			{
				return "";
			}
			case "outrider":
			{
				return "";
			}
			case "prophet":
			{
				return "";
			}
			case "firebreak":
			{
				return "";
			}
			case "reaper":
			{
				return "";
			}
			case "ruin":
			{
				return "";
			}
			case "seraph":
			{
				return "";
			}
			case "nomad":
			{
				return "";
			}
		}
		return "";
	#/
}

/*
	Name: play_conv_self_other
	Namespace: battlechatter
	Checksum: 0xA48B39C9
	Offset: 0xDD60
	Size: 0x13C
	Parameters: 0
	Flags: None
*/
function play_conv_self_other()
{
	/#
		num = randomintrange(0, 4);
		self play_test_dialog("" + num);
		wait(4);
		players = arraysort(level.players, self.origin);
		foreach(player in players)
		{
			if(player != self && isalive(player))
			{
				player play_test_dialog(("" + self response_key()) + num);
				break;
			}
		}
	#/
}

/*
	Name: play_conv_other_self
	Namespace: battlechatter
	Checksum: 0x2F7FC5AD
	Offset: 0xDEA8
	Size: 0x13C
	Parameters: 0
	Flags: None
*/
function play_conv_other_self()
{
	/#
		num = randomintrange(0, 4);
		players = arraysort(level.players, self.origin);
		foreach(player in players)
		{
			if(player != self && isalive(player))
			{
				player play_test_dialog("" + num);
				break;
			}
		}
		wait(4);
		self play_test_dialog(("" + player response_key()) + num);
	#/
}

/*
	Name: play_conv_other_other
	Namespace: battlechatter
	Checksum: 0x8C1BBD84
	Offset: 0xDFF0
	Size: 0x1DC
	Parameters: 0
	Flags: None
*/
function play_conv_other_other()
{
	/#
		num = randomintrange(0, 4);
		players = arraysort(level.players, self.origin);
		foreach(player in players)
		{
			if(player != self && isalive(player))
			{
				player play_test_dialog("" + num);
				firstplayer = player;
				break;
			}
		}
		wait(4);
		foreach(player in players)
		{
			if(player != self && player !== firstplayer && isalive(player))
			{
				player play_test_dialog(("" + firstplayer response_key()) + num);
				break;
			}
		}
	#/
}

