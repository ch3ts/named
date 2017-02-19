# docker-bind9 - beta

This project allows to get the latest version of bind9 for Debian 8 ( a.k.a jessie ).  
You will need docker and docker-compose to compile bind9.

Run:

  * make build
  * make start

and use

  * make stop


 Library required: 
  * libssl1.0.0

<br/><br/><br/>
NB: If you use bind9 in a Docker, make sure to add capabilities for the container.