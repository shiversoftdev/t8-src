// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\shoutcaster.csc;
#using scripts\core_common\util_shared.csc;

#namespace ctf;

/*
	Name: main
	Namespace: ctf
	Checksum: 0xA5143E0A
	Offset: 0x1E0
	Size: 0x2F4
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	callback::on_localclient_connect(&on_localclient_connect);
	clientfield::register("scriptmover", "ctf_flag_away", 17000, 1, "int", &setctfaway, 0, 0);
	clientfield::register("allplayers", "ctf_flag_carried", 17000, 1, "int", &function_4db33d0, 0, 1);
	clientfield::register("worlduimodel", "CTFLevelInfo.bestTimeAllies", 17000, 9, "int", undefined, 0, 0);
	clientfield::register("worlduimodel", "CTFLevelInfo.bestTimeAxis", 17000, 9, "int", undefined, 0, 0);
	clientfield::register("worlduimodel", "CTFLevelInfo.flagCarrierAllies", 17000, 7, "int", undefined, 0, 0);
	clientfield::register("worlduimodel", "CTFLevelInfo.flagCarrierAxis", 17000, 7, "int", undefined, 0, 0);
	clientfield::register("worlduimodel", "CTFLevelInfo.flagStateAllies", 17000, 2, "int", undefined, 0, 0);
	clientfield::register("worlduimodel", "CTFLevelInfo.flagStateAxis", 17000, 2, "int", undefined, 0, 0);
	clientfield::register("worlduimodel", "ctf_reset_score", 17000, 1, "int", &ctf_reset_score, 0, 0);
	forcestreamxmodel(#"p8_mp_flag_pole_1_blackops", 8, -1);
	forcestreamxmodel(#"hash_5569a00a8fe22d03", 8, -1);
	forcestreamxmodel(#"p8_mp_flag_pole_1_mercs", 8, -1);
	forcestreamxmodel(#"hash_62818f90d175c02c", 8, -1);
}

/*
	Name: ctf_reset_score
	Namespace: ctf
	Checksum: 0xB4A22B5D
	Offset: 0x4E0
	Size: 0xF4
	Parameters: 7
	Flags: None
*/
function ctf_reset_score(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	var_c2c45c73 = getuimodel(getuimodelforcontroller(localclientnum), "GameScore");
	var_dbedf85e = getuimodel(var_c2c45c73, "playerScore");
	var_b61c1787 = getuimodel(var_c2c45c73, "enemyScore");
	setuimodelvalue(var_dbedf85e, 0);
	setuimodelvalue(var_b61c1787, 0);
}

/*
	Name: on_localclient_connect
	Namespace: ctf
	Checksum: 0x859DCCB0
	Offset: 0x5E0
	Size: 0xAC
	Parameters: 1
	Flags: None
*/
function on_localclient_connect(localclientnum)
{
	level.var_8b7ba196[localclientnum] = util::getnextobjid(localclientnum);
	objective_add(localclientnum, level.var_8b7ba196[localclientnum], "invisible", #"flag_taken", (0, 0, 0), util::get_other_team(function_9b3f0ed1(localclientnum)));
	level thread function_27ecd662(localclientnum);
}

/*
	Name: function_27ecd662
	Namespace: ctf
	Checksum: 0x89E443DE
	Offset: 0x698
	Size: 0x21E
	Parameters: 1
	Flags: None
*/
function function_27ecd662(localclientnum)
{
	player = function_27673a7(localclientnum);
	player endon(#"disconnect");
	while(true)
	{
		enemies = getplayers(localclientnum);
		player = function_27673a7(localclientnum);
		var_3b68ee3f = undefined;
		foreach(enemy in enemies)
		{
			if(enemy.team == player.team)
			{
				continue;
			}
			if(isdefined(enemy.var_b0256c7b) && enemy.var_b0256c7b)
			{
				var_3b68ee3f = enemy.origin;
				break;
			}
		}
		if(isdefined(var_3b68ee3f))
		{
			var_b13a6419 = gettime();
			objective_setstate(localclientnum, level.var_8b7ba196[localclientnum], "active");
			objective_setposition(localclientnum, level.var_8b7ba196[localclientnum], var_3b68ee3f);
			while(var_b13a6419 + 2000 > gettime() && isdefined(enemy) && enemy.var_b0256c7b)
			{
				waitframe(1);
			}
		}
		else
		{
			objective_setstate(localclientnum, level.var_8b7ba196[localclientnum], "invisible");
			waitframe(1);
		}
	}
}

/*
	Name: setctfaway
	Namespace: ctf
	Checksum: 0x14EBA08C
	Offset: 0x8C0
	Size: 0x84
	Parameters: 7
	Flags: None
*/
function setctfaway(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	team = self.team;
	setflagasaway(localclientnum, team, newval);
	self thread clearctfaway(localclientnum, team);
}

/*
	Name: clearctfaway
	Namespace: ctf
	Checksum: 0xFF96442F
	Offset: 0x950
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function clearctfaway(localclientnum, team)
{
	self waittill(#"death");
	setflagasaway(localclientnum, team, 0);
}

/*
	Name: function_4db33d0
	Namespace: ctf
	Checksum: 0x4BFF13C1
	Offset: 0x9A0
	Size: 0x4A
	Parameters: 7
	Flags: None
*/
function function_4db33d0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self.var_b0256c7b = newval;
}

