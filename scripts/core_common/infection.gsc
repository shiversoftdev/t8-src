// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f27a7b2232674db;
#using script_75be2950b381443;
#using scripts\core_common\spectating.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\teams.gsc;

#namespace infection;

/*
	Name: function_89f2df9
	Namespace: infection
	Checksum: 0xD8EAAAAB
	Offset: 0x100
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"infection", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: infection
	Checksum: 0x4801C356
	Offset: 0x148
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!isdefined(level.infection) && getgametypesetting("infectionMode", 0))
	{
		initialize();
	}
}

/*
	Name: initialize
	Namespace: infection
	Checksum: 0x2AFA7D10
	Offset: 0x1A0
	Size: 0xAE
	Parameters: 0
	Flags: Linked
*/
function initialize()
{
	level.infection = {#hash_c0879807:[], #hash_c4b373ef:[], #platoon:#"invalid", #team:#"none", #hash_e088b6aa:undefined, #primary_weapon:undefined, #bodies:[], #perks:[]};
}

/*
	Name: function_74650d7
	Namespace: infection
	Checksum: 0x6146B105
	Offset: 0x258
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_74650d7()
{
	if(isdefined(level.infection))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_bf46a7aa
	Namespace: infection
	Checksum: 0xA2A1DC9D
	Offset: 0x280
	Size: 0x18
	Parameters: 0
	Flags: Linked
*/
function function_bf46a7aa()
{
	return isdefined(self.infected) && self.infected;
}

/*
	Name: function_a2d73bc3
	Namespace: infection
	Checksum: 0xE82EEE9C
	Offset: 0x2A0
	Size: 0x36
	Parameters: 1
	Flags: None
*/
function function_a2d73bc3(team)
{
	if(!function_74650d7())
	{
		return;
	}
	level.infection.team = team;
}

/*
	Name: function_fb163563
	Namespace: infection
	Checksum: 0x36C22724
	Offset: 0x2E0
	Size: 0x36
	Parameters: 1
	Flags: None
*/
function function_fb163563(platoon)
{
	if(!function_74650d7())
	{
		return;
	}
	level.infection.platoon = platoon;
}

/*
	Name: function_153000d0
	Namespace: infection
	Checksum: 0x985DF427
	Offset: 0x320
	Size: 0x9C
	Parameters: 2
	Flags: None
*/
function function_153000d0(male, female)
{
	/#
		assert(isdefined(male));
	#/
	/#
		assert(isdefined(female));
	#/
	male_index = player_role::function_97d19493(male);
	female_index = player_role::function_97d19493(female);
	function_e8cc8373(male_index, female_index);
}

/*
	Name: function_e8cc8373
	Namespace: infection
	Checksum: 0x15FD3A79
	Offset: 0x3C8
	Size: 0x8E
	Parameters: 2
	Flags: Linked, Private
*/
private function function_e8cc8373(male, female)
{
	/#
		assert(isdefined(male));
	#/
	/#
		assert(isdefined(female));
	#/
	if(!function_74650d7())
	{
		return;
	}
	level.infection.bodies[0] = male;
	level.infection.bodies[1] = female;
}

/*
	Name: function_db5ddd5f
	Namespace: infection
	Checksum: 0x5FEDB8B
	Offset: 0x460
	Size: 0xEE
	Parameters: 1
	Flags: None
*/
function function_db5ddd5f(perk)
{
	/#
		assert(isdefined(perk));
	#/
	if(!function_74650d7())
	{
		return;
	}
	if(!isdefined(level.infection.perks))
	{
		level.infection.perks = [];
	}
	else if(!isarray(level.infection.perks))
	{
		level.infection.perks = array(level.infection.perks);
	}
	level.infection.perks[level.infection.perks.size] = perk;
}

/*
	Name: function_ff357d24
	Namespace: infection
	Checksum: 0x2E22D5B4
	Offset: 0x558
	Size: 0xB0
	Parameters: 0
	Flags: Linked
*/
function function_ff357d24()
{
	if(!function_74650d7())
	{
		return;
	}
	foreach(perk in level.infection.perks)
	{
		if(!self hasperk(perk))
		{
			self setperk(perk);
		}
	}
}

/*
	Name: give_loadout
	Namespace: infection
	Checksum: 0x87308A26
	Offset: 0x610
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function give_loadout()
{
	self function_e6f9e3cd();
	self clearperks();
	self function_ff357d24();
}

/*
	Name: function_f3a05d39
	Namespace: infection
	Checksum: 0x9978CB69
	Offset: 0x668
	Size: 0x164
	Parameters: 0
	Flags: Linked
*/
function function_f3a05d39()
{
	if(!isplayer(self))
	{
		/#
			assert(0);
		#/
		return;
	}
	self function_8fd843dd(0);
	self function_9b48a8e5(0);
	self function_ab96a9b5("head", 0);
	self function_ab96a9b5("headgear", 0);
	self function_ab96a9b5("arms", 0);
	self function_ab96a9b5("torso", 0);
	self function_ab96a9b5("legs", 0);
	self function_ab96a9b5("palette", 0);
	self function_ab96a9b5("warpaint", 0);
	self function_ab96a9b5("decal", 0);
}

/*
	Name: function_c37a6757
	Namespace: infection
	Checksum: 0x5A6A7A9E
	Offset: 0x7D8
	Size: 0x1AC
	Parameters: 0
	Flags: None
*/
function function_c37a6757()
{
	if(self hasdobj() && self haspart("j_spine4"))
	{
		self playsoundontag(#"hash_3407b7c42e8075c9", "j_spine4");
	}
	self thread function_da08f4d0();
	current_role = self player_role::get();
	foreach(body in level.infection.bodies)
	{
		if(current_role == body)
		{
			self function_f3a05d39();
			return;
		}
	}
	body_index = (self getplayergendertype() == "male" ? 0 : 1);
	self player_role::set(level.infection.bodies[body_index], 1);
	self function_f3a05d39();
}

/*
	Name: function_da08f4d0
	Namespace: infection
	Checksum: 0x66F3BEBD
	Offset: 0x990
	Size: 0x128
	Parameters: 0
	Flags: Linked
*/
function function_da08f4d0()
{
	self endon(#"death");
	wait(randomintrange(2, 4));
	while(true)
	{
		str_alias = #"hash_61fc4fa3eeafcf07";
		n_wait_min = 2;
		n_wait_max = 5;
		if(self issprinting())
		{
			str_alias = #"hash_64441bbb83e130e9";
			n_wait_min = 4;
			n_wait_max = 7;
		}
		if(self hasdobj() && self haspart("j_spine4"))
		{
			self playsoundontag(str_alias, "j_spine4");
		}
		wait(randomintrange(n_wait_min, n_wait_max));
	}
}

/*
	Name: function_882350c
	Namespace: infection
	Checksum: 0x28266492
	Offset: 0xAC0
	Size: 0x42
	Parameters: 0
	Flags: None
*/
function function_882350c()
{
	xuid = self getxuid();
	level.infection.var_c4b373ef[xuid] = 1;
}

/*
	Name: function_687661ea
	Namespace: infection
	Checksum: 0xA3291FC4
	Offset: 0xB10
	Size: 0x66
	Parameters: 0
	Flags: None
*/
function function_687661ea()
{
	xuid = self getxuid();
	if(isdefined(level.infection.var_c4b373ef[xuid]) && level.infection.var_c4b373ef[xuid])
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_896b35be
	Namespace: infection
	Checksum: 0xBD4EAA24
	Offset: 0xB80
	Size: 0x10E
	Parameters: 0
	Flags: Linked, Private
*/
private function function_896b35be()
{
	if(level.infection.platoon != #"invalid")
	{
		if(self function_bf46a7aa())
		{
			return self.team;
		}
		if(isdefined(level.infection.var_c0879807[self.team]))
		{
			return level.infection.var_c0879807[self.team];
		}
		team = self.team;
		if(team != #"spectator")
		{
			players_on_team = getplayers(team);
			if(players_on_team.size <= 1)
			{
				return team;
			}
		}
		team = teams::function_959bac94();
		return team;
	}
	return level.infection.team;
}

/*
	Name: function_76601b7d
	Namespace: infection
	Checksum: 0xD4DABB3F
	Offset: 0xC98
	Size: 0x16
	Parameters: 0
	Flags: Linked
*/
function function_76601b7d()
{
	return level.infection.platoon;
}

/*
	Name: function_d3da95cf
	Namespace: infection
	Checksum: 0xE3938174
	Offset: 0xCB8
	Size: 0x1B4
	Parameters: 0
	Flags: None
*/
function function_d3da95cf()
{
	team = self function_896b35be();
	platoon = function_76601b7d();
	if(platoon != #"invalid")
	{
		level.infection.var_c0879807[self.team] = team;
		namespace_aa9b5883::function_334c4bec(team, platoon);
	}
	if(!isdefined(level.everexisted[team]))
	{
		level.everexisted[team] = gettime();
	}
	if(self.sessionstate != "dead")
	{
		self.switching_teams = 1;
		self.switchedteamsresetgadgets = 1;
		self.joining_team = team;
		self.leaving_team = self.pers[#"team"];
	}
	self teams::function_dc7eaabd(team);
	self.pers[#"weapon"] = undefined;
	self.pers[#"spawnweapon"] = undefined;
	self.pers[#"savedmodel"] = undefined;
	self.pers[#"teamtime"] = undefined;
	self.infected = 1;
	self spectating::set_permissions();
}

