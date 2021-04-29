// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_28784009b5b165db;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\microwave_turret_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\turret_shared.gsc;
#using scripts\core_common\vehicle_ai_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;

#namespace namespace_a16f7863;

/*
	Name: function_89f2df9
	Namespace: namespace_a16f7863
	Checksum: 0x88F72A6D
	Offset: 0xE8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_419dc372c53dc4c5", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_a16f7863
	Checksum: 0xB243DC67
	Offset: 0x130
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	vehicle::add_main_callback("microwave_turret", &function_5dfbc20a);
}

/*
	Name: function_5dfbc20a
	Namespace: namespace_a16f7863
	Checksum: 0xEE4ABB74
	Offset: 0x168
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function function_5dfbc20a()
{
	auto_turret::function_f17009ff();
	function_2dae59e4();
	function_4dc5ff34();
}

/*
	Name: function_4dc5ff34
	Namespace: namespace_a16f7863
	Checksum: 0xFE79D3DC
	Offset: 0x1A8
	Size: 0xBC
	Parameters: 0
	Flags: None
*/
function function_4dc5ff34()
{
	guardian = self;
	guardian vehicle_ai::get_state_callbacks("combat").update_func = &function_21304ee6;
	guardian vehicle_ai::get_state_callbacks("combat").exit_func = &function_4ea89e5a;
	guardian vehicle_ai::get_state_callbacks("unaware").enter_func = &function_ab51fb9e;
	guardian vehicle_ai::set_state("unaware");
}

/*
	Name: function_ab51fb9e
	Namespace: namespace_a16f7863
	Checksum: 0xD30B8B4F
	Offset: 0x270
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function function_ab51fb9e(params)
{
	guardian = self;
	guardian clientfield::set("turret_microwave_open", 0);
}

/*
	Name: function_21304ee6
	Namespace: namespace_a16f7863
	Checksum: 0xA3E4F829
	Offset: 0x2B8
	Size: 0x130
	Parameters: 1
	Flags: None
*/
function function_21304ee6(params)
{
	guardian = self;
	guardian endon(#"death", #"change_state");
	if(isdefined(guardian.enemy))
	{
		auto_turret::sentry_turret_alert_sound();
		wait(0.5);
	}
	guardian startmicrowave();
	while(true)
	{
		guardian.turretrotscale = 1;
		if(isdefined(guardian.enemy) && isalive(guardian.enemy) && guardian cansee(guardian.enemy))
		{
			guardian turretsettarget(0, guardian.enemy);
		}
		guardian vehicle_ai::evaluate_connections();
		wait(0.5);
	}
}

/*
	Name: function_4ea89e5a
	Namespace: namespace_a16f7863
	Checksum: 0xB4483AB0
	Offset: 0x3F0
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function function_4ea89e5a(params)
{
	guardian = self;
	guardian stopmicrowave();
}

/*
	Name: startmicrowave
	Namespace: namespace_a16f7863
	Checksum: 0xDDDE4DE8
	Offset: 0x428
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function startmicrowave()
{
	guardian = self;
	guardian clientfield::set("turret_microwave_open", 1);
	guardian microwave_turret::startmicrowave();
}

/*
	Name: stopmicrowave
	Namespace: namespace_a16f7863
	Checksum: 0xFDA38FC9
	Offset: 0x480
	Size: 0x3C
	Parameters: 0
	Flags: None
*/
function stopmicrowave()
{
	guardian = self;
	if(isdefined(guardian))
	{
		guardian clientfield::set("turret_microwave_open", 0);
	}
}

/*
	Name: function_e341abb9
	Namespace: namespace_a16f7863
	Checksum: 0xE34C5E49
	Offset: 0x4C8
	Size: 0xD0
	Parameters: 2
	Flags: None
*/
function function_e341abb9(totalfiretime, enemy)
{
	guardian = self;
	guardian endon(#"death", #"change_state");
	auto_turret::sentry_turret_alert_sound();
	wait(0.1);
	weapon = guardian seatgetweapon(0);
	firetime = weapon.firetime;
	while(time < totalfiretime)
	{
		wait(firetime);
		time = time + firetime;
	}
}

/*
	Name: function_2dae59e4
	Namespace: namespace_a16f7863
	Checksum: 0x9C460B2
	Offset: 0x5A0
	Size: 0x5E
	Parameters: 0
	Flags: None
*/
function function_2dae59e4()
{
	guardian = self;
	guardian.maxsightdistsqrd = 450 * 450;
	guardian turret::set_on_target_angle(15, 0);
	guardian.soundmod = "hpm";
}

