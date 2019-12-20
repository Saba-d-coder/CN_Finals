# FTP n TElNET

set ns [new Simulator]

set tr [open 2.tr w]
$ns trace-all $tr

set nf [open 2.nam w]
$ns namtrace-all $nf

proc finish {} {
    global ns tr nf
    $ns flush-trace
    close $tr
    close $nf
    exec nam 2.nam &
    exec awk -f 2.awk 2.tr & 
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
$ftp set type_ FTP

set tcp1 [new Agent/TCP]
$ns attach-agent $n1 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n3 $sink1

$ns connect $tcp1 $sink1

set telnet [new Application/Telnet]
$telnet attach-agent $tcp1
$telnet set interval_ 0

$ns at 0.1 "$ftp start"
$ns at 0.5 "$telnet start"
$ns at 1.0 "$telnet stop"
$ns at 1.2 "$ftp stop"
$ns at 1.5 "finish"

$ns run