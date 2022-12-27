 echo "Available tables : "
                ls -F

                read -p "Enter table Name: " TableTo_delete_from
				if [[ -f $TableTo_delete_from]]; then

                cat $TableTo_delete_from
                
					echo "Now you are going in the vi mode to edit the file and delet from it, follow these instructions: "
					echo "############################################################################################"
					echo "1- Press i to enter the insert mode and then delete the table with the value you want."
					echo "2- Press ESC to exit the insert mode and type :wq to save and exit."
					echo "############################################################################################"
					echo "Please confirm by pressing 1 or exit by pressing 2"
					select confirmation in "Yes" "No" ; do
					case $confirmation in
					Yes)
					vi $TableTo_delete_from
					echo "Ok! Here is the updated file:"
					cat $TableTo_delete_from
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
				echo "$TableTo_delete_from not exist"
				fi	