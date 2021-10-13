FROM nixos/nix as NIXBASE
ARG packages=""
RUN mkdir -p /output/store && \
    nix-env --profile /output/profile -iA nixpkgs.busybox ${packages} && \
    cp -va $(nix-store -qR /output/profile) /output/store

FROM scratch
COPY --from=NIXBASE /output/store /nix/store
COPY --from=NIXBASE /output/profile/ /usr/local/

# s6 requires busybox (which contians tar, etc)
ADD https://github.com/just-containers/s6-overlay/releases/latest/download/s6-overlay-amd64.tar.gz /tmp/
RUN  ["/usr/local/sbin/tar", "xzf", "/tmp/s6-overlay-amd64.tar.gz", "-C", "/"]

ENTRYPOINT ["/init"]


#
#FROM nixos/nix as NIXBASE
#ARG packages=""
#COPY *.nix /
#RUN nix-build /s6-overlay.nix && \
#    mkdir -p /output/store && \
#    nix-env --profile /output/profile -iA nixpkgs.busybox ${packages} && \
#    nix-env --profile /output/profile -i -f /s6-overlay.nix && \
#    cp -va $(nix-store -qR /output/profile) /output/store
#
#FROM scratch
#COPY --from=NIXBASE /output/store /nix/store
#COPY --from=NIXBASE /output/profile/ /usr/local/
#ENTRYPOINT ["sh"]

