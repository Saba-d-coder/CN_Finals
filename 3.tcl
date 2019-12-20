# 4 node point to point TCP and UDP

set ns [new Simulator]

set tr [open 3.tr w]
$ns trace-all $tr

set nf [open 3.nam w]
$ns namtrace-all $nf

proc finish {} {
    global ns tr nf
    $ns flush-trace
    close $tr
    close $nf
    exec nam 3.nam &
    exec awk -f 3.awk 3.tr & 
    exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$ns duplex-link $n0 $n2 2Mb 10ms DropTail
$ns duplex-link $n1 $n2 2Mb 10ms DropTail
$ns duplex-link $n2 $n3 900kb 10ms DropTail

$ns queue-limit $n0 $n2 10

set tcp [new Agent/TCP]
$ns attach-agent $n0 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n3 $sink

$ns connect $tcp $sink

set ftp [new Application/FTP]
$ftp attach-agent $tcp

set udp [new Agent/UDP]
$ns attach-agent $n1 $udp
set null [new Agent/Null]
$ns attach-agent $n3 $null

set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set packetSize_ 512
$cbr set interval_ 0.005

$ns connect $udp $null

$ns at 0.1 "$ftp start"
$ns at 0.5 "$cbr start"
$ns at 1.0 "$cbr stop"
$ns at 1.2 "$ftp stop"
$ns at 1.5 "finish"

$ns run