
while true
	do
		echo "enter databaes name ?"
		read ans 
		if [[ -d $ans ]] ;
			then
			echo "danatabase $ans exist"
			elif [[ $ans =~ ^[a-z|A-Z]+$ ]];
			then
			mkdir $ans
			echo "$ans created sucsesfuly" 
			break 
			else
			echo "error: enter charchter only! " 
		fi
	done
	main_menu