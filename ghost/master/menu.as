//———————————————————— Sakura menu ————————————————————
function OnSakuraMenu
{
	local output = "";
	
	output += "\0\b[2]\s[0]\![set,autoscroll,disable]\f[anchorvisitedfontcolor,default.anchor]\![quicksection,true]\![no-autopause]";
	
	output += "\![*]\__q[OnPromptTalk]Speak!\__q  \![*]";
	
	if (LastTalk == "") output += "\f[color,disable]Repeat!\f[color,default]";
	else output += "\__q[OnLastTalk]Repeat!\__q";
	output += "\n\n";
	
	output += "\![*]\__q[OnItemMenu,0]Soul transfer\__q";
	output += "\n\n";
	
	if (DefaultBalloon())
	{
		output += "\![*]\__q[OnBalloonColorMenu,0]Spell choice\__q";
		output += "\n\n";
	}
	
	local talkrates = TalkRates();
	if (DefaultBalloon()) output += "Talk rate:      ";
	else output += "Talk rate:  ";
	
	if (Save.Data.TalkInterval == 0) output += "\f[underline,true]\_a[OnChangeTalkInterval,0]Silence!\_a\f[underline,default]";
	else output += "\__q[OnChangeTalkInterval,0]Silence!\__q";
	
	output += "\n";
	for (local i = 1; i < talkrates.length; i++)
	{
		if (talkrates[i].time == Save.Data.TalkInterval) output += "\f[underline,true]\_a[OnChangeTalkInterval,{talkrates[i].time}]{talkrates[i].label}\_a\f[underline,default]";
		else output += "\__q[OnChangeTalkInterval,{talkrates[i].time}]{talkrates[i].label}\__q";
		
		if (DefaultBalloon()) output += " ";
		else output += "  ";
	}
	
	output += "\n\n";
	
	output += "\![*]\__q[blank]As you were!\__q";
	
	return output;
}

function OnItemMenu
{
	local items = [
		{type: "Gem", positions: ["Lean_left","Lean_right", "Side"], colors: ["Red","Purple"]},
		{type: "Pot", positions: ["Upright", "Spilled"], colors: ["Brown","Gray"]},
		{type: "Bottle", positions: ["Upright", "Toppled"], colors: ["Green","Red"]},
	];
	
	local CharacterItem = [];
	if (Shiori.Reference[0] == "1") CharacterItem = CurrentKeroItem;
	else CharacterItem = CurrentSakuraItem;
	local scope = Shiori.Reference[0]; //I should check if this is empty buuuuuuut we'll pretend it never will be! -- It seems to be working fine for references...?
	
	local output = "";
	output += "\C\{scope}\![lock,balloonrepaint]\c";
	output += "\{scope}\b[4]\s[0]";
	output += "\![quicksection,true]\![set,autoscroll,disable]\![no-autopause]\f[anchorvisitedfontcolor,default.anchor]";
	output += "\f[align,center]{emdash} Soul transfer {emdash}\n\f[align,left]";
	
	
	local currentitem = {};
	output += "Item:\n";
	for (local i = 0; i < items.length; i++)
	{
		local item = items[i];
		local tag = "[OnItemChange,{scope},{item.type} {item.positions[0]} {item.colors[0]}]{item.type}";
		if (item.type == CharacterItem[0])
		{
			output += "\_a{tag}\_a  ";
			currentitem = item;
		}
		else output += "\__q{tag}\__q  ";
	}
	output += "\c[char,2]";
	output += "\n\n";
	
	output += "Position:\n";
	for (local i = 0; i < currentitem.positions.length; i++)
	{
		local tag = "[OnItemChange,{scope},{CharacterItem[0]} {currentitem.positions[i]} {CharacterItem[2]}]{currentitem.positions[i].Replace('_',' ')}";
		if (currentitem.positions[i] == CharacterItem[1]) output += "\_a{tag}\_a  ";
		else output += "\__q{tag}\__q  ";
		if (DefaultBalloon() && i == 1) output += "\n"; //Bandaid patch for word wrap awkwardness...
	}
	output += "\c[char,2]\n\n";
	
	//Bandaid patch because the above patch makes for awkwardness with buttons jumping around...
	if (DefaultBalloon() && CharacterItem[0] != "Gem") output += "\n";
	
	output += "Color:\n";
	for (local i = 0; i < currentitem.colors.length; i++)
	{
		local tag = "[OnItemChange,{scope},{CharacterItem[0]} {CharacterItem[1]} {currentitem.colors[i]}]{currentitem.colors[i]}";
		if (currentitem.colors[i] == CharacterItem[2]) output += "\_a{tag}\_a  ";
		else output += "\__q{tag}\__q  ";
	}
	output += "\c[char,2]\n\n";
	
	output += "\![*]\__q[OnItemChange,{scope},{CharacterItem[0]} {CharacterItem[1]} {CharacterItem[2]},random]Random\__q";
	output += "\n\n";
	
	if (Shiori.Reference[0] == "1") output += "\![*]\__q[OnKeroMenu]Back\__q";
	else output += "\![*]\__q[OnSakuraMenu]Back\__q";
	
	output += "  \![*]\__q[blank]Close\__q";
	output += "\![unlock,balloonrepaint]";
	
	return output;
}

function OnItemChange
{
	local pick = Shiori.Reference[1];
	
	//I am not sure if I need to check for null here... it seems to be handling it, at least for the references...?
	if (Shiori.Reference[2] == "random")
	{
		while (pick == Shiori.Reference[1]) pick = Random.Select(AvailableDressups); //don't pick same item
	}
	
	return "\C\![lock,balloonrepaint]\![set,autoscroll,disable]\{Shiori.Reference[0]}\![bind,Item,{pick},1]\_w[1]\![raise,OnItemMenu,{Shiori.Reference[0]}]";
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
	
	local scope = {num: "0", name: "Sakura", surface: "0"};
	local CurrentBalloonColor = Save.Data.SakuraBalloonColor;
	if (Shiori.Reference[0] == 1)
	{
		scope = {num: "1", name: "Kero", surface: "10"}; //TODO i think probably we should normalize this to just surface0...
		CurrentBalloonColor = Save.Data.KeroBalloonColor;
	}
	
	local output = "";
	output += "\C\{scope.num}\![lock,balloonrepaint]\c";
	output += "\{scope.num}\b[4]\s[{scope.surface}]";
	
	output += "\![quicksection,true]\![set,autoscroll,disable]\![no-autopause]\f[anchorvisitedfontcolor,default.anchor]";
	
	output += "\f[align,center]{emdash} Spell choice {emdash}\n\f[align,left]";
	for (local i = 0; i < colors.length; i++)
	{
		local tag = "[OnBalloonColorChange,{scope.num},{colors[i].number}]{colors[i].label}";
		
		if (CurrentBalloonColor == colors[i].number) output += "\![*]\_a{tag}\_a\n";
		else output += "\![*]\__q{tag}\__q\n";
	}
	output += "\n";
	output += "\![*]\__q[OnBalloonColorChange,{scope.num},{CurrentBalloonColor},random]Random\__q";
	output += "\n\n";
	output += "\![*]\__q[On{scope.name}Menu]Back\__q  \![*]\__q[blank]Close\__q";
	output += "\![unlock,balloonrepaint]";
	
	return output;
}

function OnBalloonColorChange
{
	local pick = Shiori.Reference[1];
	
	//I am not sure if I need to check for null here... it seems to be handling it, at least for the references...?
	if (Shiori.Reference[2] == "random")
	{
		while (pick == Shiori.Reference[1]) pick = Random.GetIndex(0,12); //don't pick same color
	}
	
	if (Shiori.Reference[0] == 1) Save.Data.KeroBalloonColor = pick;
	else Save.Data.SakuraBalloonColor = pick;
	
	return "\C\![raise,OnBalloonColorMenu,{Shiori.Reference[0]}]";
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
	output += "\1\b[0]\s[10]\![set,autoscroll,disable]\f[anchorvisitedfontcolor,default.anchor]\![quicksection,true]\![no-autopause]";
	
	output += "\![*]\__q[OnItemMenu,1]Soul transfer\__q";
	output += "\n\n";
	
	if (DefaultBalloon())
	{
		output += "\![*]\__q[OnBalloonColorMenu,1]Spell choice\__q";
		output += "\n\n";
	}
	
	output += "\![*]\__q[blank]As you were!\__q";
	
	return output;
}