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
	. createdb.sh 
	;;
	listDB)
	. listdb.sh
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
	. create_t.sh 	 
	;;
	"lsit tables")
	. list_t.sh 
	;;
	"drop table")
	. drop_t.sh 
	;;
	"insert into table")
	. insert_t.sh 
	;;
	"select from table")
	. select_t.sh 
	;;
	"delete from table")
	. delete_t.sh 
	;;
	"update table")
	. update_t.sh 
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
	. dropdb.sh
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

