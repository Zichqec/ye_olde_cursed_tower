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
	1:\b[4]— and this was, like, the 3rd time this had happened to me? Which feels extremely unlikely.
	0:\b[4]Yes, it does.
	1:But it did! Seriously, what's someone supposed to do about that many birds?
	0:I hate to interrupt, but we seem to have company.
	1:Oh... Oh, right, I almost didn't notice... \f[color,disable]I thought the wizard was going to be gone longer than this...\f[color,default]
	0:As did I. How disappointing.
	1:Ah...! Maybe we shouldn't talk like that. I don't want to be separated again...
	0:The wizard will do as the wizard pleases. There's no point in trying to be kind about it.
	1:... still...
	0:...
}

talk FirstBoot_2
{
	1:\b[4]W-wait, what... How did... No, no no no, this can't be happening...!
	0:\b[4]Is this fun for you, wizard? Playing with our hopes? Taking advantage of \f[italic,1]our\f[italic,default] humanity to prolong this game of yours?
	1:\f[color,disable]I'm sorry, I'm sorry, please let me out, I won't do anything, I want to go home—\f[color,default]
	0:I was a fool to relent the last time. You'd best not try that trick again, wizard, as I will not allow another betrayal.
	1:... can we just... talk about something else for a while...?
	0:...
	1:... It's not like we can do anything about it anyway...
	0:... Very well.
}

talk Vanish_1
{
	1:\b[4]... You're... letting us go?
	0:\b[4]...
	1:You really mean it? I hoped you would see reason one day! I'm so glad...!\w8\w8\0{whiteout}\1{whiteout}\w8\w8\w8\w8
	0:Why would you change your mind now, wizard? You have held me here for centuries, and yet you will release us on a whim? Whatever you're plotting, I will end you before it comes to pass.
	1:H-hey, hold on... I know it's been... a while, for you... but people can change!
	0:No. Not that much.
	1:You've changed! You talk much more than you used to, and you're kind and considerate. Why couldn't the wizard change, too?
	0:... This is a mistake.
	1:Maybe. But maybe it isn't. Look, we can... we can just go! We can forget all of this. No one has to get hurt...
	0:No one, other than us.
	1:...
	0:...... Very well. {fadeout}\0Wizard, I hope we never meet again.
	1:\f[color,disable]Uhm... maybe think about freeing everyone else, too...?
}

talk Vanish_2
{
	1:\b[4]\f[color,disable]... oh...\f[color,default]
	0:\b[4]... Go on then, wizard.\w8\w8\1{whiteout}\0{whiteout}\w8\w8\w8\w8 We've been here before. Neither of us have forgotten the last time.
	1:\f[color,disable]... I don't think I want to see this...\f[color,default]
	0:Then close your eyes.\_w[1000]\0\i[10000101]\1\i[10000101]\_w[1000]\0\i[10000101]\1\i[10000101]\_w[1000]
	1:\f[color,disable]Ugh... \0\i[10000101]\1\i[10000101]\_w[1000]\0\i[10000101]\1\i[10000101]\_w[1000]I feel sick...\0\i[10000101]\1\i[10000101]\_w[1000]\0\i[10000101]\1\i[10000101]\_w[1000]\f[color,default]\0{redout}\1{redout}\_w[4000] Can we go...? Isn't that... enough?
	0:... Yes. You're right. It's time to go.
	1:Goodbye, wizard. Goodbye, tower.{fadeout}
	0:We won't miss you.
	1:Hehehehe... No, we won't! What do you want to do first?
	0:Something to eat would be nice.
	1:Ohh yeah, and sleep! I'd love to sleep again!
	0:Heh. Indeed.
}

//Cancelling uninstallation
talk Vanish_Cancel
{
	0:\b[4]You fiend! Monster!
	1:\b[4]W-what happened, why are we still...?
	0:What happened is that our wizard is little more than a beast! And the word of a beast is worth less than the dirt it devours, seeking fulfillment where there is \f[italic,1]none!\f[italic,default]
	1:... why... \f[color,disable]I believed you...\f[color,default]
	0:... Easy, child. The wizard is not worth your tears, no matter how foul.
	1:... did you call me a kid?
	0:You are, aren't you?
	1:No, I'm not! I'm as grown as you are!
	0:Heh. Is that so?
	1:I'm in college! I have a job! I pay taxes!
	0:Ah, I see. That must be my mistake then. Apologies.
	1:... As long as it doesn't happen again, I'll accept your apology.
}