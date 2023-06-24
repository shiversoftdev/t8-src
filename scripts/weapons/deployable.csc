// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace deployable;

/*
	Name: __init__system__
	Namespace: deployable
	Checksum: 0xC198F288
	Offset: 0xF8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"deployable", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: deployable
	Checksum: 0x6DB752E4
	Offset: 0x140
	Size: 0x72
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!isdefined(level._deployable_weapons))
	{
		level._deployable_weapons = [];
	}
	level.var_c442de72 = &function_c1ee2dce;
	level thread group_mega_round_end_abcd_talking();
	if(!isdefined(level.var_1765ad79))
	{
		level.var_1765ad79 = 1;
	}
}

/*
	Name: register_deployable
	Namespace: deployable
	Checksum: 0x67CA2A1
	Offset: 0x1C0
	Size: 0xAA
	Parameters: 2
	Flags: None
*/
function register_deployable(weapon, var_7ec218c6)
{
	if(weapon.name == "#none")
	{
		return;
	}
	/#
		assert(weapon.name != "");
	#/
	level._deployable_weapons[weapon.statindex] = spawnstruct();
	level._deployable_weapons[weapon.statindex].var_7ec218c6 = var_7ec218c6;
}

/*
	Name: function_3e8d9b27
	Namespace: deployable
	Checksum: 0x74997C25
	Offset: 0x278
	Size: 0x8C
	Parameters: 1
	Flags: None
*/
function function_3e8d9b27(previs_weapon)
{
	previs_model = self;
	if(isdefined(previs_weapon.var_4bcd08b0))
	{
		previs_model setmodel(previs_weapon.var_4bcd08b0);
	}
	else
	{
		previs_model setmodel(#"hash_7a80bed4a96537e6");
	}
	previs_model notsolid();
}

/*
	Name: function_c1ee2dce
	Namespace: deployable
	Checksum: 0x34C9368D
	Offset: 0x310
	Size: 0x7C
	Parameters: 3
	Flags: Linked
*/
function function_c1ee2dce(player, localclientnum, weapon)
{
	var_314a434f = function_35d1c69f(localclientnum, player, weapon);
	player function_bf191832(var_314a434f.isvalid, var_314a434f.origin, var_314a434f.angles);
}

/*
	Name: function_35d1c69f
	Namespace: deployable
	Checksum: 0xA4A2B0F9
	Offset: 0x398
	Size: 0x1BE
	Parameters: 3
	Flags: Linked
*/
function function_35d1c69f(localclientnum, player, weapon)
{
	if(!weapon.var_dbbd4cec)
	{
		var_10c45189 = player function_242060b9(weapon);
		var_7ed1816f = var_10c45189.isvalid || ((isdefined(level._deployable_weapons[level._deployable_weapons[weapon.statindex].statindex].var_7ec218c6) ? level._deployable_weapons[weapon.statindex].var_7ec218c6 : 0));
	}
	else
	{
		var_7ed1816f = 1;
		var_10c45189 = {#angles:player.angles, #origin:player.origin, #isvalid:1};
	}
	var_c3743e82 = !level.var_1765ad79 || function_e0d90bc8(localclientnum) || (isdefined(weapon.var_33d50507) && weapon.var_33d50507);
	gameplay_allows_deploy = player clientfield::get_to_player("gameplay_allows_deploy");
	var_10c45189.isvalid = var_7ed1816f && gameplay_allows_deploy && var_c3743e82;
	return var_10c45189;
}

/*
	Name: group_mega_round_end_abcd_talking
	Namespace: deployable
	Checksum: 0x976F6A51
	Offset: 0x560
	Size: 0x2E0
	Parameters: 1
	Flags: Linked
*/
function group_mega_round_end_abcd_talking(localclientnum = 0)
{
	level notify("previs_deployable_" + localclientnum);
	level endon("previs_deployable_" + localclientnum);
	wait(10);
	previs_model = spawn(localclientnum, (0, 0, 0), "script_model");
	previs_weapon = getweapon(#"eq_alarm");
	var_5929417d = 0;
	var_2e40ce22 = 0;
	var_d4d81eb4 = 0;
	while(true)
	{
		var_fdadca2a = previs_weapon;
		if(!var_5929417d)
		{
			if(var_2e40ce22 == 1)
			{
				previs_model stoprenderoverridebundle("rob_deployable_can_deploy");
			}
			if(var_d4d81eb4 == 1)
			{
				previs_model stoprenderoverridebundle("rob_deployable_cannot_deploy");
			}
			var_2e40ce22 = 0;
			var_d4d81eb4 = 0;
			if(isdefined(previs_model))
			{
				previs_model hide();
			}
			wait(0.2);
		}
		else
		{
			waitframe(1);
		}
		var_5929417d = 0;
		if(getdvarint(#"hash_4df6a4cc1cfae912", 1) == 0)
		{
			continue;
		}
		player = function_5c10bd79(localclientnum);
		if(!isdefined(player))
		{
			continue;
		}
		if(!isalive(player))
		{
			continue;
		}
		previs_weapon = undefined;
		if(function_96d4f30e(localclientnum))
		{
			previs_weapon = function_e9fe14ee(localclientnum);
		}
		else
		{
			previs_weapon = player.weapon;
		}
		if(!previs_weapon.deployable || previs_weapon.var_e0d42861)
		{
			continue;
		}
		if(function_c7b681af(localclientnum))
		{
			var_5929417d = 1;
			continue;
		}
		var_314a434f = function_35d1c69f(localclientnum, player, previs_weapon);
		player function_bf191832(var_314a434f.isvalid, var_314a434f.origin, var_314a434f.angles);
	}
}

