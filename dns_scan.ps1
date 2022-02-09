$subnet=$args[0]
$server=$args[1]

For ($x=1;$x -lt 255; $x++){
    Resolve-DnsName -DnsOnly $subnet.$x -Server $server -ErrorAction Ignore
} 