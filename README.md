# wigglydots
My autoinstaller for powerline and dotfiles and scripts and stuff. Powered by [mescaline](https://github.com/netzverweigerer/mescaline).

![alt tag](https://wigglytuff.org/images/wigglydots.png)

**Dependencies**

  ```console
  $ sudo apt-get install keychain zsh python3 git vim tmux python-pip scrot colordiff
  $ sudo pip install powerline-status
  ```
You'll also need to use a font compatible with powerline's special characters. [Terminus Medium 9px](https://github.com/Igglybuff/config-bits/blob/master/fonts/TerminusTTF-4.39.ttf?raw=true) (patched) is the font used in the screenshot.

**Usage**

  ```console
  $ git clone --recursive https://github.com/Igglybuff/wigglydots.git
  $ cd wigglydots
  $ ./installer
  ```
wigglydots will back up any pre-existing .rc or .conf files automagically. Remember to change your shell to zsh with:
  ```console
  $ sudo chsh -s /usr/bin/zsh <username>
  ```

**Tidbits**

  * The imgur.py script depends on you defining an imgur API key as an environment variable. (e.g. in ~/.zshrc)

	```console
	$ echo "export IMGUR_API_KEY='your api key here'" >> ~/.zshrc
	```

  * The 'wigglyscrot.sh' script is really only for me, but you can easily modify that to work with your own server.
  * Mescaline is created by netzverweigerer - https://github.com/netzverweigerer armin@arminius.org
