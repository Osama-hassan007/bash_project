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