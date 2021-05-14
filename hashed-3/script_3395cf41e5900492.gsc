// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2c6ff91addfd14b7;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\vehicle_ai_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;

#namespace rcxd;

/*
	Name: function_89f2df9
	Namespace: rcxd
	Checksum: 0x15FF27CE
	Offset: 0xC8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"rcxd", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: rcxd
	Checksum: 0x4901AC79
	Offset: 0x110
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	vehicle::add_main_callback("rcxd", &function_91ea9492);
}

/*
	Name: function_91ea9492
	Namespace: rcxd
	Checksum: 0x1F7D2C60
	Offset: 0x148
	Size: 0x8C
	Parameters: 0
	Flags: None
*/
function function_91ea9492()
{
	namespace_c2dce87e::function_c6f75619();
	self.detonate_sides_disabled = 1;
	self useanimtree("generic");
	self initsounds();
	if(isdefined(level.vehicle_initializer_cb))
	{
		[[level.vehicle_initializer_cb]](self);
	}
	defaultrole();
}

/*
	Name: defaultrole
	Namespace: rcxd
	Checksum: 0xFD7A2EA6
	Offset: 0x1E0
	Size: 0x10C
	Parameters: 0
	Flags: None
*/
function defaultrole()
{
	self vehicle_ai::init_state_machine_for_role("default");
	self vehicle_ai::get_state_callbacks("combat").update_func = &namespace_c2dce87e::state_combat_update;
	self vehicle_ai::get_state_callbacks("driving").update_func = &namespace_c2dce87e::state_scripted_update;
	self vehicle_ai::get_state_callbacks("death").update_func = &namespace_c2dce87e::state_death_update;
	self vehicle_ai::get_state_callbacks("emped").update_func = &namespace_c2dce87e::state_emped_update;
	self vehicle_ai::call_custom_add_state_callbacks();
	vehicle_ai::startinitialstate("combat");
}

/*
	Name: initsounds
	Namespace: rcxd
	Checksum: 0x79CD6361
	Offset: 0x2F8
	Size: 0x19E
	Parameters: 0
	Flags: None
*/
function initsounds()
{
	self.sndalias = [];
	self.sndalias[#"inair"] = #"hash_65ec2e5d43b62423";
	self.sndalias[#"land"] = #"hash_26fddc98c4b5aa5a";
	self.sndalias[#"spawn"] = #"hash_1b30b26c406054e2";
	self.sndalias[#"direction"] = #"hash_69f9a2b48dccef90";
	self.sndalias[#"jump_up"] = #"hash_43b08a05140c0ea9";
	self.sndalias[#"hash_6dacc5a8faf1b6f3"] = #"hash_7a70a6fa72ea121";
	self.sndalias[#"hash_22b0b71c07ac7fea"] = #"hash_548fbad0d3c63e20";
	self.sndalias[#"hash_26569720e0ae76f3"] = #"hash_29426008ddf3da16";
	self.sndalias[#"hash_2b3a22d457fba169"] = #"hash_4966894e7ae3a222";
	self.sndalias[#"hash_56dd8cae01fc143c"] = #"veh_wasp_wall_imp";
}

