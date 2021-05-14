// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace postfx;

/*
	Name: function_89f2df9
	Namespace: postfx
	Checksum: 0x98D999B0
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"postfx_bundle", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: postfx
	Checksum: 0xABB1AC02
	Offset: 0xE0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_localplayer_spawned(&localplayer_postfx_bundle_init);
}

/*
	Name: localplayer_postfx_bundle_init
	Namespace: postfx
	Checksum: 0x9ADC05D7
	Offset: 0x110
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function localplayer_postfx_bundle_init(localclientnum)
{
	if(isdefined(self.postfxbundelsinited))
	{
		return;
	}
	self.postfxbundelsinited = 1;
	self.playingpostfxbundle = "";
	self.forcestoppostfxbundle = 0;
	self.exitpostfxbundle = 0;
	/#
		self thread postfxbundledebuglisten();
		self thread function_764eb053();
	#/
}

/*
	Name: postfxbundledebuglisten
	Namespace: postfx
	Checksum: 0xE6E58548
	Offset: 0x198
	Size: 0x210
	Parameters: 0
	Flags: None
*/
function postfxbundledebuglisten()
{
	/#
		self endon(#"death");
		setdvar(#"scr_play_postfx_bundle", "");
		setdvar(#"scr_stop_postfx_bundle", "");
		setdvar(#"scr_exit_postfx_bundle", "");
		while(true)
		{
			playbundlename = getdvarstring(#"scr_play_postfx_bundle");
			if(playbundlename != "")
			{
				self thread playpostfxbundle(playbundlename);
				setdvar(#"scr_play_postfx_bundle", "");
			}
			stopbundlename = getdvarstring(#"scr_stop_postfx_bundle");
			if(stopbundlename != "")
			{
				self thread stoppostfxbundle(stopbundlename);
				setdvar(#"scr_stop_postfx_bundle", "");
			}
			var_38ce085 = getdvarstring(#"scr_exit_postfx_bundle");
			if(var_38ce085 != "")
			{
				self thread exitpostfxbundle(var_38ce085);
				setdvar(#"scr_exit_postfx_bundle", "");
			}
			wait(0.5);
		}
	#/
}

/*
	Name: function_764eb053
	Namespace: postfx
	Checksum: 0xE217F00A
	Offset: 0x3B0
	Size: 0x2B6
	Parameters: 0
	Flags: None
*/
function function_764eb053()
{
	/#
		self endon(#"death");
		var_986c8888 = 0;
		var_4828f60f = 0;
		var_e0f0fb1d = "";
		ent = undefined;
		while(true)
		{
			showmodel = getdvarint(#"hash_56d8c90edb7a97b6", 0);
			showviewmodel = getdvarint(#"hash_65c459b02d95c9c9", 0);
			newspawn = 0;
			if(showmodel != var_986c8888)
			{
				if(showmodel > 0)
				{
					if(!isdefined(ent))
					{
						newspawn = 1;
						ent = util::spawn_model(self.localclientnum, "");
					}
				}
				else if(var_986c8888 > 0)
				{
					if(isdefined(ent))
					{
						ent delete();
						ent = undefined;
					}
				}
				var_986c8888 = showmodel;
			}
			if(newspawn || showmodel == 1 && isdefined(ent))
			{
				ent.origin = self.origin + vectorscale((0, 0, 1), 70) + anglestoforward(self.angles) * 250;
			}
			bundlename = getdvarstring(#"hash_3e6eca38278b4ff6", "");
			if(bundlename != var_e0f0fb1d && isdefined(ent))
			{
				ent function_5d482e78(var_e0f0fb1d);
				if(bundlename != "")
				{
					ent function_bf9d3071(bundlename);
				}
			}
			if(showviewmodel && (showviewmodel != var_4828f60f || bundlename != var_e0f0fb1d))
			{
				self function_5d482e78(var_e0f0fb1d);
				if(bundlename != "")
				{
					self function_bf9d3071(bundlename);
				}
			}
			var_e0f0fb1d = bundlename;
			var_4828f60f = showviewmodel;
			waitframe(1);
		}
	#/
}

/*
	Name: playpostfxbundle
	Namespace: postfx
	Checksum: 0x11135E94
	Offset: 0x670
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function playpostfxbundle(playbundlename)
{
	self thread watchentityshutdown(playbundlename);
	self codeplaypostfxbundle(playbundlename);
}

/*
	Name: watchentityshutdown
	Namespace: postfx
	Checksum: 0xE6C4F3E2
	Offset: 0x6B8
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function watchentityshutdown(playbundlename)
{
	self notify("6433c543b3eba711" + playbundlename);
	self endon("6433c543b3eba711" + playbundlename);
	localclientnum = self.localclientnum;
	self waittill(#"death", #"finished_playing_postfx_bundle");
	codestoppostfxbundlelocal(localclientnum, playbundlename);
}

/*
	Name: stoppostfxbundle
	Namespace: postfx
	Checksum: 0x973925D3
	Offset: 0x748
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function stoppostfxbundle(bundlename)
{
	self codestoppostfxbundle(bundlename);
}

/*
	Name: function_c8b5f318
	Namespace: postfx
	Checksum: 0xC2F6C9B8
	Offset: 0x778
	Size: 0x3C
	Parameters: 3
	Flags: Linked
*/
function function_c8b5f318(bundlename, constname, constvalue)
{
	self function_116b95e5(bundlename, constname, constvalue);
}

/*
	Name: function_556665f2
	Namespace: postfx
	Checksum: 0x501C8811
	Offset: 0x7C0
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function function_556665f2(bundlename)
{
	return self function_d2cb869e(bundlename);
}

/*
	Name: exitpostfxbundle
	Namespace: postfx
	Checksum: 0xB03CE68D
	Offset: 0x7F0
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function exitpostfxbundle(bundlename)
{
	self function_3f145588(bundlename);
}

/*
	Name: setfrontendstreamingoverlay
	Namespace: postfx
	Checksum: 0x437F0FBA
	Offset: 0x820
	Size: 0x11C
	Parameters: 3
	Flags: Linked
*/
function setfrontendstreamingoverlay(localclientnum, system, enabled)
{
	if(!isdefined(self.overlayclients))
	{
		self.overlayclients = [];
	}
	if(!isdefined(self.overlayclients[localclientnum]))
	{
		self.overlayclients[localclientnum] = [];
	}
	self.overlayclients[localclientnum][system] = enabled;
	foreach(en in self.overlayclients[localclientnum])
	{
		if(en)
		{
			enablefrontendstreamingoverlay(localclientnum, 1);
			return;
		}
	}
	enablefrontendstreamingoverlay(localclientnum, 0);
}

