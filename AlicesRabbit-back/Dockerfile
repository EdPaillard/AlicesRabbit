FROM elixir:1.12.3
WORKDIR /serv
RUN mix local.hex --force && \
    mix local.rebar --force
COPY mix.exs mix.lock ./
RUN mix deps.get && \
    mix deps.compile
COPY . .
EXPOSE 4000

CMD ["./dbdeploy.sh"]