// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2dc48f46bfeac894;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_c6623988;

/*
	Name: function_89f2df9
	Namespace: namespace_c6623988
	Checksum: 0x45041D36
	Offset: 0xA8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_792d260b7a3d5986", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_c6623988
	Checksum: 0x5EF3E880
	Offset: 0xF0
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_2e115fb9 = getweapon(#"hash_514f1c2ee7ec8acf");
	level.var_b9d2a7a9 = getweapon(#"hash_17f9f60ce4ea5074");
	level.var_f1ab9c51 = getweapon(#"hash_24840aebcc206215");
	level.var_69aaf8f = getdvarfloat(#"hash_27445ccf68d30520", 5);
	ability_player::register_gadget_activation_callbacks(11, &function_e31bc59d, &function_7fbddc72);
}

/*
	Name: function_e31bc59d
	Namespace: namespace_c6623988
	Checksum: 0x971C913F
	Offset: 0x1D8
	Size: 0xF4
	Parameters: 2
	Flags: Linked
*/
function function_e31bc59d(var_3245778e, weapon)
{
	if(weapon != getweapon(#"sig_buckler_dw"))
	{
		return;
	}
	self.var_4233f7e5 = 1;
	self.var_70465a20 = gettime();
	if(!(isdefined(level.var_c4002ed1) && level.var_c4002ed1))
	{
		if(isdefined(self))
		{
			self clientfield::set_player_uimodel("hudItems.abilityHintIndex", 1);
		}
	}
	self waittill(#"death", #"weapon_change");
	if(isdefined(self))
	{
		self clientfield::set_player_uimodel("hudItems.abilityHintIndex", 0);
	}
}

/*
	Name: function_7fbddc72
	Namespace: namespace_c6623988
	Checksum: 0xEFC7823B
	Offset: 0x2D8
	Size: 0x1E
	Parameters: 2
	Flags: Linked
*/
function function_7fbddc72(var_3245778e, weapon)
{
	self.var_4233f7e5 = 0;
}

