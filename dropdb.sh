	while true
	do
		echo "available databases :"
		ls -F | grep /
		echo "enter database you want remove : "
		read name
		if [[ -d $name ]] ;
			then
			echo "Are you You Want To drop $name Database? y/n"
			read x
			case $x in 
				[Yy]* ) 
				rm -r $name 
				echo "$name has been deleted"
				break
				;;
				[Nn]* )
				echo "Canceled"
				break
				;;
				* )
				echo "invalid option"
				;;
			esac
			else 
			echo "$name doesn't exist"
			echo "try again....."
		fi
	done