---
title: Copasa is killing my hopes
description: The CEMIG of water distribution
date: 2026-04-16 17:10:57-03:00
draft: false
image: cover.png
categories:
- computing
- folly
tags:
- copasa
- nonsense
bluesky_comment_uri: 
comments: true
---


Today the missus sent me an image of an SMS sent to my father-in-law, wanting to know if I had received any water bills lately.

The SMS had that classic scam vibe: trying to convey that sense of urgency. Sending a link with a little hash of an address that couldn't possibly be real: copasa.**net**.br. Well, Copasa is obviously .**com**.br, of course.

...Right?

I was just about to reply that *it's a scam, obviously! Just look at the domain*... But then I thought, "wow, Copasa is really struggling with *infosec*, huh? They let some nutjob snatch up a .net.br with their name perfectly".

Out of curiosity, I went to do a WHOIS on the domains.

![Copasa.com.br](whois-copasacombr.png)

OK, everything seems fine. And the scam one?

![Copasa.net.br](whois-copasanetbr.png)

...Huh?

----

Okay, apparently Copasa has completely separated the institutional side from the customer service side, including not using the same domain. I don't really agree with it, but who knows how decisions are made there, aside from making my mother go without water for about 10 days out of pure procedural spite.

But then you look at the certificate for the .net.br domain.

![Copasa.net.br's certificate](cert.png)

Dude, are they seriously using the same certificate for staging and production? Seriously, they expose staging like this?

You search for the domain on ye olde Googley, and their SEO is a degree worse than nonexistent, it's negligent. This is the first page:

![First page results for Copasa.net.br](copasa-p1.png)

Practically nothing added to facilitate a search result. But beyond that, you find a link on the first page to the admin panel of the SaaS they use for their customer service system. And beyond that, which is above the other, you also find a link to the admin panel in staging. I'm not going any further with anything else for fear of knowing that this is also part of the structural decay, just to sell this state company for peanuts later.

They use [WeTalkie](https://wetalkie.com/). Poor folks, paying for their sins by having a client like this. Copasa has been giving us headaches every now and then around here. The sad fate of the march of institutional decay is for it to become another CEMIG to convince the population that it's worthless. Lamentable.

I remember going on a field trip to a treatment plant when I was a kid. I remember the filtration tanks, the settling tanks. But I don't remember when it was anymore, who I had as a classmate, things like that.

It would be good if they "treated" the data security of the population that depends on them, because all this exposure is scary.
