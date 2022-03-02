// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_melee_weapon.gsc;

#namespace namespace_bf08ec2;

/*
	Name: function_89f2df9
	Namespace: namespace_bf08ec2
	Checksum: 0x6CCD1399
	Offset: 0xA0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"galvaknuckles", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_bf08ec2
	Checksum: 0x60CD2C99
	Offset: 0xF0
	Size: 0x6C
	Parameters: 0
	Flags: Linked, Private
*/
function private __init__()
{
	zm_loadout::register_melee_weapon_for_level(#"galvaknuckles_t8");
	level.var_b77d3496 = getweapon(#"galvaknuckles_t8");
	callback::on_ai_killed(&on_ai_killed);
}

/*
	Name: __main__
	Namespace: namespace_bf08ec2
	Checksum: 0x1392D2A5
	Offset: 0x168
	Size: 0x54
	Parameters: 0
	Flags: Linked, Private
*/
function private __main__()
{
	zm_melee_weapon::init(#"galvaknuckles_t8", #"hash_c994e1032879502", 5000, "tazer_upgrade", #"hash_60606b68e93a29c8", "galva", undefined);
}

/*
	Name: on_ai_killed
	Namespace: namespace_bf08ec2
	Checksum: 0xF4CE94C6
	Offset: 0x1C8
	Size: 0x104
	Parameters: 1
	Flags: Linked
*/
function on_ai_killed(s_params)
{
	wait(0.15);
	if(s_params.weapon === level.var_b77d3496 && isdefined(self) && isactor(self) && isdefined(s_params.eattacker))
	{
		var_5b84ed9a = s_params.eattacker getcentroid();
		var_2640e082 = 15 * (vectornormalize(self getcentroid() - var_5b84ed9a)) + vectorscale((0, 0, 1), 0.1);
		self startragdoll();
		self launchragdoll(var_2640e082);
	}
}

