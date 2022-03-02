// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\math_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\vehicle_shared.csc;

#namespace namespace_25e7a951;

/*
	Name: function_89f2df9
	Namespace: namespace_25e7a951
	Checksum: 0x20061FDE
	Offset: 0x1F8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_6904e1bbfeec0434", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_25e7a951
	Checksum: 0x93DC7979
	Offset: 0x240
	Size: 0x244
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.remote_missile_targets = [];
	level.var_70a07f6f = &function_70a07f6f;
	level.var_e656f88a = &function_e656f88a;
	level.var_dde557d5 = 0;
	level.hawk_settings = spawnstruct();
	level.hawk_settings.bundle = getscriptbundle("hawk_settings");
	for(ti = 0; ti < 6; ti++)
	{
		level.remote_missile_targets[ti] = spawnstruct();
		clientfield::function_346f95ba("hawk_target_lockon" + ti, "target_visible", 13000, 1, "int", undefined, 0, 0);
	}
	clientfield::register("vehicle", "hawk_range", 13000, 1, "int", &function_6701affc, 0, 1);
	vehicle::add_vehicletype_callback("veh_hawk_player_mp", &hawk_spawned);
	vehicle::function_2f97bc52("veh_hawk_player_mp", &function_fbdbb841);
	vehicle::function_2f97bc52("veh_hawk_player_far_range_mp", &function_1ed9ef6a);
	vehicle::function_cd2ede5("veh_hawk_player_mp", &function_500d3fa7);
	vehicle::function_cd2ede5("veh_hawk_player_far_range_mp", &function_fc1227ca);
	callback::on_localplayer_spawned(&on_local_player_spawned);
}

/*
	Name: hawk_spawned
	Namespace: namespace_25e7a951
	Checksum: 0x8DE05FD1
	Offset: 0x490
	Size: 0x3C
	Parameters: 1
	Flags: Linked, Private
*/
function private hawk_spawned(localclientnum)
{
	self.var_51d5c26f = level.hawk_settings.bundle;
	self thread function_23a9e4af(localclientnum);
}

/*
	Name: function_23a9e4af
	Namespace: namespace_25e7a951
	Checksum: 0xDDA19F3B
	Offset: 0x4D8
	Size: 0x17C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_23a9e4af(localclientnum)
{
	self endon(#"death");
	while(!isdefined(self.owner))
	{
		wait(0.1);
	}
	if(isplayer(self.owner) && self.owner function_21c0fa55())
	{
		setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.hawkActive"), 1);
		self setcompassicon("icon_minimap_hawk");
		self function_811196d1(0);
		self function_5e00861(1.5);
		self function_a5edb367(#"gold");
		self thread function_2e07be71(localclientnum);
		self thread function_5a1bf101(localclientnum);
	}
	else
	{
		self function_811196d1(1);
	}
}

/*
	Name: function_70a07f6f
	Namespace: namespace_25e7a951
	Checksum: 0x42F437D0
	Offset: 0x660
	Size: 0x7C
	Parameters: 3
	Flags: Linked
*/
function function_70a07f6f(localclientnum, newval, fieldname)
{
	for(ti = 0; ti < 6; ti++)
	{
		if(fieldname == (("luielement.remote_missile_target_lockon" + ti) + ".clientnum"))
		{
			level.remote_missile_targets[ti].clientnum = newval;
		}
	}
}

/*
	Name: function_e656f88a
	Namespace: namespace_25e7a951
	Checksum: 0x32ADFED7
	Offset: 0x6E8
	Size: 0x96
	Parameters: 3
	Flags: Linked
*/
function function_e656f88a(localclientnum, newval, fieldname)
{
	for(ti = 0; ti < 6; ti++)
	{
		if(fieldname == (("luielement.remote_missile_target_lockon" + ti) + ".target_locked"))
		{
			if(newval)
			{
				playsound(localclientnum, level.hawk_settings.bundle.tag_sound);
			}
		}
	}
}

/*
	Name: function_fbdbb841
	Namespace: namespace_25e7a951
	Checksum: 0x3A91369E
	Offset: 0x788
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function function_fbdbb841(localclientnum, vehicle)
{
	if(!self function_21c0fa55())
	{
		return;
	}
	function_775073e(localclientnum);
}

/*
	Name: function_1ed9ef6a
	Namespace: namespace_25e7a951
	Checksum: 0xFB3FB64F
	Offset: 0x7D8
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function function_1ed9ef6a(localclientnum, vehicle)
{
	if(!self function_21c0fa55())
	{
		return;
	}
	function_6367489e(localclientnum);
}

/*
	Name: function_500d3fa7
	Namespace: namespace_25e7a951
	Checksum: 0x2ADE28B3
	Offset: 0x828
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function function_500d3fa7(localclientnum, vehicle)
{
	if(!self function_21c0fa55())
	{
		return;
	}
	function_3759fcf(localclientnum);
}

/*
	Name: function_fc1227ca
	Namespace: namespace_25e7a951
	Checksum: 0xDD96DBA9
	Offset: 0x878
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function function_fc1227ca(localclientnum, vehicle)
{
	if(!self function_21c0fa55())
	{
		return;
	}
	function_3759fcf(localclientnum);
}

/*
	Name: on_local_player_spawned
	Namespace: namespace_25e7a951
	Checksum: 0xE52066DA
	Offset: 0x8C8
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function on_local_player_spawned(localclientnum)
{
	player = function_5c10bd79(localclientnum);
	vehicle = getplayervehicle(player);
	if(isdefined(vehicle) && (vehicle.vehicletype === #"veh_hawk_player_mp" || vehicle.vehicletype === #"veh_hawk_player_far_range_mp"))
	{
		return;
	}
	function_3759fcf(localclientnum);
}

/*
	Name: function_6701affc
	Namespace: namespace_25e7a951
	Checksum: 0x39B211FC
	Offset: 0x988
	Size: 0x104
	Parameters: 7
	Flags: Linked
*/
function function_6701affc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(self.vehicletype != #"veh_hawk_player_mp" && self.vehicletype != #"veh_hawk_player_far_range_mp")
	{
		return;
	}
	player = function_5c10bd79(localclientnum);
	vehicle = getplayervehicle(player);
	if(isdefined(vehicle) && self == vehicle)
	{
		if(newval > 0)
		{
			function_6367489e(localclientnum);
		}
		else
		{
			function_775073e(localclientnum);
		}
	}
}

/*
	Name: function_775073e
	Namespace: namespace_25e7a951
	Checksum: 0x5485AE82
	Offset: 0xA98
	Size: 0xE4
	Parameters: 1
	Flags: Linked
*/
function function_775073e(localclientnum)
{
	if(function_148ccc79(localclientnum, #"hash_63b0389eb9286669"))
	{
		codestoppostfxbundlelocal(localclientnum, #"hash_63b0389eb9286669");
	}
	if(!function_148ccc79(localclientnum, #"hash_594d5293046135ff"))
	{
		function_a837926b(localclientnum, #"hash_594d5293046135ff");
	}
	var_e39026ad = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.hawkWeakSignal");
	if(isdefined(var_e39026ad))
	{
		setuimodelvalue(var_e39026ad, 0);
	}
}

/*
	Name: function_6367489e
	Namespace: namespace_25e7a951
	Checksum: 0xC2FF78D7
	Offset: 0xB88
	Size: 0xEC
	Parameters: 1
	Flags: Linked
*/
function function_6367489e(localclientnum)
{
	if(function_148ccc79(localclientnum, #"hash_594d5293046135ff"))
	{
		codestoppostfxbundlelocal(localclientnum, #"hash_594d5293046135ff");
	}
	if(!function_148ccc79(localclientnum, #"hash_63b0389eb9286669"))
	{
		function_a837926b(localclientnum, #"hash_63b0389eb9286669");
	}
	var_e39026ad = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.hawkWeakSignal");
	if(isdefined(var_e39026ad))
	{
		setuimodelvalue(var_e39026ad, 1);
	}
}

/*
	Name: function_3759fcf
	Namespace: namespace_25e7a951
	Checksum: 0x67ECC746
	Offset: 0xC80
	Size: 0xEC
	Parameters: 2
	Flags: Linked
*/
function function_3759fcf(localclientnum, var_c5e2f09a)
{
	if(function_148ccc79(localclientnum, #"hash_594d5293046135ff"))
	{
		codestoppostfxbundlelocal(localclientnum, #"hash_594d5293046135ff");
	}
	if(function_148ccc79(localclientnum, #"hash_63b0389eb9286669"))
	{
		codestoppostfxbundlelocal(localclientnum, #"hash_63b0389eb9286669");
	}
	var_e39026ad = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.hawkWeakSignal");
	if(isdefined(var_e39026ad))
	{
		setuimodelvalue(var_e39026ad, 0);
	}
}

/*
	Name: function_2e07be71
	Namespace: namespace_25e7a951
	Checksum: 0x5C48AE2F
	Offset: 0xD78
	Size: 0x15C
	Parameters: 1
	Flags: Linked
*/
function function_2e07be71(localclientnum)
{
	var_fa108926 = (localclientnum + "_") + self getentitynumber();
	self notify("cfc7ae5c0a7a3ce" + var_fa108926);
	self endon("cfc7ae5c0a7a3ce" + var_fa108926);
	/#
		assert(isdefined(self.owner));
	#/
	var_3216cebd = self.owner getentitynumber();
	self waittill(#"death");
	if(isdefined(var_3216cebd))
	{
		var_dff09cb4 = getentbynum(localclientnum, var_3216cebd);
		if(isdefined(var_dff09cb4) && isplayer(var_dff09cb4) && var_dff09cb4 function_21c0fa55())
		{
			setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.hawkActive"), 0);
		}
	}
}

/*
	Name: function_5a1bf101
	Namespace: namespace_25e7a951
	Checksum: 0xEA7B787B
	Offset: 0xEE0
	Size: 0x8EE
	Parameters: 1
	Flags: Linked
*/
function function_5a1bf101(localclientnum)
{
	var_fa108926 = (localclientnum + "_") + self getentitynumber();
	self notify("7f2100a11fa32baf" + var_fa108926);
	self endon("7f2100a11fa32baf" + var_fa108926);
	self endon(#"death");
	var_dff09cb4 = self.owner;
	controllermodel = getuimodelforcontroller(localclientnum);
	var_84528d5d = 0.5;
	var_9acf630f = 0.3;
	var_8ecbc09b = 2;
	if(isdefined(level.hawk_settings) && isdefined(level.hawk_settings.bundle))
	{
		bundle = level.hawk_settings.bundle;
	}
	if(isdefined(bundle))
	{
		var_59d4144b = (isdefined(bundle.var_59d4144b) ? bundle.var_59d4144b : 0.5);
		var_e7c561e2 = (isdefined(bundle.var_e7c561e2) ? bundle.var_e7c561e2 : 0.3);
		var_98977cea = (isdefined(bundle.var_98977cea) ? bundle.var_98977cea : 2);
	}
	var_ebf5b862 = [];
	var_15d793e8 = [];
	var_1f3cc5f9 = [];
	var_2e31947c = [];
	for(ti = 0; ti < 6; ti++)
	{
		var_9935a809 = "luielement.remote_missile_target_lockon" + ti;
		var_24a98e1f = var_9935a809 + ".target_locked";
		var_ebf5b862[ti] = createuimodel(controllermodel, var_24a98e1f);
		var_b4fbb3cb = var_9935a809 + ".clientnum";
		var_15d793e8[ti] = createuimodel(controllermodel, var_b4fbb3cb);
		var_3d384de3 = var_9935a809 + ".lockonScale";
		var_1f3cc5f9[ti] = createuimodel(controllermodel, var_3d384de3);
		var_907cb130 = var_9935a809 + ".lockonObscured";
		var_78e27c6d[ti] = createuimodel(controllermodel, var_907cb130);
	}
	var_c0443ab2 = 0;
	var_8736e321 = 1;
	var_6c8b920a = [];
	var_7cb3c06f = [];
	var_7cb3c06f[#"stand"] = vectorscale((0, 0, 1), 60);
	var_7cb3c06f[#"crouch"] = vectorscale((0, 0, 1), 40);
	var_7cb3c06f[#"prone"] = vectorscale((0, 0, 1), 12);
	while(isdefined(var_dff09cb4) && isplayer(var_dff09cb4) && var_dff09cb4 function_21c0fa55())
	{
		if(var_dff09cb4 isremotecontrolling(localclientnum))
		{
			if(!isinvehicle(localclientnum, self) && isdefined(var_dff09cb4.weapon) && var_dff09cb4.weapon.statname == #"remote_missile")
			{
				if(var_c0443ab2)
				{
					function_86f17acc(controllermodel, var_1f3cc5f9);
					var_6c8b920a = [];
					var_c0443ab2 = 0;
				}
				wait(0.1);
				continue;
			}
		}
		/#
			if(isdefined(bundle))
			{
				var_59d4144b = (isdefined(bundle.var_59d4144b) ? bundle.var_59d4144b : 0.5);
				var_e7c561e2 = (isdefined(bundle.var_e7c561e2) ? bundle.var_e7c561e2 : 0.3);
				var_98977cea = (isdefined(bundle.var_98977cea) ? bundle.var_98977cea : 2);
			}
		#/
		now = var_dff09cb4 getclienttime();
		var_c0443ab2 = 1;
		var_1d7ce7ba = project2dto3d(localclientnum, 0, 0, 12);
		var_14569a7a = 0;
		cam_angles = getcamanglesbylocalclientnum(localclientnum);
		var_ca5159f1 = anglestoforward(cam_angles);
		for(ti = 0; ti < 6; ti++)
		{
			if(getuimodelvalue(var_ebf5b862[ti]) == 0)
			{
				var_6c8b920a[ti] = undefined;
				continue;
			}
			var_8347ac20 = getuimodelvalue(var_15d793e8[ti]);
			target_player = getentbynum(localclientnum, var_8347ac20);
			if(!isdefined(target_player) || !isplayer(target_player))
			{
				var_6c8b920a[ti] = undefined;
				continue;
			}
			if(vectordot(var_ca5159f1, target_player.origin - var_1d7ce7ba) < 0)
			{
				var_6c8b920a[ti] = undefined;
				continue;
			}
			if(!isdefined(var_6c8b920a[ti]))
			{
				var_6c8b920a[ti] = (now - 100) - 10;
			}
			var_4759b4d3 = project3dto2d(localclientnum, target_player.origin);
			var_20a99afd = project3dto2d(localclientnum, target_player.origin + vectorscale((0, 0, 1), 60));
			screen_height = distance2d(var_4759b4d3, var_20a99afd);
			var_fcd926d5 = (var_59d4144b * screen_height) / 60;
			var_fcd926d5 = math::clamp(var_fcd926d5, var_e7c561e2, var_98977cea);
			setuimodelvalue(var_1f3cc5f9[ti], var_fcd926d5);
			cooldown_time = now - var_6c8b920a[ti];
			if(var_14569a7a < 1 || cooldown_time > 200)
			{
				if(cooldown_time > 100)
				{
					var_6c8b920a[ti] = now;
					var_14569a7a++;
					trace = bullettrace(var_1d7ce7ba, target_player.origin + var_7cb3c06f[target_player getstance()], 0, var_dff09cb4);
					if(isdefined(trace))
					{
						var_d7caaee9 = trace[#"fraction"] < 1;
						setuimodelvalue(var_78e27c6d[ti], var_d7caaee9);
					}
				}
			}
		}
		waitframe(1);
		if(isdefined(self.owner))
		{
			var_dff09cb4 = self.owner;
		}
	}
}

/*
	Name: function_86f17acc
	Namespace: namespace_25e7a951
	Checksum: 0x39122974
	Offset: 0x17D8
	Size: 0x5E
	Parameters: 2
	Flags: Linked
*/
function function_86f17acc(controllermodel, var_1f3cc5f9)
{
	for(ti = 0; ti < 6; ti++)
	{
		setuimodelvalue(var_1f3cc5f9[ti], 1);
	}
}

