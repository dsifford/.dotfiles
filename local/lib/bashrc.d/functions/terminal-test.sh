# shellcheck shell=bash
#
# Print truecolor test
#

terminal-test() {

	echo 'Text attributes'
	echo -e '\tBold:|\e[1mThis text is bold.\e[0m' \
			'\n\tDim:|\e[2mThis text is dim.\e[0m' \
			'\n\tItalic:|\e[3mThis text is italic.\e[0m' \
			'\n\tUnderline:|\e[4mThis text is underlined.\e[0m' \
			'\n\tBlink:|\e[5mThis text is blinking.\e[0m' \
			'\n\tReverse:|\e[7mThis text is inverted.\e[0m' \
			'\n\tStrikethrough:|\e[9mThis text is strikethrough.\e[0m' \
			| column -t -s\|

	echo
	echo 'Truecolor Support Test (should be a smooth color transition)'

    awk 'BEGIN{
		s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
		for (colnum = 0; colnum<77; colnum++) {
			r = 255-(colnum*255/76);
			g = (colnum*510/76);
			b = (colnum*255/76);
			if (g>255) g = 510-g;
			printf "\033[48;2;%d;%d;%dm", r,g,b;
			printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
			printf "%s\033[0m", substr(s,colnum+1,1);
		}
		printf "\n";
	}'
}

