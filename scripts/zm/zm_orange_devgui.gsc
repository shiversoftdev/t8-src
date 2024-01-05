// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\zm_orange_mq_sendoff.gsc;
#using scripts\zm\zm_orange_challenges.gsc;
#using scripts\zm\zm_orange_ee_dynamite.gsc;
#using scripts\zm\zm_orange_zones.gsc;
#using scripts\zm\zm_orange_mq_hell.gsc;
#using scripts\zm\zm_orange_pap.gsc;
#using scripts\zm\zm_orange_fasttravel_ziplines.gsc;
#using scripts\zm_common\zm_sq.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace zm_orange_devgui;

/*
	Name: init
	Namespace: zm_orange_devgui
	Checksum: 0x60DA2A13
	Offset: 0xD0
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function init()
{
	/#
		level thread devgui();
	#/
}

/*
	Name: jump_to
	Namespace: zm_orange_devgui
	Checksum: 0x58721BFF
	Offset: 0xF8
	Size: 0x6C
	Parameters: 1
	Flags: Private
*/
function private jump_to(str_dest)
{
	/#
		s_dest = struct::get(str_dest);
		self setorigin(s_dest.origin);
		self setplayerangles(s_dest.angles);
	#/
}

/*
	Name: devgui
	Namespace: zm_orange_devgui
	Checksum: 0x591A5E3
	Offset: 0x170
	Size: 0x8A8
	Parameters: 0
	Flags: Private
*/
function private devgui()
{
	/#
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		while(true)
		{
			waitframe(1);
			str_command = getdvarstring(#"zm_orange_debug_cmd", "");
			switch(str_command)
			{
				case "hash_78bca375c84177d4":
				{
					getplayers()[0] jump_to("");
					break;
				}
				case "hash_18769c2b6ae60247":
				{
					level thread zm_orange_fasttravel_ziplines::function_80a9077f();
					break;
				}
				case "hash_24668a82eef6ed20":
				{
					level thread zm_orange_pap::function_79946aff();
					break;
				}
				case "lava_toggle":
				{
					zm_orange_mq_hell::lava_control();
					break;
				}
				case "hash_75c01ef1f8005214":
				{
					iprintln("");
					level flag::set(#"soul_fill");
					break;
				}
				case "hash_7db70cb23b9d2739":
				{
					iprintln("");
					level flag::clear(#"soul_fill");
					break;
				}
				case "hash_58843c67593e2cfe":
				{
					zm_orange_challenges::function_e4b04738();
					break;
				}
				case "test_last_stand":
				{
					zm_devgui::zombie_devgui_open_sesame();
					zm_orange_fasttravel_ziplines::function_80a9077f();
					zm_orange_zones::function_3b77181c(1);
					if(level flag::get(#"hash_6f7fd3d4d070db87") == 0)
					{
						exploder::exploder("");
						level.var_9cc989a5 delete();
						level flag::set(#"hash_6f7fd3d4d070db87");
					}
					zm_orange_mq_hell::function_405f867d();
					break;
				}
				case "hash_1ff4cd3ce63b00f9":
				{
					zm_orange_ee_dynamite::function_61511fcf(0);
					zm_orange_ee_dynamite::function_61511fcf(1);
					zm_orange_ee_dynamite::function_61511fcf(2);
					break;
				}
				case "hash_3c6c8aaf444d0e1a":
				{
					level flag::set(#"hash_98e32feb5b8ac79");
					break;
				}
				case "hash_4f92a974297244f1":
				{
					if(!isdefined(level.var_969fe3f1))
					{
						level.var_969fe3f1 = 0;
					}
					level.var_969fe3f1 = !level.var_969fe3f1;
					break;
				}
				case "hash_78366ec4a1968af6":
				{
					foreach(item in level.var_50e4c504)
					{
						item show();
					}
					break;
				}
				case "play_portal":
				{
					level thread zm_orange_mq_sendoff::function_d096f18f();
					break;
				}
				case "hash_86a620951049404":
				{
					zm_orange_mq_hell::function_fe36418c();
					break;
				}
				case "move_pap_boathouse":
				{
					zm_orange_pap::function_ccc079bc("");
					break;
				}
				case "move_pap_beach":
				{
					zm_orange_pap::function_ccc079bc("");
					break;
				}
				case "move_pap_ship":
				{
					zm_orange_pap::function_ccc079bc("");
					break;
				}
				case "move_pap_lagoon":
				{
					zm_orange_pap::function_ccc079bc("");
					break;
				}
				case "hash_7bfd0d4950600d9a":
				{
					zm_orange_pap::function_ccc079bc("");
					break;
				}
				case "full_unlock":
				{
					zm_devgui::zombie_devgui_open_sesame();
					zm_orange_fasttravel_ziplines::function_80a9077f();
					zm_orange_zones::function_3b77181c(1);
					level thread zm_sq::function_f2dd8601(#"pap_rock", 1);
					break;
				}
				case "hash_2918cc0fd8ab72cd":
				{
					level thread zm_orange_pap::function_eaaea036();
					break;
				}
				case "hash_3da3831f62e16b2c":
				{
					level thread zm_orange_pap::function_96ef31b7();
					break;
				}
				case "test_hell":
				{
					zm_orange_mq_hell::test_hell();
					break;
				}
			}
			setdvar(#"zm_orange_debug_cmd", "");
		}
	#/
}

