FROM alpine:3.14.2 as base
COPY --from=public.ecr.aws/cythral/decrs /decrs /usr/local/bin/decrs
RUN apk --no-cache upgrade
RUN apk --no-cache add libcap gcompat runuser libgcc libstdc++ krb5
RUN rm -rf /var/cache/apk/*
RUN chmod 750 /usr/local/bin/decrs
RUN adduser --system --no-create-home brighid

FROM scratch
COPY --from=base / /