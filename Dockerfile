FROM public.ecr.aws/docker/library/alpine:3.18

# Pinned kustomize, copied from the official SIG-CLI image. No remote script,
# no GitHub API, no token needed to install. Bump this tag to upgrade.
COPY --from=registry.k8s.io/kustomize/kustomize:v5.8.1 /app/kustomize /usr/local/bin/kustomize

RUN apk --no-cache add gettext git bash
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
