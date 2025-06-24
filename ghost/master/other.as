function OnTranslate
{
	local talkstr = Shiori.Reference[0]; //I REMEMBERED THIS TIME
	
	//Autopause for all your autopause needs
	if (!talkstr.Contains("\![no-autopause]"))
	{
		talkstr = talkstr.Replace("......?",".\w4.\w4.\w4.\w4.\w4.\w4?\w8\w8");
		talkstr = talkstr.Replace("......!",".\w4.\w4.\w4.\w4.\w4.\w4!\w8\w8");
		//i THINK just the two below will be ok... because if there is a question mark or exclamation mark on the end, they ONLY need pauses if the scope switches or linebreaks are added. And those are both covered by other things -- update they are not lol
		//These break the autopause rule of requiring a space after... hum.
		//TODO do we need interrobang, because this does not account for interrobang + ellipses. need a better solution...
		talkstr = talkstr.Replace("......",".\w4.\w4.\w4.\w4.\w4.\w8\w8"); //this wont work for space then more text
		talkstr = talkstr.Replace("...?",".\w4.\w4.\w4?\w8\w8");
		talkstr = talkstr.Replace("...!",".\w4.\w4.\w4!\w8\w8");
		talkstr = talkstr.Replace("...",".\w4.\w4.\w8\w8");
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
	
	if (Save.Data.BalloonName == "Ye Olde Soul Spell")
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

function OnNotifySelfInfo
{
	Save.Data.BalloonName = Shiori.Reference[5];
}

function OnBalloonChange
{
	Save.Data.BalloonName = Shiori.Reference[0];
}

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