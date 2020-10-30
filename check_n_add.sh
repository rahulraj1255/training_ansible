#!/usr/bin/env bash

IFS='/'
shell=$SHELL
read -a shells <<< "$SHELL"
IFS=' '
shell=${shells[-1]}

case "$shell" in
	bash )
		profile="~/.bashrc"
		;;
	zsh )
		profile="~/.zshrc"
		;;
	ksh )
		profile="~/.profile"
		;;
	fish )
		profile="~/.config/fish/config.fish"
		;;
	* )
	profile="your profile"
	return 1
	;;
esac

eval profile=$profile

case "$shell" in
	fish )
		lines= 'set -x PATH \"${PYENV_ROOT}/bin\" \$PATH
status --is-interactive; and . (pyenv init -|psub)
status --is-interactive; and . (pyenv virtualenv-init -|psub)'
		#echo "set -x PATH \"${PYENV_ROOT}/bin\" \$PATH" >> ${profile}
		#echo 'status --is-interactive; and . (pyenv init -|psub)' >> ${profile}
		#echo 'status --is-interactive; and . (pyenv virtualenv-init -|psub)' >> ${profile}
		;;
	* )
		lines='PATH="/home/pyapp/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"'
		#echo "export PATH=\"${PYENV_ROOT}/bin:\$PATH\"" >> ${profile}
		#echo "eval \"\$(pyenv init -)\"" >> ${profile}
		#echo "eval \"\$(pyenv virtualenv-init -)\"" >> ${profile}
		;;
esac
#lines=$1
patternfound=1
filename=$profile
IFS=$'\n'
readarray -t lines <<< "$lines"
for line in ${lines[@]}; do
	echo "In lop"
	grep "$line" "$filename" >> /dev/null
	if (( $? == 1 )); then
		patternfound=0
	fi
done

	
#filename=$profile
#pcregrep -M '$lines' "$filename" >> /dev/null
if (( $patternfound == 0 )); then
	echo "Pattern not found! Appending"
	for line in ${lines[@]}; do
		echo "$line" >> "$filename"
	done
else
echo "Pattern found!"
fi
