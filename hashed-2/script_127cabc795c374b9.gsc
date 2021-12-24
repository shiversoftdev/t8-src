// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_47fb62300ac0bd60;
#using script_5b1c3d314b9c88fb;
#using script_cb32d07c95e5628;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\gamestate.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_87f097c4;

/*
	Name: function_89f2df9
	Namespace: namespace_87f097c4
	Checksum: 0xD8528663
	Offset: 0x130
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_7551e984c9a42af9", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_87f097c4
	Checksum: 0x9294CB1A
	Offset: 0x178
	Size: 0x1DC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_6e0c26c7 = (isdefined(getgametypesetting(#"hash_30b11d064f146fcc")) ? getgametypesetting(#"hash_30b11d064f146fcc") : 0) || (isdefined(getgametypesetting(#"hash_697d65a68cc6c6f1")) ? getgametypesetting(#"hash_697d65a68cc6c6f1") : 0);
	if(level.var_6e0c26c7)
	{
		clientfield::register("world", "zombie_arm_blood_splash", 20000, 1, "counter");
		clientfield::register("world", "bathtub_fake_soul_sfx", 20000, 1, "counter");
		level.var_e91bcfae = 0;
		var_430db2b8 = getent("zombie_arm", "targetname");
		if(isdefined(var_430db2b8))
		{
			var_430db2b8 ghost();
		}
		level.var_afdd2ed7 = 0;
		callback::on_ai_killed(&on_ai_killed);
		callback::function_10a4dd0a(&function_dd00c744);
	}
	/#
		function_4ed420e3();
	#/
}

/*
	Name: on_ai_killed
	Namespace: namespace_87f097c4
	Checksum: 0x13827EE7
	Offset: 0x360
	Size: 0x176
	Parameters: 1
	Flags: Linked
*/
function on_ai_killed(params)
{
	if(isdefined(level.var_e91bcfae) && level.var_e91bcfae)
	{
		return;
	}
	if(isplayer(params.eattacker))
	{
		attacker = params.eattacker;
		bathtub = struct::get(#"hash_53bbab305c87572a", "targetname");
		if(isdefined(bathtub))
		{
			distance = distance(bathtub.origin, attacker.origin);
			if(distance < 256)
			{
				level.var_afdd2ed7++;
				level clientfield::increment("bathtub_fake_soul_sfx", 1);
			}
			if(level.var_afdd2ed7 >= 3)
			{
				level thread function_613448ed(attacker, bathtub);
				callback::remove_callback(#"on_ai_killed", &on_ai_killed);
				level.var_afdd2ed7 = undefined;
			}
		}
	}
}

/*
	Name: function_dd00c744
	Namespace: namespace_87f097c4
	Checksum: 0x5AF52F1E
	Offset: 0x4E0
	Size: 0x184
	Parameters: 1
	Flags: Linked
*/
function function_dd00c744(params)
{
	if(!isdefined(params.item))
	{
		return;
	}
	item = params.item;
	if(isplayer(self))
	{
		if(isdefined(item.var_cd8fb96) && item.var_cd8fb96)
		{
			var_430db2b8 = getent("zombie_arm", "targetname");
			if(isdefined(var_430db2b8))
			{
				var_4805bfaa = (var_430db2b8.origin[0], var_430db2b8.origin[1], var_430db2b8.origin[2] + -24);
				var_430db2b8 playsound(#"hash_134bc3c2ce6ed759");
				level thread function_ca44f5a5(var_430db2b8, var_4805bfaa, 1);
				level clientfield::increment("zombie_arm_blood_splash", 1);
				callback::remove_callback(#"hash_56d1805bfff3e65b", &function_dd00c744);
			}
		}
	}
}

/*
	Name: function_613448ed
	Namespace: namespace_87f097c4
	Checksum: 0x7A03AB61
	Offset: 0x670
	Size: 0x264
	Parameters: 2
	Flags: Linked
*/
function function_613448ed(player, bathtub)
{
	self notify("1db1954ce3ca6f10");
	self endon("1db1954ce3ca6f10");
	if(isdefined(level.var_e91bcfae) && level.var_e91bcfae)
	{
		return;
	}
	var_47943768 = function_1deb2b38(bathtub);
	var_430db2b8 = getent("zombie_arm", "targetname");
	if(isdefined(var_430db2b8) && isdefined(var_47943768))
	{
		var_47943768.var_cd8fb96 = 1;
		var_4805bfaa = (var_430db2b8.origin[0], var_430db2b8.origin[1], var_430db2b8.origin[2] + 24);
		var_47943768.origin = (var_430db2b8.origin[0] + 2, var_430db2b8.origin[1] + 1.5, var_430db2b8.origin[2] + 15);
		var_47943768.angles = (0, -50, -90);
		var_45f173ec = (var_47943768.origin[0], var_47943768.origin[1], var_47943768.origin[2] + 24);
		var_430db2b8 show();
		var_430db2b8 playsound(#"hash_2b9e3e8f3a11bcdb");
		level clientfield::increment("zombie_arm_blood_splash", 1);
		level thread function_ca44f5a5(var_430db2b8, var_4805bfaa);
		level thread function_b413daad(var_47943768, var_45f173ec);
	}
}

/*
	Name: function_ca44f5a5
	Namespace: namespace_87f097c4
	Checksum: 0x1F80A52B
	Offset: 0x8E0
	Size: 0xB4
	Parameters: 3
	Flags: Linked
*/
function function_ca44f5a5(var_430db2b8, target_pos, var_e77e9de = 0)
{
	if(!isdefined(var_430db2b8) || !isdefined(target_pos))
	{
		return;
	}
	var_430db2b8 endon(#"death");
	var_430db2b8 moveto(target_pos, 2);
	if(var_e77e9de)
	{
		var_430db2b8 waittill(#"movedone");
		var_430db2b8 ghost();
	}
}

/*
	Name: function_b413daad
	Namespace: namespace_87f097c4
	Checksum: 0xDBCCEBDD
	Offset: 0x9A0
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function function_b413daad(var_47943768, target_pos)
{
	var_47943768 moveto(target_pos, 2);
}

/*
	Name: function_1deb2b38
	Namespace: namespace_87f097c4
	Checksum: 0xC1E0DA75
	Offset: 0x9E0
	Size: 0xEA
	Parameters: 1
	Flags: Linked
*/
function function_1deb2b38(var_b721e8a9)
{
	if(!isdefined(var_b721e8a9) || (isdefined(level.var_e91bcfae) && level.var_e91bcfae))
	{
		return;
	}
	level.var_e91bcfae = 1;
	if(isdefined(var_b721e8a9))
	{
		a_items = var_b721e8a9 namespace_65181344::function_fd87c780(#"hash_36b0e1ba91844d34", 1);
		foreach(item in a_items)
		{
			if(isdefined(item))
			{
				return item;
			}
		}
	}
}

/*
	Name: function_4ed420e3
	Namespace: namespace_87f097c4
	Checksum: 0x3BDC5C43
	Offset: 0xAD8
	Size: 0x84
	Parameters: 0
	Flags: None
*/
function function_4ed420e3()
{
	/#
		while(!canadddebugcommand())
		{
			waitframe(1);
		}
		mapname = util::function_53bbf9d2();
		adddebugcommand(("" + mapname) + "");
		level thread function_7eabf705();
	#/
}

/*
	Name: function_7eabf705
	Namespace: namespace_87f097c4
	Checksum: 0x7EB489F3
	Offset: 0xB68
	Size: 0x10E
	Parameters: 0
	Flags: None
*/
function function_7eabf705()
{
	/#
		self notify("");
		self endon("");
		level endon(#"game_ended");
		level endon(#"hash_671b150516dd9870");
		while(true)
		{
			if(getdvarint(#"hash_7e7b9e2edcf6d1ee", 0))
			{
				players = getplayers();
				bathtub = struct::get(#"hash_53bbab305c87572a", "");
				function_613448ed(players[0], bathtub);
				level notify(#"hash_671b150516dd9870");
				break;
			}
			waitframe(1);
		}
	#/
}

