# homebrew-tap

Personal Homebrew tap.

```sh
brew install besmirzanaj/tap/<formula>
```

## Formulas

| Formula    | Description                                              | Install                                   |
| ---------- | ------------------------------------------------------- | ----------------------------------------- |
| `dnsglobe` | Global DNS propagation checker TUI                      | `brew install besmirzanaj/tap/dnsglobe`   |
| `dnsbench` | Benchmark & diagnose recursive DNS resolvers            | `brew install besmirzanaj/tap/dnsbench`   |

## Maintenance

- `dnsglobe` — published automatically by [cargo-dist](https://opensource.axo.dev/cargo-dist/) from the source repo.
- `dnsbench` — repackages upstream [`ialexsilva/dnsbench-cli`](https://github.com/ialexsilva/dnsbench-cli) release binaries. A weekly workflow ([`.github/workflows/bump-dnsbench.yml`](.github/workflows/bump-dnsbench.yml)) checks for a newer upstream release and, if found, regenerates the formula (version + sha256s) and commits it. Run it on demand from the **Actions** tab (**Run workflow**).
