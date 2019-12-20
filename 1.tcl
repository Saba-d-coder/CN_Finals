#3 nodes point to point

set ns [new Simulator]

set tr [open 1.tr w]
$ns trace-all $tr

set nf [open 1.nam w]
$ns namtrace-all $nf

proc finish {} {
    global ns tr nf
    $ns flush-trace
    close $tr
    close $nf
    exec nam 1.nam &
    exec awk -f 1.awk 1.tr & 
    exit 0
}

set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$ns duplex-link $n1 $n2 2Mb 10ms DropTail
$ns duplex-link $n2 $n3 0.05Mb 10ms DropTail

$ns queue-limit $n1 $n2 10
$ns queue-limit $n2 $n3 8

set udp [new Agent/UDP]
$ns attach-agent $n1 $udp

set null [new Agent/Null]
$ns attach-agent $n3 $null

set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set packetSize_ 512

$ns connect $udp $null

$ns at 0.1 "$cbr start"
$ns at 1.0 "$cbr stop"
$ns at 1.2 "finish"

$ns run