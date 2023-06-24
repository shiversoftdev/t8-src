// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\abilities\ability_player.gsc;
#using scripts\core_common\globallogic\globallogic_score.gsc;
#using scripts\weapons\weaponobjects.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace grapple;

/*
	Name: __init__system__
	Namespace: grapple
	Checksum: 0xE5EC29BB
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"grapple", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: grapple
	Checksum: 0x28F19C0D
	Offset: 0xE0
	Size: 0xC4
	Parameters: 0
	Flags: None
*/
function __init__()
{
	callback::on_spawned(&function_8fa5ff65);
	ability_player::register_gadget_activation_callbacks(20, undefined, &gadget_grapple_off);
	globallogic_score::function_5a241bd8(getweapon(#"eq_grapple"), &function_d79e9bb5);
	weaponobjects::function_e6400478(#"eq_grapple", &function_422f24cc, 1);
}

/*
	Name: function_422f24cc
	Namespace: grapple
	Checksum: 0x7B8DDD90
	Offset: 0x1B0
	Size: 0x26
	Parameters: 1
	Flags: None
*/
function function_422f24cc(watcher)
{
	watcher.ondamage = &function_1987d583;
}

/*
	Name: function_d79e9bb5
	Namespace: grapple
	Checksum: 0xF7482952
	Offset: 0x1E0
	Size: 0x98
	Parameters: 5
	Flags: None
*/
function function_d79e9bb5(attacker, victim, weapon, attackerweapon, meansofdeath)
{
	if(!isdefined(attacker) || (isdefined(attackerweapon) && attackerweapon == weapon))
	{
		return 0;
	}
	return attacker isgrappling() || (isdefined(attacker.var_700a5910) && (attacker.var_700a5910 + 2000) > gettime());
}

/*
	Name: gadget_grapple_off
	Namespace: grapple
	Checksum: 0x4A404361
	Offset: 0x280
	Size: 0x58
	Parameters: 2
	Flags: None
*/
function gadget_grapple_off(slot, weapon)
{
	if(!function_d79e9bb5(self) && isdefined(level.var_228e8cd6))
	{
		self [[level.var_228e8cd6]](weapon);
	}
}

/*
	Name: function_8fa5ff65
	Namespace: grapple
	Checksum: 0x9D77125A
	Offset: 0x2E0
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function function_8fa5ff65()
{
	self thread function_9dd08ccf();
}

/*
	Name: function_9dd08ccf
	Namespace: grapple
	Checksum: 0x3139995E
	Offset: 0x308
	Size: 0x82
	Parameters: 0
	Flags: None
*/
function function_9dd08ccf()
{
	self endon(#"death", #"disconnect", #"joined_team", #"joined_spectators", #"changed_specialist");
	while(isdefined(self))
	{
		self waittill(#"grapple_cancel");
		self.var_700a5910 = gettime();
	}
}

/*
	Name: function_1987d583
	Namespace: grapple
	Checksum: 0x154F4F66
	Offset: 0x398
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function function_1987d583(watcher)
{
	self setcandamage(0);
}

