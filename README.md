# LiteratePlotlyRepro.jl

[![Docs](https://img.shields.io/badge/docs-dev-blue.svg)](https://cncastillo.github.io/LiteratePlotlyRepro/dev/)

Minimal Julia reproducer for the Plotly + Literate + Documenter behavior discussed in [Literate.jl issue #126](https://github.com/fredrikekre/Literate.jl/issues/126).

## Problem this repository targets

When PlotlyJS figures are generated from a Literate source and rendered in Documenter output, figure sizing and HTML embedding behavior can be inconsistent. This repository captures that workflow end-to-end and documents the rendering cases so the behavior can be reproduced, discussed, and fixed with a concrete testbed.

## Documentation

- Dev docs: https://cncastillo.github.io/LiteratePlotlyRepro/dev/

Docs are built and deployed automatically from GitHub Actions (`.github/workflows/documentation.yml`) on pushes to `main` and tags.

## Build docs locally

```bash
julia --project=docs -e 'using Pkg; Pkg.develop(PackageSpec(path=pwd())); Pkg.instantiate()'
julia --project=docs docs/make.jl
```
