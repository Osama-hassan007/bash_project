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