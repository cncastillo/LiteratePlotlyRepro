# # PlotlyJS.jl Direct Example
#
# This file is a **Literate.jl input source**:
# - lines beginning with `#` become markdown in the generated page
# - regular Julia lines are executed when `execute=true`
#
# It uses `PlotlyJS.jl` directly (not `Plots.jl`).
#
# ## Build a simple figure

using PlotlyJS
using Base64

x = range(0, 2pi; length=200)
y = sin.(x)

trace = scatter(; x=collect(x), y=collect(y), mode="lines", name="sin(x)")

# Helper: inspect the final HTML emitted by `show(..., MIME"text/html", fig)`
# and extract the `<object style="width:...;height:...">` dimensions.
function object_html_from_show(fig::PlotlyJS.SyncPlot)
    io = IOBuffer()
    show(io, MIME"text/html"(), fig)
    return String(take!(io))
end

function object_payload_from_show(fig::PlotlyJS.SyncPlot)
    html = object_html_from_show(fig)
    m = match(r"data=\"data:text/html;base64,([^\"]+)\"", html)
    @assert m !== nothing
    return String(base64decode(m.captures[1]))
end

function object_dims_from_show(fig::PlotlyJS.SyncPlot)
    html = object_html_from_show(fig)
    m = match(r"style=\"[^\"]*width:([^;]+);[^\"]*height:([^\"]+);[^\"]*\"", html)
    @assert m !== nothing
    return (m.captures[1], m.captures[2])
end

# ## Case 1: explicit width and height

fig_explicit = plot(trace, Layout(; title="explicit 960x380", width=960, height=380))
@assert fig_explicit isa PlotlyJS.SyncPlot
@assert size(fig_explicit) == (960, 380)
@assert object_dims_from_show(fig_explicit) == ("960px", "380px")
(; size=size(fig_explicit), object_dims=object_dims_from_show(fig_explicit))

# Render the figure itself.
#-
fig_explicit

# ## Case 2: only width set (height falls back to default)

fig_width_only = plot(trace, Layout(; title="width only 900", width=900))
@assert size(fig_width_only) == (900, 450)
@assert object_dims_from_show(fig_width_only) == ("900px", "450px")
(; size=size(fig_width_only), object_dims=object_dims_from_show(fig_width_only))

# Render the figure itself.
#-
fig_width_only

# ## Case 3: default layout size (no width/height)

fig_default = plot(trace, Layout(; title="default size"))
@assert size(fig_default) == (800, 450)
@assert object_dims_from_show(fig_default) == ("100%", "450px")
(; size=size(fig_default), object_dims=object_dims_from_show(fig_default))

# Render the figure itself.
#-
fig_default

# ## Case 4: only height set

fig_height_only = plot(trace, Layout(; title="height only 300", height=300))
@assert size(fig_height_only) == (800, 300)
@assert object_dims_from_show(fig_height_only) == ("100%", "300px")
(; size=size(fig_height_only), object_dims=object_dims_from_show(fig_height_only))

# Render the figure itself.
#-
fig_height_only

# ## Case 5: CSS width string (accepted by this docs adapter)
#
# Note: Plotly layout schema documents pixel width/height, but this verifies
# that the current docs adapter preserves string values when present.

fig_width_percent = plot(trace, Layout(; title="width 100 percent", width="100%"))
@assert size(fig_width_percent) == ("100%", 450)
@assert object_dims_from_show(fig_width_percent) == ("100%", "450px")
payload_100 = object_payload_from_show(fig_width_percent)
@assert occursin("style=\"height:100%; width:100%;\"", payload_100)
@assert !occursin("\"width\":\"100%\"", payload_100)
(; size=size(fig_width_percent), object_dims=object_dims_from_show(fig_width_percent))

# Render the figure itself.
#-
fig_width_percent

# ## Case 6: small and wide (very different from defaults)

fig_small_wide = plot(trace, Layout(; title="small and wide 1200x260", width=1200, height=260))
@assert size(fig_small_wide) == (1200, 260)
@assert object_dims_from_show(fig_small_wide) == ("1200px", "260px")
(; size=size(fig_small_wide), object_dims=object_dims_from_show(fig_small_wide))

# Render the figure itself.
#-
fig_small_wide

# ## Case 7: narrow and tall (very different from defaults)

fig_narrow_tall = plot(trace, Layout(; title="narrow and tall 360x900", width=360, height=900))
@assert size(fig_narrow_tall) == (360, 900)
@assert object_dims_from_show(fig_narrow_tall) == ("360px", "900px")
(; size=size(fig_narrow_tall), object_dims=object_dims_from_show(fig_narrow_tall))

# Render the figure itself.
#-
fig_narrow_tall

# ## Case 8: CSS width 150% (intentional overflow test)

fig_width_150 = plot(trace, Layout(; title="width 150 percent", width="150%"))
@assert size(fig_width_150) == ("150%", 450)
@assert object_dims_from_show(fig_width_150) == ("150%", "450px")
payload_150 = object_payload_from_show(fig_width_150)
@assert occursin("style=\"height:100%; width:100%;\"", payload_150)
@assert !occursin("\"width\":\"150%\"", payload_150)
(; size=size(fig_width_150), object_dims=object_dims_from_show(fig_width_150))

# Render the figure itself.
#-
fig_width_150
