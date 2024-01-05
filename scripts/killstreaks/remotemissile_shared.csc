// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\killstreaks\killstreak_detect.csc;
#using script_5520b91a8aa516ab;
#using script_7bee869df82e0445;
#using scripts\core_common\shoutcaster.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\callbacks_shared.csc;

#namespace remotemissile;

/*
	Name: init_shared
	Namespace: remotemissile
	Checksum: 0x10C2012F
	Offset: 0x2B8
	Size: 0x33C
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	if(!(isdefined(level.var_e3049e92) && level.var_e3049e92) && !isdefined(level.var_2a02828c))
	{
		level.var_2a02828c = {};
		killstreak_detect::init_shared();
		remote_missile_targets::register("remote_missile_targets");
		for(ti = 0; ti < 6; ti++)
		{
			level.remote_missile_targets[ti] = spawnstruct();
			remote_missile_target_lockon::register("remote_missile_target_lockon" + ti, &function_1de73512, &function_fd0c759c);
		}
		clientfield::register("missile", "remote_missile_brakes", 1, 1, "int", &function_3e76ad59, 0, 0);
		clientfield::register("missile", "remote_missile_bomblet_fired", 1, 1, "int", &bomblets_deployed, 0, 0);
		clientfield::register("missile", "remote_missile_fired", 1, 2, "int", &missile_fired, 0, 0);
		clientfield::register("missile", "remote_missile_phase2", 1, 1, "int", undefined, 0, 0);
		clientfield::register("toplayer", "remote_missile_screenfx", 1, 1, "int", &function_c65b18ed, 0, 1);
		clientfield::register("clientuimodel", "hudItems.remoteMissilePhase2", 1, 1, "int", undefined, 0, 0);
		clientfield::register("scriptmover", "hellstorm_camera", 1, 1, "int", &function_6d66e75a, 0, 0);
		clientfield::register("scriptmover", "hellstorm_deploy", 1, 1, "int", &hellstorm_deploy, 0, 0);
		callback::function_17381fe(&function_17381fe);
	}
}

/*
	Name: function_17381fe
	Namespace: remotemissile
	Checksum: 0x104DF551
	Offset: 0x600
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function function_17381fe(localclientnum)
{
	if(isdefined(self))
	{
		function_d260edc9(localclientnum);
	}
}

/*
	Name: function_fd0c759c
	Namespace: remotemissile
	Checksum: 0xF8E6D9DA
	Offset: 0x638
	Size: 0x68
	Parameters: 7
	Flags: None
*/
function function_fd0c759c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(level.var_e656f88a))
	{
		[[level.var_e656f88a]](localclientnum, newval, fieldname);
	}
}

/*
	Name: function_1de73512
	Namespace: remotemissile
	Checksum: 0xE944BC50
	Offset: 0x6A8
	Size: 0x68
	Parameters: 7
	Flags: None
*/
function function_1de73512(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(level.var_70a07f6f))
	{
		[[level.var_70a07f6f]](localclientnum, newval, fieldname);
	}
}

/*
	Name: hellstorm_deploy
	Namespace: remotemissile
	Checksum: 0x36513122
	Offset: 0x718
	Size: 0xC0
	Parameters: 7
	Flags: None
*/
function hellstorm_deploy(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self))
	{
		return;
	}
	self endon(#"death");
	self util::waittill_dobj(localclientnum);
	if(newval)
	{
		self useanimtree("generic");
		self setanim(#"hash_4b6a7686ae8c1f16", 1);
	}
}

/*
	Name: function_6d66e75a
	Namespace: remotemissile
	Checksum: 0xF6B45D49
	Offset: 0x7E0
	Size: 0x54
	Parameters: 7
	Flags: None
*/
function function_6d66e75a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self thread function_90b75549(localclientnum);
}

/*
	Name: function_90b75549
	Namespace: remotemissile
	Checksum: 0xDA58221F
	Offset: 0x840
	Size: 0xDE
	Parameters: 1
	Flags: None
*/
function function_90b75549(localclientnum)
{
	self notify(#"hash_3f127346d8e9769f");
	self endon(#"hash_3f127346d8e9769f", #"death");
	player = function_5c10bd79(localclientnum);
	self util::waittill_dobj(localclientnum);
	while(isdefined(player) && isdefined(self) && self.owner === player)
	{
		player camerasetposition(self.origin);
		player camerasetlookat(self.angles);
		waitframe(1);
	}
}

/*
	Name: function_3e76ad59
	Namespace: remotemissile
	Checksum: 0x637C0749
	Offset: 0x928
	Size: 0x84
	Parameters: 7
	Flags: None
*/
function function_3e76ad59(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self function_d309e55a("tag_brake_control_animate", 1);
	}
	else
	{
		self function_d309e55a("tag_brake_control_animate", 0);
	}
}

/*
	Name: missile_fired
	Namespace: remotemissile
	Checksum: 0x83F23120
	Offset: 0x9B8
	Size: 0x2E4
	Parameters: 7
	Flags: None
*/
function missile_fired(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self function_d309e55a("tag_fin_control_animate", 1);
		player = function_5c10bd79(localclientnum);
		owner = self getowner(localclientnum);
		clientobjid = util::getnextobjid(localclientnum);
		objective_onentity(localclientnum, clientobjid, self, 1, 0, 1);
		self.hellfireobjid = clientobjid;
		self thread destruction_watcher(localclientnum, clientobjid);
		objective_setstate(localclientnum, clientobjid, "active");
		if(player hasperk(localclientnum, #"specialty_showscorestreakicons"))
		{
			objective_seticon(localclientnum, clientobjid, "remotemissile_targetF");
			objective_seticonsize(localclientnum, clientobjid, 50);
		}
		self thread hud_update(localclientnum);
		if(player === owner)
		{
			player.clouds_fx = util::playfxontag(localclientnum, #"hash_50b25e352ba908d0", self, "tag_origin");
		}
	}
	else
	{
		if(newval == 2)
		{
			if(isdefined(self.hellfireobjid))
			{
				self notify(#"hellfire_detonated");
				objective_delete(localclientnum, self.hellfireobjid);
				util::releaseobjid(localclientnum, self.hellfireobjid);
			}
		}
		else
		{
			self notify(#"cleanup_objectives");
		}
	}
	ammo_ui_data_model = getuimodel(getuimodelforcontroller(localclientnum), "vehicle.rocketAmmo");
	if(isdefined(ammo_ui_data_model))
	{
		setuimodelvalue(ammo_ui_data_model, 2);
	}
}

/*
	Name: bomblets_deployed
	Namespace: remotemissile
	Checksum: 0xF77A4097
	Offset: 0xCA8
	Size: 0x1DC
	Parameters: 7
	Flags: None
*/
function bomblets_deployed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(bnewent && oldval == newval)
	{
		return;
	}
	if(newval == 1)
	{
		player = function_5c10bd79(localclientnum);
		owner = self getowner(localclientnum);
		clientobjid = util::getnextobjid(localclientnum);
		objective_onentity(localclientnum, clientobjid, self, 1, 0, 1);
		self thread destruction_watcher(localclientnum, clientobjid);
		objective_setstate(localclientnum, clientobjid, "active");
		if(player hasperk(localclientnum, #"specialty_showscorestreakicons"))
		{
			objective_seticon(localclientnum, clientobjid, "remotemissile_target");
		}
	}
	else
	{
		self notify(#"cleanup_objectives");
	}
	ammo_ui_data_model = getuimodel(getuimodelforcontroller(localclientnum), "vehicle.rocketAmmo");
	if(isdefined(ammo_ui_data_model))
	{
		setuimodelvalue(ammo_ui_data_model, 0);
	}
}

/*
	Name: destruction_watcher
	Namespace: remotemissile
	Checksum: 0x1EC1FC58
	Offset: 0xE90
	Size: 0x7C
	Parameters: 2
	Flags: None
*/
function destruction_watcher(localclientnum, clientobjid)
{
	self waittill(#"death", #"cleanup_objectives");
	wait(0.1);
	if(isdefined(clientobjid))
	{
		objective_delete(localclientnum, clientobjid);
		util::releaseobjid(localclientnum, clientobjid);
	}
}

/*
	Name: hud_update
	Namespace: remotemissile
	Checksum: 0x50527FFB
	Offset: 0xF18
	Size: 0x2A6
	Parameters: 1
	Flags: None
*/
function hud_update(localclientnum)
{
	self endon(#"death");
	self notify(#"remote_missile_singeton");
	self endon(#"remote_missile_singeton");
	missile = self;
	altitude_ui_data_model = getuimodel(getuimodelforcontroller(localclientnum), "vehicle.altitude");
	speed_ui_data_model = getuimodel(getuimodelforcontroller(localclientnum), "vehicle.speed");
	var_2c36f843 = getuimodel(getuimodelforcontroller(localclientnum), "vehicle.remainingTime");
	if(!isdefined(altitude_ui_data_model) || !isdefined(speed_ui_data_model) || !isdefined(var_2c36f843))
	{
		return;
	}
	birthtime = gettime();
	lifetime = (isdefined(missile.weapon.weapon.lifetime) ? missile.weapon.lifetime : 20) * 1000;
	prev_z = missile.origin[2];
	fps = 20;
	delay = 1 / fps;
	while(isdefined(lifetime) && lifetime > 0)
	{
		cur_z = missile.origin[2];
		setuimodelvalue(altitude_ui_data_model, cur_z);
		dist = (prev_z - cur_z) * fps;
		val = dist / 17.6;
		setuimodelvalue(speed_ui_data_model, val);
		prev_z = cur_z;
		remainingtime = 1 - ((gettime() - birthtime) / lifetime);
		setuimodelvalue(var_2c36f843, remainingtime);
		wait(delay);
	}
}

/*
	Name: function_d260edc9
	Namespace: remotemissile
	Checksum: 0x1CEBA9CA
	Offset: 0x11C8
	Size: 0x16C
	Parameters: 1
	Flags: None
*/
function function_d260edc9(localclientnum)
{
	player = function_5c10bd79(localclientnum);
	postfxbundle = #"hash_778f4a554a5cfc33";
	if(!function_148ccc79(localclientnum, postfxbundle) && (!function_1cbf351b(localclientnum) || function_93e0f729(localclientnum) === function_27673a7(localclientnum)) && !shoutcaster::function_2e6e4ee0(localclientnum))
	{
		if(isdefined(self.weapon) && self.weapon.statname == #"remote_missile")
		{
			function_a837926b(localclientnum, postfxbundle);
		}
	}
	else
	{
		if(isdefined(player.clouds_fx))
		{
			killfx(localclientnum, player.clouds_fx);
		}
		if(function_148ccc79(localclientnum, postfxbundle))
		{
			codestoppostfxbundlelocal(localclientnum, postfxbundle);
		}
	}
}

/*
	Name: function_c65b18ed
	Namespace: remotemissile
	Checksum: 0x93C809EB
	Offset: 0x1340
	Size: 0x184
	Parameters: 7
	Flags: None
*/
function function_c65b18ed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	player = function_5c10bd79(localclientnum);
	postfxbundle = #"hash_778f4a554a5cfc33";
	if(!isdefined(self))
	{
		return;
	}
	if(newval)
	{
		if(!function_148ccc79(localclientnum, postfxbundle) && (!function_1cbf351b(localclientnum) || function_93e0f729(localclientnum) === function_27673a7(localclientnum)) && !shoutcaster::function_2e6e4ee0(localclientnum))
		{
			function_a837926b(localclientnum, postfxbundle);
		}
	}
	else
	{
		if(isdefined(player.clouds_fx))
		{
			killfx(localclientnum, player.clouds_fx);
		}
		if(function_148ccc79(localclientnum, postfxbundle))
		{
			codestoppostfxbundlelocal(localclientnum, postfxbundle);
		}
	}
}

