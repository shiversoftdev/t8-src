// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\duplicaterender_mgr.csc;
#using scripts\core_common\filter_shared.csc;
#using scripts\core_common\math_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\vehicle_shared.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace bat;

/*
	Name: main
	Namespace: bat
	Checksum: 0x331FEA0F
	Offset: 0x130
	Size: 0x74
	Parameters: 0
	Flags: AutoExec
*/
function autoexec main()
{
	vehicle::add_vehicletype_callback("bat", &function_9b3fe343);
	clientfield::register("vehicle", "bat_transform_fx", 8000, 1, "int", &battransformfx, 0, 0);
}

/*
	Name: function_9b3fe343
	Namespace: bat
	Checksum: 0x6F7A6D59
	Offset: 0x1B0
	Size: 0xB4
	Parameters: 1
	Flags: Linked, Private
*/
function private function_9b3fe343(localclientnum)
{
	self mapshaderconstant(localclientnum, 0, "scriptVector2", 0.1);
	if(isdefined(level.debug_keyline_zombies) && level.debug_keyline_zombies)
	{
		self duplicate_render::set_dr_flag("keyline_active", 1);
		self duplicate_render::update_dr_filters(localclientnum);
	}
	util::playfxontag(localclientnum, #"hash_1cb1e3e527bd121c", self, "tag_eye");
}

/*
	Name: battransformfx
	Namespace: bat
	Checksum: 0xCCFDA227
	Offset: 0x270
	Size: 0xDC
	Parameters: 7
	Flags: Linked
*/
function battransformfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		e_player = function_5c10bd79(localclientnum);
		physicsexplosionsphere(localclientnum, self.origin, 250, 30, 5);
		n_dist = distance(self.origin, e_player.origin);
		if(n_dist < 400)
		{
			function_36e4ebd4(localclientnum, "damage_light");
		}
	}
}

