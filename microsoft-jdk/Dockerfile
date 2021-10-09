FROM nixos/nix as NIXBASE
ARG packages=""
COPY *.nix /
RUN nix-build /microsoft-jdk.nix && \
    mkdir -p /output/store && \
    nix-env --profile /output/profile -iA nixpkgs.tini ${packages} && \
    nix-env --profile /output/profile -i -f /microsoft-jdk.nix && \
    cp -va $(nix-store -qR /output/profile) /output/store

FROM scratch
COPY --from=NIXBASE /output/store /nix/store
COPY --from=NIXBASE /output/profile/ /usr/local/
ENTRYPOINT ["tini", "--"]
CMD ["java", "-version"]
