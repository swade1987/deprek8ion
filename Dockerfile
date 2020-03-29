FROM alpine:3
LABEL MAINTAINER Steven Wade <steven@stevenwade.co.uk>

# Install necessary tooling
RUN apk add --no-cache curl bash execline findutils && rm -rf /var/cache/apk/*

# Copy in rego policies to work with Conftest.
COPY policies/* /policies/

COPY install.sh /install.sh
RUN chmod +x /install.sh
RUN /install.sh

CMD ["/bin/sh"]