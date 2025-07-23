//—————————— Boot / close control ——————————
function OnAosoraDefaultSaveData
{
	Save.Data.TalkInterval = 180;
	Save.Data.FarApart = 0;
	Save.Data.Reinstalls = 0;
	Save.Data.Vanishing = 0;
	Save.Data.SakuraBalloonColor = "3";
	Save.Data.KeroBalloonColor = "6";
	Save.Data.CurrentAiGraph = 0;
	Save.Data.DebugMode = 0;
}

function OnAosoraLoad
{
	TalkTimer.RandomTalk = OnAITalk;
	TalkTimer.RandomTalkIntervalSeconds = Save.Data.TalkInterval;
	TalkTimer.NadenadeTalk = OnStroked;
	TalkTimer.NadenadeMoveThreshold = 50; //Unsure if I need to specify this or if 50 is the default when unspecified, but...
	TalkBuilder.Default.AutoLineBreak = "\n\w8";
	TalkBuilder.Default.ScopeChangeLineBreak = "\n\n";
	TalkBuilder.Default.Head = ""; //For now, this ghost requires this to be blank...
	LastTalk = "";
}

function OnFirstBoot
{
	Save.Data.Vanishing = 0;
	Save.Data.Reinstalls = Shiori.Reference[0];
	local output = "";
	
	if (Shiori.Reference[0] >= 2)
	{
		if (Save.Data.TalkInterval == 0) Save.Data.TalkInterval = 180; //If talking was disabled, make it not that anymore (because you can't access the menu in this mode)
		output += "\0\![bind,Hide,Hide,1]";
		output += "\1\![bind,Hide,Hide,1]";
		output += OnPromptTalk();
	}
	else
	{
		output += "\0\s[0]\1\s[10]";
		
		if (Shiori.Reference[0] == 1) output += FirstBoot_2();
		else output += FirstBoot_1();
	}
	
	return output;
}

function OnVanishSelected
{
	Save.Data.Vanishing = 1;
	local output = "";
	
	if (Save.Data.Reinstalls > 0) output += "\t\*" + Vanish_2();
	else output += Vanish_1();
	
	return output += "\_w[3000]";
}

function OnVanishButtonHold
{
	Save.Data.Vanishing = 0;
	return "\0\s[0]\![set,alpha,100]\1\s[10]\![set,alpha,100]" + Vanish_Cancel();
}

function OnBoot
{
	if (Save.Data.Vanishing == 1 || Save.Data.Reinstalls >= 2)
	{
		return "\t\![raise,OnFirstBoot,{Save.Data.Reinstalls.ToNumber() + 1}]";
	}
	
	local output = "{GetCoords}\0\s[0]\1\s[10]";
	if (FarApart()) output += BootApartTalk();
	else output += BootTalk();
	return output;
}

//This one doesn't work like the others because you can't just jump to another event outside of OnClose, if you do, SSP will force itself to quit if you chose to completely close SSP, and probably in some other instances as well. However! You can certainly use embed tags to evaluate which dialogue to pick on the fly... :3c
function OnClose
{
	if (Save.Data.Reinstalls >= 2) return "\-";
	
	local output = "{GetCoords}\![embed,OnClosePick]";
	
	output += "\w8\w8\w8\-";
	return output;
}

function OnClosePick
{
	local output = "\0\s[0]\1\s[10]";
	
	if (FarApart() != Save.Data.FarApart) //Mismatch means the state must have changed
	{
		if (FarApart()) output += Reflection.Get("ApartTransitionTalk")();
		else output += Reflection.Get("TogetherTransitionTalk")();
		
		Save.Data.FarApart = FarApart();
	}
	else if (FarApart()) output += CloseApartTalk();
	else output += CloseTalk();
	
	return output;
}


//—————————— Randomtalk control ——————————
function OnPromptTalk
{
	LastTalk = TalkTimer.CallRandomTalk();
	return LastTalk;
}

function OnAITalk
{
	return "{GetCoords}\![raise,OnSendTalk]";
}

function OnSendTalk
{
	//Surface calls go *here* because if you put them in the talk builder then they bend to the whims of the talk builder
	LastTalk = "\0\s[0]\1\s[10]";
	
	if (Save.Data.Reinstalls >= 2)
	{
		LastTalk += "\t\*" + Reflection.Get("FinalTalk")() + "\_w[5000]\![vanishbymyself]";
	}
	else if (FarApart() != Save.Data.FarApart) //Mismatch means the state must have changed
	{
		if (FarApart()) LastTalk += Reflection.Get("ApartTransitionTalk")();
		else LastTalk += Reflection.Get("TogetherTransitionTalk")();
		
		Save.Data.FarApart = FarApart();
	}
	else if (FarApart()) LastTalk += Reflection.Get("ApartTalk")();
	else LastTalk += Reflection.Get("RandomTalk")();
	
	return LastTalk;
}

function OnLastTalk
{
	return LastTalk;
}


//—————————— Petting control ——————————
function OnStroked
{
	return "{GetCoords}\![raise,OnSendStroked,,,,{Shiori.Reference[3]}]";
}

function OnSendStroked
{
	local which = "Sakura";
	if (Shiori.Reference[3] == 1) which = "Kero";
	
	if (FarApart() != Save.Data.FarApart) //Mismatch means the state must have changed
	{
		local output = "";
		
		if (FarApart()) output += Reflection.Get("ApartTransition{which}")();
		else output += Reflection.Get("TogetherTransition{which}")();
		
		Save.Data.FarApart = FarApart();
		return output;
	}
	else
	{
		if (FarApart()) return Reflection.Get("{which}ApartStroked")();
		else return Reflection.Get("{which}Stroked")();
	}
}


//—————————— Other mouse control ——————————
function OnMouseDoubleClick
{
	if (Save.Data.Vanishing == 1) return OnVanishButtonHold;
	else return "{GetCoords}\![raise,OnSendMouseDoubleClick,,,,{Shiori.Reference[3]}]";
}

function OnSendMouseDoubleClick
{
	if (Shiori.Reference[3] == 1) return OnKeroMenu;
	else return OnSakuraMenu;
}

function OnMouseDragEnd
{
	local output = "{GetCoords}";
	if (BalloonIsOpen()) output = "\C" + output;
	
	return output;
}