while true; do
			echo "available tables : "
			ls -F
			echo "enter table you want remov : "
			read trm
			if [[ -f $trm ]];
				then
				echo " are you sure you want drop $trm ? y/n "
				read g
				case $g in 
					[Ty]*)
					rm $trm
					echo "$trm deleted"
					break
					;;
					[Nn]*)
					echo "canceled"
					break
					menu_table
					;;
					*)
					echo "invalid option"
				esac
				else
				echo "$trm not exist"	 
			fi
	done 
	menu_table