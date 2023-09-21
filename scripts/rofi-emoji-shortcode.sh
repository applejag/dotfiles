
jq '.emojis[] | select(.shortname != "") | .emoji + "\t" + .name + "\t" + .shortname' ~/dotfiles/scripts/emojis.json -r \
	| rofi -dmenu \
	| cut -d$'\t' -f3 \
	| wl-copy --trim-newline
