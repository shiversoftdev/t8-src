// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\killstreaks\ai\tracking.gsc;
#using scripts\killstreaks\ai\state.gsc;
#using scripts\killstreaks\ai\target.gsc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace ai_escort;

/*
	Name: init
	Namespace: ai_escort
	Checksum: 0xD046702C
	Offset: 0xA0
	Size: 0x74
	Parameters: 0
	Flags: None
*/
function init()
{
	ai_state::function_e9b061a8(1, &function_ae92f67d, &function_92ed3ce9, undefined, &function_5d31deb6, &function_4af1ff64, &function_a78474f2, &update_debug);
}

/*
	Name: function_1b378f6d
	Namespace: ai_escort
	Checksum: 0xC092DC32
	Offset: 0x120
	Size: 0xC2
	Parameters: 5
	Flags: Private
*/
function private function_1b378f6d(var_5a529222, var_edc20efd, var_d73e0c6e, var_544ae93d, var_db083d2c)
{
	/#
		assert(isdefined(self.ai));
	#/
	self.ai.escort = {#hash_db083d2c:var_db083d2c, #hash_544ae93d:var_544ae93d, #hash_d73e0c6e:var_d73e0c6e, #hash_edc20efd:var_edc20efd, #hash_5a529222:var_5a529222, #state:2};
}

/*
	Name: function_60415868
	Namespace: ai_escort
	Checksum: 0x2DF4BCC5
	Offset: 0x1F0
	Size: 0x84
	Parameters: 1
	Flags: None
*/
function function_60415868(bundle)
{
	self.ai.bundle = bundle;
	function_1b378f6d((isdefined(bundle.var_d6c2930c) ? bundle.var_d6c2930c : 100), bundle.var_c45a5808, bundle.var_ee9fdcf3, bundle.var_946f502c, bundle.var_52c674ec);
}

/*
	Name: function_ae92f67d
	Namespace: ai_escort
	Checksum: 0x68A0F7E9
	Offset: 0x280
	Size: 0x22
	Parameters: 0
	Flags: None
*/
function function_ae92f67d()
{
	self.goalradius = self.ai.escort.var_5a529222;
}

/*
	Name: function_4af1ff64
	Namespace: ai_escort
	Checksum: 0x26A0A896
	Offset: 0x2B0
	Size: 0x4E
	Parameters: 0
	Flags: None
*/
function function_4af1ff64()
{
	if(self function_7e09d4ab())
	{
		return self.ai.escort.var_edc20efd;
	}
	return self.ai.escort.var_d73e0c6e;
}

/*
	Name: function_a78474f2
	Namespace: ai_escort
	Checksum: 0x1C89B59A
	Offset: 0x308
	Size: 0xA
	Parameters: 0
	Flags: None
*/
function function_a78474f2()
{
	return self.origin;
}

/*
	Name: function_7e09d4ab
	Namespace: ai_escort
	Checksum: 0x8D1E4969
	Offset: 0x320
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function function_7e09d4ab()
{
	if(self.ai.escort.state == 1)
	{
		return true;
	}
	return false;
}

/*
	Name: function_c6c4dd36
	Namespace: ai_escort
	Checksum: 0xB25BB65B
	Offset: 0x358
	Size: 0x4E
	Parameters: 0
	Flags: None
*/
function function_c6c4dd36()
{
	if(self.ai.escort.state == 1 || self.ai.escort.state == 2)
	{
		return true;
	}
	return false;
}

/*
	Name: function_2be96ed8
	Namespace: ai_escort
	Checksum: 0xB4B6481
	Offset: 0x3B0
	Size: 0x12C
	Parameters: 3
	Flags: Private
*/
function private function_2be96ed8(current_point, var_673e28d2, points)
{
	new_points = [];
	var_a85cb855 = 10000;
	foreach(point in points)
	{
		dist = distancesquared(current_point, point.origin);
		if(dist < var_a85cb855)
		{
			continue;
		}
		dist = distancesquared(var_673e28d2, point.origin);
		if(dist < var_a85cb855)
		{
			continue;
		}
		new_points[new_points.size] = point;
	}
	if(new_points.size == 0)
	{
		return points;
	}
	return new_points;
}

/*
	Name: function_cd106dcf
	Namespace: ai_escort
	Checksum: 0x17F8BEA2
	Offset: 0x4E8
	Size: 0x2C
	Parameters: 2
	Flags: None
*/
function function_cd106dcf(left, right)
{
	return left.dot > right.dot;
}

/*
	Name: function_2d44c54f
	Namespace: ai_escort
	Checksum: 0xFC4917A6
	Offset: 0x520
	Size: 0xDA
	Parameters: 1
	Flags: Private
*/
function private function_2d44c54f(points)
{
	if(points.size < 5)
	{
		new_points = arraycopy(points);
	}
	else
	{
		new_points = [];
		for(i = 0; i < (points.size / 2) + 1; i++)
		{
			if(!isdefined(new_points))
			{
				new_points = [];
			}
			else if(!isarray(new_points))
			{
				new_points = array(new_points);
			}
			new_points[new_points.size] = points[i];
		}
	}
	return array::randomize(new_points);
}

/*
	Name: function_14457965
	Namespace: ai_escort
	Checksum: 0xEFECF9DF
	Offset: 0x608
	Size: 0x4A
	Parameters: 0
	Flags: None
*/
function function_14457965()
{
	if(!isdefined(self.script_owner) || !isalive(self.script_owner))
	{
		return self.origin;
	}
	return self.script_owner.origin;
}

/*
	Name: get_point_of_interest
	Namespace: ai_escort
	Checksum: 0xCFAAFE21
	Offset: 0x660
	Size: 0x1A2
	Parameters: 0
	Flags: None
*/
function get_point_of_interest()
{
	targets = self ai_target::get_targets();
	ai_target = arraygetclosest(self.origin, targets);
	var_56bd1bef = function_14457965();
	objective_target = gameobjects::function_6cdadc59(var_56bd1bef);
	if(!isdefined(ai_target) && !isdefined(objective_target))
	{
		return level.mapcenter;
	}
	if(!isdefined(objective_target))
	{
		return ai_target.origin;
	}
	if(!isdefined(ai_target))
	{
		return objective_target.origin;
	}
	ai_distance = distance(ai_target.origin, var_56bd1bef);
	var_3ac8b299 = distance(objective_target.origin, var_56bd1bef);
	if((ai_distance + var_3ac8b299) == 0)
	{
		return level.mapcenter;
	}
	coef = ai_distance / (ai_distance + var_3ac8b299);
	origin = vectorlerp(ai_target.origin, objective_target.origin, coef);
	return origin;
}

/*
	Name: function_d15dd929
	Namespace: ai_escort
	Checksum: 0x496D4B63
	Offset: 0x810
	Size: 0xA6
	Parameters: 1
	Flags: None
*/
function function_d15dd929(origin)
{
	result = function_9cc082d2(origin + vectorscale((0, 0, 1), 100), 200);
	if(isdefined(result) && isdefined(result[#"materialflags"]) && result[#"materialflags"] & 2)
	{
		return false;
	}
	if(!ispointonnavmesh(origin, 16, 1))
	{
		return false;
	}
	return true;
}

/*
	Name: function_cb4925e3
	Namespace: ai_escort
	Checksum: 0x613C4A10
	Offset: 0x8C0
	Size: 0x13C
	Parameters: 1
	Flags: None
*/
function function_cb4925e3(tacpoints)
{
	validpoints = [];
	foreach(tacpoint in tacpoints)
	{
		if(function_d15dd929(tacpoint.origin))
		{
			array::add(validpoints, tacpoint);
			continue;
		}
		/#
			record3dtext("", tacpoint.origin + vectorscale((0, 0, 1), 40), (1, 1, 1), "");
		#/
		/#
			recordline(tacpoint.origin + vectorscale((0, 0, 1), 40), tacpoint.origin, (1, 1, 1), "");
		#/
	}
	return validpoints;
}

/*
	Name: function_b6f15bda
	Namespace: ai_escort
	Checksum: 0xA261DA3E
	Offset: 0xA08
	Size: 0x63E
	Parameters: 0
	Flags: None
*/
function function_b6f15bda()
{
	if(!function_c6c4dd36())
	{
		return;
	}
	var_56bd1bef = self function_14457965();
	if(!isdefined(var_56bd1bef))
	{
		return;
	}
	if(!ispointonnavmesh(var_56bd1bef, self))
	{
		return;
	}
	if(isdefined(self.isarriving) && self.isarriving)
	{
		return;
	}
	if(isactor(self) && (self asmistransdecrunning() || self asmistransitionrunning()))
	{
		return;
	}
	velocity = self.script_owner tracking::get_velocity();
	var_9d59ceab = self.script_owner getvelocity();
	cylinder = ai::t_cylinder(var_56bd1bef, self.ai.escort.var_5a529222, 30);
	tacpoints = undefined;
	if(lengthsquared(var_9d59ceab) > 20 && isdefined(velocity) && (!(isdefined(self.ai.var_82cafa78) && self.ai.var_82cafa78)))
	{
		var_84e7232 = var_56bd1bef + vectorscale(vectornormalize(velocity), 100);
		var_84e7232 = getclosestpointonnavmesh(var_84e7232, 100);
		if(isdefined(var_84e7232) && isdefined(self.ai.escort.var_db083d2c))
		{
			var_84e7232 = checknavmeshdirection(var_56bd1bef, var_84e7232 - var_56bd1bef, 100, 0);
			if(isdefined(var_84e7232))
			{
				/#
					recordsphere(var_84e7232, 8, (0, 1, 1), "");
				#/
				var_b6a10143 = ai::t_cylinder(var_56bd1bef, 80, 30);
				/#
					assert(isdefined(var_b6a10143.origin));
				#/
				tacpoints = tacticalquery(self.ai.escort.var_db083d2c, cylinder, self, var_b6a10143, var_84e7232, var_56bd1bef);
			}
		}
	}
	else
	{
		var_84e7232 = var_56bd1bef + vectorscale(anglestoforward((0, self.script_owner.angles[1], 0)), 300);
		var_84e7232 = getclosestpointonnavmesh(var_84e7232, 200);
		if(isdefined(var_84e7232) && isdefined(self.ai.escort.var_db083d2c))
		{
			var_84e7232 = checknavmeshdirection(var_56bd1bef, var_84e7232 - var_56bd1bef, 300, 0);
			if(isdefined(var_84e7232))
			{
				/#
					recordsphere(var_84e7232, 8, (1, 0.5, 0), "");
				#/
				cylinder = ai::t_cylinder(var_84e7232, self.ai.escort.var_5a529222, 30);
				var_8f3583cf = ai::t_cylinder(self.origin, 200, 30);
				/#
					assert(isdefined(var_8f3583cf.origin));
				#/
				tacpoints = tacticalquery(self.ai.escort.var_db083d2c, cylinder, self, var_8f3583cf, var_84e7232, var_56bd1bef);
			}
			else
			{
				/#
					recordsphere(var_84e7232, 8, (1, 0, 0), "");
				#/
			}
		}
	}
	if(!isdefined(tacpoints) || tacpoints.size == 0)
	{
		tacpoints = tacticalquery(self.ai.escort.var_544ae93d, cylinder, self);
	}
	if(isdefined(tacpoints) && tacpoints.size != 0)
	{
		tacpoints = function_cb4925e3(tacpoints);
		if(isdefined(tacpoints) && tacpoints.size != 0)
		{
			self.var_36299b51 = tacpoints;
			newpos = tacpoints[0].origin;
			if(isdefined(newpos))
			{
				self.ai.escort.var_8d8186ad = var_56bd1bef;
				self.ai.escort.var_e48a6ca = gettime();
				self setgoal(newpos);
				self function_a57c34b7(newpos);
				if(isdefined(self.ai.var_82cafa78) && self.ai.var_82cafa78)
				{
					self.ai.var_82cafa78 = 0;
				}
			}
		}
	}
}

/*
	Name: function_81832658
	Namespace: ai_escort
	Checksum: 0xCEEC97FC
	Offset: 0x1050
	Size: 0x54
	Parameters: 0
	Flags: None
*/
function function_81832658()
{
	var_1f2328d0 = self function_4794d6a3();
	if(!isdefined(var_1f2328d0.var_9e404264) || var_1f2328d0.var_9e404264)
	{
		return true;
	}
	return false;
}

/*
	Name: function_11d6df2c
	Namespace: ai_escort
	Checksum: 0x7A927E58
	Offset: 0x10B0
	Size: 0x32E
	Parameters: 0
	Flags: None
*/
function function_11d6df2c()
{
	var_56bd1bef = self function_14457965();
	var_1f2328d0 = self function_4794d6a3();
	if(isdefined(self.ai.var_b1248bd1) && self.ai.var_b1248bd1)
	{
		self.ai.var_b1248bd1 = 0;
		return true;
	}
	if(isdefined(self.ai.escort.var_8d8186ad))
	{
		if(distancesquared(self.ai.escort.var_8d8186ad, var_56bd1bef) >= (self.ai.escort.var_5a529222 * self.ai.escort.var_5a529222))
		{
			return true;
		}
	}
	else if(distancesquared(self.origin, var_56bd1bef) >= (self.ai.escort.var_5a529222 * self.ai.escort.var_5a529222))
	{
		return true;
	}
	var_56bd1bef = self function_14457965();
	if(isdefined(var_56bd1bef) && isdefined(self.ai.escort.var_e48a6ca) && gettime() > (self.ai.escort.var_e48a6ca + randomintrange(3000, 4000)))
	{
		if(isdefined(self.script_owner) && isdefined(self.script_owner.angles))
		{
			if(!util::within_fov(var_56bd1bef, self.script_owner.angles, self.origin, cos(50)))
			{
				return true;
			}
		}
	}
	if(isdefined(self.ai.escort.var_8d8186ad) && isdefined(self.ai.escort.var_e48a6ca) && !self haspath())
	{
		if(isdefined(var_56bd1bef) && gettime() > (self.ai.escort.var_e48a6ca + randomintrange(10000, 12000)))
		{
			if(distancesquared(self.ai.escort.var_8d8186ad, var_56bd1bef) <= (350 * 350))
			{
				self.ai.var_82cafa78 = 1;
				return true;
			}
		}
	}
	return false;
}

/*
	Name: function_92ed3ce9
	Namespace: ai_escort
	Checksum: 0x72E07DA8
	Offset: 0x13E8
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function function_92ed3ce9()
{
	if(function_11d6df2c())
	{
		self function_b6f15bda();
	}
}

/*
	Name: function_5d31deb6
	Namespace: ai_escort
	Checksum: 0x3AF52794
	Offset: 0x1420
	Size: 0x86
	Parameters: 0
	Flags: None
*/
function function_5d31deb6()
{
	if(isdefined(self.ai.hasseenfavoriteenemy) && self.ai.hasseenfavoriteenemy)
	{
		self.ai.escort.state = 0;
	}
	else if(self.ai.escort.state == 0)
	{
		self.ai.escort.state = 2;
	}
}

/*
	Name: update_debug
	Namespace: ai_escort
	Checksum: 0x80F724D1
	Offset: 0x14B0
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function update_debug()
{
}

