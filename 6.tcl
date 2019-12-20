# 6-10 nodes LAN change error rate

set ns [new Simulator]

set tr [open 6.tr w]
$ns trace-all $tr

set nf [open 6.nam w]
$ns namtrace-all $nf

set error_rate 0.00

proc finish {} {
    global ns tr nf
    $ns flush-trace
    close $tr
    close $nf
    exec nam 6.nam &
    exec gawk -f 6.awk 6.tr & 
    exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

$ns duplex-link $n0 $n2 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns simplex-link $n2 $n3 0.3Mb 100ms DropTail
$ns simplex-link $n3 $n2 0.3Mb 100ms DropTail

set lan [$ns newLan "$n3 $n4 $n5" 0.5Mb 40ms LL Queue/DropTail MAC/802_3 Channel]

$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient right-up
$ns simplex-link-op $n2 $n3 orient right

$ns queue-limit $n2 $n3 20
$ns simplex-link-op $n3 $n2 queuePos 0.5

set error [new ErrorModel]
$error ranvar [new RandomVariable/Uniform]
$error drop-target [new Agent/Null]
$error set rate_ $error_rate
$ns lossmodel $error $n2 $n3

set tcp [new Agent/TCP/Newreno]
$ns attach-agent $n0 $tcp
$tcp set packetSize_ 552
$tcp set window_ 8000

set sink [new Agent/TCPSink/DelAck]
$ns attach-agent $n4 $sink

$ns connect $tcp $sink

set ftp [new Application/FTP]
$ftp attach-agent $tcp

# ------------------------------------------

set udp [new Agent/UDP]
$ns attach-agent $n1 $udp

set null [new Agent/Null]
$ns attach-agent $n5 $null

set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set type_ CBR
$cbr set packetSize_ 1000
$cbr set rate_ 0.2Mb
$cbr set random_ false

$ns connect $udp $null

$ns at 0.0 "$n0 label TCP_Traffic"
$ns at 0.0 "$n1 label UDP_Traffic"
$ns at 0.1 "$cbr start"
$ns at 1.0 "$ftp start"
$ns at 124.1 "$ftp stop"
$ns at 125.0 "$cbr stop"
$ns at 125.1 "finish"

$ns run