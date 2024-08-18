FROM busybox:stable-uclibc as bb
FROM headscale/headscale:0.23.0-beta1
COPY ./config.yaml /etc/headscale/config.yaml
COPY --from=bb /bin/sh /bin/sh
COPY --from=bb /bin/echo /bin/echo
COPY --from=bb /bin/mkdir /bin/mkdir
COPY --from=bb /bin/ls /bin/ls
COPY --from=bb /bin/cat /bin/cat
COPY --from=bb /bin/env /bin/env
RUN mkdir -p /var/lib/headscale
ENTRYPOINT ["/bin/sh", "-c" , "echo ${NOISE_PRIVATE_KEY} > /var/lib/headscale/noise_private.key && /ko-app/headscale serve "]
