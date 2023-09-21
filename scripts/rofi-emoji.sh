
jq '.emojis[] | .emoji + "\t" + .name' ~/dotfiles/scripts/emojis.json -r \
	| rofi -dmenu \
	| cut -d$'\t' -f1 \
	| wl-copy --trim-newline

