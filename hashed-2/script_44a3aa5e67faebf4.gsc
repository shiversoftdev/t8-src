// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3aa0f32b70d4f7cb;
#using script_3f9e0dc8454d98e1;
#using script_caf007e2a98afa2;
#using script_db06eb511bd9b36;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;

#namespace namespace_af9faf28;

/*
	Name: function_89f2df9
	Namespace: namespace_af9faf28
	Checksum: 0x5A7E462C
	Offset: 0x100
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_6d2716025c669985", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_af9faf28
	Checksum: 0xCDC67937
	Offset: 0x150
	Size: 0x3AE
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	/#
		assert(isscriptfunctionptr(&function_dedfe444));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7a881cd7648d875a", &function_dedfe444);
	/#
		assert(isscriptfunctionptr(&function_79554a79));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6049ac9ce94751b0", &function_79554a79);
	/#
		assert(!isdefined(&function_fc646a7e) || isscriptfunctionptr(&function_fc646a7e));
	#/
	/#
		assert(!isdefined(&function_d31cb502) || isscriptfunctionptr(&function_d31cb502));
	#/
	/#
		assert(!isdefined(&function_1a4b60ca) || isscriptfunctionptr(&function_1a4b60ca));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"hash_4a47f3f524ce4354", &function_fc646a7e, &function_d31cb502, &function_1a4b60ca);
	/#
		assert(!isdefined(&function_a2185434) || isscriptfunctionptr(&function_a2185434));
	#/
	/#
		assert(!isdefined(&function_48ef356e) || isscriptfunctionptr(&function_48ef356e));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"hash_6b33c79337b1854f", &function_a2185434, &function_48ef356e, undefined);
	/#
		adddebugcommand("");
		adddebugcommand("");
	#/
	zm_cleanup::function_cdf5a512(#"zombie", &function_16f40942);
	level.var_e5a996e8 = &function_e5a996e8;
}

/*
	Name: __main__
	Namespace: namespace_af9faf28
	Checksum: 0x80F724D1
	Offset: 0x508
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: function_61418721
	Namespace: namespace_af9faf28
	Checksum: 0x9512DD20
	Offset: 0x518
	Size: 0x96
	Parameters: 3
	Flags: Linked
*/
function function_61418721(point, line_start, line_end)
{
	var_13d62e0a = point - line_start;
	var_1ad356b8 = vectornormalize(line_end - line_start);
	var_f6451fc1 = vectordot(var_13d62e0a, var_1ad356b8);
	closest_point = line_start + var_1ad356b8 * var_f6451fc1;
	return closest_point;
}

/*
	Name: number_b_
	Namespace: namespace_af9faf28
	Checksum: 0x2A1DF6A2
	Offset: 0x5B8
	Size: 0xDC
	Parameters: 4
	Flags: Linked
*/
function number_b_(var_5c57c958, var_f3e138f3, var_3800dad7, plane_normal)
{
	var_a979e3a2 = vectordot(plane_normal, var_f3e138f3);
	result = undefined;
	if(abs(var_a979e3a2) > 0.001)
	{
		var_fa608360 = var_3800dad7 - var_5c57c958;
		var_bc4566f4 = vectordot(var_fa608360, plane_normal);
		var_c7ca84dc = var_bc4566f4 / var_a979e3a2;
		if(var_c7ca84dc >= 0)
		{
			result = var_c7ca84dc;
		}
	}
	return result;
}

/*
	Name: function_dc61ccae
	Namespace: namespace_af9faf28
	Checksum: 0xF5935D8D
	Offset: 0x6A0
	Size: 0x674
	Parameters: 3
	Flags: None
*/
function function_dc61ccae(vnd_start, var_6f06d19d, var_ca144d1e)
{
	self endon(#"death");
	self.var_b20b0960 endon(#"death");
	while(true)
	{
		waitframe(1);
		enabled = getdvarint(#"hash_6e0cbdce6b2104a3", 0);
		if(enabled)
		{
			var_8e89eaf2 = self gettagorigin("tag_weapon_left");
			var_bb4eaebf = getvehiclenode(vnd_start.target, "targetname");
			var_3573db0e = function_61418721(var_8e89eaf2, vnd_start.origin, var_bb4eaebf.origin);
			var_f687fa19 = var_3573db0e - var_8e89eaf2;
			var_56b5839 = length(var_f687fa19);
			/#
				sphere(self.var_b20b0960.origin, 2, (0, 1, 0), 0.3, 0, 8, 1);
				line(var_8e89eaf2, var_3573db0e, (1, 1, 0));
				sphere(var_8e89eaf2, 2, (1, 0.5, 0), 0.3, 0, 8, 1);
			#/
			if(isdefined(var_6f06d19d) && isdefined(var_ca144d1e))
			{
				var_af2e4b51 = function_61418721(self.var_b20b0960.origin, var_6f06d19d, var_ca144d1e);
				var_2b30dcba = vectornormalize(self.var_b20b0960.origin - var_af2e4b51);
				var_41aabd6d = number_b_(self.var_b20b0960.origin, (0, 0, 1), var_af2e4b51, var_2b30dcba);
				if(isdefined(var_41aabd6d))
				{
					var_b43bc141 = self.var_b20b0960.origin + (0, 0, 1) * var_41aabd6d;
					height_difference = var_b43bc141[2] - self.var_b20b0960.origin[2];
					/#
						line(self.var_b20b0960.origin, var_b43bc141, (1, 0, 1));
						record3dtext("" + height_difference, self.var_b20b0960.origin, (1, 1, 1), "");
					#/
				}
				var_3a080e11 = function_61418721(var_8e89eaf2, var_6f06d19d, var_ca144d1e);
				var_2eb8d479 = var_3a080e11 + (0, 0, 1);
				forward = vectornormalize(var_bb4eaebf.origin - vnd_start.origin);
				right = vectorcross((0, 0, 1), forward);
				up = vectorcross(forward, right);
				angles = axistoangles(forward, up);
				var_c246e8d5 = function_e2ee5807(var_3a080e11, var_8e89eaf2, angles);
				var_e941deaa = vectornormalize(var_c246e8d5);
				/#
					line(var_8e89eaf2, var_8e89eaf2 + var_c246e8d5, (1, 0, 1));
					line(var_6f06d19d, var_ca144d1e, (1, 0.5, 0));
					line(var_8e89eaf2, var_3a080e11, (1, 1, 0));
					sphere(var_6f06d19d, 8, (1, 0.5, 0), 0.3, 0, 8, 1);
					sphere(var_ca144d1e, 8, (1, 0.5, 0), 0.3, 0, 8, 1);
					record3dtext("" + var_c246e8d5, var_8e89eaf2 + var_c246e8d5, (1, 1, 1), "");
				#/
			}
			var_31120f24 = vnd_start;
			while(isdefined(var_31120f24.target))
			{
				var_bb4eaebf = getvehiclenode(var_31120f24.target, "targetname");
				/#
					sphere(var_31120f24.origin, 5, (1, 1, 0), 1, 0, 8, 1);
					sphere(var_bb4eaebf.origin, 5, (1, 1, 0), 1, 0, 8, 1);
					line(var_31120f24.origin, var_bb4eaebf.origin, (1, 1, 0));
				#/
				var_31120f24 = var_bb4eaebf;
			}
		}
	}
}

/*
	Name: function_aeb6539c
	Namespace: namespace_af9faf28
	Checksum: 0x1F0C2AE0
	Offset: 0xD20
	Size: 0x9C
	Parameters: 2
	Flags: Linked
*/
function function_aeb6539c(origin, angles)
{
	self endon(#"disconnect");
	self.var_f22c83f5 = 1;
	self.var_e75517b1 = 1;
	self.allowpain = 0;
	self forceteleport(origin, angles);
	self linkto(self.var_b20b0960, "tag_origin", (0, 0, 0), angles * (-1, 0, 0));
}

/*
	Name: function_dedfe444
	Namespace: namespace_af9faf28
	Checksum: 0x5D33BD4
	Offset: 0xDC8
	Size: 0xCC
	Parameters: 1
	Flags: Linked, Private
*/
private function function_dedfe444(entity)
{
	if(isdefined(entity.traversestartnode) && isdefined(entity.traversestartnode.script_noteworthy) && entity.traversestartnode.script_noteworthy == "zipline_traversal" && isdefined(entity.traversestartnode.var_e45a0969) && entity shouldstarttraversal())
	{
		/#
			record3dtext("", self.origin, (1, 0, 0), "");
		#/
		return 1;
	}
	return 0;
}

/*
	Name: function_79554a79
	Namespace: namespace_af9faf28
	Checksum: 0xFEFF4AD6
	Offset: 0xEA0
	Size: 0x46
	Parameters: 1
	Flags: Linked, Private
*/
private function function_79554a79(entity)
{
	entity.vnd_start = getvehiclenode(entity.traversestartnode.var_e45a0969, "targetname");
}

/*
	Name: function_4e6fe1be
	Namespace: namespace_af9faf28
	Checksum: 0xD035C677
	Offset: 0xEF0
	Size: 0x52
	Parameters: 0
	Flags: Linked, Private
*/
private function function_4e6fe1be()
{
	self endon(#"death");
	self.var_b20b0960 = spawner::simple_spawn_single(getent("veh_fasttravel", "targetname"));
}

/*
	Name: function_fc646a7e
	Namespace: namespace_af9faf28
	Checksum: 0x11351EB9
	Offset: 0xF50
	Size: 0x60
	Parameters: 2
	Flags: Linked, Private
*/
private function function_fc646a7e(entity, asmstatename)
{
	animationstatenetworkutility::requeststate(entity, asmstatename);
	entity.var_bf8dfaf4 = 1;
	entity.var_b20b0960 = undefined;
	entity thread function_4e6fe1be();
	return 5;
}

/*
	Name: function_d31cb502
	Namespace: namespace_af9faf28
	Checksum: 0x51447ABC
	Offset: 0xFB8
	Size: 0x26A
	Parameters: 2
	Flags: Linked, Private
*/
private function function_d31cb502(entity, asmstatename)
{
	result = 5;
	if(isdefined(entity.var_b20b0960))
	{
		if(!(isdefined(entity.var_b20b0960.vehonpath) && entity.var_b20b0960.vehonpath))
		{
			entity.var_b20b0960.origin = entity.vnd_start.origin;
			entity.var_b20b0960.angles = entity.vnd_start.angles;
			entity.var_b20b0960 setspeed(32);
			entity function_aeb6539c(entity.vnd_start.origin, entity.vnd_start.angles);
			entity.var_b20b0960 thread vehicle::get_on_and_go_path(entity.vnd_start);
			/#
				line_start = struct::get(entity.vnd_start.target + "", "");
				line_end = struct::get(entity.vnd_start.target + "", "");
				if(isdefined(line_start) && isdefined(line_end))
				{
					self thread function_dc61ccae(entity.vnd_start, line_start.origin, line_end.origin);
				}
				else
				{
					self thread function_dc61ccae(entity.vnd_start);
				}
			#/
		}
		else if(isdefined(entity.var_b20b0960.var_d4b82e45) && entity.var_b20b0960.var_d4b82e45 == 1)
		{
			result = 4;
		}
	}
	return result;
}

/*
	Name: function_1a4b60ca
	Namespace: namespace_af9faf28
	Checksum: 0x1B78C402
	Offset: 0x1230
	Size: 0x78
	Parameters: 2
	Flags: Linked, Private
*/
private function function_1a4b60ca(entity, asmstatename)
{
	entity unlink();
	entity.var_bf8dfaf4 = 0;
	entity.allowpain = 1;
	if(isdefined(self.var_b20b0960))
	{
		entity.var_b20b0960 delete();
	}
	return 4;
}

/*
	Name: function_a2185434
	Namespace: namespace_af9faf28
	Checksum: 0x2EB2E8FE
	Offset: 0x12B0
	Size: 0x30
	Parameters: 2
	Flags: Linked, Private
*/
private function function_a2185434(entity, asmstatename)
{
	animationstatenetworkutility::requeststate(entity, asmstatename);
	return 5;
}

/*
	Name: function_48ef356e
	Namespace: namespace_af9faf28
	Checksum: 0x7CCF266B
	Offset: 0x12E8
	Size: 0x4A
	Parameters: 2
	Flags: Linked, Private
*/
private function function_48ef356e(entity, asmstatename)
{
	result = 5;
	if(entity isonground())
	{
		result = 4;
	}
	return result;
}

/*
	Name: function_16f40942
	Namespace: namespace_af9faf28
	Checksum: 0xCFE4ECC9
	Offset: 0x1340
	Size: 0x38
	Parameters: 0
	Flags: Linked, Private
*/
private function function_16f40942()
{
	result = 0;
	if(isdefined(self.var_bf8dfaf4) && self.var_bf8dfaf4)
	{
		result = 1;
	}
	return result;
}

/*
	Name: function_e5a996e8
	Namespace: namespace_af9faf28
	Checksum: 0x929C00D2
	Offset: 0x1380
	Size: 0x9A
	Parameters: 2
	Flags: Linked, Private
*/
private function function_e5a996e8(player, zone)
{
	result = undefined;
	if(isdefined(player.last_valid_position))
	{
		result = function_52c1730(player.last_valid_position, zone.nodes, 500);
	}
	else
	{
		result = function_52c1730(player.origin, zone.nodes, 500);
	}
	return result;
}

