// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_617a54f4;

/*
	Name: function_d8383812
	Namespace: namespace_617a54f4
	Checksum: 0xD893ED7D
	Offset: 0x108
	Size: 0x19C
	Parameters: 9
	Flags: None
*/
function function_d8383812(id, var_948bda55, script_noteworthy, speed, var_1c79db43, var_2e845a89, var_925337f4, var_6a1c7649, var_b8d19839 = 0)
{
	if(!isdefined(level.var_e4336230))
	{
		level.var_e4336230 = [];
	}
	level.var_e4336230["sc_" + id] = {#hash_b8d19839:var_b8d19839, #hash_6a1c7649:var_6a1c7649, #hash_925337f4:var_925337f4, #hash_2e845a89:var_2e845a89, #hash_1c79db43:var_1c79db43, #speed:speed, #script_noteworthy:script_noteworthy};
	clientfield::register("actor", "sc_" + id, var_948bda55, 1, "int", &function_305e672f, 0, 0);
	if(var_b8d19839)
	{
		clientfield::register("vehicle", "sc_" + id, var_948bda55, 1, "int", &function_305e672f, 0, 0);
	}
}

/*
	Name: function_305e672f
	Namespace: namespace_617a54f4
	Checksum: 0x460A38EC
	Offset: 0x2B0
	Size: 0x2E4
	Parameters: 7
	Flags: Private
*/
private function function_305e672f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	def = level.var_e4336230[fieldname];
	if(!isdefined(def))
	{
		return;
	}
	self util::waittill_dobj(localclientnum);
	if(!isdefined(self) || !isdefined(self.origin))
	{
		return;
	}
	var_86d7c3fd = struct::get_array(def.script_noteworthy, "script_noteworthy");
	capture_point = arraygetclosest(self.origin, var_86d7c3fd);
	e_fx = spawn(localclientnum, self gettagorigin("J_Spine4"), "script_model");
	e_fx setmodel(#"tag_origin");
	e_fx playsound(localclientnum, "zmb_sq_souls_release");
	util::playfxontag(localclientnum, def.var_1c79db43, e_fx, "tag_origin");
	if(isdefined(def.var_925337f4))
	{
		level [[def.var_925337f4]](localclientnum, def, capture_point, self);
	}
	time = distance(e_fx.origin, capture_point.origin) / def.speed;
	e_fx moveto(capture_point.origin, time);
	e_fx waittill(#"movedone");
	e_fx playsound(localclientnum, "zmb_sq_souls_impact");
	util::playfxontag(localclientnum, def.var_2e845a89, e_fx, "tag_origin");
	if(isdefined(def.var_6a1c7649))
	{
		level [[def.var_6a1c7649]](localclientnum, def, capture_point);
	}
	wait(0.3);
	e_fx delete();
}

