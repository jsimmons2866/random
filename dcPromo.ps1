 #Areyousure function. Allows user to select Yes or No when asked to exit. Yes exits and No returns to main menu.   
 function areyousure {$areyousure = read-host "Are you sure you want to exit? (yes/no)"   
           if ($areyousure -eq "yes"){exit}   
           if ($areyousure -eq "no"){mainmenu}   
           else {write-host -foregroundcolor red "Invalid Selection"    
                 areyousure   
                }   
                     }   
 #Mainmenu function. Contains the screen output for the menu and waits for and handles user input.   
 function mainmenu{   
 cls   
 echo "---------------------------------------------------------"   
 echo ""   
 echo ""   
 echo "    1. Promote this server to a Domain Controller"     
 echo "    2. Exit"  
 echo ""   
 echo ""   
 echo "---------------------------------------------------------"   
 $answer = read-host "Please Make a Selection"   
 if ($answer -eq 1){$cmd = 'C:\Windows\System32\dcpromo.exe /unattend:C:\answer_file.txt' 
 Invoke-expression $cmd}     
 if ($answer -eq 2){areyousure}   
 else {write-host -ForegroundColor red "Invalid Selection"   
       sleep 5   
       mainmenu  