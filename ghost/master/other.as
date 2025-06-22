function OnTranslate
{
	local talkstr = Shiori.Reference[0]; //I REMEMBERED THIS TIME
	
	//Autopause for all your autopause needs
	if (!talkstr.Contains("\![no-autopause]"))
	{
		talkstr = talkstr.Replace(". ",".\w8\w8 ");
		talkstr = talkstr.Replace(", ",",\w4 ");
		talkstr = talkstr.Replace("? ","?\w8\w8 ");
		talkstr = talkstr.Replace("! ","!\w8\w8 ");
		talkstr = talkstr.Replace(": ",":\w8 ");
		talkstr = talkstr.Replace("; ",";\w8 ");
	}
	
	return talkstr;
}