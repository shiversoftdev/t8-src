// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f9e0dc8454d98e1;
#using script_5660bae5b402a1eb;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_e7b06f1b;

/*
	Name: function_89f2df9
	Namespace: namespace_e7b06f1b
	Checksum: 0xFF163C2B
	Offset: 0xD0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_6119ea2d427fdf8a", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_e7b06f1b
	Checksum: 0x80F724D1
	Offset: 0x118
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
}

/*
	Name: function_f1d9de41
	Namespace: namespace_e7b06f1b
	Checksum: 0xCBE422B1
	Offset: 0x128
	Size: 0x44
	Parameters: 1
	Flags: None
*/
function function_f1d9de41(player)
{
	player zm_utility::function_7a35b1d7(self.hint);
	level thread function_386c20ef(player);
}

/*
	Name: function_386c20ef
	Namespace: namespace_e7b06f1b
	Checksum: 0xA9E5F9C9
	Offset: 0x178
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_386c20ef(player)
{
	if(isdefined(player.lives) && player.lives < 5)
	{
		player.lives++;
	}
	else if(player zm_laststand::function_618fd37e() < 5)
	{
		player zm_laststand::function_3a00302e();
	}
}

