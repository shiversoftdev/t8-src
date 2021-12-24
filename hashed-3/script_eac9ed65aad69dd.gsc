// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\math_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_d81cee52;

/*
	Name: function_89f2df9
	Namespace: namespace_d81cee52
	Checksum: 0xEC310634
	Offset: 0x1D0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_664a4361aaa4140d", &init_shared, undefined, undefined);
}

/*
	Name: init_shared
	Namespace: namespace_d81cee52
	Checksum: 0x51572C65
	Offset: 0x218
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function init_shared(localclientnum)
{
	clientfield::register("missile", "sensor_dart_state", 1, 1, "int", &function_73021afc, 0, 1);
	clientfield::register("clientuimodel", "hudItems.sensorDartCount", 1, 3, "int", undefined, 0, 0);
	callback::on_localclient_connect(&player_init);
	callback::add_weapon_type("eq_sensor", &arrow_spawned);
}

/*
	Name: arrow_spawned
	Namespace: namespace_d81cee52
	Checksum: 0x717EAFAE
	Offset: 0x2F8
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function arrow_spawned(localclientnum)
{
	self.var_44dad7e8 = 1;
}

/*
	Name: player_init
	Namespace: namespace_d81cee52
	Checksum: 0x34B546AF
	Offset: 0x320
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function player_init(localclientnum)
{
	self thread function_31a1aa18(localclientnum);
}

/*
	Name: function_73021afc
	Namespace: namespace_d81cee52
	Checksum: 0xE3EAC1B9
	Offset: 0x350
	Size: 0x162
	Parameters: 7
	Flags: Linked, Private
*/
private function function_73021afc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	starttime = gettime();
	while(isdefined(self) && !self hasdobj(localclientnum))
	{
		if(gettime() - starttime > 1000)
		{
			return;
		}
		waitframe(1);
	}
	if(!isdefined(self))
	{
		return;
	}
	self function_8e04481f();
	switch(newval)
	{
		case 0:
		default:
		{
			self function_b608a20b(localclientnum);
			break;
		}
		case 1:
		{
			self thread function_a252eaf0(localclientnum);
			self thread function_e3a084cd(localclientnum);
			self function_ef15ea9c();
			break;
		}
	}
}

/*
	Name: function_a252eaf0
	Namespace: namespace_d81cee52
	Checksum: 0x2CA24563
	Offset: 0x4C0
	Size: 0x84
	Parameters: 1
	Flags: Linked, Private
*/
private function function_a252eaf0(localclientnum)
{
	var_9cf4b61c = self getentitynumber();
	self waittill(#"death");
	if(isdefined(self.var_b44c157f))
	{
		self.var_b44c157f delete();
	}
	function_fb25716d(localclientnum, var_9cf4b61c);
}

/*
	Name: function_e3a084cd
	Namespace: namespace_d81cee52
	Checksum: 0x8F319462
	Offset: 0x550
	Size: 0x584
	Parameters: 1
	Flags: Linked, Private
*/
private function function_e3a084cd(localclientnum)
{
	self setcompassicon("minimap_sensor_dart_flying");
	self function_8e04481f();
	self function_a5edb367(#"neutral");
	self thread function_6527a2e9(localclientnum, "o_recon_sensor_gun_projectile_closed_idle");
	var_9cf4b61c = self getentitynumber();
	self endon(#"death");
	var_18452954 = getservertime(localclientnum);
	startorigin = self.origin;
	var_dc3f8ecd = startorigin;
	var_3d3d7bb1 = 0;
	localplayer = function_5c10bd79(localclientnum);
	self.var_b44c157f = spawn(localclientnum, self.origin, "script_model", localplayer getentitynumber(), self.team);
	self.var_b44c157f setmodel(#"tag_origin");
	self.var_b44c157f linkto(self);
	self.var_b44c157f setcompassicon("minimap_sensor_dart_pip");
	self.var_b44c157f function_8e04481f();
	self.var_b44c157f function_5e00861(0.25);
	self.var_b44c157f function_a5edb367(#"neutral");
	while(var_3d3d7bb1 < 250)
	{
		var_dc3f8ecd = self.origin;
		var_450cbe48 = getservertime(localclientnum);
		elapsedtime = var_450cbe48 - var_18452954;
		if(1)
		{
			var_e460f21 = math::clamp(elapsedtime / 500, 0, 1);
			radius = lerpfloat(200, 600, var_e460f21);
			distance = distance2d(self.origin, startorigin);
			if(distance > 200)
			{
				self.angles = vectortoangles(self.origin - startorigin);
				var_354c76a5 = atan(radius / distance);
				if(var_3d3d7bb1 > 0)
				{
					var_354c76a5 = var_354c76a5 * ((250 - var_3d3d7bb1) / 250);
					self function_5e00861(0);
				}
				else
				{
					self function_5e00861((radius / 200) * 0.6);
				}
				self function_5db470de(localclientnum, distance, 1, var_354c76a5 * 2);
			}
		}
		waitframe(1);
		parent = self getlinkedent();
		if(isdefined(parent) || var_dc3f8ecd == self.origin)
		{
			var_3d3d7bb1 = (var_3d3d7bb1 + getservertime(localclientnum)) - var_450cbe48;
		}
		else
		{
			var_3d3d7bb1 = 0;
		}
	}
	if(isdefined(self.var_b44c157f))
	{
		self.var_b44c157f delete();
	}
	self setcompassicon("minimap_sensor_dart");
	self function_8e04481f();
	self function_5e00861(0.62);
	var_d199bf4f = (function_f99d2668() ? 2400 : 800);
	if(isdefined(level.var_1bf85d03))
	{
		var_d199bf4f = level.var_1bf85d03;
	}
	self function_5db470de(localclientnum, var_d199bf4f, 1);
	self thread function_6527a2e9(localclientnum, "o_recon_sensor_gun_projectile_open", "o_recon_sensor_gun_projectile_closed_idle");
	self thread function_e140ca2b(localclientnum);
}

/*
	Name: function_31a1aa18
	Namespace: namespace_d81cee52
	Checksum: 0xFB5C6D7C
	Offset: 0xAE0
	Size: 0x3C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_31a1aa18(localclientnum)
{
	level waittill(#"game_ended");
	function_c18242d9(localclientnum);
}

/*
	Name: function_6527a2e9
	Namespace: namespace_d81cee52
	Checksum: 0x14898050
	Offset: 0xB28
	Size: 0xCC
	Parameters: 3
	Flags: Linked
*/
function function_6527a2e9(localclientnum, animname, prevanim)
{
	self endon(#"death");
	self util::waittill_dobj(localclientnum);
	self useanimtree("generic");
	self setanimrestart(animname, 1, 0, 1);
	if(isdefined(prevanim))
	{
		self setanimrestart(prevanim, 0, 0, 1);
	}
}

/*
	Name: function_e140ca2b
	Namespace: namespace_d81cee52
	Checksum: 0xFCD1C0C1
	Offset: 0xC00
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function function_e140ca2b(localclientnum)
{
	self endon(#"death");
	self waittill(#"hash_8156a03b06bd6e4");
	self thread function_6527a2e9(localclientnum, "o_recon_sensor_gun_projectile_open_idle");
}

