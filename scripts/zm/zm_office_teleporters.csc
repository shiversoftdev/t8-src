// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_fasttravel.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace zm_office_teleporters;

/*
	Name: __init__system__
	Namespace: zm_office_teleporters
	Checksum: 0x86B08F10
	Offset: 0x340
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_office_teleporters", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_office_teleporters
	Checksum: 0xA480D2F2
	Offset: 0x390
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_clientfields();
	init_fx();
}

/*
	Name: __main__
	Namespace: zm_office_teleporters
	Checksum: 0x11C6758
	Offset: 0x3C0
	Size: 0x29C
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	num = getdvarint(#"splitscreen_playercount", 0);
	if(num < 1)
	{
		num = 1;
	}
	for(localclientnum = 0; localclientnum < num; localclientnum++)
	{
		util::waitforclient(localclientnum);
	}
	level._effect[#"fasttravel_end"] = #"tools/fx_null";
	if(!isdefined(level.var_22677da8))
	{
		level.var_22677da8 = [];
	}
	else if(!isarray(level.var_22677da8))
	{
		level.var_22677da8 = array(level.var_22677da8);
	}
	a_s_portals = struct::get_array("office_portal");
	a_e_players = getlocalplayers();
	foreach(s_portal in a_s_portals)
	{
		level.var_22677da8[s_portal.script_noteworthy] = s_portal;
		if(!isdefined(s_portal.var_9d387dd5))
		{
			s_portal.var_9d387dd5 = [];
		}
		else if(!isarray(s_portal.var_9d387dd5))
		{
			s_portal.var_9d387dd5 = array(s_portal.var_9d387dd5);
		}
		for(i = 0; i < a_e_players.size; i++)
		{
			s_portal.var_9d387dd5[i] = util::spawn_model(i, "tag_origin", s_portal.origin, s_portal.angles);
		}
	}
}

/*
	Name: init_clientfields
	Namespace: zm_office_teleporters
	Checksum: 0xB79C295D
	Offset: 0x668
	Size: 0x4CC
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("scriptmover", "portal_dest_fx", 1, 3, "int", &function_e4ea441, 0, 0);
	clientfield::register("toplayer", "portal_conference_level1", 1, 1, "int", &portal_ready_fx, 0, 0);
	clientfield::register("toplayer", "portal_offices_level1", 1, 1, "int", &portal_ready_fx, 0, 0);
	clientfield::register("toplayer", "portal_war_room", 1, 1, "int", &portal_ready_fx, 0, 0);
	clientfield::register("toplayer", "portal_war_room_server_room", 1, 1, "int", &portal_ready_fx, 0, 0);
	clientfield::register("toplayer", "portal_war_room_map", 1, 1, "int", &portal_ready_fx, 0, 0);
	clientfield::register("toplayer", "portal_panic_room", 1, 1, "int", &portal_ready_fx, 0, 0);
	clientfield::register("toplayer", "portal_labs_power_room", 1, 1, "int", &portal_ready_fx, 0, 0);
	clientfield::register("toplayer", "portal_labs_hall1_east", 1, 1, "int", &portal_ready_fx, 0, 0);
	clientfield::register("toplayer", "portal_labs_hall1_west", 1, 1, "int", &portal_ready_fx, 0, 0);
	clientfield::register("toplayer", "portal_labs_hall2_east", 1, 1, "int", &portal_ready_fx, 0, 0);
	clientfield::register("toplayer", "portal_labs_hall2_west", 1, 1, "int", &portal_ready_fx, 0, 0);
	clientfield::register("world", "delete_war_room_portal_fx", 1, 1, "counter", &delete_war_room_portal_fx, 0, 0);
	clientfield::register("scriptmover", "cage_portal_fx", 1, 1, "int", &cage_portal_fx, 0, 0);
	clientfield::register("actor", "crawler_portal_spawn_fx", 1, 1, "counter", &crawler_portal_spawn_fx, 0, 0);
	clientfield::register("toplayer", "teleporter_transition", 1, 1, "counter", &function_38a241a1, 0, 0);
	clientfield::register("scriptmover", "war_room_map_control", 1, 1, "int", &war_room_map_control, 1, 0);
}

/*
	Name: init_fx
	Namespace: zm_office_teleporters
	Checksum: 0x582FFEB5
	Offset: 0xB40
	Size: 0x1B2
	Parameters: 0
	Flags: Linked
*/
function init_fx()
{
	level._effect[#"portal_ready"] = #"maps/zm_office/fx8_teleporter_ready";
	level._effect[#"portal_cooldown"] = #"hash_7793c4c65b08e6ed";
	level._effect[#"hash_32b0f959e6b81272"] = #"hash_4860741425dc1daa";
	level._effect[#"hash_44687d6082f9a0a4"] = #"hash_a4954ed961d6327";
	level._effect[#"hash_2e43973bc23c661d"] = #"hash_28fc28160d26395e";
	level._effect[#"hash_69091fb60c4fb574"] = #"hash_35e8a88a4a4563b4";
	level._effect[#"hash_690922b60c4fba8d"] = #"hash_205d49f043463dd2";
	level._effect[#"hash_690921b60c4fb8da"] = #"hash_19301646fb93e04c";
	level._effect[#"hash_3ae2cb0d50ae8e3e"] = #"hash_2cafcfa899f12c0";
}

/*
	Name: function_38a241a1
	Namespace: zm_office_teleporters
	Checksum: 0xEF1BDE51
	Offset: 0xD00
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_38a241a1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	/#
		println("", localclientnum);
	#/
	self thread postfx::playpostfxbundle("pstfx_zm_office_teleporter");
}

/*
	Name: function_e4ea441
	Namespace: zm_office_teleporters
	Checksum: 0x3FAB7676
	Offset: 0xD88
	Size: 0x2BA
	Parameters: 7
	Flags: Linked
*/
function function_e4ea441(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.effect_id))
	{
		deletefx(localclientnum, self.effect_id);
	}
	switch(newval)
	{
		case 1:
		{
			self.effect_id = util::playfxontag(localclientnum, level._effect[#"hash_69091fb60c4fb574"], self, "tag_origin");
			self.var_81884612 = self playloopsound(#"evt_teleporter_loop", 1.75);
			break;
		}
		case 2:
		{
			self.effect_id = util::playfxontag(localclientnum, level._effect[#"hash_690922b60c4fba8d"], self, "tag_origin");
			self.var_81884612 = self playloopsound(#"evt_teleporter_loop", 1.75);
			break;
		}
		case 3:
		{
			self.effect_id = util::playfxontag(localclientnum, level._effect[#"hash_690921b60c4fb8da"], self, "tag_origin");
			self.var_81884612 = self playloopsound(#"evt_teleporter_loop", 1.75);
			break;
		}
		case 4:
		{
			self.effect_id = util::playfxontag(localclientnum, level._effect[#"hash_44687d6082f9a0a4"], self, "tag_origin");
			self thread play_packa_special_looper(localclientnum);
			break;
		}
		case 5:
		{
			self.effect_id = util::playfxontag(localclientnum, level._effect[#"hash_2e43973bc23c661d"], self, "tag_origin");
			break;
		}
	}
}

/*
	Name: portal_ready_fx
	Namespace: zm_office_teleporters
	Checksum: 0x229541C1
	Offset: 0x1050
	Size: 0x166
	Parameters: 7
	Flags: Linked
*/
function portal_ready_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	while(!isdefined(level.var_22677da8))
	{
		waitframe(1);
	}
	var_dabe3ecb = level.var_22677da8[fieldname].var_9d387dd5[localclientnum];
	if(!isdefined(var_dabe3ecb) || var_dabe3ecb.b_off === 1)
	{
		return;
	}
	if(isdefined(var_dabe3ecb.effect_id))
	{
		deletefx(localclientnum, var_dabe3ecb.effect_id);
	}
	if(newval > 0)
	{
		var_dabe3ecb.effect_id = util::playfxontag(localclientnum, level._effect[#"portal_ready"], var_dabe3ecb, "tag_origin");
	}
	else
	{
		var_dabe3ecb.effect_id = util::playfxontag(localclientnum, level._effect[#"portal_cooldown"], var_dabe3ecb, "tag_origin");
	}
}

/*
	Name: play_packa_special_looper
	Namespace: zm_office_teleporters
	Checksum: 0x2A30CF7B
	Offset: 0x11C0
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function play_packa_special_looper(localclientnum)
{
	self playloopsound("mus_packapunch_special", 1);
	level waittill(#"pack_portal_fx_off", localclientnum);
	self stoploopsound(1);
}

/*
	Name: delete_war_room_portal_fx
	Namespace: zm_office_teleporters
	Checksum: 0x19BEC96B
	Offset: 0x1228
	Size: 0xC4
	Parameters: 7
	Flags: Linked
*/
function delete_war_room_portal_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	while(!isdefined(level.var_22677da8))
	{
		waitframe(1);
	}
	var_dabe3ecb = level.var_22677da8[#"portal_war_room"].var_9d387dd5[localclientnum];
	var_dabe3ecb.b_off = 1;
	if(isdefined(var_dabe3ecb.effect_id))
	{
		deletefx(localclientnum, var_dabe3ecb.effect_id);
	}
}

/*
	Name: cage_portal_fx
	Namespace: zm_office_teleporters
	Checksum: 0x924247EF
	Offset: 0x12F8
	Size: 0x278
	Parameters: 7
	Flags: Linked
*/
function cage_portal_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval > 0)
	{
		if(!isdefined(self.fx_ids))
		{
			self.fx_ids = [];
		}
		else if(!isarray(self.fx_ids))
		{
			self.fx_ids = array(self.fx_ids);
		}
		var_330a603a = util::playfxontag(localclientnum, level._effect[#"hash_690922b60c4fba8d"], self, "tag_origin");
		if(!isdefined(self.fx_ids))
		{
			self.fx_ids = [];
		}
		else if(!isarray(self.fx_ids))
		{
			self.fx_ids = array(self.fx_ids);
		}
		self.fx_ids[self.fx_ids.size] = var_330a603a;
		var_330a603a = util::playfxontag(localclientnum, level._effect[#"portal_ready"], self, "tag_origin");
		if(!isdefined(self.fx_ids))
		{
			self.fx_ids = [];
		}
		else if(!isarray(self.fx_ids))
		{
			self.fx_ids = array(self.fx_ids);
		}
		self.fx_ids[self.fx_ids.size] = var_330a603a;
	}
	else
	{
		foreach(fx_id in self.fx_ids)
		{
			deletefx(localclientnum, fx_id);
		}
	}
}

/*
	Name: function_d522cf76
	Namespace: zm_office_teleporters
	Checksum: 0x7E436247
	Offset: 0x1578
	Size: 0xFC
	Parameters: 7
	Flags: None
*/
function function_d522cf76(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	while(!isdefined(level.fxents))
	{
		waitframe(1);
	}
	if(newval > 0)
	{
		fx_array = level.fxents[localclientnum];
		for(i = 0; i < fx_array.size; i++)
		{
			if(fx_array[i].portal_id === "portal_war_room")
			{
				deletefx(localclientnum, fx_array[i].portalfx);
				fx_array[i] = level.var_b657fc96;
			}
		}
	}
}

/*
	Name: groom_lake_fx
	Namespace: zm_office_teleporters
	Checksum: 0x89F1B27A
	Offset: 0x1680
	Size: 0x1F2
	Parameters: 7
	Flags: None
*/
function groom_lake_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	while(!isdefined(level.var_5b15862b))
	{
		waitframe(1);
	}
	fx_array = level.var_5b15862b[localclientnum];
	foreach(fx_pos in fx_array)
	{
		if(isdefined(fx_pos.portalfx))
		{
			deletefx(localclientnum, fx_pos.portalfx);
		}
		if(newval > 1)
		{
			fx_pos.portalfx = util::playfxontag(localclientnum, level._effect[#"hash_578fbb9b0cbfb223"], fx_pos, "tag_origin");
			continue;
		}
		if(newval == 1)
		{
			fx_pos.portalfx = util::playfxontag(localclientnum, level._effect[#"hash_7329d5e1b8fc021a"], fx_pos, "tag_origin");
			continue;
		}
		fx_pos.portalfx = util::playfxontag(localclientnum, level._effect[#"hash_710b1e3e51e84426"], fx_pos, "tag_origin");
	}
}

/*
	Name: crawler_portal_spawn_fx
	Namespace: zm_office_teleporters
	Checksum: 0x6C415D08
	Offset: 0x1880
	Size: 0xD4
	Parameters: 7
	Flags: Linked
*/
function crawler_portal_spawn_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	self endon(#"death");
	warmup_fx = util::playfxontag(localclientnum, "maps/zm_office/fx8_teleporter_ready", self, "j_spine2");
	wait(1.5);
	if(isdefined(warmup_fx))
	{
		deletefx(localclientnum, warmup_fx);
	}
	util::playfxontag(localclientnum, "maps/zm_office/fx8_teleporter_destination", self, "j_spine2");
}

/*
	Name: war_room_map_control
	Namespace: zm_office_teleporters
	Checksum: 0x171EF12A
	Offset: 0x1960
	Size: 0xEC
	Parameters: 7
	Flags: Linked
*/
function war_room_map_control(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	if(newval)
	{
		wait(1);
		self playrenderoverridebundle("rob_zm_off_table_plotting_map");
	}
	else
	{
		playfx(localclientnum, level._effect[#"hash_3ae2cb0d50ae8e3e"], self.origin, (1, 0, 0), (0, 0, 1));
		wait(1);
		self stoprenderoverridebundle("rob_zm_off_table_plotting_map");
	}
}

