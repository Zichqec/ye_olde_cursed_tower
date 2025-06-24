function OnAosoraDefaultSaveData
{
	Save.Data.TalkInterval = 180;
}

function OnAosoraLoad
{
	TalkTimer.RandomTalk = OnAITalk;
	TalkTimer.RandomTalkIntervalSeconds = Save.Data.TalkInterval;
	TalkTimer.NadenadeTalk = OnStroked;
	TalkTimer.NadenadeMoveThreshold = 50; //Unsure if I need to specify this or if 50 is the default when unspecified, but...
	TalkBuilder.Default.AutoLineBreak = "\n\w8";
	TalkBuilder.Default.ScopeChangeLineBreak = "\n\n\w8\w8";
	TalkBuilder.Default.Head = ""; //If this isn't empty, talk blocks start with \0 and therefore if you try to start with \1 then you get awkward linebreaks...
	LastTalk = "";
}

function OnBoot
{
	local output = "\0\s[0]\1\s[10]";
	output += GetCoords();
	if (FarApart()) output += BootApartTalk();
	else output += BootTalk();
	return output;
}

function OnClose
{
	local output = "\0\s[0]\1\s[10]";
	output += GetCoords();
	if (FarApart()) output += CloseApartTalk();
	else output += CloseTalk();
	output += "\w8\w8\w8\-";
	return output;
}

function OnPromptTalk
{
	LastTalk = TalkTimer.CallRandomTalk();
	return LastTalk;
}

function OnAITalk
{
	//Surface calls go _here_ because if you put them in the talk builder then they bend to the whims of the talk builder
	LastTalk = "\0\s[0]\1\s[10]";
	if (FarApart()) LastTalk += Reflection.Get("ApartTalk")();
	else LastTalk += Reflection.Get("RandomTalk")();
	return LastTalk;
}

function OnLastTalk
{
	return LastTalk;
}

function OnStroked
{
	if (Shiori.Reference[3] == 1)
	{
		if (FarApart()) return KeroApartStroked;
		else return KeroStroked;
	}
	else
	{
		if (FarApart()) return SakuraApartStroked;
		else return SakuraStroked;
		return SakuraStroked;
	}
}

function OnMouseDoubleClick
{
	if (Shiori.Reference[3] == 1) return OnKeroMenu;
	else return OnSakuraMenu;
}

function OnKeyPress
{
	if (Shiori.Reference[0] == "f1") return "\![open,readme]";
	else if (Shiori.Reference[0] == "t") return OnPromptTalk;
	else if (Shiori.Reference[0] == "r") return OnLastTalk;
}

function OnMouseDragEnd
{
	local output = "";
	if (BalloonIsOpen()) output += "\C";
	output += "{GetCoords}";
	return output;
}

function GetCoords
{
	return "\![get,property,OnGetCoords,currentghost.scope(0).x,currentghost.scope(0).y,currentghost.scope(1).x,currentghost.scope(1).y]";
}

function OnGetCoords
{
	Save.Data.SakuraCoords = {x: Shiori.Reference[0].ToNumber(), y: Shiori.Reference[1].ToNumber()};
	Save.Data.KeroCoords = {x: Shiori.Reference[2].ToNumber(), y: Shiori.Reference[3].ToNumber()};
}

function FarApart
{
	local maxdistance = 500; //px
	
	local xdiff = Save.Data.SakuraCoords.x - Save.Data.KeroCoords.x;
	local ydiff = Save.Data.SakuraCoords.y - Save.Data.KeroCoords.y;
	
	if (xdiff < 0) xdiff *= -1;
	if (ydiff < 0) ydiff *= -1;
	
	if (xdiff > maxdistance || ydiff > maxdistance) return 1;
	else return 0;
}

function BalloonIsOpen
{
	local status = Shiori.Headers.Status.ToString();
	if (status.Contains("balloon") || status.Contains("choosing")) return 1;
	else return 0;
}

function OnSurfaceRestore
{
	return "\0\s[0]\1\s[10]";
}