// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace throttle;

/*
	Name: _updatethrottlethread
	Namespace: throttle
	Checksum: 0x2C744361
	Offset: 0x68
	Size: 0x34
	Parameters: 1
	Flags: Linked, Private
*/
private function _updatethrottlethread(throttle)
{
	while(isdefined(throttle))
	{
		[[ throttle ]]->_updatethrottle();
		wait(throttle.updaterate_);
	}
}

/*
	Name: __constructor
	Namespace: throttle
	Checksum: 0xCF965234
	Offset: 0xA8
	Size: 0x66
	Parameters: 0
	Flags: Linked, 8
*/
function __constructor()
{
	self.queue_ = [];
	self.processed_ = 0;
	self.processlimit_ = 1;
	self.var_3cd6b18f = [];
	self.updaterate_ = float(function_60d95f53()) / 1000;
}

/*
	Name: __destructor
	Namespace: throttle
	Checksum: 0x80F724D1
	Offset: 0x118
	Size: 0x4
	Parameters: 0
	Flags: Linked, 16
*/
function __destructor()
{
}

/*
	Name: _updatethrottle
	Namespace: throttle
	Checksum: 0x6910F927
	Offset: 0x128
	Size: 0x132
	Parameters: 0
	Flags: Linked, Private
*/
private function _updatethrottle()
{
	self.processed_ = 0;
	currentqueue = self.queue_;
	self.queue_ = [];
	foreach(item in currentqueue)
	{
		if(!isdefined(item))
		{
			continue;
		}
		foreach(var_fe3b6341 in self.var_3cd6b18f)
		{
			if(item === var_fe3b6341)
			{
				self.queue_[self.queue_.size] = item;
				break;
			}
		}
	}
	self.var_3cd6b18f = [];
}

/*
	Name: initialize
	Namespace: throttle
	Checksum: 0xADAC57EE
	Offset: 0x268
	Size: 0x94
	Parameters: 2
	Flags: Linked
*/
function initialize(processlimit = 1, updaterate = float(function_60d95f53()) / 1000)
{
	self.processlimit_ = processlimit;
	self.updaterate_ = updaterate;
	self thread _updatethrottlethread(self);
}

/*
	Name: waitinqueue
	Namespace: throttle
	Checksum: 0x2D25EE26
	Offset: 0x308
	Size: 0x154
	Parameters: 1
	Flags: Linked
*/
function waitinqueue(entity = randomint(2147483647))
{
	if(self.processed_ >= self.processlimit_)
	{
		nextqueueindex = (self.queue_.size > 0 ? getlastarraykey(self.queue_) + 1 : 0);
		self.queue_[nextqueueindex] = entity;
		firstinqueue = 0;
		while(!firstinqueue)
		{
			if(!isdefined(entity))
			{
				return;
			}
			firstqueueindex = getfirstarraykey(self.queue_);
			if(self.processed_ < self.processlimit_ && self.queue_[firstqueueindex] === entity)
			{
				firstinqueue = 1;
				self.queue_[firstqueueindex] = undefined;
			}
			else
			{
				self.var_3cd6b18f[self.var_3cd6b18f.size] = entity;
				wait(self.updaterate_);
			}
		}
	}
	self.processed_++;
}

/*
	Name: function_18b95af8
	Namespace: throttle
	Checksum: 0xBA410401
	Offset: 0x468
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function function_18b95af8(entity)
{
	return isinarray(self.queue_, entity);
}

/*
	Name: function_5ef47bb4
	Namespace: throttle
	Checksum: 0x269F96D9
	Offset: 0x498
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_5ef47bb4(entity)
{
	arrayremovevalue(self.queue_, entity);
}

/*
	Name: throttle
	Namespace: throttle
	Checksum: 0x10964EDD
	Offset: 0x4C8
	Size: 0x1A6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function throttle()
{
	classes.throttle[0] = spawnstruct();
	classes.throttle[0].__vtable[1593080756] = &function_5ef47bb4;
	classes.throttle[0].__vtable[414800632] = &function_18b95af8;
	classes.throttle[0].__vtable[1800262167] = &waitinqueue;
	classes.throttle[0].__vtable[1128083910] = &initialize;
	classes.throttle[0].__vtable[2058390100] = &_updatethrottle;
	classes.throttle[0].__vtable[913321084] = &__destructor;
	classes.throttle[0].__vtable[674154906] = &__constructor;
	classes.throttle[0].__vtable[1015204362] = &_updatethrottlethread;
}

