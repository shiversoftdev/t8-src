// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.gsc;

#namespace name;

/*
	Name: setup
	Namespace: name
	Checksum: 0x7155CABA
	Offset: 0x5D0
	Size: 0x7C
	Parameters: 0
	Flags: None
*/
function setup()
{
	/#
		assert(!isdefined(level.names));
	#/
	level.names = [];
	level.namesindex = [];
	if(!isdefined(level.script))
	{
		level.script = util::get_map_name();
	}
	initialize_nationality("american");
}

/*
	Name: initialize_nationality
	Namespace: name
	Checksum: 0x5B079F80
	Offset: 0x658
	Size: 0x8A
	Parameters: 1
	Flags: Linked
*/
function initialize_nationality(str_nationality)
{
	if(!isdefined(level.names[str_nationality]))
	{
		level.names[str_nationality] = [];
		if(str_nationality != "civilian")
		{
			add_nationality_names(str_nationality);
		}
		randomize_name_list(str_nationality);
		level.nameindex[str_nationality] = 0;
	}
}

/*
	Name: add_nationality_names
	Namespace: name
	Checksum: 0x40550F6E
	Offset: 0x6F0
	Size: 0x82
	Parameters: 1
	Flags: Linked
*/
function add_nationality_names(str_nationality)
{
	switch(str_nationality)
	{
		case "american":
		{
			american_names();
			break;
		}
		default:
		{
			/#
				assertmsg("" + str_nationality);
			#/
			break;
		}
	}
}

/*
	Name: american_names
	Namespace: name
	Checksum: 0x5574083B
	Offset: 0x780
	Size: 0xC84
	Parameters: 0
	Flags: Linked
*/
function american_names()
{
	add_name("american", "Adams");
	add_name("american", "Alexander");
	add_name("american", "Allen");
	add_name("american", "Anderson");
	add_name("american", "Bailey");
	add_name("american", "Baker");
	add_name("american", "Barnes");
	add_name("american", "Bell");
	add_name("american", "Bennett");
	add_name("american", "Brooks");
	add_name("american", "Brown");
	add_name("american", "Bryant");
	add_name("american", "Butler");
	add_name("american", "Campbell");
	add_name("american", "Carter");
	add_name("american", "Clark");
	add_name("american", "Coleman");
	add_name("american", "Collins");
	add_name("american", "Cook");
	add_name("american", "Cooper");
	add_name("american", "Cox");
	add_name("american", "Davis");
	add_name("american", "Diaz");
	add_name("american", "Edwards");
	add_name("american", "Evans");
	add_name("american", "Flores");
	add_name("american", "Foster");
	add_name("american", "Garcia");
	add_name("american", "Gonzales");
	add_name("american", "Gonzalez");
	add_name("american", "Gray");
	add_name("american", "Green");
	add_name("american", "Griffin");
	add_name("american", "Hall");
	add_name("american", "Harris");
	add_name("american", "Hayes");
	add_name("american", "Henderson");
	add_name("american", "Hernandez");
	add_name("american", "Hill");
	add_name("american", "Howard");
	add_name("american", "Hughes");
	add_name("american", "Jackson");
	add_name("american", "James");
	add_name("american", "Jenkins");
	add_name("american", "Johnson");
	add_name("american", "Jones");
	add_name("american", "Kelly");
	add_name("american", "King");
	add_name("american", "Lee");
	add_name("american", "Lewis");
	add_name("american", "Long");
	add_name("american", "Lopez");
	add_name("american", "Martin");
	add_name("american", "Martinez");
	add_name("american", "Miller");
	add_name("american", "Mitchell");
	add_name("american", "Moore");
	add_name("american", "Morgan");
	add_name("american", "Morris");
	add_name("american", "Murphy");
	add_name("american", "Nelson");
	add_name("american", "Parker");
	add_name("american", "Patterson");
	add_name("american", "Perez");
	add_name("american", "Perry");
	add_name("american", "Peterson");
	add_name("american", "Phillips");
	add_name("american", "Powell");
	add_name("american", "Price");
	add_name("american", "Ramirez");
	add_name("american", "Reed");
	add_name("american", "Richardson");
	add_name("american", "Rivera");
	add_name("american", "Roberts");
	add_name("american", "Robinson");
	add_name("american", "Rodriguez");
	add_name("american", "Rogers");
	add_name("american", "Ross");
	add_name("american", "Russell");
	add_name("american", "Sanchez");
	add_name("american", "Sanders");
	add_name("american", "Scott");
	add_name("american", "Simmons");
	add_name("american", "Smith");
	add_name("american", "Stewart");
	add_name("american", "Taylor");
	add_name("american", "Thomas");
	add_name("american", "Thompson");
	add_name("american", "Torres");
	add_name("american", "Turner");
	add_name("american", "Walker");
	add_name("american", "Ward");
	add_name("american", "Washington");
	add_name("american", "Watson");
	add_name("american", "White");
	add_name("american", "Williams");
	add_name("american", "Wilson");
	add_name("american", "Wood");
	add_name("american", "Wright");
	add_name("american", "Young");
}

/*
	Name: add_name
	Namespace: name
	Checksum: 0x1BFE7482
	Offset: 0x1410
	Size: 0x40
	Parameters: 2
	Flags: Linked
*/
function add_name(nationality, thename)
{
	level.names[nationality][level.names[nationality].size] = thename;
}

/*
	Name: randomize_name_list
	Namespace: name
	Checksum: 0xC527F55
	Offset: 0x1458
	Size: 0xDA
	Parameters: 1
	Flags: Linked
*/
function randomize_name_list(nationality)
{
	size = level.names[nationality].size;
	for(i = 0; i < size; i++)
	{
		switchwith = randomint(size);
		temp = level.names[nationality][i];
		level.names[nationality][i] = level.names[nationality][switchwith];
		level.names[nationality][switchwith] = temp;
	}
}

/*
	Name: get
	Namespace: name
	Checksum: 0xED9A1A37
	Offset: 0x1540
	Size: 0x336
	Parameters: 1
	Flags: Linked
*/
function get(override)
{
	if(!isdefined(override) && level.script == "credits")
	{
		self.airank = "private";
		self notify(#"set name and rank");
		return;
	}
	if(isdefined(self.script_friendname))
	{
		if(self.script_friendname == "none")
		{
			self.propername = "";
		}
		else
		{
			self.propername = self.script_friendname;
			getrankfromname(self.propername);
		}
		self notify(#"set name and rank");
		return;
	}
	/#
		assert(isdefined(level.names));
	#/
	str_classname = self get_ai_classname();
	str_nationality = "american";
	if(issubstr(str_classname, "_civilian_"))
	{
		self.airank = "none";
		str_nationality = "civilian";
	}
	else
	{
		if(self is_special_agent_member(str_classname))
		{
			str_nationality = "agent";
		}
		else
		{
			if(issubstr(str_classname, "_sco_"))
			{
				self.airank = "none";
				str_nationality = "chinese";
			}
			else
			{
				if(issubstr(str_classname, "_egypt_"))
				{
					str_nationality = "egyptian";
				}
				else
				{
					if(self is_police_member(str_classname))
					{
						str_nationality = "police";
					}
					else
					{
						if(self is_seal_member(str_classname))
						{
							str_nationality = "seal";
						}
						else
						{
							if(self is_navy_member(str_classname))
							{
								str_nationality = "navy";
							}
							else
							{
								if(self is_security_member(str_classname))
								{
									str_nationality = "security";
								}
								else
								{
									if(issubstr(str_classname, "_soviet_"))
									{
										self.airank = "none";
										str_nationality = "russian";
									}
									else if(issubstr(str_classname, "_ally_sing_"))
									{
										str_nationality = "singapore_police";
									}
								}
							}
						}
					}
				}
			}
		}
	}
	initialize_nationality(str_nationality);
	get_name_for_nationality(str_nationality);
	self notify(#"set name and rank");
}

/*
	Name: get_ai_classname
	Namespace: name
	Checksum: 0x6C5D8B7D
	Offset: 0x1880
	Size: 0x5A
	Parameters: 0
	Flags: Linked
*/
function get_ai_classname()
{
	if(isdefined(self.dr_ai_classname))
	{
		str_classname = tolower(self.dr_ai_classname);
	}
	else
	{
		str_classname = tolower(self.classname);
	}
	return str_classname;
}

/*
	Name: add_override_name_func
	Namespace: name
	Checksum: 0x598B6235
	Offset: 0x18E8
	Size: 0x7A
	Parameters: 2
	Flags: None
*/
function add_override_name_func(nationality, func)
{
	if(!isdefined(level._override_name_funcs))
	{
		level._override_name_funcs = [];
	}
	/#
		assert(!isdefined(level._override_name_funcs[nationality]), "");
	#/
	level._override_name_funcs[nationality] = func;
}

/*
	Name: get_name_for_nationality
	Namespace: name
	Checksum: 0x4EF5214B
	Offset: 0x1970
	Size: 0x41A
	Parameters: 1
	Flags: Linked
*/
function get_name_for_nationality(nationality)
{
	/#
		assert(isdefined(level.nameindex[nationality]), nationality);
	#/
	if(isdefined(level._override_name_funcs) && isdefined(level._override_name_funcs[nationality]))
	{
		self.propername = [[level._override_name_funcs[nationality]]]();
		self.airank = "";
		return;
	}
	if(nationality == "civilian")
	{
		self.propername = "";
		return;
	}
	level.nameindex[nationality] = (level.nameindex[nationality] + 1) % level.names[nationality].size;
	lastname = level.names[nationality][level.nameindex[nationality]];
	if(!isdefined(lastname))
	{
		lastname = "";
	}
	if(isdefined(level._override_rank_func))
	{
		self [[level._override_rank_func]](lastname);
	}
	else
	{
		if(isdefined(self.airank) && self.airank == "none")
		{
			self.propername = lastname;
			return;
		}
		rank = randomint(100);
		if(nationality == "seal")
		{
			if(rank > 20)
			{
				fullname = "PO " + lastname;
				self.airank = "petty officer";
			}
			else
			{
				if(rank > 10)
				{
					fullname = "CPO " + lastname;
					self.airank = "chief petty officer";
				}
				else
				{
					fullname = "Lt. " + lastname;
					self.airank = "lieutenant";
				}
			}
		}
		else
		{
			if(nationality == "navy")
			{
				if(rank > 60)
				{
					fullname = "SN " + lastname;
					self.airank = "seaman";
				}
				else
				{
					if(rank > 20)
					{
						fullname = "PO " + lastname;
						self.airank = "petty officer";
					}
					else
					{
						fullname = "CPO " + lastname;
						self.airank = "chief petty officer";
					}
				}
			}
			else
			{
				if(nationality == "police")
				{
					fullname = "Officer " + lastname;
					self.airank = "police officer";
				}
				else
				{
					if(nationality == "agent")
					{
						fullname = "Agent " + lastname;
						self.airank = "special agent";
					}
					else
					{
						if(nationality == "security")
						{
							fullname = "Officer " + lastname;
						}
						else
						{
							if(nationality == "singapore_police")
							{
								fullname = "Officer " + lastname;
								self.airank = "police officer";
							}
							else
							{
								if(rank > 20)
								{
									fullname = "Pvt. " + lastname;
									self.airank = "private";
								}
								else
								{
									if(rank > 10)
									{
										fullname = "Cpl. " + lastname;
										self.airank = "corporal";
									}
									else
									{
										fullname = "Sgt. " + lastname;
										self.airank = "sergeant";
									}
								}
							}
						}
					}
				}
			}
		}
		self.propername = fullname;
	}
}

/*
	Name: is_seal_member
	Namespace: name
	Checksum: 0xA0FE90B1
	Offset: 0x1D98
	Size: 0x3A
	Parameters: 1
	Flags: Linked
*/
function is_seal_member(str_classname)
{
	if(issubstr(str_classname, "_seal_"))
	{
		return true;
	}
	return false;
}

/*
	Name: is_navy_member
	Namespace: name
	Checksum: 0x6DDA507F
	Offset: 0x1DE0
	Size: 0x3A
	Parameters: 1
	Flags: Linked
*/
function is_navy_member(str_classname)
{
	if(issubstr(str_classname, "_navy_"))
	{
		return true;
	}
	return false;
}

/*
	Name: is_police_member
	Namespace: name
	Checksum: 0xDFED4C51
	Offset: 0x1E28
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function is_police_member(str_classname)
{
	if(issubstr(str_classname, "_lapd_") || issubstr(str_classname, "_swat_"))
	{
		return true;
	}
	return false;
}

/*
	Name: is_security_member
	Namespace: name
	Checksum: 0x24FBFA23
	Offset: 0x1E90
	Size: 0x36
	Parameters: 1
	Flags: Linked
*/
function is_security_member(str_classname)
{
	if(issubstr(str_classname, "_security_"))
	{
		return true;
	}
	return false;
}

/*
	Name: is_special_agent_member
	Namespace: name
	Checksum: 0x333F70A2
	Offset: 0x1ED0
	Size: 0x3A
	Parameters: 1
	Flags: Linked
*/
function is_special_agent_member(str_classname)
{
	if(issubstr(str_classname, "_sstactical_"))
	{
		return true;
	}
	return false;
}

/*
	Name: getrankfromname
	Namespace: name
	Checksum: 0x810092EE
	Offset: 0x1F18
	Size: 0x1B2
	Parameters: 1
	Flags: Linked
*/
function getrankfromname(name)
{
	if(!isdefined(name))
	{
		self.airank = "private";
	}
	tokens = strtok(name, " ");
	/#
		assert(tokens.size);
	#/
	shortrank = tokens[0];
	switch(shortrank)
	{
		case "pvt.":
		{
			self.airank = "private";
			break;
		}
		case "hash_5827a20dd30caea2":
		{
			self.airank = "private";
			break;
		}
		case "cpl.":
		{
			self.airank = "corporal";
			break;
		}
		case "sgt.":
		{
			self.airank = "sergeant";
			break;
		}
		case "lt.":
		{
			self.airank = "lieutenant";
			break;
		}
		case "hash_21327d909449a828":
		{
			self.airank = "captain";
			break;
		}
		default:
		{
			/#
				println(("" + shortrank) + "");
			#/
			self.airank = "private";
			break;
		}
	}
}

/*
	Name: issubstr_match_any
	Namespace: name
	Checksum: 0x5FF6E8C3
	Offset: 0x20D8
	Size: 0xBA
	Parameters: 2
	Flags: None
*/
function issubstr_match_any(str_match, str_search_array)
{
	/#
		assert(str_search_array.size, "");
	#/
	foreach(str_search in str_search_array)
	{
		if(issubstr(str_match, str_search))
		{
			return true;
		}
	}
	return false;
}

