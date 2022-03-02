// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2255a7ad3edc838f;
#using script_2dc48f46bfeac894;
#using script_3f27a7b2232674db;
#using script_47fb62300ac0bd60;
#using script_545a0bac37bda541;
#using script_56ca01b3b31455b5;
#using script_68d2ee1489345a1d;
#using script_6c8abe14025b47c4;
#using script_7133a4d461308099;
#using scripts\core_common\bb_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\contracts_shared.gsc;
#using scripts\core_common\loadout_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\persistence_shared.gsc;
#using scripts\core_common\potm_shared.gsc;
#using scripts\core_common\rank_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\mp_common\callbacks.gsc;
#using scripts\mp_common\challenges.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\mp_common\gametypes\globallogic_audio.gsc;
#using scripts\mp_common\gametypes\globallogic_score.gsc;
#using scripts\mp_common\gametypes\globallogic_utils.gsc;
#using scripts\mp_common\gametypes\match.gsc;
#using scripts\mp_common\gametypes\outcome.gsc;
#using scripts\mp_common\scoreevents.gsc;
#using scripts\mp_common\util.gsc;

#namespace globallogic_score;

/*
	Name: __init__
	Namespace: globallogic_score
	Checksum: 0x41F8652B
	Offset: 0x3C8
	Size: 0x154
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__()
{
	level.scoreevents_givekillstats = &givekillstats;
	level.scoreevents_processassist = &function_b1a3b359;
	clientfield::register("clientuimodel", "hudItems.scoreProtected", 1, 1, "int");
	clientfield::register("clientuimodel", "hudItems.minorActions.action0", 1, 1, "counter");
	clientfield::register("clientuimodel", "hudItems.minorActions.action1", 1, 1, "counter");
	clientfield::register("clientuimodel", "hudItems.hotStreak.level", 1, 3, "int");
	callback::on_joined_team(&function_253ff387);
	callback::on_joined_spectate(&function_30ab51a4);
	callback::function_7117ff72(&function_30ab51a4);
}

/*
	Name: main
	Namespace: globallogic_score
	Checksum: 0x6740EF6F
	Offset: 0x528
	Size: 0x26
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	level thread function_39193e3a();
}

/*
	Name: function_39193e3a
	Namespace: globallogic_score
	Checksum: 0x50F21094
	Offset: 0x558
	Size: 0x114
	Parameters: 0
	Flags: Linked
*/
function function_39193e3a()
{
	self notify("18852d080139d2c5");
	self endon("18852d080139d2c5");
	level endon(#"game_ended");
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(#"hero_gadget_activated");
		if(isdefined(waitresult.weapon) && isdefined(waitresult.player))
		{
			player = waitresult.player;
			if(isdefined(player.pers[#"hash_53919d92ff1d039"]))
			{
				scoreevents::function_6f51d1e9("battle_command_ultimate_command", player.pers[#"hash_53919d92ff1d039"], undefined, undefined);
				player.pers[#"hash_53919d92ff1d039"] = undefined;
			}
		}
	}
}

/*
	Name: function_eaa4e6f7
	Namespace: globallogic_score
	Checksum: 0x9D749133
	Offset: 0x678
	Size: 0x98
	Parameters: 0
	Flags: Linked
*/
function function_eaa4e6f7()
{
	if(!level.timelimit || level.forcedend)
	{
		gamelength = float(globallogic_utils::gettimepassed()) / 1000;
		gamelength = min(gamelength, 1200);
	}
	else
	{
		gamelength = level.timelimit * 60;
	}
	return gamelength;
}

/*
	Name: function_61f303f5
	Namespace: globallogic_score
	Checksum: 0x4857855E
	Offset: 0x718
	Size: 0x48
	Parameters: 1
	Flags: Linked
*/
function function_61f303f5(var_7da9f0c)
{
	totaltimeplayed = self.timeplayed[#"total"];
	if(totaltimeplayed > var_7da9f0c)
	{
		totaltimeplayed = var_7da9f0c;
	}
	return totaltimeplayed;
}

/*
	Name: function_c9de50a6
	Namespace: globallogic_score
	Checksum: 0x9A4343B0
	Offset: 0x768
	Size: 0x8E
	Parameters: 1
	Flags: Linked
*/
function function_c9de50a6(player)
{
	for(pidx = 0; pidx < min(level.placement[#"all"].size, 3); pidx++)
	{
		if(level.placement[#"all"][pidx] != player)
		{
			continue;
		}
		return true;
	}
	return false;
}

/*
	Name: function_78e7b549
	Namespace: globallogic_score
	Checksum: 0xD2390C3D
	Offset: 0x800
	Size: 0xCA
	Parameters: 3
	Flags: Linked
*/
function function_78e7b549(scale, type, var_7da9f0c)
{
	var_f6ecfcf0 = self function_61f303f5(var_7da9f0c);
	spm = self rank::getspm();
	playerscore = int((scale * ((var_7da9f0c / 60) * spm)) * (var_f6ecfcf0 / var_7da9f0c));
	self thread givematchbonus(type, playerscore);
	self.matchbonus = playerscore;
}

/*
	Name: updatematchbonusscores
	Namespace: globallogic_score
	Checksum: 0xC387FC17
	Offset: 0x8D8
	Size: 0x3E6
	Parameters: 1
	Flags: Linked
*/
function updatematchbonusscores(outcome)
{
	if(!game.timepassed)
	{
		return;
	}
	if(!level.rankedmatch)
	{
		updatecustomgamewinner(outcome);
		return;
	}
	gamelength = function_eaa4e6f7();
	tie = outcome::function_5f24faac(outcome, "tie");
	if(tie)
	{
		winnerscale = 0.75;
		loserscale = 0.75;
	}
	else
	{
		winnerscale = 1;
		loserscale = 0.5;
	}
	winning_team = outcome::get_winning_team(outcome);
	players = level.players;
	foreach(player in players)
	{
		if(player.timeplayed[#"total"] < 1 || player.pers[#"participation"] < 1)
		{
			player thread rank::endgameupdate();
			continue;
		}
		if(level.hostforcedend && player ishost())
		{
			continue;
		}
		if(player.pers[#"score"] < 0)
		{
			continue;
		}
		if(isdefined(player.pers[#"team"]) && player.pers[#"team"] == #"spectator")
		{
			continue;
		}
		if(level.teambased)
		{
			if(tie)
			{
				player function_78e7b549(winnerscale, "tie", gamelength);
			}
			else
			{
				if(isdefined(player.pers[#"team"]) && player.pers[#"team"] == winning_team)
				{
					player function_78e7b549(winnerscale, "win", gamelength);
				}
				else
				{
					player function_78e7b549(loserscale, "loss", gamelength);
				}
			}
		}
		else
		{
			if(function_c9de50a6(player))
			{
				player function_78e7b549(winnerscale, "win", gamelength);
			}
			else
			{
				player function_78e7b549(loserscale, "loss", gamelength);
			}
		}
		player.pers[#"totalmatchbonus"] = player.pers[#"totalmatchbonus"] + player.matchbonus;
	}
}

/*
	Name: updatecustomgamewinner
	Namespace: globallogic_score
	Checksum: 0x2743946D
	Offset: 0xCC8
	Size: 0x26E
	Parameters: 1
	Flags: Linked
*/
function updatecustomgamewinner(outcome)
{
	if(!level.mpcustommatch)
	{
		return;
	}
	var_6f86cba9 = outcome::get_winning_team(outcome);
	tie = outcome::function_5f24faac(outcome, "tie");
	foreach(player in level.players)
	{
		if(!isdefined(var_6f86cba9))
		{
			player.pers[#"victory"] = 0;
		}
		else
		{
			if(level.teambased)
			{
				if(player.team == var_6f86cba9)
				{
					player.pers[#"victory"] = 2;
				}
				else
				{
					if(tie)
					{
						player.pers[#"victory"] = 1;
					}
					else
					{
						player.pers[#"victory"] = 0;
					}
				}
			}
			else
			{
				if(function_c9de50a6(player))
				{
					player.pers[#"victory"] = 2;
				}
				else
				{
					player.pers[#"victory"] = 0;
				}
			}
		}
		player.victory = player.pers[#"victory"];
		player.pers[#"sbtimeplayed"] = player.timeplayed[#"total"];
		player.sbtimeplayed = player.pers[#"sbtimeplayed"];
	}
}

/*
	Name: givematchbonus
	Namespace: globallogic_score
	Checksum: 0x2883868
	Offset: 0xF40
	Size: 0xF4
	Parameters: 2
	Flags: Linked
*/
function givematchbonus(scoretype, score)
{
	self endon(#"disconnect");
	level waittill(#"give_match_bonus");
	if(!isdefined(self))
	{
		return;
	}
	if(function_f99d2668())
	{
		return;
	}
	if(scoreevents::shouldaddrankxp(self))
	{
		if(isdefined(self.pers) && isdefined(self.pers[#"totalmatchbonus"]))
		{
			score = self.pers[#"totalmatchbonus"];
		}
		self addrankxpvalue(scoretype, score);
	}
	self rank::endgameupdate();
}

/*
	Name: gethighestscoringplayer
	Namespace: globallogic_score
	Checksum: 0x2C38FB36
	Offset: 0x1040
	Size: 0x126
	Parameters: 0
	Flags: Linked
*/
function gethighestscoringplayer()
{
	players = level.players;
	winner = undefined;
	tie = 0;
	for(i = 0; i < players.size; i++)
	{
		if(!isdefined(players[i].pointstowin))
		{
			continue;
		}
		if(players[i].pointstowin < 1)
		{
			continue;
		}
		if(!isdefined(winner) || players[i].pointstowin > winner.pointstowin)
		{
			winner = players[i];
			tie = 0;
			continue;
		}
		if(players[i].pointstowin == winner.pointstowin)
		{
			tie = 1;
		}
	}
	if(tie || !isdefined(winner))
	{
		return undefined;
	}
	return winner;
}

/*
	Name: function_15683f39
	Namespace: globallogic_score
	Checksum: 0xE585DB36
	Offset: 0x1170
	Size: 0x11A
	Parameters: 0
	Flags: Linked
*/
function function_15683f39()
{
	players = level.players;
	var_3df849b3 = undefined;
	tie = 0;
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		if(!isdefined(player.score))
		{
			continue;
		}
		if(player.score < 1)
		{
			continue;
		}
		if(!isdefined(var_3df849b3) || player.score > var_3df849b3.score)
		{
			var_3df849b3 = player;
			tie = 0;
			continue;
		}
		if(player.score == var_3df849b3.score)
		{
			tie = 1;
		}
	}
	if(tie || !isdefined(var_3df849b3))
	{
		return undefined;
	}
	return var_3df849b3;
}

/*
	Name: resetplayerscorechainandmomentum
	Namespace: globallogic_score
	Checksum: 0xC5819F09
	Offset: 0x1298
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function resetplayerscorechainandmomentum(player)
{
	player thread _setplayermomentum(self, 0);
	player thread resetscorechain();
}

/*
	Name: resetscorechain
	Namespace: globallogic_score
	Checksum: 0xEB257253
	Offset: 0x12E0
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function resetscorechain()
{
	self notify(#"reset_score_chain");
	self.scorechain = 0;
	self.rankupdatetotal = 0;
}

/*
	Name: scorechaintimer
	Namespace: globallogic_score
	Checksum: 0xFF6934E9
	Offset: 0x1318
	Size: 0x74
	Parameters: 0
	Flags: None
*/
function scorechaintimer()
{
	self notify(#"score_chain_timer");
	self endon(#"reset_score_chain", #"score_chain_timer", #"death", #"disconnect");
	wait(20);
	self thread resetscorechain();
}

/*
	Name: roundtonearestfive
	Namespace: globallogic_score
	Checksum: 0x967F95AB
	Offset: 0x1398
	Size: 0x50
	Parameters: 1
	Flags: Linked
*/
function roundtonearestfive(score)
{
	rounding = score % 5;
	if(rounding <= 2)
	{
		return score - rounding;
	}
	return score + (5 - rounding);
}

/*
	Name: giveplayermomentumnotification
	Namespace: globallogic_score
	Checksum: 0xF4C4DF22
	Offset: 0x13F8
	Size: 0x394
	Parameters: 9
	Flags: Linked
*/
function giveplayermomentumnotification(score, label, descvalue, countstowardrampage, weapon, combatefficiencybonus = 0, eventindex, event, var_36f23f1f)
{
	score = score + combatefficiencybonus;
	if(isdefined(level.var_5ee570bd) && level.var_5ee570bd)
	{
		score = rank::function_bcb5e246(event);
		if(!isdefined(score))
		{
			score = 0;
		}
	}
	if(score != 0)
	{
		if(!isdefined(eventindex))
		{
			eventindex = 1;
		}
		self luinotifyevent(#"score_event", 4, label, score, combatefficiencybonus, eventindex);
		self function_b552ffa9(#"score_event", 4, label, score, combatefficiencybonus, eventindex);
		potm::function_d6b60141(#"score_event", self, label, score, combatefficiencybonus, eventindex);
	}
	if(isdefined(event) && isdefined(level.scoreinfo[event][#"hash_7fe1763a3ac14691"]) && level.scoreinfo[event][#"hash_7fe1763a3ac14691"] == "hotstreak")
	{
		if(!isdefined(var_36f23f1f) || var_36f23f1f < 2)
		{
			self luinotifyevent(#"hash_468a2878939e8c64", 1, eventindex);
			self function_b552ffa9(#"hash_468a2878939e8c64", 1, eventindex);
		}
		else
		{
			self luinotifyevent(#"hash_468a2878939e8c64", 2, eventindex, var_36f23f1f);
			self function_b552ffa9(#"hash_468a2878939e8c64", 2, eventindex, var_36f23f1f);
		}
	}
	score = score;
	if(score > 0 && self hasperk(#"specialty_earnmoremomentum"))
	{
		score = roundtonearestfive(int((score * getdvarfloat(#"perk_killstreakmomentummultiplier", 0)) + 0.5));
	}
	if(isalive(self))
	{
		if(isdefined(level.var_bdff8e21) && level.var_bdff8e21)
		{
			score = (event === #"kill" ? 1 : 0);
		}
		_setplayermomentum(self, self.pers[#"momentum"] + score);
	}
}

/*
	Name: function_49c10afe
	Namespace: globallogic_score
	Checksum: 0x6DC212AB
	Offset: 0x1798
	Size: 0x11E
	Parameters: 0
	Flags: None
*/
function function_49c10afe()
{
	if(isdefined(level.usingscorestreaks) && level.usingscorestreaks)
	{
		_setplayermomentum(self, 0);
		self thread resetscorechain();
		weaponslist = self getweaponslist();
		for(idx = 0; idx < weaponslist.size; idx++)
		{
			weapon = weaponslist[idx];
			if(killstreaks::is_killstreak_weapon(weapon))
			{
				quantity = killstreaks::get_killstreak_quantity(weapon);
				if(isdefined(quantity) && quantity > 0)
				{
					self killstreaks::change_killstreak_quantity(weapon, quantity * -1);
				}
			}
		}
	}
}

/*
	Name: resetplayermomentumonspawn
	Namespace: globallogic_score
	Checksum: 0x171F57B7
	Offset: 0x18C0
	Size: 0x1DC
	Parameters: 0
	Flags: Linked
*/
function resetplayermomentumonspawn()
{
	if(isdefined(level.usingscorestreaks) && level.usingscorestreaks)
	{
		var_a4e87ee3 = isdefined(self.deathtime) && self.deathtime > 0;
		var_a68a55cd = self function_80172c6();
		if(var_a4e87ee3 && var_a68a55cd > 0)
		{
			var_28749ebe = (isdefined(self.var_28749ebe) ? self.var_28749ebe : 0);
			var_347218dd = var_a68a55cd > var_28749ebe;
			if(var_347218dd)
			{
				self.var_28749ebe = var_28749ebe + 1;
				var_a4e87ee3 = 0;
			}
			else
			{
				self.var_28749ebe = undefined;
			}
		}
		else
		{
			self.var_28749ebe = undefined;
		}
		if(var_a4e87ee3)
		{
			new_momentum = int(self.pers[#"momentum"] * (1 - math::clamp(self function_3ef59ab3(), 0, 1)));
			_setplayermomentum(self, new_momentum);
			self thread resetscorechain();
		}
		var_8c68675a = var_a68a55cd > (isdefined(self.var_28749ebe) ? self.var_28749ebe : 0);
		self clientfield::set_player_uimodel("hudItems.scoreProtected", var_8c68675a);
	}
}

/*
	Name: giveplayermomentum
	Namespace: globallogic_score
	Checksum: 0xAF0A7231
	Offset: 0x1AA8
	Size: 0x314
	Parameters: 6
	Flags: Linked
*/
function giveplayermomentum(event, player, victim, descvalue, weapon, var_36f23f1f)
{
	if(isdefined(level.disablemomentum) && level.disablemomentum == 1)
	{
		return;
	}
	if(level.var_aa5e6547 === 1 && getdvarint(#"hash_1aa5f986ed71357d", 1) != 0)
	{
		if(isdefined(player) && !isalive(player))
		{
			return;
		}
	}
	score = player rank::getscoreinfovalue(event);
	/#
		assert(isdefined(score));
	#/
	label = rank::getscoreinfolabel(event);
	eventindex = level.scoreinfo[event][#"row"];
	countstowardrampage = rank::doesscoreinfocounttowardrampage(event);
	combatefficiencyscore = 0;
	if(player ability_util::gadget_combat_efficiency_enabled())
	{
		combatefficiencyscore = rank::function_4587103(event);
		if(isdefined(combatefficiencyscore) && combatefficiencyscore > 0)
		{
			player ability_util::gadget_combat_efficiency_power_drain(combatefficiencyscore);
			slot = -1;
			if(isdefined(weapon))
			{
				slot = player gadgetgetslot(weapon);
				var_973c6918 = player ability_util::gadget_slot_for_type(11);
			}
		}
	}
	if(event == "death")
	{
		_setplayermomentum(victim, victim.pers[#"momentum"] + score);
	}
	if(level.gameended)
	{
		return;
	}
	if(!isdefined(label))
	{
		player giveplayermomentumnotification(score, #"hash_480234a872bd64ac", descvalue, countstowardrampage, weapon, combatefficiencyscore, eventindex, event, var_36f23f1f);
		return;
	}
	player giveplayermomentumnotification(score, label, descvalue, countstowardrampage, weapon, combatefficiencyscore, eventindex, event, var_36f23f1f);
}

/*
	Name: giveplayerscore
	Namespace: globallogic_score
	Checksum: 0x3A036EB
	Offset: 0x1DC8
	Size: 0x346
	Parameters: 6
	Flags: Linked
*/
function giveplayerscore(event, player, victim, descvalue, weapon = level.weaponnone, var_36f23f1f)
{
	scorediff = 0;
	momentum = player.pers[#"momentum"];
	giveplayermomentum(event, player, victim, descvalue, weapon, var_36f23f1f);
	newmomentum = player.pers[#"momentum"];
	if(level.overrideplayerscore)
	{
		return 0;
	}
	pixbeginevent(#"hash_50e89abe6f3fe4f1");
	score = player.pers[#"score"];
	[[level.onplayerscore]](event, player, victim);
	newscore = player.pers[#"score"];
	pixendevent();
	isusingheropower = 0;
	if(player ability_player::is_using_any_gadget())
	{
		isusingheropower = 1;
	}
	scorediff = newscore - score;
	mpplayerscore = {};
	mpplayerscore.gamemode = level.gametype;
	mpplayerscore.spawnid = getplayerspawnid(player);
	mpplayerscore.var_e73ae35f = function_b14806c6(player player_role::get(), currentsessionmode());
	mpplayerscore.gametime = function_f8d53445();
	mpplayerscore.type = (function_7a600918(event) ? event : hash(event));
	mpplayerscore.isscoreevent = scoreevents::isregisteredevent(event);
	mpplayerscore.player = player.name;
	mpplayerscore.delta = scorediff;
	mpplayerscore.deltamomentum = newmomentum - momentum;
	mpplayerscore.team = player.team;
	mpplayerscore.isusingheropower = isusingheropower;
	self thread function_3172cf59(player, newscore, weapon, mpplayerscore);
	if(scorediff > 0)
	{
		return scorediff;
	}
	return 0;
}

/*
	Name: function_e1573815
	Namespace: globallogic_score
	Checksum: 0x39C7BCC6
	Offset: 0x2118
	Size: 0x76
	Parameters: 0
	Flags: Linked
*/
function function_e1573815()
{
	if(!isdefined(level.var_a5c930dd))
	{
		level.var_a5c930dd = 0;
	}
	if(!isdefined(level.var_445b1bca))
	{
		level.var_445b1bca = 0;
	}
	while(level.var_a5c930dd == gettime() || level.var_445b1bca == gettime())
	{
		waitframe(1);
	}
	level.var_a5c930dd = gettime();
}

/*
	Name: function_3172cf59
	Namespace: globallogic_score
	Checksum: 0x1164051B
	Offset: 0x2198
	Size: 0x574
	Parameters: 4
	Flags: Linked
*/
function function_3172cf59(player, newscore, weapon, mpplayerscore)
{
	player endon(#"disconnect");
	function_e1573815();
	pixbeginevent(#"hash_12a44df598cfa600");
	event = mpplayerscore.type;
	scorediff = mpplayerscore.delta;
	if(sessionmodeismultiplayergame() && !isbot(player))
	{
		function_92d1707f(#"hash_120b2cf3162c3bc1", mpplayerscore);
	}
	player bb::add_to_stat("score", mpplayerscore.delta);
	if(!isbot(player))
	{
		if(!isdefined(player.pers[#"hash_f9d3527022e8383"]))
		{
			player.pers[#"hash_f9d3527022e8383"] = [];
		}
		if(!isdefined(player.pers[#"hash_f9d3527022e8383"][event]))
		{
			player.pers[#"hash_f9d3527022e8383"][event] = 1;
		}
		else
		{
			player.pers[#"hash_f9d3527022e8383"][event] = player.pers[#"hash_f9d3527022e8383"][event] + 1;
		}
	}
	if(scorediff <= 0)
	{
		pixendevent();
		return;
	}
	recordplayerstats(player, "score", newscore);
	challengesenabled = !level.disablechallenges;
	player stats::function_bb7eedf0(#"score", scorediff);
	if(challengesenabled)
	{
		player stats::function_dad108fa(#"career_score", scorediff);
		scoreevents = function_3cbc4c6c(weapon.var_2e4a8800);
		var_8a4cfbd = weapon.var_76ce72e8 && isdefined(scoreevents) && scoreevents.var_fcd2ff3a === 1;
		if(var_8a4cfbd)
		{
			player stats::function_dad108fa(#"hash_6e9980514a73974", scorediff);
		}
		else if(weapon.var_b76e0a09)
		{
			player stats::function_dad108fa(#"hash_26cba7430b2ed7b1", scorediff);
		}
	}
	if(level.hardcoremode)
	{
		player stats::function_dad108fa(#"score_hc", scorediff);
		if(challengesenabled)
		{
			player stats::function_dad108fa(#"career_score_hc", scorediff);
		}
	}
	else if(!level.arenamatch)
	{
		player stats::function_bb7eedf0(#"hash_2b53b624764a0a41", scorediff);
	}
	if(level.arenamatch)
	{
		player stats::function_bb7eedf0(#"hash_6e15cfed6ce05699", scorediff);
	}
	if(level.multiteam)
	{
		player stats::function_dad108fa(#"score_multiteam", scorediff);
		if(challengesenabled)
		{
			player stats::function_dad108fa(#"career_score_multiteam", scorediff);
		}
	}
	player contracts::player_contract_event(#"score", newscore, scorediff);
	if(isdefined(weapon) && killstreaks::is_killstreak_weapon(weapon))
	{
		killstreak = killstreaks::get_from_weapon(weapon);
		killstreakpurchased = 0;
		if(isdefined(killstreak) && isdefined(level.killstreaks[killstreak]))
		{
			killstreakpurchased = player util::is_item_purchased(level.killstreaks[killstreak].menuname);
		}
		player contracts::player_contract_event(#"killstreak_score", scorediff, killstreakpurchased);
	}
	pixendevent();
}

/*
	Name: default_onplayerscore
	Namespace: globallogic_score
	Checksum: 0xB60536C2
	Offset: 0x2718
	Size: 0x144
	Parameters: 3
	Flags: Linked
*/
function default_onplayerscore(event, player, victim)
{
	score = player rank::getscoreinfovalue(event);
	rolescore = player rank::getscoreinfoposition(event);
	var_f22ee5e = 0;
	if(player rank::function_f7b5d9fa(event))
	{
		var_f22ee5e = score;
	}
	/#
		assert(isdefined(score));
	#/
	if(level.var_aa5e6547 === 1 && getdvarint(#"hash_1aa5f986ed71357d", 1) != 0)
	{
		if(isdefined(player) && !isalive(player))
		{
			score = 0;
			var_f22ee5e = 0;
			rolescore = 0;
		}
	}
	function_889ed975(player, score, var_f22ee5e, rolescore);
}

/*
	Name: function_37d62931
	Namespace: globallogic_score
	Checksum: 0xD8CA3674
	Offset: 0x2868
	Size: 0x7A
	Parameters: 2
	Flags: Linked
*/
function function_37d62931(player, amount)
{
	player.pers[#"objectives"] = player.pers[#"objectives"] + amount;
	player.objectives = player.pers[#"objectives"];
}

/*
	Name: _setplayerscore
	Namespace: globallogic_score
	Checksum: 0xD30371DD
	Offset: 0x28F0
	Size: 0x352
	Parameters: 4
	Flags: Linked
*/
function _setplayerscore(player, score, var_e21e8076, var_53c3aa0b)
{
	if(score != player.pers[#"score"])
	{
		player.pers[#"score"] = score;
		player.score = player.pers[#"score"];
		recordplayerstats(player, "score", player.pers[#"score"]);
	}
	if(isdefined(var_53c3aa0b) && var_53c3aa0b != player.pers[#"rolescore"])
	{
		player.pers[#"rolescore"] = var_53c3aa0b;
		player.rolescore = player.pers[#"rolescore"];
	}
	if(isdefined(var_e21e8076) && var_e21e8076 != player.pers[#"hash_6061882505788180"])
	{
		if(isarenamode())
		{
			amount = (var_e21e8076 - player.pers[#"hash_6061882505788180"]) + player stats::get_stat(#"playerstatsbygametype", level.var_12323003, #"objective_score", #"arenavalue");
			player stats::set_stat(#"playerstatsbygametype", level.var_12323003, #"objective_score", #"arenavalue", amount);
		}
		else
		{
			amount = (var_e21e8076 - player.pers[#"hash_6061882505788180"]) + player stats::get_stat(#"playerstatsbygametype", level.var_12323003, #"objective_score", #"statvalue");
			player stats::set_stat(#"playerstatsbygametype", level.var_12323003, #"objective_score", #"statvalue", amount);
		}
		player.pers[#"hash_6061882505788180"] = var_e21e8076;
		player.var_f22ee5e = player.pers[#"hash_6061882505788180"];
	}
}

/*
	Name: _getplayerscore
	Namespace: globallogic_score
	Checksum: 0x6C693CE2
	Offset: 0x2C50
	Size: 0x28
	Parameters: 1
	Flags: Linked
*/
function _getplayerscore(player)
{
	return player.pers[#"score"];
}

/*
	Name: function_17a678b7
	Namespace: globallogic_score
	Checksum: 0xCF2510C9
	Offset: 0x2C80
	Size: 0x6C
	Parameters: 2
	Flags: Linked
*/
function function_17a678b7(player, scoresub)
{
	score = player.pers[#"score"] - scoresub;
	if(score < 0)
	{
		score = 0;
	}
	_setplayerscore(player, score);
}

/*
	Name: function_889ed975
	Namespace: globallogic_score
	Checksum: 0x2333BB2B
	Offset: 0x2CF8
	Size: 0x18C
	Parameters: 4
	Flags: Linked
*/
function function_889ed975(player, var_6de41559, var_252f7989, var_f8258842)
{
	/#
		var_1eb7c454 = getdvarfloat(#"hash_eae9a8ee387705d", 1);
		var_6de41559 = int(var_6de41559 * var_1eb7c454);
		var_252f7989 = int(var_252f7989 * var_1eb7c454);
		var_f8258842 = int(var_f8258842 * var_1eb7c454);
	#/
	score = player.pers[#"score"] + var_6de41559;
	var_e21e8076 = player.pers[#"hash_6061882505788180"];
	if(isdefined(var_252f7989))
	{
		var_e21e8076 = var_e21e8076 + var_252f7989;
	}
	var_53c3aa0b = player.pers[#"rolescore"];
	if(isdefined(var_f8258842))
	{
		var_53c3aa0b = var_53c3aa0b + var_f8258842;
	}
	_setplayerscore(player, score, var_e21e8076, var_53c3aa0b);
}

/*
	Name: playtop3sounds
	Namespace: globallogic_score
	Checksum: 0xFF1E0648
	Offset: 0x2E90
	Size: 0x180
	Parameters: 0
	Flags: Linked
*/
function playtop3sounds()
{
	waitframe(1);
	globallogic::updateplacement();
	for(i = 0; i < level.placement[#"all"].size; i++)
	{
		prevscoreplace = level.placement[#"all"][i].prevscoreplace;
		if(!isdefined(prevscoreplace))
		{
			prevscoreplace = 1;
		}
		currentscoreplace = i + 1;
		for(j = i - 1; j >= 0; j--)
		{
			if(level.placement[#"all"][i].score == level.placement[#"all"][j].score)
			{
				currentscoreplace--;
			}
		}
		wasinthemoney = prevscoreplace <= 3;
		isinthemoney = currentscoreplace <= 3;
		level.placement[#"all"][i].prevscoreplace = currentscoreplace;
	}
}

/*
	Name: setpointstowin
	Namespace: globallogic_score
	Checksum: 0x619DE86F
	Offset: 0x3018
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function setpointstowin(points)
{
	self.pers[#"pointstowin"] = math::clamp(points, 0, 65000);
	self.pointstowin = self.pers[#"pointstowin"];
	self thread globallogic::checkscorelimit();
	self thread globallogic::checkroundscorelimit();
	self thread globallogic::checkplayerscorelimitsoon();
	level thread playtop3sounds();
}

/*
	Name: givepointstowin
	Namespace: globallogic_score
	Checksum: 0x9B90984A
	Offset: 0x30E8
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function givepointstowin(points)
{
	self setpointstowin(self.pers[#"pointstowin"] + points);
}

/*
	Name: _setplayermomentum
	Namespace: globallogic_score
	Checksum: 0x4FD7739F
	Offset: 0x3130
	Size: 0x272
	Parameters: 3
	Flags: Linked
*/
function _setplayermomentum(player, momentum, updatescore = 1)
{
	momentum = math::clamp(momentum, 0, 2000);
	oldmomentum = player.pers[#"momentum"];
	if(momentum == oldmomentum)
	{
		return;
	}
	if(updatescore)
	{
		player bb::add_to_stat("momentum", momentum - oldmomentum);
	}
	if(momentum > oldmomentum)
	{
		highestmomentumcost = 0;
		numkillstreaks = 0;
		if(isdefined(player.killstreak))
		{
			numkillstreaks = player.killstreak.size;
		}
		killstreaktypearray = [];
		for(currentkillstreak = 0; currentkillstreak < numkillstreaks; currentkillstreak++)
		{
			killstreaktype = killstreaks::get_by_menu_name(player.killstreak[currentkillstreak]);
			if(isdefined(killstreaktype))
			{
				momentumcost = player function_dceb5542(level.killstreaks[killstreaktype].itemindex);
				if(momentumcost > highestmomentumcost)
				{
					highestmomentumcost = momentumcost;
				}
				killstreaktypearray[killstreaktypearray.size] = killstreaktype;
			}
		}
		_giveplayerkillstreakinternal(player, momentum, oldmomentum, killstreaktypearray);
		while(highestmomentumcost > 0 && momentum >= highestmomentumcost)
		{
			oldmomentum = 0;
			momentum = momentum - highestmomentumcost;
			_giveplayerkillstreakinternal(player, momentum, oldmomentum, killstreaktypearray);
		}
	}
	player.pers[#"momentum"] = momentum;
	player.momentum = player.pers[#"momentum"];
}

/*
	Name: _giveplayerkillstreakinternal
	Namespace: globallogic_score
	Checksum: 0xA24003
	Offset: 0x33B0
	Size: 0x5C8
	Parameters: 4
	Flags: Linked
*/
function _giveplayerkillstreakinternal(player, momentum, oldmomentum, killstreaktypearray)
{
	var_2b85d59c = isdefined(level.var_2b85d59c) && level.var_2b85d59c;
	for(killstreaktypeindex = 0; killstreaktypeindex < killstreaktypearray.size; killstreaktypeindex++)
	{
		killstreaktype = killstreaktypearray[killstreaktypeindex];
		momentumcost = player function_dceb5542(level.killstreaks[killstreaktype].itemindex);
		if(momentumcost > oldmomentum && momentumcost <= momentum)
		{
			weapon = killstreaks::get_killstreak_weapon(killstreaktype);
			was_already_at_max_stacking = 0;
			if(isdefined(level.usingscorestreaks) && level.usingscorestreaks)
			{
				if(isdefined(level.var_ed3e6ff3))
				{
					player [[level.var_ed3e6ff3]](weapon, momentum);
				}
				if(weapon.iscarriedkillstreak)
				{
					if(!isdefined(player.pers[#"held_killstreak_ammo_count"][weapon]))
					{
						player.pers[#"held_killstreak_ammo_count"][weapon] = 0;
					}
					if(!isdefined(player.pers[#"killstreak_quantity"][weapon]))
					{
						player.pers[#"killstreak_quantity"][weapon] = 0;
					}
					currentweapon = player getcurrentweapon();
					if(currentweapon == weapon)
					{
						if(player.pers[#"killstreak_quantity"][weapon] < level.scorestreaksmaxstacking)
						{
							player.pers[#"killstreak_quantity"][weapon]++;
						}
					}
					else
					{
						player.pers[#"held_killstreak_clip_count"][weapon] = weapon.clipsize;
						player.pers[#"held_killstreak_ammo_count"][weapon] = weapon.maxammo;
						player loadout::function_3ba6ee5d(weapon, player.pers[#"held_killstreak_ammo_count"][weapon]);
					}
				}
				else
				{
					old_killstreak_quantity = player killstreaks::get_killstreak_quantity(weapon);
					new_killstreak_quantity = player killstreaks::change_killstreak_quantity(weapon, 1);
					was_already_at_max_stacking = new_killstreak_quantity == old_killstreak_quantity;
					if(!was_already_at_max_stacking)
					{
						player challenges::earnedkillstreak();
						player contracts::function_a54e2068(#"hash_3ddcd024e6e13a32");
						if(player ability_util::gadget_is_active(12))
						{
							scoreevents::processscoreevent(#"focus_earn_scorestreak", player, undefined, undefined);
							player scoreevents::specialistmedalachievement();
							player scoreevents::specialiststatabilityusage(4, 1);
							if(player.heroability.name == "gadget_combat_efficiency")
							{
								player stats::function_e24eec31(player.heroability, #"scorestreaks_earned", 1);
								if(!isdefined(player.scorestreaksearnedperuse))
								{
									player.scorestreaksearnedperuse = 0;
								}
								player.scorestreaksearnedperuse++;
								if(player.scorestreaksearnedperuse >= 3)
								{
									scoreevents::processscoreevent(#"focus_earn_multiscorestreak", player, undefined, undefined);
									player.scorestreaksearnedperuse = 0;
								}
							}
						}
					}
				}
				if(!was_already_at_max_stacking)
				{
					player killstreaks::add_to_notification_queue(level.killstreaks[killstreaktype].menuname, new_killstreak_quantity, killstreaktype, var_2b85d59c, 0);
				}
				continue;
			}
			player killstreaks::add_to_notification_queue(level.killstreaks[killstreaktype].menuname, 0, killstreaktype, var_2b85d59c, 0);
			activeeventname = "reward_active";
			if(isdefined(weapon))
			{
				neweventname = weapon.name + "_active";
				if(scoreevents::isregisteredevent(neweventname))
				{
					activeeventname = neweventname;
				}
			}
		}
	}
}

/*
	Name: setplayermomentumdebug
	Namespace: globallogic_score
	Checksum: 0xF463B8FE
	Offset: 0x3980
	Size: 0xF8
	Parameters: 0
	Flags: None
*/
function setplayermomentumdebug()
{
	/#
		setdvar(#"sv_momentumpercent", 0);
		while(true)
		{
			wait(1);
			momentumpercent = getdvarfloat(#"sv_momentumpercent", 0);
			if(momentumpercent != 0)
			{
				player = util::gethostplayer();
				if(!isdefined(player))
				{
					return;
				}
				if(isdefined(player.killstreak))
				{
					_setplayermomentum(player, int(2000 * (momentumpercent / 100)));
				}
			}
		}
	#/
}

/*
	Name: giveteamscore
	Namespace: globallogic_score
	Checksum: 0xF22F2D6D
	Offset: 0x3A80
	Size: 0x1C4
	Parameters: 4
	Flags: Linked
*/
function giveteamscore(event, team, player, victim)
{
	if(level.overrideteamscore)
	{
		return;
	}
	pixbeginevent(#"hash_66d4a941ef078585");
	teamscore = game.stat[#"teamscores"][team];
	[[level.onteamscore]](event, team);
	pixendevent();
	newscore = game.stat[#"teamscores"][team];
	if(sessionmodeismultiplayergame())
	{
		mpteamscores = {#score:newscore, #diff:newscore - teamscore, #team:team, #event:event, #gametime:function_f8d53445()};
		function_92d1707f(#"hash_48d5ef92d24477d2", mpteamscores);
	}
	if(teamscore == newscore)
	{
		return;
	}
	updateteamscores(team);
	thread globallogic::checkscorelimit();
	thread globallogic::checkroundscorelimit();
}

/*
	Name: giveteamscoreforobjective_delaypostprocessing
	Namespace: globallogic_score
	Checksum: 0x1F77CF4A
	Offset: 0x3C50
	Size: 0x144
	Parameters: 2
	Flags: Linked
*/
function giveteamscoreforobjective_delaypostprocessing(team, score)
{
	teamscore = game.stat[#"teamscores"][team];
	onteamscore_incrementscore(score, team);
	newscore = game.stat[#"teamscores"][team];
	if(sessionmodeismultiplayergame())
	{
		mpteamobjscores = {#score:newscore, #diff:newscore - teamscore, #team:team, #gametime:function_f8d53445()};
		function_92d1707f(#"hash_22921c2c027fa389", mpteamobjscores);
	}
	if(teamscore == newscore)
	{
		return;
	}
	updateteamscores(team);
}

/*
	Name: postprocessteamscores
	Namespace: globallogic_score
	Checksum: 0x888B3BD4
	Offset: 0x3DA0
	Size: 0xA4
	Parameters: 1
	Flags: None
*/
function postprocessteamscores(teams)
{
	foreach(team in teams)
	{
		onteamscore_postprocess(team);
	}
	thread globallogic::checkscorelimit();
	thread globallogic::checkroundscorelimit();
}

/*
	Name: giveteamscoreforobjective
	Namespace: globallogic_score
	Checksum: 0x603A4F1B
	Offset: 0x3E50
	Size: 0x194
	Parameters: 2
	Flags: None
*/
function giveteamscoreforobjective(team, score)
{
	if(!isdefined(level.teams[team]))
	{
		return;
	}
	teamscore = game.stat[#"teamscores"][team];
	onteamscore(score, team);
	newscore = game.stat[#"teamscores"][team];
	if(sessionmodeismultiplayergame())
	{
		mpteamobjscores = {#score:newscore, #diff:newscore - teamscore, #team:team, #gametime:function_f8d53445()};
		function_92d1707f(#"hash_22921c2c027fa389", mpteamobjscores);
	}
	if(teamscore == newscore)
	{
		return;
	}
	updateteamscores(team);
	thread globallogic::checkscorelimit();
	thread globallogic::checkroundscorelimit();
	thread globallogic::checksuddendeathscorelimit(team);
}

/*
	Name: _setteamscore
	Namespace: globallogic_score
	Checksum: 0xAA456DEF
	Offset: 0x3FF0
	Size: 0xB4
	Parameters: 2
	Flags: Linked
*/
function _setteamscore(team, teamscore)
{
	if(teamscore == game.stat[#"teamscores"][team])
	{
		return;
	}
	game.stat[#"teamscores"][team] = math::clamp(teamscore, 0, 1000000);
	updateteamscores(team);
	thread globallogic::checkscorelimit();
	thread globallogic::checkroundscorelimit();
}

/*
	Name: resetteamscores
	Namespace: globallogic_score
	Checksum: 0xF34CD7DB
	Offset: 0x40B0
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function resetteamscores()
{
	if(level.scoreroundwinbased || util::isfirstround())
	{
		foreach(team, _ in level.teams)
		{
			game.stat[#"teamscores"][team] = 0;
		}
	}
	updateallteamscores();
}

/*
	Name: resetallscores
	Namespace: globallogic_score
	Checksum: 0xB3BDF2ED
	Offset: 0x4180
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function resetallscores()
{
	resetteamscores();
	resetplayerscores();
}

/*
	Name: resetplayerscores
	Namespace: globallogic_score
	Checksum: 0xF43889C9
	Offset: 0x41B0
	Size: 0xA6
	Parameters: 0
	Flags: Linked
*/
function resetplayerscores()
{
	players = level.players;
	winner = undefined;
	tie = 0;
	for(i = 0; i < players.size; i++)
	{
		if(isdefined(players[i].pers[#"score"]))
		{
			_setplayerscore(players[i], 0);
		}
	}
}

/*
	Name: updateteamscores
	Namespace: globallogic_score
	Checksum: 0xBD3E773C
	Offset: 0x4260
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function updateteamscores(team)
{
	setteamscore(team, game.stat[#"teamscores"][team]);
	level thread globallogic::checkteamscorelimitsoon(team);
}

/*
	Name: updateallteamscores
	Namespace: globallogic_score
	Checksum: 0x807DE0A2
	Offset: 0x42C0
	Size: 0x80
	Parameters: 0
	Flags: Linked
*/
function updateallteamscores()
{
	foreach(team, _ in level.teams)
	{
		updateteamscores(team);
	}
}

/*
	Name: _getteamscore
	Namespace: globallogic_score
	Checksum: 0x2869C1E
	Offset: 0x4348
	Size: 0x26
	Parameters: 1
	Flags: Linked
*/
function _getteamscore(team)
{
	return game.stat[#"teamscores"][team];
}

/*
	Name: gethighestteamscoreteam
	Namespace: globallogic_score
	Checksum: 0x6B93FA2A
	Offset: 0x4378
	Size: 0xEA
	Parameters: 0
	Flags: Linked
*/
function gethighestteamscoreteam()
{
	score = 0;
	winning_teams = [];
	foreach(team, _ in level.teams)
	{
		team_score = game.stat[#"teamscores"][team];
		if(team_score > score)
		{
			score = team_score;
			winning_teams = [];
		}
		if(team_score == score)
		{
			winning_teams[team] = team;
		}
	}
	return winning_teams;
}

/*
	Name: areteamarraysequal
	Namespace: globallogic_score
	Checksum: 0xB029A2CB
	Offset: 0x4470
	Size: 0xA0
	Parameters: 2
	Flags: Linked
*/
function areteamarraysequal(teamsa, teamsb)
{
	if(teamsa.size != teamsb.size)
	{
		return false;
	}
	foreach(team in teamsa)
	{
		if(!isdefined(teamsb[team]))
		{
			return false;
		}
	}
	return true;
}

/*
	Name: onteamscore
	Namespace: globallogic_score
	Checksum: 0xB18C555A
	Offset: 0x4518
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function onteamscore(score, team)
{
	onteamscore_incrementscore(score, team);
	onteamscore_postprocess(team);
}

/*
	Name: onteamscore_incrementscore
	Namespace: globallogic_score
	Checksum: 0x5D546796
	Offset: 0x4568
	Size: 0x18C
	Parameters: 2
	Flags: Linked
*/
function onteamscore_incrementscore(score, team)
{
	game.stat[#"teamscores"][team] = game.stat[#"teamscores"][team] + score;
	if(game.stat[#"teamscores"][team] < 0)
	{
		game.stat[#"teamscores"][team] = 0;
	}
	if(level.clampscorelimit)
	{
		if(level.scorelimit && game.stat[#"teamscores"][team] > level.scorelimit)
		{
			game.stat[#"teamscores"][team] = level.scorelimit;
		}
		if(level.roundscorelimit && game.stat[#"teamscores"][team] > util::get_current_round_score_limit())
		{
			game.stat[#"teamscores"][team] = util::get_current_round_score_limit();
		}
	}
}

/*
	Name: onteamscore_postprocess
	Namespace: globallogic_score
	Checksum: 0xF2CAAD6A
	Offset: 0x4700
	Size: 0x286
	Parameters: 1
	Flags: Linked
*/
function onteamscore_postprocess(team)
{
	if(level.splitscreen)
	{
		return;
	}
	if(level.scorelimit == 1)
	{
		return;
	}
	iswinning = gethighestteamscoreteam();
	if(iswinning.size == 0)
	{
		return;
	}
	if(gettime() - level.laststatustime < 5000)
	{
		return;
	}
	if(areteamarraysequal(iswinning, level.waswinning))
	{
		return;
	}
	if(iswinning.size == 1)
	{
		level.laststatustime = gettime();
		foreach(team in iswinning)
		{
			if(isdefined(level.waswinning[team]))
			{
				if(level.waswinning.size == 1)
				{
					continue;
				}
			}
			if((isdefined(level.var_e7b05b51) ? level.var_e7b05b51 : 1))
			{
				globallogic_audio::leader_dialog("gameLeadTaken", team, undefined, "status");
			}
		}
	}
	else
	{
		return;
	}
	if(level.waswinning.size == 1)
	{
		foreach(team in level.waswinning)
		{
			if(isdefined(iswinning[team]))
			{
				if(iswinning.size == 1)
				{
					continue;
				}
				if(level.waswinning.size > 1)
				{
					continue;
				}
			}
			if((isdefined(level.var_e7b05b51) ? level.var_e7b05b51 : 1))
			{
				globallogic_audio::leader_dialog("gameLeadLost", team, undefined, "status");
			}
		}
	}
	level.waswinning = iswinning;
}

/*
	Name: default_onteamscore
	Namespace: globallogic_score
	Checksum: 0xA16D5A11
	Offset: 0x4990
	Size: 0x6C
	Parameters: 2
	Flags: Linked
*/
function default_onteamscore(event, team)
{
	score = rank::getscoreinfovalue(event);
	/#
		assert(isdefined(score));
	#/
	onteamscore(score, team);
}

/*
	Name: initpersstat
	Namespace: globallogic_score
	Checksum: 0x572A2C6
	Offset: 0x4A08
	Size: 0x8C
	Parameters: 2
	Flags: Linked
*/
function initpersstat(dataname, record_stats)
{
	if(!isdefined(self.pers[dataname]))
	{
		self.pers[dataname] = 0;
	}
	if(!isdefined(record_stats) || record_stats == 1)
	{
		recordplayerstats(self, dataname, int(self.pers[dataname]));
	}
}

/*
	Name: getpersstat
	Namespace: globallogic_score
	Checksum: 0x12955878
	Offset: 0x4AA0
	Size: 0x18
	Parameters: 1
	Flags: Linked
*/
function getpersstat(dataname)
{
	return self.pers[dataname];
}

/*
	Name: incpersstat
	Namespace: globallogic_score
	Checksum: 0x5E294257
	Offset: 0x4AC0
	Size: 0x104
	Parameters: 4
	Flags: Linked
*/
function incpersstat(dataname, increment, record_stats, includegametype)
{
	pixbeginevent(#"incpersstat");
	if(isdefined(self.pers[dataname]))
	{
		self.pers[dataname] = self.pers[dataname] + increment;
	}
	if(isdefined(includegametype) && includegametype)
	{
		self stats::function_bb7eedf0(dataname, increment);
	}
	else
	{
		self stats::function_dad108fa(dataname, increment);
	}
	if(!isdefined(record_stats) || record_stats == 1)
	{
		self thread threadedrecordplayerstats(dataname);
	}
	pixendevent();
}

/*
	Name: threadedrecordplayerstats
	Namespace: globallogic_score
	Checksum: 0x435F6676
	Offset: 0x4BD0
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function threadedrecordplayerstats(dataname)
{
	self endon(#"disconnect");
	waittillframeend();
	if(isdefined(self) && isdefined(self.pers) && isdefined(self.pers[dataname]))
	{
		recordplayerstats(self, dataname, self.pers[dataname]);
	}
}

/*
	Name: updatewinstats
	Namespace: globallogic_score
	Checksum: 0x133A5D9
	Offset: 0x4C50
	Size: 0x3DC
	Parameters: 1
	Flags: Linked
*/
function updatewinstats(winner)
{
	winner stats::function_bb7eedf0(#"losses", -1);
	winner.pers[#"outcome"] = #"win";
	winner stats::function_bb7eedf0(#"wins", 1);
	if(level.rankedmatch && !level.disablestattracking && sessionmodeismultiplayergame())
	{
		if(winner stats::function_441050ca(#"wins") > 49)
		{
			winner giveachievement("mp_trophy_vanquisher");
		}
	}
	if(level.hardcoremode)
	{
		winner stats::function_dad108fa(#"wins_hc", 1);
	}
	else if(!level.arenamatch)
	{
		winner stats::function_dad108fa(#"hash_14d06f640b771fb8", 1);
	}
	if(level.arenamatch)
	{
		winner stats::function_dad108fa(#"hash_1c95b400490ba23a", 1);
	}
	if(level.multiteam)
	{
		winner stats::function_dad108fa(#"wins_multiteam", 1);
	}
	winner updatestatratio("wlratio", "wins", "losses");
	restorewinstreaks(winner);
	winner stats::function_bb7eedf0(#"cur_win_streak", 1);
	winner notify(#"win");
	winner.lootxpmultiplier = 1;
	cur_gamemode_win_streak = winner stats::function_ed81f25e(#"cur_win_streak");
	gamemode_win_streak = winner stats::function_ed81f25e(#"win_streak");
	cur_win_streak = winner stats::function_441050ca(#"cur_win_streak");
	if(isdefined(cur_gamemode_win_streak) && isdefined(gamemode_win_streak) && cur_gamemode_win_streak > gamemode_win_streak)
	{
		winner stats::function_baa25a23(#"win_streak", cur_gamemode_win_streak);
	}
	if(bot::is_bot_ranked_match())
	{
		combattrainingwins = winner stats::get_stat(#"combattrainingwins");
		winner stats::set_stat(#"combattrainingwins", combattrainingwins + 1);
	}
	if(level.var_aa5e6547 === 1)
	{
		winner stats::function_dad108fa(#"hash_a06075423336d9c", 1);
	}
	updateweaponcontractwin(winner);
	updatecontractwin(winner);
}

/*
	Name: canupdateweaponcontractstats
	Namespace: globallogic_score
	Checksum: 0x55B85C8E
	Offset: 0x5038
	Size: 0x6E
	Parameters: 0
	Flags: Linked
*/
function canupdateweaponcontractstats()
{
	if(getdvarint(#"enable_weapon_contract", 0) == 0)
	{
		return false;
	}
	if(!level.rankedmatch && !level.arenamatch)
	{
		return false;
	}
	if(function_f99d2668())
	{
		return false;
	}
	return true;
}

/*
	Name: updateweaponcontractstart
	Namespace: globallogic_score
	Checksum: 0xC63C0EF8
	Offset: 0x50B0
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function updateweaponcontractstart(player)
{
	if(!canupdateweaponcontractstats())
	{
		return;
	}
	if(player stats::get_stat(#"weaponcontractdata", #"starttimestamp") == 0)
	{
		player stats::set_stat(#"weaponcontractdata", #"starttimestamp", getutc());
	}
}

/*
	Name: updateweaponcontractwin
	Namespace: globallogic_score
	Checksum: 0x8D51FAA
	Offset: 0x5158
	Size: 0x18C
	Parameters: 1
	Flags: Linked
*/
function updateweaponcontractwin(winner)
{
	if(!canupdateweaponcontractstats())
	{
		return;
	}
	matcheswon = winner stats::get_stat(#"weaponcontractdata", #"currentvalue") + 1;
	winner stats::set_stat(#"weaponcontractdata", #"currentvalue", matcheswon);
	if((isdefined(winner stats::get_stat(#"weaponcontractdata", #"completetimestamp")) ? winner stats::get_stat(#"weaponcontractdata", #"completetimestamp") : 0) == 0)
	{
		targetvalue = getdvarint(#"weapon_contract_target_value", 100);
		if(matcheswon >= targetvalue)
		{
			winner stats::set_stat(#"weaponcontractdata", #"completetimestamp", getutc());
		}
	}
}

/*
	Name: updateweaponcontractplayed
	Namespace: globallogic_score
	Checksum: 0xB3297C1
	Offset: 0x52F0
	Size: 0x120
	Parameters: 0
	Flags: Linked
*/
function updateweaponcontractplayed()
{
	if(!canupdateweaponcontractstats())
	{
		return;
	}
	foreach(player in level.players)
	{
		if(!isdefined(player))
		{
			continue;
		}
		if(!isdefined(player.pers[#"team"]))
		{
			continue;
		}
		matchesplayed = player stats::get_stat(#"weaponcontractdata", #"matchesplayed") + 1;
		player stats::set_stat(#"weaponcontractdata", #"matchesplayed", matchesplayed);
	}
}

/*
	Name: updatecontractwin
	Namespace: globallogic_score
	Checksum: 0x553B023A
	Offset: 0x5418
	Size: 0x9A
	Parameters: 1
	Flags: Linked
*/
function updatecontractwin(winner)
{
	if(!isdefined(level.updatecontractwinevents))
	{
		return;
	}
	foreach(contractwinevent in level.updatecontractwinevents)
	{
		if(!isdefined(contractwinevent))
		{
			continue;
		}
		[[contractwinevent]](winner);
	}
}

/*
	Name: registercontractwinevent
	Namespace: globallogic_score
	Checksum: 0x8B3EC8E9
	Offset: 0x54C0
	Size: 0xAA
	Parameters: 1
	Flags: Linked
*/
function registercontractwinevent(event)
{
	if(!isdefined(level.updatecontractwinevents))
	{
		level.updatecontractwinevents = [];
	}
	if(!isdefined(level.updatecontractwinevents))
	{
		level.updatecontractwinevents = [];
	}
	else if(!isarray(level.updatecontractwinevents))
	{
		level.updatecontractwinevents = array(level.updatecontractwinevents);
	}
	level.updatecontractwinevents[level.updatecontractwinevents.size] = event;
}

/*
	Name: updatelossstats
	Namespace: globallogic_score
	Checksum: 0x5E08922F
	Offset: 0x5578
	Size: 0xA0
	Parameters: 1
	Flags: Linked
*/
function updatelossstats(loser)
{
	loser.pers[#"outcome"] = #"loss";
	loser stats::function_bb7eedf0(#"losses", 1);
	loser updatestatratio("wlratio", "wins", "losses");
	loser notify(#"loss");
}

/*
	Name: updatelosslatejoinstats
	Namespace: globallogic_score
	Checksum: 0xA01B44EA
	Offset: 0x5620
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function updatelosslatejoinstats(loser)
{
	loser stats::function_bb7eedf0(#"losses", -1);
	loser stats::function_bb7eedf0(#"losses_late_join", 1);
	loser updatestatratio("wlratio", "wins", "losses");
}

/*
	Name: updatetiestats
	Namespace: globallogic_score
	Checksum: 0x16456BCD
	Offset: 0x56B8
	Size: 0x130
	Parameters: 1
	Flags: Linked
*/
function updatetiestats(loser)
{
	loser stats::function_bb7eedf0(#"losses", -1);
	loser.pers[#"outcome"] = #"draw";
	loser stats::function_bb7eedf0(#"ties", 1);
	loser updatestatratio("wlratio", "wins", "losses");
	if(!level.disablestattracking)
	{
		loser stats::function_4db3fba1(#"cur_win_streak", 0);
		if(level.var_aa5e6547 === 1)
		{
			loser stats::function_4db3fba1(#"hash_a06075423336d9c", 0);
		}
	}
	loser notify(#"tie");
}

/*
	Name: updatewinlossstats
	Namespace: globallogic_score
	Checksum: 0xB13BBA42
	Offset: 0x57F0
	Size: 0x520
	Parameters: 0
	Flags: Linked
*/
function updatewinlossstats()
{
	if(!util::waslastround() && !level.hostforcedend)
	{
		return;
	}
	players = level.players;
	updateweaponcontractplayed();
	if(match::function_75f97ac7())
	{
		if(level.hostforcedend && match::function_517c0ce0())
		{
			return;
		}
		winner = match::function_9b24638f();
		updatewinstats(winner);
		if(!level.teambased)
		{
			placement = level.placement[#"all"];
			topthreeplayers = min(3, placement.size);
			for(index = 1; index < topthreeplayers; index++)
			{
				nexttopplayer = placement[index];
				updatewinstats(nexttopplayer);
			}
			foreach(player in players)
			{
				if(winner == player)
				{
					continue;
				}
				for(index = 1; index < topthreeplayers; index++)
				{
					if(player == placement[index])
					{
						break;
					}
				}
				if(index < topthreeplayers)
				{
					continue;
				}
				if(level.rankedmatch && !level.leaguematch && player.pers[#"latejoin"] === 1)
				{
					updatelosslatejoinstats(player);
				}
			}
		}
	}
	else
	{
		if(match::function_5f24faac("tie"))
		{
			foreach(player in players)
			{
				if(!isdefined(player.pers[#"team"]))
				{
					continue;
				}
				if(level.hostforcedend && player ishost())
				{
					continue;
				}
				updatetiestats(player);
			}
		}
		else
		{
			foreach(player in players)
			{
				if(!isdefined(player.pers[#"team"]))
				{
					continue;
				}
				if(level.hostforcedend && player ishost())
				{
					continue;
				}
				if(match::function_5f24faac("tie"))
				{
					updatetiestats(player);
					continue;
				}
				if(match::function_a2b53e17(player))
				{
					updatewinstats(player);
					continue;
				}
				if(level.rankedmatch && !level.leaguematch && player.pers[#"latejoin"] === 1)
				{
					updatelosslatejoinstats(player);
				}
				if(!level.disablestattracking)
				{
					player stats::function_4db3fba1(#"cur_win_streak", 0);
					if(level.var_aa5e6547 === 1)
					{
						player stats::function_4db3fba1(#"hash_a06075423336d9c", 0);
					}
				}
			}
		}
	}
}

/*
	Name: backupandclearwinstreaks
	Namespace: globallogic_score
	Checksum: 0x7BF1EF4
	Offset: 0x5D18
	Size: 0x164
	Parameters: 0
	Flags: Linked
*/
function backupandclearwinstreaks()
{
	if(isdefined(level.freerun) && level.freerun)
	{
		return;
	}
	self.pers[#"winstreak"] = self stats::function_441050ca(#"cur_win_streak");
	if(!level.disablestattracking)
	{
		self stats::function_4db3fba1(#"cur_win_streak", 0);
		if(level.var_aa5e6547 === 1)
		{
			self.pers[#"hash_1346f22553899977"] = self stats::function_441050ca(#"hash_a06075423336d9c");
			self stats::function_4db3fba1(#"hash_a06075423336d9c", 0);
		}
	}
	self.pers[#"winstreakforgametype"] = self stats::function_ed81f25e(#"cur_win_streak");
	self stats::function_baa25a23(#"cur_win_streak", 0);
}

/*
	Name: restorewinstreaks
	Namespace: globallogic_score
	Checksum: 0xCB883D5
	Offset: 0x5E88
	Size: 0x104
	Parameters: 1
	Flags: Linked
*/
function restorewinstreaks(winner)
{
	if(!level.disablestattracking)
	{
		winner stats::function_4db3fba1(#"cur_win_streak", winner.pers[#"winstreak"]);
		if(level.var_aa5e6547 === 1)
		{
			winner stats::function_4db3fba1(#"hash_a06075423336d9c", winner.pers[#"hash_1346f22553899977"]);
		}
	}
	winner stats::function_baa25a23(#"cur_win_streak", (isdefined(winner.pers[#"winstreakforgametype"]) ? winner.pers[#"winstreakforgametype"] : 0));
}

/*
	Name: inckillstreaktracker
	Namespace: globallogic_score
	Checksum: 0x24996CAD
	Offset: 0x5F98
	Size: 0x8E
	Parameters: 1
	Flags: Linked
*/
function inckillstreaktracker(weapon)
{
	self endon(#"disconnect");
	waittillframeend();
	if(weapon.name == #"artillery")
	{
		self.pers[#"artillery_kills"]++;
	}
	if(weapon.name == #"dog_bite")
	{
		self.pers[#"dog_kills"]++;
	}
}

/*
	Name: trackattackerkill
	Namespace: globallogic_score
	Checksum: 0x1153234A
	Offset: 0x6030
	Size: 0x2EC
	Parameters: 6
	Flags: Linked
*/
function trackattackerkill(name, rank, xp, prestige, xuid, weapon)
{
	self endon(#"disconnect");
	attacker = self;
	waittillframeend();
	pixbeginevent(#"trackattackerkill");
	if(!isdefined(attacker.pers[#"killed_players"][name]))
	{
		attacker.pers[#"killed_players"][name] = 0;
	}
	if(!isdefined(attacker.pers[#"killed_players_with_specialist"][name]))
	{
		attacker.pers[#"killed_players_with_specialist"][name] = 0;
	}
	if(!isdefined(attacker.killedplayerscurrent[name]))
	{
		attacker.killedplayerscurrent[name] = 0;
	}
	attacker.pers[#"killed_players"][name]++;
	attacker.killedplayerscurrent[name]++;
	if(weapon.isheavyweapon)
	{
		attacker.pers[#"killed_players_with_specialist"][name]++;
	}
	if(attacker.pers[#"nemesis_name"] == name)
	{
		attacker challenges::killednemesis();
	}
	attacker function_e7b4c25c(name, 1.5, rank, prestige, xp, xuid);
	if(!isdefined(attacker.lastkilledvictim) || !isdefined(attacker.lastkilledvictimcount))
	{
		attacker.lastkilledvictim = name;
		attacker.lastkilledvictimcount = 0;
	}
	if(attacker.lastkilledvictim == name)
	{
		attacker.lastkilledvictimcount++;
		if(attacker.lastkilledvictimcount >= 5)
		{
			attacker.lastkilledvictimcount = 0;
			attacker stats::function_dad108fa(#"streaker", 1);
		}
	}
	else
	{
		attacker.lastkilledvictim = name;
		attacker.lastkilledvictimcount = 1;
	}
	pixendevent();
}

/*
	Name: trackattackeedeath
	Namespace: globallogic_score
	Checksum: 0x70EE4081
	Offset: 0x6328
	Size: 0x234
	Parameters: 5
	Flags: Linked
*/
function trackattackeedeath(attackername, rank, xp, prestige, xuid)
{
	self endon(#"disconnect");
	waittillframeend();
	pixbeginevent(#"trackattackeedeath");
	if(!isdefined(self.pers[#"killed_by"][attackername]))
	{
		self.pers[#"killed_by"][attackername] = 0;
	}
	self.pers[#"killed_by"][attackername]++;
	self function_e7b4c25c(attackername, 1.5, rank, prestige, xp, xuid);
	if(self.pers[#"nemesis_name"] == attackername && self.pers[#"nemesis_tracking"][attackername].value >= 2)
	{
		self setclientuivisibilityflag("killcam_nemesis", 1);
	}
	else
	{
		self setclientuivisibilityflag("killcam_nemesis", 0);
	}
	selfkillstowardsattacker = 0;
	if(isdefined(self.pers[#"killed_players"][attackername]))
	{
		selfkillstowardsattacker = self.pers[#"killed_players"][attackername];
	}
	self luinotifyevent(#"track_victim_death", 2, self.pers[#"killed_by"][attackername], selfkillstowardsattacker);
	pixendevent();
}

/*
	Name: default_iskillboosting
	Namespace: globallogic_score
	Checksum: 0x168C527A
	Offset: 0x6568
	Size: 0x6
	Parameters: 0
	Flags: Linked
*/
function default_iskillboosting()
{
	return false;
}

/*
	Name: givekillstats
	Namespace: globallogic_score
	Checksum: 0x60CED36B
	Offset: 0x6578
	Size: 0x47C
	Parameters: 4
	Flags: Linked
*/
function givekillstats(smeansofdeath, weapon, evictim, var_e7a369ea)
{
	self endon(#"disconnect");
	if(self === var_e7a369ea)
	{
		self.kills = self.kills + 1;
	}
	laststandparams = undefined;
	if(isdefined(evictim))
	{
		laststandparams = evictim.laststandparams;
	}
	waittillframeend();
	if(level.rankedmatch && self [[level.iskillboosting]]())
	{
		/#
			self iprintlnbold("");
		#/
		return;
	}
	pixbeginevent(#"givekillstats");
	if(self === var_e7a369ea)
	{
		self activecamo::function_896ac347(weapon, #"kills", 1);
		self activecamo::function_1af985ba(weapon);
		self incpersstat(#"kills", 1, 1, 1);
		self.kills = self getpersstat(#"kills");
		self updatestatratio("kdratio", "kills", "deaths");
		if(isdefined(evictim) && isplayer(evictim) && isdefined(evictim.attackerdamage))
		{
			if(isarray(evictim.attackerdamage) && isdefined(self.clientid) && isdefined(evictim.attackerdamage[self.clientid]) && evictim.attackerdamage.size == 1)
			{
				stats::function_dad108fa(#"hash_7333f2fa3df0ea1d", 1);
			}
		}
		if(isdefined(level.var_c8453874))
		{
			[[level.var_c8453874]](self, evictim, laststandparams);
		}
	}
	if(isdefined(evictim) && isplayer(evictim))
	{
		self incpersstat(#"ekia", 1, 1, 1);
		self stats::function_e24eec31(weapon, #"ekia", 1);
		self contracts::player_contract_event(#"ekia", weapon);
		self.ekia = self getpersstat(#"ekia");
	}
	attacker = self;
	if(smeansofdeath === "MOD_HEAD_SHOT" && !killstreaks::is_killstreak_weapon(weapon))
	{
		self activecamo::function_896ac347(weapon, #"headshots", 1);
		attacker thread incpersstat(#"headshots", 1, 1, 0);
		attacker.headshots = attacker.pers[#"headshots"];
		if(isdefined(evictim))
		{
			evictim recordkillmodifier("headshot");
		}
		if((attacker.headshots % 5) == 0)
		{
			self contracts::function_a54e2068(#"hash_ca75e54eb5e5ef8");
		}
	}
	pixendevent();
}

/*
	Name: setinflictorstat
	Namespace: globallogic_score
	Checksum: 0x4B7139E7
	Offset: 0x6A00
	Size: 0x1D4
	Parameters: 3
	Flags: Linked
*/
function setinflictorstat(einflictor, eattacker, weapon)
{
	if(!isdefined(eattacker))
	{
		return;
	}
	weaponpickedup = 0;
	if(isdefined(eattacker.pickedupweapons) && isdefined(eattacker.pickedupweapons[weapon]))
	{
		weaponpickedup = 1;
	}
	if(!isdefined(einflictor))
	{
		eattacker stats::function_eec52333(weapon, #"hits", 1, eattacker.class_num, weaponpickedup);
		return;
	}
	if(!isdefined(einflictor.playeraffectedarray))
	{
		einflictor.playeraffectedarray = [];
	}
	foundnewplayer = 1;
	for(i = 0; i < einflictor.playeraffectedarray.size; i++)
	{
		if(einflictor.playeraffectedarray[i] == self)
		{
			foundnewplayer = 0;
			break;
		}
	}
	if(foundnewplayer)
	{
		einflictor.playeraffectedarray[einflictor.playeraffectedarray.size] = self;
		if(weapon.rootweapon.name == "tabun_gas")
		{
			eattacker stats::function_e24eec31(weapon, #"used", 1);
		}
		eattacker stats::function_eec52333(weapon, #"hits", 1, eattacker.class_num, weaponpickedup);
	}
}

/*
	Name: processshieldassist
	Namespace: globallogic_score
	Checksum: 0xD457EFD1
	Offset: 0x6BE0
	Size: 0x154
	Parameters: 1
	Flags: Linked
*/
function processshieldassist(killedplayer)
{
	self endon(#"disconnect");
	killedplayer endon(#"disconnect");
	waitframe(1);
	util::waittillslowprocessallowed();
	if(!isdefined(level.teams[self.pers[#"team"]]))
	{
		return;
	}
	if(self.pers[#"team"] == killedplayer.pers[#"team"])
	{
		return;
	}
	if(!level.teambased)
	{
		return;
	}
	self incpersstat(#"assists", 1, 1, 1);
	self.assists = self getpersstat(#"assists");
	currentweapon = self getcurrentweapon();
	scoreevents::processscoreevent(#"shield_assist", self, killedplayer, currentweapon);
}

/*
	Name: function_b1a3b359
	Namespace: globallogic_score
	Checksum: 0x248CB6DA
	Offset: 0x6D40
	Size: 0x354
	Parameters: 4
	Flags: Linked
*/
function function_b1a3b359(killedplayer, damagedone, weapon, assist_level = undefined)
{
	self endon(#"disconnect");
	killedplayer endon(#"disconnect");
	if(!isdefined(level.teams[self.pers[#"team"]]))
	{
		return;
	}
	if(self.pers[#"team"] == killedplayer.pers[#"team"])
	{
		return;
	}
	if(!level.teambased)
	{
		return;
	}
	assist_level = "assist";
	assist_level_value = int(ceil(damagedone / 25));
	if(assist_level_value < 1)
	{
		assist_level_value = 1;
	}
	else if(assist_level_value > 3)
	{
		assist_level_value = 3;
	}
	assist_level = (assist_level + "_") + (assist_level_value * 25);
	self incpersstat(#"assists", 1, 1, 1);
	self.assists = self getpersstat(#"assists");
	if(isdefined(weapon))
	{
		weaponpickedup = 0;
		if(isdefined(self.pickedupweapons) && isdefined(self.pickedupweapons[weapon]))
		{
			weaponpickedup = 1;
		}
		self stats::function_eec52333(weapon, #"assists", 1, self.class_num, weaponpickedup);
	}
	if(!level.var_724cf71)
	{
		switch(weapon.name)
		{
			case "hash_577b41452577c37f":
			case "concussion_grenade":
			{
				assist_level = "assist_concussion";
				break;
			}
			case "hash_af1a40bb1375dab":
			case "flash_grenade":
			{
				assist_level = "assist_flash";
				break;
			}
			case "hash_4cd586d22c20b3cf":
			case "emp_grenade":
			{
				assist_level = "assist_emp";
				break;
			}
			case "proximity_grenade":
			case "proximity_grenade_aoe":
			{
				assist_level = "assist_proximity";
				break;
			}
		}
		self challenges::assisted();
		scoreevents::processscoreevent(assist_level, self, killedplayer, weapon);
	}
	else
	{
		self challenges::function_57ca42c6(weapon);
	}
}

/*
	Name: function_f38e3d84
	Namespace: globallogic_score
	Checksum: 0x7736B231
	Offset: 0x70A0
	Size: 0xE8
	Parameters: 3
	Flags: Linked
*/
function function_f38e3d84(attacker, inflictor, weapon)
{
	if(!isdefined(attacker) || !isdefined(attacker.team) || self util::isenemyplayer(attacker) == 0)
	{
		return false;
	}
	if(self == attacker || (attacker.classname == "trigger_hurt_new" || attacker.classname == "worldspawn"))
	{
		return false;
	}
	if(killstreaks::is_killstreak_weapon(weapon))
	{
		return false;
	}
	if(attacker.team == #"spectator")
	{
		return false;
	}
	return true;
}

/*
	Name: processkillstreakassists
	Namespace: globallogic_score
	Checksum: 0xB5D4ADE0
	Offset: 0x7190
	Size: 0x1F4
	Parameters: 3
	Flags: Linked
*/
function processkillstreakassists(attacker, inflictor, weapon)
{
	if(!function_f38e3d84(attacker, inflictor, weapon))
	{
		return;
	}
	params = {#weapon:weapon, #inflictor:inflictor, #attacker:attacker, #players:[]};
	foreach(player in level.players)
	{
		if(util::function_fbce7263(player.team, attacker.team))
		{
			continue;
		}
		if(player == attacker)
		{
			continue;
		}
		if(player.sessionstate != "playing")
		{
			continue;
		}
		if(!isdefined(params.players))
		{
			params.players = [];
		}
		else if(!isarray(params.players))
		{
			params.players = array(params.players);
		}
		params.players[params.players.size] = player;
	}
	callback::callback(#"hash_425352b435722271", params);
}

/*
	Name: updateteamscorebyroundswon
	Namespace: globallogic_score
	Checksum: 0x9A692057
	Offset: 0x7390
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function updateteamscorebyroundswon()
{
	if(level.scoreroundwinbased)
	{
		foreach(team, _ in level.teams)
		{
			[[level._setteamscore]](team, game.stat[#"roundswon"][team]);
		}
	}
}

/*
	Name: function_e7b4c25c
	Namespace: globallogic_score
	Checksum: 0xBBC8DF6D
	Offset: 0x7440
	Size: 0x316
	Parameters: 6
	Flags: Linked
*/
function function_e7b4c25c(nemesis_name, value, nemesis_rank, var_15574043, nemesis_xp, nemesis_xuid)
{
	if(!isdefined(self.pers[#"nemesis_tracking"][nemesis_name]))
	{
		self.pers[#"nemesis_tracking"][nemesis_name] = {#value:0, #name:nemesis_name};
	}
	self.pers[#"nemesis_tracking"][nemesis_name].value = self.pers[#"nemesis_tracking"][nemesis_name].value + value;
	var_b5c193c6 = self.pers[#"nemesis_tracking"][self.pers[#"nemesis_name"]];
	if(self.pers[#"nemesis_name"] == "" || !isdefined(var_b5c193c6) || self.pers[#"nemesis_tracking"][nemesis_name].value > var_b5c193c6.value)
	{
		/#
			assert(isdefined(nemesis_name), "" + self.name);
		#/
		/#
			assert(isstring(nemesis_name), (("" + nemesis_name) + "") + self.name);
		#/
		self.pers[#"nemesis_name"] = nemesis_name;
		self.pers[#"nemesis_rank"] = nemesis_rank;
		self.pers[#"nemesis_rankicon"] = var_15574043;
		self.pers[#"nemesis_xp"] = nemesis_xp;
		self.pers[#"nemesis_xuid"] = nemesis_xuid;
	}
	else if(isdefined(self.pers[#"nemesis_name"]) && self.pers[#"nemesis_name"] == nemesis_name)
	{
		self.pers[#"nemesis_rank"] = nemesis_rank;
		self.pers[#"nemesis_xp"] = nemesis_xp;
	}
}

/*
	Name: function_30ab51a4
	Namespace: globallogic_score
	Checksum: 0xF32E8A4B
	Offset: 0x7760
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function function_30ab51a4(params)
{
	if(isdefined(self) && isdefined(self.pers))
	{
		self.pers[#"hash_49e7469988944ecf"] = undefined;
		self.pers[#"hash_53919d92ff1d039"] = undefined;
	}
}

/*
	Name: function_253ff387
	Namespace: globallogic_score
	Checksum: 0x3AA735D9
	Offset: 0x77C0
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_253ff387(params)
{
	if(params.var_b66879ad === 0)
	{
		return;
	}
	function_30ab51a4(params);
}

