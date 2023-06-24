// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace seeker_mine;

/*
	Name: main
	Namespace: seeker_mine
	Checksum: 0x5E8D8198
	Offset: 0x100
	Size: 0xBC
	Parameters: 0
	Flags: AutoExec
*/
function autoexec main()
{
	clientfield::register("vehicle", "seeker_mine_fx", 1, 1, "int", &fxhandler, 0, 0);
	clientfield::register("vehicle", "seeker_mine_light_fx", 1, 1, "int", &lightfxhandler, 0, 0);
	ai::add_archetype_spawn_function("seeker_mine", &spawned);
}

/*
	Name: spawned
	Namespace: seeker_mine
	Checksum: 0xC435E582
	Offset: 0x1C8
	Size: 0xAC
	Parameters: 1
	Flags: None
*/
function spawned(localclientnum)
{
	localplayer = function_5c10bd79(localclientnum);
	if(self.team === localplayer.team)
	{
		setsoundcontext("team", "ally");
	}
	else
	{
		setsoundcontext("team", "enemy");
	}
	self thread function_710c1bb3(localclientnum);
}

/*
	Name: function_710c1bb3
	Namespace: seeker_mine
	Checksum: 0x600D58FB
	Offset: 0x280
	Size: 0xB8
	Parameters: 1
	Flags: Private
*/
function private function_710c1bb3(localclientnum)
{
	self endon(#"death");
	self util::waittill_dobj(localclientnum);
	while(true)
	{
		self.light_fx = util::playfxontag(localclientnum, #"hash_69272c24309abc33", self, "tag_fx_front");
		if(isdefined(self.attacking) && self.attacking)
		{
			wait(0.25);
		}
		else
		{
			wait(1);
		}
		stopfx(localclientnum, self.light_fx);
	}
}

/*
	Name: fxhandler
	Namespace: seeker_mine
	Checksum: 0xD0C75BCF
	Offset: 0x340
	Size: 0x84
	Parameters: 7
	Flags: Private
*/
function private fxhandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newvalue)
	{
		self thread play_seeker_mine_fx(localclientnum);
	}
	else
	{
		self function_5aa8d239(localclientnum, self.fxloop);
	}
}

/*
	Name: play_seeker_mine_fx
	Namespace: seeker_mine
	Checksum: 0x7326D3A6
	Offset: 0x3D0
	Size: 0xC4
	Parameters: 1
	Flags: None
*/
function play_seeker_mine_fx(localclientnum)
{
	self endon(#"death");
	playsound(0, #"hash_153d2d19a99f3a29", self.origin);
	sound = self playloopsound(#"hash_40039ac740a9f96e");
	self.fxloop = util::playfxontag(localclientnum, #"hash_180b04db9cd1ee12", self, "tag_body_animate");
	level thread function_cece47d2(localclientnum, self, self.fxloop);
}

/*
	Name: function_cece47d2
	Namespace: seeker_mine
	Checksum: 0xFB1605D
	Offset: 0x4A0
	Size: 0x54
	Parameters: 3
	Flags: None
*/
function function_cece47d2(localclientnum, entity, fx)
{
	entity waittill(#"death");
	level function_5aa8d239(localclientnum, fx);
}

/*
	Name: function_5aa8d239
	Namespace: seeker_mine
	Checksum: 0x30CF29E
	Offset: 0x500
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function function_5aa8d239(localclientnum, fx)
{
	if(isdefined(fx))
	{
		stopfx(localclientnum, fx);
	}
}

/*
	Name: lightfxhandler
	Namespace: seeker_mine
	Checksum: 0x39623459
	Offset: 0x540
	Size: 0x62
	Parameters: 7
	Flags: Private
*/
function private lightfxhandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newvalue)
	{
		self.attacking = 1;
	}
	else
	{
		self.attacking = 0;
	}
}

