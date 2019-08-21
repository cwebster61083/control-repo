Get-WmiObject win32_networkadapterconfiguration -Filter 'ipenabled = "true"' | select `
    PSComputerName,
    DNSHostName,
    Caption,
    Description,
    DHCPEnabled,
    MACAddress,
    IPSubnet,
    IPAddress,
    DefaultIPGateway,
    DNSDomain,
    ServiceName,
    DNSServerSearchOrder,
    DHCPLeaseExpires,
    DHCPServer `
    -ErrorAction Continue