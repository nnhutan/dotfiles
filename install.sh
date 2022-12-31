echo 'Hello! You want to setup: ( ex: `1,2` -or- `q` to quit)'
echo '1. Neovim (AstroNvim distribution)'
echo '2. Zsh'
echo '3. Tmux'
echo '4. Tmuxinator'

read options
if [ $options = 'q' ]; then exit 0; fi

IFS="," read -a options <<< $options
echo  "${options[@]}"

for opt in $options
do
  case $opt in
    1)
      echo "--- Set up for $opt: Neovim (AstroNvim distribution) ---"
      if [ -d ~/.config/nvim/lua/user ]; then
        echo "----- #$opt: Create backup folder -----"
        mv ~/.config/nvim/lua/user ~/.config/nvim/lua/user.bak
      fi
      echo "----- #$opt: Link config folder -----"
      ln -s ~/dotfiles/.config/nvim_astronvim/lua/user ~/.config/nvim/lua/user
      ;;
    2)
      echo "--- Set up for $opt: Zsh ---"
      if [ -e ~/.zshrc ]; then
        echo "----- #$opt: Create backup file config -----"
        mv ~/.zshrc ~/.zshrc.bak
      fi
      echo "----- #$opt: Link config file -----"
      ln -s ~/dotfiles/.zshrc ~/.zshrc
      ;;
    3)
      echo "--- Set up for $opt: Tmux ---"
      if [ -e ~/.tmux.conf ]; then
        echo "----- #$opt: Create backup file config -----"
        mv ~/.tmux.conf ~/.tmux.conf.bak
      fi
      echo "----- #$opt: Link config file -----"
      ln -s ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
      ;;
    4)
      echo "--- Set up for $opt: Tmuxinator ---"
      if [ -d ~/.config/tmuxinator ]; then
        echo "----- #$opt: Create backup file folder -----"
        mv ~/.config/tmuxinator ~/.config/tmuxinator.bak
      fi
      echo "----- #$opt: Link config folder -----"
      ln -s ~/dotfiles/tmuxinator ~/.config/tmuxinator
      ;;
    *)
      echo "Don't know options #$opt"
      ;;
  esac
done
