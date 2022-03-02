// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2a8820b4158c6689;
#using script_ac6a30f1991e105;
#using scripts\core_common\ai_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\footsteps_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm.csc;

#namespace zm_ai_brutus;

/*
	Name: function_89f2df9
	Namespace: zm_ai_brutus
	Checksum: 0xE4AA031F
	Offset: 0x1D8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"zm_ai_brutus", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_ai_brutus
	Checksum: 0x66C96DB8
	Offset: 0x220
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("actor", "brutus_shock_attack", 1, 1, "counter", &brutus_shock_attack_fx, 0, 0);
	clientfield::register("actor", "brutus_spawn_clientfield", 1, 1, "int", &function_80adaab1, 0, 0);
	clientfield::register("toplayer", "brutus_shock_attack_player", 1, 1, "counter", &brutus_shock_attack_player, 0, 0);
	footsteps::registeraitypefootstepcb(#"brutus", &function_6e2a738c);
}

/*
	Name: function_80adaab1
	Namespace: zm_ai_brutus
	Checksum: 0x9078650D
	Offset: 0x338
	Size: 0x10C
	Parameters: 7
	Flags: Linked
*/
function function_80adaab1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	self util::waittill_dobj(localclientnum);
	if(!isdefined(self))
	{
		return;
	}
	if(newval)
	{
		self.lightfx = util::playfxontag(localclientnum, "light/fx8_light_spot_brutus_flicker", self, "tag_spotlight");
		playfx(localclientnum, "maps/zm_escape/fx8_alcatraz_brut_spawn", self.origin);
	}
	else
	{
		if(isdefined(self.lightfx))
		{
			stopfx(localclientnum, self.lightfx);
		}
		playfx(localclientnum, "maps/zm_escape/fx8_alcatraz_brut_spawn", self.origin);
	}
}

/*
	Name: brutus_shock_attack_fx
	Namespace: zm_ai_brutus
	Checksum: 0x4A01E520
	Offset: 0x450
	Size: 0xFC
	Parameters: 7
	Flags: Linked
*/
function brutus_shock_attack_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	self util::waittill_dobj(localclientnum);
	if(!isdefined(self))
	{
		return;
	}
	radius = self ai::function_9139c839().var_1709a39;
	if(!isdefined(radius))
	{
		radius = 512;
	}
	playfx(localclientnum, "maps/zm_escape/fx8_alcatraz_brut_shock", self.origin, anglestoup(self.angles));
	earthquake(localclientnum, 1, 1, self.origin, radius);
}

/*
	Name: brutus_shock_attack_player
	Namespace: zm_ai_brutus
	Checksum: 0xAF7A0D55
	Offset: 0x558
	Size: 0x5C
	Parameters: 7
	Flags: Linked
*/
function brutus_shock_attack_player(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	function_36e4ebd4(localclientnum, "damage_heavy");
}

/*
	Name: function_6e2a738c
	Namespace: zm_ai_brutus
	Checksum: 0x49D559E
	Offset: 0x5C0
	Size: 0x12E
	Parameters: 5
	Flags: Linked
*/
function function_6e2a738c(localclientnum, pos, surface, notetrack, bone)
{
	a_players = getlocalplayers();
	for(i = 0; i < a_players.size; i++)
	{
		if(abs(self.origin[2] - a_players[i].origin[2]) < 128)
		{
			var_ed2e93e5 = a_players[i] getlocalclientnumber();
			if(isdefined(var_ed2e93e5))
			{
				earthquake(var_ed2e93e5, 0.5, 0.1, self.origin, 1500);
				playrumbleonposition(var_ed2e93e5, "brutus_footsteps", self.origin);
			}
		}
	}
}

