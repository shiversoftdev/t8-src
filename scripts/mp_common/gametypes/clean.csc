// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace clean;

/*
	Name: main
	Namespace: clean
	Checksum: 0x228632E3
	Offset: 0x1D8
	Size: 0x23C
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	clientfield::register("clientuimodel", "hudItems.cleanCarryCount", 14000, 4, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "hudItems.cleanCarryFull", 14000, 1, "int", undefined, 0, 0);
	clientfield::register("scriptmover", "taco_flag", 14000, 2, "int", &function_11abf5b2, 0, 0);
	clientfield::register("allplayers", "taco_carry", 14000, 1, "int", &function_aa7bb941, 0, 0);
	clientfield::register("scriptmover", "taco_player_entnum", 14000, 4, "int", &function_568727a2, 0, 0);
	level.var_aaaae0b = "ui/fx8_fracture_plyr_marker";
	level.var_5844252c = "ui/fx8_fracture_drop_marker";
	level.var_ce64ea3e = #"hash_77d505035209b8d6";
	if(isdefined(getgametypesetting(#"hash_5cc4c3042b7d4935")) && getgametypesetting(#"hash_5cc4c3042b7d4935"))
	{
		level.var_aaaae0b = "ui/fx8_fracture_plyr_marker_shamrock";
		level.var_5844252c = "ui/fx8_fracture_drop_marker_shamrock";
		level.var_ce64ea3e = #"hash_3a64e972390f43aa";
	}
	callback::on_localclient_connect(&on_localclient_connect);
}

/*
	Name: on_localclient_connect
	Namespace: clean
	Checksum: 0xC858096C
	Offset: 0x420
	Size: 0x24
	Parameters: 1
	Flags: Private
*/
private function on_localclient_connect(localclientnum)
{
	function_d91ca1f1(localclientnum);
}

/*
	Name: function_11abf5b2
	Namespace: clean
	Checksum: 0xDDC873AA
	Offset: 0x450
	Size: 0x1D4
	Parameters: 7
	Flags: None
*/
function function_11abf5b2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self notify(#"hash_7117a0f5c62d8c3d");
	if(isdefined(self.var_47b256ef))
	{
		self.var_47b256ef unlink();
		self.var_47b256ef.origin = self.origin;
	}
	self function_81431153(localclientnum);
	if(newval != 0)
	{
		if(!isdefined(self.var_47b256ef))
		{
			self.var_47b256ef = spawn(localclientnum, self.origin, "script_model");
			self.var_47b256ef setmodel(#"tag_origin");
			self thread function_bcb88fb7(localclientnum);
		}
		self.var_5844252c = util::playfxontag(localclientnum, level.var_5844252c, self.var_47b256ef, "tag_origin");
		setfxteam(localclientnum, self.var_5844252c, self.team);
	}
	if(newval == 1)
	{
		self.var_47b256ef linkto(self);
	}
	else if(newval == 2)
	{
		self thread function_d1834e16(localclientnum);
	}
}

/*
	Name: function_bcb88fb7
	Namespace: clean
	Checksum: 0x44CCC975
	Offset: 0x630
	Size: 0x5E
	Parameters: 1
	Flags: None
*/
function function_bcb88fb7(localclientnum)
{
	self waittill(#"death");
	self function_81431153(localclientnum);
	self.var_47b256ef delete();
	self.var_47b256ef = undefined;
}

/*
	Name: function_81431153
	Namespace: clean
	Checksum: 0xBFD772E2
	Offset: 0x698
	Size: 0x3E
	Parameters: 1
	Flags: None
*/
function function_81431153(localclientnum)
{
	if(isdefined(self.var_5844252c))
	{
		killfx(localclientnum, self.var_5844252c);
		self.var_5844252c = undefined;
	}
}

/*
	Name: function_d1834e16
	Namespace: clean
	Checksum: 0xDDAA6C37
	Offset: 0x6E0
	Size: 0xFC
	Parameters: 1
	Flags: None
*/
function function_d1834e16(localclientnum)
{
	self endon(#"hash_7117a0f5c62d8c3d");
	self endon(#"death");
	toppos = self.origin + vectorscale((0, 0, 1), 12);
	bottompos = self.origin;
	while(true)
	{
		self.var_47b256ef moveto(toppos, 0.5, 0, 0);
		self.var_47b256ef waittill(#"movedone");
		self.var_47b256ef moveto(bottompos, 0.5, 0, 0);
		self.var_47b256ef waittill(#"movedone");
	}
}

/*
	Name: function_aa7bb941
	Namespace: clean
	Checksum: 0x66DB7814
	Offset: 0x7E8
	Size: 0xEC
	Parameters: 7
	Flags: None
*/
function function_aa7bb941(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self function_cd6915b7(localclientnum);
	if(newval && function_5c10bd79(localclientnum) != self)
	{
		self util::waittill_dobj(localclientnum);
		if(!isdefined(self))
		{
			return;
		}
		self.var_aaaae0b = util::playfxontag(localclientnum, level.var_aaaae0b, self, "j_neck");
		setfxteam(localclientnum, self.var_aaaae0b, self.team);
	}
}

/*
	Name: function_5cf5b566
	Namespace: clean
	Checksum: 0x550199FA
	Offset: 0x8E0
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function function_5cf5b566(localclientnum)
{
	self waittill(#"death");
	self function_cd6915b7(localclientnum);
}

/*
	Name: function_cd6915b7
	Namespace: clean
	Checksum: 0xF45B1D0F
	Offset: 0x928
	Size: 0x3E
	Parameters: 1
	Flags: None
*/
function function_cd6915b7(localclientnum)
{
	if(isdefined(self.var_aaaae0b))
	{
		killfx(localclientnum, self.var_aaaae0b);
		self.var_aaaae0b = undefined;
	}
}

/*
	Name: function_d91ca1f1
	Namespace: clean
	Checksum: 0xA0309388
	Offset: 0x970
	Size: 0xF6
	Parameters: 1
	Flags: None
*/
function function_d91ca1f1(localclientnum)
{
	level.var_67485c05[localclientnum] = [];
	for(i = 0; i < 16; i++)
	{
		level.var_ccb8d7fb[localclientnum][i] = spawnstruct();
		objid = util::getnextobjid(localclientnum);
		level.var_ccb8d7fb[localclientnum][i].id = objid;
		level.var_ccb8d7fb[localclientnum][i].var_336f0669 = undefined;
		objective_add(localclientnum, objid, "invisible", level.var_ce64ea3e);
	}
}

/*
	Name: function_5d02c098
	Namespace: clean
	Checksum: 0xD86AF7D8
	Offset: 0xA70
	Size: 0x9C
	Parameters: 2
	Flags: None
*/
function function_5d02c098(localclientnum, var_336f0669)
{
	for(i = 0; i < 16; i++)
	{
		if(!isdefined(level.var_ccb8d7fb[localclientnum][i].var_336f0669))
		{
			level.var_ccb8d7fb[localclientnum][i].var_336f0669 = var_336f0669;
			return level.var_ccb8d7fb[localclientnum][i].id;
		}
	}
	return undefined;
}

/*
	Name: function_53576950
	Namespace: clean
	Checksum: 0x4A7786DC
	Offset: 0xB18
	Size: 0x9C
	Parameters: 2
	Flags: None
*/
function function_53576950(localclientnum, var_336f0669)
{
	for(i = 0; i < 16; i++)
	{
		if(level.var_ccb8d7fb[localclientnum][i].var_336f0669 === var_336f0669)
		{
			level.var_ccb8d7fb[localclientnum][i].var_336f0669 = undefined;
			return level.var_ccb8d7fb[localclientnum][i].id;
		}
	}
	return undefined;
}

/*
	Name: function_568727a2
	Namespace: clean
	Checksum: 0x488FAA25
	Offset: 0xBC0
	Size: 0x164
	Parameters: 7
	Flags: None
*/
function function_568727a2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	player = function_27673a7(localclientnum);
	playerentnum = player getentitynumber();
	if(newval == playerentnum && newval != oldval)
	{
		objid = function_5d02c098(localclientnum, self getentitynumber());
		if(isdefined(objid))
		{
			objective_setstate(localclientnum, objid, "active");
			objective_setposition(localclientnum, objid, self.origin);
		}
	}
	else
	{
		objid = function_53576950(localclientnum, self getentitynumber());
		if(isdefined(objid))
		{
			objective_setstate(localclientnum, objid, "invisible");
		}
	}
}

