// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.gsc;
#using scripts\mp_common\gametypes\globallogic_audio.gsc;
#using scripts\mp_common\gametypes\globallogic_score.gsc;
#using scripts\mp_common\userspawnselection.gsc;
#using scripts\mp_common\util.gsc;

#namespace gametype;

/*
	Name: init
	Namespace: gametype
	Checksum: 0xE724B7D0
	Offset: 0xC8
	Size: 0x16E
	Parameters: 0
	Flags: Linked
*/
function init()
{
	bundle = function_302bd0b9();
	level.var_d1455682 = bundle;
	level.var_812be535 = 0;
	if(!isdefined(bundle))
	{
		return;
	}
	level.teambased = function_b2272884();
	setvisiblescoreboardcolumns(bundle.scoreboard_1, bundle.scoreboard_2, bundle.scoreboard_3, bundle.scoreboard_4, bundle.scoreboard_5, bundle.var_d4259e74, bundle.var_54dd9ff6, bundle.var_5ee7b40a, bundle.var_6d3350a1, bundle.var_26d52900);
	globallogic_audio::set_leader_gametype_dialog(bundle.var_ef0e6936, bundle.var_92ea240c, bundle.var_39d466bc, bundle.var_fd58840f, "", "");
	if(!isdefined(game.switchedsides))
	{
		game.switchedsides = 0;
	}
	level.onroundswitch = &on_round_switch;
}

/*
	Name: function_d81f6eb7
	Namespace: gametype
	Checksum: 0xEF3B58D4
	Offset: 0x240
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_d81f6eb7()
{
	bundle = level.var_d1455682;
	if(!isdefined(bundle))
	{
		return;
	}
	function_f2f4dfa7();
	util::function_9540d9b6();
	if(!util::isoneround() && level.scoreroundwinbased)
	{
		globallogic_score::resetteamscores();
	}
}

/*
	Name: on_round_switch
	Namespace: gametype
	Checksum: 0x8673DC05
	Offset: 0x2C8
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function on_round_switch()
{
	bundle = level.var_d1455682;
	if(!isdefined(bundle))
	{
		return;
	}
	if(isdefined(level.var_d1455682.switchsides) && level.var_d1455682.switchsides)
	{
		game.switchedsides = !game.switchedsides;
		userspawnselection::onroundchange();
	}
}

/*
	Name: function_788fb510
	Namespace: gametype
	Checksum: 0xC4CCA1CD
	Offset: 0x350
	Size: 0x20
	Parameters: 1
	Flags: Linked, Private
*/
function private function_788fb510(value)
{
	if(!isdefined(value))
	{
		return "";
	}
	return value;
}

/*
	Name: setvisiblescoreboardcolumns
	Namespace: gametype
	Checksum: 0x704F31F2
	Offset: 0x378
	Size: 0x1EC
	Parameters: 10
	Flags: Linked
*/
function setvisiblescoreboardcolumns(col1, col2, col3, col4, col5, col6, col7, col8, col9, col10)
{
	col1 = function_788fb510(col1);
	col2 = function_788fb510(col2);
	col3 = function_788fb510(col3);
	col4 = function_788fb510(col4);
	col5 = function_788fb510(col5);
	col6 = function_788fb510(col6);
	col7 = function_788fb510(col7);
	col8 = function_788fb510(col8);
	col9 = function_788fb510(col9);
	col10 = function_788fb510(col10);
	if(!level.rankedmatch)
	{
		setscoreboardcolumns(col1, col2, col3, col4, col5, col6, col7, col8, col9, col10, "sbtimeplayed", "shotshit", "shotsmissed", "victory");
	}
	else
	{
		setscoreboardcolumns(col1, col2, col3, col4, col5, col6, col7, col8, col9, col10);
	}
}

/*
	Name: function_f2f4dfa7
	Namespace: gametype
	Checksum: 0x7A6C199
	Offset: 0x570
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_f2f4dfa7()
{
	if(isdefined(level.var_d1455682.switchsides) && level.var_d1455682.switchsides && game.switchedsides)
	{
		util::set_team_mapping(game.defenders, game.attackers);
	}
	else
	{
		util::set_team_mapping(game.attackers, game.defenders);
	}
}

