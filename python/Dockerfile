FROM nixos/nix
RUN mkdir -p /output/store
RUN nix-env --profile /output/profile -i python2Full
RUN cp -va $(nix-store -qR /output/profile) /output/store
FROM scratch
COPY --from=0 /output/store /nix/store
COPY --from=0 /output/profile/ /usr/local/
