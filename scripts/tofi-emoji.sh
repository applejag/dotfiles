
jq '.emojis[] | .emoji + "\t" + .name' ~/dotfiles/scripts/emojis.json -r \
	| tofi --ascii-input true --fuzzy-match true \
	| cut -d$'\t' -f1 \
	| wl-copy --trim-newline

