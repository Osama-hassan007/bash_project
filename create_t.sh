while true
	do
		echo "enter table name ?"
		read tn 
		if [[ -f $tn ]] ;
			then
			echo  "table $tn exist" 
			echo "choose another name ! "
			elif [[ $tn =~ ^[a-z|A-Z]+$ ]];
			then
			touch $tn
			break 
			else
			echo "error: enter charchter only! " 
		fi
	done
	while true; do
		echo "Num of columns in your table? "
		read n
		if [[ $n =~ ^[0-9]$ ]]; then
			break
			else
			echo "error! enter a number :" 
		fi
	done
	for (( i = 1; i <= n; i++ )); do
		
		while true ; do 
			echo "Column No $i Name : "
			read cn
			if [[ $cn =~ ^[a-z|A-Z]+$ ]];
				then 
				break 
				else
				echo "error: enter charchter only! "
			fi
		done
				echo " enter column $i data type [int/string]"
				select ct in "int" "string";do
				
				case $ct in
				"int")
					ct="int"
					break
				;;
				"string")
					ct="string"
					break
				;;
				*)
					echo "invaled choise ! choose again"
				esac
				done
					
			if [[ i -eq $n ]];
			then
			echo -n $cn ":" $ct >> $tn
			elif [[ i -eq 1 ]]
			then
			echo -n $cn ":" $ct "(pk) | " >> $tn
			else
			echo -n $cn ":" $ct "|" >> $tn
		fi	
	done
	echo "$tn has been created sucsesfuly"
	echo -e  >>$tn
	menu_table