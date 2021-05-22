# SETUP UNATTENDED
export DEBIAN_FRONTEND=noninteractive

# SETUP APT
apt update
apt upgrade -y

# INSTALL CORE APT PACKAGES
apt install -y \
  build-essential \
  git \
  curl \
  wget \
  neovim \
  yadm \
  mosh

# INSTALL NVIM PLUG
echo "Installing Vim Plug"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# INSTALL RBENV
if ! type "rbenv" > /dev/null; then
  echo "Installing rbenv & ruby build..."
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  cd ~/.rbenv && src/configure && make -C src && cd
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
else
  echo "Upgrading rbenv & ruby build..."
  cd ~/.rbenv
  git pull
  cd plugins/ruby-build
  git pull
  cd
fi

# INSTALL/UPGRADE NVM
echo "Insalling & Upgrading NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

# LOAD DOT FILES
yadm clone https://github.com/JoeeGrigg/dotfiles.git
