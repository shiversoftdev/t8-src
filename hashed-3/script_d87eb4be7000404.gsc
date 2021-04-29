// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_24c32478acf44108;
#using script_3aa0f32b70d4f7cb;
#using script_3f9e0dc8454d98e1;
#using script_4d85e8de54b02198;
#using script_522aeb6ae906391e;
#using script_57f7003580bb15e0;
#using script_59f07c660e6710a5;
#using script_7e59d7bba853fe4b;
#using script_bd2b8aaa388dcce;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_behavior.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_net.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_af28b608;

/*
	Name: function_89f2df9
	Namespace: namespace_af28b608
	Checksum: 0x10D9A3A3
	Offset: 0x180
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_2281c92f7b8c6d9d", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_af28b608
	Checksum: 0xA257AB46
	Offset: 0x1D0
	Size: 0x264
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_score::function_e5d6e6dd(#"hash_777dead372b3a736", 1);
	/#
		assert(isscriptfunctionptr(&function_f5d43a20));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2a1fbaa1c4a45a3f", &function_f5d43a20);
	/#
		assert(isscriptfunctionptr(&function_ad034041));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_64a769b6a696ad3e", &function_ad034041, 1);
	spawner::add_archetype_spawn_function(#"hash_777dead372b3a736", &function_d8a99ae2);
	/#
		zm_devgui::function_c7dd7a17("");
		adddebugcommand("");
		adddebugcommand("");
	#/
	level thread aat::register_immunity("zm_aat_brain_decay", #"hash_777dead372b3a736", 1, 1, 1);
	level thread aat::register_immunity("zm_aat_frostbite", #"hash_777dead372b3a736", 1, 1, 1);
	level thread aat::register_immunity("zm_aat_kill_o_watt", #"hash_777dead372b3a736", 1, 1, 1);
	level thread aat::register_immunity("zm_aat_plasmatic_burst", #"hash_777dead372b3a736", 1, 1, 1);
}

/*
	Name: __main__
	Namespace: namespace_af28b608
	Checksum: 0x80F724D1
	Offset: 0x440
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: function_d8a99ae2
	Namespace: namespace_af28b608
	Checksum: 0x818FB390
	Offset: 0x450
	Size: 0x6C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_d8a99ae2()
{
	blackboard::createblackboardforentity(self);
	ai::createinterfaceforentity(self);
	self zombie_utility::set_zombie_run_cycle("super_sprint");
	self thread function_487069e4();
}

/*
	Name: function_487069e4
	Namespace: namespace_af28b608
	Checksum: 0x643D13D8
	Offset: 0x4C8
	Size: 0x34
	Parameters: 0
	Flags: Linked, Private
*/
private function function_487069e4()
{
	self endon(#"death");
	wait(1);
	self disableaimassist();
}

/*
	Name: function_b6824ff0
	Namespace: namespace_af28b608
	Checksum: 0xA452967C
	Offset: 0x508
	Size: 0xAC
	Parameters: 4
	Flags: Linked, Private
*/
private function function_b6824ff0(entity, player, duration, color)
{
	/#
		enabled = getdvarint(#"hash_46b9af6724aa7968", 0);
		if(enabled)
		{
			endpoint = function_78910888(player);
			entity thread function_e5ffb77c(entity.origin, endpoint, 0.05, color);
		}
	#/
}

/*
	Name: function_e5ffb77c
	Namespace: namespace_af28b608
	Checksum: 0xFD169610
	Offset: 0x5C0
	Size: 0x116
	Parameters: 4
	Flags: Private
*/
private function function_e5ffb77c(start, end, duration, color)
{
	/#
		while(current_time > 0)
		{
			waitframe(1);
			line(start, end, color, 1, 1);
			sphere(end, 10, color, 1, 0, 8, 1);
			distance = distance(start, end);
			print3d(end + vectorscale((0, 0, 1), 10), "" + distance, color, 1, 1, 1);
			current_time = current_time - 1;
		}
	#/
}

/*
	Name: function_78910888
	Namespace: namespace_af28b608
	Checksum: 0xCACFA9EE
	Offset: 0x6E0
	Size: 0x86
	Parameters: 1
	Flags: Private
*/
private function function_78910888(player)
{
	angles = player getplayerangles();
	forward = anglestoforward(angles);
	result = player.origin + vectorscale((0, 0, 1), 30) + forward * 100;
	return result;
}

/*
	Name: function_ad034041
	Namespace: namespace_af28b608
	Checksum: 0xE6CB9189
	Offset: 0x770
	Size: 0x1EC
	Parameters: 1
	Flags: Linked, Private
*/
private function function_ad034041(entity)
{
	players = getplayers();
	var_de85d14d = [];
	foreach(player in players)
	{
		if(player cansee(entity))
		{
			function_b6824ff0(entity, player, 0.1, (1, 0, 0));
			var_de85d14d[var_de85d14d.size] = player;
			continue;
		}
		function_b6824ff0(entity, player, 0.1, (0, 1, 0));
	}
	if(var_de85d14d.size > 0)
	{
		if(!(isdefined(entity.is_inert) && entity.is_inert))
		{
			entity namespace_9ff9f642::freeze();
		}
		entity setgoal(entity.origin);
	}
	else if(isdefined(entity.is_inert) && entity.is_inert)
	{
		entity namespace_9ff9f642::unfreeze();
	}
	if(isdefined(entity.var_72411ccf))
	{
		entity [[entity.var_72411ccf]](entity);
	}
	else
	{
		entity zm_behavior::zombiefindflesh(entity);
	}
}

/*
	Name: function_f5d43a20
	Namespace: namespace_af28b608
	Checksum: 0x423206AD
	Offset: 0x968
	Size: 0x7C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_f5d43a20(entity)
{
	result = zombiebehavior::zombieshouldmeleecondition(entity);
	if(result && isdefined(entity.enemy) && entity.enemy cansee(entity))
	{
		result = 1;
	}
	return result;
}

