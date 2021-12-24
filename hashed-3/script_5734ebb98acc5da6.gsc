// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\exploder_shared.csc;
#using scripts\core_common\flagsys_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_68b18f4c;

/*
	Name: function_89f2df9
	Namespace: namespace_68b18f4c
	Checksum: 0x4C91D46A
	Offset: 0x288
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_5bdb62b16cf7d51e", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_68b18f4c
	Checksum: 0xF8936CC9
	Offset: 0x2D0
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_f64d56a1 = (isdefined(getgametypesetting(#"hash_11b79ec2ffb886c8")) ? getgametypesetting(#"hash_11b79ec2ffb886c8") : 0) || (isdefined(getgametypesetting(#"hash_697d65a68cc6c6f1")) ? getgametypesetting(#"hash_697d65a68cc6c6f1") : 0);
	if(isdefined(level.var_f64d56a1) && level.var_f64d56a1)
	{
		callback::on_localclient_connect(&on_local_client_connect);
		callback::on_localplayer_spawned(&function_8be09fdd);
	}
}

/*
	Name: function_fb0bd6b9
	Namespace: namespace_68b18f4c
	Checksum: 0xF2AC8946
	Offset: 0x3E8
	Size: 0x206
	Parameters: 1
	Flags: Linked
*/
function function_fb0bd6b9(localclientnum)
{
	var_a45a64b6 = getdynent("nixie_tube_cage");
	if(!isdefined(var_a45a64b6))
	{
		/#
			println("");
		#/
		return;
	}
	var_a45a64b6.canuse = 0;
	var_679f0ee5 = struct::get_array("nixie_tubes", "script_noteworthy");
	foreach(s_tube in var_679f0ee5)
	{
		var_790990d7 = util::spawn_model(localclientnum, #"hash_2a475dc4752c8b17", s_tube.origin, s_tube.angles);
		var_8f21b4af = util::spawn_model(localclientnum, #"hash_53d213db448a97e1", s_tube.origin, s_tube.angles);
		var_8f21b4af hide();
		var_790990d7.script_string = "mdl_nixie_tubes";
		var_8f21b4af.script_string = "mdl_nixie_tubes_on";
		var_8f21b4af.targetname = s_tube.targetname + "_on";
		var_790990d7.targetname = s_tube.targetname + "_off";
		s_tube.var_790990d7 = var_790990d7;
		s_tube.var_8f21b4af = var_8f21b4af;
	}
}

/*
	Name: on_local_client_connect
	Namespace: namespace_68b18f4c
	Checksum: 0x13DA3CAC
	Offset: 0x5F8
	Size: 0x154
	Parameters: 1
	Flags: Linked
*/
function on_local_client_connect(localclientnum)
{
	level endon(#"game_ended");
	var_1ef32d1f = getdynent("nixie_tube_cage");
	if(!(isdefined(level.var_f64d56a1) && level.var_f64d56a1))
	{
		if(isdefined(var_1ef32d1f))
		{
			setdynentenabled(var_1ef32d1f, 0);
		}
		return;
	}
	level function_fb0bd6b9(localclientnum);
	if(isdefined(var_1ef32d1f))
	{
		var_a2b73cfc = spawn(localclientnum, var_1ef32d1f.origin, "script_origin");
		var_a2b73cfc.targetname = "nixie_sound_manager";
		var_a2b73cfc.loop_sound = var_a2b73cfc playloopsound(#"hash_589f33024097b46");
	}
	else
	{
		return;
	}
	level flagsys::wait_till(#"hash_38a387462f3a9ad");
	level thread function_f98a4376(localclientnum);
}

/*
	Name: function_8be09fdd
	Namespace: namespace_68b18f4c
	Checksum: 0x2743400C
	Offset: 0x758
	Size: 0x8E
	Parameters: 1
	Flags: Linked
*/
function function_8be09fdd(localclientnum)
{
	local_player = function_5c10bd79(localclientnum);
	if(!isdefined(local_player.var_75910156))
	{
		local_player.var_75910156 = 0;
	}
	if(!isdefined(local_player.var_ea3eeab0))
	{
		local_player.var_ea3eeab0 = 0;
	}
	if(!isdefined(local_player.var_dc054e3d))
	{
		local_player.var_dc054e3d = 0;
	}
}

/*
	Name: function_97f8efcd
	Namespace: namespace_68b18f4c
	Checksum: 0x2A7CCE0C
	Offset: 0x7F0
	Size: 0x1F4
	Parameters: 1
	Flags: Linked
*/
function function_97f8efcd(localclientnum)
{
	var_1ef32d1f = getdynent("nixie_tube_cage");
	if(isdefined(var_1ef32d1f))
	{
		var_1ef32d1f.canuse = 1;
	}
	var_243a1bdb = getent(localclientnum, "nixie_tube_1_on", "targetname");
	var_4974664f = getent(localclientnum, "nixie_tube_2_on", "targetname");
	var_37adc2c2 = getent(localclientnum, "nixie_tube_3_on", "targetname");
	var_529f2403 = getent(localclientnum, "nixie_tube_1_off", "targetname");
	var_66984bf5 = getent(localclientnum, "nixie_tube_2_off", "targetname");
	var_3f227d0a = getent(localclientnum, "nixie_tube_3_off", "targetname");
	var_243a1bdb show();
	var_4974664f show();
	var_37adc2c2 show();
	var_529f2403 hide();
	var_66984bf5 hide();
	var_3f227d0a hide();
}

/*
	Name: function_f451b137
	Namespace: namespace_68b18f4c
	Checksum: 0x9B790333
	Offset: 0x9F0
	Size: 0x4A
	Parameters: 0
	Flags: Linked
*/
function function_f451b137()
{
	if(isdefined(self) && isplayer(self))
	{
		self.var_75910156 = 0;
		self.var_ea3eeab0 = 0;
		self.var_dc054e3d = 0;
	}
}

/*
	Name: function_d169c443
	Namespace: namespace_68b18f4c
	Checksum: 0x618A3482
	Offset: 0xA48
	Size: 0xC6
	Parameters: 1
	Flags: Linked
*/
function function_d169c443(localclientnum)
{
	ents = getentarray(localclientnum, self.targetname, "targetname");
	foreach(tube in ents)
	{
		if(tube hasdobj(localclientnum))
		{
			return tube;
		}
	}
	return undefined;
}

/*
	Name: function_f98a4376
	Namespace: namespace_68b18f4c
	Checksum: 0x92803529
	Offset: 0xB18
	Size: 0xFAA
	Parameters: 1
	Flags: Linked
*/
function function_f98a4376(localclientnum)
{
	level thread function_97f8efcd(localclientnum);
	waitframe(1);
	var_4f5b63ea = struct::get("nixie_tube_1");
	var_83aecc80 = struct::get("nixie_tube_2");
	var_31a8a875 = struct::get("nixie_tube_3");
	while(true)
	{
		local_player = function_5c10bd79(localclientnum);
		if(isdefined(local_player))
		{
			var_cd92754b = var_4f5b63ea.var_8f21b4af;
			var_59578baf = var_83aecc80.var_8f21b4af;
			var_ca95ee2a = var_31a8a875.var_8f21b4af;
			var_e28cb83c = var_4f5b63ea.var_790990d7;
			var_5a5a2785 = var_83aecc80.var_790990d7;
			var_479e820e = var_31a8a875.var_790990d7;
			if(function_65b9eb0f(localclientnum))
			{
				var_da258db4 = var_cd92754b.localclientnum;
				var_cd92754b = var_cd92754b function_d169c443(var_da258db4);
				if(!isdefined(var_cd92754b))
				{
					return;
				}
				var_da258db4 = var_59578baf.localclientnum;
				var_59578baf = var_59578baf function_d169c443(var_da258db4);
				if(!isdefined(var_59578baf))
				{
					return;
				}
				var_da258db4 = var_ca95ee2a.localclientnum;
				var_ca95ee2a = var_ca95ee2a function_d169c443(var_da258db4);
				if(!isdefined(var_ca95ee2a))
				{
					return;
				}
				var_da258db4 = var_e28cb83c.localclientnum;
				var_e28cb83c = var_e28cb83c function_d169c443(var_da258db4);
				if(!isdefined(var_e28cb83c))
				{
					return;
				}
				var_da258db4 = var_5a5a2785.localclientnum;
				var_5a5a2785 = var_5a5a2785 function_d169c443(var_da258db4);
				if(!isdefined(var_5a5a2785))
				{
					return;
				}
				var_da258db4 = var_479e820e.localclientnum;
				var_479e820e = var_479e820e function_d169c443(var_da258db4);
				if(!isdefined(var_479e820e))
				{
					return;
				}
			}
			if(isdefined(local_player.var_75910156))
			{
				if(local_player.var_75910156 >= 0)
				{
					if(isdefined(var_cd92754b hasdobj(localclientnum)) && var_cd92754b hasdobj(localclientnum) && (isdefined(var_cd92754b haspart(localclientnum, "tag_nixie_off")) && var_cd92754b haspart(localclientnum, "tag_nixie_off")))
					{
						var_cd92754b hidepart(localclientnum, "tag_nixie_off");
					}
					if(isdefined(var_59578baf hasdobj(localclientnum)) && var_59578baf hasdobj(localclientnum) && (isdefined(var_59578baf haspart(localclientnum, "tag_nixie_off")) && var_59578baf haspart(localclientnum, "tag_nixie_off")))
					{
						var_59578baf hidepart(localclientnum, "tag_nixie_off");
					}
					if(isdefined(var_ca95ee2a hasdobj(localclientnum)) && var_ca95ee2a hasdobj(localclientnum) && (isdefined(var_ca95ee2a haspart(localclientnum, "tag_nixie_off")) && var_ca95ee2a haspart(localclientnum, "tag_nixie_off")))
					{
						var_ca95ee2a hidepart(localclientnum, "tag_nixie_off");
					}
					for(i = 0; i < 10; i++)
					{
						if(local_player.var_75910156 != i)
						{
							if(isdefined(var_cd92754b hasdobj(localclientnum)) && var_cd92754b hasdobj(localclientnum) && (isdefined(var_cd92754b haspart(localclientnum, "tag_nixie_" + i)) && var_cd92754b haspart(localclientnum, "tag_nixie_" + i)))
							{
								var_cd92754b hidepart(localclientnum, "tag_nixie_" + i);
							}
						}
						if(local_player.var_ea3eeab0 != i)
						{
							if(isdefined(var_59578baf hasdobj(localclientnum)) && var_59578baf hasdobj(localclientnum) && (isdefined(var_59578baf haspart(localclientnum, "tag_nixie_" + i)) && var_59578baf haspart(localclientnum, "tag_nixie_" + i)))
							{
								var_59578baf hidepart(localclientnum, "tag_nixie_" + i);
							}
						}
						if(local_player.var_dc054e3d != i)
						{
							if(isdefined(var_ca95ee2a hasdobj(localclientnum)) && var_ca95ee2a hasdobj(localclientnum) && (isdefined(var_ca95ee2a haspart(localclientnum, "tag_nixie_" + i)) && var_ca95ee2a haspart(localclientnum, "tag_nixie_" + i)))
							{
								var_ca95ee2a hidepart(localclientnum, "tag_nixie_" + i);
							}
						}
					}
					if(isdefined(var_cd92754b hasdobj(localclientnum)) && var_cd92754b hasdobj(localclientnum) && (isdefined(var_cd92754b haspart(localclientnum, "tag_nixie_" + local_player.var_75910156)) && var_cd92754b haspart(localclientnum, "tag_nixie_" + local_player.var_75910156)))
					{
						var_cd92754b showpart(localclientnum, "tag_nixie_" + local_player.var_75910156);
					}
					if(isdefined(var_59578baf hasdobj(localclientnum)) && var_59578baf hasdobj(localclientnum) && (isdefined(var_59578baf haspart(localclientnum, "tag_nixie_" + local_player.var_ea3eeab0)) && var_59578baf haspart(localclientnum, "tag_nixie_" + local_player.var_ea3eeab0)))
					{
						var_59578baf showpart(localclientnum, "tag_nixie_" + local_player.var_ea3eeab0);
					}
					if(isdefined(var_ca95ee2a hasdobj(localclientnum)) && var_ca95ee2a hasdobj(localclientnum) && (isdefined(var_ca95ee2a haspart(localclientnum, "tag_nixie_" + local_player.var_dc054e3d)) && var_ca95ee2a haspart(localclientnum, "tag_nixie_" + local_player.var_dc054e3d)))
					{
						var_ca95ee2a showpart(localclientnum, "tag_nixie_" + local_player.var_dc054e3d);
					}
				}
				else
				{
					for(i = 0; i < 10; i++)
					{
						if(isdefined(var_cd92754b hasdobj(localclientnum)) && var_cd92754b hasdobj(localclientnum) && (isdefined(var_cd92754b haspart(localclientnum, "tag_nixie_" + i)) && var_cd92754b haspart(localclientnum, "tag_nixie_" + i)))
						{
							var_cd92754b hidepart(localclientnum, "tag_nixie_" + i);
						}
						if(isdefined(var_59578baf hasdobj(localclientnum)) && var_59578baf hasdobj(localclientnum) && (isdefined(var_59578baf haspart(localclientnum, "tag_nixie_" + i)) && var_59578baf haspart(localclientnum, "tag_nixie_" + i)))
						{
							var_59578baf hidepart(localclientnum, "tag_nixie_" + i);
						}
						if(isdefined(var_ca95ee2a hasdobj(localclientnum)) && var_ca95ee2a hasdobj(localclientnum) && (isdefined(var_ca95ee2a haspart(localclientnum, "tag_nixie_" + i)) && var_ca95ee2a haspart(localclientnum, "tag_nixie_" + i)))
						{
							var_ca95ee2a hidepart(localclientnum, "tag_nixie_" + i);
						}
					}
					if(isdefined(var_cd92754b hasdobj(localclientnum)) && var_cd92754b hasdobj(localclientnum) && (isdefined(var_cd92754b haspart(localclientnum, "tag_nixie_" + local_player.var_75910156)) && var_cd92754b haspart(localclientnum, "tag_nixie_" + local_player.var_75910156)))
					{
						var_cd92754b showpart(localclientnum, "tag_nixie_off");
					}
					if(isdefined(var_59578baf hasdobj(localclientnum)) && var_59578baf hasdobj(localclientnum) && (isdefined(var_59578baf haspart(localclientnum, "tag_nixie_" + local_player.var_75910156)) && var_59578baf haspart(localclientnum, "tag_nixie_" + local_player.var_75910156)))
					{
						var_59578baf showpart(localclientnum, "tag_nixie_off");
					}
					if(isdefined(var_ca95ee2a hasdobj(localclientnum)) && var_ca95ee2a hasdobj(localclientnum) && (isdefined(var_ca95ee2a haspart(localclientnum, "tag_nixie_" + local_player.var_75910156)) && var_ca95ee2a haspart(localclientnum, "tag_nixie_" + local_player.var_75910156)))
					{
						var_ca95ee2a showpart(localclientnum, "tag_nixie_off");
					}
					var_e28cb83c show();
					var_5a5a2785 show();
					var_479e820e show();
					var_cd92754b hide();
					var_59578baf hide();
					var_ca95ee2a hide();
					break;
				}
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_3981d015
	Namespace: namespace_68b18f4c
	Checksum: 0x1498D489
	Offset: 0x1AD0
	Size: 0x3F8
	Parameters: 1
	Flags: Event
*/
event function_3981d015(eventstruct)
{
	if(!(isdefined(level.var_f64d56a1) && level.var_f64d56a1))
	{
		if(eventstruct.ent.targetname === "nixie_tube_cage")
		{
			setdynentenabled(eventstruct.ent, 0);
		}
		return;
	}
	if(eventstruct.ent.targetname === "nixie_tube_cage" && isdefined(eventstruct.localclientnum))
	{
		if(!(isdefined(eventstruct.ent.canuse) && eventstruct.ent.canuse))
		{
			return;
		}
		players = getlocalplayers();
		if(players.size > 0)
		{
			closest_player = arraygetclosest(eventstruct.ent.origin, players, 128);
			if(isdefined(closest_player))
			{
				var_7a452f77 = struct::get_array("nixie_tubes", "script_noteworthy");
				if(var_7a452f77.size > 0)
				{
					var_a776da4f = distance2d(closest_player.origin, var_7a452f77[0].var_8f21b4af.origin);
					var_4da8e55e = var_7a452f77[0];
					foreach(s_tube in var_7a452f77)
					{
						var_c3cbab72 = distance2d(closest_player.origin, s_tube.var_8f21b4af.origin);
						if(var_c3cbab72 < var_a776da4f)
						{
							var_4da8e55e = s_tube;
							var_a776da4f = distance2d(closest_player.origin, s_tube.var_8f21b4af.origin);
						}
					}
					foreach(player in players)
					{
						if(isdefined(var_4da8e55e.targetname))
						{
							switch(var_4da8e55e.targetname)
							{
								case "nixie_tube_1":
								{
									player.var_75910156 = (player.var_75910156 + 1) % 10;
									break;
								}
								case "nixie_tube_2":
								{
									player.var_ea3eeab0 = (player.var_ea3eeab0 + 1) % 10;
									break;
								}
								case "nixie_tube_3":
								{
									player.var_dc054e3d = (player.var_dc054e3d + 1) % 10;
									break;
								}
							}
						}
						player thread function_bbca669b(player, eventstruct.ent);
					}
				}
			}
		}
	}
}

/*
	Name: function_bbca669b
	Namespace: namespace_68b18f4c
	Checksum: 0x36EDFA70
	Offset: 0x1ED0
	Size: 0xA4
	Parameters: 2
	Flags: Linked
*/
function function_bbca669b(var_64c09f7f, dynent)
{
	if(isdefined(var_64c09f7f) && isdefined(dynent))
	{
		var_64c09f7f notify(#"hash_2f586f8df1e6596d");
		var_64c09f7f endon(#"hash_2f586f8df1e6596d", #"hash_59db65b924f851e4", #"hash_f787bd652d7a4b", #"disconnect");
		wait(5);
		var_64c09f7f thread function_c1cc29be(var_64c09f7f, dynent);
	}
}

/*
	Name: function_c1cc29be
	Namespace: namespace_68b18f4c
	Checksum: 0xB389D8ED
	Offset: 0x1F80
	Size: 0x352
	Parameters: 2
	Flags: Linked
*/
function function_c1cc29be(var_64c09f7f, dynent)
{
	if(isdefined(var_64c09f7f) && isdefined(dynent))
	{
		var_64c09f7f endon(#"hash_59db65b924f851e4", #"disconnect");
		var_64c09f7f notify(#"hash_f787bd652d7a4b");
		localclientnum = var_64c09f7f.localclientnum;
		var_8171dd3a = var_64c09f7f.var_75910156;
		var_8dfff656 = var_64c09f7f.var_ea3eeab0;
		var_44e1e41b = var_64c09f7f.var_dc054e3d;
		var_954ac27a = 0;
		if(var_8171dd3a == 1 && var_8dfff656 == 1 && var_44e1e41b == 5)
		{
			var_954ac27a = 1;
		}
		if(var_8171dd3a == 8 && var_8dfff656 == 7 && var_44e1e41b == 2)
		{
			var_954ac27a = 1;
		}
		if(var_8171dd3a == 4 && var_8dfff656 == 2 && var_44e1e41b == 0)
		{
			var_954ac27a = 1;
		}
		if(var_954ac27a)
		{
			dynent.canuse = 0;
			wait(1.5 + 0.25);
			var_62002857 = 0;
			var_64c09f7f thread function_f451b137();
			wait(2);
			var_64c09f7f function_172e72fa();
			if(var_954ac27a)
			{
				var_d46a1171 = (("" + var_8171dd3a) + var_8dfff656) + var_44e1e41b;
				var_64c09f7f thread function_a5d20d9b(var_d46a1171);
				if(var_d46a1171 == "115")
				{
					var_62002857 = 6;
				}
			}
		}
		else
		{
			var_32823664 = getentarray(localclientnum, "mdl_nixie_tubes", "script_string");
			foreach(var_790990d7 in var_32823664)
			{
				var_790990d7 thread function_b4231440(localclientnum);
			}
			playsound(localclientnum, #"hash_6c0f63cd38c393e7", dynent.origin);
			dynent.canuse = 0;
			var_64c09f7f thread function_f451b137();
			dynent.canuse = 1;
		}
	}
}

/*
	Name: function_a5d20d9b
	Namespace: namespace_68b18f4c
	Checksum: 0x45BD9A34
	Offset: 0x22E0
	Size: 0xD2
	Parameters: 1
	Flags: Linked
*/
function function_a5d20d9b(var_d46a1171)
{
	self notify(#"hash_1ba800da972b0558", {#hash_d46a1171:var_d46a1171});
	switch(var_d46a1171)
	{
		case "hash_456c3818181fa486":
		{
			self thread function_74244cfa();
			break;
		}
		case "hash_148ca2184545ba86":
		{
			self thread function_72aed7cb();
			break;
		}
		case "hash_2bd23a1809bb3649":
		{
			self thread function_1451e44e();
		}
		default:
		{
			break;
		}
	}
}

/*
	Name: function_74244cfa
	Namespace: namespace_68b18f4c
	Checksum: 0xCDCA2424
	Offset: 0x23C0
	Size: 0x120
	Parameters: 0
	Flags: Linked
*/
function function_74244cfa()
{
	self notify("43e9d9fe0bc4c9a6");
	self endon("43e9d9fe0bc4c9a6");
	players = getlocalplayers();
	foreach(player in players)
	{
		var_32823664 = getentarray(player.localclientnum, "mdl_nixie_tubes", "script_string");
		if(var_32823664.size > 0)
		{
			var_32823664[0] playsound(player.localclientnum, #"hash_5ecaf6acf6be0b1f", var_32823664[0].origin);
		}
	}
}

/*
	Name: function_72aed7cb
	Namespace: namespace_68b18f4c
	Checksum: 0x2FC48611
	Offset: 0x24E8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_72aed7cb()
{
	exploder::exploder("fx_exploder_fireworks_ee");
	level thread function_a746f03f();
}

/*
	Name: function_a746f03f
	Namespace: namespace_68b18f4c
	Checksum: 0x4CB387AF
	Offset: 0x2528
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_a746f03f()
{
	level endon(#"game_ended");
	wait(60);
	exploder::kill_exploder("fx_exploder_fireworks_ee");
}

/*
	Name: function_1451e44e
	Namespace: namespace_68b18f4c
	Checksum: 0x4A64669F
	Offset: 0x2570
	Size: 0x178
	Parameters: 0
	Flags: Linked
*/
function function_1451e44e()
{
	self notify("61ff44b5486a5e5a");
	self endon("61ff44b5486a5e5a");
	players = getlocalplayers();
	foreach(player in players)
	{
		var_32823664 = getentarray(player.localclientnum, "mdl_nixie_tubes", "script_string");
		if(var_32823664.size >= 1)
		{
			if(isdefined(player.var_1ad66d1))
			{
				stopfx(player.localclientnum, player.var_1ad66d1);
			}
			player.var_1ad66d1 = function_239993de(player.localclientnum, "smoke/fx8_column_md_green", var_32823664[1], "tag_origin");
			player thread function_e0df40bf(player.localclientnum);
		}
	}
}

/*
	Name: function_172e72fa
	Namespace: namespace_68b18f4c
	Checksum: 0x855297A0
	Offset: 0x26F0
	Size: 0x76
	Parameters: 0
	Flags: Linked
*/
function function_172e72fa()
{
	if(isplayer(self))
	{
		var_a45a64b6 = getdynent("nixie_tube_cage");
		if(isdefined(var_a45a64b6))
		{
			var_a45a64b6.canuse = 0;
		}
		self.var_75910156 = -1;
		self.var_ea3eeab0 = -1;
		self.var_dc054e3d = -1;
	}
}

/*
	Name: function_b4231440
	Namespace: namespace_68b18f4c
	Checksum: 0xB4AF6BD1
	Offset: 0x2770
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_b4231440(localclientnum)
{
	self.var_3c43a180 = util::playfxontag(localclientnum, #"hash_1a61f16f38e7e93d", self, "tag_animate");
	wait(1);
	stopfx(localclientnum, self.var_3c43a180);
}

/*
	Name: function_e0df40bf
	Namespace: namespace_68b18f4c
	Checksum: 0xBFBADAAE
	Offset: 0x27E0
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_e0df40bf(localclientnum)
{
	self endon(#"death");
	level endon(#"game_ended");
	wait(60);
	if(isdefined(self.var_1ad66d1))
	{
		stopfx(self.localclientnum, self.var_1ad66d1);
	}
}

