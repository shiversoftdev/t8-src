// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_324d329b31b9b4ec;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;

#namespace supplydrop;

/*
	Name: init_shared
	Namespace: supplydrop
	Checksum: 0x96D7641A
	Offset: 0x230
	Size: 0x3B4
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	if(!isdefined(level.var_ba8d5308))
	{
		level.var_ba8d5308 = {};
		ir_strobe::init_shared();
		level.chopper_fx[#"damage"][#"light_smoke"] = "destruct/fx8_atk_chppr_smk_trail";
		level.chopper_fx[#"damage"][#"heavy_smoke"] = "destruct/fx8_atk_chppr_exp_trail";
		level._effect[#"qrdrone_prop"] = #"hash_6cd811fe548313ca";
		level._effect[#"heli_guard_light"][#"friendly"] = #"killstreaks/fx_sc_lights_grn";
		level._effect[#"heli_guard_light"][#"enemy"] = #"killstreaks/fx_sc_lights_red";
		level._effect[#"heli_comlink_light"][#"common"] = #"killstreaks/fx_drone_hunter_lights";
		level._effect[#"heli_gunner_light"][#"friendly"] = #"killstreaks/fx_vtol_lights_grn";
		level._effect[#"heli_gunner_light"][#"enemy"] = #"killstreaks/fx_vtol_lights_red";
		level._effect[#"heli_gunner"][#"vtol_fx"] = #"killstreaks/fx_vtol_thruster";
		level._effect[#"heli_gunner"][#"vtol_fx_ft"] = #"killstreaks/fx_vtol_thruster";
		clientfield::register("vehicle", "supplydrop_care_package_state", 1, 1, "int", &supplydrop_care_package_state, 0, 0);
		clientfield::register("vehicle", "supplydrop_ai_tank_state", 1, 1, "int", &supplydrop_ai_tank_state, 0, 0);
		clientfield::register("scriptmover", "supplydrop_thrusters_state", 1, 1, "int", &setsupplydropthrustersstate, 0, 0);
		clientfield::register("scriptmover", "aitank_thrusters_state", 1, 1, "int", &setaitankhrustersstate, 0, 0);
	}
}

/*
	Name: function_724944f0
	Namespace: supplydrop
	Checksum: 0xED3905BF
	Offset: 0x5F0
	Size: 0x8E
	Parameters: 1
	Flags: None
*/
function function_724944f0(localclientnum)
{
	player = self;
	player.markerfx = undefined;
	if(isdefined(player.markerobj))
	{
		player.markerobj delete();
	}
	if(isdefined(player.markerfxhandle))
	{
		killfx(localclientnum, player.markerfxhandle);
		player.markerfxhandle = undefined;
	}
}

/*
	Name: setupanimtree
	Namespace: supplydrop
	Checksum: 0xFD95303E
	Offset: 0x688
	Size: 0x3C
	Parameters: 0
	Flags: None
*/
function setupanimtree()
{
	if(self hasanimtree() == 0)
	{
		self useanimtree("generic");
	}
}

/*
	Name: supplydrop_care_package_state
	Namespace: supplydrop
	Checksum: 0x82803C38
	Offset: 0x6D0
	Size: 0xEC
	Parameters: 7
	Flags: None
*/
function supplydrop_care_package_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	self setupanimtree();
	if(newval == 1)
	{
		self setanim(#"o_drone_supply_care_idle", 1, 0, 1);
	}
	else
	{
		self setanim(#"o_drone_supply_care_drop", 1, 0, 0.3);
	}
}

/*
	Name: supplydrop_ai_tank_state
	Namespace: supplydrop
	Checksum: 0x2204C4D0
	Offset: 0x7C8
	Size: 0x76
	Parameters: 7
	Flags: None
*/
function supplydrop_ai_tank_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	self setupanimtree();
	if(newval == 1)
	{
	}
}

/*
	Name: updatemarkerthread
	Namespace: supplydrop
	Checksum: 0xDBF660FD
	Offset: 0x848
	Size: 0x13C
	Parameters: 1
	Flags: None
*/
function updatemarkerthread(localclientnum)
{
	self endoncallback(&function_724944f0, #"death");
	player = self;
	killstreakcorebundle = struct::get_script_bundle("killstreak", "killstreak_core");
	while(isdefined(player.markerobj))
	{
		viewangles = getlocalclientangles(localclientnum);
		forwardvector = vectorscale(anglestoforward(viewangles), killstreakcorebundle.ksmaxairdroptargetrange);
		results = bullettrace(player geteye(), player geteye() + forwardvector, 0, player);
		player.markerobj.origin = results[#"position"];
		waitframe(1);
	}
}

/*
	Name: stopcrateeffects
	Namespace: supplydrop
	Checksum: 0x7A9BE03C
	Offset: 0x990
	Size: 0x10A
	Parameters: 1
	Flags: None
*/
function stopcrateeffects(localclientnum)
{
	crate = self;
	if(isdefined(crate.thrusterfxhandle0))
	{
		stopfx(localclientnum, crate.thrusterfxhandle0);
	}
	if(isdefined(crate.thrusterfxhandle1))
	{
		stopfx(localclientnum, crate.thrusterfxhandle1);
	}
	if(isdefined(crate.thrusterfxhandle2))
	{
		stopfx(localclientnum, crate.thrusterfxhandle2);
	}
	if(isdefined(crate.thrusterfxhandle3))
	{
		stopfx(localclientnum, crate.thrusterfxhandle3);
	}
	crate.thrusterfxhandle0 = undefined;
	crate.thrusterfxhandle1 = undefined;
	crate.thrusterfxhandle2 = undefined;
	crate.thrusterfxhandle3 = undefined;
}

/*
	Name: cleanupthrustersthread
	Namespace: supplydrop
	Checksum: 0xF83EB421
	Offset: 0xAA8
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function cleanupthrustersthread(localclientnum)
{
	crate = self;
	crate notify(#"cleanupthrustersthread_singleton");
	crate endon(#"cleanupthrustersthread_singleton");
	crate waittill(#"death");
	crate stopcrateeffects(localclientnum);
}

/*
	Name: setsupplydropthrustersstate
	Namespace: supplydrop
	Checksum: 0x4E03A1D8
	Offset: 0xB28
	Size: 0x1D4
	Parameters: 7
	Flags: None
*/
function setsupplydropthrustersstate(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	crate = self;
	params = struct::get_script_bundle("killstreak", "killstreak_supply_drop");
	if(newval != oldval && isdefined(params.ksthrusterfx))
	{
		if(newval == 1)
		{
			crate stopcrateeffects(localclientnum);
			crate.thrusterfxhandle0 = util::playfxontag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_01");
			crate.thrusterfxhandle1 = util::playfxontag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_02");
			crate.thrusterfxhandle2 = util::playfxontag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_03");
			crate.thrusterfxhandle3 = util::playfxontag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_04");
			crate thread cleanupthrustersthread(localclientnum);
		}
		else
		{
			crate stopcrateeffects(localclientnum);
		}
	}
}

/*
	Name: setaitankhrustersstate
	Namespace: supplydrop
	Checksum: 0x528A0FA9
	Offset: 0xD08
	Size: 0x1D4
	Parameters: 7
	Flags: None
*/
function setaitankhrustersstate(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	crate = self;
	params = struct::get_script_bundle("killstreak", "killstreak_tank_robot");
	if(newval != oldval && isdefined(params.ksthrusterfx))
	{
		if(newval == 1)
		{
			crate stopcrateeffects(localclientnum);
			crate.thrusterfxhandle0 = util::playfxontag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_01");
			crate.thrusterfxhandle1 = util::playfxontag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_02");
			crate.thrusterfxhandle2 = util::playfxontag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_03");
			crate.thrusterfxhandle3 = util::playfxontag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_04");
			crate thread cleanupthrustersthread(localclientnum);
		}
		else
		{
			crate stopcrateeffects(localclientnum);
		}
	}
}

/*
	Name: marker_state_changed
	Namespace: supplydrop
	Checksum: 0x8D0A0365
	Offset: 0xEE8
	Size: 0x294
	Parameters: 7
	Flags: None
*/
function marker_state_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	player = self;
	killstreakcorebundle = struct::get_script_bundle("killstreak", "killstreak_core");
	if(newval == 1)
	{
		player.markerfx = killstreakcorebundle.fxvalidlocation;
	}
	else
	{
		if(newval == 2)
		{
			player.markerfx = killstreakcorebundle.fxinvalidlocation;
		}
		else
		{
			player.markerfx = undefined;
		}
	}
	if(isdefined(player.markerobj) && !player.markerobj hasdobj(localclientnum))
	{
		return;
	}
	if(isdefined(player.markerfxhandle))
	{
		killfx(localclientnum, player.markerfxhandle);
		player.markerfxhandle = undefined;
	}
	if(isdefined(player.markerfx))
	{
		if(!isdefined(player.markerobj))
		{
			player.markerobj = spawn(localclientnum, (0, 0, 0), "script_model");
			player.markerobj.angles = vectorscale((1, 0, 0), 270);
			player.markerobj setmodel(#"wpn_t7_none_world");
			player.markerobj util::waittill_dobj(localclientnum);
			player thread updatemarkerthread(localclientnum);
		}
		player.markerfxhandle = util::playfxontag(localclientnum, player.markerfx, player.markerobj, "tag_origin");
	}
	else if(isdefined(player.markerobj))
	{
		player.markerobj delete();
	}
}

