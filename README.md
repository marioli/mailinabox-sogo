Mail-in-a-Box
=============

Mail-in-a-Box helps individuals take back control of their email by defining a one-click, easy-to-deploy SMTP+everything else server: a mail server in a box.

**Please see [https://mailinabox.email](https://mailinabox.email) for the project's website and setup guide!**

!!! About this fork !!!
-----------------------
This fork of Mail-in-a-box intends to upgrade the base OS to 16.04 LTS and replace Roundcube/Z-push (and more) with the [SOGo groupware](http://www.sogo.nu/).

In the nearest future you should consider this fork as **highly experimental** and **not fit for production**.

**NOTE**: There is NO upgrade/migration path from older Mail-in-a-box installations.

* * *

Our goals are to:

* Make deploying a good mail server easy.
* Promote [decentralization](http://redecentralize.org/), innovation, and privacy on the web.
* Have automated, auditable, and [idempotent](https://sharknet.us/2014/02/01/automated-configuration-management-challenges-with-idempotency/) configuration.
* **Not** make a totally unhackable, NSA-proof server.
* **Not** make something customizable by power users.

Additionally, this project has a [Code of Conduct](CODE_OF_CONDUCT.md), which supersedes the goals above. Please review it when joining our community.

The Box
-------

Mail-in-a-Box turns a fresh Ubuntu 16.04 LTS 64-bit machine into a working mail server by installing and configuring various components.

It is a one-click email appliance. There are no user-configurable setup options. It "just works".

The components installed are:

* SMTP ([postfix](http://www.postfix.org/)), IMAP ([dovecot](http://dovecot.org/))
* Webmail ([SOGo Groupware](http://sogo.nu/))(*), static website hosting ([nginx](http://nginx.org/))
* Calendar and Contact sync ([SOGo Groupware](http://sogo.nu/))*, Fast Text Search for Dovecot mailbox ([Solr](http://lucene.apache.org/solr/))
* Spam filtering ([spamassassin](https://spamassassin.apache.org/)), greylisting ([postgrey](http://postgrey.schweikert.ch/)), antivirus ([clamav](https://www.clamav.net/))
* DNS ([nsd4](https://www.nlnetlabs.nl/projects/nsd/)) with [SPF](https://en.wikipedia.org/wiki/Sender_Policy_Framework), DKIM ([OpenDKIM](http://www.opendkim.org/)), [DMARC](https://en.wikipedia.org/wiki/DMARC), [DNSSEC](https://en.wikipedia.org/wiki/DNSSEC), [DANE TLSA](https://en.wikipedia.org/wiki/DNS-based_Authentication_of_Named_Entities), and [SSHFP](https://tools.ietf.org/html/rfc4255) records automatically set
* Backups ([duplicity](http://duplicity.nongnu.org/)), firewall ([ufw](https://launchpad.net/ufw)), intrusion protection ([fail2ban](http://www.fail2ban.org/wiki/index.php/Main_Page)), system monitoring ([munin](http://munin-monitoring.org/))

(*) [SOGo](http://sogo.nu/) provides an seamless for these services within the same UI.

It also includes:

* A control panel and API for adding/removing mail users, aliases, custom DNS records, etc. and detailed system monitoring.
* Our own builds of postgrey (adding better whitelisting) and dovecot-lucene (faster search for mail) distributed via the [Mail-in-a-Box PPA](https://launchpad.net/~mail-in-a-box/+archive/ubuntu/ppa) on Launchpad.

For more information on how Mail-in-a-Box handles your privacy, see the [security details page](security.md).

Installation
------------

See the [setup guide](https://mailinabox.email/guide.html) for detailed, user-friendly instructions.

For experts, start with a completely fresh (really, I mean it) Ubuntu 16.04 LTS 64-bit machine. On the machine...

Clone this repository:

	$ git clone https://github.com/jkaberg/mailinabox-sogo
	$ cd mailinabox

Begin the installation.

	$ sudo setup/start.sh

The Acknowledgements
--------------------
This fork is due to the awesome work done by these [people](https://github.com/jkaberg/mailinabox-sogo/graphs/contributors).

This project was inspired in part by the ["NSA-proof your email in 2 hours"](http://sealedabstract.com/code/nsa-proof-your-e-mail-in-2-hours/) blog post by Drew Crawford, [Sovereign](https://github.com/sovereign/sovereign) by Alex Payne, and conversations with <a href="https://twitter.com/shevski" target="_blank">@shevski</a>, <a href="https://github.com/konklone" target="_blank">@konklone</a>, and <a href="https://github.com/gregelin" target="_blank">@GregElin</a>.

Mail-in-a-Box is similar to [iRedMail](http://www.iredmail.org/) and [Modoboa](https://github.com/tonioo/modoboa).