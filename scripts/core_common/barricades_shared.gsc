// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\doors_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\values_shared.gsc;

#namespace barricades;

/*
	Name: function_89f2df9
	Namespace: barricades
	Checksum: 0xCAA1220C
	Offset: 0x140
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
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
	object = new var_65d2fd70();
	[[ object ]]->__constructor();
	var_2a44a7ed = object;
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

#namespace namespace_65d2fd70;

/*
	Name: __constructor
	Namespace: namespace_65d2fd70
	Checksum: 0xFA02D2DC
	Offset: 0x340
	Size: 0x22
	Parameters: 0
	Flags: 8
*/
function __constructor()
{
	cdoor::__constructor();
	self.m_str_type = "barricade";
}

/*
	Name: __destructor
	Namespace: namespace_65d2fd70
	Checksum: 0xB4908501
	Offset: 0x370
	Size: 0x14
	Parameters: 0
	Flags: 16
*/
function __destructor()
{
	cdoor::__destructor();
}

/*
	Name: init
	Namespace: namespace_65d2fd70
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
	self.m_s_bundle.door_start_open = s_instance.door_start_open;
	s_instance.c_door = doors::setup_door_info(self.m_s_bundle, s_instance, self);
	if(isdefined(self.m_s_bundle.door_start_open) && self.m_s_bundle.door_start_open)
	{
		if(isdefined(self.var_a2f96f78.target))
		{
			var_59746f25 = struct::get_array(self.var_a2f96f78.target, "targetname");
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
	if(isdefined(self.m_s_bundle.var_ccc6dafc) && self.m_s_bundle.var_ccc6dafc)
	{
		self.m_e_door setcandamage(1);
		self.m_e_door val::set(#"hash_25bedd86747e41e1", "allowdeath", 0);
		thread function_b4a1f06a();
	}
	thread function_da5abae9();
	thread function_6c15ac46();
}

/*
	Name: function_b4a1f06a
	Namespace: namespace_65d2fd70
	Checksum: 0x3AA6291A
	Offset: 0x5C8
	Size: 0x280
	Parameters: 0
	Flags: None
*/
function function_b4a1f06a()
{
	self.m_e_door endon(#"delete");
	if(!isdefined(self.m_s_bundle.var_89af4052))
	{
		self.m_s_bundle.var_89af4052 = 0;
	}
	while(true)
	{
		self.m_e_door waittill(#"damage");
		if(cdoor::is_open())
		{
			var_1913ccf5--;
			if(var_1913ccf5 < 0)
			{
				var_59746f25 = struct::get_array(self.var_a2f96f78.target, "targetname");
				foreach(s_door in var_59746f25)
				{
					s_door.c_door.var_7d28591d = 0;
				}
				if(isdefined(self.m_s_bundle.var_170e4611) && self.m_s_bundle.var_170e4611)
				{
					if(isdefined(self.m_s_bundle.var_8124c17f))
					{
						self.m_e_door scene::play(self.m_s_bundle.var_8124c17f, self.m_e_door);
					}
					self.m_e_door notify(#"gameobject_deleted");
					self.m_e_door notify(#"hash_430683d292f4ba43");
					waitframe(1);
					self.m_e_door.mdl_gameobject delete();
					self.m_e_door delete();
					break;
				}
				else if(cdoor::is_open())
				{
					cdoor::close();
				}
				var_1913ccf5 = self.m_s_bundle.var_89af4052;
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_da5abae9
	Namespace: namespace_65d2fd70
	Checksum: 0x7B17D673
	Offset: 0x850
	Size: 0x142
	Parameters: 0
	Flags: None
*/
function function_da5abae9()
{
	self.m_e_door endon(#"delete", #"hash_430683d292f4ba43");
	while(true)
	{
		self.m_e_door waittill(#"hash_7166c13e79b73f9");
		if(isdefined(self.var_a2f96f78.target))
		{
			var_59746f25 = struct::get_array(self.var_a2f96f78.target, "targetname");
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
	Name: function_6c15ac46
	Namespace: namespace_65d2fd70
	Checksum: 0x2627EDCD
	Offset: 0x9A0
	Size: 0x12C
	Parameters: 0
	Flags: None
*/
function function_6c15ac46()
{
	self.m_e_door endon(#"delete", #"hash_430683d292f4ba43");
	while(true)
	{
		self.m_e_door endon(#"delete");
		self.m_e_door waittill(#"hash_923096b653062ea");
		if(isdefined(self.var_a2f96f78.target))
		{
			var_59746f25 = struct::get_array(self.var_a2f96f78.target, "targetname");
			foreach(s_door in var_59746f25)
			{
				s_door.c_door.var_7d28591d = 0;
			}
		}
		waitframe(1);
	}
}

#namespace barricades;

/*
	Name: function_65d2fd70
	Namespace: barricades
	Checksum: 0x8784218E
	Offset: 0xAD8
	Size: 0x8F6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_65d2fd70()
{
	classes.var_65d2fd70[0] = spawnstruct();
	classes.var_65d2fd70[0].__vtable[1728894115] = &cdoor::function_670cd4a3;
	classes.var_65d2fd70[0].__vtable[358705462] = &cdoor::function_ea9e96ca;
	classes.var_65d2fd70[0].__vtable[748480339] = &cdoor::function_d36318ad;
	classes.var_65d2fd70[0].__vtable[543846353] = &cdoor::calculate_offset_position;
	classes.var_65d2fd70[0].__vtable[2087472175] = &cdoor::set_door_paths;
	classes.var_65d2fd70[0].__vtable[803610018] = &cdoor::init_player_spawns;
	classes.var_65d2fd70[0].__vtable[1100120524] = &cdoor::init_movement;
	classes.var_65d2fd70[0].__vtable[463104701] = &cdoor::function_e4659543;
	classes.var_65d2fd70[0].__vtable[434551558] = &cdoor::function_e61944fa;
	classes.var_65d2fd70[0].__vtable[97079516] = &cdoor::set_script_flags;
	classes.var_65d2fd70[0].__vtable[479414490] = &cdoor::init_trigger;
	classes.var_65d2fd70[0].__vtable[840719181] = &cdoor::function_cde3a4b3;
	classes.var_65d2fd70[0].__vtable[842744696] = &cdoor::function_323b4378;
	classes.var_65d2fd70[0].__vtable[1415601776] = &cdoor::function_54605e70;
	classes.var_65d2fd70[0].__vtable[563126510] = &cdoor::function_2190a0ee;
	classes.var_65d2fd70[0].__vtable[341210554] = &cdoor::function_145675ba;
	classes.var_65d2fd70[0].__vtable[1340594645] = &cdoor::function_4fe7d9d5;
	classes.var_65d2fd70[0].__vtable[1473325655] = &cdoor::run_lock_fx;
	classes.var_65d2fd70[0].__vtable[377898267] = &cdoor::update_use_message;
	classes.var_65d2fd70[0].__vtable[1806599429] = &cdoor::open_internal;
	classes.var_65d2fd70[0].__vtable[527086575] = &cdoor::function_e0954c11;
	classes.var_65d2fd70[0].__vtable[241000097] = &cdoor::function_f1a2a15f;
	classes.var_65d2fd70[0].__vtable[183760461] = &cdoor::function_f50c09b3;
	classes.var_65d2fd70[0].__vtable[1516492343] = &cdoor::close;
	classes.var_65d2fd70[0].__vtable[876820309] = &cdoor::function_cbbcc8ab;
	classes.var_65d2fd70[0].__vtable[1961799719] = &cdoor::close_internal;
	classes.var_65d2fd70[0].__vtable[2100048836] = &cdoor::function_7d2c33c4;
	classes.var_65d2fd70[0].__vtable[964834927] = &cdoor::remove_door_trigger;
	classes.var_65d2fd70[0].__vtable[632663907] = &cdoor::is_open;
	classes.var_65d2fd70[0].__vtable[1390687784] = &cdoor::set_player_who_opened;
	classes.var_65d2fd70[0].__vtable[250899321] = &cdoor::open;
	classes.var_65d2fd70[0].__vtable[110029005] = &cdoor::delete_door;
	classes.var_65d2fd70[0].__vtable[1899451505] = &cdoor::unlock;
	classes.var_65d2fd70[0].__vtable[1388850526] = &cdoor::lock;
	classes.var_65d2fd70[0].__vtable[2144106720] = &cdoor::init_hint_trigger;
	classes.var_65d2fd70[0].__vtable[1048422439] = &cdoor::get_hack_angles;
	classes.var_65d2fd70[0].__vtable[545032549] = &cdoor::get_hack_pos;
	classes.var_65d2fd70[0].__vtable[1322064569] = &cdoor::init_door_model;
	classes.var_65d2fd70[0].__vtable[1640053651] = &cdoor::function_61c13b93;
	classes.var_65d2fd70[0].__vtable[913321084] = &cdoor::__destructor;
	classes.var_65d2fd70[0].__vtable[674154906] = &cdoor::__constructor;
	classes.var_65d2fd70[0].__vtable[1813359686] = &namespace_65d2fd70::function_6c15ac46;
	classes.var_65d2fd70[0].__vtable[631588119] = &namespace_65d2fd70::function_da5abae9;
	classes.var_65d2fd70[0].__vtable[1264455574] = &namespace_65d2fd70::function_b4a1f06a;
	classes.var_65d2fd70[0].__vtable[1836838051] = &namespace_65d2fd70::init;
	classes.var_65d2fd70[0].__vtable[913321084] = &namespace_65d2fd70::__destructor;
	classes.var_65d2fd70[0].__vtable[674154906] = &namespace_65d2fd70::__constructor;
}

