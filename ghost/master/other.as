//—————————— Misc SHIORI events ——————————
function OnTranslate
{
	local talkstr = Shiori.Reference[0]; //I REMEMBERED THIS TIME
	
	//Autopause for all your autopause needs
	if (!talkstr.Contains("\![no-autopause]"))
	{
		/*
		//Ellipsis are surprisingly tricky
		talkstr = talkstr.Replace("......?",".\w4.\w4.\w4.\w4.\w4.\w4?\w8\w8");
		talkstr = talkstr.Replace("......!",".\w4.\w4.\w4.\w4.\w4.\w4!\w8\w8");
		//i THINK just the two below will be ok... because if there is a question mark or exclamation mark on the end, they ONLY need pauses if the scope switches or linebreaks are added. And those are both covered by other things -- update they are not lol
		//These break the autopause rule of requiring a space after... hum.
		//TODO do we need interrobang, because this does not account for interrobang + ellipses. need a better solution...
		talkstr = talkstr.Replace("......",".\w4.\w4.\w4.\w4.\w4.\w8\w8"); //this wont work for space then more text
		talkstr = talkstr.Replace("...?",".\w4.\w4.\w4?\w8\w8");
		talkstr = talkstr.Replace("...!",".\w4.\w4.\w4!\w8\w8");
		talkstr = talkstr.Replace("...",".\w4.\w4.\w8\w8");
		*/
		
		talkstr = talkstr.Replace(". ",".\w8\w8 ");
		talkstr = talkstr.Replace(", ",",\w4 ");
		talkstr = talkstr.Replace("? ","?\w8\w8 ");
		talkstr = talkstr.Replace("! ","!\w8\w8 ");
		talkstr = talkstr.Replace(": ",":\w8 ");
		talkstr = talkstr.Replace("; ",";\w8 ");
		
		//First scope change... kind of a bandaid patch, hoping for a better solution later
		//No mid-dialogue punctuation needed here, only sentence enders
		talkstr = talkstr.Replace(".\1",".\w8\w8\1");
		talkstr = talkstr.Replace("?\1","?\w8\w8\1");
		talkstr = talkstr.Replace("!\1","!\w8\w8\1");
		
		talkstr = talkstr.Replace(".\0",".\w8\w8\0");
		talkstr = talkstr.Replace("?\0","?\w8\w8\0");
		talkstr = talkstr.Replace("!\0","!\w8\w8\0");
	}
	
	if (DefaultBalloon())
	{
		talkstr = talkstr.Replace("\0\b[0]","\0\b[{SakuraBalloonColor}0]");
		talkstr = talkstr.Replace("\0\b[2]","\0\b[{SakuraBalloonColor}2]");
		talkstr = talkstr.Replace("\0\b[4]","\0\b[{SakuraBalloonColor}4]");
		talkstr = talkstr.Replace("\0\b[6]","\0\b[{SakuraBalloonColor}6]");
		
		talkstr = talkstr.Replace("\1\b[0]","\1\b[{KeroBalloonColor}0]");
		talkstr = talkstr.Replace("\1\b[2]","\1\b[{KeroBalloonColor}2]");
		talkstr = talkstr.Replace("\1\b[4]","\1\b[{KeroBalloonColor}4]");
		talkstr = talkstr.Replace("\1\b[6]","\1\b[{KeroBalloonColor}6]");
	}
	else
	{
		talkstr = talkstr.Replace("\b[4]","\b[4,--fallback=2]");
		talkstr = talkstr.Replace("\b[6]","\b[6,--fallback=0]");
	}
	
	return talkstr;
}

function OnKeyPress
{
	if (Shiori.Reference[0] == "f1") return "\![open,readme]";
	else if (Shiori.Reference[0] == "t") return OnPromptTalk;
	else if (Shiori.Reference[0] == "r") return OnLastTalk;
}

function OnSurfaceRestore
{
	return "{GetCoords}\0\s[0]\![set,alpha,100]\1\s[10]\![set,alpha,100]";
}


//—————————— Update related ——————————
function homeurl
{
	return "https://raw.githubusercontent.com/Zichqec/ye_olde_cursed_tower/main/";
}

function ghostver
{
	return "v1.0.0";
}


//—————————— Right click menu ——————————
function sakura@recommendsites
{
	return FormatLinks([
		{name: "Galla", url: "https://gallathegalla.github.io/gtg-ghosts/"},
		{name: "Pommy", url: "https://www.youtube.com/@pommy_the_mimic"},
		{name: "Zichqec", url: "https://ukagaka.zichqec.com/"},
	]);
}

function sakura@portalsites
{
	return FormatLinks([
		{name: "Leave a Review", url: "https://docs.google.com/forms/d/e/1FAIpQLSdQvI9uWCeT3mD_bUcpIpgN25om1LZYinhkwJxCkrTo203_Cg/viewform"},
	]);
}

function FormatLinks(links)
{
	local output = "";
	for (i = 0; i < links.length; i++)
	{
		//Name then 0x01, URL then 0x02
		output += links[i].name + (1).ToAscii();
		output += links[i].url + (2).ToAscii();
	}
	return output;
}

//—————————— State checks (which are also just shortcuts but shhh) ——————————
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

function OnNotifySelfInfo
{
	Save.Data.BalloonName = Shiori.Reference[5];
}

function OnBalloonChange
{
	Save.Data.BalloonName = Shiori.Reference[0];
}

function OnNotifyDressupInfo
{
	/*
	[0] character ID
	[1] category name
	[2] part name
	[3] option
	[4] on-1/off-0
	[5] thumbnail path
	*/
	CurrentSakuraItem = [];
	CurrentKeroItem = [];
	AvailableDressups = [];
	for (local i = 0; i < Shiori.Reference.length; i++)
	{
		local dressup = Shiori.Reference[i];
		local byte1 = (1).ToAscii();
		dressup = dressup.Split(byte1);
		
		if (dressup[1] == "Hide") continue;
		
		if (dressup[4] == "1")
		{
			if (dressup[0] == "1") CurrentKeroItem = dressup[2].Split(" ");
			else CurrentSakuraItem = dressup[2].Split(" ");
		}
		if (dressup[0] == "0") AvailableDressups.Add(dressup[2]);
	}
}


//—————————— Shortcuts ——————————
function emdash
{
	return "\f[name,calibri]—\f[name,default]";
}

function SakuraBalloonColor
{
	return Save.Data.SakuraBalloonColor;
}

function KeroBalloonColor
{
	return Save.Data.KeroBalloonColor;
}

function DefaultBalloon
{
	return Save.Data.BalloonName == "Ye Olde Soul Spell";
}

function whiteout
{
	return "\i[10000000]";
}

function redout
{
	return "\i[10000100]";
}

function fadeout
{
	local output = "";
	for (local i = 100; i >= 0; i--)
	{
		output += "\0\![set,alpha,{i}]\1\![set,alpha,{i}]\_w[30]";
	}
	return output;
}

function br
{
	if (DefaultBalloon()) return " \c[char,1]\n";
	else return " ";
}

function getaistate
{
	local Points = [
		{name: "RandomTalk", val: RandomTalk.length},
		{name: "ApartTalk", val: ApartTalk.length},
		{name: "FinalTalk", val: FinalTalk.length},
		{name: "SakuraStroked", val: SakuraStroked.length},
		{name: "SakuraApartStroked", val: SakuraApartStroked.length},
		{name: "KeroStroked", val: KeroStroked.length},
		{name: "KeroApartStroked", val: KeroApartStroked.length},
		{name: "ToTransitionTalk", val: TogetherTransitionTalk.length},
		{name: "ToTransitionSakura", val: TogetherTransitionSakura.length},
		{name: "ToTransitionKero", val: TogetherTransitionKero.length},
		{name: "ApTransitionTalk", val: ApartTransitionTalk.length},
		{name: "ApTransitionSakura", val: ApartTransitionSakura.length},
		{name: "ApTransitionKero", val: ApartTransitionKero.length},
	];
	
	local labels = "";
	local values = "";
	
	for (local i = 0; i < Points.length; i++)
	{
		if (values != "") values += ","; //there might be a better method in aosora but i'm not sure
		values += Points[i].val;
		
		if (labels != "") labels += ",";
		labels += Points[i].name;
	}
	
	return values + "{(1).ToAscii}" + labels;	
}