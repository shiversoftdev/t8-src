// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_6c8abe14025b47c4;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_ai_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;

#namespace hawk;

/*
	Name: function_89f2df9
	Namespace: hawk
	Checksum: 0xBF5C1A4C
	Offset: 0x1A8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hawk", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: hawk
	Checksum: 0x27C87B9E
	Offset: 0x1F0
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	vehicle::add_main_callback("hawk", &function_b0abff80);
	callback::on_vehicle_killed(&on_vehicle_killed);
}

/*
	Name: function_b0abff80
	Namespace: hawk
	Checksum: 0x39F71F37
	Offset: 0x248
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_b0abff80()
{
	statemachine = self vehicle_ai::init_state_machine_for_role("default");
	self vehicle_ai::get_state_callbacks("death").update_func = &vehicle_ai::defaultstate_death_update;
	self vehicle_ai::call_custom_add_state_callbacks();
	self vehicle::toggle_sounds(1);
	self disabledriverfiring(1);
	self.ignore_death_jolt = 1;
	target_set(self);
}

/*
	Name: function_ca9b286c
	Namespace: hawk
	Checksum: 0x71A4DF63
	Offset: 0x310
	Size: 0xDC
	Parameters: 1
	Flags: Event
*/
event function_ca9b286c(eventstruct)
{
	if(!isplayer(self))
	{
		return;
	}
	vehicle = eventstruct.vehicle;
	if(!isdefined(vehicle.scriptvehicletype) || vehicle.scriptvehicletype != "hawk")
	{
		return;
	}
	vehicle function_d733412a(0);
	vehicle makevehicleusable();
	self clientfield::set_player_uimodel("hudItems.abilityHintIndex", 5);
	self thread function_a2270a7e(vehicle);
}

/*
	Name: function_e011eea6
	Namespace: hawk
	Checksum: 0xDCDB901D
	Offset: 0x3F8
	Size: 0xBC
	Parameters: 1
	Flags: Event
*/
event function_e011eea6(eventstruct)
{
	if(!isplayer(self))
	{
		return;
	}
	vehicle = eventstruct.vehicle;
	if(!isdefined(vehicle.scriptvehicletype) || vehicle.scriptvehicletype != "hawk")
	{
		return;
	}
	if(isalive(vehicle))
	{
		vehicle makevehicleunusable();
	}
	self clientfield::set_player_uimodel("hudItems.abilityHintIndex", 0);
}

/*
	Name: function_a2270a7e
	Namespace: hawk
	Checksum: 0xEFF5AB5E
	Offset: 0x4C0
	Size: 0x1B6
	Parameters: 1
	Flags: Linked, Private
*/
function private function_a2270a7e(vehicle)
{
	self notify("5137fb3aeff763b1");
	self endon("5137fb3aeff763b1");
	self endon(#"death", #"disconnect");
	vehicle endon(#"death", #"exit_vehicle");
	if(function_f99d2668())
	{
		str_mode = "wz";
	}
	else
	{
		str_mode = "mp";
	}
	while(true)
	{
		if(vehicle depthinwater() > 0 && (gettime() - vehicle.birthtime) > 350)
		{
			vehicle dodamage(vehicle.health, vehicle.origin);
		}
		if(isdefined(vehicle.var_b61d83c4) && vehicle.var_b61d83c4)
		{
			if(vehicle.vehicletype != ("veh_hawk_player_far_range_" + str_mode))
			{
				vehicle setvehicletype("veh_hawk_player_far_range_" + str_mode);
			}
		}
		else if(vehicle.vehicletype != ("veh_hawk_player_" + str_mode))
		{
			vehicle setvehicletype("veh_hawk_player_" + str_mode);
		}
		waitframe(1);
	}
}

/*
	Name: on_vehicle_killed
	Namespace: hawk
	Checksum: 0x7141FB08
	Offset: 0x680
	Size: 0x19C
	Parameters: 1
	Flags: Linked, Private
*/
function private on_vehicle_killed(params)
{
	self endon(#"death", #"free_vehicle");
	if(!isdefined(self.scriptvehicletype) || self.scriptvehicletype != "hawk")
	{
		return;
	}
	if(target_istarget(self))
	{
		target_remove(self);
	}
	if(isdefined(params))
	{
		attacker = params.eattacker;
		if(isdefined(attacker) && isplayer(attacker) && isdefined(self.team) && self.team !== attacker.team)
		{
			if(isdefined(self.owner))
			{
				self.owner thread killstreaks::play_taacom_dialog("hawkWeaponDestroyedEnemy");
			}
			scoreevents::processscoreevent("hawk_destroyed", attacker, self, params.weapon);
			if(isdefined(level.var_d2600afc))
			{
				self [[level.var_d2600afc]](attacker, self.owner, self.weapon, params.weapon);
			}
		}
	}
	self function_4c1ea6ce();
}

/*
	Name: function_4c1ea6ce
	Namespace: hawk
	Checksum: 0xF38E139C
	Offset: 0x828
	Size: 0x5C4
	Parameters: 1
	Flags: Linked
*/
function function_4c1ea6ce(var_bb2c398b = 0)
{
	hawk = self;
	if(hawk.being_destroyed === 1)
	{
		return;
	}
	hawk.being_destroyed = 1;
	var_6f6e4d4d = "futz";
	var_9e2fe80f = 0.5;
	if(isdefined(level.hawk_settings) && isdefined(level.hawk_settings.bundle))
	{
		var_6f6e4d4d = (isdefined(level.hawk_settings.bundle.var_391e6668) ? level.hawk_settings.bundle.var_391e6668 : "futz");
		var_9e2fe80f = (isdefined(level.hawk_settings.bundle.var_2f47b335) ? level.hawk_settings.bundle.var_2f47b335 : 0.5);
	}
	var_5755b643 = var_6f6e4d4d == "futz";
	hawk.var_d733e01c = 0;
	owner = hawk.var_55dded30;
	if(isdefined(owner) && owner.hawk.controlling)
	{
		owner.hawk.controlling = 0;
		if(var_5755b643 && !var_bb2c398b)
		{
			owner clientfield::set_to_player("static_postfx", 1);
			hawk vehicle_ai::set_state("death");
			hawk ghost();
			wait(var_9e2fe80f);
			if(isdefined(owner))
			{
				owner clientfield::set_to_player("static_postfx", 0);
			}
		}
		if(isdefined(owner) && isdefined(hawk))
		{
			if(owner isinvehicle())
			{
				if(owner getvehicleoccupied() === hawk)
				{
					hawk usevehicle(owner, 0);
				}
			}
		}
		if(isdefined(owner))
		{
			owner util::function_9a39538a();
		}
		if(!var_5755b643 && isdefined(hawk))
		{
			hawk vehicle_ai::set_state("death");
			hawk ghost();
		}
		if(!var_bb2c398b && !var_5755b643 && isdefined(owner) && isdefined(hawk))
		{
			owner val::set(#"hawk", "freezecontrols", 1);
			forward = anglestoforward(hawk.angles);
			moveamount = vectorscale(forward, 350 * -1);
			trace = physicstrace(hawk.origin, hawk.origin + moveamount, vectorscale((-1, -1, -1), 4), vectorscale((1, 1, 1), 4), undefined, 1);
			cam = spawn("script_model", trace[#"position"]);
			cam setmodel(#"tag_origin");
			cam linkto(hawk);
			hawk setspeedimmediate(0);
			owner camerasetposition(cam.origin);
			owner camerasetlookat(hawk.origin);
			owner cameraactivate(1);
			wait(var_9e2fe80f);
			if(isdefined(owner))
			{
				owner cameraactivate(0);
			}
			cam delete();
			if(isdefined(owner))
			{
				owner val::reset(#"hawk", "freezecontrols");
				owner setclientuivisibilityflag("hud_visible", 1);
			}
		}
	}
	else
	{
		hawk vehicle_ai::set_state("death");
		hawk ghost();
	}
	wait(0.5);
	if(isdefined(hawk))
	{
		hawk delete();
	}
}

