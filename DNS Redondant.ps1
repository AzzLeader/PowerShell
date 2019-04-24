#Installation de serveurs DNS redondants

## Sur SRV1 ##

#Installation du rôle DNS
Install-WindowsFeature DNS -IncludeManagementTools -IncludeAllSubFeature

#Ajout d'une ZRD ( zone de recherche directe) mydomain.local avec enregistrement dynamique
Add-DnsServerPrimaryZone -Name mydomain.local -ZoneFile "mydomain.local.dns" -DynamicUpdate NonsecureAndSecure

##Ajout d'une ZRI ( zone de recherche inverse) 1.168.192.in-addr.arpa avec enregistrement dynamique
Add-DnsServerPrimaryZone -NetworkId 192.168.1.0/24 -ZoneFile "1.168.192.in-addr.arpa" -DynamicUpdate NonsecureAndSecure

#Activation du nettoyage toute les semaines car nous sommes en enregistrement dynamique
Set-DnsServerScavenging -ApplyOnAllZones -ScavengingState $true -ScavengingInterval 7:00:00:00

#Ajouts de redirecteurs
Set-DnsServerForwarder -IPAddress "1.1.1.1","8.8.8.8"

#On ajoute SRV2 en tant qu'enregistrement NS pour la ZRD
Add-DnsServerZoneDelegation -IPAddress 192.168.1.201 -Name 1.168.192.in-addr.arpa -ChildZoneName 1.168.192.in-addr.arpa -NameServer SRV2.mydomain.local
#On ajoute SRV2 en tant qu'enregistrement NS pour la ZRD
Add-DnsServerZoneDelegation -IPAddress 192.168.1.201 -Name 1.168.192.in-addr.arpa -ChildZoneName 1.168.192.in-addr.arpa -NameServer SRV2.mydomain.local

### Sur SRV2 ###

#Installation du rôle DNS
Install-WindowsFeature DNS -IncludeManagementTools -IncludeAllSubFeature

#On ajoute les zones dites esclaves ( ou read-only ) avec comme maître SRV1
Add-DnsServerSecondaryZone -Name mydomain.local -ZoneFile "mydomain.local.dns" -MasterServers 192.168.1.200
Add-DnsServerSecondaryZone -Name 1.168.192.in-addr.arpa -ZoneFile "1.168.192.in-addr.arpa" -MasterServers 192.168.1.200
