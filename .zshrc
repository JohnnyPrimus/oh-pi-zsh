# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export LS_COLORS="$(vivid generate snazzy)"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="random"

# Set list of themes to pick from when loading at random
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster", "rkj-repos", "funky" )
# or read in .themefavorites (run "favtheme" from zsh to add current random
# theme to favorites
#
#ZSH_THEME_RANDOM_CANDIDATES=()
#while IFS= read -r line || [[ "$line" ]] ; do
#    ZSH_THEME_RANDOM_CANDIDATES+=( "$line" )
#done < ${HOME}/.themefavorites

# If youd rather define themes that are NOT candidates for
# RANDOM_THEME, define them in ZSH_THEME_RANDOM_IGNORED
# In one of two ways
# 
# 1) define them in this rc as a string array, just like candidates above
# ZSH_THEME_RANDOM_IGNORED=("no_thx_theme", "also_no_plz_theme")
# or
# 2) save them one per line in ~/.themeignore and read that in here
#    (run "ingoretheme" from zsh to automatically add current random theme to 
#    the ignore list)
#
ZSH_THEME_RANDOM_IGNORED=()
while IFS= read -r line || [[ "$line" ]] ; do
    ZSH_THEME_RANDOM_IGNORED+=( "$line" )
done < ${HOME}/.themeignores

if [[ -z ${RANDOM_THEME} ]]; then
  export RANDOM_THEME="$RANDOM_THEME"
fi

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' frequency 14

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM+="~/.zshcustom"

export ZSH_CONFIG=~/.zshconfig

# Default an editor. Can add logic to change based on local vs 
# remote shell, etc
EDITOR='nano'

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   EDITOR='nano'
 fi

export EDITOR=$EDITOR

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  aliases
  alias-finder
  autoenv
  bgnotify
  colorize
  colored-man-pages
  command-not-found
  common-aliases
#  cp
  debian
  dirpersist
#  docker
#  docker-compose
#  dotnet
  fzf
  fzf-zsh-plugin
#  git
  gitfast
#  github
  gitignore
  git-lfs
#  globalias
#  gnu-utils
#  gpg-agent
  history
  history-substring-search
#  jump
  keychain
#  last-working-dir
  man
  nmap
  otp
#  per-directory-history
  pipenv
  pip
  python
  pyenv
  rsync
  safe-paste
  screen
  ssh
  ssh-agent
  sudo
  systemd
  thefuck
  themes
  tmux
#  tmuxinator
  ubuntu
#  virtualenv
#  vscode
#  web-search
  zsh-autosuggestions
  zsh-navigation-tools
  zsh-syntax-highlighting
  zsh-history-substring-search
)

# Plugins configuration
# zsh-completion
fpath+=~/.oh-my-zsh/custom/plugins/zsh-completions/src:~/.config/aliases:~/.zshconfig:~/.zshconfig/aliases:$ZSH_CUSTOM

# User configuration
export JAVA_HOME='/usr/lib/jvm/java-17-openjdk-amd64'
export FZF_DEFAULT_COMMAND='fd --type f'
export PATH=$HOME/.oh-my-zsh/.autoenv:$HOME/.oh-my-zsh/bin:/usr/local/bin:/usr/bin:/usr/sbin:/usr/local/sbin:$HOME/.local/.bin:$HOME/.local/bin:$HOME/.local/share/bin:$JAVA_HOME/bin:/snap/bin:$PATH
source $ZSH/oh-my-zsh.sh

# User configuration

export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LOCALE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8

# Compilation flags
export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="$EDITOR ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"

for zsh_alias_file in ${ZSH_CONFIG}/aliases/*(.); do source $zsh_alias_file ; done

source ~/.autoenv/activate.sh
