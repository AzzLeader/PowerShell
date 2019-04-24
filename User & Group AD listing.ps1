#####  You must save this script in.ps1 and modify it with your own OU if you want it to work.#######

##### Script counting and listing AD users and groups in the order of their creation ####### 
 
#Imports of modules
Import-Module ActiveDirectory 

#Variables
$Users = Get-ADUser -Filter * -SearchBase "dc=mydomain,dc=local"
$Groups = Get-ADGroup -Filter * -SearchBase "dc=mydomain,dc=local"
$i=0
$n=0

#Listing of users in lowercase
echo "  "
echo "Utilisateurs : "
echo "  "
foreach ($User in $Users) { 
    $i++
    $USERNAME= $User.sAMAccountName.ToLower() 
    echo "User : $USERNAME  numero : $i"
 
}
#Listing of groups in lowercase
echo "  "
echo "Groupes : "
echo "  "
foreach ($Group in $Groups) { 
    $n++
    $GROUPNAME= $Group.sAMAccountName.ToLower() 
    echo "Group : $GROUPNAME  numero : $n"
 
}

echo "  "
echo "There are a total of $n groups in the AD"
echo "  "
echo "  "
echo "There are a total of $i users in the AD"
echo "  "
