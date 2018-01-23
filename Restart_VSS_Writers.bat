net stop /y CryptSvc && net start /y CryptSvc
net stop /y CertSvc && net start /y CertSvc
net stop /y VSS && net start /y VSS
net stop /y BITS && net start /y BITS
net stop /y DFSR && net start DFSR /y
net stop /y DHCPServer && net start /y DHCPServer
net stop /y NtFrs && net start /y NtFrs
net stop /y srmsvc && net start /y srmsvc
net stop /y AppHostSvc && net start /y AppHostSvc
net stop /y IISADMIN && net start /y IISADMIN
net stop /y W3SVC && net start /y W3SVC
net stop /y TSGateway && net start /y TSGateway
rem net stop /y MSExchangeIS && net start /y MSExchangeIS
net stop /y OSearch && net start /y OSearch
net stop /y OSearch14 && net start /y OSearch14
net stop /y TermServLicensing && net start /y TermServLicensing
net stop /y vmms && net start /y vmms
net stop /y NTDS && net start /y NTDS
net start /y "File Replication Service"
net start /y "Kerberos Key Distribution Center"
net start /y "Intersite Messaging"
net stop /y WINS && net start /y WINS
net stop /y Winmgmt && net start /y Winmgmt
net start /y LogMeIn
net start /y "IP Helper"
net stop /y SQLWriter && net start /y SQLWriter
net stop /y SPSearch && net start /y SPSearch
net stop /y SPSearch4 && net start /y SPSearch4
net stop /y SPWriter && net start /y SPWriter
net stop /y SPWriterV4 && net start /y SPWriterV4
net stop /y WSearch && net start /y WSearch
net stop /y EventSystem && net start /y EventSystem
net start /y "System Event Notification Service"
net start /y "File Replication Service"
net start /y "DHCP Server"
net start /y "DFS Replication"
net start /y "Background Intelligent Transfer Service"
net start /y "DNS Server"

