# wigglydots
My autoinstaller for powerline and dotfiles and scripts and stuff.

**Usage**

  ```console
  $ git clone https://github.com/Igglybuff/wigglydots.git
  $ cd wigglydots
  $ ./installer.sh

  ```
wigglydots will back up any pre-existing .rc or .conf files automagically.

**Tidbits**

  * The imgur.py script depends on you defining an imgur API key as an environment variable. (e.g. in ~/.zshrc)

	```console
	$ echo "export IMGUR_API_KEY='your api key here'" >> ~/.zshrc
	```

  * The 'wigglyscrot.sh' script is really only for me, but you can easily modify that to work with your own server.
  * Mescaline is created by netzverweigerer - https://github.com/netzverweigerer armin@arminius.org
