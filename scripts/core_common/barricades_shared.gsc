// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\doors_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\values_shared.gsc;

class cbarricade : cdoor
{
	var m_e_door;
	var var_a2f96f78;
	var m_s_bundle;

	/*
		Name: constructor
		Namespace: cbarricade
		Checksum: 0xFA02D2DC
		Offset: 0x340
		Size: 0x22
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
		self.m_str_type = "barricade";
	}

	/*
		Name: destructor
		Namespace: cbarricade
		Checksum: 0xB4908501
		Offset: 0x370
		Size: 0x14
		Parameters: 0
		Flags: 16
	*/
	destructor()
	{
	}

	/*
		Name: function_6c15ac46
		Namespace: cbarricade
		Checksum: 0x2627EDCD
		Offset: 0x9A0
		Size: 0x12C
		Parameters: 0
		Flags: None
	*/
	function function_6c15ac46()
	{
		m_e_door endon(#"delete", #"barricade_removed");
		while(true)
		{
			m_e_door endon(#"delete");
			m_e_door waittill(#"hash_923096b653062ea");
			if(isdefined(var_a2f96f78.target))
			{
				var_59746f25 = struct::get_array(var_a2f96f78.target, "targetname");
				foreach(s_door in var_59746f25)
				{
					s_door.c_door.var_7d28591d = 0;
				}
			}
			waitframe(1);
		}
	}

	/*
		Name: function_da5abae9
		Namespace: cbarricade
		Checksum: 0x7B17D673
		Offset: 0x850
		Size: 0x142
		Parameters: 0
		Flags: None
	*/
	function function_da5abae9()
	{
		m_e_door endon(#"delete", #"barricade_removed");
		while(true)
		{
			m_e_door waittill(#"hash_7166c13e79b73f9");
			if(isdefined(var_a2f96f78.target))
			{
				var_59746f25 = struct::get_array(var_a2f96f78.target, "targetname");
				foreach(s_door in var_59746f25)
				{
					s_door.c_door.var_7d28591d = 1;
					if([[ s_door.c_door ]]->is_open())
					{
						[[ s_door.c_door ]]->close();
					}
				}
			}
			waitframe(1);
		}
	}

	/*
		Name: function_b4a1f06a
		Namespace: cbarricade
		Checksum: 0x3AA6291A
		Offset: 0x5C8
		Size: 0x280
		Parameters: 0
		Flags: None
	*/
	function function_b4a1f06a()
	{
		m_e_door endon(#"delete");
		if(!isdefined(m_s_bundle.var_89af4052))
		{
			m_s_bundle.var_89af4052 = 0;
		}
		var_1913ccf5 = m_s_bundle.var_89af4052;
		while(true)
		{
			m_e_door waittill(#"damage");
			if(cdoor::is_open())
			{
				var_1913ccf5--;
				if(var_1913ccf5 < 0)
				{
					var_59746f25 = struct::get_array(var_a2f96f78.target, "targetname");
					foreach(s_door in var_59746f25)
					{
						s_door.c_door.var_7d28591d = 0;
					}
					if(isdefined(m_s_bundle.var_170e4611) && m_s_bundle.var_170e4611)
					{
						if(isdefined(m_s_bundle.var_8124c17f))
						{
							m_e_door scene::play(m_s_bundle.var_8124c17f, m_e_door);
						}
						m_e_door notify(#"gameobject_deleted");
						m_e_door notify(#"barricade_removed");
						waitframe(1);
						m_e_door.mdl_gameobject delete();
						m_e_door delete();
						break;
					}
					else
					{
						if(cdoor::is_open())
						{
							cdoor::close();
						}
						var_1913ccf5 = m_s_bundle.var_89af4052;
					}
				}
			}
			waitframe(1);
		}
	}

	/*
		Name: init
		Namespace: cbarricade
		Checksum: 0xC537AE8
		Offset: 0x390
		Size: 0x22C
		Parameters: 2
		Flags: None
	*/
	function init(var_4a686ff8, s_instance)
	{
		self.m_s_bundle = var_4a686ff8;
		self.var_a2f96f78 = s_instance;
		m_s_bundle.door_start_open = s_instance.door_start_open;
		s_instance.c_door = doors::setup_door_info(m_s_bundle, s_instance, self);
		if(isdefined(m_s_bundle.door_start_open) && m_s_bundle.door_start_open)
		{
			if(isdefined(var_a2f96f78.target))
			{
				var_59746f25 = struct::get_array(var_a2f96f78.target, "targetname");
				foreach(s_door in var_59746f25)
				{
					s_door.c_door.var_7d28591d = 1;
					if([[ s_door.c_door ]]->is_open())
					{
						[[ s_door.c_door ]]->close();
					}
				}
			}
		}
		if(isdefined(m_s_bundle.var_ccc6dafc) && m_s_bundle.var_ccc6dafc)
		{
			m_e_door setcandamage(1);
			m_e_door val::set(#"hash_25bedd86747e41e1", "allowdeath", 0);
			thread function_b4a1f06a();
		}
		thread function_da5abae9();
		thread function_6c15ac46();
	}

}

#namespace barricades;

/*
	Name: __init__system__
	Namespace: barricades
	Checksum: 0xCAA1220C
	Offset: 0x140
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"barricades", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: barricades
	Checksum: 0x6AA1D8AC
	Offset: 0x190
	Size: 0xEA
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!isdefined(level.var_9c740bff))
	{
		level.var_9c740bff = [];
	}
	level.var_9c740bff = struct::get_array("scriptbundle_barricades", "classname");
	foreach(s_instance in level.var_9c740bff)
	{
		c_door = s_instance function_14354831();
		if(isdefined(c_door))
		{
			s_instance.c_door = c_door;
		}
	}
}

/*
	Name: function_14354831
	Namespace: barricades
	Checksum: 0xBBFA4239
	Offset: 0x288
	Size: 0x7A
	Parameters: 0
	Flags: None
*/
function function_14354831()
{
	if(isdefined(self.scriptbundlename))
	{
		var_9fecaae1 = struct::get_script_bundle("barricades", self.scriptbundlename);
	}
	var_2a44a7ed = new cbarricade();
	var_2a44a7ed = [[ var_2a44a7ed ]]->init(var_9fecaae1, self);
	return var_2a44a7ed;
}

/*
	Name: __main__
	Namespace: barricades
	Checksum: 0xCAA88F66
	Offset: 0x310
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function __main__()
{
	level flagsys::wait_till("radiant_gameobjects_initialized");
}

