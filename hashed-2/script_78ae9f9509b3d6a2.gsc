// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_68264f587357ea51;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_e79e59a0;

/*
	Name: function_89f2df9
	Namespace: namespace_e79e59a0
	Checksum: 0x84D8F8B3
	Offset: 0x128
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_3434169163ecaa3e", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_e79e59a0
	Checksum: 0x6A4CCE7E
	Offset: 0x170
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("clientuimodel", "hudItems.depositing", 13000, 1, "int", undefined, 0, 0);
	if(getdvarint(#"hash_7074ed0f04816b75", 0))
	{
		clientfield::register("allplayers", "wz_cash_carrying", 13000, 1, "int", &function_3d113bfb, 0, 1);
		level.var_f042433 = [];
		level.var_e245bbc5 = [];
		level.var_7cce82bd = [];
		callback::on_localclient_connect(&on_localclient_connect);
	}
}

/*
	Name: on_localclient_connect
	Namespace: namespace_e79e59a0
	Checksum: 0xD8A66049
	Offset: 0x268
	Size: 0x184
	Parameters: 1
	Flags: Linked, Private
*/
function private on_localclient_connect(localclientnum)
{
	if(getdvarint(#"hash_7074ed0f04816b75", 0))
	{
		level.var_f042433[localclientnum] = [];
		for(i = 0; i < 1; i++)
		{
			objid = util::getnextobjid(localclientnum);
			level.var_f042433[localclientnum][i] = objid;
			objective_add(localclientnum, objid, "invisible", #"hash_3434169163ecaa3e");
		}
		level.var_7cce82bd[localclientnum] = [];
		for(i = 0; i < 12; i++)
		{
			objid = util::getnextobjid(localclientnum);
			level.var_7cce82bd[localclientnum][i] = objid;
			objective_add(localclientnum, objid, "invisible", #"hash_4f26a673bf3f456c");
		}
		level thread function_93b89303(localclientnum);
	}
}

/*
	Name: function_ed66923
	Namespace: namespace_e79e59a0
	Checksum: 0xAA844004
	Offset: 0x3F8
	Size: 0x46
	Parameters: 1
	Flags: None
*/
function function_ed66923(targetname)
{
	if(!isarray(level.var_e245bbc5))
	{
		return;
	}
	level.var_e245bbc5[level.var_e245bbc5.size] = targetname;
}

/*
	Name: function_93b89303
	Namespace: namespace_e79e59a0
	Checksum: 0x97596F38
	Offset: 0x448
	Size: 0x920
	Parameters: 1
	Flags: Linked, Private
*/
function private function_93b89303(localclientnum)
{
	player = function_27673a7(localclientnum);
	player endon(#"disconnect");
	while(true)
	{
		if(!isdefined(player))
		{
			player = function_27673a7(localclientnum);
		}
		for(i = 0; i < 1; i++)
		{
			if(isdefined(level.var_f042433[localclientnum][i]))
			{
				objective_setstate(localclientnum, level.var_f042433[localclientnum][i], "invisible");
			}
		}
		var_5482d370 = 0;
		var_59a2b21b = [];
		if(isdefined(player) && isalive(player))
		{
			var_8040e225 = item_world::function_a7e98a1a(localclientnum);
			foreach(item in var_8040e225.inventory.items)
			{
				if(item.id != 32767)
				{
					point = function_b1702735(item.id);
					if(isdefined(point) && isdefined(point.var_a6762160) && point.var_a6762160.itemtype == #"cash")
					{
						var_5482d370 = 1;
						break;
					}
				}
			}
		}
		if(var_5482d370)
		{
			dynents = [];
			foreach(targetname in level.var_e245bbc5)
			{
				var_1ec402d4 = getdynentarray(targetname);
				foreach(safe in var_1ec402d4)
				{
					if(function_ffdbe8c2(safe) == 0)
					{
						dynents[dynents.size] = safe;
					}
				}
			}
			if(dynents.size > 0)
			{
				dynents = arraysortclosest(dynents, player.origin, 10, 0, 5000);
				if(dynents.size > 0)
				{
					for(i = 0; i < 1; i++)
					{
						var_59a2b21b[i] = dynents[i];
					}
				}
			}
		}
		if(var_59a2b21b.size)
		{
			for(i = 0; i < 1; i++)
			{
				if(isdefined(level.var_f042433[localclientnum][i]))
				{
					if(isdefined(var_59a2b21b[i]))
					{
						objective_setposition(localclientnum, level.var_f042433[localclientnum][i], var_59a2b21b[i].origin);
						objective_setstate(localclientnum, level.var_f042433[localclientnum][i], "active");
						continue;
					}
					objective_setstate(localclientnum, level.var_f042433[localclientnum][i], "invisible");
				}
			}
		}
		else
		{
			for(i = 0; i < 1; i++)
			{
				if(isdefined(level.var_f042433[localclientnum][i]))
				{
					objective_setstate(localclientnum, level.var_f042433[localclientnum][i], "invisible");
				}
			}
		}
		vehicle = getplayervehicle(player);
		if(isdefined(vehicle) && isdefined(vehicle.scriptbundlesettings))
		{
			var_165435de = struct::get_script_bundle("vehiclecustomsettings", vehicle.scriptbundlesettings);
			if(isdefined(var_165435de) && (isdefined(var_165435de.var_6754976b) && var_165435de.var_6754976b))
			{
				var_ea44983e = [];
				var_81279b22 = [];
				all_players = getplayers(localclientnum);
				foreach(enemy_player in all_players)
				{
					if(enemy_player.team === player.team)
					{
						continue;
					}
					if(!(isdefined(enemy_player.var_ba474290) && enemy_player.var_ba474290))
					{
						continue;
					}
					if(distancesquared(enemy_player.origin, player.origin) < 25000000)
					{
						if(isdefined(enemy_player.var_7c34933) && (enemy_player.var_7c34933 + 1500) > gettime())
						{
							var_81279b22[enemy_player.var_cbe9b5b4] = enemy_player.var_cbe9b5b4;
							continue;
						}
						if(!isdefined(var_ea44983e))
						{
							var_ea44983e = [];
						}
						else if(!isarray(var_ea44983e))
						{
							var_ea44983e = array(var_ea44983e);
						}
						if(!isinarray(var_ea44983e, enemy_player))
						{
							var_ea44983e[var_ea44983e.size] = enemy_player;
						}
					}
				}
				for(i = 0; i < 12; i++)
				{
					if(var_81279b22[i] === i)
					{
						continue;
					}
					if(isdefined(level.var_7cce82bd[localclientnum][i]))
					{
						if(!isdefined(var_ea44983e[i]))
						{
							objective_setstate(localclientnum, level.var_7cce82bd[localclientnum][i], "invisible");
							continue;
						}
						objective_setposition(localclientnum, level.var_7cce82bd[localclientnum][i], var_ea44983e[i].origin);
						objective_setstate(localclientnum, level.var_7cce82bd[localclientnum][i], "active");
						var_ea44983e[i].var_7c34933 = gettime();
						var_ea44983e[i].var_cbe9b5b4 = i;
					}
				}
			}
		}
		else
		{
			for(i = 0; i < 12; i++)
			{
				if(isdefined(level.var_7cce82bd[localclientnum][i]))
				{
					objective_setstate(localclientnum, level.var_7cce82bd[localclientnum][i], "invisible");
				}
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_4fec33b5
	Namespace: namespace_e79e59a0
	Checksum: 0x9EC4C777
	Offset: 0xD70
	Size: 0x7C
	Parameters: 2
	Flags: Linked
*/
function function_4fec33b5(clientnum, value)
{
	var_ff5f6756 = ("Clients." + clientnum) + ".hasCash";
	var_45d5c75f = createuimodel(getglobaluimodel(), var_ff5f6756);
	setuimodelvalue(var_45d5c75f, value);
}

/*
	Name: function_3d113bfb
	Namespace: namespace_e79e59a0
	Checksum: 0xC72683D1
	Offset: 0xDF8
	Size: 0xB4
	Parameters: 7
	Flags: Linked
*/
function function_3d113bfb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self.var_ba474290 = newval;
	localplayer = function_5c10bd79(localclientnum);
	if(self != localplayer && self.team == localplayer.team)
	{
		function_4fec33b5(self getentitynumber(), newval);
	}
}

