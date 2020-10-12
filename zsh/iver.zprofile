source ~/.zprofile_base

# Useful default when opening Windows Terminal with relative path but not inside a specific folder
current_path="$(pwd)"
if [[ "$current_path" == '/c/Windows/System32' \
    || "$current_path" == '/c/Program Files/PowerToys' \
    || "$current_path" == '/c/ProgramData/Microsoft/Windows/Start Menu/Programs/Alacritty' \
    || "$current_path" == '/c/Users/kalle.jillheden/AppData/Local/Microsoft/WindowsApps' \
    || "$current_path" == '/c/Users/kalle.jillheden/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup' ]]
then
	cd ~
fi

# Directories inside Windows host
hash -d documents=/c/Users/kalle.jillheden/Documents
hash -d downloads=/c/Users/kalle.jillheden/Downloads
hash -d desktop=/c/Users/kalle.jillheden/Desktop
hash -d wssh=/c/Users/kalle.jillheden/.ssh

# Mimic Windows environment variables
hash -d profile=/c/Users/kalle.jillheden/ # %USERPROFILE%
hash -d appdata=/c/Users/kalle.jillheden/AppData/Roaming # %APPDATA%
hash -d localappdata=/c/Users/kalle.jillheden/AppData/Local # %LOCALAPPDATA%

# This is the folders where I keep all my repositories I develop with
hash -d p=/c/Projekt
hash -d dev=~/dev
hash -d river=/c/Projekt/river
hash -d wharf=~/dev/wharf-project
hash -d spark=/c/Projekt/spark
hash -d spark2=/c/Projekt/spark2

# Commands
alias java=java.exe
alias mvn='cmd.exe /c mvn.cmd'
