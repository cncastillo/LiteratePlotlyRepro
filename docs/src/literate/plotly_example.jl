# # PlotlyJS.jl Plot Examples
#
# A minimal Literate page showing the behaviour of the fix ([Literate.jl issue #126](https://github.com/fredrikekre/Literate.jl/issues/126)).

using PlotlyJS

x = range(0, 2pi; length=200)
y = sin.(x)
trace = scatter(; x=collect(x), y=collect(y), mode="lines", name="sin(x)")

# ## Case 1: explicit width and height
plot(trace, Layout(; title="explicit 960x380", width=960, height=380))

# ## Case 2: only width set
plot(trace, Layout(; title="width only 900", width=900))

# ## Case 3: default layout size
plot(trace, Layout(; title="default size"))

# ## Case 4: only height set
plot(trace, Layout(; title="height only 300", height=300))

# ## Case 5: CSS width string 100%
plot(trace, Layout(; title="width 100 percent", width="100%"))

# ## Case 6: small and wide
plot(trace, Layout(; title="small and wide 1200x260", width=1200, height=260))

# ## Case 7: narrow and tall
plot(trace, Layout(; title="narrow and tall 360x900", width=360, height=900))

# ## Case 8: CSS width string 150%
plot(trace, Layout(; title="width 150 percent", width="150%"))
