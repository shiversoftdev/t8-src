// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_59ff1d6c;

/*
	Name: function_d776b402
	Namespace: namespace_59ff1d6c
	Checksum: 0x8DBD6478
	Offset: 0x138
	Size: 0x14E
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_d776b402()
{
	clientfield::register("clientuimodel", "zmhud.damage_point_shake", 1, 1, "counter", undefined, 0, 0);
	if(util::function_5df4294() == "zclassic")
	{
		clientfield::register("worlduimodel", "ZMHudGlobal.trials.gameStartTime", 1, 31, "int", undefined, 0, 0);
	}
	callback::on_localplayer_spawned(&function_772f66bd);
	level.var_629da31e = function_e49dbc72();
	if(isdemoplaying())
	{
		return;
	}
	if((isdefined(getgametypesetting(#"hash_54dfa988db5db24c")) ? getgametypesetting(#"hash_54dfa988db5db24c") : 0))
	{
		level.var_7db2b064 = &function_ecc5a0b9;
	}
}

/*
	Name: function_772f66bd
	Namespace: namespace_59ff1d6c
	Checksum: 0xE0D14266
	Offset: 0x290
	Size: 0x27E
	Parameters: 1
	Flags: Linked
*/
function function_772f66bd(localclientnum)
{
	localplayer = function_5c10bd79(localclientnum);
	switch(getgametypesetting(#"hash_29d174e7d8ab76c8"))
	{
		case 3:
		default:
		{
			var_d75008e3 = 0;
			break;
		}
		case 4:
		{
			var_d75008e3 = 1;
			break;
		}
		case 5:
		{
			var_d75008e3 = 2;
			break;
		}
		case 6:
		{
			var_d75008e3 = 3;
			break;
		}
		case 2:
		{
			var_d75008e3 = -1;
			break;
		}
		case 1:
		{
			var_d75008e3 = -2;
			break;
		}
		case 0:
		{
			var_d75008e3 = -3;
			break;
		}
	}
	var_ca9c0ca2 = getscriptbundle("zm_base_difficulty");
	switch(level.gamedifficulty)
	{
		case 0:
		{
			str_suffix = "_E";
			break;
		}
		case 1:
		default:
		{
			str_suffix = "_N";
			break;
		}
		case 2:
		{
			str_suffix = "_H";
			break;
		}
		case 3:
		{
			str_suffix = "_I";
			break;
		}
	}
	n_base = var_ca9c0ca2.("plyBaseHealth" + str_suffix);
	n_target = int(max(n_base + (50 * var_d75008e3), 1));
	localplayer.var_ee9b8af0 = n_target;
}

/*
	Name: function_e49dbc72
	Namespace: namespace_59ff1d6c
	Checksum: 0x3AD4DE21
	Offset: 0x518
	Size: 0xD2
	Parameters: 0
	Flags: Linked
*/
function function_e49dbc72()
{
	var_97a0e767 = (isdefined(getgametypesetting(#"hash_70517c36d49b4ee0")) ? getgametypesetting(#"hash_70517c36d49b4ee0") : 0);
	switch(var_97a0e767)
	{
		case 0:
		{
			return undefined;
		}
		case 1:
		{
			return 20;
		}
		case 3:
		{
			return 60;
		}
	}
	return getdvarfloat(#"player_laststandbleedouttime", 0);
}

/*
	Name: function_ecc5a0b9
	Namespace: namespace_59ff1d6c
	Checksum: 0x6CCEFF6B
	Offset: 0x5F8
	Size: 0x44
	Parameters: 3
	Flags: Linked, Private
*/
function private function_ecc5a0b9(local_client_num, player, damage)
{
	if(int(damage) == 5)
	{
		return true;
	}
	return false;
}

/*
	Name: function_901b751c
	Namespace: namespace_59ff1d6c
	Checksum: 0xDFA6B531
	Offset: 0x648
	Size: 0x70
	Parameters: 1
	Flags: Linked
*/
function function_901b751c(var_c9db62d5)
{
	if(var_c9db62d5 === "")
	{
		return undefined;
	}
	setting = getgametypesetting(var_c9db62d5);
	/#
		assert(isdefined(setting), ("" + var_c9db62d5) + "");
	#/
	return setting;
}

