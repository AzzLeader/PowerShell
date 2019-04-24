#Installation du rôle sur SRV1
Add-WindowsFeature AD-Domain-Services -IncludeManagementTools -IncludeAllSubFeature

#Création de la forêt mydomain.local avec comme nom NetBios : MYDOMAIN
# + création du DNS + redemarrage du serveur
Install-ADDSForest -DomainName "mydomain.local" -DomainNetbiosName "MYDOMAIN" -InstallDNS -ForestMode Default -NoRebootOnCompletion $false

###                 #####                       ######                          ######

#Installation du rôle sur SRV2
Add-WindowsFeature AD-Domain-Services -IncludeManagementTools -IncludeAllSubFeature

#Ajout du second controlleur au domaine.
Install-ADDSDomain-Controller -DomainName "mydomain.local" -credential "MYDOMAIN\Administrateur" -SkipAutoConfigureDns -ReplicationSource SRV1.mydomain.local
