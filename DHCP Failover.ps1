#Configuration de la haute-disponibilité DHCP

#On configure ici un basculement sur le partenaire SRV2 pour une étendue donnée 
# avec un taux d'équilibrage de charge de 70-30 avec comme secret : P@ssw0rd

Add-DhcpServerv4Failover -ComputerName "SRV1" -Name "SRV1-SRV2-Failover" -PartnerServer "SRV2.mydomain.local" -ScopeId 192.168.1.0 -ServerRole Active -LoadBalancePercent 70 -SharedSecret "P@ssw0rd"
