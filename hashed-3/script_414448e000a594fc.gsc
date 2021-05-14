// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_50299901e4f5f38c;
#using script_545a0bac37bda541;
#using script_57c900a7e39234be;
#using script_64ab2b950d85b8ad;
#using script_6c8abe14025b47c4;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\gestures.gsc;
#using scripts\core_common\oob.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_ai_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;

#namespace namespace_a91ab695;

/*
	Name: function_89f2df9
	Namespace: namespace_a91ab695
	Checksum: 0x322E18DB
	Offset: 0x1B8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_695cd3bbff366240", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_a91ab695
	Checksum: 0x1A3C024F
	Offset: 0x200
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.hawk_settings = spawnstruct();
	level.hawk_settings.weapon = getweapon(#"eq_hawk");
	level.hawk_settings.bundle = getscriptbundle("hawk_settings_wz");
	/#
		assert(isdefined(level.hawk_settings.bundle));
	#/
	callback::on_finalize_initialization(&function_3675de8b);
	callback::function_955a779c(&function_955a779c);
	clientfield::register("vehicle", "hawk_range", 13000, 1, "int");
}

/*
	Name: function_3675de8b
	Namespace: namespace_a91ab695
	Checksum: 0xDB538FF1
	Offset: 0x318
	Size: 0x56
	Parameters: 0
	Flags: Linked
*/
function function_3675de8b()
{
	map_center = airsupport::getmapcenter();
	level.var_5718bd08 = (isdefined(level.var_7fd6bd44) ? level.var_7fd6bd44 : map_center[2] + 1000);
}

/*
	Name: function_955a779c
	Namespace: namespace_a91ab695
	Checksum: 0xB8041CBD
	Offset: 0x378
	Size: 0x11C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_955a779c(params)
{
	self endon(#"death", #"disconnect", #"begin_grenade_tracking", #"grenade_throw_cancelled");
	if(!isdefined(params.item) || !isdefined(params.item.var_a6762160) || !isdefined(params.item.var_a6762160.weapon) || params.item.var_a6762160.weapon.name != #"eq_hawk")
	{
		return;
	}
	self waittill(#"grenade_fire");
	self thread function_7dfe3289(params.item.id);
}

/*
	Name: function_6ada73f
	Namespace: namespace_a91ab695
	Checksum: 0x54CCA7F0
	Offset: 0x4A0
	Size: 0x4A
	Parameters: 1
	Flags: Linked
*/
function function_6ada73f(spawnpos)
{
	return physicstrace(self.origin, spawnpos, vectorscale((-1, -1, 0), 18), (18, 18, 12), undefined, 16 | 2);
}

/*
	Name: function_900bb4f5
	Namespace: namespace_a91ab695
	Checksum: 0xB71A6076
	Offset: 0x4F8
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_900bb4f5(params)
{
	if(isdefined(self))
	{
		self thread hawk::function_4c1ea6ce();
	}
}

/*
	Name: function_7dfe3289
	Namespace: namespace_a91ab695
	Checksum: 0x7217D9C5
	Offset: 0x530
	Size: 0x644
	Parameters: 1
	Flags: Linked
*/
function function_7dfe3289(var_d8138db2)
{
	self endon(#"disconnect", #"joined_team", #"joined_spectators", #"changed_specialist", #"changed_specialist_death");
	if(isdefined(self.hawk) && isdefined(self.hawk.vehicle))
	{
		self.hawk.vehicle hawk::function_4c1ea6ce(1);
	}
	self.hawk = spawnstruct();
	vehicletype = "veh_hawk_player_wz";
	playerangles = self getplayerangles();
	var_865c71c9 = (playerangles[0], playerangles[1], 0);
	var_c7588ce0 = (0, playerangles[1], 0);
	forward = anglestoforward(var_c7588ce0);
	forward = forward * 20;
	spawnpos = self.origin + vectorscale((0, 0, 1), 90) + forward;
	trace = self function_6ada73f(spawnpos);
	if(trace[#"fraction"] < 1)
	{
		spawnpos = self.origin + vectorscale((0, 0, 1), 75) + forward;
		trace = function_6ada73f(spawnpos);
	}
	if(trace[#"fraction"] < 1)
	{
		spawnpos = self.origin + vectorscale((0, 0, 1), 45) + forward;
		trace = function_6ada73f(spawnpos);
	}
	if(trace[#"fraction"] < 1)
	{
		spawnpos = self.origin + vectorscale((0, 0, 1), 75);
		trace = function_6ada73f(spawnpos);
	}
	if(trace[#"fraction"] < 1)
	{
		spawnpos = self.origin + vectorscale((0, 0, 1), 45);
	}
	if(!function_3238d10d(spawnpos))
	{
		self.hawk = undefined;
		return;
	}
	vehicle = spawnvehicle(vehicletype, spawnpos, var_c7588ce0);
	vehicle setteam(self.team);
	vehicle.team = self.team;
	vehicle.owner = self;
	vehicle.weapon = getweapon("eq_hawk");
	vehicle.var_20c71d46 = 1;
	vehicle.overridevehicledamage = &function_b162cdbd;
	vehicle.var_c5d65381 = 1;
	vehicle.var_8516173f = 1;
	vehicle.glasscollision_alt = 1;
	vehicle.is_staircase_up = &function_900bb4f5;
	vehicle.id = var_d8138db2;
	level.var_d79f1ee4[level.var_d79f1ee4.size] = vehicle;
	vehicle thread namespace_b376ff3f::function_956a8ecd();
	self.hawk.vehicle = vehicle;
	bundle = level.hawk_settings.bundle;
	var_a33bcd86 = int((isdefined(bundle.var_a33bcd86) ? bundle.var_a33bcd86 : 0));
	if(isbot(self))
	{
		var_a33bcd86 = 0;
	}
	if(isdefined(vehicle))
	{
		if(var_a33bcd86)
		{
			self freezecontrolsallowlook(1);
			util::wait_network_frame(1);
			if(!isalive(vehicle))
			{
				return;
			}
		}
		vehicle.var_d733e01c = 1;
		if(var_a33bcd86)
		{
			self.hawk.controlling = 1;
			self thread function_1b057db2();
			vehicle usevehicle(self, 0);
			self setplayerangles(var_865c71c9);
			self freezecontrolsallowlook(0);
			self util::setusingremote("hawk");
		}
		else
		{
			vehicle.var_e9f68b24 = var_865c71c9;
		}
		self thread function_1e7eecd7(vehicle, var_a33bcd86);
		self thread function_76da409d(vehicle);
		self thread function_df5590b(vehicle);
		self create_missile_hud(vehicle, var_a33bcd86);
		self thread function_6777d6d9(vehicle);
		self thread oob::function_c5278cb0(vehicle);
	}
}

/*
	Name: function_b162cdbd
	Namespace: namespace_a91ab695
	Checksum: 0xFE1AD4DC
	Offset: 0xB80
	Size: 0x118
	Parameters: 15
	Flags: Linked
*/
function function_b162cdbd(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal)
{
	if(gettime() - self.birthtime <= 350)
	{
		return 0;
	}
	startinghealth = 400;
	if(isdefined(level.hawk_settings.bundle.var_108f064f) && weapon == getweapon(#"shock_rifle"))
	{
		idamage = startinghealth / level.hawk_settings.bundle.var_108f064f;
	}
	return idamage;
}

/*
	Name: function_df5590b
	Namespace: namespace_a91ab695
	Checksum: 0x33AD2170
	Offset: 0xCA0
	Size: 0xE2
	Parameters: 1
	Flags: Linked
*/
function function_df5590b(vehicle)
{
	self endon(#"disconnect", #"joined_team", #"joined_spectators", #"changed_specialist", #"changed_specialist_death");
	vehicle endon(#"death");
	playerorigin = self.origin;
	while(true)
	{
		playerorigin = function_ed9fa4fc(vehicle, playerorigin);
		if(isdefined(self.isjammed) && self.isjammed)
		{
			self thread function_1eddba48();
			break;
		}
		waitframe(1);
	}
}

/*
	Name: function_ed9fa4fc
	Namespace: namespace_a91ab695
	Checksum: 0xC36B01BD
	Offset: 0xD90
	Size: 0x2D6
	Parameters: 2
	Flags: Linked
*/
function function_ed9fa4fc(vehicle, playerorigin)
{
	if(isalive(self))
	{
		playerorigin = self.origin;
	}
	vehicle.var_b61d83c4 = 0;
	self.hawk.var_b61d83c4 = 0;
	distsqr = distancesquared(vehicle.origin, playerorigin);
	if(distsqr > level.hawk_settings.bundle.var_6e4818a6 * level.hawk_settings.bundle.var_6e4818a6 || vehicle.origin[2] > level.var_5718bd08)
	{
		vehicle clientfield::set("hawk_range", 1);
		vehicle.var_b61d83c4 = 1;
		self.hawk.var_b61d83c4 = 1;
	}
	else
	{
		vehicle clientfield::set("hawk_range", 0);
	}
	if(isalive(self) && self isinvehicle() && self getvehicleoccupied() == vehicle)
	{
		if(distsqr > level.hawk_settings.bundle.max_distance * level.hawk_settings.bundle.max_distance)
		{
			self thread function_1eddba48();
		}
		if(isdefined(level.deathcircle))
		{
			if(distance2dsquared(vehicle.origin, level.deathcircle.origin) > level.deathcircle.radius * level.deathcircle.radius)
			{
				if(!isdefined(vehicle.var_3de57a77))
				{
					vehicle.var_3de57a77 = gettime();
				}
				var_a71a8383 = gettime() - vehicle.var_3de57a77;
				if(int(1 * 1000) <= var_a71a8383)
				{
					vehicle hawk::function_4c1ea6ce();
				}
			}
			else
			{
				vehicle.var_3de57a77 = undefined;
			}
		}
	}
	return playerorigin;
}

/*
	Name: function_76da409d
	Namespace: namespace_a91ab695
	Checksum: 0x7E56B4D
	Offset: 0x1070
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_76da409d(vehicle)
{
	self endon(#"disconnect");
	vehicle waittill(#"death");
	if(isdefined(self))
	{
		if(!self util::function_63d27d4e("remote_missile"))
		{
			self destroy_missile_hud();
		}
	}
}

/*
	Name: function_d89c1628
	Namespace: namespace_a91ab695
	Checksum: 0x673E7954
	Offset: 0x10F0
	Size: 0xC6
	Parameters: 1
	Flags: Linked
*/
function function_d89c1628(vehicle)
{
	if(!(isdefined(vehicle.var_d733e01c) && vehicle.var_d733e01c))
	{
		return 0;
	}
	if(self isremotecontrolling() || self util::isusingremote())
	{
		return 0;
	}
	if(self.hawk.var_a3b23d12)
	{
		return 0;
	}
	if(!self fragbuttonpressed())
	{
		return 0;
	}
	if(self function_15049d95())
	{
		return 0;
	}
	if(!isalive(self))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_1eddba48
	Namespace: namespace_a91ab695
	Checksum: 0xA9AF71C7
	Offset: 0x11C0
	Size: 0x1C4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_1eddba48()
{
	if(!isdefined(self) || !isdefined(self.hawk) || !isdefined(self.hawk.vehicle) || self.hawk.vehicle.var_55dded30 !== self)
	{
		return;
	}
	hawk = self.hawk.vehicle;
	if(hawk.var_720290e3 === 1)
	{
		return;
	}
	hawk.var_720290e3 = 1;
	hawk.var_d733e01c = 0;
	self.hawk.controlling = 0;
	self clientfield::set_to_player("static_postfx", 1);
	var_9e2fe80f = (isdefined(level.hawk_settings.bundle.var_2f47b335) ? level.hawk_settings.bundle.var_2f47b335 : 0.5);
	wait(var_9e2fe80f);
	if(isdefined(self))
	{
		self clientfield::set_to_player("static_postfx", 0);
	}
	if(isdefined(self) && isdefined(hawk) && self isinvehicle() && self getvehicleoccupied() === hawk)
	{
		hawk usevehicle(self, 0);
	}
}

/*
	Name: function_1e7eecd7
	Namespace: namespace_a91ab695
	Checksum: 0xF4206EFB
	Offset: 0x1390
	Size: 0x428
	Parameters: 2
	Flags: Linked
*/
function function_1e7eecd7(vehicle, var_44e9a475)
{
	self endon(#"disconnect", #"joined_team", #"joined_spectators", #"changed_specialist", #"changed_specialist_death");
	vehicle endon(#"death");
	if(var_44e9a475)
	{
		self.hawk.controlling = 1;
		vehicle.var_55dded30 = self;
		vehicle.playercontrolled = 1;
	}
	else
	{
		self.hawk.controlling = 0;
		vehicle.var_55dded30 = undefined;
		vehicle.playercontrolled = 0;
	}
	self.hawk.var_a3b23d12 = 1;
	while(true)
	{
		if(self.hawk.controlling)
		{
			self thread function_c4770b46(vehicle);
			self waittill(#"exit_vehicle");
			self.hawk.controlling = 0;
			vehicle.player = self;
			vehicle.var_55dded30 = undefined;
			vehicle.playercontrolled = 0;
			vehicle setspeedimmediate(0);
			vehicle setvehvelocity((0, 0, 0));
			vehicle setphysacceleration((0, 0, 0));
			vehicle setangularvelocity((0, 0, 0));
			vehicle setneargoalnotifydist(40);
			vehicle setgoal(vehicle.origin, 1);
			vehicle function_a57c34b7(vehicle.origin, 1, 0);
			vehicle makevehicleunusable();
			self util::function_9a39538a();
			self.hawk.var_a3b23d12 = 1;
			self playsoundtoplayer("gdt_hawk_pov_out", self);
			if(!(isdefined(vehicle.being_destroyed) && vehicle.being_destroyed))
			{
				vehicle notify(#"hash_47147249212b6a46");
			}
			return;
		}
		if(self function_d89c1628(vehicle))
		{
			self.hawk.controlling = 1;
			self thread function_1b057db2();
			vehicle usevehicle(self, 0);
			vehicle.var_55dded30 = self;
			vehicle.playercontrolled = 1;
			self util::setusingremote("hawk");
			vehicle playsoundtoplayer("gdt_hawk_pov_in", self);
			self freezecontrolsallowlook(0);
			vehicle vehicle_ai::clearallmovement();
			vehicle function_d4c687c9();
			if(isdefined(vehicle.var_e9f68b24))
			{
				self setplayerangles(vehicle.var_e9f68b24);
			}
		}
		else if(!self fragbuttonpressed())
		{
			self.hawk.var_a3b23d12 = 0;
		}
		waitframe(1);
	}
}

/*
	Name: function_1b057db2
	Namespace: namespace_a91ab695
	Checksum: 0x6ED4927D
	Offset: 0x17C0
	Size: 0x1DE
	Parameters: 0
	Flags: Linked
*/
function function_1b057db2()
{
	self endon(#"disconnect", #"joined_team", #"joined_spectators", #"changed_specialist", #"changed_specialist_death");
	self notify("6954b7d60005c9f0");
	self endon("6954b7d60005c9f0");
	var_10a85d23 = self gestures::function_c77349d4("gestable_drone_hawk_pda");
	self stopgestureviewmodel(var_10a85d23, 0, 0);
	if(isdefined(self.var_f97921ea))
	{
		var_a4137bf5 = gettime() - self.var_f97921ea;
		if(var_a4137bf5 < 850)
		{
			wait(float(850 - var_a4137bf5) / 1000);
		}
	}
	var_37ea2019 = 0;
	while(!var_37ea2019 && isalive(self) && self.hawk.controlling)
	{
		if(self gestures::function_b204f6e3(var_10a85d23, undefined, 0))
		{
			var_37ea2019 = 1;
			self waittill(#"exit_vehicle", #"death");
			self.var_f97921ea = gettime();
			self stopgestureviewmodel(var_10a85d23, 0, 0);
		}
		waitframe(1);
	}
}

/*
	Name: function_9096c10
	Namespace: namespace_a91ab695
	Checksum: 0x81303FE7
	Offset: 0x19A8
	Size: 0x4E
	Parameters: 0
	Flags: Linked
*/
function function_9096c10()
{
	return self usebuttonpressed() || (self stancebuttonpressed() && self gamepadusedlast());
}

/*
	Name: function_c4770b46
	Namespace: namespace_a91ab695
	Checksum: 0xBA49F5F8
	Offset: 0x1A00
	Size: 0x124
	Parameters: 1
	Flags: Linked
*/
function function_c4770b46(vehicle)
{
	self notify("7ebee304d299c8bb");
	self endon("7ebee304d299c8bb");
	vehicle endon(#"death");
	self endon(#"disconnect", #"joined_team", #"joined_spectators", #"changed_specialist", #"changed_specialist_death", #"exit_vehicle");
	while(self function_9096c10())
	{
		waitframe(1);
	}
	while(!self function_9096c10())
	{
		waitframe(1);
	}
	while(self function_9096c10())
	{
		waitframe(1);
	}
	waitframe(1);
	vehicle usevehicle(self, 0);
}

/*
	Name: function_6777d6d9
	Namespace: namespace_a91ab695
	Checksum: 0x7DE5E03E
	Offset: 0x1B30
	Size: 0xA0
	Parameters: 1
	Flags: Linked
*/
function function_6777d6d9(hawk)
{
	hawk endon(#"death");
	waitresult = undefined;
	waitresult = self waittill(#"disconnect", #"joined_team", #"joined_spectator", #"changed_specialist", #"changed_specialist_death");
	if(!isdefined(hawk))
	{
		return;
	}
	hawk notify(#"hash_47147249212b6a46");
}

/*
	Name: create_missile_hud
	Namespace: namespace_a91ab695
	Checksum: 0xF1CBC715
	Offset: 0x1BD8
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function create_missile_hud(vehicle, var_a33bcd86)
{
	player = self;
	if(var_a33bcd86)
	{
		vehicle playsoundtoplayer("gdt_hawk_pov_in", self);
	}
}

/*
	Name: destroy_missile_hud
	Namespace: namespace_a91ab695
	Checksum: 0x80F724D1
	Offset: 0x1C30
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function destroy_missile_hud()
{
}

