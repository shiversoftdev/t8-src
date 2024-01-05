// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\clientfield_shared.csc;

#namespace emp;

/*
	Name: init_shared
	Namespace: emp
	Checksum: 0x81C31984
	Offset: 0xF8
	Size: 0xBC
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	if(!isdefined(level.var_2d56b64c))
	{
		level.var_2d56b64c = {};
		clientfield::register("scriptmover", "emp_turret_init", 1, 1, "int", &emp_turret_init, 0, 0);
		clientfield::register("vehicle", "emp_turret_deploy", 1, 1, "int", &emp_turret_deploy_start, 0, 0);
		thread monitor_emp_killstreaks();
	}
}

/*
	Name: monitor_emp_killstreaks
	Namespace: emp
	Checksum: 0x5C1C63C9
	Offset: 0x1C0
	Size: 0x1A0
	Parameters: 0
	Flags: None
*/
function monitor_emp_killstreaks()
{
	level endon(#"disconnect");
	if(!isdefined(level.emp_killstreaks))
	{
		level.emp_killstreaks = [];
	}
	for(;;)
	{
		has_at_least_one_active_enemy_turret = 0;
		arrayremovevalue(level.emp_killstreaks, undefined);
		local_players = getlocalplayers();
		foreach(local_player in local_players)
		{
			if(local_player function_21c0fa55() == 0)
			{
				continue;
			}
			closest_enemy_emp = get_closest_enemy_emp_killstreak(local_player);
			if(isdefined(closest_enemy_emp))
			{
				has_at_least_one_active_enemy_turret = 1;
				localclientnum = local_player getlocalclientnumber();
				update_distance_to_closest_emp(localclientnum, distance(local_player.origin, closest_enemy_emp.origin));
			}
		}
		wait((has_at_least_one_active_enemy_turret ? 0.1 : 0.7));
	}
}

/*
	Name: get_closest_enemy_emp_killstreak
	Namespace: emp
	Checksum: 0x5DD3BBE8
	Offset: 0x368
	Size: 0x11A
	Parameters: 1
	Flags: None
*/
function get_closest_enemy_emp_killstreak(local_player)
{
	closest_emp = undefined;
	closest_emp_distance_squared = 99999999;
	foreach(emp in level.emp_killstreaks)
	{
		if(emp.owner == local_player || !local_player util::isenemyteam(emp.team))
		{
			continue;
		}
		distance_squared = distancesquared(local_player.origin, emp.origin);
		if(distance_squared < closest_emp_distance_squared)
		{
			closest_emp = emp;
			closest_emp_distance_squared = distance_squared;
		}
	}
	return closest_emp;
}

/*
	Name: update_distance_to_closest_emp
	Namespace: emp
	Checksum: 0x51F8364D
	Offset: 0x490
	Size: 0x74
	Parameters: 2
	Flags: None
*/
function update_distance_to_closest_emp(localclientnum, new_value)
{
	if(!isdefined(localclientnum))
	{
		return;
	}
	distance_to_closest_enemy_emp_ui_model = getuimodel(getuimodelforcontroller(localclientnum), "distanceToClosestEnemyEmpKillstreak");
	if(isdefined(distance_to_closest_enemy_emp_ui_model))
	{
		setuimodelvalue(distance_to_closest_enemy_emp_ui_model, new_value);
	}
}

/*
	Name: emp_turret_init
	Namespace: emp
	Checksum: 0xA6E61094
	Offset: 0x510
	Size: 0xD4
	Parameters: 7
	Flags: None
*/
function emp_turret_init(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	if(!newval)
	{
		return;
	}
	self useanimtree("generic");
	self setanimrestart(#"o_turret_emp_core_deploy", 1, 0, 0);
	self setanimtime(#"o_turret_emp_core_deploy", 0);
}

/*
	Name: cleanup_fx_on_shutdown
	Namespace: emp
	Checksum: 0x48804ADF
	Offset: 0x5F0
	Size: 0x54
	Parameters: 2
	Flags: None
*/
function cleanup_fx_on_shutdown(localclientnum, handle)
{
	self endon(#"kill_fx_cleanup");
	self waittill(#"death");
	stopfx(localclientnum, handle);
}

/*
	Name: emp_turret_deploy_start
	Namespace: emp
	Checksum: 0x5730E96A
	Offset: 0x650
	Size: 0xDE
	Parameters: 7
	Flags: None
*/
function emp_turret_deploy_start(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	self util::waittill_dobj(localclientnum);
	if(!isdefined(self))
	{
		return;
	}
	if(newval)
	{
		self thread emp_turret_deploy(localclientnum);
	}
	else
	{
		self notify(#"kill_fx_cleanup");
		if(isdefined(self.fxhandle))
		{
			stopfx(localclientnum, self.fxhandle);
			self.fxhandle = undefined;
		}
	}
}

/*
	Name: emp_turret_deploy
	Namespace: emp
	Checksum: 0x5F246680
	Offset: 0x738
	Size: 0x17C
	Parameters: 1
	Flags: None
*/
function emp_turret_deploy(localclientnum)
{
	self endon(#"death");
	self useanimtree("generic");
	self setanimrestart(#"o_turret_emp_core_deploy", 1, 0, 1);
	length = getanimlength(#"o_turret_emp_core_deploy");
	wait(length * 0.75);
	self useanimtree("generic");
	self setanim(#"o_turret_emp_core_spin", 1);
	self.fxhandle = util::playfxontag(localclientnum, #"killstreaks/fx_emp_core", self, "tag_fx");
	self thread cleanup_fx_on_shutdown(localclientnum, self.fxhandle);
	wait(length * 0.25);
	self setanim(#"o_turret_emp_core_deploy", 0);
}

