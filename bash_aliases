#!/bin/bash
## source this file, not execute it.
##
## Copyright 2000-2013 H Canary
## All Rights Reserved.

scrabble() {
	test "$1" && grep -i "$1" "/usr/share/dict/words" | less
}
#
# Useage:
#   scrabble.sh PATTERN
# Example:
#   scrabble.sh '^a[lonrchl]\{4,7\}$'

v () {
	test $# -lt 1 && { echo "view what?"; return; }
	for arg in "$@"; do
		case "${arg##*.}" in
		png|jpg|jpeg|gif|bmp|tif|tiff|tga|targa|JPG)
			{
	{ test -x /usr/bin/gthumb && \
					/usr/bin/gthumb "$arg" || \
				/usr/bin/eog "$arg" ; } > /dev/null 2>&1 &
			} ;;
		pdf|ps|eps)
			{ /usr/bin/evince "$arg" > /dev/null 2>&1 & } ;;
		txt|tex|c|cxx|cpp|h|hh|cc|C|py|pl|java|hpp|hxx)
			{ /usr/bin/emacs "$arg" \
					--eval '(setq buffer-read-only t)' \
					> /dev/null 2>&1 & } ;;
		htm|html)
			full=`readlink --canonicalize "$arg"`
			{ /usr/bin/google-chrome --password-store=basic "file://${full}" \
					> /dev/null 2>&1 & } ;;
		doc|docx|rtf|odt|odf|odp|ppt|ods|csv|tsv|xls)
			{ /usr/bin/loffice "$arg" > /dev/null 2>&1 & } ;;
		xcf)
			{ /usr/bin/gimp "$arg" > /dev/null 2>&1 & } ;;
		svg)
			{ /usr/bin/inkscape "$arg" > /dev/null 2>&1 & } ;;
		*)
			echo "What do I do with \"$arg\"?";;
		esac;
	done;
}

calc() {
	CALC_BC_DEFAULT='define ln(a) { return l(a); }
define exp(a) { return e(a); }
define pow(a,b) { return e(b*l(a)); }
define sqrtt(a) { return e(0.5*l(a)); }
define log(a) { return l(a)/l(10); }
define lg(a) { return l(a)/l(2); }
define sin(a) { return s(a); }
define cos(a) { return c(a); }
define tan(a) { return s(a)/c(a); }
define sec(a) { return 1/c(a); }
define csc(a) { return 1/s(a); }
define cot(a) { return c(a)/s(a); }
define asin(x) { return a(x/sqrt(1-(x^2))); }
define acos(x) { return a(sqrt(1-(x^2))/x); }
define atan(x) { return a(x); }
define asec(x) { return a(sqrt((x^2)-1)); }
define acsc(x) { return a(1/sqrt((x^2)-1)); }
define acot(x) { return a(1/x);}
define sinh(x) { return (e(x)-e(-x))/2;}
define cosh(x) { return (e(x)+e(-x))/2;}
define tanh(x) { return (e(2*x) - 1)/(e(2*x) + 1); }
define asinh(x) { return l(x+sqrt((x^2)+1)); }
define acosh(x) { return l(x+sqrt((x^2)-1)); }
define atanh(x) { return 0.5*l((1+x)/(1-x)); }
define fact(x) { if (x>1) { return (x * fact (x-1)); }; return (1); }
define comb(n,k) { if (k>1) { return (comb(n-1,k-1) * (n/k)); }; return (n); }
pi = 4*a(1);
define round(x) {
  oscale = scale;
  x = x * (10 ^ (oscale - 1));
  scale = 0;
  tmp = x / 1;
  if (x-tmp >= 0.5) { x = tmp + 1 ;
  } else { x = tmp ; }
  scale = oscale-1;
  x = x / (10 ^ (oscale - 1));
  scale = oscale;
  return x;
}
define ceil(x) {
  oscale = scale;
  scale = 0;
  tmp = x / 1;
  scale = oscale;
  if (x == tmp) { return x; }
  return round(0.5+x);
}
define min(x,y) { if (x < y) { return x; } ; return y; }
scale = 6;
'
	CALC_BC_SEDCMD='s/×/*/g;s/−/-/g;s/\$//g;'
	if [ "$#" -gt 0 ] ; then
		{ echo "$CALC_BC_DEFAULT" ; echo "$@" | sed "$CALC_BC_SEDCMD"; } | bc -l
	else
		{ echo "$CALC_BC_DEFAULT" ; cat - | sed "$CALC_BC_SEDCMD"; } | bc -l
	fi
}

scalc() { echo $(( $@ )) ; }
foldless() { fold -s -w 66 "$@" | less ; }
fold80less() { fold -s -w 80 "$@" | less ; }
fold72less() { fold -s -w 72 "$@" | less ; }
recent() { ls -Hort --color=yes "$@" | tail -24; }
rms() {
	test "$#" -eq 0 && { echo "argument?" ; return ; }
	TRASHDIR="/tmp/${USER}/Trash"
	for arg in "$@"; do
		d=`readlink -f "$arg"`
		x=`dirname "$d"`
		d="${TRASHDIR}/${x}"
		mkdir -p "$d"
		mv -v "$arg" "$d"
	done
}
coin() { echo -n "random byte -> ";
		head -c1 /dev/random | hexdump -e '1/1 "%02x\n"'; }

rot13() {
	test "$#" -gt 0 && { echo "$@" | tr A-Za-z N-ZA-Mn-za-m ; exit 0; }
	tr A-Za-z N-ZA-Mn-za-m
}

alias hexify="hexdump -v -e '16/1 \"%02x \" \"\\n\"' -v"
alias actual_size='stat --printf "%s\t%n\n"'
alias beep='echo -en "\a"'
alias buffer="perl -e 'my @l = <>; print @l;'"
alias charcount="wc -c -m"
alias chx="chmod +x"
alias cl="clear"
alias cpd="cp --parents"
alias r="reset"
alias myni="ps -o ni h $$"
alias niceme="renice 5 $$"
alias scr="screen -R"
alias dfh="df -h"
alias grepi="grep -i"
alias iconv-latin1-to-utf8="iconv -f latin1 -t utf-8"
alias l="ls --color=always -shF"
alias e="emacs -nw"
alias isodate="date +%Y-%m-%d"
alias la="last -21"
alias less4="less -x4"
alias less2="less -x2"
alias findhere="find . -iname"
alias rf="readlink -f"
alias les="less -N -I -S"

pu() {
	[ "$1" ] || { ps -u "$USER" ; return ; }
	ps -u "$USER" | grep "$1"
}

zipd() {
	test $# -lt 1 && { echo "zipd what?"; return; }
	for arg in "$@"; do
		test -d "$arg" || {
			echo "'${arg}' should be a directory.";
			return;
		}
		out=`basename "$arg"`".zip"
		test "$out" = "..zip" -o "$out" = "...zip" && {
			out=`readlink -f $arg`;
			out=`basename $out`".zip"; }
		echo "zip -r \"${out}\"  \"${arg}\""
		zip -r "$out"  "$arg"
		echo ""
	done
}
zipd2() {
	## Sort filenames in zip file
	test $# -lt 1 && { echo "zipd what?"; return; }
	for arg in "$@"; do
		test -d "$arg" || {
			echo "'${arg}' should be a directory.";
			return;
		}
		out=`basename "$arg"`".zip"
		test "$out" = "..zip" -o "$out" = "...zip" && {
			out=`readlink -f $arg`;
			out=`basename $out`".zip"; }
		echo "find \"$arg\" -type f | sort | zip \"$out\" -@"
		find "$arg" -type f | sort | zip "$out" -@
		echo ""
	done
}

dos2unix-() {
	for file in "$@"; do
		sed -i 's/\r//' "$file"
	done
}
unix2dos-() {
	for file in "$@"; do
		sed -i 's/\r//g;s/$/\r/' "$file"
	done
}

rmsymlink() {
	for file in "$@"; do
		file=`echo "$file" | sed 's|/$||'`
		test -h "$file" && {
			rm -v "$file" ;
		} || {
			echo "\"${file}\" is not a symbolic link." ;
		}
	done
}

genpasswd() {
	# genpasswd.sh
	#   Generate a random password with almost
	#   144 bits of randomness, making use of
	#   /dev/random.
	# Note:
	#   Most online services have somewhat
	#   arbitrary rules about what characters
	#   can be included in a password. So we
	#   limit ourselves to A-Za-z0-9.
	# Copyright 2007 Hal Canary
	# Dedicated to the Public Domain.
	echo "Grabbing bits from /dev/random..." 1>&2
	head -c 18 /dev/random | base64 | \
			sed 's/\//Z/g;s/+/z/g;'
	# If you lack base64 on your system, try:
	# head -c 18 /dev/random  | uuenview -b '' | \
	#	   sed 's/\//Z/g;s/+/z/g;'
}

amp() {
	( nohup "$@" > /dev/null 2>&1 & disown ) > /dev/null 2>&1 ;
}
complete -F _command amp


Diary() {
	YEAR=`date +%Y`
	DIARY_DIRECTORY="${HOME}/Documents/Diary/${YEAR}"
	mkdir -p "$DIARY_DIRECTORY"
	DIARY_PATH="${DIARY_DIRECTORY}/diary-`date +%Y-%m-%d`.txt" ;
	echo "$DIARY_PATH" ;
	xe "$DIARY_PATH" ;
}

unzip-nozipbomb() {
	for zipfile in "$@" ; do
		dir=$(basename "${zipfile}" .zip)
		if [ "${dir}" = "${zipfile}" ] ; then
		dir="${dir}.d"
		fi
		mkdir -p "${dir}"
		unzip -d "${dir}" "${zipfile}"
	done ;
}

savestate() {
	# poor-man's version control
	for FILE in "$@" ; do
	DATE=`stat -c %y "$FILE" `
	DATE=`echo ${DATE:0:19} | sed 's/[-: ]//g'`
	cp -a "$FILE" "${DATE}_${FILE}"
	done;
}

prepend-date() {
	for FILE in "$@" ; do
		X=`stat -c %y "$FILE" `
		DATE=`echo ${X:0:19} | sed 's/://g;s/ /_/g'`
		mv -vi "$FILE" "${DATE}_${FILE}"
	done
}

lsd() {
	/bin/ls -1F "$@" | grep '/$';
}

alias cleanshell="PS1='$ ' sh"

alias folds='/usr/bin/fold -s -w "$COLUMNS"'

prepend-something () {
   something="$1"
   shift
   for arg in "$@"; do
       mv -v "$arg" "${something}${arg}"
   done
}

alias ba='source ${HOME}/.bash_aliases'

alias cdcd='cd `pwd -P`'


cdc() {
    cd `readlink -n --canonicalize "$1"`
}

cdt() {
    if test -d '/playpen2' ; then
		MY_TMPDIR="/playpen2/${USER}/tmp"
    else
		MY_TMPDIR="/tmp/${USER}"
    fi
    mkdir -p "$MY_TMPDIR"
    cd `mktemp -d "--tmpdir=$MY_TMPDIR" tmp-XXXXXX`
}

convert2png () {
	for arg in "$@" ; do
		[ -f "$arg" ] || { echo "-f ${arg} ?"; continue; }
		convert "$arg" "${arg}.png"
		touch -m -c -r "$arg" "${arg}.png"
		echo "${arg}.png"
	done
}

s() {
    grep -Ir "$1" . | cut -c -$COLUMNS
}

untar() {
	test "$#" -gt 0 || {
		echo "Useage:  untar ARCHIVEFILE[S]";
		return;
	}
	for arg in "$@"; do
		ext="${arg##*.}"
		test -f "$arg" || { echo not a file; continue; }
		if [ "$ext" = "bz2" -o "$ext" = "tbz" -o "$ext" = "tb2" ]; then
			echo 'tar --extract --bzip2 --file' "\"${arg}\""
			tar --extract --bzip2 --file "$arg"
		elif [ "$ext" = "tgz" -o "$ext" = "gz" ]; then
			echo 'tar --extract --gzip --file' "\"${arg}\""
			tar --extract --gzip --file "$arg"
		elif [ "$ext" = "tar" ]; then
			echo 'tar --extract --file' "\"${arg}\""
			tar --extract --file "$arg"
		fi
	done

}

alias glog='git log --abbrev-commit --graph --color "--pretty=format:	%h %cr	%an: %s"'

make-() {
    clear; make "$@" 2>&1 | head
}

runcxx() {
    F=`mktemp`
    c++ -Wall -g -std=c++0x  -o "$F" "$@" && "$F"
}

random_float() {
    python -c 'import random; print random.random()'
}
random_integer() {
    python -c "import random; print random.randint(0,(${1:-4294967296})-1)"
}

lsman() {
    for x in "/usr/share/man/man"*"/${1}."*.gz ; do
	basename "$x" .gz
    done
}

poweroff() {  pre_exit ; sudo /sbin/poweroff && logout ; }
pow() { pre_exit ; sudo /sbin/poweroff && logout ; }
reboot() { pre_exit; sudo /sbin/reboot && logout ; }

myip() { /sbin/ifconfig | sed -n 's/^.*inet addr:\([^ ]*\) .*$/\1/p' ; }

add_to_resolv() {
    { for arg in "$@"; do echo "nameserver ${arg}" ; done ; } \
	| sudo resolvconf -a "dummy.${USER}" ; }

despacify() {
	for arg; do
		new=`echo "$arg" | sed "s/['\"]//g;s/&/+/g;s/[^[:alnum:]._-+]/_/g"`
		if test "$arg" '!=' "$new"; then
			mv -v "$arg" "$new"
		fi
	done
}

every_nth_line() {
    N=$1
    shift
    awk "NR%${N}==0" "$@"
}

pstree-term() {
	SSHD_PID=`ps --no-headers --format pid -C sshd | head -1`
	for x in $SSHD_PID \
		`ps --no-headers --format pid -C gnome-terminal` \
		`ps --no-headers --format pid -C xterm` ; do
		pstree -l -u -p -h $x
	done
}
pythoncalc0() {
	/usr/bin/python2 <<-EOF
		import math, numpy, os, sys, re;
		lg = lambda x : math.log(x, 2);
		fact = lambda x : math.factorial(int(math.ceil(x)));
		exp = math.exp;
		lgs = lambda n: 0 if n < 2 else 1 + lgs(lg(n));
		sqrt = math.sqrt
		print $@
	EOF
}

tmpcompile() {
	D="${HOME}/src/tmp/tmp_$(date +%Y-%m-%d_%H%M%S)"
	mkdir -p "$D"
	cat <<-EOF | sed 's/^TAB/\t/' > "${D}/Makefile"
		executable_file_name = test
		main_filename = main.cxx
		cxxfiles =

		CXX = g++
		objects := \$(cxxfiles:.cxx=.o)
		headers := \$(cxxfiles:.cxx=.h)

		.PHONY : clean all
		all : \$(executable_file_name)
		\$(executable_file_name) : \$(main_filename) \$(objects)
		TAB\$(CXX) \$(CXXFLAGS) \$^ -o \$@
		%.o: %.cxx \$(headers)
		TAB\$(CXX) -c \$(CXXFLAGS) \$< -o \$@
		clean:
		TABrm -f -v \$(objects)
		EOF
	{
		echo -e "#include <iostream>\nusing namespace std;\n"
		echo -e "int main(int argc, char ** argv) {\n"
		echo -e "	cout << \"hello world!\";\n}\n\n"
	} > "${D}/main.cxx"
	echo "${D}/main.cxx"
	echo "make -C ${D}"
}

tmpcompileqt() {
	D="${HOME}/src/tmp/tmp_$(date +%Y-%m-%d_%H%M%S)"
	mkdir -p "$D"
	cat <<-EOF | sed 's/^TAB/\t/' > "${D}/projet.pro"
		# qmake -o Makefile projet.pro
		CONFIG += qt
		SOURCES += main.cxx
		TARGET = test
	EOF
	{
		echo "#include <QString>"
		echo "#include <iostream>"
		echo "using namespace std;"
		echo "int main(int argc, char ** argv) {"
		echo "  QString s(\"hello world!\");"
		echo "  cout << qPrintable(s) << endl;"
 		echo "}"
	} > "${D}/main.cxx"
	echo "${D}"
}

alias nocomments="grep -v '\(^#\|^\s*$\)'"