// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace death_circle;

/*
	Name: function_89f2df9
	Namespace: death_circle
	Checksum: 0xA0ED348F
	Offset: 0x198
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"death_circle", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: death_circle
	Checksum: 0x5EF48694
	Offset: 0x1E0
	Size: 0x322
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_d8958e58 = isdefined(getgametypesetting(#"deathcircle")) && getgametypesetting(#"deathcircle");
	if(!level.var_d8958e58)
	{
		return;
	}
	level.var_ef215639 = [3:"evt_death_circle_strong", 2:#"hash_5b96bc3a1c23c571", 1:#"hash_1483048e184df991"];
	level.var_cb450873 = #"hash_313f1d0b4ff27caa";
	level.var_f6795a59 = [3:#"hash_3fc5123369b4c59f", 2:#"hash_5c64e89ab323857a", 1:#"hash_7c7ea03189fe65d8"];
	level.var_601fc3c5 = [3:#"hash_474c4e8748206593", 2:#"hash_474c4d87482063e0", 1:#"wz/fx8_player_outside_circle"];
	level.var_7e948a2d = [3:#"hash_559017f41745034e", 2:#"hash_2ccb19ff6223b693", 1:#"wz/fx8_plyr_pstfx_barrier_lvl_01_wz"];
	level.var_c465fd31 = [3:#"hash_316ec537e4167d47", 2:#"hash_775e24c0ca5d7b58", 1:#"hash_775e24c0ca5d7b58"];
	level.var_7d949aad = [3:0, 2:0, 1:0.5];
	level.var_213a0963 = [3:#"hash_631d14143bf8b26", 2:#"hash_301fd347a3614b8b", 1:#"hash_57b39f99758cac07"];
	clientfield::register("scriptmover", "deathcircleflag", 1, 1, "int", &function_a380fe5, 0, 0);
	clientfield::register("toplayer", "deathcircleeffects", 1, 2, "int", undefined, 0, 1);
	clientfield::register("allplayers", "outsidedeathcircle", 1, 1, "int", undefined, 0, 0);
	callback::on_localclient_connect(&on_localclient_connect);
	callback::on_localplayer_spawned(&on_localplayer_spawned);
	level.var_32e10fc2 = [];
}

/*
	Name: function_a380fe5
	Namespace: death_circle
	Checksum: 0xFBC8FF37
	Offset: 0x510
	Size: 0x424
	Parameters: 7
	Flags: Linked
*/
function function_a380fe5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self notify(#"hash_49f273cd81c6c0f");
	if(newval)
	{
		var_899562cf = self.team == #"neutral";
		var_929604bb = self.team != #"neutral";
		self setcompassicon("minimap_collapse_ring");
		self function_811196d1(0);
		self function_95bc465d(1);
		self function_5e00861(0, 1);
		self function_bc95cd57(var_899562cf);
		self function_60212003(var_929604bb);
		self thread function_a453467f(localclientnum);
		if(var_929604bb)
		{
			player = function_27673a7(localclientnum);
			if(isdefined(player) && isdefined(player.var_2cbc8a68))
			{
				player.var_2cbc8a68 function_5d482e78(#"hash_75168376918f5ab7");
				player.var_2cbc8a68 delete();
			}
			if(isdefined(self.var_2c8e49d2))
			{
				self.var_2c8e49d2 function_5d482e78(#"hash_75168376918f5ab7");
				self.var_2c8e49d2 delete();
			}
			self function_a5edb367(#"hash_4964cfaa74d2a1ac");
			self.var_2c8e49d2 = spawn(localclientnum, self.origin, "script_model");
			self.var_2c8e49d2 setmodel("p8_big_cylinder");
			self.var_2c8e49d2 function_bf9d3071(#"hash_75168376918f5ab7");
			self.var_2c8e49d2 linkto(self);
			self.var_29b256b0 = spawn(0, self.origin, "script_origin");
			self.var_29b256b0.handle = self.var_29b256b0 playloopsound(level.var_cb450873);
		}
		else
		{
			self function_a5edb367(#"none");
		}
	}
	else
	{
		self function_811196d1(1);
		self function_bc95cd57(0);
		if(isdefined(self.var_2c8e49d2))
		{
			self.var_2c8e49d2 function_5d482e78(#"hash_75168376918f5ab7");
			self.var_2c8e49d2 delete();
		}
		if(isdefined(self.var_29b256b0))
		{
			self.var_29b256b0 stoploopsound(self.var_29b256b0.handle);
			self.var_29b256b0 delete();
		}
	}
}

/*
	Name: on_localclient_connect
	Namespace: death_circle
	Checksum: 0x4C4858FE
	Offset: 0x940
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function on_localclient_connect(localclientnum)
{
	player = function_27673a7(localclientnum);
	if(isdefined(player))
	{
		player.var_2cbc8a68 = spawn(localclientnum, vectorscale((0, 0, -1), 10000), "script_model");
		player.var_2cbc8a68 function_bf9d3071(#"hash_75168376918f5ab7");
	}
	level thread function_382da026(localclientnum);
}

/*
	Name: on_localplayer_spawned
	Namespace: death_circle
	Checksum: 0xF2B3ED19
	Offset: 0x9F8
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function on_localplayer_spawned(localclientnum)
{
	if(self function_da43934d())
	{
		self thread function_7eb327bd(localclientnum);
	}
}

/*
	Name: function_382da026
	Namespace: death_circle
	Checksum: 0xAC922942
	Offset: 0xA40
	Size: 0x214
	Parameters: 1
	Flags: Linked, Private
*/
private function function_382da026(localclientnum)
{
	self notify("1368c9cad92ba095");
	self endon("1368c9cad92ba095");
	var_ef2f4cec = spawnstruct();
	level.var_32e10fc2[localclientnum] = var_ef2f4cec;
	while(true)
	{
		var_d017e788 = function_5c10bd79(localclientnum);
		if(!isdefined(var_d017e788))
		{
			waitframe(1);
			continue;
		}
		intensity = var_d017e788 clientfield::get_to_player("deathcircleeffects");
		if(var_ef2f4cec.var_e51324b5 !== intensity)
		{
			var_ef2f4cec notify(#"hash_b6468b7475f6790");
			var_ef2f4cec function_43d7470c(localclientnum, intensity);
			var_ef2f4cec function_d69170b(localclientnum, intensity);
			var_ef2f4cec function_b8c979ec(localclientnum, intensity);
			var_ef2f4cec thread function_7ede78e9(localclientnum, var_d017e788, intensity);
			level function_e1273acb(localclientnum, intensity);
			var_ef2f4cec.var_e51324b5 = intensity;
		}
		else if(intensity > 0)
		{
			var_ef2f4cec thread function_7ede78e9(localclientnum, var_d017e788, intensity);
			level function_e1273acb(localclientnum, intensity);
		}
		if(ispc())
		{
			level.var_d081e853 = intensity > 0;
		}
		waitframe(1);
	}
}

/*
	Name: function_7eb327bd
	Namespace: death_circle
	Checksum: 0x5A5294E9
	Offset: 0xC60
	Size: 0xD4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_7eb327bd(localclientnum)
{
	self waittill(#"death");
	var_ef2f4cec = level.var_32e10fc2[localclientnum];
	if(isdefined(var_ef2f4cec))
	{
		var_ef2f4cec notify(#"hash_b6468b7475f6790");
		var_ef2f4cec function_43d7470c(localclientnum);
		var_ef2f4cec function_d69170b(localclientnum);
		var_ef2f4cec function_b8c979ec(localclientnum);
		var_ef2f4cec thread function_7ede78e9(localclientnum);
	}
	level function_e1273acb(localclientnum);
}

/*
	Name: function_43d7470c
	Namespace: death_circle
	Checksum: 0xFFBC46D8
	Offset: 0xD40
	Size: 0x9A
	Parameters: 2
	Flags: Linked, Private
*/
private function function_43d7470c(localclientnum, intensity = 0)
{
	if(isdefined(self.var_ef215639))
	{
		function_d48752e(localclientnum, self.var_ef215639);
		self.var_ef215639 = undefined;
	}
	alias = level.var_ef215639[intensity];
	if(isdefined(alias))
	{
		self.var_ef215639 = function_604c9983(localclientnum, alias);
	}
}

/*
	Name: function_d69170b
	Namespace: death_circle
	Checksum: 0x89D3F980
	Offset: 0xDE8
	Size: 0xD2
	Parameters: 2
	Flags: Linked, Private
*/
private function function_d69170b(localclientnum, intensity = 0)
{
	if(isdefined(self.var_f6795a59))
	{
		function_24cd4cfb(localclientnum, self.var_f6795a59);
		self.var_f6795a59 = undefined;
	}
	postfx = level.var_f6795a59[intensity];
	if(isdefined(postfx))
	{
		if(function_148ccc79(localclientnum, postfx))
		{
			codestoppostfxbundlelocal(localclientnum, postfx);
		}
		function_a837926b(localclientnum, postfx);
		self.var_f6795a59 = postfx;
	}
}

/*
	Name: function_b8c979ec
	Namespace: death_circle
	Checksum: 0x25637B4F
	Offset: 0xEC8
	Size: 0xAA
	Parameters: 2
	Flags: Linked, Private
*/
private function function_b8c979ec(localclientnum, intensity = 0)
{
	if(isdefined(self.var_7e948a2d))
	{
		deletefx(localclientnum, self.var_7e948a2d, 1);
		self.var_7e948a2d = undefined;
	}
	var_1221e86b = level.var_7e948a2d[intensity];
	if(isdefined(var_1221e86b))
	{
		self.var_7e948a2d = playfxoncamera(localclientnum, var_1221e86b, (0, 0, 0), (1, 0, 0), (0, 0, 1));
	}
}

/*
	Name: function_7ede78e9
	Namespace: death_circle
	Checksum: 0x41A49C29
	Offset: 0xF80
	Size: 0x16A
	Parameters: 3
	Flags: Linked, Private
*/
private function function_7ede78e9(localclientnum, var_d017e788 = undefined, intensity = 0)
{
	self notify("7d26c6ac6cb4777b");
	self endon("7d26c6ac6cb4777b");
	self endon(#"hash_b6468b7475f6790");
	var_65837411 = level.var_601fc3c5[intensity];
	if(self.var_d017e788 === var_d017e788 && self.var_cfa7d2bf === var_65837411)
	{
		return;
	}
	if(isdefined(self.var_601fc3c5))
	{
		killfx(localclientnum, self.var_601fc3c5);
		self.var_601fc3c5 = undefined;
		self.var_d017e788 = undefined;
		self.var_cfa7d2bf = undefined;
	}
	if(isdefined(var_65837411) && isdefined(var_d017e788))
	{
		var_d017e788 util::waittill_dobj(localclientnum);
		if(isdefined(var_d017e788))
		{
			self.var_601fc3c5 = function_239993de(localclientnum, var_65837411, var_d017e788, "tag_origin");
			self.var_d017e788 = var_d017e788;
			self.var_cfa7d2bf = var_65837411;
		}
	}
}

/*
	Name: function_e1273acb
	Namespace: death_circle
	Checksum: 0xADC21798
	Offset: 0x10F8
	Size: 0x30E
	Parameters: 2
	Flags: Linked, Private
*/
private function function_e1273acb(localclientnum, intensity = 0)
{
	maxdistsq = 100000000;
	var_4a4e047 = 0;
	origin = getlocalclientpos(localclientnum);
	angles = getlocalclientangles(localclientnum);
	fwd = anglestoforward(angles);
	players = getplayers(localclientnum);
	players = arraysortclosest(players, origin);
	rob = level.var_c465fd31[intensity];
	var_ba26d3a3 = level.var_7d949aad[intensity];
	var_65837411 = level.var_213a0963[intensity];
	foreach(player in players)
	{
		if(!isdefined(player) || !player isplayer())
		{
			continue;
		}
		if(!player hasdobj(localclientnum))
		{
			continue;
		}
		if(var_4a4e047 >= 10 || player function_21c0fa55() || player clientfield::get("outsidedeathcircle") || !isalive(player) || distance2dsquared(origin, player.origin) > maxdistsq || vectordot(fwd, player.origin - origin) <= 0)
		{
			player function_de4523(localclientnum);
			player function_9e8e1f4f(localclientnum);
			continue;
		}
		player function_de4523(localclientnum, rob, var_ba26d3a3);
		player function_9e8e1f4f(localclientnum, var_65837411);
		var_4a4e047++;
	}
}

/*
	Name: function_de4523
	Namespace: death_circle
	Checksum: 0x8471F85E
	Offset: 0x1410
	Size: 0x126
	Parameters: 3
	Flags: Linked, Private
*/
private function function_de4523(localclientnum, rob = undefined, var_ba26d3a3 = undefined)
{
	if(self.var_eeee3972 === rob && self.var_99d5860e === var_ba26d3a3)
	{
		return;
	}
	if(isdefined(self.var_eeee3972) && self.var_eeee3972 !== rob)
	{
		self function_5d482e78(self.var_eeee3972);
		self.var_eeee3972 = undefined;
		self.var_99d5860e = undefined;
	}
	if(isdefined(rob))
	{
		if(!self function_d2503806(rob))
		{
			self function_bf9d3071(rob);
		}
		if(isdefined(var_ba26d3a3))
		{
			self function_78233d29(rob, "", "Fade", var_ba26d3a3);
		}
		self.var_eeee3972 = rob;
		self.var_99d5860e = var_ba26d3a3;
	}
}

/*
	Name: function_9e8e1f4f
	Namespace: death_circle
	Checksum: 0x4BACDF34
	Offset: 0x1540
	Size: 0x106
	Parameters: 2
	Flags: Linked, Private
*/
private function function_9e8e1f4f(localclientnum, var_65837411 = undefined)
{
	if(self.var_213a0963 === var_65837411)
	{
		return;
	}
	if(isdefined(self.var_99096337))
	{
		foreach(fxhandle in self.var_99096337)
		{
			killfx(localclientnum, fxhandle);
		}
		self.var_213a0963 = undefined;
		self.var_99096337 = undefined;
	}
	if(isdefined(var_65837411))
	{
		self.var_99096337 = playtagfxset(localclientnum, var_65837411, self);
		self.var_213a0963 = var_65837411;
	}
}

/*
	Name: function_63d6411e
	Namespace: death_circle
	Checksum: 0x44D3F0D0
	Offset: 0x1650
	Size: 0x24
	Parameters: 0
	Flags: Private
*/
private function function_63d6411e()
{
	self setcompassicon("");
}

/*
	Name: function_32f7227c
	Namespace: death_circle
	Checksum: 0xC123715C
	Offset: 0x1680
	Size: 0x152
	Parameters: 3
	Flags: Linked, Private
*/
private function function_32f7227c(deathcircle, currentradius, localclientnum)
{
	localplayer = function_5c10bd79(localclientnum);
	startpos = (deathcircle.origin[0], deathcircle.origin[1], 0);
	var_fc612cde = (0, 0, 0);
	eyepos = startpos + vectorscale((0, 0, 1), 60);
	if(isdefined(localplayer))
	{
		endpos = (localplayer.origin[0], localplayer.origin[1], 0);
		var_fc612cde = vectornormalize(endpos - startpos) * currentradius;
		eyepos = localplayer geteyeapprox();
	}
	var_ba5c9ce6 = deathcircle.origin + var_fc612cde;
	return (var_ba5c9ce6[0], var_ba5c9ce6[1], eyepos[2]);
}

/*
	Name: function_a453467f
	Namespace: death_circle
	Checksum: 0xD04ED0EA
	Offset: 0x17E0
	Size: 0x18E
	Parameters: 1
	Flags: Linked, Private
*/
private function function_a453467f(localclientnum)
{
	self endon(#"death", #"hash_49f273cd81c6c0f");
	self thread function_71f8d788();
	while(isdefined(self.scale))
	{
		radius = 15000 * self.scale;
		if(isdefined(self.var_2c8e49d2))
		{
			if(!self.var_2c8e49d2 function_d2503806(#"hash_75168376918f5ab7"))
			{
				self.var_2c8e49d2 function_bf9d3071(#"hash_75168376918f5ab7");
			}
			modelscale = radius / 150000;
			self.var_2c8e49d2 function_78233d29(#"hash_75168376918f5ab7", "", "Scale", modelscale);
			if(isdefined(self.var_29b256b0))
			{
				self.var_29b256b0.origin = function_32f7227c(self, radius, localclientnum);
			}
		}
		var_70aac56d = radius * 2;
		self function_5e00861(var_70aac56d, 1);
		waitframe(1);
	}
}

/*
	Name: function_71f8d788
	Namespace: death_circle
	Checksum: 0xC70AC44
	Offset: 0x1978
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_71f8d788()
{
	self endon(#"hash_49f273cd81c6c0f");
	self waittill(#"death");
	if(isdefined(self.var_2c8e49d2))
	{
		self.var_2c8e49d2 function_5d482e78(#"hash_75168376918f5ab7");
		self.var_2c8e49d2 delete();
	}
}

