source ~/.zprofile_base.zsh

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
