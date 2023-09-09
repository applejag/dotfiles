
jq '.emojis[] | select(.shortname != "") | .emoji + "\t" + .name + "\t" + .shortname' ~/dotfiles/scripts/emojis.json -r \
	| tofi --ascii-input true --fuzzy-match true \
	| cut -d$'\t' -f3 \
	| wl-copy --trim-newline
