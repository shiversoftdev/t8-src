// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_27ba6748d83412fd;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_99a6629b;

/*
	Name: init
	Namespace: namespace_99a6629b
	Checksum: 0x8159A84
	Offset: 0xF8
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function init()
{
	clientfield::register("scriptmover", "clone_control", 24000, 1, "int", &function_f747c7cd, 0, 0);
	clientfield::register("toplayer", "hide_player_legs", 24000, 1, "int", &function_a0c1af51, 0, 0);
	clientfield::register("toplayer", "blur_post_fx", 24000, 1, "int", &play_blur_post_fx, 0, 1);
}

/*
	Name: function_f747c7cd
	Namespace: namespace_99a6629b
	Checksum: 0xEBF78BC8
	Offset: 0x1E0
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_f747c7cd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(self.owner == function_5c10bd79(localclientnum))
		{
			self thread function_97adc67(localclientnum);
		}
	}
}

/*
	Name: function_97adc67
	Namespace: namespace_99a6629b
	Checksum: 0x91795FB3
	Offset: 0x260
	Size: 0x172
	Parameters: 1
	Flags: Linked, Private
*/
private function function_97adc67(localclientnum)
{
	self endon(#"death", #"entityshutdown");
	util::waittill_dobj(localclientnum);
	if(!isdefined(self))
	{
		return;
	}
	while(true)
	{
		if(self clientfield::get("clone_control"))
		{
			players = getlocalplayers();
			foreach(player in players)
			{
				if(isthirdperson(localclientnum))
				{
					self show();
					player hide();
					continue;
				}
				player show();
				self hide();
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_a0c1af51
	Namespace: namespace_99a6629b
	Checksum: 0x54D80EAC
	Offset: 0x3E0
	Size: 0x94
	Parameters: 7
	Flags: Linked, Private
*/
private function function_a0c1af51(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::waittill_dobj(localclientnum);
	if(!isdefined(self))
	{
		return;
	}
	if(newval)
	{
		self hideviewlegs();
	}
	else
	{
		self showviewlegs();
	}
}

/*
	Name: play_blur_post_fx
	Namespace: namespace_99a6629b
	Checksum: 0x281EF3A3
	Offset: 0x480
	Size: 0x154
	Parameters: 7
	Flags: Linked
*/
function play_blur_post_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval === 1)
	{
		if(!self postfx::function_556665f2("pstfx_speedblur"))
		{
			self postfx::playpostfxbundle("pstfx_speedblur");
		}
		self postfx::function_c8b5f318("pstfx_speedblur", #"blur", 0.05);
		self postfx::function_c8b5f318("pstfx_speedblur", #"hash_77259d33b3998de9", 0.3);
		self postfx::function_c8b5f318("pstfx_speedblur", #"hash_1a3ba6e8a0732aac", 0.8);
	}
	else if(self postfx::function_556665f2("pstfx_speedblur"))
	{
		self postfx::stoppostfxbundle("pstfx_speedblur");
	}
}

