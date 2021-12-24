// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2a1b4621c4186335;
#using script_31f976b33c4eb6dc;
#using script_3575fbea89393aba;
#using script_38ea81d05eba28f1;
#using script_3f6516099f1d5ff1;
#using script_71f2f8a6fc184b69;
#using script_7f431c02afd98cf0;
#using scripts\core_common\audio_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\mp_common\gametypes\globallogic_score.csc;
#using scripts\wz_common\vehicle.csc;

#namespace warzone;

/*
	Name: main
	Namespace: warzone
	Checksum: 0x81B96873
	Offset: 0x548
	Size: 0x854
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	insertion_passenger_count::register("insertionPassengerElem");
	var_f220c297 = getgametypesetting(#"hash_19400c3e10b77e6b");
	clientfield::register("worlduimodel", "hudItems.warzone.collapseTimerState", 1, 2, "int", undefined, 0, 0);
	clientfield::register("worlduimodel", "hudItems.warzone.collapseProgress", 1, 7, "float", undefined, 0, 0);
	clientfield::register("worlduimodel", "hudItems.warzone.reinsertionPassengerCount", 1, 7, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "hudItems.distanceFromDeathCircle", 1, 7, "float", undefined, 0, 0);
	clientfield::register("clientuimodel", "hudItems.alivePlayerCount", 1, 7, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "hudItems.alivePlayerCountEnemy", 1, 7, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "hudItems.aliveTeammateCount", 1, 7, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "hudItems.spectatorsCount", 1, 7, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "hudItems.playerKills", 1, 7, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "hudItems.playerCleanUps", 1, 7, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "presence.modeparam", 1, 7, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "hudItems.hasBackpack", 1, 1, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "hudItems.armorType", 1, 2, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "hudItems.streamerLoadFraction", 1, 5, "float", undefined, 0, 0);
	clientfield::register("clientuimodel", "hudItems.wzLoadFinished", 1, 1, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "hudItems.showReinsertionPassengerCount", 1, 1, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "hudItems.playerLivesRemaining", 15000, 3, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "hudItems.playerCanRedeploy", 15000, 1, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "hudItems.playerOnInfectedPlatoon", 21000, 1, "int", undefined, 0, 0);
	clientfield::register("allplayers", "eliminator_screen", 1, 1, "int", &function_2985ca96, 0, 0);
	clientfield::register("toplayer", "realtime_multiplay", 1, 1, "int", &function_a1b40aa4, 0, 0);
	clientfield::register("worlduimodel", "hudItems.warzone.collapse", 11000, 21, "int", undefined, 0, 0);
	clientfield::register("worlduimodel", "hudItems.warzone.waveRespawnTimer", 15000, 21, "int", undefined, 0, 0);
	clientfield::register("worlduimodel", "hudItems.warzone.collapseIndex", 1, 3, "int", undefined, 0, 0);
	clientfield::register("worlduimodel", "hudItems.warzone.collapseCount", 1, 3, "int", undefined, 0, 0);
	clientfield::register("worlduimodel", "hudItems.warzone.reinsertionIndex", 1, 3, "int", undefined, 0, 0);
	callback::on_localplayer_spawned(&on_player_spawned);
	callback::function_e9e16e2f(&function_e9e16e2f);
	callback::function_4f6cafea(&function_4f6cafea);
	callback::on_localclient_connect(&on_localclient_connect);
	level.var_a5ec5f1a = [];
	for(i = 0; i < getmaxlocalclients(); i++)
	{
		level.var_a5ec5f1a[i] = [];
	}
	level thread function_7be1ea25();
	level thread function_783be487();
	callback::function_d46d9315(&function_1bcd6e1e);
	level function_b522ef5c();
	function_41f9de03();
	function_f6b076db();
	if(isdefined(getgametypesetting(#"hash_3a73deb0ca8c9aea")) && getgametypesetting(#"hash_3a73deb0ca8c9aea"))
	{
		setdvar(#"cg_drawcrosshair", 0);
	}
	if(isdefined(getgametypesetting(#"hash_7532afe3ef8b4332")) && getgametypesetting(#"hash_7532afe3ef8b4332"))
	{
		setdvar(#"hash_2d5b0d6d4ce995d7", 0);
	}
}

/*
	Name: function_1bcd6e1e
	Namespace: warzone
	Checksum: 0x111113C2
	Offset: 0xDA8
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function function_1bcd6e1e(localclientnum)
{
	function_d547b972();
	function_65469e2e();
	if(isdefined(getgametypesetting(#"hash_6cc7b012775d9662")) && getgametypesetting(#"hash_6cc7b012775d9662"))
	{
		level thread function_3dadedf8(localclientnum);
	}
}

/*
	Name: function_7be1ea25
	Namespace: warzone
	Checksum: 0x73742A87
	Offset: 0xE48
	Size: 0x340
	Parameters: 0
	Flags: Linked
*/
function function_7be1ea25()
{
	level endon(#"disconnect");
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(#"hash_34bb692dbc392d7f");
		localclientnum = waitresult.localclientnum;
		obj_id = util::getnextobjid(localclientnum);
		clientobjid = level.var_a5ec5f1a[localclientnum][waitresult.clientnum];
		if(isdefined(clientobjid))
		{
			objective_delete(localclientnum, clientobjid);
			util::releaseobjid(localclientnum, clientobjid);
		}
		level.var_a5ec5f1a[localclientnum][waitresult.clientnum] = obj_id;
		if(!(isdefined(getgametypesetting(#"hash_76c2c603f164eb31")) && getgametypesetting(#"hash_76c2c603f164eb31")) || (!(isdefined(level.localplayers[localclientnum].var_13a5716d) && level.localplayers[localclientnum].var_13a5716d)))
		{
			objective_add(localclientnum, obj_id, "active", #"hash_3a3dbdaf943d02d5", (waitresult.xcoord, waitresult.ycoord, 0), #"none", waitresult.clientnum);
		}
		else
		{
			x = waitresult.xcoord;
			y = waitresult.ycoord;
			var_bfd46ccc = 2147483647;
			var_cfa5f67b = 2147483647;
			trace = bullettrace((x, y, var_bfd46ccc), (x, y, var_cfa5f67b), 0, self, 1);
			position = trace[#"position"];
			objective_add(localclientnum, obj_id, "active", #"hash_4d290db83b852838", position, #"none", waitresult.clientnum);
			level thread function_97d0a8af(localclientnum, obj_id, x, y, waitresult.clientnum);
		}
		function_2e625a75(localclientnum, obj_id, 1);
	}
}

/*
	Name: function_97d0a8af
	Namespace: warzone
	Checksum: 0x4586C866
	Offset: 0x1190
	Size: 0xEC
	Parameters: 5
	Flags: Linked
*/
function function_97d0a8af(local_client_num, obj_id, x, y, clientnum)
{
	self notify("68f151c5b262427f");
	self endon("68f151c5b262427f");
	while(isdefined(level.localplayers[local_client_num].var_13a5716d) && level.localplayers[local_client_num].var_13a5716d)
	{
		wait(0.1);
	}
	objective_delete(local_client_num, obj_id);
	objective_add(local_client_num, obj_id, "active", #"hash_3a3dbdaf943d02d5", (x, y, 0), #"none", clientnum);
}

/*
	Name: function_783be487
	Namespace: warzone
	Checksum: 0x346A7FA4
	Offset: 0x1288
	Size: 0xFE
	Parameters: 0
	Flags: Linked
*/
function function_783be487()
{
	level endon(#"disconnect");
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(#"hash_123261c89a0bc7a");
		localclientnum = waitresult.localclientnum;
		localplayer = function_5c10bd79(localclientnum);
		clientobjid = level.var_a5ec5f1a[localclientnum][waitresult.clientnum];
		if(isdefined(clientobjid))
		{
			objective_delete(localclientnum, clientobjid);
			util::releaseobjid(localclientnum, clientobjid);
			level.var_a5ec5f1a[localclientnum][waitresult.clientnum] = undefined;
		}
	}
}

/*
	Name: function_41f9de03
	Namespace: warzone
	Checksum: 0x952D3FAC
	Offset: 0x1390
	Size: 0x2E4
	Parameters: 0
	Flags: Linked
*/
function function_41f9de03()
{
	localclientnum = 0;
	var_65792f8b = map::get_script_bundle();
	var_4e59607a = [];
	if(isdefined(var_65792f8b) && isdefined(var_65792f8b.var_9350cee1))
	{
		foreach(var_2083855b in var_65792f8b.var_9350cee1)
		{
			var_4e59607a[var_2083855b.targetname] = var_2083855b.displayname;
		}
	}
	foreach(struct in level.struct)
	{
		if(isdefined(struct.targetname) && isdefined(var_4e59607a[struct.targetname]))
		{
			function_4b8a09b(localclientnum, var_4e59607a[struct.targetname], struct.origin);
			var_4e59607a[struct.targetname] = undefined;
		}
		if(struct.classname === "script_struct")
		{
			struct.classname = undefined;
		}
	}
	/#
		foreach(destname in var_4e59607a)
		{
			level.var_909020d0 = (isdefined(level.var_909020d0) ? level.var_909020d0 : 0) + 1;
			level.var_a1222bd2 = ((isdefined(level.var_a1222bd2) ? level.var_a1222bd2 : "") + var_2083855b.targetname) + "";
		}
		if(isdefined(level.var_909020d0))
		{
			println((level.var_909020d0 + "") + level.var_a1222bd2);
		}
	#/
}

/*
	Name: on_localclient_connect
	Namespace: warzone
	Checksum: 0x30385FDD
	Offset: 0x1680
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function on_localclient_connect(localclientnum)
{
	if(isdefined(getgametypesetting(#"hash_418adedc5cf0a538")) && getgametypesetting(#"hash_418adedc5cf0a538"))
	{
		player = function_27673a7(localclientnum);
		player thread function_7e3a43c3(localclientnum);
	}
}

/*
	Name: on_player_spawned
	Namespace: warzone
	Checksum: 0x7533C111
	Offset: 0x1718
	Size: 0x114
	Parameters: 1
	Flags: Linked
*/
function on_player_spawned(localclientnum)
{
	if(!self function_da43934d())
	{
		return;
	}
	function_2dba6c5(localclientnum, function_8978c19(localclientnum));
	forcestreamxmodel(#"hash_23c676424ced3f27", 4, 0);
	forcestreamxmodel(#"hash_153258d8addb7554", 4, 0);
	forcestreamxmodel(#"hash_6d6a1262dc74e606", 5, 0);
	forcestreamxmodel(#"hash_299eb2a348408676", 5, 0);
	thread function_a1aaf8c0();
	self thread function_f8c70ad7(localclientnum);
}

/*
	Name: function_c6878ba5
	Namespace: warzone
	Checksum: 0x73370D5E
	Offset: 0x1838
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_c6878ba5()
{
	setdvar(#"hash_254c50d45dcf475", 0);
}

/*
	Name: function_f6b076db
	Namespace: warzone
	Checksum: 0x29709A80
	Offset: 0x1868
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_f6b076db()
{
	setdvar(#"hash_254c50d45dcf475", 300);
	setdvar(#"hash_51508fd2e827ae4", 1500);
}

/*
	Name: function_e9e16e2f
	Namespace: warzone
	Checksum: 0xFC47173B
	Offset: 0x18C8
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function function_e9e16e2f(params)
{
	function_c6878ba5();
}

/*
	Name: function_4f6cafea
	Namespace: warzone
	Checksum: 0x48133783
	Offset: 0x18F0
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function function_4f6cafea(params)
{
	function_f6b076db();
}

/*
	Name: function_f8c70ad7
	Namespace: warzone
	Checksum: 0xE24F15AD
	Offset: 0x1918
	Size: 0x2C0
	Parameters: 1
	Flags: Linked
*/
function function_f8c70ad7(localclientnum)
{
	self endon_callback(&function_e8d2d8c5, #"death");
	self endon(#"disconnect");
	/#
		assert(!isdefined(self.var_408847b6));
	#/
	if(isdefined(self.var_408847b6))
	{
		self function_e8d2d8c5();
	}
	self.var_408847b6 = spawn(0, (0, 0, 0), "script_origin");
	if(!isdefined(self.var_408847b6))
	{
		return;
	}
	var_408847b6 = self.var_408847b6;
	var_408847b6.var_41266084 = var_408847b6 playloopsound("amb_height_looper_mountain_fnt");
	var_408847b6.var_2f3960f5 = var_408847b6 playloopsound("amb_height_looper_mountain_bck");
	setsoundvolumerate(var_408847b6.var_41266084, 1);
	setsoundvolumerate(var_408847b6.var_2f3960f5, 1);
	var_d15c9ee7 = 0;
	while(true)
	{
		var_ebe45f6a = self.origin[2];
		if(abs(var_ebe45f6a - var_d15c9ee7) > 50)
		{
			var_d15c9ee7 = var_ebe45f6a;
			if(var_ebe45f6a <= 3000)
			{
				setsoundvolume(var_408847b6.var_41266084, 0);
				setsoundvolume(var_408847b6.var_2f3960f5, 0);
			}
			else if(var_ebe45f6a <= 7500)
			{
				var_f9d98743 = (var_ebe45f6a - 3000) / 4500;
				setsoundvolume(var_408847b6.var_41266084, var_f9d98743);
				setsoundvolume(var_408847b6.var_2f3960f5, var_f9d98743);
			}
			else
			{
				setsoundvolume(var_408847b6.var_41266084, 1);
				setsoundvolume(var_408847b6.var_2f3960f5, 1);
			}
		}
		wait(0.25);
	}
}

/*
	Name: function_e8d2d8c5
	Namespace: warzone
	Checksum: 0xDD0DE4FB
	Offset: 0x1BE0
	Size: 0x46
	Parameters: 1
	Flags: Linked
*/
function function_e8d2d8c5(notifyhash)
{
	if(isdefined(self) && isdefined(self.var_408847b6))
	{
		self.var_408847b6 delete();
		self.var_408847b6 = undefined;
	}
}

/*
	Name: function_2dba6c5
	Namespace: warzone
	Checksum: 0xC9311B11
	Offset: 0x1C30
	Size: 0x164
	Parameters: 2
	Flags: Linked
*/
function function_2dba6c5(localclientnum, var_be9954a5)
{
	if(!isdefined(level.controllercolor))
	{
		level.controllercolor = [];
	}
	switch(var_be9954a5)
	{
		case 0:
		{
			level.controllercolor[localclientnum] = (1, 0.5, 0);
			break;
		}
		case 1:
		{
			level.controllercolor[localclientnum] = (0, 0, 1);
			break;
		}
		case 2:
		{
			level.controllercolor[localclientnum] = (0, 1, 0);
			break;
		}
		case 3:
		{
			level.controllercolor[localclientnum] = (1, 0, 1);
			break;
		}
		default:
		{
			break;
		}
	}
	if(isdefined(level.controllercolor[localclientnum]))
	{
		setcontrollerlightbarcolor(localclientnum, level.controllercolor[localclientnum]);
	}
	else
	{
		setcontrollerlightbarcolor(localclientnum);
	}
}

/*
	Name: function_a1aaf8c0
	Namespace: warzone
	Checksum: 0x9844698E
	Offset: 0x1DA0
	Size: 0x78
	Parameters: 0
	Flags: Linked
*/
function function_a1aaf8c0()
{
	self notify("15d660e19319a47");
	self endon("15d660e19319a47");
	while(isdefined(self))
	{
		waitresult = undefined;
		waitresult = level waittill(#"hash_5af34d08eac79f88");
		function_2dba6c5(waitresult.localclientnum, waitresult.var_edf90e4e);
	}
}

/*
	Name: function_2985ca96
	Namespace: warzone
	Checksum: 0x869B373D
	Offset: 0x1E20
	Size: 0x4E
	Parameters: 7
	Flags: Linked
*/
function function_2985ca96(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
	}
}

/*
	Name: function_a1b40aa4
	Namespace: warzone
	Checksum: 0x8EB86708
	Offset: 0x1E78
	Size: 0xFC
	Parameters: 7
	Flags: Linked
*/
function function_a1b40aa4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	player = function_27673a7(localclientnum);
	if(player != self)
	{
		return;
	}
	if(bwastimejump)
	{
		return;
	}
	if(!isplayer(player) || !isalive(player))
	{
		function_3f258626(localclientnum);
		return;
	}
	if(newval == 1)
	{
		function_9e9a0604(localclientnum);
	}
	else
	{
		function_3f258626(localclientnum);
	}
}

/*
	Name: function_3dadedf8
	Namespace: warzone
	Checksum: 0x9C832CF8
	Offset: 0x1F80
	Size: 0x304
	Parameters: 1
	Flags: Linked, Private
*/
private function function_3dadedf8(localclientnum)
{
	while(true)
	{
		origin = getlocalclientpos(localclientnum);
		players = getplayers(localclientnum);
		players = arraysortclosest(players, origin, undefined, 0, 6000);
		bleeding = 0;
		foreach(player in players)
		{
			if(!player hasdobj(localclientnum))
			{
				continue;
			}
			if(!(isdefined(player.var_374045a0) && player.var_374045a0))
			{
				if(player ishidden() || player isinfreefall() || player function_9a0edd92())
				{
					continue;
				}
			}
			player.var_374045a0 = 1;
			if(player getlocalclientnumber() === localclientnum)
			{
				setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.bleedingOverTime"), 1);
			}
			if(bleeding >= 10 || !isalive(player))
			{
				if(isarray(player.var_88b0c4c3))
				{
					foreach(handle in player.var_88b0c4c3)
					{
						stopfx(localclientnum, handle);
					}
					player.var_88b0c4c3 = undefined;
				}
				continue;
			}
			bleeding++;
			if(!isdefined(player.var_88b0c4c3))
			{
				player.var_88b0c4c3 = playtagfxset(localclientnum, "status_effect_bloody_tracker", player);
			}
		}
		players = undefined;
		wait(0.2);
	}
}

/*
	Name: function_7e3a43c3
	Namespace: warzone
	Checksum: 0x80FDEFA4
	Offset: 0x2290
	Size: 0xAE
	Parameters: 1
	Flags: Linked, Private
*/
private function function_7e3a43c3(localclientnum)
{
	self notify("2dfbcba8182d1332");
	self endon("2dfbcba8182d1332");
	while(true)
	{
		var_d017e788 = function_5c10bd79(localclientnum);
		if(!isdefined(var_d017e788))
		{
			waitframe(1);
			continue;
		}
		if(!var_d017e788 postfx::function_556665f2(#"hash_13defe66b6177d0b"))
		{
			var_d017e788 postfx::playpostfxbundle(#"hash_13defe66b6177d0b");
		}
		waitframe(1);
	}
}

/*
	Name: function_b522ef5c
	Namespace: warzone
	Checksum: 0xAA30A1A
	Offset: 0x2348
	Size: 0x46
	Parameters: 0
	Flags: Linked, Private
*/
private function function_b522ef5c()
{
	var_d106ba82 = struct::get("map_dest_hijacked");
	if(isdefined(var_d106ba82))
	{
		var_d106ba82.origin = (22966, 46926, 1270);
	}
}

