for ((k = 0; k <= 10 ; k++))
do
	    echo -n "[ "
	    for ((i = 0 ; i <= k; i++)); do echo -n "###"; done
	    for ((j = i ; j <= 10 ; j++)); do echo -n "   "; done
		    v=$((k * 10))
		    echo -n " ] "
		    echo -n "$v %" $'\r'
		    sleep 1
		done
	echo
