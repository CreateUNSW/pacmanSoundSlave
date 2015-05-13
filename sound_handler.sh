#!/bin/sh
playCommand="aplay -q"
signalChomp=34
alias killLoop="{ kill %1; } &>/dev/null"

function soundLoop()
{
	isChomping=0
	trap isChomping=1 $signalChomp
	while true
	do
		if [ $isChomping -eq 0 ]
		then
			${playCommand} siren.wav &
		else
			isChomping=0;
			${playCommand} chomp.wav &
		fi
		sleep 0.35
	done
}

while true
do
	input='0'
	read -n 1 input
	case $input in
		1)	# Start wakka sound loop
			killLoop
			${playCommand} start.wav
			soundLoop &
			;;
		2) # Tell next loop to play a chomp
			kill -$signalChomp %1
			;;
		3) # Intermission
			killLoop
			${playCommand} intermission.wav
			;;
		4) # Gameover
			killLoop
			${playCommand} death.wav
			;;
		q) # Exit (for debugging)
			killLoop
			echo 
			exit 0
			;;
	esac
done
