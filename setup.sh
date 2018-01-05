#!/bin/bash
echo Installing oh-my-zsh ...
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo Installing complete!
echo Installing zsh plugins ...
echo Installing zsh-autosuggestions ...
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
echo Installing complete!

echo Installing zsh-completions ...
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
echo Installing complete!

echo Installing zsh-syntax-highlighting ...
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
echo Installing complete!

echo Installing i3block ...
git clone git://github.com/vivien/i3blocks
cd i3blocks
make clean all
make install
cd - 
echo Installing complete!

echo Intalling fonts ...
git clone https://github.com/ryanoasis/nerd-fonts
cd nerd-fonts
./install.sh FiraCode FiraMono Mononoki
cd ..
echo Installing complete!

if [[ -a /etc/os-release ]]; then
	. /etc/os-release
	DISTRO=$ID
else
	DISTRO="fedora"
fi
if [[ $DISTRO != "arch" ]]; then
	echo Installing rofi compton pactl xbacklight
	dnf copr enable yaroslav/i3desktop
	dnf install rofi compton feh xbacklight pactl golang -y
	echo Installing complete ...
fi
