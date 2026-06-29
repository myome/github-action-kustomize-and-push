FROM public.ecr.aws/docker/library/alpine:3.18

# Default kustomize version baked into the image. Pinning avoids the upstream
# install script and the anonymous GitHub REST API (which is rate-limited on
# shared GitHub-hosted runner IPs and was causing the action to fail).
ARG KUSTOMIZE_VERSION=5.8.1
ARG KUSTOMIZE_SHA256_AMD64=029a7f0f4e1932c52a0476cf02a0fd855c0bb85694b82c338fc648dcb53a819d
ARG KUSTOMIZE_SHA256_ARM64=0953ea3e476f66d6ddfcd911d750f5167b9365aa9491b2326398e289fef2c142

RUN apk --no-cache add curl gettext git bash coreutils

RUN set -eu; \
    case "$(apk --print-arch)" in \
        x86_64)  arch=amd64; sha="$KUSTOMIZE_SHA256_AMD64" ;; \
        aarch64) arch=arm64; sha="$KUSTOMIZE_SHA256_ARM64" ;; \
        *) echo "Unsupported architecture: $(apk --print-arch)" >&2; exit 1 ;; \
    esac; \
    tarball="kustomize_v${KUSTOMIZE_VERSION}_linux_${arch}.tar.gz"; \
    url="https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/${tarball}"; \
    echo "Downloading ${url}"; \
    curl -fsSL --retry 5 --retry-all-errors -o "/tmp/${tarball}" "${url}"; \
    echo "${sha}  /tmp/${tarball}" | sha256sum -c -; \
    tar -xzf "/tmp/${tarball}" -C /usr/local/bin kustomize; \
    rm -f "/tmp/${tarball}"; \
    chmod +x /usr/local/bin/kustomize; \
    kustomize version

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
