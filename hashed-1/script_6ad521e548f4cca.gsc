// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_13fd015ec021af46;
#using script_36556543de898549;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\vehicle_shared.csc;

#namespace namespace_89b760b9;

/*
	Name: function_89f2df9
	Namespace: namespace_89b760b9
	Checksum: 0x8CE2587F
	Offset: 0x1D0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_c29a54995a18e5c", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_89b760b9
	Checksum: 0xDF5CB38
	Offset: 0x218
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	vehicle::add_vehicletype_callback("veh_seeker_mine_mp", &spawned);
	clientfield::register("allplayers", "seeker_mine_shock", 1, 2, "int", &function_3ade2b96, 0, 0);
	clientfield::register("scriptmover", "seeker_mine_fx", 1, 2, "int", &seeker_mine_fx, 0, 0);
	level.seeker_mine_prompt = seeker_mine_prompt::register("seeker_mine_prompt");
	callback::on_player_corpse(&on_player_corpse);
}

/*
	Name: function_3ade2b96
	Namespace: namespace_89b760b9
	Checksum: 0x39080843
	Offset: 0x320
	Size: 0x15E
	Parameters: 7
	Flags: Linked
*/
function function_3ade2b96(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self.var_3ade2b96 = 1;
		if(self function_21c0fa55())
		{
			setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.playerIsShocked"), 1);
		}
	}
	else if(newval == 2)
	{
		if(self function_21c0fa55() && function_d17ae3cc(localclientnum))
		{
			camfx = playfxoncamera(localclientnum, "player/fx8_plyr_pstfx_paralyze_screen");
			self thread function_a6451cfe(localclientnum, camfx);
		}
	}
	else
	{
		self.var_3ade2b96 = 0;
		self notify(#"hash_43f06be9944cddc1");
	}
}

/*
	Name: seeker_mine_fx
	Namespace: namespace_89b760b9
	Checksum: 0x8ACA9821
	Offset: 0x488
	Size: 0x114
	Parameters: 7
	Flags: Linked
*/
function seeker_mine_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval > 0)
	{
		if(isdefined(self.var_93be3992))
		{
			stopfx(localclientnum, self.var_93be3992);
			self notify(#"hash_6b4bac2b8c2122ef");
		}
		if(newval == 1)
		{
			self.var_93be3992 = util::playfxontag(localclientnum, "player/fx8_plyr_shocked_stage1_3p", self, "tag_origin");
		}
		else
		{
			self.var_93be3992 = util::playfxontag(localclientnum, "player/fx8_plyr_shocked_stage2_3p", self, "tag_origin");
		}
		self thread function_fc90058e(localclientnum, self.var_93be3992);
	}
}

/*
	Name: function_fc90058e
	Namespace: namespace_89b760b9
	Checksum: 0xA3E23FD3
	Offset: 0x5A8
	Size: 0x5C
	Parameters: 2
	Flags: Linked
*/
function function_fc90058e(localclientnum, fx)
{
	self waittill(#"death", #"hash_6b4bac2b8c2122ef");
	if(isdefined(fx))
	{
		stopfx(localclientnum, fx);
	}
}

/*
	Name: on_player_corpse
	Namespace: namespace_89b760b9
	Checksum: 0x40010FF
	Offset: 0x610
	Size: 0x8C
	Parameters: 2
	Flags: Linked
*/
function on_player_corpse(localclientnum, params)
{
	self endon(#"death");
	if(isdefined(params.player.var_3ade2b96) && params.player.var_3ade2b96)
	{
		self util::waittill_dobj(localclientnum);
		playtagfxset(localclientnum, "weapon_hero_seeker_drone_death", self);
	}
}

/*
	Name: function_a6451cfe
	Namespace: namespace_89b760b9
	Checksum: 0xCD6B637D
	Offset: 0x6A8
	Size: 0x9C
	Parameters: 2
	Flags: Linked
*/
function function_a6451cfe(localclientnum, camfx)
{
	self waittill(#"death", #"hash_43f06be9944cddc1");
	if(isdefined(camfx))
	{
		stopfx(localclientnum, camfx);
	}
	setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.playerIsShocked"), 0);
}

/*
	Name: spawned
	Namespace: namespace_89b760b9
	Checksum: 0x8EBD56D3
	Offset: 0x750
	Size: 0x3C
	Parameters: 1
	Flags: Linked, Private
*/
private function spawned(localclientnum)
{
	self function_811196d1(1);
	self seeker_mine::spawned(localclientnum);
}

