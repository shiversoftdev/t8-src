// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_35598499769dbb3d;
#using script_7e63597649100b1c;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace zombie_utility;

/*
	Name: zombiespawnsetup
	Namespace: zombie_utility
	Checksum: 0x5B27D219
	Offset: 0x3F8
	Size: 0xDA
	Parameters: 0
	Flags: Linked
*/
function zombiespawnsetup()
{
	self.zombie_move_speed = "walk";
	if(!isdefined(self.zombie_arms_position))
	{
		if(randomint(2) == 0)
		{
			self.zombie_arms_position = "up";
		}
		else
		{
			self.zombie_arms_position = "down";
		}
	}
	self function_df5afb5e(0);
	self setavoidancemask("avoid none");
	self collidewithactors(1);
	clientfield::set("zombie", 1);
	self.ignorepathenemyfightdist = 1;
}

/*
	Name: get_closest_valid_player
	Namespace: zombie_utility
	Checksum: 0xDF2D0548
	Offset: 0x4E0
	Size: 0x2CE
	Parameters: 3
	Flags: Linked
*/
function get_closest_valid_player(origin, ignore_player, ignore_laststand_players = 0)
{
	pixbeginevent(#"get_closest_valid_player");
	valid_player_found = 0;
	targets = getplayers();
	if(isdefined(level.closest_player_targets_override))
	{
		targets = [[level.closest_player_targets_override]]();
	}
	if(isdefined(ignore_player))
	{
		for(i = 0; i < ignore_player.size; i++)
		{
			arrayremovevalue(targets, ignore_player[i]);
		}
	}
	done = 1;
	while(targets.size && !done)
	{
		done = 1;
		for(i = 0; i < targets.size; i++)
		{
			target = targets[i];
			if(!is_player_valid(target, 1, ignore_laststand_players))
			{
				arrayremovevalue(targets, target);
				done = 0;
				break;
			}
		}
	}
	if(targets.size == 0)
	{
		pixendevent();
		return undefined;
	}
	if(isdefined(self.closest_player_override))
	{
		target = [[self.closest_player_override]](origin, targets);
	}
	else if(isdefined(level.closest_player_override))
	{
		target = [[level.closest_player_override]](origin, targets);
	}
	if(isdefined(target))
	{
		pixendevent();
		return target;
	}
	sortedpotentialtargets = arraysortclosest(targets, self.origin);
	while(sortedpotentialtargets.size)
	{
		if(is_player_valid(sortedpotentialtargets[0], 1, ignore_laststand_players))
		{
			pixendevent();
			return sortedpotentialtargets[0];
		}
		arrayremovevalue(sortedpotentialtargets, sortedpotentialtargets[0]);
	}
	pixendevent();
	return undefined;
}

/*
	Name: is_player_valid
	Namespace: zombie_utility
	Checksum: 0x26A47265
	Offset: 0x7B8
	Size: 0x1AC
	Parameters: 4
	Flags: Linked
*/
function is_player_valid(player, checkignoremeflag, ignore_laststand_players, var_da861165 = 1)
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
	if(isdefined(player.is_zombie) && player.is_zombie == 1)
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
	if(!var_da861165 && player scene::is_igc_active())
	{
		return 0;
	}
	if(isdefined(player.intermission) && player.intermission)
	{
		return 0;
	}
	if(!(isdefined(ignore_laststand_players) && ignore_laststand_players))
	{
		if(player laststand::player_is_in_laststand())
		{
			return 0;
		}
	}
	if(isdefined(checkignoremeflag) && checkignoremeflag && (player.ignoreme || player isnotarget()))
	{
		return 0;
	}
	if(isdefined(level.is_player_valid_override))
	{
		return [[level.is_player_valid_override]](player);
	}
	return 1;
}

/*
	Name: append_missing_legs_suffix
	Namespace: zombie_utility
	Checksum: 0x136C276F
	Offset: 0x970
	Size: 0x5A
	Parameters: 1
	Flags: Linked
*/
function append_missing_legs_suffix(animstate)
{
	if(isdefined(self.missinglegs) && self.missinglegs && self hasanimstatefromasd(animstate + "_crawl"))
	{
		return animstate + "_crawl";
	}
	return animstate;
}

/*
	Name: initanimtree
	Namespace: zombie_utility
	Checksum: 0xE87A92EB
	Offset: 0x9D8
	Size: 0x76
	Parameters: 1
	Flags: Linked
*/
function initanimtree(animscript)
{
	if(animscript != "pain" && animscript != "death")
	{
		self.a.special = "none";
	}
	/#
		assert(isdefined(animscript), "");
	#/
	self.a.script = animscript;
}

/*
	Name: updateanimpose
	Namespace: zombie_utility
	Checksum: 0xEA297AE4
	Offset: 0xA58
	Size: 0xAE
	Parameters: 0
	Flags: Linked
*/
function updateanimpose()
{
	/#
		assert(self.a.movement == "" || self.a.movement == "" || self.a.movement == "", "" + self.a.pose + "" + self.a.movement);
	#/
	self.desired_anim_pose = undefined;
}

/*
	Name: initialize
	Namespace: zombie_utility
	Checksum: 0xB539E527
	Offset: 0xB10
	Size: 0x214
	Parameters: 1
	Flags: None
*/
function initialize(animscript)
{
	if(isdefined(self.longdeathstarting))
	{
		if(animscript != "pain" && animscript != "death")
		{
			self dodamage(self.health + 100, self.origin);
		}
		if(animscript != "pain")
		{
			self.longdeathstarting = undefined;
			self notify(#"kill_long_death");
		}
	}
	if(isdefined(self.a.mayonlydie) && animscript != "death")
	{
		self dodamage(self.health + 100, self.origin);
	}
	if(isdefined(self.a.postscriptfunc))
	{
		scriptfunc = self.a.postscriptfunc;
		self.a.postscriptfunc = undefined;
		[[scriptfunc]](animscript);
	}
	if(animscript != "death")
	{
		self.a.nodeath = 0;
	}
	self.isholdinggrenade = undefined;
	self.covernode = undefined;
	self.changingcoverpos = 0;
	self.a.scriptstarttime = gettime();
	self.a.atconcealmentnode = 0;
	if(isdefined(self.node) && (self.node.type == #"hash_171465527444ed14" || self.node.type == #"hash_1bb444d857814e92"))
	{
		self.a.atconcealmentnode = 1;
	}
	initanimtree(animscript);
	updateanimpose();
}

/*
	Name: getnodeyawtoorigin
	Namespace: zombie_utility
	Checksum: 0xB97D2B68
	Offset: 0xD30
	Size: 0x92
	Parameters: 1
	Flags: None
*/
function getnodeyawtoorigin(pos)
{
	if(isdefined(self.node))
	{
		yaw = self.node.angles[1] - getyaw(pos);
	}
	else
	{
		yaw = self.angles[1] - getyaw(pos);
	}
	yaw = angleclamp180(yaw);
	return yaw;
}

/*
	Name: getnodeyawtoenemy
	Namespace: zombie_utility
	Checksum: 0x70A6BFE4
	Offset: 0xDD0
	Size: 0x142
	Parameters: 0
	Flags: None
*/
function getnodeyawtoenemy()
{
	pos = undefined;
	if(isvalidenemy(self.enemy))
	{
		pos = self.enemy.origin;
	}
	else if(isdefined(self.node))
	{
		forward = anglestoforward(self.node.angles);
	}
	else
	{
		forward = anglestoforward(self.angles);
	}
	forward = vectorscale(forward, 150);
	pos = self.origin + forward;
	if(isdefined(self.node))
	{
		yaw = self.node.angles[1] - getyaw(pos);
	}
	else
	{
		yaw = self.angles[1] - getyaw(pos);
	}
	yaw = angleclamp180(yaw);
	return yaw;
}

/*
	Name: getcovernodeyawtoenemy
	Namespace: zombie_utility
	Checksum: 0x94065325
	Offset: 0xF20
	Size: 0x132
	Parameters: 0
	Flags: None
*/
function getcovernodeyawtoenemy()
{
	pos = undefined;
	if(isvalidenemy(self.enemy))
	{
		pos = self.enemy.origin;
	}
	else
	{
		forward = anglestoforward(self.covernode.angles + self.animarray[#"angle_step_out"][self.a.cornermode]);
		forward = vectorscale(forward, 150);
		pos = self.origin + forward;
	}
	yaw = self.covernode.angles[1] + self.animarray[#"angle_step_out"][self.a.cornermode] - getyaw(pos);
	yaw = angleclamp180(yaw);
	return yaw;
}

/*
	Name: getyawtospot
	Namespace: zombie_utility
	Checksum: 0x2A16AD1E
	Offset: 0x1060
	Size: 0x62
	Parameters: 1
	Flags: None
*/
function getyawtospot(spot)
{
	pos = spot;
	yaw = self.angles[1] - getyaw(pos);
	yaw = angleclamp180(yaw);
	return yaw;
}

/*
	Name: getyawtoenemy
	Namespace: zombie_utility
	Checksum: 0x76667004
	Offset: 0x10D0
	Size: 0xCA
	Parameters: 0
	Flags: Linked
*/
function getyawtoenemy()
{
	pos = undefined;
	if(isvalidenemy(self.enemy))
	{
		pos = self.enemy.origin;
	}
	else
	{
		forward = anglestoforward(self.angles);
		forward = vectorscale(forward, 150);
		pos = self.origin + forward;
	}
	yaw = self.angles[1] - getyaw(pos);
	yaw = angleclamp180(yaw);
	return yaw;
}

/*
	Name: getyaw
	Namespace: zombie_utility
	Checksum: 0x763EC0CF
	Offset: 0x11A8
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function getyaw(org)
{
	angles = vectortoangles(org - self.origin);
	return angles[1];
}

/*
	Name: getyaw2d
	Namespace: zombie_utility
	Checksum: 0x5B229A52
	Offset: 0x11F0
	Size: 0x68
	Parameters: 1
	Flags: Linked
*/
function getyaw2d(org)
{
	angles = vectortoangles((org[0], org[1], 0) - (self.origin[0], self.origin[1], 0));
	return angles[1];
}

/*
	Name: absyawtoenemy
	Namespace: zombie_utility
	Checksum: 0xE91D1BDC
	Offset: 0x1260
	Size: 0xA2
	Parameters: 0
	Flags: None
*/
function absyawtoenemy()
{
	/#
		assert(isvalidenemy(self.enemy));
	#/
	yaw = self.angles[1] - getyaw(self.enemy.origin);
	yaw = angleclamp180(yaw);
	if(yaw < 0)
	{
		yaw = -1 * yaw;
	}
	return yaw;
}

/*
	Name: absyawtoenemy2d
	Namespace: zombie_utility
	Checksum: 0xC2CE6F43
	Offset: 0x1310
	Size: 0xA2
	Parameters: 0
	Flags: None
*/
function absyawtoenemy2d()
{
	/#
		assert(isvalidenemy(self.enemy));
	#/
	yaw = self.angles[1] - getyaw2d(self.enemy.origin);
	yaw = angleclamp180(yaw);
	if(yaw < 0)
	{
		yaw = -1 * yaw;
	}
	return yaw;
}

/*
	Name: absyawtoorigin
	Namespace: zombie_utility
	Checksum: 0xAF51490A
	Offset: 0x13C0
	Size: 0x6A
	Parameters: 1
	Flags: None
*/
function absyawtoorigin(org)
{
	yaw = self.angles[1] - getyaw(org);
	yaw = angleclamp180(yaw);
	if(yaw < 0)
	{
		yaw = -1 * yaw;
	}
	return yaw;
}

/*
	Name: absyawtoangles
	Namespace: zombie_utility
	Checksum: 0x8BE2F35B
	Offset: 0x1438
	Size: 0x5A
	Parameters: 1
	Flags: None
*/
function absyawtoangles(angles)
{
	yaw = self.angles[1] - angles;
	yaw = angleclamp180(yaw);
	if(yaw < 0)
	{
		yaw = -1 * yaw;
	}
	return yaw;
}

/*
	Name: getyawfromorigin
	Namespace: zombie_utility
	Checksum: 0x9464B276
	Offset: 0x14A0
	Size: 0x40
	Parameters: 2
	Flags: Linked
*/
function getyawfromorigin(org, start)
{
	angles = vectortoangles(org - start);
	return angles[1];
}

/*
	Name: getyawtotag
	Namespace: zombie_utility
	Checksum: 0xC9B828C3
	Offset: 0x14E8
	Size: 0x7A
	Parameters: 2
	Flags: None
*/
function getyawtotag(tag, org)
{
	yaw = self gettagangles(tag)[1] - getyawfromorigin(org, self gettagorigin(tag));
	yaw = angleclamp180(yaw);
	return yaw;
}

/*
	Name: getyawtoorigin
	Namespace: zombie_utility
	Checksum: 0xD3071937
	Offset: 0x1570
	Size: 0x52
	Parameters: 1
	Flags: None
*/
function getyawtoorigin(org)
{
	yaw = self.angles[1] - getyaw(org);
	yaw = angleclamp180(yaw);
	return yaw;
}

/*
	Name: geteyeyawtoorigin
	Namespace: zombie_utility
	Checksum: 0xA56FA471
	Offset: 0x15D0
	Size: 0x6A
	Parameters: 1
	Flags: None
*/
function geteyeyawtoorigin(org)
{
	yaw = self gettagangles("TAG_EYE")[1] - getyaw(org);
	yaw = angleclamp180(yaw);
	return yaw;
}

/*
	Name: getcovernodeyawtoorigin
	Namespace: zombie_utility
	Checksum: 0x5B231487
	Offset: 0x1648
	Size: 0x82
	Parameters: 1
	Flags: None
*/
function getcovernodeyawtoorigin(org)
{
	yaw = self.covernode.angles[1] + self.animarray[#"angle_step_out"][self.a.cornermode] - getyaw(org);
	yaw = angleclamp180(yaw);
	return yaw;
}

/*
	Name: isstanceallowedwrapper
	Namespace: zombie_utility
	Checksum: 0xB8B953B1
	Offset: 0x16D8
	Size: 0x4A
	Parameters: 1
	Flags: None
*/
function isstanceallowedwrapper(stance)
{
	if(isdefined(self.covernode))
	{
		return self.covernode doesnodeallowstance(stance);
	}
	return self isstanceallowed(stance);
}

/*
	Name: getclaimednode
	Namespace: zombie_utility
	Checksum: 0xE5193437
	Offset: 0x1730
	Size: 0x62
	Parameters: 0
	Flags: Linked
*/
function getclaimednode()
{
	mynode = self.node;
	if(isdefined(mynode) && (self nearnode(mynode) || (isdefined(self.covernode) && mynode == self.covernode)))
	{
		return mynode;
	}
	return undefined;
}

/*
	Name: getnodetype
	Namespace: zombie_utility
	Checksum: 0xA3A7231D
	Offset: 0x17A0
	Size: 0x3A
	Parameters: 0
	Flags: None
*/
function getnodetype()
{
	mynode = getclaimednode();
	if(isdefined(mynode))
	{
		return mynode.type;
	}
	return "none";
}

/*
	Name: getnodedirection
	Namespace: zombie_utility
	Checksum: 0xF49FC2C2
	Offset: 0x17E8
	Size: 0x42
	Parameters: 0
	Flags: None
*/
function getnodedirection()
{
	mynode = getclaimednode();
	if(isdefined(mynode))
	{
		return mynode.angles[1];
	}
	return self.desiredangle;
}

/*
	Name: getnodeforward
	Namespace: zombie_utility
	Checksum: 0x299053DC
	Offset: 0x1838
	Size: 0x5A
	Parameters: 0
	Flags: None
*/
function getnodeforward()
{
	mynode = getclaimednode();
	if(isdefined(mynode))
	{
		return anglestoforward(mynode.angles);
	}
	return anglestoforward(self.angles);
}

/*
	Name: getnodeorigin
	Namespace: zombie_utility
	Checksum: 0x7DA5EE10
	Offset: 0x18A0
	Size: 0x3A
	Parameters: 0
	Flags: None
*/
function getnodeorigin()
{
	mynode = getclaimednode();
	if(isdefined(mynode))
	{
		return mynode.origin;
	}
	return self.origin;
}

/*
	Name: safemod
	Namespace: zombie_utility
	Checksum: 0xE9C63C78
	Offset: 0x18E8
	Size: 0x54
	Parameters: 2
	Flags: None
*/
function safemod(a, b)
{
	result = int(a) % b;
	result = result + b;
	return result % b;
}

/*
	Name: angleclamp
	Namespace: zombie_utility
	Checksum: 0x4F8741E
	Offset: 0x1948
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function angleclamp(angle)
{
	anglefrac = angle / 360;
	angle = anglefrac - floor(anglefrac) * 360;
	return angle;
}

/*
	Name: quadrantanimweights
	Namespace: zombie_utility
	Checksum: 0x6B2594F5
	Offset: 0x19A0
	Size: 0x2A6
	Parameters: 1
	Flags: None
*/
function quadrantanimweights(yaw)
{
	forwardweight = 90 - abs(yaw) / 90;
	leftweight = 90 - absangleclamp180(abs(yaw - 90)) / 90;
	result[#"front"] = 0;
	result[#"right"] = 0;
	result[#"back"] = 0;
	result[#"left"] = 0;
	if(isdefined(self.alwaysrunforward))
	{
		/#
			assert(self.alwaysrunforward);
		#/
		result[#"front"] = 1;
		return result;
	}
	useleans = getdvarint(#"ai_useleanrunanimations", 0);
	if(forwardweight > 0)
	{
		result[#"front"] = forwardweight;
		if(leftweight > 0)
		{
			result[#"left"] = leftweight;
		}
		else
		{
			result[#"right"] = -1 * leftweight;
		}
	}
	else if(useleans)
	{
		result[#"back"] = -1 * forwardweight;
		if(leftweight > 0)
		{
			result[#"left"] = leftweight;
		}
		else
		{
			result[#"right"] = -1 * leftweight;
		}
	}
	else
	{
		backweight = -1 * forwardweight;
		if(leftweight > backweight)
		{
			result[#"left"] = 1;
		}
		else if(leftweight < forwardweight)
		{
			result[#"right"] = 1;
		}
		else
		{
			result[#"back"] = 1;
		}
	}
	return result;
}

/*
	Name: getquadrant
	Namespace: zombie_utility
	Checksum: 0x6931B7D1
	Offset: 0x1C50
	Size: 0xA2
	Parameters: 1
	Flags: None
*/
function getquadrant(angle)
{
	angle = angleclamp(angle);
	if(angle < 45 || angle > 315)
	{
		quadrant = "front";
	}
	else if(angle < 135)
	{
		quadrant = "left";
	}
	else if(angle < 225)
	{
		quadrant = "back";
	}
	else
	{
		quadrant = "right";
	}
	return quadrant;
}

/*
	Name: isinset
	Namespace: zombie_utility
	Checksum: 0x33DB9A21
	Offset: 0x1D00
	Size: 0x5E
	Parameters: 2
	Flags: None
*/
function isinset(input, set)
{
	for(i = set.size - 1; i >= 0; i--)
	{
		if(input == set[i])
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: notifyaftertime
	Namespace: zombie_utility
	Checksum: 0x13A4988C
	Offset: 0x1D68
	Size: 0x3E
	Parameters: 3
	Flags: None
*/
function notifyaftertime(notifystring, killmestring, time)
{
	self endon(#"death", killmestring);
	wait(time);
	self notify(notifystring);
}

/*
	Name: drawstringtime
	Namespace: zombie_utility
	Checksum: 0xC488C013
	Offset: 0x1DB0
	Size: 0x8C
	Parameters: 4
	Flags: None
*/
function drawstringtime(msg, org, color, timer)
{
	/#
		maxtime = timer * 20;
		for(i = 0; i < maxtime; i++)
		{
			print3d(org, msg, color, 1, 1);
			waitframe(1);
		}
	#/
}

/*
	Name: showlastenemysightpos
	Namespace: zombie_utility
	Checksum: 0x8B11C985
	Offset: 0x1E48
	Size: 0x118
	Parameters: 1
	Flags: None
*/
function showlastenemysightpos(string)
{
	/#
		self notify(#"hash_5c1ef88eda405ba4");
		self endon(#"hash_5c1ef88eda405ba4", #"death");
		if(!isvalidenemy(self.enemy))
		{
			return;
		}
		if(self.enemy.team == #"allies")
		{
			color = (0.4, 0.7, 1);
		}
		else
		{
			color = (1, 0.7, 0.4);
		}
		while(true)
		{
			waitframe(1);
			if(!isdefined(self.lastenemysightpos))
			{
				continue;
			}
			print3d(self.lastenemysightpos, string, color, 1, 2.15);
		}
	#/
}

/*
	Name: debugtimeout
	Namespace: zombie_utility
	Checksum: 0x48C46BE1
	Offset: 0x1F68
	Size: 0x1E
	Parameters: 0
	Flags: None
*/
function debugtimeout()
{
	wait(5);
	self notify(#"timeout");
}

/*
	Name: debugposinternal
	Namespace: zombie_utility
	Checksum: 0x1CFCF04E
	Offset: 0x1F90
	Size: 0x138
	Parameters: 3
	Flags: Linked
*/
function debugposinternal(org, string, size)
{
	/#
		self endon(#"death");
		self notify("" + org);
		self endon("" + org);
		ent = spawnstruct();
		ent thread debugtimeout();
		ent endon(#"timeout");
		if(self.enemy.team == #"allies")
		{
			color = (0.4, 0.7, 1);
		}
		else
		{
			color = (1, 0.7, 0.4);
		}
		while(true)
		{
			waitframe(1);
			print3d(org, string, color, 1, size);
		}
	#/
}

/*
	Name: debugpos
	Namespace: zombie_utility
	Checksum: 0x4517DA08
	Offset: 0x20D0
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function debugpos(org, string)
{
	thread debugposinternal(org, string, 2.15);
}

/*
	Name: debugpossize
	Namespace: zombie_utility
	Checksum: 0xC24B2A63
	Offset: 0x2110
	Size: 0x3C
	Parameters: 3
	Flags: None
*/
function debugpossize(org, string, size)
{
	thread debugposinternal(org, string, size);
}

/*
	Name: showdebugproc
	Namespace: zombie_utility
	Checksum: 0xAB999120
	Offset: 0x2158
	Size: 0x9E
	Parameters: 4
	Flags: Linked
*/
function showdebugproc(frompoint, topoint, color, printtime)
{
	/#
		self endon(#"death");
		timer = printtime * 20;
		i = 0;
		while(i < timer)
		{
			waitframe(1);
			line(frompoint, topoint, color);
			i = i + 1;
		}
	#/
}

/*
	Name: showdebugline
	Namespace: zombie_utility
	Checksum: 0x134D1AA9
	Offset: 0x2200
	Size: 0x54
	Parameters: 4
	Flags: None
*/
function showdebugline(frompoint, topoint, color, printtime)
{
	self thread showdebugproc(frompoint, topoint + vectorscale((0, 0, -1), 5), color, printtime);
}

/*
	Name: getnodeoffset
	Namespace: zombie_utility
	Checksum: 0x340B10BC
	Offset: 0x2260
	Size: 0x336
	Parameters: 1
	Flags: None
*/
function getnodeoffset(node)
{
	if(isdefined(node.offset))
	{
		return node.offset;
	}
	cover_left_crouch_offset = (-26, 0.4, 36);
	cover_left_stand_offset = (-32, 7, 63);
	cover_right_crouch_offset = (43.5, 11, 36);
	cover_right_stand_offset = (36, 8.3, 63);
	cover_crouch_offset = (3.5, -12.5, 45);
	cover_stand_offset = (-3.7, -22, 63);
	cornernode = 0;
	nodeoffset = (0, 0, 0);
	right = anglestoright(node.angles);
	forward = anglestoforward(node.angles);
	switch(node.type)
	{
		case "hash_4767a02d3b3b87cc":
		case "hash_63cbb4767da2a801":
		{
			if(node isnodedontstand() && !node isnodedontcrouch())
			{
				nodeoffset = calculatenodeoffset(right, forward, cover_left_crouch_offset);
			}
			else
			{
				nodeoffset = calculatenodeoffset(right, forward, cover_left_stand_offset);
			}
			break;
		}
		case "hash_2a7b1ca393696762":
		case "hash_3aeea178f890eb31":
		{
			if(node isnodedontstand() && !node isnodedontcrouch())
			{
				nodeoffset = calculatenodeoffset(right, forward, cover_right_crouch_offset);
			}
			else
			{
				nodeoffset = calculatenodeoffset(right, forward, cover_right_stand_offset);
			}
			break;
		}
		case "hash_1bb444d857814e92":
		case "turret":
		case "hash_581529fff05853f0":
		{
			nodeoffset = calculatenodeoffset(right, forward, cover_stand_offset);
			break;
		}
		case "hash_171465527444ed14":
		case "hash_280d1247a6abdbae":
		case "hash_6d8019ab9d39bf96":
		{
			nodeoffset = calculatenodeoffset(right, forward, cover_crouch_offset);
			break;
		}
	}
	node.offset = nodeoffset;
	return node.offset;
}

/*
	Name: calculatenodeoffset
	Namespace: zombie_utility
	Checksum: 0xE6F08681
	Offset: 0x25A0
	Size: 0x4E
	Parameters: 3
	Flags: Linked
*/
function calculatenodeoffset(right, forward, baseoffset)
{
	return vectorscale(right, baseoffset[0]) + vectorscale(forward, baseoffset[1]) + (0, 0, baseoffset[2]);
}

/*
	Name: checkpitchvisibility
	Namespace: zombie_utility
	Checksum: 0x62B44CE9
	Offset: 0x25F8
	Size: 0xF0
	Parameters: 3
	Flags: None
*/
function checkpitchvisibility(frompoint, topoint, atnode)
{
	pitch = angleclamp180(vectortoangles(topoint - frompoint)[0]);
	if(abs(pitch) > 45)
	{
		if(isdefined(atnode) && atnode.type != #"hash_6d8019ab9d39bf96" && atnode.type != #"hash_171465527444ed14")
		{
			return 0;
		}
		if(pitch > 45 || pitch < anim.covercrouchleanpitch - 45)
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: showlines
	Namespace: zombie_utility
	Checksum: 0x8424205
	Offset: 0x26F0
	Size: 0x76
	Parameters: 3
	Flags: None
*/
function showlines(start, end, end2)
{
	/#
		for(;;)
		{
			line(start, end, (1, 0, 0), 1);
			waitframe(1);
			line(start, end2, (0, 0, 1), 1);
			waitframe(1);
		}
	#/
}

/*
	Name: anim_array
	Namespace: zombie_utility
	Checksum: 0xB3CA883
	Offset: 0x2770
	Size: 0x16C
	Parameters: 2
	Flags: None
*/
function anim_array(animarray, animweights)
{
	total_anims = animarray.size;
	idleanim = randomint(total_anims);
	/#
		assert(total_anims);
	#/
	/#
		assert(animarray.size == animweights.size);
	#/
	if(total_anims == 1)
	{
		return animarray[0];
	}
	weights = 0;
	total_weight = 0;
	for(i = 0; i < total_anims; i++)
	{
		total_weight = total_weight + animweights[i];
	}
	anim_play = randomfloat(total_weight);
	current_weight = 0;
	for(i = 0; i < total_anims; i++)
	{
		current_weight = current_weight + animweights[i];
		if(anim_play >= current_weight)
		{
			continue;
		}
		idleanim = i;
		break;
	}
	return animarray[idleanim];
}

/*
	Name: notforcedcover
	Namespace: zombie_utility
	Checksum: 0xEFD62B16
	Offset: 0x28E8
	Size: 0x3A
	Parameters: 0
	Flags: None
*/
function notforcedcover()
{
	return self.a.forced_cover == "none" || self.a.forced_cover == "Show";
}

/*
	Name: forcedcover
	Namespace: zombie_utility
	Checksum: 0x4F3E194C
	Offset: 0x2930
	Size: 0x36
	Parameters: 1
	Flags: None
*/
function forcedcover(msg)
{
	return isdefined(self.a.forced_cover) && self.a.forced_cover == msg;
}

/*
	Name: print3dtime
	Namespace: zombie_utility
	Checksum: 0xC0309EC4
	Offset: 0x2970
	Size: 0x9C
	Parameters: 6
	Flags: None
*/
function print3dtime(timer, org, msg, color, alpha, scale)
{
	/#
		newtime = timer / 0.05;
		for(i = 0; i < newtime; i++)
		{
			print3d(org, msg, color, alpha, scale);
			waitframe(1);
		}
	#/
}

/*
	Name: print3drise
	Namespace: zombie_utility
	Checksum: 0xFC930E2
	Offset: 0x2A18
	Size: 0xC4
	Parameters: 5
	Flags: None
*/
function print3drise(org, msg, color, alpha, scale)
{
	/#
		newtime = 100;
		up = 0;
		org = org;
		for(i = 0; i < newtime; i++)
		{
			up = up + 0.5;
			print3d(org + (0, 0, up), msg, color, alpha, scale);
			waitframe(1);
		}
	#/
}

/*
	Name: crossproduct
	Namespace: zombie_utility
	Checksum: 0x9024E7C6
	Offset: 0x2AE8
	Size: 0x42
	Parameters: 2
	Flags: None
*/
function crossproduct(vec1, vec2)
{
	return vec1[0] * vec2[1] - vec1[1] * vec2[0] > 0;
}

/*
	Name: scriptchange
	Namespace: zombie_utility
	Checksum: 0x7FB415C1
	Offset: 0x2B38
	Size: 0x2A
	Parameters: 0
	Flags: Linked
*/
function scriptchange()
{
	self.a.current_script = "none";
	self notify(anim.scriptchange);
}

/*
	Name: delayedscriptchange
	Namespace: zombie_utility
	Checksum: 0x99A5BA97
	Offset: 0x2B70
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function delayedscriptchange()
{
	waitframe(1);
	scriptchange();
}

/*
	Name: sawenemymove
	Namespace: zombie_utility
	Checksum: 0x3C610EAC
	Offset: 0x2B98
	Size: 0x2E
	Parameters: 1
	Flags: None
*/
function sawenemymove(timer = 500)
{
	return gettime() - self.personalsighttime < timer;
}

/*
	Name: canthrowgrenade
	Namespace: zombie_utility
	Checksum: 0xE1D4F43F
	Offset: 0x2BD0
	Size: 0x3A
	Parameters: 0
	Flags: None
*/
function canthrowgrenade()
{
	if(!self.grenadeammo)
	{
		return 0;
	}
	if(self.script_forcegrenade)
	{
		return 1;
	}
	return isplayer(self.enemy);
}

/*
	Name: random_weight
	Namespace: zombie_utility
	Checksum: 0x97E78B40
	Offset: 0x2C18
	Size: 0xFA
	Parameters: 1
	Flags: None
*/
function random_weight(array)
{
	idleanim = randomint(array.size);
	if(array.size > 1)
	{
		anim_weight = 0;
		for(i = 0; i < array.size; i++)
		{
			anim_weight = anim_weight + array[i];
		}
		anim_play = randomfloat(anim_weight);
		anim_weight = 0;
		for(i = 0; i < array.size; i++)
		{
			anim_weight = anim_weight + array[i];
			if(anim_play < anim_weight)
			{
				idleanim = i;
				break;
			}
		}
	}
	return idleanim;
}

/*
	Name: setfootstepeffect
	Namespace: zombie_utility
	Checksum: 0xB31CC30B
	Offset: 0x2D20
	Size: 0xC6
	Parameters: 2
	Flags: Linked
*/
function setfootstepeffect(name, fx)
{
	/#
		assert(isdefined(name), "");
	#/
	/#
		assert(isdefined(fx), "");
	#/
	if(!isdefined(anim.optionalstepeffects))
	{
		anim.optionalstepeffects = [];
	}
	anim.optionalstepeffects[anim.optionalstepeffects.size] = name;
	level._effect["step_" + name] = fx;
	anim.optionalstepeffectfunction = &zombie_shared::playfootstepeffect;
}

/*
	Name: persistentdebugline
	Namespace: zombie_utility
	Checksum: 0xC28342FE
	Offset: 0x2DF0
	Size: 0x8E
	Parameters: 2
	Flags: None
*/
function persistentdebugline(start, end)
{
	/#
		self endon(#"death");
		level notify(#"newdebugline");
		level endon(#"newdebugline");
		for(;;)
		{
			line(start, end, (0.3, 1, 0), 1);
			waitframe(1);
		}
	#/
}

/*
	Name: isnodedontstand
	Namespace: zombie_utility
	Checksum: 0x25256810
	Offset: 0x2E88
	Size: 0x16
	Parameters: 0
	Flags: Linked
*/
function isnodedontstand()
{
	return self.spawnflags & 4 == 4;
}

/*
	Name: isnodedontcrouch
	Namespace: zombie_utility
	Checksum: 0x107D39B7
	Offset: 0x2EA8
	Size: 0x16
	Parameters: 0
	Flags: Linked
*/
function isnodedontcrouch()
{
	return self.spawnflags & 8 == 8;
}

/*
	Name: doesnodeallowstance
	Namespace: zombie_utility
	Checksum: 0xB47365F4
	Offset: 0x2EC8
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function doesnodeallowstance(stance)
{
	if(stance == "stand")
	{
		return !self isnodedontstand();
	}
	/#
		assert(stance == "");
	#/
	return !self isnodedontcrouch();
}

/*
	Name: animarray
	Namespace: zombie_utility
	Checksum: 0x3F62AEFB
	Offset: 0x2F48
	Size: 0xB8
	Parameters: 1
	Flags: None
*/
function animarray(animname)
{
	/#
		assert(isdefined(self.a.array));
	#/
	/#
		if(!isdefined(self.a.array[animname]))
		{
			dumpanimarray();
			/#
				assert(isdefined(self.a.array[animname]), "" + animname + "");
			#/
		}
	#/
	return self.a.array[animname];
}

/*
	Name: animarrayanyexist
	Namespace: zombie_utility
	Checksum: 0x99276EBA
	Offset: 0x3008
	Size: 0xBE
	Parameters: 1
	Flags: None
*/
function animarrayanyexist(animname)
{
	/#
		assert(isdefined(self.a.array));
	#/
	/#
		if(!isdefined(self.a.array[animname]))
		{
			dumpanimarray();
			/#
				assert(isdefined(self.a.array[animname]), "" + animname + "");
			#/
		}
	#/
	return self.a.array[animname].size > 0;
}

/*
	Name: animarraypickrandom
	Namespace: zombie_utility
	Checksum: 0xB050849D
	Offset: 0x30D0
	Size: 0x14A
	Parameters: 1
	Flags: None
*/
function animarraypickrandom(animname)
{
	/#
		assert(isdefined(self.a.array));
	#/
	/#
		if(!isdefined(self.a.array[animname]))
		{
			dumpanimarray();
			/#
				assert(isdefined(self.a.array[animname]), "" + animname + "");
			#/
		}
	#/
	/#
		assert(self.a.array[animname].size > 0);
	#/
	if(self.a.array[animname].size > 1)
	{
		index = randomint(self.a.array[animname].size);
	}
	else
	{
		index = 0;
	}
	return self.a.array[animname][index];
}

/*
	Name: dumpanimarray
	Namespace: zombie_utility
	Checksum: 0x858E37A9
	Offset: 0x3228
	Size: 0x108
	Parameters: 0
	Flags: None
*/
function dumpanimarray()
{
	/#
		println("");
		foreach(k, v in self.a.array)
		{
			if(isarray(v))
			{
				println("" + k + "" + v.size + "");
				continue;
			}
			println("" + k + "", v);
		}
	#/
}

/*
	Name: getanimendpos
	Namespace: zombie_utility
	Checksum: 0x2911620D
	Offset: 0x3338
	Size: 0x4A
	Parameters: 1
	Flags: None
*/
function getanimendpos(theanim)
{
	movedelta = getmovedelta(theanim, 0, 1);
	return self localtoworldcoords(movedelta);
}

/*
	Name: isvalidenemy
	Namespace: zombie_utility
	Checksum: 0x3331A1AD
	Offset: 0x3390
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function isvalidenemy(enemy)
{
	if(!isdefined(enemy))
	{
		return 0;
	}
	return 1;
}

/*
	Name: damagelocationisany
	Namespace: zombie_utility
	Checksum: 0x645C7E5F
	Offset: 0x33B8
	Size: 0x21E
	Parameters: 12
	Flags: Linked
*/
function damagelocationisany(a, b, c, d, e, f, g, h, i, j, k, ovr)
{
	if(!isdefined(self.damagelocation))
	{
		return 0;
	}
	if(!isdefined(a))
	{
		return 0;
	}
	if(self.damagelocation == a)
	{
		return 1;
	}
	if(!isdefined(b))
	{
		return 0;
	}
	if(self.damagelocation == b)
	{
		return 1;
	}
	if(!isdefined(c))
	{
		return 0;
	}
	if(self.damagelocation == c)
	{
		return 1;
	}
	if(!isdefined(d))
	{
		return 0;
	}
	if(self.damagelocation == d)
	{
		return 1;
	}
	if(!isdefined(e))
	{
		return 0;
	}
	if(self.damagelocation == e)
	{
		return 1;
	}
	if(!isdefined(f))
	{
		return 0;
	}
	if(self.damagelocation == f)
	{
		return 1;
	}
	if(!isdefined(g))
	{
		return 0;
	}
	if(self.damagelocation == g)
	{
		return 1;
	}
	if(!isdefined(h))
	{
		return 0;
	}
	if(self.damagelocation == h)
	{
		return 1;
	}
	if(!isdefined(i))
	{
		return 0;
	}
	if(self.damagelocation == i)
	{
		return 1;
	}
	if(!isdefined(j))
	{
		return 0;
	}
	if(self.damagelocation == j)
	{
		return 1;
	}
	if(!isdefined(k))
	{
		return 0;
	}
	if(self.damagelocation == k)
	{
		return 1;
	}
	/#
		assert(!isdefined(ovr));
	#/
	return 0;
}

/*
	Name: ragdolldeath
	Namespace: zombie_utility
	Checksum: 0x4EBFC964
	Offset: 0x35E0
	Size: 0xFC
	Parameters: 1
	Flags: None
*/
function ragdolldeath(moveanim)
{
	self endon(#"killanimscript");
	lastorg = self.origin;
	movevec = (0, 0, 0);
	for(;;)
	{
		waitframe(1);
		force = distance(self.origin, lastorg);
		lastorg = self.origin;
		if(self.health == 1)
		{
			self.a.nodeath = 1;
			self startragdoll();
			waitframe(1);
			physicsexplosionsphere(lastorg, 600, 0, force * 0.1);
			self notify(#"killanimscript");
			return;
		}
	}
}

/*
	Name: iscqbwalking
	Namespace: zombie_utility
	Checksum: 0xD426F403
	Offset: 0x36E8
	Size: 0x18
	Parameters: 0
	Flags: None
*/
function iscqbwalking()
{
	return isdefined(self.cqbwalking) && self.cqbwalking;
}

/*
	Name: squared
	Namespace: zombie_utility
	Checksum: 0xD10EA526
	Offset: 0x3708
	Size: 0x16
	Parameters: 1
	Flags: None
*/
function squared(value)
{
	return value * value;
}

/*
	Name: randomizeidleset
	Namespace: zombie_utility
	Checksum: 0x81A09393
	Offset: 0x3728
	Size: 0x2A
	Parameters: 0
	Flags: None
*/
function randomizeidleset()
{
	self.a.idleset = randomint(2);
}

/*
	Name: getrandomintfromseed
	Namespace: zombie_utility
	Checksum: 0x7E5F1F26
	Offset: 0x3760
	Size: 0x66
	Parameters: 2
	Flags: None
*/
function getrandomintfromseed(intseed, intmax)
{
	/#
		assert(intmax > 0);
	#/
	index = intseed % anim.randominttablesize;
	return anim.randominttable[index] % intmax;
}

/*
	Name: is_banzai
	Namespace: zombie_utility
	Checksum: 0x35734AB6
	Offset: 0x37D0
	Size: 0x18
	Parameters: 0
	Flags: None
*/
function is_banzai()
{
	return isdefined(self.banzai) && self.banzai;
}

/*
	Name: is_zombie
	Namespace: zombie_utility
	Checksum: 0x931AF210
	Offset: 0x37F0
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function is_zombie()
{
	if(isdefined(self.is_zombie) && self.is_zombie)
	{
		return 1;
	}
	return 0;
}

/*
	Name: is_civilian
	Namespace: zombie_utility
	Checksum: 0x820DB20
	Offset: 0x3820
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function is_civilian()
{
	if(isdefined(self.is_civilian) && self.is_civilian)
	{
		return 1;
	}
	return 0;
}

/*
	Name: set_orient_mode
	Namespace: zombie_utility
	Checksum: 0x8BE347F8
	Offset: 0x3850
	Size: 0xE4
	Parameters: 2
	Flags: None
*/
function set_orient_mode(mode, val1)
{
	/#
		if(level.dog_debug_orient == self getentnum())
		{
			if(isdefined(val1))
			{
				println("" + mode + "" + val1 + "" + gettime());
			}
			else
			{
				println("" + mode + "" + gettime());
			}
		}
	#/
	if(isdefined(val1))
	{
		self orientmode(mode, val1);
	}
	else
	{
		self orientmode(mode);
	}
}

/*
	Name: debug_anim_print
	Namespace: zombie_utility
	Checksum: 0x3468C1DF
	Offset: 0x3940
	Size: 0xAC
	Parameters: 1
	Flags: None
*/
function debug_anim_print(text)
{
	/#
		if(isdefined(level.dog_debug_anims) && level.dog_debug_anims)
		{
			println(text + "" + gettime());
		}
		if(isdefined(level.dog_debug_anims_ent) && level.dog_debug_anims_ent == self getentnum())
		{
			println(text + "" + gettime());
		}
	#/
}

/*
	Name: debug_turn_print
	Namespace: zombie_utility
	Checksum: 0x884D5077
	Offset: 0x39F8
	Size: 0x17C
	Parameters: 2
	Flags: None
*/
function debug_turn_print(text, line)
{
	/#
		if(isdefined(level.dog_debug_turns) && level.dog_debug_turns == self getentnum())
		{
			duration = 200;
			currentyawcolor = (1, 1, 1);
			lookaheadyawcolor = (1, 0, 0);
			desiredyawcolor = (1, 1, 0);
			currentyaw = angleclamp180(self.angles[1]);
			desiredyaw = angleclamp180(self.desiredangle);
			lookaheaddir = self.lookaheaddir;
			lookaheadangles = vectortoangles(lookaheaddir);
			lookaheadyaw = angleclamp180(lookaheadangles[1]);
			println(text + "" + gettime() + "" + currentyaw + "" + lookaheadyaw + "" + desiredyaw);
		}
	#/
}

/*
	Name: set_zombie_var
	Namespace: zombie_utility
	Checksum: 0x6B2599AF
	Offset: 0x3B80
	Size: 0x146
	Parameters: 5
	Flags: Linked
*/
function set_zombie_var(zvar, value, is_float = 0, column = 1, is_team_based = 0)
{
	if(!isdefined(level.zombie_vars))
	{
		level.zombie_vars = [];
	}
	if(is_team_based)
	{
		foreach(team, _ in level.teams)
		{
			if(!isdefined(level.zombie_vars[team]))
			{
				level.zombie_vars[team] = [];
			}
			level.zombie_vars[team][zvar] = value;
		}
	}
	else
	{
		level.zombie_vars[zvar] = value;
	}
	return value;
}

/*
	Name: function_c7ab6cbc
	Namespace: zombie_utility
	Checksum: 0xA8F511C7
	Offset: 0x3CD0
	Size: 0x84
	Parameters: 3
	Flags: Linked
*/
function function_c7ab6cbc(zvar, team, value)
{
	if(!isdefined(level.zombie_vars))
	{
		level.zombie_vars = [];
	}
	if(!isdefined(level.zombie_vars[team]))
	{
		level.zombie_vars[team] = [];
	}
	level.zombie_vars[team][zvar] = value;
	return value;
}

/*
	Name: function_d2dfacfd
	Namespace: zombie_utility
	Checksum: 0xC8D8E171
	Offset: 0x3D60
	Size: 0x38
	Parameters: 1
	Flags: Linked
*/
function function_d2dfacfd(zvar)
{
	if(!isdefined(level.zombie_vars))
	{
		level.zombie_vars = [];
	}
	return level.zombie_vars[zvar];
}

/*
	Name: function_6403cf83
	Namespace: zombie_utility
	Checksum: 0x70AF86FD
	Offset: 0x3DA0
	Size: 0x40
	Parameters: 2
	Flags: Linked
*/
function function_6403cf83(zvar, team)
{
	if(isdefined(level.zombie_vars[team]))
	{
		return level.zombie_vars[team][zvar];
	}
}

/*
	Name: function_826f5e98
	Namespace: zombie_utility
	Checksum: 0x8AA26706
	Offset: 0x3DE8
	Size: 0x6E
	Parameters: 2
	Flags: Linked
*/
function function_826f5e98(zvar, value)
{
	/#
		assert(isplayer(self), "");
	#/
	if(!isdefined(self.zombie_vars))
	{
		self.zombie_vars = [];
	}
	self.zombie_vars[zvar] = value;
}

/*
	Name: function_73061b82
	Namespace: zombie_utility
	Checksum: 0x8A777C3E
	Offset: 0x3E60
	Size: 0x60
	Parameters: 1
	Flags: Linked
*/
function function_73061b82(zvar)
{
	/#
		assert(isplayer(self), "");
	#/
	if(!isdefined(self.zombie_vars))
	{
		self.zombie_vars = [];
	}
	return self.zombie_vars[zvar];
}

/*
	Name: spawn_zombie
	Namespace: zombie_utility
	Checksum: 0x9E1CFAA9
	Offset: 0x3EC8
	Size: 0x2FE
	Parameters: 4
	Flags: Linked
*/
function spawn_zombie(spawner, target_name, spawn_point, round_number)
{
	if(!isdefined(spawner))
	{
		/#
			println("");
		#/
		return undefined;
	}
	while(getfreeactorcount() < 1)
	{
		waitframe(1);
	}
	spawner.script_moveoverride = 1;
	if(isdefined(spawner.script_forcespawn) && spawner.script_forcespawn)
	{
		if(isactorspawner(spawner) && isdefined(level.overridezombiespawn))
		{
			guy = [[level.overridezombiespawn]]();
		}
		else
		{
			guy = spawner spawnfromspawner(0, 1);
		}
		if(!zombie_spawn_failed(guy))
		{
			if(isdefined(level.giveextrazombies))
			{
				guy [[level.giveextrazombies]]();
			}
			guy enableaimassist();
			if(isdefined(round_number))
			{
				guy._starting_round_number = round_number;
			}
			if(isdefined(level.zombie_team))
			{
				guy.team = level.zombie_team;
			}
			if(isactor(guy))
			{
				guy clearentityowner();
			}
			level.zombiemeleeplayercounter = 0;
			if(isactor(guy))
			{
				guy forceteleport(spawner.origin);
			}
			guy show();
			spawner.count = 666;
			if(isdefined(target_name))
			{
				guy.targetname = target_name;
			}
			if(isdefined(spawn_point) && isdefined(level.move_spawn_func))
			{
				guy thread [[level.move_spawn_func]](spawn_point);
			}
			/#
				if(isdefined(spawner.zm_variant_type))
				{
					guy.variant_type = spawner.zm_variant_type;
				}
			#/
			return guy;
		}
		/#
			println("", spawner.origin);
		#/
		return undefined;
	}
	/#
		println("", spawner.origin);
	#/
	return undefined;
}

/*
	Name: zombie_spawn_failed
	Namespace: zombie_utility
	Checksum: 0x62320A6E
	Offset: 0x41D8
	Size: 0x4E
	Parameters: 1
	Flags: Linked
*/
function zombie_spawn_failed(spawn)
{
	if(isdefined(spawn) && isalive(spawn))
	{
		if(isalive(spawn))
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: get_desired_origin
	Namespace: zombie_utility
	Checksum: 0x683E2839
	Offset: 0x4230
	Size: 0xDA
	Parameters: 0
	Flags: Linked
*/
function get_desired_origin()
{
	if(isdefined(self.target))
	{
		ent = getent(self.target, "targetname");
		if(!isdefined(ent))
		{
			ent = struct::get(self.target, "targetname");
		}
		if(!isdefined(ent))
		{
			ent = getnode(self.target, "targetname");
		}
		/#
			assert(isdefined(ent), "" + self.target + "" + self.origin);
		#/
		return ent.origin;
	}
	return undefined;
}

/*
	Name: hide_pop
	Namespace: zombie_utility
	Checksum: 0xEB79115B
	Offset: 0x4318
	Size: 0x7A
	Parameters: 0
	Flags: Linked
*/
function hide_pop()
{
	self endon(#"death");
	self ghost();
	wait(0.5);
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
	Name: handle_rise_notetracks
	Namespace: zombie_utility
	Checksum: 0x168FF59C
	Offset: 0x43A0
	Size: 0x2C
	Parameters: 2
	Flags: Linked
*/
function handle_rise_notetracks(note, spot)
{
	self thread finish_rise_notetracks(note, spot);
}

/*
	Name: finish_rise_notetracks
	Namespace: zombie_utility
	Checksum: 0xAD98B727
	Offset: 0x43D8
	Size: 0x70
	Parameters: 2
	Flags: Linked
*/
function finish_rise_notetracks(note, spot)
{
	if(note == "deathout" || note == "deathhigh")
	{
		self.zombie_rise_death_out = 1;
		self notify(#"zombie_rise_death_out");
		wait(2);
		spot notify(#"stop_zombie_rise_fx");
	}
}

/*
	Name: zombie_rise_death
	Namespace: zombie_utility
	Checksum: 0xCA1C2D0F
	Offset: 0x4450
	Size: 0xF4
	Parameters: 2
	Flags: Linked
*/
function zombie_rise_death(zombie, spot)
{
	zombie.zombie_rise_death_out = 0;
	zombie endon(#"rise_anim_finished", #"death");
	while(isdefined(zombie) && isdefined(zombie.health) && zombie.health > 1)
	{
		zombie waittill(#"damage");
	}
	if(isdefined(spot))
	{
		spot notify(#"stop_zombie_rise_fx");
	}
	if(isdefined(zombie))
	{
		zombie.deathanim = zombie get_rise_death_anim();
		zombie stopanimscripted();
	}
}

/*
	Name: get_rise_death_anim
	Namespace: zombie_utility
	Checksum: 0x6AA626E6
	Offset: 0x4550
	Size: 0x3A
	Parameters: 0
	Flags: Linked
*/
function get_rise_death_anim()
{
	if(self.zombie_rise_death_out)
	{
		return "zm_rise_death_out";
	}
	self.noragdoll = 1;
	self.nodeathragdoll = 1;
	return "zm_rise_death_in";
}

/*
	Name: reset_attack_spot
	Namespace: zombie_utility
	Checksum: 0xC4854895
	Offset: 0x4598
	Size: 0x62
	Parameters: 0
	Flags: Linked
*/
function reset_attack_spot()
{
	if(isdefined(self.attacking_node))
	{
		node = self.attacking_node;
		index = self.attacking_spot_index;
		node.attack_spots_taken[index] = 0;
		self.attacking_node = undefined;
		self.attacking_spot_index = undefined;
		self.attacking_spot = undefined;
	}
}

/*
	Name: zombie_gut_explosion
	Namespace: zombie_utility
	Checksum: 0x659B0179
	Offset: 0x4608
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function zombie_gut_explosion()
{
	self.guts_explosion = 1;
	gibserverutils::annihilate(self);
}

/*
	Name: delayed_zombie_eye_glow
	Namespace: zombie_utility
	Checksum: 0xDFC4DAD3
	Offset: 0x4638
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function delayed_zombie_eye_glow()
{
	self endon(#"zombie_delete", #"death");
	self endon(#"death");
	if(isdefined(self.in_the_ground) && self.in_the_ground || (isdefined(self.in_the_ceiling) && self.in_the_ceiling))
	{
		while(!isdefined(self.create_eyes))
		{
			wait(0.1);
		}
	}
	else
	{
		wait(0.5);
	}
	self zombie_eye_glow();
}

/*
	Name: zombie_eye_glow
	Namespace: zombie_utility
	Checksum: 0xCF072A7
	Offset: 0x46E8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function zombie_eye_glow()
{
	if(!isdefined(self) || !isactor(self))
	{
		return;
	}
	if(!(isdefined(self.no_eye_glow) && self.no_eye_glow))
	{
		self clientfield::set("zombie_eye_glow", 1);
	}
}

/*
	Name: zombie_eye_glow_stop
	Namespace: zombie_utility
	Checksum: 0xFBFD7A67
	Offset: 0x4758
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function zombie_eye_glow_stop()
{
	if(!isdefined(self) || !isactor(self))
	{
		return;
	}
	if(!(isdefined(self.no_eye_glow) && self.no_eye_glow))
	{
		self clientfield::set("zombie_eye_glow", 0);
	}
}

/*
	Name: round_spawn_failsafe_debug_draw
	Namespace: zombie_utility
	Checksum: 0x2631527A
	Offset: 0x47C8
	Size: 0x132
	Parameters: 0
	Flags: Linked
*/
function round_spawn_failsafe_debug_draw()
{
	self notify("26c0d7279ed843c6");
	self endon("26c0d7279ed843c6");
	self endon(#"death");
	prevorigin = self.origin;
	while(true)
	{
		if(isdefined(level.toggle_keyline_always) && level.toggle_keyline_always)
		{
			self clientfield::set("zombie_keyline_render", 1);
			wait(1);
			continue;
		}
		wait(4);
		if(isdefined(self.lastchunk_destroy_time))
		{
			if(gettime() - self.lastchunk_destroy_time < 8000)
			{
				continue;
			}
		}
		if(distancesquared(self.origin, prevorigin) < 576)
		{
			self clientfield::set("zombie_keyline_render", 1);
		}
		else
		{
			self clientfield::set("zombie_keyline_render", 0);
		}
		prevorigin = self.origin;
	}
}

/*
	Name: round_spawn_failsafe
	Namespace: zombie_utility
	Checksum: 0x13F42D14
	Offset: 0x4908
	Size: 0x4B6
	Parameters: 0
	Flags: Linked
*/
function round_spawn_failsafe()
{
	self notify("683ec951fbae35ee");
	self endon("683ec951fbae35ee");
	self endon(#"death");
	if(isdefined(level.debug_keyline_zombies) && level.debug_keyline_zombies)
	{
		self thread round_spawn_failsafe_debug_draw();
	}
	v_prev_origin = self.origin;
	while(true)
	{
		if(!function_d2dfacfd(#"zombie_use_failsafe"))
		{
			return;
		}
		if(isdefined(self.ignore_round_spawn_failsafe) && self.ignore_round_spawn_failsafe)
		{
			return;
		}
		if(!isdefined(level.failsafe_waittime))
		{
			level.failsafe_waittime = 30;
		}
		wait(level.failsafe_waittime);
		if(isdefined(self.missinglegs) && self.missinglegs)
		{
			wait(10);
		}
		if(isdefined(self.is_inert) && self.is_inert)
		{
			continue;
		}
		if(isdefined(self.lastchunk_destroy_time) && gettime() - self.lastchunk_destroy_time < 8000)
		{
			continue;
		}
		if(self.origin[2] < function_d2dfacfd(#"below_world_check"))
		{
			if(isdefined(level.var_455393ef))
			{
				self thread [[level.var_455393ef]](v_prev_origin);
			}
			else if(isdefined(level.put_timed_out_zombies_back_in_queue) && level.put_timed_out_zombies_back_in_queue && (!(isdefined(self.isscreecher) && self.isscreecher)))
			{
				level.zombie_total++;
				level.zombie_total_subtract++;
			}
			self.var_e700d5e2 = 1;
			self dodamage(self.health + 100, (0, 0, 0));
			break;
		}
		var_25e376fd = 0;
		if(isdefined(level.var_62fc4786))
		{
			var_25e376fd = self [[level.var_62fc4786]](v_prev_origin);
		}
		else if(distancesquared(self.origin, v_prev_origin) < 576)
		{
			var_25e376fd = 1;
		}
		if(var_25e376fd)
		{
			if(isdefined(level.var_455393ef))
			{
				self thread [[level.var_455393ef]](v_prev_origin);
			}
			else if(isdefined(level.put_timed_out_zombies_back_in_queue) && level.put_timed_out_zombies_back_in_queue)
			{
				if(!(isdefined(self.nuked) && self.nuked) && (!(isdefined(self.marked_for_death) && self.marked_for_death)) && (!(isdefined(self.isscreecher) && self.isscreecher)) && (!(isdefined(self.missinglegs) && self.missinglegs)))
				{
					level.zombie_total++;
					level.zombie_total_subtract++;
					var_1a8c05ae = {#hash_e0d660f6:self.var_e0d660f6, #n_health:self.health};
					if(!isdefined(level.var_fc73bad4[self.archetype]))
					{
						level.var_fc73bad4[self.archetype] = [];
					}
					else if(!isarray(level.var_fc73bad4[self.archetype]))
					{
						level.var_fc73bad4[self.archetype] = array(level.var_fc73bad4[self.archetype]);
					}
					level.var_fc73bad4[self.archetype][level.var_fc73bad4[self.archetype].size] = var_1a8c05ae;
				}
			}
			level.zombies_timeout_playspace++;
			self.var_e700d5e2 = 1;
			self dodamage(self.health + 100, (0, 0, 0));
			break;
		}
		v_prev_origin = self.origin;
	}
}

/*
	Name: ai_calculate_health
	Namespace: zombie_utility
	Checksum: 0xE8E346D7
	Offset: 0x4DC8
	Size: 0x1B4
	Parameters: 2
	Flags: Linked
*/
function ai_calculate_health(var_88f4c6ec, round_number)
{
	if(isdefined(level.var_5d1805c4))
	{
		var_d082c739 = [[level.var_5d1805c4]](var_88f4c6ec, round_number);
		if(var_d082c739 >= 0)
		{
			return var_d082c739;
		}
	}
	if(util::function_5df4294() == #"zclassic" && level.gamedifficulty < 2 && round_number > 35)
	{
		round_number = 35;
	}
	var_d082c739 = var_88f4c6ec;
	for(i = 2; i <= round_number; i++)
	{
		if(i >= 10 && (!(isdefined(level.var_50dd0ec5) && level.var_50dd0ec5)))
		{
			old_health = var_d082c739;
			var_d082c739 = var_d082c739 + int(var_d082c739 * function_d2dfacfd(#"zombie_health_increase_multiplier"));
			if(var_d082c739 < old_health)
			{
				var_d082c739 = old_health;
				break;
			}
			continue;
		}
		var_d082c739 = int(var_d082c739 + function_d2dfacfd(#"zombie_health_increase"));
	}
	return var_d082c739;
}

/*
	Name: default_max_zombie_func
	Namespace: zombie_utility
	Checksum: 0x799B32ED
	Offset: 0x4F88
	Size: 0x15A
	Parameters: 2
	Flags: Linked
*/
function default_max_zombie_func(max_num, n_round)
{
	/#
		count = getdvarint(#"zombie_default_max", -1);
		if(count > -1)
		{
			return count;
		}
	#/
	max = max_num;
	if(n_round < 2)
	{
		max = int(max_num * 0.25);
	}
	else if(n_round < 3)
	{
		max = int(max_num * 0.3);
	}
	else if(n_round < 4)
	{
		max = int(max_num * 0.5);
	}
	else if(n_round < 5)
	{
		max = int(max_num * 0.7);
	}
	else if(n_round < 6)
	{
		max = int(max_num * 0.9);
	}
	return max;
}

/*
	Name: get_current_zombie_count
	Namespace: zombie_utility
	Checksum: 0x92239857
	Offset: 0x50F0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function get_current_zombie_count()
{
	enemies = get_round_enemy_array();
	return enemies.size;
}

/*
	Name: get_round_enemy_array
	Namespace: zombie_utility
	Checksum: 0xE9CA43D8
	Offset: 0x5120
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function get_round_enemy_array()
{
	a_ai_enemies = [];
	a_ai_valid_enemies = [];
	a_ai_enemies = getaiteamarray(level.zombie_team);
	for(i = 0; i < a_ai_enemies.size; i++)
	{
		if(isdefined(a_ai_enemies[i].ignore_enemy_count) && a_ai_enemies[i].ignore_enemy_count)
		{
			continue;
		}
		if(!isdefined(a_ai_valid_enemies))
		{
			a_ai_valid_enemies = [];
		}
		else if(!isarray(a_ai_valid_enemies))
		{
			a_ai_valid_enemies = array(a_ai_valid_enemies);
		}
		a_ai_valid_enemies[a_ai_valid_enemies.size] = a_ai_enemies[i];
	}
	return a_ai_valid_enemies;
}

/*
	Name: get_zombie_array
	Namespace: zombie_utility
	Checksum: 0x544AA203
	Offset: 0x5220
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function get_zombie_array()
{
	enemies = [];
	valid_enemies = [];
	enemies = getaispeciesarray(level.zombie_team, "all");
	for(i = 0; i < enemies.size; i++)
	{
		if(enemies[i].archetype === #"zombie")
		{
			if(!isdefined(valid_enemies))
			{
				valid_enemies = [];
			}
			else if(!isarray(valid_enemies))
			{
				valid_enemies = array(valid_enemies);
			}
			valid_enemies[valid_enemies.size] = enemies[i];
		}
	}
	return valid_enemies;
}

/*
	Name: set_zombie_run_cycle_override_value
	Namespace: zombie_utility
	Checksum: 0x11528FD9
	Offset: 0x5318
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function set_zombie_run_cycle_override_value(new_move_speed)
{
	set_zombie_run_cycle(new_move_speed);
	self.zombie_move_speed_override = new_move_speed;
}

/*
	Name: set_zombie_run_cycle_restore_from_override
	Namespace: zombie_utility
	Checksum: 0x198FB315
	Offset: 0x5358
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function set_zombie_run_cycle_restore_from_override()
{
	str_restore_move_speed = self.zombie_move_speed_restore;
	self.zombie_move_speed_override = undefined;
	set_zombie_run_cycle(str_restore_move_speed);
}

/*
	Name: function_d2f660ce
	Namespace: zombie_utility
	Checksum: 0x425700D
	Offset: 0x5398
	Size: 0x1E4
	Parameters: 1
	Flags: Linked
*/
function function_d2f660ce(var_a598c292)
{
	if(isdefined(self.var_b518759e) && self.var_b518759e)
	{
		return var_a598c292;
	}
	if(isdefined(level.var_43fb4347))
	{
		switch(level.var_43fb4347)
		{
			case "run":
			{
				if(var_a598c292 == "walk")
				{
					var_70b46d1c = "run";
				}
				break;
			}
			case "sprint":
			{
				if(var_a598c292 == "walk" || var_a598c292 == "run")
				{
					var_70b46d1c = "sprint";
				}
				break;
			}
			case "super_sprint":
			{
				if(var_a598c292 != "super_sprint")
				{
					var_70b46d1c = "super_sprint";
				}
				break;
			}
		}
	}
	if(isdefined(level.var_102b1301))
	{
		switch(level.var_102b1301)
		{
			case "walk":
			{
				if(var_a598c292 != "walk")
				{
					var_70b46d1c = "walk";
				}
				break;
			}
			case "run":
			{
				if(var_a598c292 == "sprint" || var_a598c292 == "super_sprint")
				{
					var_70b46d1c = "run";
				}
				break;
			}
			case "sprint":
			{
				if(var_a598c292 == "super_sprint")
				{
					var_70b46d1c = "sprint";
				}
				break;
			}
		}
	}
	if(isdefined(var_70b46d1c))
	{
		return var_70b46d1c;
	}
	return var_a598c292;
}

/*
	Name: set_zombie_run_cycle
	Namespace: zombie_utility
	Checksum: 0x105E14B7
	Offset: 0x5588
	Size: 0x2DC
	Parameters: 1
	Flags: Linked
*/
function set_zombie_run_cycle(new_move_speed)
{
	if(isdefined(self.zombie_move_speed_override))
	{
		if(!isdefined(new_move_speed))
		{
			new_move_speed = function_33da7a07();
		}
		new_move_speed = self function_d2f660ce(new_move_speed);
		self.zombie_move_speed_restore = new_move_speed;
		return;
	}
	if(isdefined(new_move_speed))
	{
		self.zombie_move_speed = new_move_speed;
	}
	else if(level.gamedifficulty == 0)
	{
		self.zombie_move_speed = function_33da7a07(1);
	}
	else
	{
		self.zombie_move_speed = function_33da7a07();
	}
	self.zombie_move_speed = self function_d2f660ce(self.zombie_move_speed);
	if(isdefined(level.zm_variant_type_max))
	{
		/#
			if(0)
			{
				debug_variant_type = getdvarint(#"scr_zombie_variant_type", -1);
				if(debug_variant_type != -1)
				{
					if(debug_variant_type <= level.zm_variant_type_max[self.zombie_move_speed][self.zombie_arms_position])
					{
						self.variant_type = debug_variant_type;
					}
					else
					{
						self.variant_type = level.zm_variant_type_max[self.zombie_move_speed][self.zombie_arms_position] - 1;
					}
				}
				else
				{
					self.variant_type = randomint(level.zm_variant_type_max[self.zombie_move_speed][self.zombie_arms_position]);
				}
			}
		#/
		if(self.archetype === #"zombie" || self.archetype === #"hash_1bab8a0ba811401e")
		{
			if(isdefined(self.zm_variant_type_max))
			{
				self.variant_type = randomint(self.zm_variant_type_max[self.zombie_move_speed][self.zombie_arms_position]);
			}
			else
			{
				self.variant_type = randomint(level.zm_variant_type_max[self.zombie_move_speed][self.zombie_arms_position]);
			}
		}
	}
	self.needs_run_update = 1;
	self notify(#"needs_run_update");
	self.deathanim = self append_missing_legs_suffix("zm_death");
	self callback::callback(#"hash_dfbeaa068b23e7c");
}

/*
	Name: function_33da7a07
	Namespace: zombie_utility
	Checksum: 0xA2930EFE
	Offset: 0x5870
	Size: 0xCA
	Parameters: 1
	Flags: Linked
*/
function function_33da7a07(var_5a886f00)
{
	if(!isdefined(self._starting_round_number))
	{
		self._starting_round_number = level.round_number;
	}
	if(self._starting_round_number == 1)
	{
		var_65f77417 = 1;
	}
	else
	{
		var_65f77417 = int(self._starting_round_number * function_d2dfacfd(#"zombie_move_speed_multiplier"));
	}
	var_750836cc = randomintrange(var_65f77417, var_65f77417 + 35);
	return function_f9c50a93(var_750836cc, var_5a886f00);
}

/*
	Name: function_f9c50a93
	Namespace: zombie_utility
	Checksum: 0xF4353143
	Offset: 0x5948
	Size: 0xA2
	Parameters: 2
	Flags: Linked
*/
function function_f9c50a93(move_speed, var_5a886f00)
{
	if(isdefined(var_5a886f00) && var_5a886f00)
	{
		if(move_speed <= 35)
		{
			return "walk";
		}
		return "run";
	}
	if(move_speed <= 35)
	{
		return "walk";
	}
	if(move_speed <= 70)
	{
		return "run";
	}
	if(move_speed <= 236)
	{
		return "sprint";
	}
	return "super_sprint";
}

/*
	Name: setup_zombie_knockdown
	Namespace: zombie_utility
	Checksum: 0xF735E031
	Offset: 0x59F8
	Size: 0x32A
	Parameters: 2
	Flags: Linked
*/
function setup_zombie_knockdown(var_5f02306b, var_43b3242)
{
	if(!isactor(self) || (isdefined(self.missinglegs) && self.missinglegs) || (isdefined(self.var_5dd07a80) && self.var_5dd07a80) || (isdefined(self.isinmantleaction) && self.isinmantleaction) || self isplayinganimscripted() || (self function_dd070839() && (!(isdefined(var_43b3242) && var_43b3242))))
	{
		return;
	}
	if(!isdefined(var_5f02306b))
	{
		return;
	}
	self.knockdown = 1;
	if(isvec(var_5f02306b))
	{
		zombie_to_entity = var_5f02306b - self.origin;
	}
	else
	{
		zombie_to_entity = var_5f02306b.origin - self.origin;
	}
	zombie_to_entity_2d = vectornormalize((zombie_to_entity[0], zombie_to_entity[1], 0));
	zombie_forward = anglestoforward(self.angles);
	zombie_forward_2d = vectornormalize((zombie_forward[0], zombie_forward[1], 0));
	zombie_right = anglestoright(self.angles);
	zombie_right_2d = vectornormalize((zombie_right[0], zombie_right[1], 0));
	dot = vectordot(zombie_to_entity_2d, zombie_forward_2d);
	if(dot >= 0.5)
	{
		self.knockdown_direction = "front";
		self.getup_direction = "getup_back";
	}
	else if(dot < 0.5 && dot > -0.5)
	{
		dot = vectordot(zombie_to_entity_2d, zombie_right_2d);
		if(dot > 0)
		{
			self.knockdown_direction = "right";
			if(math::cointoss())
			{
				self.getup_direction = "getup_back";
			}
			else
			{
				self.getup_direction = "getup_belly";
			}
		}
		else
		{
			self.knockdown_direction = "left";
			self.getup_direction = "getup_belly";
		}
	}
	else
	{
		self.knockdown_direction = "back";
		self.getup_direction = "getup_belly";
	}
}

/*
	Name: function_fc0cb93d
	Namespace: zombie_utility
	Checksum: 0x8FF8DA2
	Offset: 0x5D30
	Size: 0x10A
	Parameters: 1
	Flags: None
*/
function function_fc0cb93d(entity)
{
	self.pushed = 1;
	zombie_to_entity = entity.origin - self.origin;
	zombie_to_entity_2d = vectornormalize((zombie_to_entity[0], zombie_to_entity[1], 0));
	zombie_right = anglestoright(self.angles);
	zombie_right_2d = vectornormalize((zombie_right[0], zombie_right[1], 0));
	dot = vectordot(zombie_to_entity_2d, zombie_right_2d);
	if(dot < 0)
	{
		self.push_direction = "right";
	}
	else
	{
		self.push_direction = "left";
	}
}

/*
	Name: clear_all_corpses
	Namespace: zombie_utility
	Checksum: 0x856D5202
	Offset: 0x5E48
	Size: 0x86
	Parameters: 0
	Flags: Linked
*/
function clear_all_corpses()
{
	level notify(#"clear_all_corpses");
	corpse_array = getcorpsearray();
	for(i = 0; i < corpse_array.size; i++)
	{
		if(isdefined(corpse_array[i]))
		{
			corpse_array[i] delete();
		}
	}
}

/*
	Name: get_current_actor_count
	Namespace: zombie_utility
	Checksum: 0x7E6CA811
	Offset: 0x5ED8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function get_current_actor_count()
{
	count = 0;
	actors = getaispeciesarray(level.zombie_team, "all");
	if(isdefined(actors))
	{
		count = count + actors.size;
	}
	count = count + get_current_corpse_count();
	return count;
}

/*
	Name: get_current_corpse_count
	Namespace: zombie_utility
	Checksum: 0xB6BD9FE7
	Offset: 0x5F58
	Size: 0x30
	Parameters: 0
	Flags: Linked
*/
function get_current_corpse_count()
{
	corpse_array = getcorpsearray();
	if(isdefined(corpse_array))
	{
		return corpse_array.size;
	}
	return 0;
}

/*
	Name: zombie_gib_on_damage
	Namespace: zombie_utility
	Checksum: 0xAC895335
	Offset: 0x5F90
	Size: 0xC8
	Parameters: 0
	Flags: Linked
*/
function zombie_gib_on_damage()
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		self thread zombie_gib(waitresult.amount, waitresult.attacker, waitresult.direction, waitresult.position, waitresult.mod, waitresult.tag_name, waitresult.model_name, waitresult.part_name, waitresult.weapon);
	}
}

/*
	Name: zombie_gib
	Namespace: zombie_utility
	Checksum: 0xF68F2AFF
	Offset: 0x6060
	Size: 0x4F8
	Parameters: 9
	Flags: Linked
*/
function zombie_gib(amount, attacker, direction_vec, point, type, tagname, modelname, partname, weapon)
{
	if(!isdefined(self))
	{
		return;
	}
	if(!self zombie_should_gib(amount, attacker, type))
	{
		return;
	}
	if(self head_should_gib(attacker, type, point) && type != "MOD_BURNED")
	{
		self zombie_head_gib(attacker, type);
		return;
	}
	if(!(isdefined(self.gibbed) && self.gibbed) && isdefined(self.damagelocation))
	{
		if(self damagelocationisany("head", "helmet", "neck"))
		{
			return;
		}
		self.stumble = undefined;
		b_gibbed = 1;
		switch(self.damagelocation)
		{
			case "torso_upper":
			case "torso_lower":
			{
				if(!gibserverutils::isgibbed(self, 32))
				{
					gibserverutils::gibrightarm(self);
				}
				break;
			}
			case "right_arm_lower":
			case "right_arm_upper":
			case "right_hand":
			{
				if(!gibserverutils::isgibbed(self, 32))
				{
					gibserverutils::gibrightarm(self);
				}
				break;
			}
			case "left_arm_lower":
			case "left_arm_upper":
			case "left_hand":
			{
				if(!gibserverutils::isgibbed(self, 16))
				{
					gibserverutils::gibleftarm(self);
				}
				break;
			}
			case "right_leg_upper":
			case "left_leg_lower":
			case "right_leg_lower":
			case "left_foot":
			case "right_foot":
			case "left_leg_upper":
			{
				b_gibbed = 0;
				break;
			}
			default:
			{
				if(self.damagelocation == "none")
				{
					if(type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH")
					{
						self derive_damage_refs(point);
						break;
					}
				}
			}
		}
		if(isdefined(level.custom_derive_damage_refs))
		{
			self [[level.custom_derive_damage_refs]](point, weapon);
		}
		if(isdefined(self.missinglegs) && self.missinglegs && self.health > 0)
		{
			b_gibbed = 1;
			level notify(#"hash_5198ca6a3343ece8", {#weapon:weapon, #player:attacker, #zombie:self});
			self allowedstances("crouch");
			self setphysparams(15, 0, 24);
			self allowpitchangle(1);
			self setpitchorient();
			health = self.health;
			health = health * 0.1;
			if(isdefined(self.crawl_anim_override))
			{
				self [[self.crawl_anim_override]]();
			}
		}
		if(b_gibbed && self.health > 0)
		{
			if(isdefined(level.gib_on_damage))
			{
				self thread [[level.gib_on_damage]](attacker);
			}
		}
	}
}

/*
	Name: add_zombie_gib_weapon_callback
	Namespace: zombie_utility
	Checksum: 0xF9E13CC5
	Offset: 0x6560
	Size: 0x86
	Parameters: 3
	Flags: None
*/
function add_zombie_gib_weapon_callback(weapon_name, gib_callback, gib_head_callback)
{
	if(!isdefined(level.zombie_gib_weapons))
	{
		level.zombie_gib_weapons = [];
	}
	if(!isdefined(level.zombie_gib_head_weapons))
	{
		level.zombie_gib_head_weapons = [];
	}
	level.zombie_gib_weapons[weapon_name] = gib_callback;
	level.zombie_gib_head_weapons[weapon_name] = gib_head_callback;
}

/*
	Name: have_zombie_weapon_gib_callback
	Namespace: zombie_utility
	Checksum: 0x5136DBD2
	Offset: 0x65F0
	Size: 0x8A
	Parameters: 1
	Flags: Linked
*/
function have_zombie_weapon_gib_callback(weapon)
{
	if(!isdefined(level.zombie_gib_weapons))
	{
		level.zombie_gib_weapons = [];
	}
	if(!isdefined(level.zombie_gib_head_weapons))
	{
		level.zombie_gib_head_weapons = [];
	}
	if(isweapon(weapon))
	{
		weapon = weapon.name;
	}
	if(isdefined(level.zombie_gib_weapons[weapon]))
	{
		return 1;
	}
	return 0;
}

/*
	Name: get_zombie_weapon_gib_callback
	Namespace: zombie_utility
	Checksum: 0x5FCA28D0
	Offset: 0x6688
	Size: 0xA8
	Parameters: 2
	Flags: Linked
*/
function get_zombie_weapon_gib_callback(weapon, damage_percent)
{
	if(!isdefined(level.zombie_gib_weapons))
	{
		level.zombie_gib_weapons = [];
	}
	if(!isdefined(level.zombie_gib_head_weapons))
	{
		level.zombie_gib_head_weapons = [];
	}
	if(isweapon(weapon))
	{
		weapon = weapon.name;
	}
	if(isdefined(level.zombie_gib_weapons[weapon]))
	{
		return self [[level.zombie_gib_weapons[weapon]]](damage_percent);
	}
	return 0;
}

/*
	Name: have_zombie_weapon_gib_head_callback
	Namespace: zombie_utility
	Checksum: 0x55C27264
	Offset: 0x6738
	Size: 0x8A
	Parameters: 1
	Flags: Linked
*/
function have_zombie_weapon_gib_head_callback(weapon)
{
	if(!isdefined(level.zombie_gib_weapons))
	{
		level.zombie_gib_weapons = [];
	}
	if(!isdefined(level.zombie_gib_head_weapons))
	{
		level.zombie_gib_head_weapons = [];
	}
	if(isweapon(weapon))
	{
		weapon = weapon.name;
	}
	if(isdefined(level.zombie_gib_head_weapons[weapon]))
	{
		return 1;
	}
	return 0;
}

/*
	Name: get_zombie_weapon_gib_head_callback
	Namespace: zombie_utility
	Checksum: 0x6E1A541F
	Offset: 0x67D0
	Size: 0xA8
	Parameters: 2
	Flags: Linked
*/
function get_zombie_weapon_gib_head_callback(weapon, damage_location)
{
	if(!isdefined(level.zombie_gib_weapons))
	{
		level.zombie_gib_weapons = [];
	}
	if(!isdefined(level.zombie_gib_head_weapons))
	{
		level.zombie_gib_head_weapons = [];
	}
	if(isweapon(weapon))
	{
		weapon = weapon.name;
	}
	if(isdefined(level.zombie_gib_head_weapons[weapon]))
	{
		return self [[level.zombie_gib_head_weapons[weapon]]](damage_location);
	}
	return 0;
}

/*
	Name: zombie_should_gib
	Namespace: zombie_utility
	Checksum: 0x92182CDA
	Offset: 0x6880
	Size: 0x2D8
	Parameters: 3
	Flags: Linked
*/
function zombie_should_gib(amount, attacker, type)
{
	if(!isdefined(type))
	{
		return 0;
	}
	if(isdefined(self.is_on_fire) && self.is_on_fire)
	{
		return 0;
	}
	if(isdefined(self.no_gib) && self.no_gib == 1)
	{
		return 0;
	}
	prev_health = amount + self.health;
	if(prev_health <= 0)
	{
		prev_health = 1;
	}
	damage_percent = amount / prev_health * 100;
	weapon = undefined;
	if(isdefined(attacker))
	{
		if(isplayer(attacker) || (isdefined(attacker.can_gib_zombies) && attacker.can_gib_zombies))
		{
			if(isplayer(attacker))
			{
				weapon = attacker getcurrentweapon();
			}
			else
			{
				weapon = attacker.weapon;
			}
			if(isdefined(weapon) && (isdefined(weapon.doannihilate) && weapon.doannihilate))
			{
				return 0;
			}
			if(have_zombie_weapon_gib_callback(weapon))
			{
				if(self get_zombie_weapon_gib_callback(weapon, damage_percent))
				{
					return 1;
				}
				return 0;
			}
		}
	}
	switch(type)
	{
		case "mod_telefrag":
		case "mod_unknown":
		case "mod_burned":
		case "mod_trigger_hurt":
		case "mod_suicide":
		case "mod_falling":
		{
			return 0;
		}
		case "mod_melee":
		{
			return 0;
		}
	}
	if(type == "MOD_PISTOL_BULLET" || type == "MOD_RIFLE_BULLET")
	{
		if(!isdefined(attacker) || !isplayer(attacker))
		{
			return 0;
		}
		if(weapon == level.weaponnone || (isdefined(level.start_weapon) && weapon == level.start_weapon) || weapon.isgasweapon)
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: head_should_gib
	Namespace: zombie_utility
	Checksum: 0x41F9F33
	Offset: 0x6B60
	Size: 0x32E
	Parameters: 3
	Flags: Linked
*/
function head_should_gib(attacker, type, point)
{
	if(isdefined(self.head_gibbed) && self.head_gibbed)
	{
		return 0;
	}
	if(!isdefined(attacker) || !isplayer(attacker))
	{
		if(!(isdefined(attacker.can_gib_zombies) && attacker.can_gib_zombies))
		{
			return 0;
		}
	}
	if(isplayer(attacker))
	{
		weapon = attacker getcurrentweapon();
	}
	else
	{
		weapon = attacker.weapon;
	}
	if(have_zombie_weapon_gib_head_callback(weapon))
	{
		if(self get_zombie_weapon_gib_head_callback(weapon, self.damagelocation))
		{
			return 1;
		}
		return 0;
	}
	if(type != "MOD_RIFLE_BULLET" && type != "MOD_PISTOL_BULLET")
	{
		if(type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH")
		{
			if(distance(point, self gettagorigin("j_head")) > 55)
			{
				return 0;
			}
			return 1;
		}
		if(type == "MOD_PROJECTILE")
		{
			if(distance(point, self gettagorigin("j_head")) > 10)
			{
				return 0;
			}
			return 1;
		}
		if(weapon.weapclass != "spread")
		{
			return 0;
		}
	}
	if(!self damagelocationisany("head", "helmet", "neck"))
	{
		return 0;
	}
	if(type == "MOD_PISTOL_BULLET" && weapon.weapclass != "smg" || weapon == level.weaponnone || (isdefined(level.start_weapon) && weapon == level.start_weapon) || weapon.isgasweapon)
	{
		return 0;
	}
	if(sessionmodeiscampaigngame() && (type == "MOD_PISTOL_BULLET" && weapon.weapclass != "smg"))
	{
		return 0;
	}
	low_health_percent = self.health / self.maxhealth * 100;
	if(low_health_percent > 10)
	{
		return 0;
	}
	return 1;
}

/*
	Name: zombie_hat_gib
	Namespace: zombie_utility
	Checksum: 0x1D3E2552
	Offset: 0x6E98
	Size: 0x10C
	Parameters: 2
	Flags: None
*/
function zombie_hat_gib(attacker, means_of_death)
{
	self endon(#"death");
	if(isdefined(self.hat_gibbed) && self.hat_gibbed)
	{
		return;
	}
	if(!isdefined(self.gibspawn5) || !isdefined(self.gibspawntag5))
	{
		return;
	}
	self.hat_gibbed = 1;
	if(isdefined(self.hatmodel))
	{
		self detach(self.hatmodel, "");
	}
	temp_array = [];
	temp_array[0] = level._zombie_gib_piece_index_hat;
	self gib("normal", temp_array);
	if(isdefined(level.track_gibs))
	{
		level [[level.track_gibs]](self, temp_array);
	}
}

/*
	Name: damage_over_time
	Namespace: zombie_utility
	Checksum: 0x703046B2
	Offset: 0x6FB0
	Size: 0x160
	Parameters: 4
	Flags: Linked
*/
function damage_over_time(dmg, delay, attacker, means_of_death)
{
	self endon(#"death", #"exploding");
	self endon(#"exploding");
	if(!isalive(self))
	{
		return;
	}
	if(!isplayer(attacker))
	{
		attacker = self;
	}
	if(!isdefined(means_of_death))
	{
		means_of_death = "MOD_UNKNOWN";
	}
	while(true)
	{
		if(isdefined(delay))
		{
			wait(delay);
		}
		if(isdefined(self))
		{
			var_223fc6f5 = self gettagorigin("j_neck");
			if(!isdefined(var_223fc6f5))
			{
				var_223fc6f5 = self.origin;
			}
			if(isdefined(attacker))
			{
				self dodamage(dmg, var_223fc6f5, attacker, self, self.damagelocation, means_of_death, 4096, self.damageweapon);
			}
			else
			{
				self dodamage(dmg, var_223fc6f5);
			}
		}
	}
}

/*
	Name: derive_damage_refs
	Namespace: zombie_utility
	Checksum: 0xF1914E92
	Offset: 0x7118
	Size: 0x47C
	Parameters: 1
	Flags: Linked
*/
function derive_damage_refs(point)
{
	if(!isdefined(self))
	{
		return;
	}
	if(!isdefined(point))
	{
		return;
	}
	if(!isdefined(level.gib_tags))
	{
		init_gib_tags();
	}
	closesttag = "tag_origin";
	closestdistsq = distancesquared(point, self.origin);
	for(i = 0; i < level.gib_tags.size; i++)
	{
		tagorigin = self gettagorigin(level.gib_tags[i]);
		if(!isdefined(tagorigin))
		{
			continue;
		}
		distsq = distancesquared(point, tagorigin);
		if(distsq < closestdistsq)
		{
			closesttag = level.gib_tags[i];
			closestdistsq = distsq;
		}
	}
	if(closesttag == "J_SpineLower" || closesttag == "J_SpineUpper" || closesttag == "J_Spine4")
	{
		gibserverutils::gibrightarm(self);
	}
	else if(closesttag == "J_Shoulder_LE" || closesttag == "J_Elbow_LE" || closesttag == "J_Wrist_LE")
	{
		if(!gibserverutils::isgibbed(self, 16))
		{
			gibserverutils::gibleftarm(self);
		}
	}
	else if(closesttag == "J_Shoulder_RI" || closesttag == "J_Elbow_RI" || closesttag == "J_Wrist_RI")
	{
		if(!gibserverutils::isgibbed(self, 32))
		{
			gibserverutils::gibrightarm(self);
		}
	}
	else if(closesttag == "J_Hip_LE" || closesttag == "J_Knee_LE" || closesttag == "J_Ankle_LE")
	{
		if(isdefined(self.nocrawler) && self.nocrawler || (isdefined(level.var_41259f0d) && level.var_41259f0d) || ((isdefined(level.var_41017830) ? level.var_41017830 : 0)))
		{
			return;
		}
		gibserverutils::gibleftleg(self);
		if(randomint(100) > 75)
		{
			gibserverutils::gibrightleg(self);
		}
		self function_df5afb5e(1);
	}
	else if(closesttag == "J_Hip_RI" || closesttag == "J_Knee_RI" || closesttag == "J_Ankle_RI")
	{
		if(isdefined(self.nocrawler) && self.nocrawler || (isdefined(level.var_41259f0d) && level.var_41259f0d) || ((isdefined(level.var_41017830) ? level.var_41017830 : 0)))
		{
			return;
		}
		gibserverutils::gibrightleg(self);
		if(randomint(100) > 75)
		{
			gibserverutils::gibleftleg(self);
		}
		self function_df5afb5e(1);
	}
}

/*
	Name: init_gib_tags
	Namespace: zombie_utility
	Checksum: 0x36B695A
	Offset: 0x75A0
	Size: 0x14E
	Parameters: 0
	Flags: Linked
*/
function init_gib_tags()
{
	tags = [];
	tags[tags.size] = "J_SpineLower";
	tags[tags.size] = "J_SpineUpper";
	tags[tags.size] = "J_Spine4";
	tags[tags.size] = "J_Shoulder_LE";
	tags[tags.size] = "J_Elbow_LE";
	tags[tags.size] = "J_Wrist_LE";
	tags[tags.size] = "J_Shoulder_RI";
	tags[tags.size] = "J_Elbow_RI";
	tags[tags.size] = "J_Wrist_RI";
	tags[tags.size] = "J_Hip_LE";
	tags[tags.size] = "J_Knee_LE";
	tags[tags.size] = "J_Ankle_LE";
	tags[tags.size] = "J_Hip_RI";
	tags[tags.size] = "J_Knee_RI";
	tags[tags.size] = "J_Ankle_RI";
	level.gib_tags = tags;
}

/*
	Name: getanimdirection
	Namespace: zombie_utility
	Checksum: 0xCCD27C8C
	Offset: 0x76F8
	Size: 0x96
	Parameters: 1
	Flags: None
*/
function getanimdirection(damageyaw)
{
	if(damageyaw > 135 || damageyaw <= -135)
	{
		return "front";
	}
	if(damageyaw > 45 && damageyaw <= 135)
	{
		return "right";
	}
	if(damageyaw > -45 && damageyaw <= 45)
	{
		return "back";
	}
	return "left";
}

/*
	Name: makezombiecrawler
	Namespace: zombie_utility
	Checksum: 0x446EA489
	Offset: 0x77A0
	Size: 0x1F8
	Parameters: 1
	Flags: Linked
*/
function makezombiecrawler(b_both_legs)
{
	if(isdefined(level.var_41259f0d) && level.var_41259f0d || ((isdefined(level.var_41017830) ? level.var_41017830 : 0)))
	{
		return;
	}
	if(isdefined(b_both_legs) && b_both_legs)
	{
		val = 100;
	}
	else
	{
		val = randomint(100);
	}
	if(val > 75)
	{
		gibserverutils::gibrightleg(self);
		gibserverutils::gibleftleg(self);
	}
	else if(val > 37)
	{
		gibserverutils::gibrightleg(self);
	}
	else
	{
		gibserverutils::gibleftleg(self);
	}
	self.has_legs = 0;
	self function_df5afb5e(1);
	self allowedstances("crouch");
	self setphysparams(15, 0, 24);
	self allowpitchangle(1);
	self setpitchorient();
	health = self.health;
	health = health * 0.1;
}

/*
	Name: zombie_head_gib
	Namespace: zombie_utility
	Checksum: 0x211651B
	Offset: 0x79A0
	Size: 0xD4
	Parameters: 2
	Flags: Linked
*/
function zombie_head_gib(attacker, means_of_death)
{
	self endon(#"death");
	if(isdefined(self.head_gibbed) && self.head_gibbed)
	{
		return;
	}
	self.head_gibbed = 1;
	self zombie_eye_glow_stop();
	if(!(isdefined(self.disable_head_gib) && self.disable_head_gib))
	{
		gibserverutils::gibhead(self);
	}
	self thread damage_over_time(ceil(self.health * 0.2), 1, attacker, means_of_death);
}

/*
	Name: function_3ab2b4eb
	Namespace: zombie_utility
	Checksum: 0xCFAB0765
	Offset: 0x7A80
	Size: 0x1C2
	Parameters: 0
	Flags: Linked
*/
function function_3ab2b4eb()
{
	if(isdefined(self.no_gib) && self.no_gib)
	{
		return;
	}
	playsoundatposition(#"hash_3046850a33a1bf30", self.origin);
	var_55633591 = randomint(5);
	if(var_55633591 == 3 && gibserverutils::isgibbed(self, 32) || (var_55633591 == 4 && gibserverutils::isgibbed(self, 16)))
	{
		var_55633591 = randomint(3);
	}
	switch(var_55633591)
	{
		case 0:
		{
			self zombie_head_gib();
			break;
		}
		case 1:
		{
			gibserverutils::gibrightleg(self);
			break;
		}
		case 2:
		{
			gibserverutils::gibleftleg(self);
			break;
		}
		case 3:
		{
			gibserverutils::gibrightarm(self);
			break;
		}
		case 4:
		{
			gibserverutils::gibleftarm(self);
			break;
		}
		default:
		{
			break;
		}
	}
}

/*
	Name: gib_random_parts
	Namespace: zombie_utility
	Checksum: 0x52A25B7A
	Offset: 0x7C50
	Size: 0x1A4
	Parameters: 0
	Flags: Linked
*/
function gib_random_parts()
{
	if(isdefined(self.no_gib) && self.no_gib)
	{
		return;
	}
	playsoundatposition(#"hash_3046850a33a1bf30", self.origin);
	val = randomint(100);
	if(val > 50)
	{
		self zombie_head_gib();
	}
	val = randomint(100);
	if(val > 50)
	{
		gibserverutils::gibrightleg(self);
	}
	val = randomint(100);
	if(val > 50)
	{
		gibserverutils::gibleftleg(self);
	}
	val = randomint(100);
	if(val > 50)
	{
		if(!gibserverutils::isgibbed(self, 32))
		{
			gibserverutils::gibrightarm(self);
		}
	}
	val = randomint(100);
	if(val > 50)
	{
		if(!gibserverutils::isgibbed(self, 16))
		{
			gibserverutils::gibleftarm(self);
		}
	}
}

/*
	Name: function_df5afb5e
	Namespace: zombie_utility
	Checksum: 0xD0F49DF4
	Offset: 0x7E00
	Size: 0xCA
	Parameters: 1
	Flags: Linked
*/
function function_df5afb5e(missinglegs = 0)
{
	if(missinglegs)
	{
		self.knockdown = 0;
		if(isdefined(self.var_1731eda3) && self.var_1731eda3)
		{
			self.var_1731eda3 = undefined;
		}
		if(isdefined(level.var_9b91564e))
		{
			if(!isdefined(level.var_41017830))
			{
				level.var_41017830 = 0;
			}
			level.var_41017830++;
			self callback::function_d8abfc3d(#"on_ai_killed", &function_c768f32b);
		}
	}
	self.missinglegs = missinglegs;
}

/*
	Name: function_c768f32b
	Namespace: zombie_utility
	Checksum: 0x6738C2C3
	Offset: 0x7ED8
	Size: 0x18
	Parameters: 1
	Flags: Linked, Private
*/
private function function_c768f32b(params)
{
	level.var_41017830--;
}

/*
	Name: init_ignore_player_handler
	Namespace: zombie_utility
	Checksum: 0xE49249CF
	Offset: 0x7EF8
	Size: 0x12
	Parameters: 0
	Flags: AutoExec
*/
autoexec function init_ignore_player_handler()
{
	level._ignore_player_handler = [];
}

/*
	Name: register_ignore_player_handler
	Namespace: zombie_utility
	Checksum: 0xAF6AE71C
	Offset: 0x7F18
	Size: 0x8A
	Parameters: 2
	Flags: None
*/
function register_ignore_player_handler(archetype, ignore_player_func)
{
	/#
		assert(isdefined(archetype), "");
	#/
	/#
		assert(!isdefined(level._ignore_player_handler[archetype]), "" + archetype + "");
	#/
	level._ignore_player_handler[archetype] = ignore_player_func;
}

/*
	Name: run_ignore_player_handler
	Namespace: zombie_utility
	Checksum: 0x2FA3BDD3
	Offset: 0x7FB0
	Size: 0x36
	Parameters: 0
	Flags: Linked
*/
function run_ignore_player_handler()
{
	if(isdefined(level._ignore_player_handler[self.archetype]))
	{
		self [[level._ignore_player_handler[self.archetype]]]();
	}
}

/*
	Name: function_27ba8249
	Namespace: zombie_utility
	Checksum: 0xF2FE0E80
	Offset: 0x7FF0
	Size: 0x120
	Parameters: 0
	Flags: None
*/
function function_27ba8249()
{
	/#
		self notify(#"hash_3f5088baaf14f6d0");
		self endon(#"death", #"hash_3f5088baaf14f6d0");
		settings_bundle = self ai::function_9139c839();
		if(!isdefined(settings_bundle))
		{
			return;
		}
		var_fd8e23d9 = self ai::function_9139c839().var_450edb3b;
		if(isdefined(var_fd8e23d9))
		{
			self asmsetanimationrate(var_fd8e23d9);
		}
		while(true)
		{
			wait(1);
			animation_rate = self ai::function_9139c839().var_450edb3b;
			if(!isdefined(animation_rate))
			{
				return;
			}
			if(var_fd8e23d9 == animation_rate)
			{
				continue;
			}
			self asmsetanimationrate(animation_rate);
			var_fd8e23d9 = animation_rate;
		}
	#/
}

