//———————————————————— Sakura menu ————————————————————
function OnSakuraMenu
{
	local output = "";
	
	output += "\0\b[2]\s[0]\![set,autoscroll,disable]\f[anchorvisitedfontcolor,default.anchor]\![quicksection,true]\![no-autopause]";
	
	output += "\![*]\__q[OnPromptTalk]Speak!\__q  \![*]";
	
	if (LastTalk == "") output += "\f[color,disable]Repeat!\f[color,default]";
	else output += "\__q[OnLastTalk]Repeat!\__q";
	
	output += "\n\n";
	
	if (Save.Data.BalloonName == "Ye Olde Soul Spell")
	{
		output += "\![*]\__q[OnBalloonColorMenu,0]Spell choice\__q";
		output += "\n\n";
	}
	
	local talkrates = TalkRates();
	if (Save.Data.BalloonName == "Ye Olde Soul Spell") output += "Talk rate:      ";
	else output += "Talk rate:  ";
	
	if (Save.Data.TalkInterval == 0) output += "\f[underline,true]\_a[OnChangeTalkInterval,0]Silence!\_a\f[underline,default]";
	else output += "\__q[OnChangeTalkInterval,0]Silence!\__q";
	
	output += "\n";
	for (local i = 1; i < talkrates.length; i++)
	{
		if (talkrates[i].time == Save.Data.TalkInterval) output += "\f[underline,true]\_a[OnChangeTalkInterval,{talkrates[i].time}]{talkrates[i].label}\_a\f[underline,default]";
		else output += "\__q[OnChangeTalkInterval,{talkrates[i].time}]{talkrates[i].label}\__q";
		
		if (Save.Data.BalloonName == "Ye Olde Soul Spell") output += " ";
		else output += "  ";
	}
	
	output += "\n\n";
	
	output += "\![*]\__q[blank]As you were!\__q";
	
	return output;
}

function OnBalloonColorMenu
{
	local colors = [
		{number: "0", label: "Plasma"},
		{number: "1", label: "Spectral Scream"},
		{number: "2", label: "Lotus Storm"},
		{number: "3", label: "Sanguine Rain"},
		{number: "4", label: "Fireball"},
		{number: "5", label: "Sun Strike"},
		{number: "6", label: "Chlorophyll Burst"},
		{number: "7", label: "Frost"},
		{number: "8", label: "Ethereal Mist"},
		{number: "9", label: "Abyssal Reach"},
		{number: "10", label: "Nebula Bolt"},
		{number: "11", label: "Chromatic Pulse"},
	];
	
	local output = "";
	if (Shiori.Reference[0] == 1)
	{
		output += "\1\![lock,balloonrepaint]\c\0";
		output += "\1\b[4]\s[10]";
	}
	else //0
	{
		output += "\C\0\![lock,balloonrepaint]\c\0";
		output += "\0\b[4]\s[0]";
	}
	output += "\![quicksection,true]\![set,autoscroll,disable]\![no-autopause]\f[anchorvisitedfontcolor,default.anchor]";
	
	if (Shiori.Reference[0] == 1)
	{
		output += "\f[align,center]{emdash} Spell choice {emdash}\n\f[align,left]";
		for (local i = 0; i < colors.length; i++)
		{
			if (Save.Data.KeroBalloonColor == colors[i].number)
			{
				output += "\![*]\_a[OnBalloonColorChange,1,{colors[i].number}]{colors[i].label}\_a\n";
			}
			else
			{
				output += "\![*]\__q[OnBalloonColorChange,1,{colors[i].number}]{colors[i].label}\__q\n";
			}
		}
		output += "\n";
		output += "\![*]\__q[OnBalloonColorChange,1,{Random.GetIndex(0,colors.length)}]Random\__q";
		output += "\n\n";
		output += "\![*]\__q[OnKeroMenu]Back\__q  \![*]\__q[blank]Close\__q";
		output += "\1\![unlock,balloonrepaint]";
	}
	else
	{
		output += "\f[align,center]{emdash} Spell choice {emdash}\n\f[align,left]";
		for (local i = 0; i < colors.length; i++)
		{
			if (Save.Data.SakuraBalloonColor == colors[i].number)
			{
				output += "\![*]\_a[OnBalloonColorChange,0,{colors[i].number}]{colors[i].label}\_a\n";
			}
			else
			{
				output += "\![*]\__q[OnBalloonColorChange,0,{colors[i].number}]{colors[i].label}\__q\n";
			}
		}
		output += "\n";
		output += "\![*]\__q[OnBalloonColorChange,0,{Random.GetIndex(0,colors.length)}]Random\__q";
		output += "\n\n";
		output += "\![*]\__q[OnSakuraMenu]Back\__q  \![*]\__q[blank]Close\__q";
		output += "\0\![unlock,balloonrepaint]";
	}
	
	return output;
}

function OnBalloonColorChange
{
	if (Shiori.Reference[0] == 1)
	{
		Save.Data.KeroBalloonColor = Shiori.Reference[1];
	}
	else //0
	{
		Save.Data.SakuraBalloonColor = Shiori.Reference[1];
	}
	return "\![raise,OnBalloonColorMenu,{Shiori.Reference[0]}]";
}

function TalkRates
{
	return [
		{time: 0, label: "Silence!"},
		{time: 60, label: "1m"},
		{time: 180, label: "3m"},
		{time: 300, label: "5m"},
		{time: 600, label: "10m"},
		{time: 900, label: "15m"},
	];
}

function OnChangeTalkInterval
{
	Save.Data.TalkInterval = Shiori.Reference[0];
	TalkTimer.RandomTalkIntervalSeconds = Shiori.Reference[0];
	TalkTimer.RandomTalkElapsedSeconds = 0;
	
	return OnSakuraMenu;
}

//———————————————————— Kero menu ————————————————————
function OnKeroMenu
{
	local output = "";
	output += "\1\b[2]\![set,autoscroll,disable]\f[anchorvisitedfontcolor,default.anchor]\![quicksection,true]\![no-autopause]";
	
	if (Save.Data.BalloonName == "Ye Olde Soul Spell")
	{
		output += "\![*]\__q[OnBalloonColorMenu,1]Spell choice\__q";
		output += "\n\n";
	}
	
	// if (FarApart()) output += "Lonely sad :(";
	// else output += "Friendship :)";
	
	// output += "\n\n";
	
	// output += "Sakura X: {Save.Data.SakuraCoords.x}\n";
	// output += "Sakura Y: {Save.Data.SakuraCoords.y}\n\n";
	// output += "Kero X: {Save.Data.KeroCoords.x}\n";
	// output += "Kero Y: {Save.Data.KeroCoords.y}\n\n";
	
	output += "\![*]\__q[blank]As you were!\__q";
	return output;
}