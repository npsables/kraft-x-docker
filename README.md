# kraft x docker
Kafka zookeeperless, implement RAFT protocol for self maintaining clustership

### **tl;dr**: 

You need to set **advertised.listeners** (or KAFKA_ADVERTISED_LISTENERS if you’re using Docker images) to the external address (host/IP) so that clients can correctly connect to it. Otherwise they’ll try to connect to the internal host address–and if that’s not reachable then problems ensue. 
- https://rmoff.net/2018/08/02/kafka-listeners-explained/

#### More configs and explains:
- https://www.ibm.com/docs/en/oala/1.3.6?topic=SSPFMY_1.3.6/com.ibm.scala.doc/config/iwa_cnf_scldc_kfk_prp_exmpl_c.html

### hub:
- npsables/kraft-x-docker:3.2.3

### stand alone:
- docker run -p 9092:9092 --name kraft kraft-x-docker:3.2.3

### cluster (but u know what I mean)
- cd compose
- docker-compose -f docker-compose.example.yaml up