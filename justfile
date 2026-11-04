# Everything CI runs.
ci:
    nix fmt -- --ci
    pnpm install --frozen-lockfile
    biome check
    pnpm exec tsc -p .
    pnpm build

# Builds the page and serves it at chat.agentics.lwirth.com, from lwirth-cloud,
# whose serve.nix in dotcloud says how.
deploy: ci
    rsync -rlpt --delete --delay-updates --chmod=D755,F644 dist/ root@lwirth-cloud:/srv/chat/
