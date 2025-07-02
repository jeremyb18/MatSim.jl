cDir = @__DIR__
cd(cDir)
push!(LOAD_PATH,joinpath(cDir,"../libraries"))

using ase
using LennardJones
using BenchmarkTools
using YAML
using nSampling
using Base.Threads
using Plots
using DataFrames
using DelimitedFiles
using nSamplingMultithreads





# Load data in to test
resultsPath = joinpath(cDir,"draws-LJ.Pt-Ag")
input = YAML.load_file(joinpath(cDir,"NS.yml"))
LJ_average = LennardJones.get_LJ_averages(resultsPath)
myNS = nSamplingMultithreads.initialize(input["params"],LJ_average);# 10k allocations.  Need to optimize this.
nSamplingMultithreads.tune_step_sizes!(myNS,LJ_average)
@time nSamplingMultithreads.run_NS(myNS,LJ_average)

# data = readdlm("NS.out")
# energy = data[5:end, 2]
# V = data[5:end, 1]
# plot(energy,title="Min Energy: $(energy[end])", xlabel="Iterations", ylabel="Energy")
# savefig("Energy_by_Iteration.png")


# plot(V,energy,title="Min Energy: $(energy[end])", xlabel="V", ylabel="Energy")
# plot!(xscale=:log10)
# savefig("Energy_by_ConfigurationSpace.png")



# Disregard all below


