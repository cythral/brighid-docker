FROM alpine:3.14.3 as base
COPY --from=public.ecr.aws/cythral/decrs /decrs /usr/local/bin/decrs
COPY watch.sh /usr/local/bin/watch

RUN apk --no-cache upgrade
RUN apk --no-cache add libcap gcompat runuser libgcc libstdc++ krb5-libs libssl1.1 ca-certificates inotify-tools
RUN rm -rf /var/cache/apk/*
RUN chmod 750 /usr/local/bin/decrs /usr/local/bin/watch
RUN adduser --system brighid
COPY openssl.cnf /etc/ssl/openssl.cnf
 
FROM scratch
ENV \
DOTNET_RUNNING_IN_CONTAINER=true \
DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=true

COPY --from=base / /
