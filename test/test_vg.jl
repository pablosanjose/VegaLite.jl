using Test
using VegaLite
using URIParser
using FilePaths
using DataFrames
using VegaDatasets

include("testhelper_create_vg_plot.jl")

@testset "VGSpec" begin

@test vg"""{ "data": [ { "name": "test" } ] }"""(URI("http://www.foo.com/bar.json"), "test") == vg"""
    {
        "data": [{
            "name": "test",
            "url": "http://www.foo.com/bar.json"
        }]
    }
    """

df = DataFrame(a=[1.,2.], b=["A", "B"], c=[Date(2000), Date(2001)])

p1 = getvgplot()

p2 = deletedata(p1)
@test !haskey(p2.params["data"][1], "values")

p3 = p2(df, "table")

@test p3.params["data"][1]["values"][1]["b"] == "A"

deletedata!(p1)

@test p1 == p2

end
