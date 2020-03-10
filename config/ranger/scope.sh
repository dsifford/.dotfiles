#!/usr/bin/env bash
# shellcheck disable=SC2034

# If the option `use_preview_script` is set to `true`,
# then this script will be called and its output will be displayed in ranger.
# ANSI color codes are supported.
# STDIN is disabled, so interactive scripts won't work properly
# STDERR is silenced/ignored

# This script is considered a configuration file and must be updated manually.
# It will be left untouched if you upgrade ranger.

# Meanings of exit codes:
# code | meaning    | action of ranger
# -----+------------+-------------------------------------------
# 0    | success    | Display stdout as preview
# 1    | no preview | Display no preview at all
# 2    | plain text | Display the plain content of the file
# 3    | fix width  | Don't reload when width changes
# 4    | fix height | Don't reload when height changes
# 5    | fix both   | Don't ever reload
# 6    | image      | Display the image `$image_cache_path` points to as an image preview
# 7    | image      | Display the file directly as an image

###
# Settings
##
set -o noclobber
set -o noglob
set -o nounset
set -o pipefail

declare COLORTERM=8bit
declare IFS=$'\n'

###
# Script arguments
##
declare file_path="$1"             # Full path of the highlighted file
declare preview_width="$2"         # Height of the preview pane (number of fitting characters)
declare preview_height="$3"        # Width of the preview pane (number of fitting characters)
declare image_cache_path="$4"      # Full path that should be used to cache image preview
declare image_preview_enabled="$5" # 'True' if image previews are enabled, 'False' otherwise

###
# Variables
##
declare -i file_bytes
declare -l file_encoding
declare -l file_extension
declare -l file_mime_type

file_bytes=$(stat -c%s "$file_path")
file_encoding=$(file --brief --mime-encoding -- "$file_path")            # The file encoding
file_extension=${file_path##*.}                                          # The file extension
file_mime_type=$(file --dereference --brief --mime-type -- "$file_path") # The file mime type

# Settings

main() {
	if [[ "$image_preview_enabled" == 'True' ]]; then
		handle_image
	fi
	handle_extension
	handle_fallback
	exit 1
}

highlight_file() {
	bat \
		--theme dracula \
		--color always \
		--style changes,numbers \
		--line-range :500 \
		"$@"
}

handle_extension() {
	case "$file_extension" in
		# Archive
		a | ace | alz | arc | arj | bz | bz2 | cab | cpio | deb | gz | jar | lha | lz | lzh | lzma | lzo | rpm | rz | t7z | tar | tbz | tbz2 | tgz | tlz | txz | tZ | tzo | war | xpi | xz | Z | zip)
			atool --list -- "$file_path" && exit 5
			bsdtar --list --file "$file_path" && exit 5
			exit 1
			;;
		rar)
			# Avoid password prompt by providing empty password
			unrar lt -p- -- "$file_path" && exit 5
			exit 1
			;;
		7z)
			# Avoid password prompt by providing empty password
			7z l -p -- "$file_path" && exit 5
			exit 1
			;;

		torrent)
			transmission-show -- "$file_path" && exit 5
			exit 1
			;;

		# Microsoft Word
		docx | odt)
			# Convert to markdown and preview
			highlight_file --language md < <(pandoc -t gfm "$file_path") && exit 5
			exit 1
			;;
	esac
}

handle_image() {
	case "$file_mime_type" in
		image/svg*)
			# handle these with highlight_file
			;;

		image/*)
			local orientation
			orientation="$(identify -format '%[EXIF:Orientation]\n' -- "$file_path")"
			# If orientation data is present and the image actually
			# needs rotating ("1" means no rotation)...
			if [[ -n "$orientation" && "$orientation" != 1 ]]; then
				# ...auto-rotate the image according to the EXIF data.
				convert -- "$file_path" -auto-orient "$image_cache_path" && exit 6
			fi

			# `w3mimgdisplay` will be called for all images (unless overriden as above),
			# but might fail for unsupported types.
			exit 7
			;;

		video/*)
			# Thumbnail
			ffmpegthumbnailer -i "$file_path" -o "$image_cache_path" -s 0 && exit 6
			exit 1
			;;

		application/pdf)
			pdftoppm -f 1 -l 1 \
				-scale-to-x 1920 \
				-scale-to-y -1 \
				-singlefile \
				-jpeg -tiffcompression jpeg \
				-- "$file_path" "${image_cache_path%.*}" \
				&& exit 6
			exit 1
			;;
	esac
}

handle_fallback() {
	if ((file_bytes < 1000000)); then
		case "$file_encoding" in
			*-ascii | utf-8 | utf-16)
				highlight_file "$file_path" && exit 5
				exit 2
				;;
		esac
	fi

	exiftool "$file_path" && exit 5
	echo '----- File Type Classification -----' \
		&& file --dereference --brief -- "$file_path" \
		&& exit 5

	exit 1
}

main
