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
		echo "$tn created " 
		break 
		else
		echo "error: enter charchter only! " 
	fi
done
while true; do
	echo "How many columns in your table? "
	read n
	if [[ $n =~ ^[0-9]$ ]]; then
		break
		else
		echo "error! enter a number :" 
	fi
done
for (( i = 1; i <= n; i++ )); do
	
	while true ; do 
		echo "enter column $i name : "
		read cn
		if [[ $cn =~ ^[a-z|A-Z]+$ ]];
			then 
			break 
			else
			echo "error: enter charchter only! "
		fi
	done
	
	while true ; do
	        echo " enter column $i data type [int/string]"
	        read ct
		if [[ $ct != *(int)*(string) ]];
			then 
			echo "inavaled data type"
			else
			break
	        fi
	done	
	
	if [[ i -eq $n ]];
	then
	echo $cn >> $tn
	echo $ct >> $tn.tp
	else
	echo -n ":" $cn >> $tn
	echo -n ":" $ct >> $tn.tp
	
	fi
done
echo "$tn has been created sucsesfuly"
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
;;
"select from table")
;;
"delete from table")
;;
"update table")
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

