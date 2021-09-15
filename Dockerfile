FROM alpine:3.14.2 as base
COPY --from=public.ecr.aws/cythral/decrs /decrs /usr/local/bin/decrs
RUN apk --no-cache upgrade
RUN apk --no-cache add libcap gcompat runuser libgcc libstdc++ krb5-libs libssl1.1 ca-certificates
RUN rm -rf /var/cache/apk/*
RUN chmod 750 /usr/local/bin/decrs
RUN adduser --system --no-create-home brighid

# TLS Fix
RUN sed -i 's/DEFAULT@SECLEVEL=2/DEFAULT@SECLEVEL=1/g' /etc/ssl/openssl.cnf
RUN sed -i 's/MinProtocol = TLSv1.2/MinProtocol = TLSv1/g' /etc/ssl/openssl.cnf

FROM scratch
ENV \
DOTNET_RUNNING_IN_CONTAINER=true \
DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=true

COPY --from=base / /
