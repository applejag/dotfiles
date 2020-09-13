source ~/.zprofile_base

# Useful default when opening Windows Terminal with relative path but not inside a specific folder
current_path="$(pwd)"
if [[ "$current_path" == '/c/Windows/System32' \
    || "$current_path" == '/c/Program Files/PowerToys' \
    || "$current_path" == '/c/ProgramData/Microsoft/Windows/Start Menu/Programs/Alacritty' \
    || "$current_path" == '/c/Users/kalle/AppData/Local/Microsoft/WindowsApps' ]]
then
	cd ~
fi

# Directories inside Windows host
hash -d documents=/c/Users/kalle/Documents
hash -d downloads=/c/Users/kalle/Downloads
hash -d desktop=/c/Users/kalle/Desktop
hash -d wssh=/c/Users/kalle/.ssh

# Mimic Windows environment variables
hash -d profile=/c/Users/kalle/ # %USERPROFILE%
hash -d appdata=/c/Users/kalle/AppData/Roaming # %APPDATA%
hash -d localappdata=/c/Users/kalle/AppData/Local # %LOCALAPPDATA%

# This is the folders where I keep all my repositories I develop with
hash -d dev=/c/dev
hash -d json=/c/dev/Newtonsoft.Json-for-Unity
hash -d json.w=/c/dev/Newtonsoft.Json-for-Unity.wiki
hash -d json.c=/c/dev/Newtonsoft.Json-for-Unity.Converters
