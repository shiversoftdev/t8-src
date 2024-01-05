// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\zm_zodt8_sound.csc;
#using scripts\zm\zm_zodt8_gamemodes.csc;
#using scripts\zm_common\zm_characters.csc;
#using scripts\zm_common\zm_weapons.csc;
#using scripts\zm_common\zm_utility.csc;
#using scripts\zm_common\zm_pack_a_punch.csc;
#using scripts\zm_common\zm_fasttravel.csc;
#using scripts\zm_common\zm_audio_sq.csc;
#using scripts\zm_common\zm.csc;
#using scripts\zm_common\load.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\audio_shared.csc;

#namespace namespace_57873b62;

/*
	Name: init
	Namespace: namespace_57873b62
	Checksum: 0x40155FE7
	Offset: 0x128
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	init_clientfields();
	level thread init_decals();
}

/*
	Name: init_decals
	Namespace: namespace_57873b62
	Checksum: 0x88035008
	Offset: 0x160
	Size: 0xB0
	Parameters: 0
	Flags: Linked
*/
function init_decals()
{
	wait(0.1);
	if(!zm_utility::is_ee_enabled())
	{
		var_c85b91c4 = findvolumedecalindexarray("freerangeanimalcrackers");
		foreach(n_index in var_c85b91c4)
		{
			hidevolumedecal(n_index);
		}
	}
}

/*
	Name: init_clientfields
	Namespace: namespace_57873b62
	Checksum: 0x5AF1D5BA
	Offset: 0x218
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("scriptmover", "" + #"morse_star", 1, 1, "int", &function_3653f153, 0, 0);
}

/*
	Name: function_3653f153
	Namespace: namespace_57873b62
	Checksum: 0xFC4F40D9
	Offset: 0x280
	Size: 0xCD8
	Parameters: 7
	Flags: Linked
*/
function function_3653f153(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self util::waittill_dobj(localclientnum);
		while(true)
		{
			wait(10);
			function_d11e8e8d(localclientnum);
			function_5200214e(localclientnum);
			function_5200214e(localclientnum);
			function_bbf9723b();
			function_d11e8e8d(localclientnum);
			function_d11e8e8d(localclientnum);
			function_d11e8e8d(localclientnum);
			function_d11e8e8d(localclientnum);
			function_bbf9723b();
			function_5200214e(localclientnum);
			function_d11e8e8d(localclientnum);
			function_5200214e(localclientnum);
			function_5200214e(localclientnum);
			function_ca7f5c75();
			function_5200214e(localclientnum);
			function_d11e8e8d(localclientnum);
			function_d11e8e8d(localclientnum);
			function_bbf9723b();
			function_5200214e(localclientnum);
			function_5200214e(localclientnum);
			function_5200214e(localclientnum);
			function_ca7f5c75();
			function_5200214e(localclientnum);
			function_d11e8e8d(localclientnum);
			function_5200214e(localclientnum);
			function_5200214e(localclientnum);
			function_bbf9723b();
			function_5200214e(localclientnum);
			function_5200214e(localclientnum);
			function_5200214e(localclientnum);
			function_bbf9723b();
			function_d11e8e8d(localclientnum);
			function_d11e8e8d(localclientnum);
			function_5200214e(localclientnum);
			function_ca7f5c75();
			function_d11e8e8d(localclientnum);
			function_5200214e(localclientnum);
			function_5200214e(localclientnum);
			function_bbf9723b();
			function_d11e8e8d(localclientnum);
			function_d11e8e8d(localclientnum);
			function_bbf9723b();
			function_d11e8e8d(localclientnum);
			function_d11e8e8d(localclientnum);
			function_d11e8e8d(localclientnum);
			function_bbf9723b();
			function_d11e8e8d(localclientnum);
			function_d11e8e8d(localclientnum);
			function_d11e8e8d(localclientnum);
			function_d11e8e8d(localclientnum);
			function_ca7f5c75();
			function_5200214e(localclientnum);
			function_bbf9723b();
			function_5200214e(localclientnum);
			function_5200214e(localclientnum);
			function_5200214e(localclientnum);
			function_ca7f5c75();
			function_d11e8e8d(localclientnum);
			function_d11e8e8d(localclientnum);
			function_d11e8e8d(localclientnum);
			function_bbf9723b();
			function_d11e8e8d(localclientnum);
			function_5200214e(localclientnum);
			function_bbf9723b();
			function_d11e8e8d(localclientnum);
			function_d11e8e8d(localclientnum);
			function_d11e8e8d(localclientnum);
			function_5200214e(localclientnum);
			function_bbf9723b();
			function_d11e8e8d(localclientnum);
			function_ca7f5c75();
			function_5200214e(localclientnum);
			function_bbf9723b();
			function_d11e8e8d(localclientnum);
			function_d11e8e8d(localclientnum);
			function_d11e8e8d(localclientnum);
			function_d11e8e8d(localclientnum);
			function_bbf9723b();
			function_d11e8e8d(localclientnum);
			function_ca7f5c75();
			function_5200214e(localclientnum);
			function_5200214e(localclientnum);
			function_5200214e(localclientnum);
			function_bbf9723b();
			function_5200214e(localclientnum);
			function_d11e8e8d(localclientnum);
			function_bbf9723b();
			function_d11e8e8d(localclientnum);
			function_ca7f5c75();
			function_d11e8e8d(localclientnum);
			function_5200214e(localclientnum);
			function_5200214e(localclientnum);
			function_bbf9723b();
			function_d11e8e8d(localclientnum);
			function_d11e8e8d(localclientnum);
			function_d11e8e8d(localclientnum);
			function_d11e8e8d(localclientnum);
			function_bbf9723b();
			function_5200214e(localclientnum);
			function_5200214e(localclientnum);
			function_5200214e(localclientnum);
			function_ca7f5c75();
			function_d11e8e8d(localclientnum);
			function_5200214e(localclientnum);
			function_bbf9723b();
			function_5200214e(localclientnum);
			function_d11e8e8d(localclientnum);
			function_d11e8e8d(localclientnum);
			function_d11e8e8d(localclientnum);
			function_bbf9723b();
			function_d11e8e8d(localclientnum);
			function_5200214e(localclientnum);
			function_bbf9723b();
			function_5200214e(localclientnum);
			function_d11e8e8d(localclientnum);
			function_bbf9723b();
			function_5200214e(localclientnum);
			function_d11e8e8d(localclientnum);
			function_d11e8e8d(localclientnum);
			function_bbf9723b();
			function_5200214e(localclientnum);
			function_5200214e(localclientnum);
			function_5200214e(localclientnum);
			function_bbf9723b();
			function_5200214e(localclientnum);
			function_d11e8e8d(localclientnum);
			function_bbf9723b();
			function_d11e8e8d(localclientnum);
			function_bbf9723b();
			function_5200214e(localclientnum);
			function_d11e8e8d(localclientnum);
			function_d11e8e8d(localclientnum);
			function_ca7f5c75();
			function_5200214e(localclientnum);
			function_d11e8e8d(localclientnum);
			function_5200214e(localclientnum);
			function_5200214e(localclientnum);
			function_bbf9723b();
			function_5200214e(localclientnum);
			function_5200214e(localclientnum);
			function_5200214e(localclientnum);
			function_bbf9723b();
			function_d11e8e8d(localclientnum);
			function_d11e8e8d(localclientnum);
			function_5200214e(localclientnum);
		}
	}
}

/*
	Name: function_d11e8e8d
	Namespace: namespace_57873b62
	Checksum: 0x390D1F3D
	Offset: 0xF60
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_d11e8e8d(localclientnum)
{
	var_a4f5395a = util::playfxontag(localclientnum, #"hash_431dfa76576eb899", self, "tag_origin");
	wait(0.25);
	if(isdefined(var_a4f5395a))
	{
		killfx(localclientnum, var_a4f5395a);
	}
	wait(0.25);
}

/*
	Name: function_5200214e
	Namespace: namespace_57873b62
	Checksum: 0x157DC659
	Offset: 0xFE0
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_5200214e(localclientnum)
{
	var_a4f5395a = util::playfxontag(localclientnum, #"hash_431dfa76576eb899", self, "tag_origin");
	wait(0.75);
	if(isdefined(var_a4f5395a))
	{
		killfx(localclientnum, var_a4f5395a);
	}
	wait(0.25);
}

/*
	Name: function_bbf9723b
	Namespace: namespace_57873b62
	Checksum: 0xAD93B051
	Offset: 0x1060
	Size: 0xC
	Parameters: 0
	Flags: Linked
*/
function function_bbf9723b()
{
	wait(0.5);
}

/*
	Name: function_ca7f5c75
	Namespace: namespace_57873b62
	Checksum: 0x4F863F83
	Offset: 0x1078
	Size: 0xC
	Parameters: 0
	Flags: Linked
*/
function function_ca7f5c75()
{
	wait(1.5);
}

