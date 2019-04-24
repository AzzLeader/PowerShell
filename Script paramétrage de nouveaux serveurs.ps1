#Installation des modules
Install-Module DNSSuffix

#Importation des modules
Import-Module DNSSuffix

#Modifier le suffixe DNS principal du PC
Set-PrimaryDNSSuffix -DNSSuffix mydomain.local

#Si InterfaceIndex est inconnu veuillez decommentez la ligne suivante :
#foreach ($interface in $adapter) {
#    $adapter = Get-NetAdapter
#    if ($interface.Name -like "Ethernet"){
#        $a = $interface.ifIndex
# }
#} 
#Et remplacer la valeur 12 par $a adns les deux prochaines commandes : ( -InterfaceIndex $a )

#Paramétrage de la carte réseau
Set-NetIPAddress -InterfaceIndex 12 -IPAddress 192.168.1.100 -PrefixLength 24 -DefaultGateway 192.168.1.254

#Paramétrage des DNS
Set-DnsClientServerAddress -InterfaceIndex 12 -ServerAddresses 192.168.1.200,192.168.1.201

#Activation de Windows
Set-WindowsProductKey -ProductKey XXXXX-XXXXX-XXXXX-XXXXX-XXXXX

#Renommer le PC
Rename-Computer -NewName "MyServer" #-Restart si il n'y a pas de domaine

#Integrer le serveur au domaine
Add-Computer -DomainName mydomain.local -DomainCredential Administrateur@mydomain.local -OUPath "OU=Serveurs,OU=mydomain,DC=local" -Restart
