# LiteratePlotlyRepro.jl

[![Docs](https://img.shields.io/badge/docs-dev-blue.svg)](https://cncastillo.github.io/LiteratePlotlyRepro/dev/)

When PlotlyJS figures are generated from a Literate source and rendered in Documenter output, the figures do not show up ([Literate.jl issue #126](https://github.com/fredrikekre/Literate.jl/issues/126)). 

This repo presents a solution by extending the method `Base.show` for `PlotlyJS.SyncPlot`'s.
