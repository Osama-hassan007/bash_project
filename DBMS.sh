#!/usr/bin/bash
shopt -s extglob
export LC_COLLATE=C
PS3="please selcte : "
echo "|=======================|"
echo "|Welcome To Our K&O DBMS|"
echo "|=======================|"  
function main_menu() {                              
select m in "createDB" "listDB" "connectDB" "dropDB" "exit"
do
	case $m in 
	createDB)
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
	;;
	listDB)
	echo "available databases :"
	ls -F | grep /
	main_menu
	;;
	connectDB)
	function connect() {
	echo "available databases :"
	ls -F | grep /
	echo "enter database name you want connect : "
	read db
	if [[ -d $db ]];
	then
	cd $db 
	PS3="you are in $db : "
	function menu_table(){
	select T in "create table" "lsit tables" "drop table" "insert into table" "select from table" "delete from table" "update table" "main menu"
	do 
	case $T in 
	"create table")
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
	;;
	"lsit tables")
	echo "available tables : "
		ls -F  
		menu_table
	;;
	"drop table")
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
	;;
	"insert into table")
	echo "available tables : "
	ls -F 
	read -p "Enter table Name: " insertb
                if [[ -f $insertb ]]; then
                  typeset -i cn=$(awk -F"|" '{if(NR==1){print NF}}' $insertb)

                  for ((i = 1; i <= $cn; i++)); do
                    colname=$(awk -F"|" -v"i=$i" '{if(NR==1){print $i}}' $insertb)
                    coltype=$(awk -F"|" -v"i=$i" '{if(NR==1){print $i}}' $insertb)
                 
				    
                    while true; do
                      read -p "Enter $colname " value
                      
                        if [[ $i != $cn ]]; then
                          
                          echo -n $value"|" >>$insertb
                          echo "Value 1 Added!"
                          break
                        else
                          echo -n $value >>$insertb
                          echo "Value 2 Added!"
                          break

                        fi
                      
                      
                      
                    done
                  done
                else
                  echo "$insertb doesn't exist"
                fi
	;;
	"select from table")
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
	;;
	"delete from table")
	echo "available tables : "
	ls -F 
	read -p "Enter table Name: " dtb
		if [[ -f $dtb ]]; then
				awk -F "|" 'BEGIN{FS=" | "}{if(NR==1){print $0}}' $dtb;
				read -p "Enter column to delete record from  : " coldel;
				read -p "Enter value : " vldel;
				awk -F "|"  'BEGIN{FS="|"}
				{
					if(NR==1){
						for(i=1;i<=NF;i++){
							if($i=="'$coldel'"){var=i}
						}
					}
					else{
						if($var=='$vldel'){
							loc=NR
						}
					}
					{if(NR!=loc)print 
					}
				}' $dtb > tmp $dtb;
			else
				echo "$dtb doesn't exist";
		fi
	;;
	"update table")
	  echo "Available tables : "
                ls -F

                read -p "Enter table Name: " TableToBeUpdated
				if [[ -f $TableToBeUpdated ]]; then

                cat $TableToBeUpdated
                
					echo "Now you are going in the vi mode to edit the file and update it, follow these instructions: "
					echo "############################################################################################"
					echo "1- Press i to enter the insert mode and then update the table with the value you want."
					echo "2- Press ESC to exit the insert mode and type :wq to save and exit."
					echo "############################################################################################"
					echo "Please confirm by pressing 1 or exit by pressing 2"
					select confirmation in "Yes" "No" ; do
					case $confirmation in
					Yes)
					vi $TableToBeUpdated
					echo "Ok! Here is the updated file:"
					cat $TableToBeUpdated
					;;
					No)
					exit
					;;
					*)
					echo "Invalid Option!"
					;;
					esac
					done
				else 
				echo "$TableToBeUpdated not exist"
				fi	
	;;
	"main menu")
	main_menu
	;;
	*)
	echo "$REPLY wrong choise try again ! ";
	exit
	;; 
	esac
	done }
	menu_table
	else
	echo "database not exist"
	connect
	fi }
	connect
	;;
	dropDB)
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
	;;
	exit )
	echo " GOOD BYE"
	exit 
	;;
	*)
	echo -n "wrong choise 
	please try again :" 
	esac
done }
main_menu

