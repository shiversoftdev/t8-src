// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\visionset_mgr_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace drown;

/*
	Name: __init__system__
	Namespace: drown
	Checksum: 0xC2D8EFEC
	Offset: 0x110
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"drown", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: drown
	Checksum: 0x6A908E0C
	Offset: 0x158
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_spawned(&function_27777812);
	callback::on_connect(&on_connect);
	level.drown_pre_damage_stage_time = 2000;
	if(!isdefined(level.vsmgr_prio_overlay_drown_blur))
	{
		level.vsmgr_prio_overlay_drown_blur = 10;
	}
	visionset_mgr::register_info("overlay", "drown_blur", 1, level.vsmgr_prio_overlay_drown_blur, 1, 1, &visionset_mgr::ramp_in_out_thread_per_player, 1);
	clientfield::register("toplayer", "drown_stage", 1, 3, "int");
}

/*
	Name: on_connect
	Namespace: drown
	Checksum: 0xEF43BFE6
	Offset: 0x248
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function on_connect()
{
	self callback::on_death(&function_1ef50162);
	self callback::function_d8abfc3d(#"on_end_game", &function_c621d98c);
}

/*
	Name: activate_player_health_visionset
	Namespace: drown
	Checksum: 0xE424B73B
	Offset: 0x2A8
	Size: 0x6A
	Parameters: 0
	Flags: Linked
*/
function activate_player_health_visionset()
{
	self deactivate_player_health_visionset();
	if(!self.drown_vision_set)
	{
		visionset_mgr::activate("overlay", "drown_blur", self, 0.1, 0.25, 0.1);
		self.drown_vision_set = 1;
	}
}

/*
	Name: deactivate_player_health_visionset
	Namespace: drown
	Checksum: 0xB4DA327D
	Offset: 0x320
	Size: 0x4E
	Parameters: 0
	Flags: Linked
*/
function deactivate_player_health_visionset()
{
	if(!isdefined(self.drown_vision_set) || self.drown_vision_set)
	{
		visionset_mgr::deactivate("overlay", "drown_blur", self);
		self.drown_vision_set = 0;
	}
}

/*
	Name: function_27777812
	Namespace: drown
	Checksum: 0x90CAFCEB
	Offset: 0x378
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_27777812()
{
	self callback::add_callback(#"underwater", &function_84845e32);
	self deactivate_player_health_visionset();
}

/*
	Name: function_c621d98c
	Namespace: drown
	Checksum: 0x3E1235F1
	Offset: 0x3D0
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_c621d98c(params)
{
	self function_1ef50162(params);
	self callback::remove_on_death(&function_1ef50162);
}

/*
	Name: function_84845e32
	Namespace: drown
	Checksum: 0xE927B880
	Offset: 0x420
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_84845e32(params)
{
	if(!isdefined(self.playerrole))
	{
		return;
	}
	if(params.underwater)
	{
		thread watch_player_drowning();
	}
}

/*
	Name: watch_player_drowning
	Namespace: drown
	Checksum: 0x14B69E6E
	Offset: 0x468
	Size: 0x654
	Parameters: 0
	Flags: Linked
*/
function watch_player_drowning()
{
	self endon(#"disconnect", #"death");
	level endon(#"game_ended");
	self clientfield::set_to_player("drown_stage", 0);
	self.lastwaterdamagetime = self getlastoutwatertime();
	self.drownstage = 0;
	var_c1e8fa5d = 4000;
	underwaterbreathtime = 1000;
	if(isdefined(level.var_ac6052e9))
	{
		underwaterbreathtime = int([[level.var_ac6052e9]]("underwaterBreathTime", 1) * 1000);
		exertbuffer = [[level.var_ac6052e9]]("playerExertBuffer", 1);
	}
	while(true)
	{
		waitframe(1);
		underwater = game.state == "pregame" || game.state == "playing" && self isplayerunderwater();
		var_790acff6 = isdefined(level.var_8e910e84) && level.var_8e910e84 && self inlaststand() && getwaterheight(self.origin) > self getplayercamerapos()[2];
		underwater = underwater | var_790acff6;
		if(underwater && (!(isdefined(self.var_f07d3654) && self.var_f07d3654)))
		{
			if(!(isdefined(self.wasunderwater) && self.wasunderwater))
			{
				self.wasunderwater = 1;
				self.var_cdefe788 = gettime();
				self stopsounds();
			}
			n_swimtime = int(self.playerrole.swimtime * 1000);
			if(self hasperk(#"hash_4ef368f54cd86ab7"))
			{
				n_swimtime = int(n_swimtime * 1.5);
			}
			if((gettime() - self.lastwaterdamagetime) > (n_swimtime - var_c1e8fa5d) && self.drownstage == 0)
			{
				if(isdefined(level.var_9f155bf4))
				{
					self thread [[level.var_9f155bf4]]("MOD_DROWN");
				}
				var_c1e8fa5d = var_c1e8fa5d - (int(self.playerrole.var_f0886300 * 1000));
			}
			if((gettime() - self.lastwaterdamagetime) > (n_swimtime - level.drown_pre_damage_stage_time) && self.drownstage == 0)
			{
				self.drownstage++;
				self clientfield::set_to_player("drown_stage", self.drownstage);
			}
			else if(self.drownstage == 0 && var_790acff6)
			{
				self.drownstage++;
				self clientfield::set_to_player("drown_stage", self.drownstage);
				self.lastwaterdamagetime = (gettime() - n_swimtime) + (int(self.playerrole.var_f0886300 * 1000));
			}
			if(gettime() - self.lastwaterdamagetime > n_swimtime)
			{
				self.lastwaterdamagetime = self.lastwaterdamagetime + (int(self.playerrole.var_f0886300 * 1000));
				self dodamage(self.playerrole.swimdamage, self.origin, undefined, undefined, undefined, "MOD_DROWN", 6);
				self activate_player_health_visionset();
				if(self.drownstage < 4)
				{
					self.drownstage++;
					self clientfield::set_to_player("drown_stage", self.drownstage);
				}
			}
		}
		else
		{
			if(isdefined(level.var_ee30f81d) && (isdefined(self.wasunderwater) && self.wasunderwater))
			{
				if(self.drownstage > 0)
				{
					thread [[level.var_ee30f81d]](self, 1);
				}
				thread [[level.var_ee30f81d]](self, 0);
			}
			self.drownstage = 0;
			self clientfield::set_to_player("drown_stage", 0);
			self.lastwaterdamagetime = self getlastoutwatertime();
			self deactivate_player_health_visionset();
			var_c1e8fa5d = 4000;
			self.wasunderwater = 0;
			return;
		}
	}
}

/*
	Name: function_1ef50162
	Namespace: drown
	Checksum: 0xC325CBD4
	Offset: 0xAC8
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_1ef50162(params = undefined)
{
	self.drownstage = 0;
	self clientfield::set_to_player("drown_stage", 0);
	self.wasunderwater = 0;
	self deactivate_player_health_visionset();
}

/*
	Name: is_player_drowning
	Namespace: drown
	Checksum: 0x31EC651C
	Offset: 0xB38
	Size: 0x3E
	Parameters: 0
	Flags: None
*/
function is_player_drowning()
{
	drowning = 1;
	if(!isdefined(self.drownstage) || self.drownstage == 0)
	{
		drowning = 0;
	}
	return drowning;
}

