param($subnet, $server)
For ($x=1;$x -lt 255; $x++){
    Resolve-DnsName -DnsOnly "$subnet.$x" -Server $server -ErrorAction Ignore
} 