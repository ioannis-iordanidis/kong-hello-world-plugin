FROM kong:0.13

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh && \
    apk add --no-cache curl && \
    apk add --no-cache gcc musl-dev && \
    apk add --no-cache openssl && \
    apk add --no-cache openssl-dev && \
    rm -rf /var/cache/apk/*

RUN git clone https://bitbucket.org/gt_tech/jwks_aware_oauth_jwt_access_token_validator.git /tmp/jwt \
&& cd /tmp/jwt \
&& git checkout tags/v1.0.0-RC3 \
&& mv /tmp/jwt/kong/plugins/jwks_aware_oauth_jwt_access_token_validator /usr/local/share/lua/5.1/kong/plugins/jwks_aware_oauth_jwt_access_token_validator

ENV KONG_CUSTOM_PLUGINS=kong-plugin-hello-world

CMD ["/usr/local/openresty/nginx/sbin/nginx", "-c", "/usr/local/kong/nginx.conf", "-p", "/usr/local/kong/"]
