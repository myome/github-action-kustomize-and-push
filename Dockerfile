FROM public.ecr.aws/docker/library/alpine:3.18

RUN apk --no-cache add curl gettext git bash
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
