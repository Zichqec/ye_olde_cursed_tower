//I could make some of these talk blocks... but I kind of don't want to mix talk blocks and function blocks too much? I'll think about it...

//—————————————————————————————— Installing something ——————————————————————————————
//https://ukagakadreamteam.github.io/ukadoc/manual/list_shiori_event.html#OnInstallBegin

function OnInstallComplete
{
	local output = "";
	
	output += "\0\![set,serikotalk,false]Installed {Shiori.Reference[1]} ({Shiori.Reference[0]}).";
	
	//A little menu to open or change to the ghost that was installed immediately
	if (Shiori.Reference[0].Contains("ghost"))
	{
		output += "\n\n\_q";
		output += "\![*]\__q[OnInstallComplete@Action,call]Call {Shiori.Reference[1]}\__q  \![*]\__q[OnInstallComplete@Action,change]Change to {Shiori.Reference[1]}\__q\n\n";
		output += "\![*]\__q[blank]Done\__q";
	}
	
	return output;
}

function OnInstallComplete@Action
{
	return `\!["{Shiori.Reference[0]}",ghost,lastinstalled]`;
}

function OnInstallFailure
{
	local reason = Shiori.Reference[0];
	
	if (Shiori.Reference[0] == "unlha32") reason = "could not load the dll to decompress lzh files";
	else if (Shiori.Reference[0] == "extraction") reason = "failed to decompress the file";
	else if (Shiori.Reference[0] == "invalid type") reason = "the install.txt is incorrect";
	else if (Shiori.Reference[0] == "unsupported") reason = "the archive is not supported";
	else if (Shiori.Reference[0] == "password") reason = "incorrect password";
	else if (Shiori.Reference[0] == "artificial") reason = "canceled by user";
	
	return "\0\![set,serikotalk,false]Could not complete installation: {reason}.";
}


//—————————————————————————————— Creating a .nar file ——————————————————————————————
//https://ukagakadreamteam.github.io/ukadoc/manual/list_shiori_event.html#OnNarCreating

function OnNarCreated
{
	//Makes a clickable link that'll open the location of the file they just made
	local nar = `\_a[OnNarLocation,"{Shiori.Reference[1]}"]{Shiori.Reference[0]}\_a`;
	
	return "\0\![set,serikotalk,false]Successfully created {nar}.";
}

function OnNarLocation
{
	return `\![open,explorer,"{Shiori.Reference[0]}"]`;
}


//—————————————————————————————— Network Update ——————————————————————————————
//https://ukagakadreamteam.github.io/ukadoc/manual/list_shiori_event.html#OnUpdateBegin

function OnUpdateBegin
{
	return "\0\![set,serikotalk,false]Checking for updates.\w8";
}

//reference0 is the number of new files, starting from 0
function OnUpdateReady
{
	//Number of files starts from 0, so this displays the correct amount
	local newfiles = Shiori.Reference[0];
	newfiles = newfiles.ToNumber();
	newfiles += 1;
	
	//plural checks, adds an s and changes is to are if there's more than 1 file
	local s = ""; local are = "is";
	if (newfiles != 1) { s = "s"; are = "are"; }
	
	return "\0\![set,serikotalk,false]There {are} {newfiles} new file{s}.\w8";
}

//When the update finishes. Don't forget to initialize any new variables you've created! I highly highly recommend using OnInitialize for this, in case the user updates via the ghost explorer or some other means.
//reference0 is 'none' if there were no new files to update with
function OnUpdateComplete
{
	if (Shiori.Reference[0] == "none")
	{
		return "\0\![set,serikotalk,false]There are no new files.";
	}
	else
	{
		return "\0\![set,serikotalk,false]Update complete.";
	}
}

function OnUpdateFailure
{
	local reason = Shiori.Reference[0];
	
	if (Shiori.Reference[0] == "timeout") reason = "connection timed out";
	else if (Shiori.Reference[0] == "md5 miss") reason = "MD5 error on file {Shiori.Reference[1]}\n\nPlease contact the ghost author for assistance";
	else if (Shiori.Reference[0] == "artificial") reason = "canceled by user";
	
	return "\0\![set,serikotalk,false]Could not update: {reason}.";
}

//—————————————————————————————— SNTP (clock fixing) ——————————————————————————————
//https://ukagakadreamteam.github.io/ukadoc/manual/list_shiori_event.html#OnSNTPBegin

function OnSNTPCompare
{
	local output = "";
	if (Shiori.Reference[3] != 0)
	{
		local s = "";
		if (Shiori.Reference[3] != 1) { s = "s"; }
		
		output += "\0\![set,serikotalk,false]The clock is off by {Shiori.Reference[3]} second{s}.\n\n";
		
		output += "\![*]\q[Fix it,script:\6]  \![*]\q[Leave it,blank]";
	}
	else
	{
		output += "\0\![set,serikotalk,false]The clock is accurate.";
	}
	
	return output;
}

function OnSNTPCorrect
{
	return "\0\![set,serikotalk,false]The clock has been corrected.";
}

function OnSNTPFailure
{
	return "\0\![set,serikotalk,false]Could not correct the clock.";
}


//—————————————————————————————— BIFF (Email check) ———————————————————————————————
//https://ukagakadreamteam.github.io/ukadoc/manual/list_shiori_event.html#OnBIFFBegin

function OnBIFFFailure
{
	local reason = Shiori.Reference[0];
	
	if (Shiori.Reference[0] == "timeout") reason = "connection timed out";
	else if (Shiori.Reference[0] == "kick") reason = "can't access account";
	else if (Shiori.Reference[0] == "defect") reason = "POP settings incorrect";
	else if (Shiori.Reference[0] == "artificial") reason = "canceled by user";

	return "\0\![set,serikotalk,false]Could not get emails: {reason}.";
}


//———————————————————————————————— Headlines/RSS ——————————————————————————————————
//https://ukagakadreamteam.github.io/ukadoc/manual/list_shiori_event.html#OnHeadlinesenseBegin

function OnHeadlinesenseFailure
{
	local reason = Shiori.Reference[0];
	
	if (Shiori.Reference[0] == "can't download") reason = "can't download the file";
	else if (Shiori.Reference[0] == "can't analyze") reason = "can't analyze the file";

	return "\0\![set,serikotalk,false]Could not get RSS: {reason}.";
}