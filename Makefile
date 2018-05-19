# global variables {{{1
home := /home/$(shell /usr/bin/id -un)
repo := $(CURDIR)

install := /usr/bin/install
install_data := $(install) -D -m 644 -T -v

# general rules {{{1
default:

pre-build:

build:

install:

.PHONY: default pre-build build install

# bourne shell {{{1
profile := $(DESTDIR)$(home)/.profile

install: $(profile)

$(profile): $(repo)/sh/profile.sh
	@$(install_data) $< $@

# bourne again shell {{{1
bashrc := $(DESTDIR)$(home)/.bashrc
bash_profile := $(DESTDIR)$(home)/.bash_profile

install: $(bashrc) $(bash_profile)

$(bashrc): $(repo)/bash/rc.bash
	@$(install_data) $< $@

$(bash_profile): $(repo)/bash/profile.bash
	@$(install_data) $< $@

# tmux {{{1
tmux_config := $(DESTDIR)$(home)/.tmux.conf

install: $(tmux_config)

$(tmux_config): $(repo)/tmux/tmux.conf
	@$(install_data) $< $@

# vi improved {{{1
vimrc := $(DESTDIR)$(home)/.vim/vimrc
vim_colors := $(DESTDIR)$(home)/.vim/colors/solarized.vim

install: $(vimrc) $(vim_colors)

$(vimrc): $(repo)/vim/vimrc
	@$(install_data) $< $@

$(vim_colors): $(repo)/vim/colors/solarized.vim
	@$(install_data) $< $@

# git {{{1
git_config := $(DESTDIR)$(home)/.config/git/config

install: $(git_config)

$(git_config): $(repo)/git/config
	@$(install_data) $< $@

# openbox {{{1
openbox_rc := $(DESTDIR)$(home)/.config/openbox/rc.xml
openbox_menu := $(DESTDIR)$(home)/.config/openbox/menu.xml

install: $(openbox_rc) $(openbox_menu)

$(openbox_rc): $(repo)/openbox/rc.xml
	@$(install_data) $< $@

$(openbox_menu): $(repo)/openbox/menu.xml
	@$(install_data) $< $@

# i3 window manager {{{1
i3wm_config := $(DESTDIR)$(home)/.config/i3/config

install: $(i3wm_config)

$(i3wm_config): $(repo)/i3/config
	@$(install_data) $< $@

# i3 status {{{1
i3status_config := $(DESTDIR)$(home)/.config/i3status/config

install: $(i3status_config)

$(i3status_config): $(repo)/i3status/config
	@$(install_data) $< $@

# gtk {{{1
gtk-2 := $(DESTDIR)$(home)/.gtkrc-2.0
gtk-3 := $(DESTDIR)$(home)/.config/gtk-3.0/settings.ini

install: $(gtk-2) $(gtk-3)

$(gtk-2): $(repo)/gtk/gtkrc-2.0
	@$(install_data) $< $@

$(gtk-3): $(repo)/gtk/settings.ini
	@$(install_data) $< $@

# misc {{{1
keyboard_led := $(DESTDIR)$(home)/.config/autostart/kbled.desktop
xresources := $(DESTDIR)$(home)/.Xresources

install: $(keyboard_led) $(xresources)

$(keyboard_led): $(repo)/misc/kbled.desktop
	@$(install_data) $< $@

$(xresources): $(repo)/misc/Xresources
	@$(install_data) $< $@
