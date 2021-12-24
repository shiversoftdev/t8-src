// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_38755604e51a604e;
#using script_47fb62300ac0bd60;
#using script_77dd41c80e39f62;
#using script_8abfb58852911dd;
#using script_c60e21cd69c9db2;
#using script_cb32d07c95e5628;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\infection.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_b912c30b;

/*
	Name: function_89f2df9
	Namespace: namespace_b912c30b
	Checksum: 0xA1D32BAF
	Offset: 0x268
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_6977117f54c58849", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_b912c30b
	Checksum: 0x7FF8235
	Offset: 0x2B0
	Size: 0x3AC
	Parameters: 0
	Flags: Linked, Private
*/
private function __init__()
{
	level.var_91a15ec0 = #"world";
	level.zombie_team = level.var_91a15ec0;
	level.attackables = [];
	level.var_7fc48a1a = [];
	/#
		level.var_80bea5a6 = 0;
		level thread function_b4f41a02();
	#/
	level.var_8a3036cc = 0;
	level.var_57a77bb = 0;
	level.var_d5cd88c2 = 0;
	level.var_2510617f = 0;
	level.var_6eb6193a = 0;
	level.var_7dff87f1 = 0;
	level.var_31286808 = getdvarint(#"bg_gravity", 0);
	if(isdefined(getgametypesetting(#"hash_3109a8794543000f")) && getgametypesetting(#"hash_3109a8794543000f"))
	{
		if(isdefined(getgametypesetting(#"hash_42471cb0cbc19544")) && getgametypesetting(#"hash_42471cb0cbc19544"))
		{
			level.var_9eb9a467 = #"hash_2a471518604bcd8b";
		}
		else
		{
			level.var_9eb9a467 = #"hash_15895bcfe301ee08";
		}
	}
	else if(isdefined(getgametypesetting(#"hash_42471cb0cbc19544")) && getgametypesetting(#"hash_42471cb0cbc19544"))
	{
		level.var_9eb9a467 = #"hash_3a93829b52b54c36";
	}
	else
	{
		level.var_9eb9a467 = #"hash_7da4c1f53ef0f7d7";
	}
	level.var_db43cbd7 = #"hash_3165784c9d75971c";
	level.var_1b7acd6d = #"hash_33bdf9068c8cfb57";
	level.var_72151997 = #"hash_3e1e0d5abe4173f2";
	level.var_14364e26 = #"hash_1d5141b0fcc5b473";
	level.var_7d2bc89 = #"hash_1ee01737fce4ccfe";
	clientfield::register("scriptmover", "aizoneflag", -1, 2, "int");
	clientfield::register("scriptmover", "aizoneflag_tu14", 14000, 3, "int");
	clientfield::register("scriptmover", "magicboxflag", 1, 3, "int");
	clientfield::register("scriptmover", "soultransfer", 14000, 2, "int");
	clientfield::register("actor", "zombie_died", 17000, 1, "int");
}

/*
	Name: function_b4f41a02
	Namespace: namespace_b912c30b
	Checksum: 0x8B2C7D5
	Offset: 0x668
	Size: 0x430
	Parameters: 0
	Flags: None
*/
function function_b4f41a02()
{
	/#
		level endon(#"game_ended");
		aitypes = array(#"spawner_boct_zombie_wz", #"hash_618248fca82d83a6", #"hash_50c4ae7eab84983b", #"hash_7905cf70902495a2", #"hash_2d45c1aaf7808b60", #"hash_70f16a3fe6713fa0", #"hash_78b8c004294d69fe");
		setdvar(#"hash_209287456d55fca1", "");
		foreach(type in aitypes)
		{
			if(function_e949cfd7(type))
			{
				util::function_345e5b9a((("" + function_9e72a96(type)) + "") + function_9e72a96(type) + "");
			}
		}
		util::function_345e5b9a("");
		util::function_345e5b9a("");
		while(true)
		{
			wait(0.1);
			cmd = getdvarstring(#"hash_209287456d55fca1", "");
			if(cmd == "")
			{
				continue;
			}
			cmd_tokens = strtok(cmd, "");
			switch(cmd_tokens[0])
			{
				case "hash_c0b89e8d4a71cff":
				{
					player = level.players[0];
					direction = player getplayerangles();
					direction_vec = anglestoforward(direction);
					eye = player geteye();
					direction_vec = (direction_vec[0] * 8000, direction_vec[1] * 8000, direction_vec[2] * 8000);
					trace = bullettrace(eye, eye + direction_vec, 0, undefined);
					ai = spawnactor(cmd_tokens[1], trace[#"position"], (0, 0, 0), undefined, 1);
					closest_zone = arraygetclosest(trace[#"position"], level.var_5b357434);
					ai thread function_7adc1e46(closest_zone, 0);
					break;
				}
			}
			setdvar(#"hash_209287456d55fca1", "");
		}
	#/
}

/*
	Name: debug_ai
	Namespace: namespace_b912c30b
	Checksum: 0x363B38AC
	Offset: 0xAA0
	Size: 0xEAE
	Parameters: 0
	Flags: None
*/
function debug_ai()
{
	/#
		level endon(#"game_ended");
		level.var_b4702614 = [];
		level.var_b4702614[0] = "";
		level.var_b4702614[1] = "";
		level.var_b4702614[2] = "";
		level.var_b4702614[3] = "";
		level.var_b4702614[4] = "";
		level.var_b4702614[5] = "";
		level.var_b4702614[6] = "";
		while(true)
		{
			if(isdefined(level.var_e066667d) && level.var_e066667d && isdefined(level.var_91a15ec0))
			{
				axis = getaiteamarray(level.var_91a15ec0);
				foreach(entity in axis)
				{
					if(!isalive(entity))
					{
						continue;
					}
					org = entity.origin + vectorscale((0, 0, 1), 100);
					if(isdefined(entity.aistate))
					{
						org = entity.origin + vectorscale((0, 0, 1), 90);
						if(getdvarint(#"recorder_enablerec", 0))
						{
							record3dtext(((isdefined(level.var_b4702614[entity.aistate]) ? level.var_b4702614[entity.aistate] : "") + "") + entity.health, entity.origin, (1, 0.5, 0), "", entity);
						}
						else
						{
							print3d(org, ((isdefined(level.var_b4702614[entity.aistate]) ? level.var_b4702614[entity.aistate] : "") + "") + entity.health, (1, 0.5, 0), 1, 0.2);
						}
					}
					var_2f8d622d = 0;
					if(isdefined(entity.enemy) && entity cansee(entity.enemy))
					{
						var_2f8d622d = 1;
					}
					if(isdefined(entity.var_5a8f690))
					{
						org = entity.origin + vectorscale((0, 0, 1), 85);
						if(getdvarint(#"recorder_enablerec", 0))
						{
							record3dtext(((("" + entity.var_5a8f690) + "") + var_2f8d622d) + "", entity.origin, (1, 0.5, 0), "", entity);
						}
						else
						{
							print3d(org, ((("" + entity.var_5a8f690) + "") + var_2f8d622d) + "", (1, 0.5, 0), 1, 0.2);
						}
					}
					if(isdefined(entity.allowoffnavmesh))
					{
						org = entity.origin + vectorscale((0, 0, 1), 80);
						if(getdvarint(#"recorder_enablerec", 0))
						{
							record3dtext("" + entity.allowoffnavmesh, entity.origin, (1, 0.5, 0), "", entity);
						}
						else
						{
							print3d(org, "" + entity.allowoffnavmesh, (1, 0.5, 0), 1, 0.2);
						}
					}
					if(isdefined(entity.var_6e3313ab))
					{
						org = entity.origin + vectorscale((0, 0, 1), 75);
						if(getdvarint(#"recorder_enablerec", 0))
						{
							record3dtext("" + entity.var_6e3313ab, entity.origin, (1, 0.5, 0), "", entity);
						}
						else
						{
							print3d(org, "" + entity.var_6e3313ab, (1, 0.5, 0), 1, 0.2);
						}
					}
					if(isdefined(entity.var_ad26639d))
					{
						org = entity.origin + vectorscale((0, 0, 1), 70);
						if(getdvarint(#"recorder_enablerec", 0))
						{
							record3dtext("" + entity.var_ad26639d, entity.origin, (1, 0.5, 0), "", entity);
						}
						else
						{
							print3d(org, "" + entity.var_ad26639d, (1, 0.5, 0), 1, 0.2);
						}
					}
					if(isdefined(entity.var_9a79d89d))
					{
						origin = entity.var_9a79d89d;
						if(!isvec(entity.var_9a79d89d))
						{
							origin = entity.var_9a79d89d.origin;
						}
						if(getdvarint(#"recorder_enablerec", 0))
						{
							record3dtext("", entity.origin, (0, 0, 1), "", entity);
						}
						else
						{
							print3d(entity.var_9a79d89d + vectorscale((0, 0, 1), 10), "", (0, 0, 1), 1, 1);
						}
					}
					if(isdefined(entity.var_db912cfe) && isdefined(entity.surfacetype))
					{
						org = entity.origin + vectorscale((0, 0, 1), 70);
						if(getdvarint(#"recorder_enablerec", 0))
						{
							record3dtext((("" + entity.surfacetype) + "") + entity.var_db912cfe, entity.origin, (1, 0.5, 0), "", entity);
						}
						else
						{
							print3d(org, (("" + entity.surfacetype) + "") + entity.var_db912cfe, (1, 0.5, 0), 1, 0.2);
						}
					}
					if(isdefined(entity.var_1e9a96f7))
					{
						org = entity.origin + vectorscale((0, 0, 1), 200);
						if(getdvarint(#"recorder_enablerec", 0))
						{
							record3dtext(((("" + entity.var_1e9a96f7) + "") + entity.var_1e9a96f7) + "", entity.origin, (1, 0.5, 0), "", entity);
						}
						else
						{
							print3d(org, ((("" + entity.var_1e9a96f7) + "") + entity.var_1e9a96f7) + "", (1, 0.5, 0), 1, 2);
						}
					}
					if(isdefined(entity.movetime) && getdvarint(#"hash_1aebd3ffed21a22a", 0))
					{
						org = entity.origin + vectorscale((0, 0, 1), 90);
						if(getdvarint(#"recorder_enablerec", 0))
						{
							record3dtext("" + (gettime() - entity.movetime), entity.origin, (1, 0.5, 0), "", entity);
						}
						else
						{
							print3d(org, "" + (gettime() - entity.movetime), (1, 0.5, 0), 1, 0.2);
						}
					}
					if(isdefined(entity.idletime) && getdvarint(#"hash_1aebd3ffed21a22a", 0))
					{
						org = entity.origin + vectorscale((0, 0, 1), 95);
						if(getdvarint(#"recorder_enablerec", 0))
						{
							record3dtext("" + (gettime() - entity.idletime), entity.origin, (1, 0.5, 0), "", entity);
						}
						else
						{
							print3d(org, "" + (gettime() - entity.idletime), (1, 0.5, 0), 1, 0.2);
						}
					}
					if(isdefined(entity.attackable) && getdvarint(#"hash_6e5b3c35cb223a9d", 0))
					{
						recordline(entity.origin, entity.attackable_slot.origin, (0, 1, 0));
						recordstar(entity.attackable_slot.origin, (0, 0, 1));
						org = entity.origin + vectorscale((0, 0, 1), 100);
						if(getdvarint(#"recorder_enablerec", 0))
						{
							record3dtext("" + distance2dsquared(entity.origin, entity.attackable_slot.origin), entity.origin, (1, 0.5, 0), "", entity);
						}
						else
						{
							print3d(org, "" + distance2dsquared(entity.origin, entity.attackable_slot.origin), (1, 0.5, 0), 1, 0.2);
						}
					}
					if(isdefined(entity.var_6c408220))
					{
						entity [[entity.var_6c408220]]();
					}
				}
			}
			waitframe(1);
		}
	#/
}

/*
	Name: hide_pop
	Namespace: namespace_b912c30b
	Checksum: 0x55D674DC
	Offset: 0x1958
	Size: 0x92
	Parameters: 1
	Flags: Linked
*/
function hide_pop(var_16dd87ad)
{
	self endon(#"death");
	self ghost();
	wait((isdefined(var_16dd87ad) ? var_16dd87ad : 0.5));
	if(isdefined(self))
	{
		self show();
		util::wait_network_frame();
		if(isdefined(self))
		{
			self.create_eyes = 1;
		}
	}
}

/*
	Name: function_55625f76
	Namespace: namespace_b912c30b
	Checksum: 0x64F01FF9
	Offset: 0x19F8
	Size: 0x26C
	Parameters: 4
	Flags: Linked
*/
function function_55625f76(spot_origin, spot_angles, anim_name, var_16dd87ad)
{
	self endon(#"death");
	self clientfield::set("zombie_riser_fx", 1);
	self.in_the_ground = 1;
	if(isdefined(self.anchor))
	{
		self.anchor delete();
	}
	self.anchor = spawn("script_origin", self.origin);
	self.anchor.angles = self.angles;
	self linkto(self.anchor);
	if(!isdefined(spot_angles))
	{
		spot_angles = (0, 0, 0);
	}
	anim_org = spot_origin;
	anim_ang = spot_angles;
	anim_org = anim_org + (0, 0, 0);
	self ghost();
	self.anchor moveto(anim_org, 0.05);
	self.anchor waittill(#"movedone");
	self unlink();
	if(isdefined(self.anchor))
	{
		self.anchor delete();
	}
	self thread hide_pop(var_16dd87ad);
	self orientmode("face default");
	self animscripted("rise_anim", self.origin, spot_angles, anim_name, "normal");
	self notify(#"rise_anim_finished");
	self.in_the_ground = 0;
	self clientfield::set("zombie_riser_fx", 0);
}

/*
	Name: function_b793bca2
	Namespace: namespace_b912c30b
	Checksum: 0xA48569DF
	Offset: 0x1C70
	Size: 0xE
	Parameters: 0
	Flags: Private
*/
private function function_b793bca2()
{
	self.allowoffnavmesh = 0;
}

/*
	Name: function_c9a1a3bd
	Namespace: namespace_b912c30b
	Checksum: 0x19DEA744
	Offset: 0x1C88
	Size: 0x25C
	Parameters: 4
	Flags: None
*/
function function_c9a1a3bd(spot_origin, spot_angles, anim_name, var_c2a69066)
{
	self endon(#"death");
	if(!isdefined(anim_name))
	{
		return;
	}
	self clientfield::set("zombie_riser_fx", 1);
	self.is_digging = 1;
	self animscripted("dig_anim", self.origin, self.angles, anim_name, "normal");
	self waittill_match({#notetrack:"end"}, #"dig_anim");
	self ghost();
	self notsolid();
	self clientfield::set("zombie_riser_fx", 0);
	self pathmode("dont move", 1);
	spawn_point = self.var_4dc5382f.spawn_points[randomint(self.var_4dc5382f.spawn_points.size)];
	wait(2);
	self forceteleport(spawn_point.origin, spawn_point.angles);
	wait(2);
	self pathmode("move allowed");
	self solid();
	self function_55625f76(spawn_point.origin, spawn_point.angles, self.spawn_anim);
	self.is_digging = 0;
	if(isdefined(var_c2a69066))
	{
		self [[var_c2a69066]]();
	}
}

/*
	Name: function_92c7e9a9
	Namespace: namespace_b912c30b
	Checksum: 0x5EF29A6F
	Offset: 0x1EF0
	Size: 0x2FA
	Parameters: 1
	Flags: Linked
*/
function function_92c7e9a9(var_4dc5382f)
{
	self endon(#"delete");
	var_4dc5382f notify(#"hash_504cca68acf811b2");
	var_4dc5382f endon(#"hash_504cca68acf811b2");
	wisp = var_4dc5382f.var_484efd06;
	if(isdefined(self.var_4dc5382f.var_78823914) && self.var_4dc5382f.var_78823914)
	{
		wisp clientfield::set("soultransfer", 1);
		n_duration = 0.5;
		speed = 500;
		minrange = 100;
		wisp unlink();
		while(isalive(self) && isdefined(wisp))
		{
			end_point = self.origin + vectorscale((0, 0, 1), 60);
			dist_sq = distancesquared(end_point, wisp.origin);
			if(dist_sq < minrange * minrange)
			{
				break;
			}
			n_duration = sqrt(dist_sq) / speed;
			if(n_duration > 0.2)
			{
				wisp moveto(end_point, n_duration, 0.1, 0.1);
			}
			wait(n_duration);
		}
		if(isalive(self) && isdefined(wisp))
		{
			wisp linkto(self, "j_helmet", (0, 0, 0), (0, 0, 0));
			wisp clientfield::set("soultransfer", 0);
			self waittill(#"death");
			if(isdefined(wisp))
			{
				wisp clientfield::set("soultransfer", 1);
				wisp unlink();
				end_point = wisp.origin + vectorscale((0, 0, 1), 60);
				n_duration = 1;
				wisp moveto(end_point, n_duration, 0.1, 0.1);
				wait(n_duration);
			}
		}
	}
}

/*
	Name: function_7adc1e46
	Namespace: namespace_b912c30b
	Checksum: 0x28817163
	Offset: 0x21F8
	Size: 0x21C
	Parameters: 2
	Flags: Linked
*/
function function_7adc1e46(var_4dc5382f, var_1e9a96f7)
{
	level endon(#"game_ended");
	self.var_4dc5382f = var_4dc5382f;
	self.disabletargetservice = 1;
	self.var_5a8f690 = undefined;
	self.var_ea34ab74 = undefined;
	self.aistate = 0;
	self.favoriteenemy = undefined;
	self.var_1e9a96f7 = var_1e9a96f7;
	if(isdefined(var_1e9a96f7) && var_1e9a96f7)
	{
		var_4dc5382f.special_ai = self;
		self thread function_92c7e9a9(var_4dc5382f);
	}
	/#
		if(isdefined(level.var_76325c03) && level.var_76325c03)
		{
			level.var_80bea5a6++;
			if(level.var_80bea5a6 > 3)
			{
				level.var_80bea5a6 = 3;
			}
			self.var_4dc5382f.var_80bea5a6 = level.var_80bea5a6;
		}
	#/
	var_80bea5a6 = 1;
	if(isdefined(self.var_4dc5382f) && isdefined(self.var_4dc5382f.var_80bea5a6))
	{
		var_80bea5a6 = self.var_4dc5382f.var_80bea5a6;
	}
	if(isdefined(level.var_7b5ba689) && level.var_7b5ba689 && (isdefined(self.var_1e9a96f7) && self.var_1e9a96f7))
	{
		self thread namespace_4ae2f15f::delayed_zombie_eye_glow(3);
	}
	else if(isdefined(var_80bea5a6))
	{
		self thread namespace_4ae2f15f::delayed_zombie_eye_glow(var_80bea5a6);
	}
	self.team = level.var_91a15ec0;
	self.var_b69c12bc = 1;
	self callback::function_d8abfc3d(#"on_ai_killed", &function_a679f9b);
}

/*
	Name: function_a679f9b
	Namespace: namespace_b912c30b
	Checksum: 0xB1E5AEED
	Offset: 0x2420
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function function_a679f9b(params)
{
	if(isdefined(self.var_4dc5382f))
	{
		self.var_4dc5382f.var_84b8298c--;
		namespace_bf3feaf0::function_37411c68(self.var_4dc5382f, self);
		if(isdefined(params.eattacker) && isplayer(params.eattacker))
		{
			if(self.archetype == #"zombie")
			{
				self.var_4dc5382f.var_58ba2ab7++;
			}
			else
			{
				self.var_4dc5382f.var_41e86d33++;
			}
		}
	}
}

/*
	Name: is_player_valid
	Namespace: namespace_b912c30b
	Checksum: 0xA75B5F65
	Offset: 0x24D8
	Size: 0x108
	Parameters: 1
	Flags: Linked
*/
function is_player_valid(player)
{
	if(!isdefined(player))
	{
		return 0;
	}
	if(!isalive(player))
	{
		return 0;
	}
	if(!isplayer(player))
	{
		return 0;
	}
	if(player.sessionstate == "spectator")
	{
		return 0;
	}
	if(player.sessionstate == "intermission")
	{
		return 0;
	}
	if(isdefined(player.intermission) && player.intermission)
	{
		return 0;
	}
	if(player laststand::player_is_in_laststand())
	{
		return 0;
	}
	if(player infection::is_infected())
	{
		return 0;
	}
	if(player.ignoreme || player isnotarget())
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_f10600c
	Namespace: namespace_b912c30b
	Checksum: 0x2B583D5
	Offset: 0x25E8
	Size: 0x11A
	Parameters: 1
	Flags: Linked
*/
function function_f10600c(enemy)
{
	if(!is_player_valid(enemy))
	{
		return 0;
	}
	if(isdefined(self.var_5a8f690) && gettime() < self.var_ea34ab74)
	{
		return self.var_5a8f690;
	}
	targetpoint = (isdefined(enemy.var_88f8feeb) ? enemy.var_88f8feeb : enemy getcentroid());
	if(bullettracepassed(self geteye(), targetpoint, 0, enemy))
	{
		self clearentitytarget();
		self.var_5a8f690 = 1;
		self.var_ea34ab74 = gettime() + 2000;
	}
	else
	{
		self.var_5a8f690 = 0;
		self.var_ea34ab74 = gettime() + 500;
	}
	return self.var_5a8f690;
}

/*
	Name: function_5f460765
	Namespace: namespace_b912c30b
	Checksum: 0x3E185F00
	Offset: 0x2710
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function function_5f460765()
{
	if((isdefined(getgametypesetting(#"hash_26f00de198472b81")) ? getgametypesetting(#"hash_26f00de198472b81") : 0) && (isdefined(getgametypesetting(#"hash_50c10372c80d0a6b")) ? getgametypesetting(#"hash_50c10372c80d0a6b") : 0) != 0)
	{
		return (isdefined(getgametypesetting(#"hash_50c10372c80d0a6b")) ? getgametypesetting(#"hash_50c10372c80d0a6b") : 0);
	}
	return undefined;
}

/*
	Name: ai_wz_can_see
	Namespace: namespace_b912c30b
	Checksum: 0xDE87CEB3
	Offset: 0x2818
	Size: 0x5E0
	Parameters: 0
	Flags: Linked
*/
function ai_wz_can_see()
{
	aiprofile_beginentry("ai_wz_can_see");
	/#
		if(getdvarint(#"hash_59d67b405e560d25", 0) > 2)
		{
			aiprofile_endentry();
			return undefined;
		}
	#/
	players_in_zone = [];
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		if(isdefined(players[i].var_4dc5382f) && isdefined(self.var_4dc5382f) && players[i].var_4dc5382f == self.var_4dc5382f)
		{
			if(!isdefined(players_in_zone))
			{
				players_in_zone = [];
			}
			else if(!isarray(players_in_zone))
			{
				players_in_zone = array(players_in_zone);
			}
			players_in_zone[players_in_zone.size] = players[i];
			continue;
		}
		if(getdvarint(#"hash_4cfef227405e3c46", 0) && !isdefined(players[i].var_4dc5382f) && !isdefined(self.var_4dc5382f))
		{
			if(!isdefined(players_in_zone))
			{
				players_in_zone = [];
			}
			else if(!isarray(players_in_zone))
			{
				players_in_zone = array(players_in_zone);
			}
			players_in_zone[players_in_zone.size] = players[i];
			continue;
		}
		if(isdefined(self.var_4dc5382f) && (isdefined(self.var_4dc5382f.var_36a9f8ba) && self.var_4dc5382f.var_36a9f8ba))
		{
			if(!isdefined(players_in_zone))
			{
				players_in_zone = [];
			}
			else if(!isarray(players_in_zone))
			{
				players_in_zone = array(players_in_zone);
			}
			players_in_zone[players_in_zone.size] = players[i];
		}
	}
	n_max_dist = undefined;
	if((isdefined(getgametypesetting(#"hash_26f00de198472b81")) ? getgametypesetting(#"hash_26f00de198472b81") : 0) && !(isdefined(getgametypesetting(#"hash_77af5743dec010ae")) ? getgametypesetting(#"hash_77af5743dec010ae") : 0))
	{
		n_max_dist = getdvarint(#"hash_5a59019abe7dc15d", 5000);
	}
	if(getdvarint(#"hash_4cfef227405e3c46", 0))
	{
		n_max_dist = 1650;
	}
	var_13324143 = arraysortclosest(players_in_zone, self.origin, 4, undefined, n_max_dist);
	if(isdefined(self.var_ff3f3261) && self.var_ff3f3261 && isdefined(var_13324143[0]))
	{
		aiprofile_endentry();
		return var_13324143[0];
	}
	var_a5b66044 = [];
	var_1f79ce88 = [];
	foreach(player in var_13324143)
	{
		if(self function_f10600c(player))
		{
			var_a5b66044[var_a5b66044.size] = player;
			var_1f79ce88[var_1f79ce88.size] = (isdefined(player.last_valid_position) ? player.last_valid_position : player.origin);
		}
	}
	var_4c08e4c9 = function_5f460765();
	if(!isdefined(var_4c08e4c9))
	{
		var_f67d1ba2 = generatenavmeshpath(self.origin, var_1f79ce88, self);
	}
	else
	{
		var_f67d1ba2 = generatenavmeshpath(self.origin, var_1f79ce88, self, undefined, undefined, var_4c08e4c9);
	}
	if(isdefined(var_f67d1ba2) && var_f67d1ba2.status == "succeeded")
	{
		var_4a71d96f = arraygetclosest(var_f67d1ba2.pathpoints[var_f67d1ba2.pathpoints.size - 1], var_a5b66044);
	}
	aiprofile_endentry();
	return var_4a71d96f;
}

/*
	Name: get_closest_player
	Namespace: namespace_b912c30b
	Checksum: 0x538FBDF6
	Offset: 0x2E00
	Size: 0xFE
	Parameters: 2
	Flags: Linked
*/
function get_closest_player(str_zone, v_origin)
{
	n_closest_dist = 9999999;
	var_655f39be = undefined;
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		if(isdefined(players[i].var_4dc5382f) && players[i].var_4dc5382f == str_zone)
		{
			n_dist = distance(players[i].origin, v_origin);
			if(n_dist < n_closest_dist)
			{
				n_closest_dist = n_dist;
				var_655f39be = players[i];
			}
		}
	}
	return var_655f39be;
}

/*
	Name: fake_physicslaunch
	Namespace: namespace_b912c30b
	Checksum: 0x41FA5D17
	Offset: 0x2F08
	Size: 0x130
	Parameters: 2
	Flags: Linked
*/
function fake_physicslaunch(target_pos, power)
{
	dist = distance(self.origin, target_pos);
	time = float(function_60d95f53()) / 1000;
	if(dist > 0.01)
	{
		time = dist / power;
		drop = -0.5 * level.var_31286808 * (time * time);
		delta = target_pos - self.origin;
		velocity = (delta[0] / time, delta[1] / time, (delta[2] - drop) / time);
		self movegravity(velocity, time);
	}
	return time;
}

/*
	Name: function_7a1e21a9
	Namespace: namespace_b912c30b
	Checksum: 0x89BA6503
	Offset: 0x3040
	Size: 0x1C6
	Parameters: 6
	Flags: Linked
*/
function function_7a1e21a9(attacker, v_origin, min_radius = 50, max_radius = 70, var_4dd1cd8b = 100, var_8c20ac00 = 100)
{
	self endon(#"delete");
	self.origin = v_origin + vectorscale((0, 0, 1), 10);
	if(isdefined(attacker) && (isdefined(attacker.usingvehicle) && attacker.usingvehicle))
	{
		min_radius = var_4dd1cd8b;
		max_radius = var_8c20ac00;
	}
	dest_origin = function_e1cd5954(v_origin, min_radius, max_radius);
	n_power = 100;
	time = self fake_physicslaunch(dest_origin, n_power);
	if(self.item.name == #"ray_gun")
	{
		self playsound(#"mus_raygun_stinger");
	}
	else
	{
		self playsound(#"zmb_spawn_powerup");
	}
	wait(time);
	if(isdefined(self))
	{
		self.origin = dest_origin;
	}
}

/*
	Name: function_d92e3c5a
	Namespace: namespace_b912c30b
	Checksum: 0x34275D2F
	Offset: 0x3210
	Size: 0x324
	Parameters: 3
	Flags: Linked
*/
function function_d92e3c5a(attacker, var_4dc5382f, itemlist)
{
	if(!isdefined(self.var_6a7537d8))
	{
		self.var_6a7537d8 = 1;
	}
	v_origin = self.origin;
	items = self namespace_65181344::function_fd87c780(itemlist, self.var_6a7537d8);
	if(!isdefined(self))
	{
		return;
	}
	if(isdefined(self.var_e575a1bb))
	{
		min_radius = self.var_e575a1bb;
	}
	else
	{
		min_radius = undefined;
	}
	if(isdefined(self.var_40c895b9))
	{
		max_radius = self.var_40c895b9;
	}
	else
	{
		max_radius = undefined;
	}
	if(isdefined(self.var_e154425f))
	{
		var_ad797f55 = self.var_e154425f;
	}
	else
	{
		var_4dd1cd8b = undefined;
	}
	if(isdefined(self.var_4f53e075))
	{
		var_8c20ac00 = self.var_4f53e075;
	}
	else
	{
		var_8c20ac00 = undefined;
	}
	for(i = 0; i < items.size; i++)
	{
		item = items[i];
		if(isdefined(item))
		{
			if(isdefined(level.var_c64b3b46) && level.var_c64b3b46)
			{
				if(isdefined(item.var_a6762160) && isdefined(var_4dc5382f) && isdefined(var_4dc5382f.item_drops))
				{
					if(!isdefined(var_4dc5382f.item_drops[self.archetype]))
					{
						var_4dc5382f.item_drops[self.archetype] = [];
					}
					if(!isdefined(var_4dc5382f.item_drops[self.archetype][item.var_a6762160.name]))
					{
						var_4dc5382f.item_drops[self.archetype][item.var_a6762160.name] = {};
					}
					if(!isdefined(var_4dc5382f.item_drops[self.archetype][item.var_a6762160.name].count))
					{
						var_4dc5382f.item_drops[self.archetype][item.var_a6762160.name].count = 0;
					}
					var_4dc5382f.item_drops[self.archetype][item.var_a6762160.name].count++;
				}
			}
			item thread function_7a1e21a9(attacker, v_origin, min_radius, max_radius, var_4dd1cd8b, var_8c20ac00);
		}
		waitframe(1);
	}
}

/*
	Name: function_e1cd5954
	Namespace: namespace_b912c30b
	Checksum: 0x6078DB6
	Offset: 0x3540
	Size: 0x146
	Parameters: 3
	Flags: Linked
*/
function function_e1cd5954(v_origin, min_radius, max_radius)
{
	var_9bd6c1ae = v_origin;
	queryresult = positionquery_source_navigation(var_9bd6c1ae, min_radius, max_radius, 500, 4);
	if(isdefined(queryresult.data[0]))
	{
		var_9bd6c1ae = queryresult.data[randomint(queryresult.data.size)].origin;
	}
	else
	{
		var_9bd6c1ae = v_origin;
	}
	trace = bullettrace(var_9bd6c1ae + vectorscale((0, 0, 1), 40), var_9bd6c1ae + (vectorscale((0, 0, -1), 150)), 0, undefined);
	if(trace[#"fraction"] < 1)
	{
		var_9bd6c1ae = trace[#"position"];
	}
	return var_9bd6c1ae + vectorscale((0, 0, 1), 3);
}

/*
	Name: function_9fa1c215
	Namespace: namespace_b912c30b
	Checksum: 0x8CB0A3C5
	Offset: 0x3690
	Size: 0x320
	Parameters: 1
	Flags: Linked
*/
function function_9fa1c215(var_4dc5382f)
{
	if(isdefined(level.var_18bf5e98))
	{
		return [[level.var_18bf5e98]]();
	}
	itemlist = level.var_9eb9a467;
	var_1130690 = 0;
	if(isdefined(level.var_b4143320) && level.var_b4143320)
	{
		var_d0c1e811 = 0;
		if(isdefined(level.deathcircle) && isdefined(level.var_52b56362))
		{
			if(level.var_52b56362 < level.var_1a35832e)
			{
				var_d0c1e811 = 1;
			}
		}
		else
		{
			var_d0c1e811 = 1;
		}
		if(var_d0c1e811 && isdefined(var_4dc5382f) && var_4dc5382f.var_c573acdd == var_4dc5382f.var_ce8df1c9)
		{
			if(level.var_d5cd88c2 < level.var_acfc1745 && randomfloat(1) <= 0.3)
			{
				itemlist = level.var_1b7acd6d;
				level.var_d5cd88c2++;
				var_1130690 = 1;
				level.var_57a77bb = 1;
			}
			if(!level.var_2510617f < level.var_1b2f5c9d && randomfloat(1) <= 0.3)
			{
				itemlist = level.var_72151997;
				level.var_2510617f++;
				var_1130690 = 1;
				level.var_57a77bb = 0;
			}
			if(!level.var_6eb6193a < level.var_ad2edeba && randomfloat(1) <= 0.3)
			{
				itemlist = level.var_14364e26;
				level.var_6eb6193a++;
				var_1130690 = 1;
				level.var_57a77bb = 0;
			}
			if(!level.var_7dff87f1 < level.var_a71296ac && randomfloat(1) <= 0.3)
			{
				itemlist = level.var_7d2bc89;
				level.var_7dff87f1++;
				var_1130690 = 1;
				level.var_57a77bb = 0;
			}
		}
	}
	if(!var_1130690)
	{
		if(randomint(100) <= 2)
		{
			if(!level.var_8a3036cc)
			{
				itemlist = level.var_db43cbd7;
				level.var_8a3036cc = 1;
			}
		}
	}
	if(isdefined(var_4dc5382f))
	{
		var_4dc5382f.var_c573acdd++;
	}
	return itemlist;
}

/*
	Name: function_f311bd4c
	Namespace: namespace_b912c30b
	Checksum: 0xA05DD88B
	Offset: 0x39B8
	Size: 0x3E4
	Parameters: 1
	Flags: Linked
*/
function function_f311bd4c(var_4dc5382f)
{
	self notify("54de30d16f7f89db");
	self endon("54de30d16f7f89db");
	waitresult = undefined;
	waitresult = self waittill(#"death");
	var_a98b31aa = isdefined(self.var_4dc5382f) && isdefined(self.var_4dc5382f.def);
	self.var_4dc5382f = undefined;
	if(isdefined(self.fxent))
	{
		self clientfield::set("zombie_has_microwave", 0);
		self.fxent delete();
	}
	if(isplayer(waitresult.attacker))
	{
		if(isdefined(self.var_42042e94) && self.var_42042e94)
		{
			self.var_42042e94 = 0;
			self detach(#"p8_zm_red_floatie_duck", "j_spinelower");
			self clientfield::set("zombie_died", 1);
		}
		scoreevents::processscoreevent(#"zombie_kills", waitresult.attacker, undefined, undefined);
		var_b25650ab = spawnstruct();
		var_b25650ab.origin = self.origin;
		var_b25650ab.archetype = self.archetype;
		if(isdefined(self.var_e575a1bb))
		{
			var_b25650ab.var_e575a1bb = self.var_e575a1bb;
		}
		if(isdefined(self.var_40c895b9))
		{
			var_b25650ab.var_40c895b9 = self.var_40c895b9;
		}
		if(isdefined(self.var_e154425f))
		{
			var_b25650ab.var_e154425f = self.var_e154425f;
		}
		if(isdefined(self.var_4f53e075))
		{
			var_b25650ab.var_4f53e075 = self.var_4f53e075;
		}
		if(isdefined(var_a98b31aa) || (isdefined(self.var_54f8158e) && self.var_54f8158e))
		{
			if(!level.inprematchperiod)
			{
				waitresult.attacker stats::function_d40764f3(#"hash_5e146097143ab761", 1);
			}
			if(isdefined(self.var_2cee3556))
			{
				var_b25650ab.var_2cee3556 = self.var_2cee3556;
				foreach(item_list, var_c46cdc46 in var_b25650ab.var_2cee3556)
				{
					var_b25650ab.var_6a7537d8 = var_c46cdc46;
					var_b25650ab function_d92e3c5a(waitresult.attacker, var_4dc5382f, item_list);
				}
			}
			else if(isdefined(self.var_ef46cd4))
			{
				self function_d92e3c5a(waitresult.attacker, var_4dc5382f, self.var_ef46cd4);
			}
			else
			{
				itemlist = function_9fa1c215(var_4dc5382f);
				if(isdefined(itemlist))
				{
					self function_d92e3c5a(waitresult.attacker, var_4dc5382f, itemlist);
				}
			}
		}
	}
}

/*
	Name: function_9758722
	Namespace: namespace_b912c30b
	Checksum: 0x33F2404
	Offset: 0x3DA8
	Size: 0xB2
	Parameters: 1
	Flags: Linked
*/
function function_9758722(speed)
{
	if(self.zombie_move_speed === speed)
	{
		return;
	}
	self.zombie_move_speed = speed;
	if(!isdefined(self.zombie_arms_position))
	{
		self.zombie_arms_position = (math::cointoss() == 1 ? "up" : "down");
	}
	if(isdefined(level.var_9ee73630))
	{
		self.variant_type = randomint(level.var_9ee73630[self.zombie_move_speed][self.zombie_arms_position]);
	}
}

/*
	Name: function_35eac38d
	Namespace: namespace_b912c30b
	Checksum: 0x122E30C
	Offset: 0x3E68
	Size: 0x16E
	Parameters: 1
	Flags: Linked
*/
function function_35eac38d(pathnode)
{
	path_struct = {#loops:0, #path:array(pathnode)};
	var_592eaf7 = pathnode;
	while(isdefined(var_592eaf7.target))
	{
		var_592eaf7 = getnode(var_592eaf7.target, "targetname");
		if(!isdefined(var_592eaf7))
		{
			break;
		}
		if(isinarray(path_struct.path, var_592eaf7))
		{
			path_struct.loops = 1;
			break;
		}
		if(!isdefined(path_struct.path))
		{
			path_struct.path = [];
		}
		else if(!isarray(path_struct.path))
		{
			path_struct.path = array(path_struct.path);
		}
		path_struct.path[path_struct.path.size] = var_592eaf7;
	}
	return path_struct;
}

/*
	Name: function_9a5f0c0
	Namespace: namespace_b912c30b
	Checksum: 0x952D83E8
	Offset: 0x3FE0
	Size: 0xAE
	Parameters: 2
	Flags: Linked
*/
function function_9a5f0c0(startpt, endpt)
{
	self endon(#"delete");
	self.origin = startpt + vectorscale((0, 0, 1), 10);
	time = self fake_physicslaunch(endpt, 100);
	self playsound(#"zmb_spawn_powerup");
	wait(time);
	if(isdefined(self))
	{
		self.origin = endpt;
	}
}

/*
	Name: function_bf357ddf
	Namespace: namespace_b912c30b
	Checksum: 0x3507F15A
	Offset: 0x4098
	Size: 0x114
	Parameters: 2
	Flags: Linked
*/
function function_bf357ddf(spawnpt, itemlist)
{
	waitresult = undefined;
	waitresult = self waittill(#"death");
	if(isdefined(spawnpt.target))
	{
		var_10508147 = struct::get(spawnpt.target, "targetname");
		items = self namespace_65181344::function_fd87c780(itemlist, 1);
		for(i = 0; i < items.size; i++)
		{
			item = items[i];
			if(isdefined(item))
			{
				item thread function_9a5f0c0(self.origin, var_10508147.origin);
			}
			waitframe(1);
		}
	}
}

/*
	Name: function_ac114e1f
	Namespace: namespace_b912c30b
	Checksum: 0xB227CE91
	Offset: 0x41B8
	Size: 0x174
	Parameters: 3
	Flags: Linked
*/
function function_ac114e1f(spawnpt, aitype, zone_name)
{
	players = getplayers();
	spawned = spawnactor(aitype, spawnpt.origin, spawnpt.angles, "wz_dyn_ai");
	if(isdefined(spawned))
	{
		spawned thread function_7adc1e46(undefined, 0);
		spawned.spawn_anim = undefined;
		spawned.var_b8c61fc5 = 0;
		spawned.var_ef59b90 = 3;
		spawned namespace_4ae2f15f::function_d1e55248(#"hash_6e6d6ff06622efa4", 1);
		spawned.var_721a3dbd = 0;
		spawned.var_35eedf58 = 0;
		spawned.disable_movement = 1;
		spawned.var_ea7e9b57 = namespace_bf3feaf0::function_aacb2027(zone_name, aitype);
		if(isdefined(zone_name))
		{
			itemlist = function_9fa1c215(zone_name);
			spawned thread function_bf357ddf(spawnpt, itemlist);
		}
	}
}

/*
	Name: function_f656f22e
	Namespace: namespace_b912c30b
	Checksum: 0x8F159B79
	Offset: 0x4338
	Size: 0xFE
	Parameters: 1
	Flags: Linked
*/
function function_f656f22e(var_4dc5382f)
{
	all_ai = getaiteamarray(#"world");
	if(isdefined(all_ai) && all_ai.size > 0)
	{
		foreach(ai in all_ai)
		{
			if(isdefined(ai.var_ea7e9b57) && ai.var_ea7e9b57 == var_4dc5382f)
			{
				ai kill(undefined, undefined, undefined, undefined, 0, 1);
				waitframe(1);
			}
		}
	}
}

/*
	Name: get_attackable
	Namespace: namespace_b912c30b
	Checksum: 0xE6BD19EF
	Offset: 0x4440
	Size: 0x1AA
	Parameters: 2
	Flags: Linked
*/
function get_attackable(entity, var_83917763)
{
	if(!(isdefined(var_83917763) && var_83917763) && !isinarray(level.var_8de0b84e, entity getentitynumber()))
	{
		return undefined;
	}
	if(isdefined(level.attackables))
	{
		arrayremovevalue(level.attackables, undefined);
		foreach(attackable in level.attackables)
		{
			if(!isdefined(attackable.var_b79a8ac7) || !isdefined(attackable.var_b79a8ac7.var_f019ea1a))
			{
				continue;
			}
			dist = distancesquared(entity.origin, attackable.origin);
			if(dist < attackable.var_b79a8ac7.var_f019ea1a * attackable.var_b79a8ac7.var_f019ea1a)
			{
				if(attackable get_attackable_slot(entity))
				{
					return attackable;
				}
			}
		}
	}
	return undefined;
}

/*
	Name: get_attackable_slot
	Namespace: namespace_b912c30b
	Checksum: 0xF4E9C884
	Offset: 0x45F8
	Size: 0x21E
	Parameters: 1
	Flags: Linked
*/
function get_attackable_slot(entity)
{
	if(!isdefined(self.var_b79a8ac7))
	{
		return 0;
	}
	self clear_slots();
	var_4dbfc246 = [];
	var_34bcb139 = [];
	foreach(slot in self.var_b79a8ac7.slots)
	{
		if(!isdefined(slot.entity))
		{
			var_34bcb139[var_34bcb139.size] = slot;
		}
	}
	if(var_34bcb139.size == 0)
	{
		return 0;
	}
	var_754df93c = entity.origin;
	var_b2c0d134 = arraygetclosest(var_754df93c, var_34bcb139);
	if(var_b2c0d134.var_bb075e37)
	{
		var_acdc8d71 = getclosestpointonnavmesh(var_b2c0d134.origin, entity getpathfindingradius(), entity getpathfindingradius());
		if(isdefined(var_acdc8d71))
		{
			var_b2c0d134.entity = entity;
			entity.var_b238ef38 = {#position:var_acdc8d71, #slot:var_b2c0d134};
			return 1;
		}
	}
	else
	{
		var_b2c0d134.entity = entity;
		entity.var_b238ef38 = {#position:var_b2c0d134.origin, #slot:var_b2c0d134};
		return 1;
	}
	return 0;
}

/*
	Name: clear_slots
	Namespace: namespace_b912c30b
	Checksum: 0x80CFB7AC
	Offset: 0x4820
	Size: 0xE6
	Parameters: 0
	Flags: Linked
*/
function clear_slots()
{
	if(!isdefined(self.var_b79a8ac7))
	{
		return;
	}
	foreach(slot in self.var_b79a8ac7.slots)
	{
		if(!isalive(slot.entity))
		{
			slot.entity = undefined;
			continue;
		}
		if(isdefined(slot.entity.missinglegs) && slot.entity.missinglegs)
		{
			slot.entity = undefined;
		}
	}
}

/*
	Name: function_2b925fa5
	Namespace: namespace_b912c30b
	Checksum: 0x1790AA06
	Offset: 0x4910
	Size: 0x5E
	Parameters: 1
	Flags: Linked
*/
function function_2b925fa5(entity)
{
	if(isdefined(entity.attackable))
	{
		entity.attackable = undefined;
	}
	if(isdefined(entity.var_b238ef38))
	{
		entity.var_b238ef38.slot.entity = undefined;
		entity.var_b238ef38 = undefined;
	}
}

/*
	Name: function_bdb2b85b
	Namespace: namespace_b912c30b
	Checksum: 0x94B39094
	Offset: 0x4978
	Size: 0x3BA
	Parameters: 6
	Flags: Linked
*/
function function_bdb2b85b(entity, origin, angles, radius, num_spots, var_7a2632b5)
{
	level endon(#"game_ended");
	slots = [];
	mins = vectorscale((-1, -1, 0), 10);
	maxs = (10, 10, 48);
	/#
		record3dtext("", origin, (0, 0, 1));
	#/
	for(i = 0; i < num_spots; i++)
	{
		t = mapfloat(0, num_spots, 0, 360, i);
		x = radius * (cos(t + angles[1]));
		y = radius * (sin(t + angles[1]));
		pos = (x, y, 0) + origin;
		if(!bullettracepassed(origin + vectorscale((0, 0, 1), 5), pos + vectorscale((0, 0, 1), 5), 0, entity))
		{
			if((i % 2) == 1)
			{
				waitframe(1);
			}
			continue;
		}
		var_e07c7e8 = physicstrace(pos + vectorscale((0, 0, 1), 10), pos + (vectorscale((0, 0, -1), 10)), mins, maxs, self, 1);
		var_c060661b = var_e07c7e8[#"position"];
		var_3e98a413 = getclosestpointonnavmesh(var_c060661b, 64, 15);
		if(isdefined(var_3e98a413))
		{
			/#
				recordstar(var_3e98a413, (0, 1, 0));
			#/
			slots[slots.size] = {#hash_bb075e37:1, #origin:var_3e98a413};
		}
		else if(isdefined(var_c060661b))
		{
			if(isdefined(var_7a2632b5))
			{
				var_acdc8d71 = getclosestpointonnavmesh(var_c060661b, var_7a2632b5, 15);
			}
			/#
				if(isdefined(var_acdc8d71))
				{
					recordstar(var_acdc8d71, (1, 0, 1));
				}
			#/
			/#
				recordstar(var_c060661b, (1, 0.5, 0));
			#/
			slots[slots.size] = {#hash_acdc8d71:var_acdc8d71, #hash_bb075e37:0, #origin:var_c060661b};
		}
		if((i % 2) == 1)
		{
			waitframe(1);
		}
	}
	return slots;
}

/*
	Name: function_16e2f075
	Namespace: namespace_b912c30b
	Checksum: 0x447DD9BC
	Offset: 0x4D40
	Size: 0x1FC
	Parameters: 1
	Flags: Linked
*/
function function_16e2f075(params)
{
	self.var_cd7665dd = gettime();
	if(isdefined(self.var_1b5e8136) && (gettime() - self.var_1b5e8136) > 1000)
	{
		return;
	}
	if(!(isdefined(self.var_85c3882d) && self.var_85c3882d))
	{
		self.var_1b5e8136 = gettime();
	}
	self.var_85c3882d = 1;
	if(!(isdefined(self.var_a9d9d11b) && self.var_a9d9d11b) || self.var_a9d9d11b < gettime())
	{
		self.var_a9d9d11b = gettime() + 500;
		if(getdvarint(#"hash_4cfef227405e3c46", 0))
		{
			damageamount = randomintrange(20, 60);
			self notify(#"hash_1c3d0eb6bfd8461a");
		}
		else
		{
			damageamount = 30;
		}
		self dodamage(damageamount, self.origin, params.wire.owner, params.wire, undefined, "MOD_IMPACT", 0, level.var_87226c31.var_3e7344ee);
	}
	if(isdefined(level.var_f2e76de4))
	{
		if(!isinarray(level.var_f2e76de4, self))
		{
			level.var_f2e76de4[level.var_f2e76de4.size] = self;
		}
	}
	else
	{
		level.var_f2e76de4 = array(self);
		level thread function_7a87d2a7();
	}
}

/*
	Name: function_7a87d2a7
	Namespace: namespace_b912c30b
	Checksum: 0x1E0EEFA7
	Offset: 0x4F48
	Size: 0x1EA
	Parameters: 1
	Flags: Linked
*/
function function_7a87d2a7(var_a9ffa6ec)
{
	level endon(#"game_ended");
	self endon(#"death");
	while(true)
	{
		var_202d087b = [];
		foreach(ai in level.var_f2e76de4)
		{
			if(!isdefined(ai) || !isalive(ai))
			{
				var_202d087b[var_202d087b.size] = ai;
				continue;
			}
			var_3a8a4c13 = gettime() - ai.var_1b5e8136;
			if(var_3a8a4c13 > 1000)
			{
				ai.var_85c3882d = undefined;
			}
			timesincelast = gettime() - ai.var_cd7665dd;
			if(timesincelast > 250)
			{
				ai.var_85c3882d = undefined;
				ai.var_1b5e8136 = undefined;
				var_202d087b[var_202d087b.size] = ai;
			}
		}
		foreach(ai in var_202d087b)
		{
			arrayremovevalue(level.var_f2e76de4, ai);
		}
		waitframe(1);
	}
}

/*
	Name: function_516ff8da
	Namespace: namespace_b912c30b
	Checksum: 0x806BD337
	Offset: 0x5140
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function function_516ff8da()
{
	self.var_54f8158e = 1;
	self thread function_f311bd4c();
}

/*
	Name: function_b7dc3ab4
	Namespace: namespace_b912c30b
	Checksum: 0xF9FF8B20
	Offset: 0x5170
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_b7dc3ab4()
{
	if((isdefined(getgametypesetting(#"hash_2ce00db5cd5003ff")) ? getgametypesetting(#"hash_2ce00db5cd5003ff") : 0))
	{
		level function_71578099();
	}
	else
	{
		level function_9caf8627();
	}
}

/*
	Name: function_71578099
	Namespace: namespace_b912c30b
	Checksum: 0xA8C3407C
	Offset: 0x5200
	Size: 0x3B6
	Parameters: 0
	Flags: Linked
*/
function function_71578099()
{
	nodes = getallnodes();
	foreach(node in nodes)
	{
		if(node.type != #"begin")
		{
			continue;
		}
		if(isdefined(node.targetname))
		{
			var_99b5fc08 = function_c79d31c4(node.targetname);
			if(isdefined(var_99b5fc08) && var_99b5fc08.size > 0)
			{
				var_a6131e58 = 0;
				foreach(dynent in var_99b5fc08)
				{
					if(dynent.var_15d44120 === #"p8_fxanim_wz_rollup_door_medium_mod")
					{
						var_a6131e58 = 1;
						break;
					}
				}
				if(!var_a6131e58)
				{
					foreach(var_4dc5382f in level.var_5b357434)
					{
						var_8d8a9cfc = istouching(node.origin, var_4dc5382f.def);
						if(!var_8d8a9cfc)
						{
							var_c88f4455 = getothernodeinnegotiationpair(node);
							if(isdefined(var_c88f4455))
							{
								var_8d8a9cfc = istouching(var_c88f4455.origin, var_4dc5382f.def);
							}
						}
						if(var_8d8a9cfc)
						{
							var_4dc5382f.var_336d2f53[var_4dc5382f.var_336d2f53.size] = node;
							node.var_4dc5382f = var_4dc5382f;
							break;
						}
					}
				}
				else
				{
					function_dc0a8e61(node, 1);
					var_c88f4455 = getothernodeinnegotiationpair(node);
					if(isdefined(var_c88f4455))
					{
						function_dc0a8e61(var_c88f4455, 1);
					}
				}
				if(!isdefined(node.var_4dc5382f) && !var_a6131e58)
				{
					linktraversal(node);
				}
				foreach(dynent in var_99b5fc08)
				{
					dynent.var_993e9bb0 = 1;
					dynent.var_a6131e58 = var_a6131e58;
				}
			}
		}
	}
}

/*
	Name: function_9caf8627
	Namespace: namespace_b912c30b
	Checksum: 0x291CE07B
	Offset: 0x55C0
	Size: 0x22E
	Parameters: 0
	Flags: Linked
*/
function function_9caf8627()
{
	nodes = getallnodes();
	foreach(node in nodes)
	{
		if(node.type != #"begin" && node.type != #"end")
		{
			continue;
		}
		var_e209e8e0 = 0;
		if(isdefined(node.targetname))
		{
			var_99b5fc08 = function_c79d31c4(node.targetname);
			var_e209e8e0 = isdefined(var_99b5fc08) && var_99b5fc08.size > 0;
		}
		if(!var_e209e8e0)
		{
			var_c88f4455 = getothernodeinnegotiationpair(node);
			if(!isdefined(var_c88f4455) || !isdefined(var_c88f4455.targetname))
			{
				continue;
			}
			var_99b5fc08 = function_c79d31c4(var_c88f4455.targetname);
			var_e209e8e0 = isdefined(var_99b5fc08) && var_99b5fc08.size > 0;
		}
		if(var_e209e8e0)
		{
			function_dc0a8e61(node, 1);
			foreach(dynent in var_99b5fc08)
			{
				dynent.var_993e9bb0 = 1;
			}
		}
	}
}

