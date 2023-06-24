// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\ai\zm_ai_brutus.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_devgui.gsc;

#namespace namespace_9d28c60;

/*
	Name: __init__system__
	Namespace: namespace_9d28c60
	Checksum: 0x54FFF659
	Offset: 0xC0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_2e2fcde8843638d9", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_9d28c60
	Checksum: 0xBCF8D0F2
	Offset: 0x108
	Size: 0x4C
	Parameters: 0
	Flags: Linked, Private
*/
function private __init__()
{
	spawner::add_archetype_spawn_function(#"brutus", &function_e67297f2);
	/#
		function_f2cc1ec();
	#/
}

/*
	Name: function_e67297f2
	Namespace: namespace_9d28c60
	Checksum: 0x27D4CACD
	Offset: 0x160
	Size: 0x44
	Parameters: 0
	Flags: Linked, Private
*/
function private function_e67297f2()
{
	if(self.var_9fde8624 !== #"brutus_special")
	{
		return;
	}
	self attach("c_t8_zmb_mob_brutus_boss_baton", "tag_weapon_right");
}

/*
	Name: function_f2cc1ec
	Namespace: namespace_9d28c60
	Checksum: 0xA1FE1B08
	Offset: 0x1B0
	Size: 0x5C
	Parameters: 0
	Flags: Private
*/
function private function_f2cc1ec()
{
	/#
		adddebugcommand("");
		adddebugcommand("");
		zm_devgui::add_custom_devgui_callback(&function_5162a3de);
	#/
}

/*
	Name: function_5162a3de
	Namespace: namespace_9d28c60
	Checksum: 0xA077627E
	Offset: 0x218
	Size: 0x1FA
	Parameters: 1
	Flags: Private
*/
function private function_5162a3de(cmd)
{
	/#
		switch(cmd)
		{
			case "hash_3b5a33d5b7ae4e80":
			{
				spawners = getspawnerarray();
				foreach(spawner in spawners)
				{
					if(spawner.var_9fde8624 === #"brutus_special" && isdefined(spawner.script_noteworthy))
					{
						zm_devgui::spawn_archetype(spawner.script_noteworthy);
						break;
					}
				}
				break;
			}
			case "hash_2e229b658a79d09f":
			{
				brutuses = getaiarchetypearray(#"brutus");
				foreach(brutus in brutuses)
				{
					if(brutus.var_9fde8624 === #"brutus_special")
					{
						brutus kill(undefined, undefined, undefined, undefined, 0, 1);
					}
				}
				break;
			}
			default:
			{
				break;
			}
		}
	#/
}

