FROM sebp/elk

RUN apt-get install wget

# for Synology NAS
RUN echo 'bootstrap.system_call_filter: false' >> ${ES_PATH_CONF}/elasticsearch.yml

# filters for pfSense and Suricata
RUN rm ${LOGSTASH_PATH_CONF}/conf.d/*
ADD ./01-inputs.conf ${LOGSTASH_PATH_CONF}/conf.d/01-inputs.conf
ADD ./10-syslog.conf ${LOGSTASH_PATH_CONF}/conf.d/10-syslog.conf
ADD ./11-pfsense.conf ${LOGSTASH_PATH_CONF}/conf.d/11-pfsense.conf
ADD ./30-outputs.conf ${LOGSTASH_PATH_CONF}/conf.d/30-outputs.conf
ADD ./pfsense2_4_3.grok ${LOGSTASH_PATH_CONF}/conf.d/patterns/pfsense2_4_3.grok

# host files
RUN echo '192.168.3.10 logs.blanboom.org logs' >> /etc/hosts
RUN echo 'logs' >> /etc/hostname

# GeoIP
RUN cd /etc/logstash \
 && wget http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz \
 && gunzip GeoLite2-City.mmdb.gz
