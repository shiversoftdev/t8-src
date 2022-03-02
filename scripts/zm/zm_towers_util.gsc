// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_35598499769dbb3d;
#using script_3f9e0dc8454d98e1;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_magicbox.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_11c28b18;

/*
	Name: function_ae1b4f5b
	Namespace: namespace_11c28b18
	Checksum: 0x71901E5
	Offset: 0x108
	Size: 0x1EC
	Parameters: 3
	Flags: Linked
*/
function function_ae1b4f5b(var_6888276a = 75, var_7d866d50 = 75, var_aadd0545 = 75)
{
	if(isdefined(self.no_gib) && self.no_gib)
	{
		return;
	}
	val = randomint(100);
	if(val > 100 - var_6888276a)
	{
		self zombie_utility::zombie_head_gib();
	}
	val = randomint(100);
	if(val > 100 - var_7d866d50)
	{
		if(!gibserverutils::isgibbed(self, 32))
		{
			gibserverutils::gibrightarm(self);
		}
	}
	val = randomint(100);
	if(val > 100 - var_7d866d50)
	{
		if(!gibserverutils::isgibbed(self, 16))
		{
			gibserverutils::gibleftarm(self);
		}
	}
	val = randomint(100);
	if(val > 100 - var_aadd0545)
	{
		gibserverutils::gibrightleg(self);
	}
	val = randomint(100);
	if(val > 100 - var_aadd0545)
	{
		gibserverutils::gibleftleg(self);
	}
}

/*
	Name: function_48f49769
	Namespace: namespace_11c28b18
	Checksum: 0xFD264F09
	Offset: 0x300
	Size: 0x178
	Parameters: 0
	Flags: Linked
*/
function function_48f49769()
{
	while(isdefined(self))
	{
		waittime = randomfloatrange(2.5, 5);
		yaw = randomint(360);
		if(yaw > 300)
		{
			yaw = 300;
		}
		else if(yaw < 60)
		{
			yaw = 60;
		}
		yaw = self.angles[1] + yaw;
		new_angles = (-60 + randomint(120), yaw, -45 + randomint(90));
		self rotateto(new_angles, waittime, waittime * 0.5, waittime * 0.5);
		if(isdefined(self.worldgundw))
		{
			self.worldgundw rotateto(new_angles, waittime, waittime * 0.5, waittime * 0.5);
		}
		wait(randomfloat(waittime - 0.1));
	}
}

/*
	Name: function_6408c105
	Namespace: namespace_11c28b18
	Checksum: 0xFFA3D21
	Offset: 0x480
	Size: 0x398
	Parameters: 0
	Flags: Linked
*/
function function_6408c105()
{
	/#
		assert(isdefined(level._spawned_wallbuys));
	#/
	foreach(wallbuy in level._spawned_wallbuys)
	{
		s_target = struct::get(wallbuy.target, "targetname");
		if(isdefined(s_target) && isdefined(s_target.target))
		{
			fx_wallbuy = getent(s_target.target, "targetname");
			if(isdefined(fx_wallbuy))
			{
				fx_wallbuy ghost();
			}
		}
		model = struct::get(wallbuy.target, "targetname");
		if(isdefined(model) && isdefined(model.target))
		{
			var_393a819e = getent(model.target, "targetname");
			if(isdefined(var_393a819e))
			{
				var_393a819e ghost();
			}
		}
		if(isdefined(wallbuy.trigger_stub) && isdefined(wallbuy.trigger_stub.clientfieldname))
		{
			/#
				assert(!isdefined(wallbuy.var_d6cca569));
			#/
			wallbuy.var_d6cca569 = level clientfield::get(wallbuy.trigger_stub.clientfieldname);
			level clientfield::set(wallbuy.trigger_stub.clientfieldname, 0);
		}
	}
	foreach(var_2b84085b in level.var_b5079c7c)
	{
		level exploder::exploder(var_2b84085b);
	}
	level thread function_fcf197fa("zombie_door", 0);
	a_structs = struct::get_array("perk_vapor_altar");
	foreach(s_struct in a_structs)
	{
		s_struct zm_perks::function_efd2c9e6();
	}
}

/*
	Name: function_1008e277
	Namespace: namespace_11c28b18
	Checksum: 0x52838612
	Offset: 0x820
	Size: 0x378
	Parameters: 0
	Flags: Linked
*/
function function_1008e277()
{
	/#
		assert(isdefined(level._spawned_wallbuys));
	#/
	foreach(wallbuy in level._spawned_wallbuys)
	{
		target_struct = struct::get(wallbuy.target, "targetname");
		if(isdefined(target_struct) && isdefined(target_struct.target))
		{
			wallbuy_fx = getent(target_struct.target, "targetname");
			if(isdefined(wallbuy_fx))
			{
				wallbuy_fx show();
			}
		}
		model = struct::get(wallbuy.target, "targetname");
		if(isdefined(model) && isdefined(model.target))
		{
			var_393a819e = getent(model.target, "targetname");
			if(isdefined(var_393a819e))
			{
				var_393a819e show();
			}
		}
		if(isdefined(wallbuy.trigger_stub) && isdefined(wallbuy.trigger_stub.clientfieldname))
		{
			/#
				assert(isdefined(wallbuy.var_d6cca569));
			#/
			level clientfield::set(wallbuy.trigger_stub.clientfieldname, wallbuy.var_d6cca569);
			wallbuy.var_d6cca569 = undefined;
		}
	}
	foreach(var_2b84085b in level.var_b5079c7c)
	{
		level exploder::exploder_stop(var_2b84085b);
	}
	level thread function_fcf197fa("zombie_door", 1);
	a_structs = struct::get_array("perk_vapor_altar");
	foreach(s_struct in a_structs)
	{
		s_struct zm_perks::function_1e721859();
	}
}

/*
	Name: function_fcf197fa
	Namespace: namespace_11c28b18
	Checksum: 0x4C9788F1
	Offset: 0xBA0
	Size: 0x23A
	Parameters: 2
	Flags: Linked, Private
*/
function private function_fcf197fa(targetname, b_show)
{
	var_dc3827e3 = getentarray(targetname, "targetname");
	if(isdefined(var_dc3827e3))
	{
		foreach(blocker in var_dc3827e3)
		{
			if(isdefined(blocker.target))
			{
				var_6a2895e6 = getentarray(blocker.target, "targetname");
				if(isdefined(var_6a2895e6))
				{
					foreach(var_1d6a70e8 in var_6a2895e6)
					{
						if(isdefined(var_1d6a70e8.objectid) && !var_1d6a70e8 zm_utility::function_1a4d2910())
						{
							switch(var_1d6a70e8.objectid)
							{
								case "symbol_back_debris":
								case "symbol_front_power":
								case "symbol_back":
								case "symbol_front":
								case "symbol_front_debris":
								case "symbol_back_power":
								{
									if(b_show)
									{
										var_1d6a70e8 show();
									}
									else
									{
										var_1d6a70e8 ghost();
									}
									break;
								}
								default:
								{
									break;
								}
							}
						}
					}
				}
			}
		}
	}
}

/*
	Name: function_afd37143
	Namespace: namespace_11c28b18
	Checksum: 0x491FB485
	Offset: 0xDE8
	Size: 0x6E
	Parameters: 1
	Flags: Linked
*/
function function_afd37143(str_line)
{
	for(i = 0; i < level.players.size; i++)
	{
		if(isdefined(level.players[i]))
		{
			level.players[i] thread function_9821b7f1(str_line);
		}
	}
}

/*
	Name: function_9821b7f1
	Namespace: namespace_11c28b18
	Checksum: 0x8966195A
	Offset: 0xE60
	Size: 0x9C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_9821b7f1(str_line)
{
	self endon(#"disconnect");
	while(isdefined(self.zmannouncertalking) && self.zmannouncertalking || (isdefined(self.isspeaking) && self.isspeaking) || (isdefined(self.var_5b6ebfd0) && self.var_5b6ebfd0))
	{
		wait(0.5);
	}
	level zm_audio::sndannouncerplayvox(str_line, self);
}

/*
	Name: function_c05cc102
	Namespace: namespace_11c28b18
	Checksum: 0xFE2FDA6A
	Offset: 0xF08
	Size: 0x160
	Parameters: 1
	Flags: Linked
*/
function function_c05cc102(s_params)
{
	self endon(#"death");
	if(s_params.weapon != level.var_43db5ea6)
	{
		return;
	}
	var_be17187b = undefined;
	var_be17187b = s_params.projectile waittill(#"projectile_impact_explode", #"explode", #"death");
	if(isdefined(s_params.projectile) && var_be17187b._notify == "death")
	{
		level notify(#"hash_3042a9bf2f57ea0a", {#hash_814c9389:s_params.projectile.origin, #attacker:self});
	}
	else if(var_be17187b._notify == "projectile_impact_explode")
	{
		level notify(#"hash_3042a9bf2f57ea0a", {#hash_814c9389:var_be17187b.position, #attacker:self});
	}
}

