// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_18f0d22c75b141a7;
#using script_2c74a7b5eea1ec89;
#using script_2dc48f46bfeac894;
#using script_47f5b3a23db10e76;
#using script_5399f402045d7abd;
#using script_545a0bac37bda541;
#using script_57f7003580bb15e0;
#using script_6c8abe14025b47c4;
#using script_79a7e1c31a3e8cc;
#using script_8988fdbc78d6c53;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\damagefeedback_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\gestures.gsc;
#using scripts\core_common\influencers_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace concertina_wire;

/*
	Name: init_shared
	Namespace: concertina_wire
	Checksum: 0xD20067D9
	Offset: 0x2C8
	Size: 0x334
	Parameters: 1
	Flags: None
*/
function init_shared(var_4b51853b)
{
	level.var_87226c31 = spawnstruct();
	level.var_87226c31.bundle = getscriptbundle(var_4b51853b);
	level.var_87226c31.var_3e7344ee = getweapon(#"eq_concertina_wire");
	level.var_87226c31.var_546a220c = "concertina_wire_objective_default";
	level.var_87226c31.var_925bbb2 = [];
	level.var_87226c31.var_d6a27a84 = [];
	level.var_94029383 = &function_4ee7d46a;
	setdvar(#"hash_430cc236fe8b2561", 8);
	ability_player::register_gadget_should_notify(37, 1);
	weaponobjects::function_e6400478(#"eq_concertina_wire", &function_57955e51, 1);
	callback::on_spawned(&on_player_spawned);
	callback::on_player_killed_with_params(&onplayerkilled);
	callback::on_start_gametype(&function_c89d0204);
	deployable::function_2e088f73(level.var_87226c31.var_3e7344ee, &function_e5fdca70, &function_6fe5a945, undefined, undefined, 1);
	level.var_87226c31.var_357db326 = 10000;
	clientfield::register("scriptmover", "concertinaWire_placed", 1, 5, "float");
	clientfield::register("scriptmover", "concertinaWireDestroyed", 1, 1, "int");
	clientfield::register("scriptmover", "concertinaWireDroopyBits", 1, 3, "int");
	level.var_87226c31.var_ff1a491d = level.var_87226c31.bundle.var_76d79155 * level.var_87226c31.bundle.var_76d79155;
	level.var_87226c31.var_17a4fddd = getweapon(#"sig_buckler_turret");
	setdvar(#"hash_753335900deb89ea", 25);
}

/*
	Name: function_c89d0204
	Namespace: concertina_wire
	Checksum: 0x34C0587B
	Offset: 0x608
	Size: 0x14
	Parameters: 0
	Flags: None
*/
function function_c89d0204()
{
	thread function_b842eab8();
}

/*
	Name: function_ef1137ae
	Namespace: concertina_wire
	Checksum: 0xE6814A83
	Offset: 0x628
	Size: 0xCC
	Parameters: 5
	Flags: None
*/
function function_ef1137ae(attacker, victim, weapon, attackerweapon, meansofdeath)
{
	if(!isdefined(victim) || !isdefined(victim.var_c6a21b50) || ((isdefined(victim.var_cd7665dd) ? victim.var_cd7665dd : 0) + 500) < gettime())
	{
		return false;
	}
	if(isdefined(attacker) && (!isdefined(victim.var_c6a21b50.owner) || attacker != victim.var_c6a21b50.owner))
	{
		return false;
	}
	return true;
}

/*
	Name: onplayerkilled
	Namespace: concertina_wire
	Checksum: 0x5A0AA6F5
	Offset: 0x700
	Size: 0x3FC
	Parameters: 1
	Flags: None
*/
function onplayerkilled(s_params)
{
	if(!isdefined(s_params.weapon))
	{
		return;
	}
	if(!function_ef1137ae(s_params.eattacker, self))
	{
		return;
	}
	if(s_params.weapon != level.var_87226c31.var_3e7344ee)
	{
		killstreaks::processscoreevent(#"hash_7f457b0236eb8fc", s_params.eattacker, self, level.var_87226c31.var_3e7344ee);
	}
	if(s_params.weapon != level.var_87226c31.var_3e7344ee)
	{
		return;
	}
	weapon = s_params.weapon;
	var_4fd6205f = (isdefined(self.var_c6a21b50.owner) ? self.var_c6a21b50.owner == s_params.eattacker : 0);
	if(!isdefined(s_params.eattacker) || !isplayer(s_params.eattacker))
	{
		return;
	}
	var_8e797a67 = s_params.eattacker loadout::function_18a77b37("primarygrenade");
	var_a66b455e = s_params.eattacker loadout::function_18a77b37("specialgrenade");
	var_ec20b2a = s_params.eattacker loadout::function_18a77b37("ultimate");
	var_bc9c6fcb = 0;
	if(isdefined(var_8e797a67) && var_8e797a67.statname == weapon.statname || (isdefined(var_a66b455e) && var_a66b455e.statname == weapon.statname) || (isdefined(var_ec20b2a) && var_ec20b2a.statname == weapon.statname))
	{
		var_bc9c6fcb = 1;
	}
	if(var_bc9c6fcb)
	{
		killstreaks::processscoreevent(#"hash_152856ae19af395b", self.var_c6a21b50.owner, self, level.var_87226c31.var_3e7344ee);
	}
	if(isdefined(level.playgadgetsuccess) && var_4fd6205f)
	{
		relativepos = vectornormalize(self.origin - s_params.eattacker.origin);
		dir = anglestoforward(s_params.eattacker getplayerangles());
		dotproduct = vectordot(dir, relativepos);
		if(dotproduct > 0 && sighttracepassed(s_params.eattacker geteye(), self geteye(), 1, s_params.eattacker, self))
		{
			s_params.eattacker [[level.playgadgetsuccess]](level.var_87226c31.var_3e7344ee, undefined, self, undefined);
		}
	}
}

/*
	Name: function_c5f0b9e7
	Namespace: concertina_wire
	Checksum: 0xA257D0B
	Offset: 0xB08
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function function_c5f0b9e7(func)
{
	level.var_6230d238 = func;
}

/*
	Name: function_d700c081
	Namespace: concertina_wire
	Checksum: 0xA5649C0D
	Offset: 0xB30
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function function_d700c081(func)
{
	level.var_c560f03 = func;
}

/*
	Name: function_42b34d5a
	Namespace: concertina_wire
	Checksum: 0xEB6A951A
	Offset: 0xB58
	Size: 0xA0
	Parameters: 0
	Flags: None
*/
function function_42b34d5a()
{
	if(!isdefined(self.concertinawire))
	{
		return;
	}
	foreach(concertinawire in self.concertinawire.var_a3aac76c)
	{
		if(isdefined(concertinawire))
		{
			concertinawire function_4ee7d46a(1);
		}
	}
}

/*
	Name: function_e4f3f17
	Namespace: concertina_wire
	Checksum: 0x6FB65CD2
	Offset: 0xC00
	Size: 0x9C
	Parameters: 0
	Flags: None
*/
function function_e4f3f17()
{
	self endon(#"death");
	if((isdefined(level.var_87226c31.bundle.timeout) ? level.var_87226c31.bundle.timeout : 0) == 0)
	{
		return;
	}
	wait(level.var_87226c31.bundle.timeout);
	if(isdefined(self))
	{
		self function_4ee7d46a(1);
	}
}

/*
	Name: on_player_spawned
	Namespace: concertina_wire
	Checksum: 0x81D3FAE1
	Offset: 0xCA8
	Size: 0xA4
	Parameters: 0
	Flags: None
*/
function on_player_spawned()
{
	if(!isdefined(self.concertinawire))
	{
		self.concertinawire = spawnstruct();
		self.concertinawire.var_a3aac76c = [];
		self.concertinawire.activelist = [];
	}
	if(!self hasweapon(level.var_87226c31.var_3e7344ee) && self.concertinawire.var_a3aac76c.size > 0)
	{
		self function_42b34d5a();
	}
}

/*
	Name: function_e5fdca70
	Namespace: concertina_wire
	Checksum: 0x9E7D10F1
	Offset: 0xD58
	Size: 0x4C
	Parameters: 3
	Flags: None
*/
function function_e5fdca70(origin, angles, player)
{
	if(isdefined(level.var_d1ae43e3))
	{
		return [[level.var_d1ae43e3]](origin, angles, player);
	}
	return 1;
}

/*
	Name: function_6fe5a945
	Namespace: concertina_wire
	Checksum: 0xD37C03E1
	Offset: 0xDB0
	Size: 0x428
	Parameters: 1
	Flags: None
*/
function function_6fe5a945(player)
{
	/#
		assert(isdefined(level.var_87226c31.bundle.var_63aab046));
	#/
	if(!isdefined(player) || !isdefined(player.concertinawire))
	{
		return 0;
	}
	var_b43e8dc2 = player function_287dcf4b(level.var_87226c31.bundle.var_63aab046, level.var_87226c31.bundle.maxwidth, 0, 0, level.var_87226c31.var_3e7344ee);
	if(!var_b43e8dc2.isvalid)
	{
		player.concertinawire.var_add809de = undefined;
		player function_bf191832(0, (0, 0, 0), (0, 0, 0));
		return var_b43e8dc2;
	}
	player.concertinawire.var_add809de = var_b43e8dc2;
	var_2b68b641 = function_54267517(var_b43e8dc2.origin);
	var_1167a9ce = function_6541080b(var_b43e8dc2.origin, level.var_87226c31.var_ff1a491d);
	var_a82b48d6 = anglestoright(player.angles);
	origins = [];
	if(!isdefined(origins))
	{
		origins = [];
	}
	else if(!isarray(origins))
	{
		origins = array(origins);
	}
	origins[origins.size] = var_b43e8dc2.origin;
	var_e5da702e = var_b43e8dc2.origin + (var_a82b48d6 * getdvarfloat(#"hash_753335900deb89ea", 1));
	if(!isdefined(origins))
	{
		origins = [];
	}
	else if(!isarray(origins))
	{
		origins = array(origins);
	}
	origins[origins.size] = var_e5da702e;
	var_62e3ee6f = var_b43e8dc2.origin - (var_a82b48d6 * getdvarfloat(#"hash_753335900deb89ea", 1));
	if(!isdefined(origins))
	{
		origins = [];
	}
	else if(!isarray(origins))
	{
		origins = array(origins);
	}
	origins[origins.size] = var_62e3ee6f;
	if(smart_cover::function_e3a901c(origins, getdvarfloat(#"hash_753335900deb89ea", 1)))
	{
		var_b43e8dc2.isvalid = 0;
		return var_b43e8dc2;
	}
	var_1e5ed37a = !var_1167a9ce && !var_2b68b641;
	if(!var_1e5ed37a)
	{
		var_b43e8dc2.isvalid = 0;
		player function_bf191832(var_1e5ed37a, (0, 0, 0), (0, 0, 0));
		return var_b43e8dc2;
	}
	player function_bf191832(var_1e5ed37a, var_b43e8dc2.origin, var_b43e8dc2.angles);
	return var_b43e8dc2;
}

/*
	Name: function_5ea6e77d
	Namespace: concertina_wire
	Checksum: 0x9163869A
	Offset: 0x11E0
	Size: 0xC6
	Parameters: 2
	Flags: None
*/
function function_5ea6e77d(point, upangles)
{
	var_2fa728ff = point + (upangles * -10);
	var_71fcd06b = point + (upangles * 10);
	mins = vectorscale((-1, -1, -1), 10);
	maxs = vectorscale((1, 1, 1), 10);
	var_e07c7e8 = physicstrace(var_71fcd06b, var_2fa728ff, mins, maxs, self, 1);
	return var_e07c7e8[#"fraction"] < 1;
}

/*
	Name: function_2562ba62
	Namespace: concertina_wire
	Checksum: 0x60EDDA46
	Offset: 0x12B0
	Size: 0x2EA
	Parameters: 3
	Flags: Private
*/
function private function_2562ba62(var_637dcf3d, startlocation, var_a4e8554b)
{
	var_b43e8dc2 = spawnstruct();
	var_b43e8dc2.var_e74f7cdd = 1;
	var_b43e8dc2.var_8e37de72 = 1;
	var_b43e8dc2.var_b78da7c7 = var_a4e8554b;
	var_70d65e57 = anglestoright(var_637dcf3d.angles);
	var_16482870 = 0;
	lasttime = gettime();
	var_97dd8ca1 = 1 / level.var_87226c31.bundle.var_d8e2166d;
	var_28cd159a = 0;
	var_ea8ed4c6 = 0;
	while(var_16482870 <= var_a4e8554b)
	{
		var_637dcf3d clientfield::set("concertinaWire_placed", 1 - var_16482870);
		var_300fb0d2 = (level.var_87226c31.bundle.maxwidth * var_16482870) * 0.5;
		rightpoint = startlocation + (var_70d65e57 * var_300fb0d2);
		upangles = anglestoup(var_637dcf3d.angles);
		if(!var_637dcf3d function_5ea6e77d(rightpoint, upangles))
		{
			var_b43e8dc2.var_e74f7cdd = 0;
		}
		leftpoint = startlocation - (var_70d65e57 * var_300fb0d2);
		if(!var_637dcf3d function_5ea6e77d(leftpoint, upangles))
		{
			var_b43e8dc2.var_8e37de72 = 0;
		}
		var_28cd159a = var_16482870;
		if(var_ea8ed4c6 || !var_b43e8dc2.var_8e37de72 || !var_b43e8dc2.var_e74f7cdd)
		{
			break;
		}
		waitframe(1);
		var_32c844bb = gettime() - lasttime;
		var_16482870 = var_16482870 + (var_32c844bb * var_97dd8ca1);
		if(var_16482870 >= var_a4e8554b)
		{
			var_ea8ed4c6 = 1;
			var_16482870 = min(var_16482870, var_a4e8554b);
		}
		var_637dcf3d.var_80cf41a4 = var_16482870;
		lasttime = gettime();
	}
	var_b43e8dc2.var_b78da7c7 = max(var_a4e8554b - var_28cd159a, 0);
	return var_b43e8dc2;
}

/*
	Name: function_4e7c57c1
	Namespace: concertina_wire
	Checksum: 0x43C13949
	Offset: 0x15A8
	Size: 0x244
	Parameters: 7
	Flags: Private
*/
function private function_4e7c57c1(var_637dcf3d, startorigin, direction, var_16482870, var_a4e8554b, movedirection, var_3140daee)
{
	var_b26653b3 = var_16482870 * level.var_87226c31.bundle.maxwidth;
	lasttime = gettime();
	var_97dd8ca1 = 1 / level.var_87226c31.bundle.var_d8e2166d;
	while(var_16482870 <= var_a4e8554b)
	{
		var_637dcf3d clientfield::set("concertinaWire_placed", 1 - var_16482870);
		if(var_16482870 == var_a4e8554b)
		{
			break;
		}
		var_300fb0d2 = level.var_87226c31.bundle.maxwidth * var_16482870;
		var_dbd651f9 = var_300fb0d2 - var_b26653b3;
		var_637dcf3d.origin = startorigin + (vectorscale(direction, var_dbd651f9 * 0.5));
		var_f49249d7 = startorigin + (direction * var_300fb0d2);
		upangles = anglestoup(var_637dcf3d.angles);
		if(!var_637dcf3d function_5ea6e77d(var_f49249d7, upangles))
		{
			if(movedirection == 0)
			{
				var_3140daee.var_e74f7cdd = 0;
			}
			else
			{
				var_3140daee.var_8e37de72 = 1;
			}
			break;
		}
		waitframe(1);
		var_32c844bb = gettime() - lasttime;
		var_16482870 = var_16482870 + (var_32c844bb * var_97dd8ca1);
		var_16482870 = min(var_16482870, 1);
		var_637dcf3d.var_80cf41a4 = var_16482870;
		lasttime = gettime();
	}
	return var_3140daee;
}

/*
	Name: function_8d89605
	Namespace: concertina_wire
	Checksum: 0x55AB70E2
	Offset: 0x17F8
	Size: 0x6EC
	Parameters: 2
	Flags: None
*/
function function_8d89605(var_637dcf3d, traceresults)
{
	var_637dcf3d endon(#"death");
	var_637dcf3d useanimtree("generic");
	var_637dcf3d setanim(level.var_87226c31.bundle.deployanim, 1, 0, 0);
	var_637dcf3d clientfield::set("concertinaWire_placed", 1);
	waitframe(1);
	var_a4e8554b = traceresults.width / level.var_87226c31.bundle.maxwidth;
	var_97dd8ca1 = 1 / level.var_87226c31.bundle.var_d8e2166d;
	var_2ba378bd = var_a4e8554b * level.var_87226c31.bundle.var_d8e2166d;
	lasttime = gettime();
	moveamount = 0;
	var_16482870 = 0;
	var_b80b6889 = distance2d(traceresults.origin, traceresults.var_c0e006dc);
	var_65ea35de = distance2d(traceresults.origin, traceresults.var_44cf251d);
	var_70d65e57 = vectornormalize(traceresults.var_c0e006dc - traceresults.origin);
	var_3d34e352 = vectornormalize(traceresults.var_44cf251d - traceresults.origin);
	if(var_b80b6889 < var_65ea35de)
	{
		var_a66e2af8 = var_b80b6889;
		movementdirection = vectornormalize(traceresults.var_44cf251d - traceresults.origin);
		movedirection = 1;
	}
	else
	{
		var_a66e2af8 = var_65ea35de;
		movementdirection = vectornormalize(traceresults.var_c0e006dc - traceresults.origin);
		movedirection = 0;
	}
	var_de26b48c = min((var_a66e2af8 * 2) / level.var_87226c31.bundle.maxwidth, 1);
	var_3140daee = function_2562ba62(var_637dcf3d, traceresults.origin, var_de26b48c);
	var_300fb0d2 = (var_de26b48c - var_3140daee.var_b78da7c7) * level.var_87226c31.bundle.maxwidth;
	var_16482870 = var_de26b48c - var_3140daee.var_b78da7c7;
	var_891f9499 = 0;
	var_fbcc67d7 = traceresults.width - var_300fb0d2;
	if(!var_3140daee.var_e74f7cdd && !var_3140daee.var_8e37de72)
	{
		var_891f9499 = 0;
	}
	else if(!var_3140daee.var_e74f7cdd || !var_3140daee.var_8e37de72)
	{
		var_891f9499 = 1;
		if(!var_3140daee.var_e74f7cdd)
		{
			movementdirection = var_3d34e352;
			var_fbcc67d7 = min(var_65ea35de - var_300fb0d2, var_fbcc67d7);
			movedirection = 1;
		}
		else
		{
			movementdirection = var_70d65e57;
			var_fbcc67d7 = min(var_b80b6889 - var_300fb0d2, var_fbcc67d7);
			movedirection = 0;
		}
		var_a4e8554b = (var_fbcc67d7 + var_300fb0d2) / level.var_87226c31.bundle.maxwidth;
	}
	if(var_a4e8554b - var_16482870 > 0.05)
	{
		var_3140daee = function_4e7c57c1(var_637dcf3d, traceresults.origin, movementdirection, var_16482870, var_a4e8554b, movedirection, var_3140daee);
	}
	if(!var_3140daee.var_e74f7cdd && !var_3140daee.var_8e37de72)
	{
		var_637dcf3d clientfield::set("concertinaWireDroopyBits", 3);
	}
	else
	{
		if(!var_3140daee.var_e74f7cdd)
		{
			var_637dcf3d clientfield::set("concertinaWireDroopyBits", 1);
		}
		else if(!var_3140daee.var_8e37de72)
		{
			var_637dcf3d clientfield::set("concertinaWireDroopyBits", 2);
		}
	}
	if(isdefined(var_637dcf3d.var_80cf41a4))
	{
		var_3dd315d6 = var_637dcf3d.var_80cf41a4;
		if(var_3dd315d6 < 0.85)
		{
			var_3dd315d6 = var_3dd315d6 * 0.9;
		}
		var_637dcf3d setanimtime(level.var_87226c31.bundle.deployanim, var_3dd315d6);
	}
	var_637dcf3d.trigger = spawn("trigger_box_new", var_637dcf3d.origin + vectorscale((0, 0, 1), 30), getvehicletriggerflags() | getaitriggerflags(), 20, int((var_16482870 * traceresults.width) * 0.8), 60);
	var_637dcf3d.trigger.angles = var_637dcf3d.angles;
	thread function_f067d867(var_637dcf3d);
}

/*
	Name: function_fc4df41e
	Namespace: concertina_wire
	Checksum: 0xBF6CBEDE
	Offset: 0x1EF0
	Size: 0x334
	Parameters: 2
	Flags: None
*/
function function_fc4df41e(watcher, owner)
{
	self endon(#"death");
	player = owner;
	self.var_52a68abf = 1;
	self hide();
	if(!isdefined(player.concertinawire.var_add809de) || !player.concertinawire.var_add809de.isvalid)
	{
		player deployable::function_416f03e6(level.var_87226c31.var_3e7344ee);
		return;
	}
	var_637dcf3d = player function_34d706ae(watcher, self, player.concertinawire.var_add809de.origin, player.concertinawire.var_add809de.angles, 1, player.concertinawire.var_add809de.width);
	array::add(player.concertinawire.activelist, var_637dcf3d);
	var_26c9fcc2 = function_57f553e9(player.concertinawire.activelist, level.var_87226c31.bundle.var_a0b69d8b);
	if(isdefined(var_26c9fcc2))
	{
		var_26c9fcc2 function_4ee7d46a(1);
	}
	if(isdefined(level.var_6230d238))
	{
		owner [[level.var_6230d238]](self);
	}
	self thread function_d82c03d4(player);
	var_637dcf3d clientfield::set("concertinaWire_placed", 1);
	/#
		assert(isdefined(level.var_87226c31), "");
	#/
	/#
		assert(isdefined(level.var_87226c31.bundle), "");
	#/
	var_637dcf3d influencers::create_entity_enemy_influencer("grenade", owner.team);
	var_637dcf3d util::function_c596f193();
	if(isdefined(level.var_87226c31.bundle.deployanim))
	{
		thread function_8d89605(var_637dcf3d, player.concertinawire.var_add809de);
	}
	var_637dcf3d function_e4f3f17();
}

/*
	Name: function_57955e51
	Namespace: concertina_wire
	Checksum: 0x244CDD0A
	Offset: 0x2230
	Size: 0x42
	Parameters: 1
	Flags: None
*/
function function_57955e51(watcher)
{
	watcher.watchforfire = 1;
	watcher.onspawn = &function_fc4df41e;
	watcher.deleteonplayerspawn = 0;
}

/*
	Name: function_d82c03d4
	Namespace: concertina_wire
	Checksum: 0xE8036151
	Offset: 0x2280
	Size: 0x5C
	Parameters: 1
	Flags: None
*/
function function_d82c03d4(player)
{
	self endon(#"death");
	player waittill(#"joined_team", #"disconnect");
	player function_42b34d5a();
}

/*
	Name: function_dd007be2
	Namespace: concertina_wire
	Checksum: 0xBBF2D85
	Offset: 0x22E8
	Size: 0xAC
	Parameters: 0
	Flags: None
*/
function function_dd007be2()
{
	level endon(#"game_ended");
	self.owner endon(#"disconnect", #"joined_team", #"changed_specialist");
	self endon(#"hash_c72d58e3d4735b");
	waitresult = undefined;
	waitresult = self waittill(#"death");
	if(!isdefined(self))
	{
		return;
	}
	self thread onkilled(waitresult);
}

/*
	Name: ondamage
	Namespace: concertina_wire
	Checksum: 0x458BF852
	Offset: 0x23A0
	Size: 0x130
	Parameters: 0
	Flags: None
*/
function ondamage()
{
	self endon(#"death");
	level endon(#"game_ended");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		if(isdefined(waitresult.attacker) && isplayer(waitresult.attacker) && getdvarint(#"hash_4cfef227405e3c46", 0) == 0)
		{
			if(waitresult.amount > 0 && damagefeedback::dodamagefeedback(waitresult.weapon, waitresult.attacker))
			{
				waitresult.attacker damagefeedback::update(waitresult.mod, waitresult.inflictor, undefined, waitresult.weapon, self);
			}
		}
	}
}

/*
	Name: function_cbc97710
	Namespace: concertina_wire
	Checksum: 0x7C88EF2B
	Offset: 0x24D8
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function function_cbc97710()
{
	wait(10);
	self delete();
}

/*
	Name: function_a1253947
	Namespace: concertina_wire
	Checksum: 0xB97EB54D
	Offset: 0x2500
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function function_a1253947()
{
	self clientfield::set("concertinaWireDestroyed", 1);
}

/*
	Name: function_4ee7d46a
	Namespace: concertina_wire
	Checksum: 0xC9C23367
	Offset: 0x2530
	Size: 0x54C
	Parameters: 1
	Flags: None
*/
function function_4ee7d46a(isselfdestruct)
{
	concertinawire = self;
	concertinawire notify(#"hash_c72d58e3d4735b");
	concertinawire clientfield::set("enemyequip", 0);
	concertinawire clientfield::set("friendlyequip", 0);
	if(isdefined(concertinawire.objectiveid))
	{
		objective_delete(concertinawire.objectiveid);
		gameobjects::release_obj_id(concertinawire.objectiveid);
	}
	if(isdefined(level.var_87226c31.bundle.var_35fbc280))
	{
		if(isdefined(isselfdestruct) && isselfdestruct)
		{
			var_415135a0 = level.var_87226c31.bundle.var_28811698;
			var_72db9941 = level.var_87226c31.bundle.var_5493f8b0;
		}
		else
		{
			var_415135a0 = level.var_87226c31.bundle.var_35fbc280;
			var_72db9941 = level.var_87226c31.bundle.var_b3756378;
		}
		playfx(var_415135a0, concertinawire.origin, anglestoforward(concertinawire.angles), anglestoup(concertinawire.angles));
		if(isdefined(var_72db9941))
		{
			concertinawire playsound(var_72db9941);
		}
	}
	if(isdefined(level.var_87226c31.bundle.var_bb6c29b4) && isdefined(self.var_d02ddb8e) && self.var_d02ddb8e == getweapon(#"shock_rifle"))
	{
		playfx(level.var_87226c31.bundle.var_bb6c29b4, concertinawire.origin);
	}
	var_28eaeb22 = -1;
	for(index = 0; index < level.var_87226c31.var_925bbb2.size; index++)
	{
		if(level.var_87226c31.var_925bbb2[index] == concertinawire)
		{
			array::remove_index(level.var_87226c31.var_925bbb2, index, 0);
			break;
		}
	}
	if(isdefined(concertinawire.owner))
	{
		for(index = 0; index < concertinawire.owner.concertinawire.activelist.size; index++)
		{
			if(concertinawire.owner.concertinawire.activelist[index] == concertinawire)
			{
				arrayremovevalue(concertinawire.owner.concertinawire.activelist, concertinawire);
				concertinawire.owner.concertinawire.activelist = array::remove_undefined(concertinawire.owner.concertinawire.activelist, 0);
				break;
			}
		}
	}
	if(isdefined(concertinawire.var_2ee191cc))
	{
		foreach(var_a4879492 in concertinawire.var_2ee191cc)
		{
			deployable::function_b20df196(var_a4879492);
		}
	}
	deployable::function_81598103(concertinawire);
	if(isdefined(concertinawire.var_3b0688ef))
	{
		badplace_delete(concertinawire.var_3b0688ef);
	}
	if(isdefined(concertinawire.killcament))
	{
		concertinawire.killcament thread util::deleteaftertime(5);
	}
	if(isdefined(concertinawire.grenade))
	{
		concertinawire.grenade thread util::deleteaftertime(1);
	}
	if(isdefined(concertinawire.trigger))
	{
		concertinawire.trigger delete();
	}
	concertinawire delete();
}

/*
	Name: onkilled
	Namespace: concertina_wire
	Checksum: 0xFD6ECD91
	Offset: 0x2A88
	Size: 0x12C
	Parameters: 1
	Flags: None
*/
function onkilled(var_c946c04c)
{
	concertinawire = self;
	if(var_c946c04c.attacker != concertinawire.owner)
	{
		concertinawire.owner globallogic_score::function_5829abe3(var_c946c04c.attacker, var_c946c04c.weapon, concertinawire.weapon);
		if(isdefined(level.var_d2600afc))
		{
			concertinawire [[level.var_d2600afc]](var_c946c04c.attacker, concertinawire.owner, concertinawire.weapon, var_c946c04c.weapon);
		}
	}
	concertinawire.var_d02ddb8e = var_c946c04c.weapon;
	if(isdefined(level.var_c560f03))
	{
		concertinawire [[level.var_c560f03]](var_c946c04c.attacker, concertinawire.var_d02ddb8e);
	}
	concertinawire thread function_4ee7d46a(0);
}

/*
	Name: getmodel
	Namespace: concertina_wire
	Checksum: 0xB34FC8B6
	Offset: 0x2BC0
	Size: 0x5E
	Parameters: 1
	Flags: None
*/
function getmodel(var_796be15d)
{
	return (self.team == #"allies" ? level.var_87226c31.bundle.var_397ed90c : level.var_87226c31.bundle.var_b256e3da);
}

/*
	Name: function_dac69ad1
	Namespace: concertina_wire
	Checksum: 0x7DAB8834
	Offset: 0x2C28
	Size: 0x534
	Parameters: 2
	Flags: None
*/
function function_dac69ad1(player, concertinawire)
{
	speed = length(player getvelocity());
	var_1c365dd = !(isdefined(level.var_cbec7a45) && level.var_cbec7a45) && level.var_87226c31.bundle.var_baf7c45 && player status_effect::function_3c54ae98(2) >= level.var_87226c31.bundle.var_baf7c45;
	if(speed <= (isdefined(level.var_87226c31.bundle.var_6b2b3b22) ? level.var_87226c31.bundle.var_6b2b3b22 : 0))
	{
		if((isdefined(player.var_fc55d553) ? player.var_fc55d553 : 0))
		{
			return;
		}
		if(var_1c365dd)
		{
			damageamount = (isdefined(level.var_87226c31.bundle.var_81601340) ? level.var_87226c31.bundle.var_81601340 : 0);
		}
		else
		{
			damageamount = (isdefined(level.var_87226c31.bundle.var_acadc685) ? level.var_87226c31.bundle.var_acadc685 : 0);
		}
		if(player getstance() == "prone")
		{
			if(var_1c365dd)
			{
				damageamount = damageamount * (isdefined(level.var_87226c31.bundle.var_39717932) ? level.var_87226c31.bundle.var_39717932 : 0);
			}
			else
			{
				damageamount = damageamount * (isdefined(level.var_87226c31.bundle.var_9095a88f) ? level.var_87226c31.bundle.var_9095a88f : 0);
			}
		}
		player dodamage(damageamount, player.origin, concertinawire.owner, concertinawire, undefined, "MOD_IMPACT", 0, level.var_87226c31.var_3e7344ee);
		player.var_fc55d553 = 1;
	}
	else
	{
		if(isdefined(player.var_fee1c0df) && player.var_fee1c0df > gettime())
		{
			return;
		}
		params = function_4d1e7b48(level.var_87226c31.bundle.var_1a6488fe);
		/#
			assert(isdefined(params), "");
		#/
		duration = params.var_77449e9;
		player.var_fee1c0df = gettime() + duration;
		if(var_1c365dd)
		{
			damageamount = (isdefined(level.var_87226c31.bundle.var_24458de7) ? level.var_87226c31.bundle.var_24458de7 : 0);
		}
		else
		{
			damageamount = (isdefined(level.var_87226c31.bundle.var_a9502662) ? level.var_87226c31.bundle.var_a9502662 : 0);
		}
		if(level.hardcoremode)
		{
			damageamount = damageamount * (isdefined(level.var_87226c31.bundle.var_78c1e37b) ? level.var_87226c31.bundle.var_78c1e37b : 0.25);
		}
		player dodamage(damageamount, player.origin, concertinawire.owner, concertinawire, undefined, "MOD_IMPACT", 0, level.var_87226c31.var_3e7344ee);
		player status_effect::status_effect_apply(params, level.var_87226c31.var_3e7344ee, concertinawire.owner, 0, undefined, undefined, player.origin);
	}
	concertinawire function_a9160578(damageamount, player);
}

/*
	Name: function_b842eab8
	Namespace: concertina_wire
	Checksum: 0x39C36C8
	Offset: 0x3168
	Size: 0x172
	Parameters: 0
	Flags: None
*/
function function_b842eab8()
{
	level endon(#"game_ended");
	params = function_4d1e7b48(level.var_87226c31.bundle.var_f6fdbda7);
	while(true)
	{
		foreach(player in level.players)
		{
			if(!isdefined(player))
			{
				continue;
			}
			if(!isdefined(player.var_cd7665dd) || !(isdefined(player.var_85c3882d) ? player.var_85c3882d : 0))
			{
				continue;
			}
			timesincelast = gettime() - player.var_cd7665dd;
			if(timesincelast > 250)
			{
				player.var_85c3882d = 0;
				player status_effect::function_408158ef(params.var_67e2281d, params.var_18d16a6b);
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_f067d867
	Namespace: concertina_wire
	Checksum: 0x65A79650
	Offset: 0x32E8
	Size: 0x81E
	Parameters: 1
	Flags: None
*/
function function_f067d867(concertinawire)
{
	level endon(#"game_ended");
	concertinawire endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = concertinawire.trigger waittill(#"trigger");
		player = waitresult.activator;
		if(!isplayer(player))
		{
			isenemy = isdefined(concertinawire.owner) && isdefined(player.owner) && (!level.teambased || util::function_fbce7263(player.team, concertinawire.owner.team)) && player.owner != concertinawire.owner;
			if(isdefined(player.killstreaktype) && (player.killstreaktype == "recon_car" || player.killstreaktype == "inventory_recon_car") && isenemy)
			{
				player dodamage(1, player.origin, concertinawire.owner, concertinawire, undefined, "MOD_IMPACT", 0, level.var_87226c31.var_3e7344ee);
			}
			if(isdefined(player.archetype) && player.archetype == #"robot" && util::function_fbce7263(player.team, concertinawire.owner.team))
			{
				player.var_85c3882d = 1;
				continue;
			}
			if(isdefined(player.archetype) && player.archetype == #"wasp" && util::function_fbce7263(player.team, concertinawire.owner.team))
			{
				continue;
			}
			if(isdefined(concertinawire.owner) && util::function_fbce7263(player.team, concertinawire.owner.team))
			{
				if(!(isdefined(player.var_65e57a10) && player.var_65e57a10))
				{
					if(getdvarint(#"hash_4cfef227405e3c46", 0))
					{
						damageamount = 10;
					}
					else
					{
						damageamount = (isdefined(level.var_87226c31.bundle.var_acadc685) ? level.var_87226c31.bundle.var_acadc685 : 0);
					}
					concertinawire dodamage(damageamount, player.origin, concertinawire.owner, concertinawire, undefined, "MOD_IMPACT", 0, level.var_87226c31.var_3e7344ee);
				}
				player callback::callback(#"hash_3bb51ce51020d0eb", {#wire:concertinawire});
			}
			continue;
		}
		player.var_cd7665dd = gettime();
		player.var_c6a21b50 = concertinawire;
		player.var_85c3882d = 1;
		var_50487836 = isdefined(concertinawire.owner) && (!level.teambased || util::function_fbce7263(player.team, concertinawire.owner.team)) && player != concertinawire.owner;
		var_da47eedd = 0;
		if(level.var_87226c31.var_17a4fddd === player.currentweapon)
		{
			var_da47eedd = 1;
		}
		var_434fa90d = var_da47eedd || player isslamming() || player isjuking();
		if(var_50487836 && !var_434fa90d)
		{
			concertinawire function_2dd4aa9d(player);
		}
		var_e8c58890 = 0;
		if(isdefined(player.var_d98c5084))
		{
			distancemoved = distance2d(player.var_d98c5084, player.origin);
			if(distancemoved < 0.0001)
			{
			}
			else if(!isdefined(player.var_45650309) || (gettime() > (player.var_45650309 + 350) && distancemoved > 0.5))
			{
				var_e8c58890 = 1;
			}
		}
		else
		{
			var_e8c58890 = 1;
		}
		if(var_e8c58890)
		{
			player playsound(#"hash_4b5965717e4efc71");
			player.var_45650309 = gettime();
			if((isdefined(var_50487836) ? var_50487836 : 0) && !var_434fa90d)
			{
				player gestures::function_56e00fbf(#"hash_3e06c757e4b20f4f", undefined, 0);
			}
		}
		player.var_d98c5084 = player.origin;
		if(var_50487836 && !var_434fa90d)
		{
			function_dac69ad1(player, concertinawire);
		}
		if(var_da47eedd && isdefined(level.var_87226c31.bundle.var_2aa7241e))
		{
			if(!isdefined(concertinawire.var_2dd485d4[player.clientid]) || (concertinawire.var_2dd485d4[player.clientid] + 500) < gettime())
			{
				if(!isdefined(concertinawire.var_2dd485d4[player.clientid]))
				{
					concertinawire.var_2dd485d4[player.clientid] = gettime();
				}
				var_33ecfd86 = level.var_87226c31.bundle.var_2aa7241e * 0.5;
				concertinawire dodamage(var_33ecfd86, player.origin, player, undefined, undefined, "MOD_IMPACT", 0, player.currentweapon);
				concertinawire.var_2dd485d4[player.clientid] = gettime();
			}
		}
	}
}

/*
	Name: function_41225d9b
	Namespace: concertina_wire
	Checksum: 0xA5D89FB3
	Offset: 0x3B10
	Size: 0x82
	Parameters: 2
	Flags: Private
*/
function private function_41225d9b(player, var_16505949)
{
	player endon(#"death");
	player allowjump(0);
	player.var_10fb4c3d = 0;
	wait(var_16505949);
	player allowjump(1);
	player.var_10fb4c3d = 1;
}

/*
	Name: function_2dd4aa9d
	Namespace: concertina_wire
	Checksum: 0x60459CD9
	Offset: 0x3BA0
	Size: 0x4A2
	Parameters: 1
	Flags: Private
*/
function private function_2dd4aa9d(player)
{
	concertinawire = self;
	var_1c365dd = !(isdefined(level.var_cbec7a45) && level.var_cbec7a45) && level.var_87226c31.bundle.var_baf7c45 && player status_effect::function_3c54ae98(2) >= level.var_87226c31.bundle.var_baf7c45;
	if(player jumpbuttonpressed() && (isdefined(player.var_10fb4c3d) ? player.var_10fb4c3d : 1))
	{
		if(!isdefined(player.var_357edf99) || !player.var_357edf99)
		{
			if(var_1c365dd)
			{
				damageamount = (isdefined(level.var_87226c31.bundle.var_24458de7) ? level.var_87226c31.bundle.var_24458de7 : 0);
				var_30df0193 = (isdefined(level.var_87226c31.bundle.var_2ec8f744) ? level.var_87226c31.bundle.var_2ec8f744 : 0);
			}
			else
			{
				damageamount = (isdefined(level.var_87226c31.bundle.var_a9502662) ? level.var_87226c31.bundle.var_a9502662 : 0);
				var_30df0193 = (isdefined(level.var_87226c31.bundle.var_41225d9b) ? level.var_87226c31.bundle.var_41225d9b : 0);
			}
			player dodamage(damageamount, player.origin, concertinawire.owner, concertinawire, undefined, "MOD_IMPACT", 0, level.var_87226c31.var_3e7344ee);
			player.var_357edf99 = 1;
			thread function_41225d9b(player, var_30df0193);
			concertinawire function_a9160578(damageamount, player);
		}
	}
	else
	{
		player.var_357edf99 = 0;
	}
	if(player isdoublejumping())
	{
		player setdoublejumpenergy(0);
	}
	if(!isdefined(player.var_673f6995) || player.var_673f6995 < gettime())
	{
		params = function_4d1e7b48(level.var_87226c31.bundle.var_f6fdbda7);
		/#
			assert(isdefined(params), "");
		#/
		duration = params.var_77449e9;
		player.var_673f6995 = gettime() + duration;
		player.var_fc55d553 = 0;
	}
	if(!isdefined(player.var_13d8a85d) || player.var_13d8a85d < gettime())
	{
		params = function_4d1e7b48(level.var_87226c31.bundle.var_f6fdbda7);
		/#
			assert(isdefined(params), "");
		#/
		player status_effect::status_effect_apply(params, level.var_87226c31.var_3e7344ee, concertinawire.owner, 1, undefined, undefined, player.origin);
		endtime = player status_effect::function_2ba2756c(params.var_18d16a6b);
		player.var_13d8a85d = endtime - 75;
	}
}

/*
	Name: function_a9160578
	Namespace: concertina_wire
	Checksum: 0xB01BCBFA
	Offset: 0x4050
	Size: 0x166
	Parameters: 2
	Flags: None
*/
function function_a9160578(damagedealt, player)
{
	if(!isdefined(player) || !isdefined(damagedealt) || !isdefined(self))
	{
		return;
	}
	damagedealt = int(damagedealt);
	self.damagedealt = (isdefined(self.damagedealt) ? self.damagedealt : 0) + damagedealt;
	if(!isdefined(self.var_84ac42b3))
	{
		self.var_84ac42b3 = [];
	}
	var_25e4be49 = player getentitynumber();
	self.var_84ac42b3[var_25e4be49] = 1;
	if(isdefined(level.var_87226c31.bundle.var_89ee8a9) && self.damagedealt >= level.var_87226c31.bundle.var_89ee8a9)
	{
		scoreevents::processscoreevent(#"hash_6024b59ca1d3b641", self.owner, undefined, self.weapon, self.var_84ac42b3.size);
		self.damagedealt = self.damagedealt - level.var_87226c31.bundle.var_89ee8a9;
	}
}

/*
	Name: function_82c4beb0
	Namespace: concertina_wire
	Checksum: 0x8B191BCB
	Offset: 0x41C0
	Size: 0x3C2
	Parameters: 12
	Flags: None
*/
function function_82c4beb0(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, iboneindex, imodelindex)
{
	if(isdefined(self.owner))
	{
		myteam = self.owner.team;
	}
	if(!isdefined(myteam))
	{
		return 0;
	}
	if(isdefined(eattacker))
	{
		otherteam = eattacker.team;
	}
	var_1133e6dc = util::function_fbce7263(myteam, otherteam);
	if(weapon_utils::ismeleemod(smeansofdeath) && isdefined(level.var_87226c31.bundle.var_7f93f9c) && (isdefined(var_1133e6dc) && var_1133e6dc))
	{
		var_1c365dd = !(isdefined(level.var_cbec7a45) && level.var_cbec7a45) && level.var_87226c31.bundle.var_baf7c45 && eattacker status_effect::function_3c54ae98(2) >= level.var_87226c31.bundle.var_baf7c45;
		if(var_1c365dd)
		{
			damageamount = (isdefined(level.var_87226c31.bundle.var_d5eccf80) ? level.var_87226c31.bundle.var_d5eccf80 : 0);
		}
		else
		{
			damageamount = (isdefined(level.var_87226c31.bundle.var_7f93f9c) ? level.var_87226c31.bundle.var_7f93f9c : 0);
		}
		if(weapon == getweapon("sig_blade"))
		{
			damageamount = 0;
		}
		if(damageamount > 0)
		{
			eattacker dodamage(damageamount, self.origin, self.owner, self, undefined, "MOD_IMPACT", 0, level.var_87226c31.var_3e7344ee);
			self function_a9160578(damageamount, eattacker);
		}
	}
	if(weapon_utils::isexplosivedamage(smeansofdeath))
	{
		idamage = int(idamage * (isdefined(level.var_87226c31.bundle.var_7a4fd57b) ? level.var_87226c31.bundle.var_7a4fd57b : 0));
	}
	shotstokill = killstreak_bundles::get_shots_to_kill(weapon, smeansofdeath, level.var_87226c31.bundle);
	if(shotstokill == 0)
	{
	}
	else
	{
		if(shotstokill > 0)
		{
			idamage = (self.startinghealth / shotstokill) + 1;
		}
		else
		{
			idamage = 0;
		}
	}
	return int(idamage);
}

/*
	Name: function_639cb9da
	Namespace: concertina_wire
	Checksum: 0x567AB760
	Offset: 0x4590
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function function_639cb9da()
{
	self endon(#"death");
	level waittill(#"game_ended");
	if(!isdefined(self))
	{
		return;
	}
	self function_4ee7d46a(1);
}

/*
	Name: function_34d706ae
	Namespace: concertina_wire
	Checksum: 0xA05EF193
	Offset: 0x45E8
	Size: 0x6E6
	Parameters: 6
	Flags: None
*/
function function_34d706ae(watcher, var_db52b808, origin, angles, var_796be15d, width)
{
	player = self;
	var_bf8e4260 = spawn("script_model", origin);
	var_bf8e4260.targetname = "concertina_wire";
	var_db52b808.concertinawire = var_bf8e4260;
	var_bf8e4260.grenade = var_db52b808;
	var_bf8e4260 setmodel(level.var_87226c31.var_3e7344ee.var_22082a57);
	watcher.objectarray[watcher.objectarray.size] = var_bf8e4260;
	var_bf8e4260.var_2ee191cc = [];
	var_bf8e4260.var_2dd485d4 = [];
	var_2358ae9 = anglestoright(angles);
	var_8a455f75 = origin - ((width * 0.5) * var_2358ae9);
	var_2d71f8ca = int(width / 32);
	for(index = 0; index < var_2d71f8ca; index++)
	{
		var_a4879492 = deployable::function_d60e5a06(var_8a455f75, 32);
		array::add(var_bf8e4260.var_2ee191cc, var_a4879492);
		var_8a455f75 = var_8a455f75 + (var_2358ae9 * 64);
	}
	var_bf8e4260.var_86a21346 = &function_82c4beb0;
	var_bf8e4260.angles = angles;
	var_bf8e4260.owner = player;
	var_bf8e4260.takedamage = 1;
	var_bf8e4260.startinghealth = (isdefined(level.var_87226c31.bundle.var_d9317c6b) ? level.var_87226c31.bundle.var_d9317c6b : 0);
	var_bf8e4260.health = var_bf8e4260.startinghealth;
	var_bf8e4260.var_3b0688ef = "concertina_wire_badplace" + var_bf8e4260 getentitynumber();
	badplace_box(var_bf8e4260.var_3b0688ef, 0, var_bf8e4260.origin, width / 2, "all");
	var_bf8e4260 setteam(player getteam());
	var_bf8e4260 setweapon(level.var_87226c31.var_3e7344ee);
	var_bf8e4260.weapon = level.var_87226c31.var_3e7344ee;
	array::add(player.concertinawire.var_a3aac76c, var_bf8e4260);
	if(isdefined(level.var_87226c31.var_546a220c))
	{
		var_bf8e4260.objectiveid = gameobjects::get_next_obj_id();
		objective_add(var_bf8e4260.objectiveid, "active", var_bf8e4260, level.var_87226c31.var_546a220c);
		function_da7940a3(var_bf8e4260.objectiveid, 1);
		objective_setteam(var_bf8e4260.objectiveid, player.team);
	}
	var_35c2e583 = player gadgetgetslot(level.var_87226c31.var_3e7344ee);
	if(!function_f99d2668())
	{
		self gadgetpowerset(var_35c2e583, 0);
	}
	var_bf8e4260 setteam(player.team);
	array::add(level.var_87226c31.var_925bbb2, var_bf8e4260);
	var_bf8e4260 clientfield::set("friendlyequip", 1);
	var_bf8e4260 clientfield::set("enemyequip", 1);
	var_bf8e4260 thread ondamage();
	var_bf8e4260 thread function_dd007be2();
	var_bf8e4260 thread function_639cb9da();
	var_bf8e4260.victimsoundmod = "vehicle";
	killcament = spawn("script_model", var_bf8e4260.origin + ((isdefined(level.var_87226c31.bundle.var_eb9150a5) ? level.var_87226c31.bundle.var_eb9150a5 : 0), (isdefined(level.var_87226c31.bundle.var_26a346c8) ? level.var_87226c31.bundle.var_26a346c8 : 0), (isdefined(level.var_87226c31.bundle.var_d0fb9b7a) ? level.var_87226c31.bundle.var_d0fb9b7a : 0)));
	killcament.targetname = "concertina_wire_killcament";
	var_bf8e4260.killcament = killcament;
	player deployable::function_6ec9ee30(var_bf8e4260, level.var_87226c31.var_3e7344ee);
	watcher.objectarray[watcher.objectarray.size] = killcament;
	return var_bf8e4260;
}

/*
	Name: function_18dd6b22
	Namespace: concertina_wire
	Checksum: 0xD3CF9439
	Offset: 0x4CD8
	Size: 0xA0
	Parameters: 1
	Flags: None
*/
function function_18dd6b22(concertinawire)
{
	level endon(#"game_ended");
	concertinawire endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = concertinawire waittill(#"broken");
		if(waitresult.type == "base_piece_broken")
		{
			concertinawire function_4ee7d46a(0);
		}
	}
}

/*
	Name: function_6541080b
	Namespace: concertina_wire
	Checksum: 0x1E6A50D4
	Offset: 0x4D80
	Size: 0xB6
	Parameters: 2
	Flags: None
*/
function function_6541080b(origin, maxdistancesq)
{
	foreach(concertinawire in level.var_87226c31.var_925bbb2)
	{
		if(!isdefined(concertinawire))
		{
			continue;
		}
		if(distancesquared(concertinawire.origin, origin) < maxdistancesq)
		{
			return true;
		}
	}
	return false;
}

/*
	Name: watchweaponchange
	Namespace: concertina_wire
	Checksum: 0xFA4EF1EB
	Offset: 0x4E40
	Size: 0x88
	Parameters: 0
	Flags: None
*/
function watchweaponchange()
{
	player = self;
	self notify(#"hash_7c317ca72a23c2a6");
	self endon(#"hash_7c317ca72a23c2a6");
	while(true)
	{
		if(self weaponswitchbuttonpressed())
		{
			if(isdefined(player.concertinawire))
			{
				player.concertinawire.var_5af6633b = 1;
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_57f553e9
	Namespace: concertina_wire
	Checksum: 0x12439E79
	Offset: 0x4ED0
	Size: 0x6A
	Parameters: 2
	Flags: None
*/
function function_57f553e9(var_85947e0d, maxallowed)
{
	if(var_85947e0d.size <= maxallowed)
	{
		return undefined;
	}
	outstayed_spawner = array::pop_front(var_85947e0d, 0);
	var_85947e0d = array::remove_undefined(var_85947e0d, 0);
	return outstayed_spawner;
}

