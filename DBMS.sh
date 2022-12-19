#!/usr/bin/bash
echo "|===================|"
echo "|Welcome To Our DBMS|"
echo "|===================|"                                
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
elif [[ $ans =~ -?[0-9]+ ]];
then
echo "error: please try again"
else
mkdir $ans
echo $ans created sucsesfuly 
break 
fi
done
;;
listDB)
echo "available databases :"
ls -F | grep /
;;
connectDB)
echo "available databases :"
ls -F | grep /
echo "enter database name : "
read db
if [[ -d $db ]];
then
cd $db 
PS3="you are in $db : "
select T in "create table" "lsit table" "drop table" "insert into table" "select from table" "delete from table" "update table"
do 
case $T in 
"create table")
echo " enter table name :"
read tname 
if [[ -f $tname ]];
then
echo "$tname table is  exist" 
elif [[ $ans =~ -?[0-9]+ ]];
then
echo " erro ! please try again"
else 
touch $tname
echo "numbers of field ? "
read q 
 
fi 
;;
"lsit table")
;;
"drop table")
;;
"insert into table")
;;
"select from table")
;;
"delete from table")
;;
"update table")
;;
*)
echo "$REPLY wrong choise try again ! ";
exit
;; 
esac
done
else
echo "database not exist"
fi
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
break 
;;
*)
echo -n "wrong choise 
please try again :" 
esac
done 

