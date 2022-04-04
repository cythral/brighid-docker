FROM arm64v8/alpine:3.15.4 as base
COPY --from=public.ecr.aws/cythral/decrs:0.1.0 /decrs /usr/local/bin/decrs
COPY src/migrate.sh /usr/local/bin/migrate
COPY src/watch.sh /usr/local/bin/watch

RUN apk --no-cache upgrade
RUN apk --no-cache add libcap gcompat runuser libgcc libstdc++ krb5-libs libssl1.1 ca-certificates inotify-tools
RUN rm -rf /var/cache/apk/*
RUN chmod 750 /usr/local/bin/decrs /usr/local/bin/watch /usr/local/bin/migrate
RUN adduser --system brighid
COPY openssl.cnf /etc/ssl1.1/openssl.cnf

FROM scratch
ENV \
    DOTNET_RUNNING_IN_CONTAINER=true \
    DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=true

COPY --from=base / /
