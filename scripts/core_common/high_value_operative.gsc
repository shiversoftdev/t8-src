// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\player\player_role.gsc;
#using scripts\core_common\player\player_stats.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace hvo;

/*
	Name: __init__system__
	Namespace: hvo
	Checksum: 0xE469AB4C
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"high_value_operative", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: hvo
	Checksum: 0x1B2DE092
	Offset: 0xE8
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function __init__()
{
	setdvar(#"hash_35dbebb08d656926", 0);
	callback::on_spawned(&function_59d3154f);
}

/*
	Name: function_2ce5cb7e
	Namespace: hvo
	Checksum: 0xC69E6E77
	Offset: 0x138
	Size: 0x61A
	Parameters: 0
	Flags: None
*/
function function_2ce5cb7e()
{
	if(!getdvarint(#"hash_35dbebb08d656926", 0) || isdefined(self.pers[#"hvo"]) || isbot(self) || !level.rankedmatch || level.disablestattracking)
	{
		return;
	}
	self.pers[#"hvo"] = [];
	self.pers[#"hvo"][#"base"] = [];
	self.pers[#"hvo"][#"current"] = [];
	var_e800bb6a = getscriptbundlelist("hvolist");
	if(isdefined(var_e800bb6a) && isarray(var_e800bb6a))
	{
		foreach(var_3aa46fc3 in var_e800bb6a)
		{
			hvo = getscriptbundle(var_3aa46fc3);
			if(!isdefined(hvo) || !isdefined(hvo.var_739c1749) || !isarray(hvo.var_739c1749))
			{
				continue;
			}
			if(isdefined(hvo.var_46a95923) && hvo.var_46a95923 != "none" && hvo.var_46a95923 != level.gametype)
			{
				continue;
			}
			foreach(stat in hvo.var_739c1749)
			{
				if(!isdefined(stat) || !isdefined(stat.stattype))
				{
					continue;
				}
				if(isdefined(stat.var_82670522) && isdefined(self.pers[#"hvo"][#"base"][stat.var_82670522]) || isdefined(self.pers[#"hvo"][#"base"][stat.stattype]))
				{
					continue;
				}
				switch(stat.stattype)
				{
					case "playerstatslist":
					{
						if(!isdefined(stat.var_82670522))
						{
							break;
						}
						self.pers[#"hvo"][#"base"][stat.var_82670522] = self stats::get_stat_global(stat.var_82670522);
						self.pers[#"hvo"][#"current"][stat.var_82670522] = self stats::get_stat_global(stat.var_82670522);
						break;
					}
					case "razorwireekia":
					{
						razorwireekia = self stats::get_stat_global(#"stats_concertina_wire_snared_kill") + self stats::get_stat_global(#"stats_concertina_wire_kill");
						self.pers[#"hvo"][#"base"][stat.stattype] = razorwireekia;
						self.pers[#"hvo"][#"current"][stat.stattype] = razorwireekia;
						break;
					}
					case "highestkillstreak":
					case "objectivescore":
					case "objectivetime":
					case "damagedone":
					case "highestmultikill":
					case "objectiveekia":
					default:
					{
						self.pers[#"hvo"][#"base"][stat.stattype] = 0;
						self.pers[#"hvo"][#"current"][stat.stattype] = 0;
						break;
					}
				}
			}
		}
	}
}

/*
	Name: function_59d3154f
	Namespace: hvo
	Checksum: 0x5CEAB0F4
	Offset: 0x760
	Size: 0x60E
	Parameters: 0
	Flags: None
*/
function function_59d3154f()
{
	if(!getdvarint(#"hash_35dbebb08d656926", 0) || !(isdefined(self.var_228b6835) ? self.var_228b6835 : 0) || !level.rankedmatch || level.disablestattracking)
	{
		return;
	}
	var_e800bb6a = getscriptbundlelist("hvolist");
	var_aa1fbd8c = self.pers[#"hash_1b145cf9f0673e9"];
	if(!isdefined(var_e800bb6a) || !isarray(var_e800bb6a) || !isdefined(var_aa1fbd8c))
	{
		return;
	}
	if(!isdefined(self.pers[#"hvo"][var_aa1fbd8c]))
	{
		self.pers[#"hvo"][var_aa1fbd8c] = [];
	}
	var_d6155829 = [];
	foreach(var_3aa46fc3 in var_e800bb6a)
	{
		hvo = getscriptbundle(var_3aa46fc3);
		if(!isdefined(hvo) || !isdefined(hvo.var_739c1749) || !isarray(hvo.var_739c1749))
		{
			continue;
		}
		if(isdefined(hvo.var_447510ee) && hvo.var_447510ee != var_aa1fbd8c)
		{
			continue;
		}
		if(isdefined(hvo.var_46a95923) && hvo.var_46a95923 != "none" && hvo.var_46a95923 != level.gametype)
		{
			continue;
		}
		foreach(stat in hvo.var_739c1749)
		{
			if(!isdefined(stat) || (isdefined(stat.var_233a23b6) && stat.var_233a23b6) || !isdefined(stat.stattype))
			{
				continue;
			}
			switch(stat.stattype)
			{
				case "playerstatslist":
				{
					if(!isdefined(stat.var_82670522))
					{
						break;
					}
					var_6fda3763 = self function_d0c02a50(stat, var_aa1fbd8c, stat.stattype);
					var_d6155829[stat.var_82670522] = var_6fda3763;
					break;
				}
				case "razorwireekia":
				{
					razorwireekia = self stats::get_stat_global(#"stats_concertina_wire_snared_kill") + self stats::get_stat_global(#"stats_concertina_wire_kill");
					self function_b535c32e(stat, razorwireekia, var_aa1fbd8c);
					var_d6155829[stat.stattype] = razorwireekia;
					break;
				}
				case "objectivescore":
				case "objectivetime":
				case "damagedone":
				case "objectiveekia":
				{
					var_6fda3763 = self function_b535c32e(stat, self.pers[stat.stattype], var_aa1fbd8c);
					var_d6155829[stat.stattype] = var_6fda3763;
					break;
				}
				case "highestkillstreak":
				{
					var_6fda3763 = self.pers[#"cur_kill_streak"] - self.pers[#"hvo"][#"current"][#"highestkillstreak"];
					self function_be94d98b(stat, var_6fda3763, var_aa1fbd8c);
					break;
				}
			}
		}
	}
	var_d6155829[#"highestkillstreak"] = self.pers[#"cur_kill_streak"];
	foreach(index, stat in var_d6155829)
	{
		self.pers[#"hvo"][#"current"][index] = stat;
	}
}

/*
	Name: function_323c6715
	Namespace: hvo
	Checksum: 0xEDBAF382
	Offset: 0xD78
	Size: 0xCD8
	Parameters: 0
	Flags: None
*/
function function_323c6715()
{
	if(!getdvarint(#"hash_35dbebb08d656926", 0) || !level.rankedmatch || level.disablestattracking)
	{
		return;
	}
	var_e800bb6a = getscriptbundlelist("hvolist");
	players = getplayers();
	if(!isdefined(var_e800bb6a) || !isarray(var_e800bb6a) || !isdefined(players) || !isarray(players))
	{
		return;
	}
	level.var_1a0a6769 = [];
	foreach(var_74be6838, var_3aa46fc3 in var_e800bb6a)
	{
		hvo = getscriptbundle(var_3aa46fc3);
		if(!isdefined(hvo) || !isdefined(hvo.var_739c1749) || !isarray(hvo.var_739c1749))
		{
			continue;
		}
		if(isdefined(hvo.var_46a95923) && hvo.var_46a95923 != "none" && hvo.var_46a95923 != level.gametype)
		{
			continue;
		}
		foreach(player in players)
		{
			if(!isdefined(player) || isbot(player))
			{
				continue;
			}
			/#
				assert(isdefined(player.pers), "");
			#/
			/#
				assert(isdefined(player.pers[#"hvo"]), "");
			#/
			var_9b4eeccc = function_b14806c6(player player_role::get(), currentsessionmode());
			if(!isdefined(var_9b4eeccc) || (isdefined(hvo.var_447510ee) && hvo.var_447510ee != var_9b4eeccc) || !isdefined(player.pers) || !isdefined(player.pers[#"hvo"]))
			{
				continue;
			}
			if(!isdefined(player.pers[#"hvo"][var_9b4eeccc]))
			{
				player.pers[#"hvo"][var_9b4eeccc] = [];
			}
			var_29da3a57 = 0;
			var_6ad8c73b = [];
			foreach(stat in hvo.var_739c1749)
			{
				if(!isdefined(stat) || !isdefined(stat.stattype))
				{
					continue;
				}
				switch(stat.stattype)
				{
					case "playerstatslist":
					{
						score = player function_cd851b02(stat, var_9b4eeccc, stat.stattype);
						break;
					}
					case "razorwireekia":
					{
						razorwireekia = player stats::get_stat_global(#"stats_concertina_wire_snared_kill") + player stats::get_stat_global(#"stats_concertina_wire_kill");
						score = player function_1fa30a47(stat, razorwireekia, var_9b4eeccc);
						break;
					}
					case "objectivescore":
					case "objectivetime":
					case "damagedone":
					case "objectiveekia":
					{
						score = player function_1fa30a47(stat, player.pers[stat.stattype], var_9b4eeccc);
						break;
					}
					case "highestkillstreak":
					{
						if(isdefined(stat.var_233a23b6) && stat.var_233a23b6)
						{
							score = (player.pers[#"cur_kill_streak"] > player.pers[#"best_kill_streak"] ? player.pers[#"cur_kill_streak"] : player.pers[#"best_kill_streak"]);
						}
						else
						{
							if(!isdefined(player.pers[#"hvo"][var_9b4eeccc][stat.stattype]))
							{
								player.pers[#"hvo"][var_9b4eeccc][stat.stattype] = 0;
							}
							score = (player.pers[#"cur_kill_streak"] > player.pers[#"hvo"][var_9b4eeccc][stat.stattype] ? player.pers[#"cur_kill_streak"] : player.pers[#"hvo"][var_9b4eeccc][stat.stattype]);
						}
						break;
					}
					case "highestmultikill":
					{
						score = (isdefined(player.pers[player.stattype]) ? player.pers[stat.stattype] : 0);
						break;
					}
					default:
					{
						score = 0;
						break;
					}
				}
				var_29da3a57 = var_29da3a57 + (score * (isdefined(stat.var_26568428) ? stat.var_26568428 : 0));
				var_6ad8c73b[var_6ad8c73b.size] = score;
			}
			for(index = 0; index < 3; index++)
			{
				if(!isdefined(level.var_1a0a6769[index]))
				{
					level.var_1a0a6769[index] = spawnstruct();
				}
				if(var_29da3a57 < (isdefined(level.var_1a0a6769[index].var_29da3a57) ? level.var_1a0a6769[index].var_29da3a57 : 0))
				{
					continue;
				}
				for(var_82927499 = 2; var_82927499 > index; var_82927499--)
				{
					if(!isdefined(level.var_1a0a6769[var_82927499]))
					{
						level.var_1a0a6769[var_82927499] = spawnstruct();
					}
					if(!isdefined(level.var_1a0a6769[var_82927499 - 1]))
					{
						level.var_1a0a6769[var_82927499 - 1] = spawnstruct();
					}
					level.var_1a0a6769[var_82927499].var_29da3a57 = level.var_1a0a6769[var_82927499 - 1].var_29da3a57;
					level.var_1a0a6769[var_82927499].player = level.var_1a0a6769[var_82927499 - 1].player;
					level.var_1a0a6769[var_82927499].hvo = level.var_1a0a6769[var_82927499 - 1].hvo;
					level.var_1a0a6769[var_82927499].var_74be6838 = level.var_1a0a6769[var_82927499 - 1].var_74be6838;
					level.var_1a0a6769[var_82927499].var_6ad8c73b = level.var_1a0a6769[var_82927499 - 1].var_6ad8c73b;
				}
				level.var_1a0a6769[index].var_29da3a57 = var_29da3a57;
				level.var_1a0a6769[index].player = player;
				level.var_1a0a6769[index].hvo = hvo;
				level.var_1a0a6769[index].var_74be6838 = var_74be6838;
				level.var_1a0a6769[index].var_6ad8c73b = var_6ad8c73b;
				break;
			}
		}
	}
	foreach(var_142bdec0 in level.var_1a0a6769)
	{
		loc_000019EC:
		luinotifyevent(#"hvo_card", 7, var_142bdec0.player.clientid, (isdefined(var_142bdec0.var_74be6838) ? var_142bdec0.var_74be6838 : 0), (isdefined(var_142bdec0.var_6ad8c73b[0]) ? var_142bdec0.var_6ad8c73b[0] : 0), (isdefined(var_142bdec0.var_6ad8c73b[1]) ? var_142bdec0.var_6ad8c73b[1] : 0), (isdefined(var_142bdec0.var_6ad8c73b[2]) ? var_142bdec0.var_6ad8c73b[2] : 0), (isdefined(var_142bdec0.var_6ad8c73b[3]) ? var_142bdec0.var_6ad8c73b[3] : 0), (isdefined(var_142bdec0.var_6ad8c73b[4]) ? var_142bdec0.var_6ad8c73b[4] : 0));
	}
}

/*
	Name: function_cd851b02
	Namespace: hvo
	Checksum: 0xEE3071AE
	Offset: 0x1A58
	Size: 0x1A4
	Parameters: 3
	Flags: Private
*/
function private function_cd851b02(stat, var_9b4eeccc, ddl)
{
	if(!isdefined(stat.var_82670522))
	{
		return 0;
	}
	if(isdefined(stat.var_233a23b6) && stat.var_233a23b6)
	{
		score = self stats::get_stat(ddl, stat.var_82670522, #"statvalue") - self.pers[#"hvo"][#"base"][stat.var_82670522];
	}
	else
	{
		score = (isdefined(self.pers[#"hvo"][var_9b4eeccc][stat.var_82670522]) ? self.pers[#"hvo"][var_9b4eeccc][stat.var_82670522] : 0);
		score = score + (self stats::get_stat(ddl, stat.var_82670522, #"statvalue") - self.pers[#"hvo"][#"current"][stat.var_82670522]);
	}
	return score;
}

/*
	Name: function_d0c02a50
	Namespace: hvo
	Checksum: 0x91D36EEE
	Offset: 0x1C08
	Size: 0x14E
	Parameters: 3
	Flags: Private
*/
function private function_d0c02a50(stat, var_aa1fbd8c, ddl)
{
	if(!isdefined(self.pers[#"hvo"][var_aa1fbd8c][stat.var_82670522]))
	{
		self.pers[#"hvo"][var_aa1fbd8c][stat.var_82670522] = 0;
	}
	var_6fda3763 = self stats::get_stat(ddl, stat.var_82670522, #"statvalue");
	self.pers[#"hvo"][var_aa1fbd8c][stat.var_82670522] = self.pers[#"hvo"][var_aa1fbd8c][stat.var_82670522] + (var_6fda3763 - self.pers[#"hvo"][#"current"][stat.var_82670522]);
	return var_6fda3763;
}

/*
	Name: function_1fa30a47
	Namespace: hvo
	Checksum: 0x14D816F5
	Offset: 0x1D60
	Size: 0x13C
	Parameters: 3
	Flags: Private
*/
function private function_1fa30a47(stat, currentscore, var_9b4eeccc)
{
	if(isdefined(stat.var_233a23b6) && stat.var_233a23b6)
	{
		score = currentscore - self.pers[#"hvo"][#"base"][stat.stattype];
	}
	else
	{
		score = (isdefined(self.pers[#"hvo"][var_9b4eeccc][stat.stattype]) ? self.pers[#"hvo"][var_9b4eeccc][stat.stattype] : 0);
		score = score + (currentscore - self.pers[#"hvo"][#"current"][stat.stattype]);
	}
	return score;
}

/*
	Name: function_b535c32e
	Namespace: hvo
	Checksum: 0x6EDB0836
	Offset: 0x1EA8
	Size: 0x116
	Parameters: 3
	Flags: Private
*/
function private function_b535c32e(stat, score, var_aa1fbd8c)
{
	if(!isdefined(self.pers[#"hvo"][var_aa1fbd8c][stat.stattype]))
	{
		self.pers[#"hvo"][var_aa1fbd8c][stat.stattype] = 0;
	}
	self.pers[#"hvo"][var_aa1fbd8c][stat.stattype] = self.pers[#"hvo"][var_aa1fbd8c][stat.stattype] + (score - self.pers[#"hvo"][#"current"][stat.stattype]);
	return score;
}

/*
	Name: function_be94d98b
	Namespace: hvo
	Checksum: 0x1E5128FD
	Offset: 0x1FC8
	Size: 0xE2
	Parameters: 3
	Flags: Private
*/
function private function_be94d98b(stat, score, var_aa1fbd8c)
{
	if(!isdefined(self.pers[#"hvo"][var_aa1fbd8c][stat.stattype]))
	{
		self.pers[#"hvo"][var_aa1fbd8c][stat.stattype] = 0;
	}
	if(self.pers[#"hvo"][var_aa1fbd8c][stat.stattype] < score)
	{
		self.pers[#"hvo"][var_aa1fbd8c][stat.stattype] = score;
	}
}

