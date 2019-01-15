#!/usr/bin/env bash
set -o noclobber
set -o noglob
set -o nounset
set -o pipefail

IFS=$'\n'

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
# 6    | image      | Display the image `$IMAGE_CACHE_PATH` points to as an image preview
# 7    | image      | Display the file directly as an image

# Script arguments
declare FILE_PATH="$1"                       # Full path of the highlighted file
declare -l FILE_EXTENSION="${FILE_PATH##*.}" # The file extension
declare IMAGE_CACHE_PATH="$4"                # Full path that should be used to cache image preview
declare PV_IMAGE_ENABLED="$5"                # 'True' if image previews are enabled, 'False' otherwise
declare MIMETYPE                             # The file's mime type
MIMETYPE="$(file --dereference --brief --mime-type -- "$FILE_PATH")"

# Settings
declare -i HIGHLIGHT_SIZE_MAX=262143 # 256KiB
declare -i HIGHLIGHT_TABWIDTH=4
declare HIGHLIGHT_FORMAT=ansi
declare HIGHLIGHT_STYLE=pablo

main() {
	if [[ "$PV_IMAGE_ENABLED" == 'True' ]]; then
		handle_image
	fi
	handle_mime
	handle_extension
	handle_fallback
	exit 1
}

handle_extension() {
	case "$FILE_EXTENSION" in
		# Archive
		a | ace | alz | arc | arj | bz | bz2 | cab | cpio | deb | gz | jar | lha | lz | lzh | lzma | lzo | rpm | rz | t7z | tar | tbz | tbz2 | tgz | tlz | txz | tZ | tzo | war | xpi | xz | Z | zip)
			atool --list -- "$FILE_PATH" && exit 5
			bsdtar --list --file "$FILE_PATH" && exit 5
			exit 1
			;;
		rar)
			# Avoid password prompt by providing empty password
			unrar lt -p- -- "$FILE_PATH" && exit 5
			exit 1
			;;
		7z)
			# Avoid password prompt by providing empty password
			7z l -p -- "$FILE_PATH" && exit 5
			exit 1
			;;

		torrent)
			transmission-show -- "$FILE_PATH" && exit 5
			exit 1
			;;

		# OpenDocument
		odt | ods | odp | sxw)
			# Preview as text conversion
			odt2txt "$FILE_PATH" && exit 5
			exit 1
			;;

		# Microsoft Word
		docx)
			# Convert to markdown and preview
			highlight \
				--replace-tabs="$HIGHLIGHT_TABWIDTH" \
				--out-format="$HIGHLIGHT_FORMAT" \
				--style="$HIGHLIGHT_STYLE" \
				--syntax=md \
				--force < <(pandoc -t gfm "$FILE_PATH") && exit 5
			exit 1
			;;

		tsx)
			if [[ "$(stat --printf='%s' -- "$FILE_PATH")" -gt "$HIGHLIGHT_SIZE_MAX" ]]; then
				exit 2
			fi
			highlight \
				--force \
				--replace-tabs="$HIGHLIGHT_TABWIDTH" \
				--out-format="$HIGHLIGHT_FORMAT" \
				--style="$HIGHLIGHT_STYLE" \
				--syntax=ts \
				-- "$FILE_PATH" && exit 5
			exit 2
			;;
	esac
}

handle_image() {
	case "$MIMETYPE" in
		image/svg*)
			return
			;;

		# Image
		image/*)
			local orientation
			orientation="$(identify -format '%[EXIF:Orientation]\n' -- "$FILE_PATH")"
			# If orientation data is present and the image actually
			# needs rotating ("1" means no rotation)...
			if [[ -n "$orientation" && "$orientation" != 1 ]]; then
				# ...auto-rotate the image according to the EXIF data.
				convert -- "$FILE_PATH" -auto-orient "$IMAGE_CACHE_PATH" && exit 6
			fi

			# `w3mimgdisplay` will be called for all images (unless overriden as above),
			# but might fail for unsupported types.
			exit 7
			;;

		# Video
		video/*)
			# Thumbnail
			ffmpegthumbnailer -i "$FILE_PATH" -o "$IMAGE_CACHE_PATH" -s 0 && exit 6
			exit 1
			;;

		# PDF
		application/pdf)
			pdftoppm -f 1 -l 1 \
				-scale-to-x 1920 \
				-scale-to-y -1 \
				-singlefile \
				-jpeg -tiffcompression jpeg \
				-- "$FILE_PATH" "${IMAGE_CACHE_PATH%.*}" \
				&& exit 6
			exit 1
			;;
	esac
}

handle_mime() {
	case "$MIMETYPE" in
		application/json)
			prettier --parser json-stringify "$FILE_PATH" \
				| highlight \
					--force \
					--out-format="$HIGHLIGHT_FORMAT" \
					--style="$HIGHLIGHT_STYLE" \
					--syntax=json && exit 5
			exit 1
			;;

		application/pdf)
			pdftotext -l 10 -nopgbrk -q -- "$FILE_PATH" - && exit 5
			exit 1
			;;

		image/svg*)
			prettier --parser html "$FILE_PATH" \
				| highlight \
					--force \
					--out-format="$HIGHLIGHT_FORMAT" \
					--style="$HIGHLIGHT_STYLE" \
					--syntax=xml && exit 5
			exit 1
			;;
	esac
}

handle_fallback() {
	case "$MIMETYPE" in
		text/* | */xml)
			if [[ "$(stat --printf='%s' -- "$FILE_PATH")" -gt "$HIGHLIGHT_SIZE_MAX" ]]; then
				exit 2
			fi
			highlight \
				--force \
				--replace-tabs="$HIGHLIGHT_TABWIDTH" \
				--out-format="$HIGHLIGHT_FORMAT" \
				--style="$HIGHLIGHT_STYLE" \
				-- "$FILE_PATH" && exit 5
			exit 2
			;;
	esac

	exiftool "$FILE_PATH" && exit 5
	echo '----- File Type Classification -----' \
		&& file --dereference --brief -- "$FILE_PATH" \
		&& exit 5

	exit 1
}

main
