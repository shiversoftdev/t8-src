// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace teams;

/*
	Name: function_dc7eaabd
	Namespace: teams
	Checksum: 0x1B930823
	Offset: 0x68
	Size: 0x14C
	Parameters: 1
	Flags: None
*/
function function_dc7eaabd(assignment)
{
	/#
		assert(isdefined(assignment));
	#/
	self.pers[#"team"] = assignment;
	self.team = assignment;
	self.sessionteam = assignment;
	if(isdefined(level.teams[assignment]))
	{
		status = self function_3d288f14();
		if(!isdefined(level.var_75dffa9f[assignment]) || (status != level.var_75dffa9f[assignment] && status == #"game"))
		{
			if(status == #"game")
			{
				level.var_75dffa9f[assignment] = #"game";
			}
			else
			{
				level.var_75dffa9f[assignment] = #"none";
			}
		}
	}
	/#
		self thread function_ba459d03(assignment);
	#/
}

/*
	Name: function_3d288f14
	Namespace: teams
	Checksum: 0x3730F504
	Offset: 0x1C0
	Size: 0x11A
	Parameters: 0
	Flags: Linked
*/
function function_3d288f14()
{
	/#
		if(isbot(self))
		{
			if(isdefined(self.var_30e2c3ec))
			{
				return self.var_30e2c3ec;
			}
			rand = randomintrange(0, 3);
			switch(rand)
			{
				case 0:
				{
					self.var_30e2c3ec = #"none";
					break;
				}
				case 1:
				{
					self.var_30e2c3ec = #"game";
					break;
				}
				case 2:
				{
					self.var_30e2c3ec = #"system";
					break;
				}
			}
			return self.var_30e2c3ec;
		}
	#/
	status = self function_e59fbfc8();
	return status;
}

/*
	Name: function_6d86768e
	Namespace: teams
	Checksum: 0x5827011
	Offset: 0x2E8
	Size: 0x42
	Parameters: 1
	Flags: Linked
*/
function function_6d86768e(team)
{
	team_players = getplayers(team);
	if(team_players.size > 0)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_959bac94
	Namespace: teams
	Checksum: 0x166658C5
	Offset: 0x338
	Size: 0xEA
	Parameters: 0
	Flags: None
*/
function function_959bac94()
{
	foreach(team in level.teams)
	{
		if(self function_6d86768e(team))
		{
			/#
				println("" + "" + self.name + "" + team);
			#/
			/#
				function_d28f6fa0(team);
			#/
			return team;
		}
	}
	return #"spectator";
}

/*
	Name: function_ba459d03
	Namespace: teams
	Checksum: 0x788CA9A1
	Offset: 0x430
	Size: 0x134
	Parameters: 1
	Flags: Private
*/
private function function_ba459d03(team)
{
	/#
		if(isdefined(level.var_ba13fb7a) && level.var_ba13fb7a)
		{
			var_54e8d52e = string(team);
			if(isdefined(level.teams[team]))
			{
				var_54e8d52e = level.teams[team];
			}
			voip = "";
			if(isdefined(level.var_75dffa9f[team]))
			{
				voip = voip + (level.var_75dffa9f[team] == #"game" ? "" : "");
			}
			else
			{
				voip = voip + "";
			}
			println("" + "" + self.name + "" + var_54e8d52e + "" + voip);
		}
	#/
}

/*
	Name: function_a9d594a0
	Namespace: teams
	Checksum: 0x9C7CDF23
	Offset: 0x570
	Size: 0xD0
	Parameters: 1
	Flags: None
*/
function function_a9d594a0(party)
{
	/#
		foreach(var_52ec371a in party.var_d77ed5eb)
		{
			var_2798314b = var_52ec371a function_491311f4();
			if(var_2798314b.var_a15e4438 != party.var_a15e4438)
			{
				/#
					assertmsg("");
				#/
			}
		}
	#/
}

/*
	Name: function_d28f6fa0
	Namespace: teams
	Checksum: 0x53C776FA
	Offset: 0x648
	Size: 0xB0
	Parameters: 1
	Flags: None
*/
function function_d28f6fa0(team)
{
	/#
		players = getplayers(team);
		foreach(player in players)
		{
			function_a9d594a0(player function_491311f4());
		}
	#/
}

