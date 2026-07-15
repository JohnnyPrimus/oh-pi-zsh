#!/usr/bin/env sh
# Update nano from v7 to v8 using a .deb binary.
#
# Usage:
#   ./nano_update.sh /path/to/nano_8.x_amd64.deb
#   ./nano_update.sh https://example.com/mirror/nano_8.x_amd64.deb
#
# Provide the .deb yourself (local file or URL) -- the correct download
# location depends on your distro, release, and architecture, so it isn't
# hardcoded here.
set -e

note() {
	printf '%s\n' "nano_update.sh: $1"
}

die() {
	printf '%s\n' "nano_update.sh: $1" >&2
	exit 1
}

if [ -f ~/.bash_profile ]; then
		note "appending to file: ~/.bash_profile"
		printf '%s\n' "source $dot_sh_file" >> ~/.bash_profile
	elif [ -f ~/.bash_login ]; then
		note "appending to file: ~/.bash_login"
		printf '%s\n' "source $dot_sh_file" >> ~/.bash_login
	fi

SOURCE="http://http.us.debian.org/debian/pool/main/n/nano/nano_8.4-1+deb13u1_amd64.deb"

if [ "$#" -gt 1 ]; then
    die "usage: $0 <path-or-url-to-nano-8-deb>"
elif [ "$#" -eq 1 ]; then
    SOURCE="$1"
fi


REQUIRED_MAJOR=8
WORKDIR="$(mktemp -d)"
DEB_FILE="$WORKDIR/nano.deb"
trap 'rm -rf "$WORKDIR"' EXIT

command -v dpkg >/dev/null 2>&1 || die "dpkg not found; this script targets Debian/Ubuntu systems"

# --- Report current version -------------------------------------------------
if command -v nano >/dev/null 2>&1; then
	CURRENT_VERSION="$(nano --version | awk '/GNU nano/ {print $4}')"
	note "current nano version: ${CURRENT_VERSION:-unknown}"
else
	note "nano is not currently installed"
fi

# --- Obtain the .deb ---------------------------------------------------------
case "$SOURCE" in
	http://*|https://*)
		note "downloading $SOURCE"
		if command -v curl >/dev/null 2>&1; then
			curl -fL -o "$DEB_FILE" "$SOURCE"
		elif command -v wget >/dev/null 2>&1; then
			wget -O "$DEB_FILE" "$SOURCE"
		else
			die "need curl or wget to download from a URL"
		fi
		;;
	*)
		[ -f "$SOURCE" ] || die "file not found: $SOURCE"
		DEB_FILE="$SOURCE"
		;;
esac

case "$CURRENT_VERSION" in
	"$REQUIRED_MAJOR".*)
		note "current version is already ${REQUIRED_MAJOR}.x; no update needed"
		exit 0
		;;
	6.*)
		note "current version is 6.x; skipping update (updates to libc required. need ubuntu 24.04 or debian 13)"
		exit 0
		;;
esac

# --- Sanity-check the package -------------------------------------------------
dpkg-deb --info "$DEB_FILE" >/dev/null 2>&1 || die "not a valid .deb file: $DEB_FILE"

PKG_NAME="$(dpkg-deb -f "$DEB_FILE" Package)"
PKG_VERSION="$(dpkg-deb -f "$DEB_FILE" Version)"
[ "$PKG_NAME" = "nano" ] || die "package name is '$PKG_NAME', expected 'nano'"

case "$PKG_VERSION" in
	"$REQUIRED_MAJOR".*) ;;
	*) die "package version is $PKG_VERSION, expected ${REQUIRED_MAJOR}.x" ;;
esac

note "installing $PKG_NAME $PKG_VERSION"

# --- Install ------------------------------------------------------------------
SUDO=""
[ "$(id -u)" -eq 0 ] || SUDO="sudo"

$SUDO dpkg -i "$DEB_FILE" || {
	note "resolving missing dependencies"
	$SUDO apt-get install -f -y
	$SUDO dpkg -i "$DEB_FILE" || die "failed to install $DEB_FILE"
}

# --- Verify ---------------------------------------------------------------
NEW_VERSION="$(nano --version | awk '/GNU nano/ {print $4}')"
case "$NEW_VERSION" in
	"$REQUIRED_MAJOR".*)
		note "Done! nano updated to version $NEW_VERSION"
		;;
	*)
		die "install finished but nano reports version $NEW_VERSION, not ${REQUIRED_MAJOR}.x"
		;;
esac
