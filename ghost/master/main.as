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
	//TalkBuilder.Default.AutoLineBreak = "";
	TalkBuilder.Default.Head = "\0\b[0]";
	LastTalk = "";
}

function OnBoot
{
	local output = "";
	output += GetCoords();
	if (FarApart()) output += BootApartTalk();
	else output += BootTalk();
	return output;
}

function OnClose
{
	local output = "";
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
	if (FarApart())
	{
		LastTalk = Reflection.Get("ApartTalk")();
	}
	else
	{
		LastTalk = Reflection.Get("RandomTalk")();
	}
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
		return KeroStroked;
	}
	else
	{
		return SakuraStroked;
	}
}

function OnMouseDoubleClick
{
	if (Shiori.Reference[3] == 1)
	{
		return OnKeroMenu;
	}
	else
	{
		return OnSakuraMenu;
	}
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