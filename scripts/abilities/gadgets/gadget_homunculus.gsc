// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_35598499769dbb3d;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace gadget_homunculus;

/*
	Name: __init__system__
	Namespace: gadget_homunculus
	Checksum: 0x4A826BE7
	Offset: 0xE0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"homunculus", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: gadget_homunculus
	Checksum: 0x536A4CF1
	Offset: 0x128
	Size: 0xDC
	Parameters: 0
	Flags: Linked, Private
*/
function private __init__()
{
	level.var_2da60c10 = [];
	if(isdefined(getgametypesetting(#"wzenablehomunculus")) && getgametypesetting(#"wzenablehomunculus"))
	{
		level.var_cc310d06 = &function_7bfc867f;
		level thread function_c83057f0();
		callback::on_finalize_initialization(&function_1c601b99);
		level scene::add_scene_func(#"hash_42c9ac9338fda8d1", &jump);
	}
}

/*
	Name: function_1c601b99
	Namespace: gadget_homunculus
	Checksum: 0x6B05437
	Offset: 0x210
	Size: 0x50
	Parameters: 0
	Flags: Linked
*/
function function_1c601b99()
{
	if(isdefined(level.var_a5dacbea))
	{
		[[level.var_a5dacbea]](getweapon(#"homunculus"), &function_127fb8f3);
	}
}

/*
	Name: function_c83057f0
	Namespace: gadget_homunculus
	Checksum: 0x42FAECF6
	Offset: 0x268
	Size: 0x176
	Parameters: 0
	Flags: Linked, Private
*/
function private function_c83057f0()
{
	level endon(#"game_ended");
	while(true)
	{
		foreach(homunculus in level.var_2da60c10)
		{
			if(!isdefined(homunculus) || homunculus.spawning === 1)
			{
				continue;
			}
			if(gettime() >= homunculus.despawn_time)
			{
				homunculus function_7bfc867f();
				continue;
			}
			if(homunculus.attacking === 1)
			{
				continue;
			}
			if(function_9ce07f7c(homunculus))
			{
				homunculus thread function_bb17ec5a();
				continue;
			}
			if(homunculus.dancing !== 1)
			{
				homunculus thread function_b053b486();
			}
			waitframe(1);
		}
		arrayremovevalue(level.var_2da60c10, undefined);
		waitframe(1);
	}
}

/*
	Name: function_9ce07f7c
	Namespace: gadget_homunculus
	Checksum: 0x4E96B17E
	Offset: 0x3E8
	Size: 0xC2
	Parameters: 1
	Flags: Linked, Private
*/
function private function_9ce07f7c(homunculus)
{
	var_b1de6a06 = getentitiesinradius(homunculus.origin, 250, 15);
	foreach(actor in var_b1de6a06)
	{
		if(function_62318121(homunculus, actor))
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_90cc805b
	Namespace: gadget_homunculus
	Checksum: 0x5012B9E5
	Offset: 0x4B8
	Size: 0x13A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_90cc805b(homunculus)
{
	var_b1de6a06 = getentitiesinradius(homunculus.origin, 250, 15);
	var_9db93b2e = [];
	foreach(var_6baf60af in var_b1de6a06)
	{
		if(function_62318121(homunculus, var_6baf60af))
		{
			if(!isdefined(var_9db93b2e))
			{
				var_9db93b2e = [];
			}
			else if(!isarray(var_9db93b2e))
			{
				var_9db93b2e = array(var_9db93b2e);
			}
			var_9db93b2e[var_9db93b2e.size] = var_6baf60af;
		}
	}
	return arraysortclosest(var_9db93b2e, homunculus.origin, undefined, undefined, 250);
}

/*
	Name: function_62318121
	Namespace: gadget_homunculus
	Checksum: 0x422A0F67
	Offset: 0x600
	Size: 0x68
	Parameters: 2
	Flags: Linked, Private
*/
function private function_62318121(homunculus, ent)
{
	if(!isdefined(ent))
	{
		return false;
	}
	if(ent.archetype == "zombie" && util::function_fbce7263(ent.team, homunculus.team))
	{
		return true;
	}
	return false;
}

/*
	Name: function_4776caf4
	Namespace: gadget_homunculus
	Checksum: 0xB27A48FF
	Offset: 0x670
	Size: 0x57C
	Parameters: 1
	Flags: Private, Event
*/
event private function_4776caf4(eventstruct)
{
	if(eventstruct.weapon.name == #"homunculus")
	{
		grenade = eventstruct.projectile;
		grenade ghost();
		grenade.angles = self.angles;
		homunculus = util::spawn_model(grenade.model, grenade.origin, grenade.angles);
		homunculus.spawning = 1;
		homunculus.identifier_weapon = grenade.item;
		homunculus.player = grenade.thrower;
		grenade.homunculus = homunculus;
		grenade.homunculus linkto(grenade);
		grenade.homunculus.team = grenade.team;
		grenade.homunculus clientfield::set("enemyequip", 1);
		var_66ae7054 = 0;
		if(math::cointoss() && math::cointoss())
		{
			homunculus playsoundontag(#"hash_8d020e5460f4a95", "j_head");
			var_66ae7054 = 1;
		}
		else
		{
			homunculus playsoundontag(#"hash_689f11fd8983d1a6", "j_head");
		}
		homunculus thread scene::play(#"hash_76de80efed42a7ee", homunculus);
		grenade waittill(#"stationary", #"death");
		if(isdefined(grenade))
		{
			homunculus unlink();
			grenade delete();
			if(isdefined(homunculus))
			{
				homunculus.var_acdc8d71 = getclosestpointonnavmesh(homunculus.origin, 360, 15.1875);
				if(!isdefined(level.var_2da60c10))
				{
					level.var_2da60c10 = [];
				}
				else if(!isarray(level.var_2da60c10))
				{
					level.var_2da60c10 = array(level.var_2da60c10);
				}
				level.var_2da60c10[level.var_2da60c10.size] = homunculus;
				homunculus.despawn_time = gettime() + (int(120 * 1000));
				playfx(#"zm_weapons/fx8_equip_homunc_spawn", homunculus.origin);
				homunculus playsound(#"hash_21206f1b7fb27f81");
				var_255a121f = 0;
				if(math::cointoss() && math::cointoss() && !var_66ae7054)
				{
					homunculus playsoundontag(#"hash_6b4fa8bf14690e0c", "j_head");
					var_255a121f = 1;
				}
				else
				{
					homunculus playsoundontag(#"hash_1d6e8d28eabdb1fb", "j_head");
				}
				mover = util::spawn_model("tag_origin", homunculus.origin, homunculus.angles);
				homunculus linkto(mover);
				homunculus.mover = mover;
				homunculus drop_to_ground(1);
				homunculus scene::stop();
				if(!var_255a121f)
				{
					homunculus thread function_1dba4a2();
				}
				homunculus.mover scene::play(#"hash_2e6bf8370e7c2412", homunculus);
				homunculus notify(#"hash_3e410dbcd9e66000");
				homunculus.spawning = undefined;
			}
		}
		else if(isdefined(homunculus))
		{
			homunculus delete();
		}
	}
}

/*
	Name: function_1dba4a2
	Namespace: gadget_homunculus
	Checksum: 0x4ADF6540
	Offset: 0xBF8
	Size: 0xA8
	Parameters: 0
	Flags: Linked
*/
function function_1dba4a2()
{
	self endon(#"death", #"hash_3e410dbcd9e66000");
	self.mover endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"hash_5851b555291e7748");
		if(isdefined(waitresult.str_alias))
		{
			self playsoundontag(waitresult.str_alias, "j_head");
		}
	}
}

/*
	Name: function_bb17ec5a
	Namespace: gadget_homunculus
	Checksum: 0x14FC4615
	Offset: 0xCA8
	Size: 0x316
	Parameters: 0
	Flags: Linked, Private
*/
function private function_bb17ec5a()
{
	self endon(#"death");
	self.attacking = 1;
	self.mover scene::stop();
	self.dancing = undefined;
	/#
		iprintlnbold("");
	#/
	start_attack = 1;
	while(true)
	{
		var_c7f2fbb7 = function_90cc805b(self);
		if(!var_c7f2fbb7.size)
		{
			break;
		}
		foreach(enemy in var_c7f2fbb7)
		{
			if(isalive(enemy) && bullettracepassed(self.origin + vectorscale((0, 0, 1), 16), enemy getcentroid(), 0, self, enemy))
			{
				self face_target(enemy);
				if(start_attack === 1)
				{
					start_attack = undefined;
					if(math::cointoss() && math::cointoss())
					{
						self playsound(#"hash_22c88cff01a4691b");
					}
					self.mover scene::stop();
					self.mover scene::play(#"hash_42c9ac9338fda8d1", self);
					self.mover thread scene::play(#"hash_6d058a77349e6267", self);
					if(!isalive(enemy))
					{
						continue;
					}
				}
				n_dist = distancesquared(self.origin, enemy.origin);
				n_time = n_dist / 48400;
				n_time = n_time * 0.5;
				self function_c8f642f6(enemy, n_time);
			}
			waitframe(1);
		}
		wait(0.1);
	}
	self drop_to_ground();
	self.attacking = undefined;
}

/*
	Name: function_b053b486
	Namespace: gadget_homunculus
	Checksum: 0xED94AAF2
	Offset: 0xFC8
	Size: 0x54
	Parameters: 0
	Flags: Linked, Private
*/
function private function_b053b486()
{
	self endon(#"death");
	self.dancing = 1;
	self.mover scene::play(#"hash_3cfd8e7348ff04ed", self);
}

/*
	Name: drop_to_ground
	Namespace: gadget_homunculus
	Checksum: 0x4B01B59F
	Offset: 0x1028
	Size: 0x19C
	Parameters: 1
	Flags: Linked, Private
*/
function private drop_to_ground(b_immediate = 0)
{
	self endon(#"death");
	s_trace = groundtrace(self.origin + vectorscale((0, 0, 1), 16), self.origin + (vectorscale((0, 0, -1), 1000)), 0, self);
	var_a75fe4be = s_trace[#"position"];
	if(b_immediate)
	{
		self.mover moveto(var_a75fe4be, 0.01);
		self.mover waittill(#"movedone");
	}
	else if(abs(self.origin[2] - var_a75fe4be[2]) > 1)
	{
		n_time = 0.25;
		self.mover scene::stop();
		self.mover moveto(var_a75fe4be, 0.25);
		self.mover scene::play(#"hash_3b32418a502baf6", self);
	}
}

/*
	Name: jump
	Namespace: gadget_homunculus
	Checksum: 0x8549E760
	Offset: 0x11D0
	Size: 0xB4
	Parameters: 1
	Flags: Linked, Private
*/
function private jump(scene_ents)
{
	scene_ents[#"homunculus"] endon(#"death");
	scene_ents[#"homunculus"] waittill(#"jumped");
	if(isdefined(scene_ents[#"homunculus"].mover))
	{
		scene_ents[#"homunculus"].mover movez(40, 0.35);
	}
}

/*
	Name: face_target
	Namespace: gadget_homunculus
	Checksum: 0x35D526B1
	Offset: 0x1290
	Size: 0x9C
	Parameters: 1
	Flags: Linked, Private
*/
function private face_target(target)
{
	v_dir = vectornormalize(target.origin - self.origin);
	v_dir = (v_dir[0], v_dir[1], 0);
	v_angles = vectortoangles(v_dir);
	self.mover rotateto(v_angles, 0.15);
}

/*
	Name: function_c8f642f6
	Namespace: gadget_homunculus
	Checksum: 0xBA0C4BC8
	Offset: 0x1338
	Size: 0x204
	Parameters: 2
	Flags: Linked, Private
*/
function private function_c8f642f6(enemy, n_time)
{
	self.mover movez(16, n_time);
	self.mover waittill(#"movedone");
	if(isalive(enemy))
	{
		v_target = enemy gettagorigin("j_head");
		if(!isdefined(v_target))
		{
			v_target = enemy getcentroid() + vectorscale((0, 0, 1), 16);
		}
		self.mover moveto(v_target, n_time);
		self.mover waittill(#"movedone");
		if(isalive(enemy))
		{
			if(math::cointoss() && math::cointoss())
			{
				self playsound(#"hash_ba5815eb0dc4d97");
			}
			enemy playsound(#"hash_3a99f739009a77fa");
			enemy dodamage(enemy.health + 666, enemy.origin, self.player, undefined, undefined, "MOD_UNKNOWN", 0, getweapon(#"homunculus"));
			gibserverutils::gibhead(enemy);
		}
	}
}

/*
	Name: function_7bfc867f
	Namespace: gadget_homunculus
	Checksum: 0x62057A98
	Offset: 0x1548
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_7bfc867f()
{
	self playsoundontag(#"hash_6e471fde121d0263", "j_head");
	self drop_to_ground();
	self.mover scene::stop();
	self.mover scene::play(#"hash_7315321629a290c5", self);
	playfx(#"zm_weapons/fx8_equip_homunc_death_exp", self.origin);
	self delete();
}

/*
	Name: function_bd59a592
	Namespace: gadget_homunculus
	Checksum: 0x4ECCE242
	Offset: 0x1618
	Size: 0x138
	Parameters: 1
	Flags: Linked
*/
function function_bd59a592(zombie)
{
	var_2d9e38fc = 360 * 360;
	var_128c12c9 = undefined;
	var_b26b6492 = undefined;
	foreach(homunculus in level.var_2da60c10)
	{
		if(!isdefined(homunculus))
		{
			continue;
		}
		dist_sq = distancesquared(zombie.origin, homunculus.origin);
		if(isdefined(homunculus) && homunculus.attacking === 1 && dist_sq < var_2d9e38fc)
		{
			if(!isdefined(var_128c12c9) || dist_sq < var_128c12c9)
			{
				var_128c12c9 = dist_sq;
				var_b26b6492 = homunculus;
			}
		}
	}
	return var_b26b6492;
}

/*
	Name: function_127fb8f3
	Namespace: gadget_homunculus
	Checksum: 0x898019FD
	Offset: 0x1758
	Size: 0xF4
	Parameters: 2
	Flags: Linked
*/
function function_127fb8f3(homunculus, attackingplayer)
{
	homunculus endon(#"death");
	randangle = randomfloat(360);
	if(isdefined(level._equipment_emp_destroy_fx))
	{
		playfx(level._equipment_emp_destroy_fx, homunculus.origin + vectorscale((0, 0, 1), 5), (cos(randangle), sin(randangle), 0), anglestoup(homunculus.angles));
	}
	wait(1.1);
	homunculus function_7bfc867f();
}

