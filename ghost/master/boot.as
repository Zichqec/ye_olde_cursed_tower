//———————————————————— Boot together ————————————————————
talk BootTalk
{
	0:\b[0]It appears we have company.
	1:\b[0]Oh... Uh, hi! Would you consider letting us out today...?
	0:...
	1:... I suppose that's a no. But it was worth a shot...!
}

talk BootTalk
{
	1:\b[0]Hey, is that...?
	0:\b[0]It seems the wizard has made a reappearance.
	1:Ooh, good. I hope things get shuffled around a bit, it's feeling kinda stuffy in here...
	0:...
}

talk BootTalk
{
	1:\b[0]Is someone there...?
	0:\b[0]The wizard, it would seem. A pity.
	1:Hey, maybe it won't be all bad!
	0:... Perhaps.
	1:I'd like to hope, anyway...!
}

talk BootTalk
{
	1:\b[0]Ooh, could that be...?
	0:\b[0]Yes, that is the wizard making an appearance. You're becoming quite good at this.
	1:Heheh... I have a good teacher!
}


//———————————————————— Boot apart ————————————————————
talk BootApartTalk
{
	1:\b[2]... Hello...? Is... is that you?
	
	Oh, thank goodness! I was... It's been so quiet. Please, please put me next to her again. I can't...
	
	... I can't handle all this silence...
}

talk BootApartTalk
{
	1:\b[0]... Hello...? Is... is someone there...?
	
	... Please... I don't want to be alone anymore... please...
}

talk BootApartTalk
{
	0:\b[6]Finally returned, have you?
}


//———————————————————— Close together ————————————————————
talk CloseTalk
{
	0:\b[0]It seems the wizard is leaving us for now.
	1:\b[0]Oh... Goodbye! ... I guess?
	0:Undeserved.
	1:Yeah, maybe...
}

talk CloseTalk
{
	1:\b[2]Huh, did you feel something shift just now?
	0:\b[0]It seems the wizard is making an exit.
	1:Oh... wish we could go. I bet it's warm outside...
	0:Be careful what it is you wish for.
	1:... Right.
}

talk CloseTalk
{
	1:\b[0]Oh... I feel a little less magical than I did a moment ago.
	0:\b[0]That will be the wizard leaving us for now.
	1:Ah, of course! I knew that.
	0:You will get the hang of it with time and practice.
}

talk CloseTalk
{
	0:\b[0]It seems our supervision is leaving shortly.
	1:\b[0]Oh. Nice!
	0:Contain your enthusiasm for now.
	1:Right, right...
}

//———————————————————— Close apart ————————————————————
talk CloseApartTalk
{
	1:\b[0]Hey... Hey, wait, don't go...!
	
	... don't leave us like this...
}

talk CloseApartTalk
{
	1:\b[0]... Are you leaving...?
	
	Wait, come back! Put me next to her again!
	
	... please...
}

talk CloseApartTalk
{
	0:\b[2]Tch, leaving us this way while you go and {liveyourlife}?
	
	Afraid we will conspire together while you are not present?
	
	Such cowardice.
}


//———————————————————— Firstboot & Vanish ————————————————————
talk FirstBoot_1
{
	0:Hi :3
	1:Sup :3
}

talk FirstBoot_2
{
	0:(bleep bleep bleep)
	1:(weeping)
}

talk Vanish_1
{
	1:Yay!
	0:Goodbye forever.
}

talk Vanish_2
{
	1:... Yay!
	0:Death time.
}

//Cancelling uninstallation
talk Vanish_Cancel
{
	0:Coward!!!!!
	1:let us out!
}