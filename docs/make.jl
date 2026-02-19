import Pkg

Pkg.activate(@__DIR__)
Pkg.develop(Pkg.PackageSpec(path=joinpath(@__DIR__, "..")))
Pkg.instantiate()

using Documenter
using Literate
using LiteratePlotlyRepro
using PlotlyJS

const GITHUB_REPO = get(ENV, "GITHUB_REPOSITORY", "cncastillo/LiteratePlotlyRepro")
const CI = get(ENV, "CI", "false") == "true"
const REPO_REMOTE = Documenter.Remotes.GitHub(GITHUB_REPO)

# Keep the Plotly SyncPlot HTML workaround in a separate file for direct reference.
include(joinpath(@__DIR__, "plotly_syncplot_html_fix.jl"))

# Back to regular documentation generation stuff.
const LITERATE_DIR = joinpath(@__DIR__, "src", "literate")
const GENERATED_DIR = joinpath(@__DIR__, "src", "generated")
mkpath(GENERATED_DIR)

Literate.markdown(
    joinpath(LITERATE_DIR, "plotly_example.jl"),
    GENERATED_DIR;
    execute=true,
    documenter=true,
)

makedocs(;
    modules = [LiteratePlotlyRepro],
    sitename = "LiteratePlotlyRepro.jl",
    repo = REPO_REMOTE,
    format = Documenter.HTML(;
        prettyurls = CI,
        edit_link = "main",
    ),
    pages = [
        "Home" => "index.md",
        "Examples" => [
            "Plotly Example" => "generated/plotly_example.md",
        ],
    ],
)

deploydocs(;
    repo = "github.com/$GITHUB_REPO.git",
    devbranch = "main",
)
