// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace rat;

/*
	Name: init
	Namespace: rat
	Checksum: 0x5B6D1F75
	Offset: 0x88
	Size: 0x62C
	Parameters: 0
	Flags: None
*/
function init()
{
	/#
		if(!isdefined(level.rat))
		{
			level.rat = spawnstruct();
			level.rat.common = spawnstruct();
			level.rat.script_command_list = [];
			level.rat.var_e53a63ce = 0;
			level.rat.var_cd4fd549 = 0;
			callback::on_player_killed(&function_cecf7c3d);
			addratscriptcmd("", &function_5fd1a95b);
			addratscriptcmd("", &rscteleport);
			addratscriptcmd("", &function_51706559);
			addratscriptcmd("", &function_b2fe8b5a);
			addratscriptcmd("", &function_bff535fb);
			addratscriptcmd("", &function_220d66d8);
			addratscriptcmd("", &function_be6e2f9f);
			addratscriptcmd("", &function_ff0fa082);
			addratscriptcmd("", &function_aecb1023);
			addratscriptcmd("", &function_90282828);
			addratscriptcmd("", &function_3b51dc31);
			addratscriptcmd("", &function_a6d4d86b);
			addratscriptcmd("", &function_54b7f226);
			addratscriptcmd("", &function_1b77bedd);
			addratscriptcmd("", &rscsimulatescripterror);
			addratscriptcmd("", &function_1f00a502);
			addratscriptcmd("", &function_696e6dd3);
			addratscriptcmd("", &function_dec22d87);
			addratscriptcmd("", &function_e3ab4393);
			addratscriptcmd("", &function_cb62ece6);
			addratscriptcmd("", &function_d197a150);
			addratscriptcmd("", &function_c4336b49);
			addratscriptcmd("", &function_ccc178f3);
			addratscriptcmd("", &function_2fa64525);
			addratscriptcmd("", &function_6fb461e2);
			addratscriptcmd("", &function_f52fc58b);
			addratscriptcmd("", &function_dbc9b57c);
			addratscriptcmd("", &function_4f3a7675);
			addratscriptcmd("", &function_458913b0);
			addratscriptcmd("", &function_191d6974);
			addratscriptcmd("", &function_d1b632ff);
			addratscriptcmd("", &function_7d9a084b);
			addratscriptcmd("", &function_1ac5a32b);
			addratscriptcmd("", &function_7992a479);
			addratscriptcmd("", &function_9efe300c);
		}
	#/
}

/*
	Name: function_7d22c1c9
	Namespace: rat
	Checksum: 0x4D221221
	Offset: 0x6C0
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function function_7d22c1c9()
{
	/#
		level flagsys::set("");
	#/
}

/*
	Name: function_65e13d0f
	Namespace: rat
	Checksum: 0x16B4D8CF
	Offset: 0x6F0
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function function_65e13d0f()
{
	/#
		level flagsys::clear("");
	#/
}

/*
	Name: function_b4f2a076
	Namespace: rat
	Checksum: 0x784AE5E5
	Offset: 0x720
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function function_b4f2a076()
{
	/#
		level flagsys::set("");
	#/
}

/*
	Name: function_6aa20375
	Namespace: rat
	Checksum: 0x6F3C8F57
	Offset: 0x750
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function function_6aa20375()
{
	/#
		level flagsys::clear("");
	#/
}

/*
	Name: addratscriptcmd
	Namespace: rat
	Checksum: 0xF831813C
	Offset: 0x780
	Size: 0x4A
	Parameters: 2
	Flags: None
*/
function addratscriptcmd(commandname, functioncallback)
{
	/#
		init();
		level.rat.script_command_list[commandname] = functioncallback;
	#/
}

/*
	Name: codecallback_ratscriptcommand
	Namespace: rat
	Checksum: 0xD146D540
	Offset: 0x7D8
	Size: 0x114
	Parameters: 1
	Flags: Event
*/
event codecallback_ratscriptcommand(params)
{
	/#
		init();
		/#
			assert(isdefined(params._cmd));
		#/
		/#
			assert(isdefined(params._id));
		#/
		/#
			assert(isdefined(level.rat.script_command_list[params._cmd]), "" + params._cmd);
		#/
		callback = level.rat.script_command_list[params._cmd];
		ret = level [[callback]](params);
		ratreportcommandresult(params._id, 1, ret);
	#/
}

/*
	Name: function_4337d833
	Namespace: rat
	Checksum: 0xA50A306C
	Offset: 0x8F8
	Size: 0x154
	Parameters: 1
	Flags: None
*/
function function_4337d833(params)
{
	/#
		if(isdefined(params.var_61e64cb8))
		{
			xuid = int(params.var_61e64cb8);
			foreach(player in getplayers())
			{
				if(!isdefined(player.bot))
				{
					player_xuid = int(player getxuid(1));
					if(xuid == player_xuid)
					{
						return player;
					}
				}
			}
			ratreportcommandresult(params._id, 0, "");
			wait(1);
		}
		else
		{
			return util::gethostplayer();
		}
	#/
}

/*
	Name: function_5fd1a95b
	Namespace: rat
	Checksum: 0x9FA344F7
	Offset: 0xA58
	Size: 0x98
	Parameters: 1
	Flags: None
*/
function function_5fd1a95b(params)
{
	/#
		foreach(cmd, func in level.rat.script_command_list)
		{
			function_55e20e75(params._id, cmd);
		}
	#/
}

/*
	Name: function_7992a479
	Namespace: rat
	Checksum: 0xA090265D
	Offset: 0xAF8
	Size: 0x6C
	Parameters: 1
	Flags: None
*/
function function_7992a479(params)
{
	/#
		player = function_4337d833(params);
		weapon = getweapon(params.weaponname);
		player giveweapon(weapon);
	#/
}

/*
	Name: function_1b77bedd
	Namespace: rat
	Checksum: 0x55807528
	Offset: 0xB70
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function function_1b77bedd(params)
{
	/#
		if(isdefined(level.inprematchperiod))
		{
			return level.inprematchperiod;
		}
	#/
}

/*
	Name: rscteleport
	Namespace: rat
	Checksum: 0x790BC406
	Offset: 0xBA8
	Size: 0x124
	Parameters: 1
	Flags: None
*/
function rscteleport(params)
{
	/#
		player = function_4337d833(params);
		pos = (float(params.x), float(params.y), float(params.z));
		player setorigin(pos);
		if(isdefined(params.ax))
		{
			angles = (float(params.ax), float(params.ay), float(params.az));
			player setplayerangles(angles);
		}
	#/
}

/*
	Name: function_696e6dd3
	Namespace: rat
	Checksum: 0xF9ED3BF9
	Offset: 0xCD8
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function function_696e6dd3(params)
{
	/#
		player = function_4337d833(params);
		player setstance(params.stance);
	#/
}

/*
	Name: function_b2fe8b5a
	Namespace: rat
	Checksum: 0x45983B40
	Offset: 0xD30
	Size: 0x42
	Parameters: 1
	Flags: None
*/
function function_b2fe8b5a(params)
{
	/#
		player = function_4337d833(params);
		return player getstance();
	#/
}

/*
	Name: function_cb62ece6
	Namespace: rat
	Checksum: 0x2A9CCCD
	Offset: 0xD80
	Size: 0x42
	Parameters: 1
	Flags: None
*/
function function_cb62ece6(params)
{
	/#
		player = function_4337d833(params);
		return player ismeleeing();
	#/
}

/*
	Name: function_bff535fb
	Namespace: rat
	Checksum: 0x78D226DF
	Offset: 0xDD0
	Size: 0x42
	Parameters: 1
	Flags: None
*/
function function_bff535fb(params)
{
	/#
		player = function_4337d833(params);
		return player playerads();
	#/
}

/*
	Name: function_220d66d8
	Namespace: rat
	Checksum: 0x2A9BF25A
	Offset: 0xE20
	Size: 0x3A
	Parameters: 1
	Flags: None
*/
function function_220d66d8(params)
{
	/#
		player = function_4337d833(params);
		return player.health;
	#/
}

/*
	Name: function_be6e2f9f
	Namespace: rat
	Checksum: 0xAB445188
	Offset: 0xE68
	Size: 0xAC
	Parameters: 1
	Flags: None
*/
function function_be6e2f9f(params)
{
	/#
		player = function_4337d833(params);
		if(isdefined(params.amount))
		{
			player dodamage(int(params.amount), player getorigin());
		}
		else
		{
			player dodamage(1, player getorigin());
		}
	#/
}

/*
	Name: function_ff0fa082
	Namespace: rat
	Checksum: 0x1ADCB24A
	Offset: 0xF20
	Size: 0x6C
	Parameters: 1
	Flags: None
*/
function function_ff0fa082(params)
{
	/#
		player = function_4337d833(params);
		currentweapon = player getcurrentweapon();
		if(isdefined(currentweapon.name))
		{
			return currentweapon.name;
		}
	#/
}

/*
	Name: function_7d9a084b
	Namespace: rat
	Checksum: 0xF9368D8E
	Offset: 0xF98
	Size: 0x6C
	Parameters: 1
	Flags: None
*/
function function_7d9a084b(params)
{
	/#
		player = function_4337d833(params);
		currentweapon = player getcurrentweapon();
		if(isdefined(currentweapon.name))
		{
			return currentweapon.reloadtime;
		}
	#/
}

/*
	Name: function_aecb1023
	Namespace: rat
	Checksum: 0xD75339A5
	Offset: 0x1010
	Size: 0x62
	Parameters: 1
	Flags: None
*/
function function_aecb1023(params)
{
	/#
		player = function_4337d833(params);
		currentweapon = player getcurrentweapon();
		return player getammocount(currentweapon);
	#/
}

/*
	Name: function_90282828
	Namespace: rat
	Checksum: 0xC19D7951
	Offset: 0x1080
	Size: 0x62
	Parameters: 1
	Flags: None
*/
function function_90282828(params)
{
	/#
		player = function_4337d833(params);
		currentweapon = player getcurrentweapon();
		return player getweaponammoclip(currentweapon);
	#/
}

/*
	Name: function_3b51dc31
	Namespace: rat
	Checksum: 0x65AA20B2
	Offset: 0x10F0
	Size: 0x62
	Parameters: 1
	Flags: None
*/
function function_3b51dc31(params)
{
	/#
		player = function_4337d833(params);
		currentweapon = player getcurrentweapon();
		return player function_f09c133d(currentweapon);
	#/
}

/*
	Name: function_54b7f226
	Namespace: rat
	Checksum: 0xF6124809
	Offset: 0x1160
	Size: 0xAC
	Parameters: 1
	Flags: None
*/
function function_54b7f226(params)
{
	/#
		player = function_4337d833(params);
		origin = player getorigin();
		function_55e20e75(params._id, origin);
		angles = player getplayerangles();
		function_55e20e75(params._id, angles);
	#/
}

/*
	Name: function_a6d4d86b
	Namespace: rat
	Checksum: 0x175AE8A3
	Offset: 0x1218
	Size: 0x4A
	Parameters: 1
	Flags: None
*/
function function_a6d4d86b(params)
{
	/#
		if(isdefined(params.var_185699f8))
		{
			return getnumconnectedplayers(1);
		}
		return getnumconnectedplayers(0);
	#/
}

/*
	Name: function_cecf7c3d
	Namespace: rat
	Checksum: 0xC6AF1E45
	Offset: 0x1270
	Size: 0x6A
	Parameters: 0
	Flags: None
*/
function function_cecf7c3d()
{
	/#
		if(isdefined(self.bot))
		{
			level.rat.var_cd4fd549 = level.rat.var_cd4fd549 + 1;
		}
		else
		{
			level.rat.var_e53a63ce = level.rat.var_e53a63ce + 1;
		}
	#/
}

/*
	Name: function_d197a150
	Namespace: rat
	Checksum: 0x284FFFB2
	Offset: 0x12E8
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function function_d197a150(params)
{
	/#
		return level.rat.var_e53a63ce;
	#/
}

/*
	Name: function_c4336b49
	Namespace: rat
	Checksum: 0x8FBF1B4
	Offset: 0x1318
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function function_c4336b49(params)
{
	/#
		return level.rat.var_cd4fd549;
	#/
}

/*
	Name: function_51706559
	Namespace: rat
	Checksum: 0xBC04A6F8
	Offset: 0x1348
	Size: 0x18C
	Parameters: 1
	Flags: None
*/
function function_51706559(params)
{
	/#
		foreach(player in level.players)
		{
			if(!isdefined(player.bot))
			{
				continue;
			}
			pos = (float(params.x), float(params.y), float(params.z));
			player setorigin(pos);
			if(isdefined(params.ax))
			{
				angles = (float(params.ax), float(params.ay), float(params.az));
				player setplayerangles(angles);
			}
			if(!isdefined(params.all))
			{
				break;
			}
		}
	#/
}

/*
	Name: function_dec22d87
	Namespace: rat
	Checksum: 0x78EE7156
	Offset: 0x14E0
	Size: 0x190
	Parameters: 1
	Flags: None
*/
function function_dec22d87(params)
{
	/#
		player = function_4337d833(params);
		forward = anglestoforward(player.angles);
		distance = 50;
		if(isdefined(params.distance))
		{
			distance = float(params.distance);
		}
		spawn = player.origin + forward * distance;
		foreach(other_player in level.players)
		{
			if(other_player == player)
			{
				continue;
			}
			if(isdefined(params.var_5d792f96) && int(params.var_5d792f96) && !isdefined(other_player.bot))
			{
				continue;
			}
			other_player setorigin(spawn);
		}
	#/
}

/*
	Name: function_e3ab4393
	Namespace: rat
	Checksum: 0xBBCE2841
	Offset: 0x1678
	Size: 0x1EC
	Parameters: 1
	Flags: None
*/
function function_e3ab4393(params)
{
	/#
		player = function_4337d833(params);
		forward = anglestoforward(player.angles);
		distance = 50;
		if(isdefined(params.distance))
		{
			distance = float(params.distance);
		}
		spawn = player.origin + forward * distance;
		foreach(other_player in level.players)
		{
			if(isdefined(params.bot) && int(params.bot) && !isdefined(other_player.bot))
			{
				continue;
			}
			if(player getteam() != other_player getteam())
			{
				other_player setorigin(spawn);
				other_player setplayerangles(player.angles);
				return;
			}
		}
		ratreportcommandresult(params._id, 0, "");
	#/
}

/*
	Name: function_1ac5a32b
	Namespace: rat
	Checksum: 0x6BCD7D96
	Offset: 0x1870
	Size: 0xD4
	Parameters: 1
	Flags: None
*/
function function_1ac5a32b(params)
{
	/#
		player = function_4337d833(params);
		forward = anglestoforward(player.angles);
		distance = 50;
		if(isdefined(params.distance))
		{
			distance = float(params.distance);
		}
		front = player.origin + forward * distance;
		player setorigin(front);
	#/
}

/*
	Name: function_ccc178f3
	Namespace: rat
	Checksum: 0x9EF0DDF2
	Offset: 0x1950
	Size: 0x42
	Parameters: 1
	Flags: None
*/
function function_ccc178f3(params)
{
	/#
		player = function_4337d833(params);
		return player isplayinganimscripted();
	#/
}

/*
	Name: function_6fb461e2
	Namespace: rat
	Checksum: 0xADA6F1D8
	Offset: 0x19A0
	Size: 0x44
	Parameters: 1
	Flags: None
*/
function function_6fb461e2(params)
{
	/#
		player = function_4337d833(params);
		return !player arecontrolsfrozen();
	#/
}

/*
	Name: function_2fa64525
	Namespace: rat
	Checksum: 0xB4F9C9C8
	Offset: 0x19F0
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function function_2fa64525(params)
{
	/#
		if(isdefined(params.flag))
		{
			return flagsys::get(params.flag);
		}
	#/
}

/*
	Name: function_1f00a502
	Namespace: rat
	Checksum: 0xA9A7DBCE
	Offset: 0x1A38
	Size: 0xA4
	Parameters: 1
	Flags: None
*/
function function_1f00a502(params)
{
	/#
		foreach(player in getplayers())
		{
			if(isbot(player))
			{
				return player.health;
			}
		}
		return -1;
	#/
}

/*
	Name: function_4f3a7675
	Namespace: rat
	Checksum: 0x2678EE1
	Offset: 0x1AE8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_4f3a7675(params)
{
	/#
		if(isdefined(level.var_5efad16e))
		{
			level [[level.var_5efad16e]]();
			return 1;
		}
		return 0;
	#/
}

/*
	Name: function_d04e8397
	Namespace: rat
	Checksum: 0xDCD38F4
	Offset: 0x1B38
	Size: 0x64
	Parameters: 1
	Flags: None
*/
function function_d04e8397(name)
{
	/#
		level flagsys::set("");
		level scene::play(name);
		level flagsys::clear("");
	#/
}

/*
	Name: function_191d6974
	Namespace: rat
	Checksum: 0xE965DF62
	Offset: 0x1BA8
	Size: 0x64
	Parameters: 1
	Flags: None
*/
function function_191d6974(params)
{
	/#
		if(isdefined(params.name))
		{
			level thread function_d04e8397(params.name);
		}
		else
		{
			ratreportcommandresult(params._id, 0, "");
		}
	#/
}

/*
	Name: function_d1b632ff
	Namespace: rat
	Checksum: 0x152FDC19
	Offset: 0x1C18
	Size: 0x2A
	Parameters: 1
	Flags: None
*/
function function_d1b632ff(params)
{
	/#
		return flagsys::get("");
	#/
}

/*
	Name: rscsimulatescripterror
	Namespace: rat
	Checksum: 0xFFB1395D
	Offset: 0x1C50
	Size: 0x5E
	Parameters: 1
	Flags: None
*/
function rscsimulatescripterror(params)
{
	/#
		if(params.errorlevel == "")
		{
			/#
				assertmsg("");
			#/
		}
		else
		{
			thisdoesntexist.orthis = 0;
		}
	#/
}

/*
	Name: rscrecteleport
	Namespace: rat
	Checksum: 0x55CE7749
	Offset: 0x1CB8
	Size: 0x154
	Parameters: 1
	Flags: None
*/
function rscrecteleport(params)
{
	/#
		println("");
		player = [[level.rat.common.gethostplayer]]();
		pos = player getorigin();
		angles = player getplayerangles();
		cmd = "" + pos[0] + "" + pos[1] + "" + pos[2] + "" + angles[0] + "" + angles[1] + "" + angles[2];
		ratrecordmessage(0, "", cmd);
		setdvar(#"rat_record_teleport_request", 0);
	#/
}

/*
	Name: function_f52fc58b
	Namespace: rat
	Checksum: 0x9B941762
	Offset: 0x1E18
	Size: 0x84
	Parameters: 1
	Flags: None
*/
function function_f52fc58b(params)
{
	/#
		num = 0;
		if(isdefined(params))
		{
			if(isdefined(params.num))
			{
				num = int(params.num);
			}
		}
		if(num > 0)
		{
			adddebugcommand("" + num);
		}
	#/
}

/*
	Name: function_dbc9b57c
	Namespace: rat
	Checksum: 0xFB6272DB
	Offset: 0x1EA8
	Size: 0x84
	Parameters: 1
	Flags: None
*/
function function_dbc9b57c(params)
{
	/#
		num = 0;
		if(isdefined(params))
		{
			if(isdefined(params.num))
			{
				num = int(params.num);
			}
		}
		if(num > 0)
		{
			adddebugcommand("" + num);
		}
	#/
}

/*
	Name: function_458913b0
	Namespace: rat
	Checksum: 0xE96E429D
	Offset: 0x1F38
	Size: 0x44
	Parameters: 1
	Flags: None
*/
function function_458913b0(params)
{
	/#
		player = function_4337d833(params);
		toggleplayercontrol(player);
	#/
}

/*
	Name: function_9efe300c
	Namespace: rat
	Checksum: 0x2979B60B
	Offset: 0x1F88
	Size: 0x13C
	Parameters: 1
	Flags: None
*/
function function_9efe300c(params)
{
	/#
		player = function_4337d833(params);
		spawn = 0;
		team = "";
		if(isdefined(params) && isdefined(params.spawn))
		{
			if(isdefined(params.spawn))
			{
				spawn = int(params.spawn);
			}
			if(isdefined(params.team))
			{
				team = params.team;
			}
		}
		if(isdefined(level.spawn_start) && isdefined(level.spawn_start[team]))
		{
			player setorigin(level.spawn_start[team][spawn].origin);
			player setplayerangles(level.spawn_start[team][spawn].angles);
		}
	#/
}

