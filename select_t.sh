	echo "available tables : "
	ls -F 
	echo "enter table name :"
	read st 
	typeset -i cn=$(awk -F"|" '{if(NR==1){print NF}}' $st)
	if [[ -f $st  ]]; then
		select selectable in "select all table" "select specific column" ;
		do
			case $selectable in 
			"select all table" )
			cat $st 
			;;
			"select specific column" )
			# read -p "Enter Number of column: " number
			# for (( i = 1; i <= number; i++ )); 
			# do
			# 	read -p "Enter column $number name: " colname;
			# 	awk -F "|" '{if(NR=2){
			# 		for(i=1 ;i <= NF; i++){
			# 					if($i=="'$colname'"){
			# 						var=i
			# 				    break;
			# 				}
			# 			}
			# 		} {print $var}
			# 	}' $st
			# done
			for (( i=1 ; i <= $cn ; i++ )) ; do
                        read -p "Enter the column name : " colname
						if [[ $colname == $i  ]];then
                        cut -d "|" -f $i $st
						else
						echo "$colname not exist"
						fi

            done
			;;
			*)
			echo "invaled option" 
			
			esac
		done
		else 
		echo "$st not exist "
	fi 