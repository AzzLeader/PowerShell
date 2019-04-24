#Installation du rôle DHCP sur SRV1
Install-WindowsFeature DHCP -IncludeManagementTools -IncludeAllSubFeature

#Creation d'une étendue nommé "Prod" de .100 à .120 avec un bail de 8 heures
Add-DhcpServerv4Scope -Name "Prod" -StartRange 192.168.1.100 -EndRange 192.168.1.119 -SubnetMask 255.255.255.0 -LeaseDuration 8:00:00 -State Active

#Configuration des options du bail : DNS, Gateway, nom de domaine, ...
Set-DhcpServerv4OptionValue -ScopeId 192.168.1.0 -DnsDomain mydomain.local -DnsServer "192.168.1.200","192.168.1.201" -Router 192.168.1.254
