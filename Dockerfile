FROM grafana/k6:0.54.0 AS k6official

FROM alpine:3.20

COPY --from=k6official /usr/bin/k6 /usr/bin/k6

RUN apk add postgresql15-client

ENV PGDATABASE="postgresql://supabase_admin@localhost:5432/postgres"

COPY scripts /

ENTRYPOINT ["/bin/sh", "-c", "sleep infinity"]
