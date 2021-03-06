import subprocess


def run(command):
    return subprocess.call(command, shell=True)


arch_packages = "firefox telegram-desktop discord freeoffice microsoft-office-web-jak vlc qbittorrent simplescreenrecorder obs-studio shotcut etcher stacer nautilus python-nautilus gucharmap tilix zsh rofi feh timeset blueman pulseaudio-bluetooth pa-applet pavucontrol neofetch speedtest-cli wmctrl xclip bat redshift noto-fonts-emoji py3status python-pydbus"
aur_packages = "google-chrome-stable foxitreader  spotify spicetify-cli spotify-tui spotifyd  mailspring teams nautilus-empty-file visual-studio-code-bin clion pycharm-professional intellij-idea-ultimate-edition intellij-idea-ultimate-edition-jre webstorm datagrip i3-battery-popup-git xidlehook"
vscode_extensions = ["James-Yu.latex-workshop", "fallenwood.vimL", "icrawl.discord-vscode", "ms-python.python", "ms-vscode.cpptools", "ms-vsliveshare.vsliveshare", "ritwickdey.LiveServer", "vscode-icons-team.vscode-icons", "j-james.adapta-nokto-vscode"]


def install_arch_packages():
    run("sudo pacman -S {}".format(arch_packages))


def install_aur_packages():
    run("yay -S {}".format(aur_packages))


def install_vscode_extensions():
    for extension in vscode_extensions:
    	run("code --install-extension {}".format(extension))


def install_oh_my_zsh():
    run("sh -c \"$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\"")
    run("git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting")
    run("git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions")


def install_vim_plug():
    run("curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim")


def fix_time():
    run("sudo timedatectl set-local-rtc 1 --adjust-system-clock")


def install_bin():
    run("cp -r .bin $HOME")


def install_fonts():
    run("cp .config/other/fonts $HOME/.local/share")
    run("fc-cache -f -v")


def install_configs():
    run("cp -r .config/conky $HOME/.config")
    run("cp -r .config/fontconfig $HOME/.config")
    run("cp -r .config/rofi $HOME/.config")
    run("sudo cp .config/rofi/bin/rofi-sensible-terminal /usr/bin")
    run("cp .config/gtk-3.0/bookmarks $HOME/.config/gtk-3.0")
    run("cp -r .config/mailspring $HOME/.config")
    run("cp -r .config/spicetify $HOME/.config")
    run("sudo chmod a+wr /opt/spotify")
    run("sudo chmod a+wr /opt/spotify/Apps -R")
    run("sudo .other/spt/install.sh")
    run("spicetify backup apply enable-devtool")
    run("dconf load /com/gexperts/Tilix/ < .config/tilix/config.dconf")
    run("cp .config/picom/picom.conf $HOME/.config")
    run("cp .config/ranger/rifle.conf $HOME/.config/ranger")
    run("cp .config/dmenu/.dmenurc $HOME")
    run("cp .config/dunst/dunstrc $HOME/config/dunst")
    run("cp .config/ssh/config $HOME/.ssh")
    run("cp -r .config/i3/* $HOME/.i3")
    run("sudo cp -r .other/grub/fallout-grub-theme /boot/grub/themes")
    run("sudo cp -r .other/grub/grub /etc/default")
    run("sudo update-grub")
    run("cp .vimrc $HOME")
    run("cp .zshrc $HOME")

if __name__ == "__main__":

    # install_arch_packages()
    # install_aur_packages()
    # install_vscode_extensions()
    # install_oh_my_zsh()
    # install_vim_plug()
    # fix_time()
    # install_bin()
    # install_fonts()
    # install_configs()

    print("\nIntallation has finished!\n")
