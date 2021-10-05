FROM nixos/nix as NIXBASE
ARG packages
RUN mkdir -p /output/store && \
    nix-env --profile /output/profile -iA nixpkgs.tini ${packages} && \
    cp -va $(nix-store -qR /output/profile) /output/store

FROM scratch
COPY --from=NIXBASE /output/store /nix/store
COPY --from=NIXBASE /output/profile/ /usr/local/
ENTRYPOINT ["tini", "--"]
CMD ["ruby", "--version"]
