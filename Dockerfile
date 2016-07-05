FROM demo-vm1.interact.lu:5000/nginx-interact:stable

EXPOSE 80

# Install GeoIP module.
RUN apt-get update && apt-get install -y geoip-database libgeoip1 wget
RUN mv /usr/share/GeoIP/GeoIP.dat /usr/share/GeoIP/GeoIP.dat_bak \
	&& cd /usr/share/GeoIP/ \
	&& wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz \
	&& gunzip GeoIP.dat.gz

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./ez_params.d /etc/nginx/ez_params.d
COPY ./conf.d/ /etc/nginx/conf.d/
COPY ./htpasswd /etc/nginx/htpasswd


CMD ["nginx", "-g", "daemon off;"]
