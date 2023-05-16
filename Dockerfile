FROM alpine:3.16

RUN apk update && \
	apk add --no-cache nginx=1.22.1-r0 && \
	sed -i 's/ssl_protocols TLSv1.1 TLSv1.2/ssl_protocols/' /etc/nginx/nginx.conf
 
# for editing files
RUN apk add --no-cache nano

# for SSL Signing
RUN apk add --no-cache openssl=1.1.1t-r2 && \
    openssl req -x509 \
	-nodes \
	-sha256 \
	-days 365 \
	-newkey rsa:2048 \
	-subj "/C=DE/L=Bielefeld/O=42Wolfsburg/OU=student/CN=euyi.42.fr" \
	-keyout /etc/ssl/certs/well_known.key \
	 -out /etc/ssl/certs/well_known.crt

# Update /etc/nginx/fastcgi_params file to add missing attributes
RUN sed -i 's/fastcgi_param  SCRIPT_NAME/fastcgi_param  SCRIPT_FILENAME    $document_root$fastcgi_script_name;\nfastcgi_param  SCRIPT_NAME/' /etc/nginx/fastcgi_params && \
	sed -i 's/fastcgi_param  REQUEST_URI/fastcgi_param  PATH_INFO          $fastcgi_path_info;\nfastcgi_param  REQUEST_URI/' /etc/nginx/fastcgi_params && \
	sed -i 's/fastcgi_param  REQUEST_URI/fastcgi_param  PATH_TRANSLATED    $document_root$fastcgi_path_info;\nfastcgi_param  REQUEST_URI/' /etc/nginx/fastcgi_params

# Replace default config in /etc/nginx/http.d/default.conf
COPY conf/default.conf /etc/nginx/http.d/

# Copy our entrypoint bash script to DockerImage root
# and set chmod=0755 permission to enable it execute 
COPY --chmod=0755 conf/entrypoint.sh /

#Default command this DockerImage runs to launch Nginx
ENTRYPOINT ["/entrypoint.sh"]

#since ENTRYPOINT exists above, these will serve as its argv
CMD ["nginx", "-g", "daemon off;"]
