

"""
    XPalm(meteo; outputs, initiation_age=0, parameters=default_parameters())

Run the XPalm model with the given meteo data and return the results in a DataFrame.

# Arguments

- `meteo`: DataFrame with the meteo data
- `vars`: A dictionary with the outputs to be returned for each scale of simulation
- `initiation_age`: age of the plant at the beginning of the simulation
- `parameters`: parameters of the model

# Returns

- `DataFrame` with the results of the simulation

# Example

```julia
using XPalm, CSV, DataFrames
meteo = CSV.read(joinpath(dirname(dirname(pathof(XPalm))), "0-data/meteo.csv"), DataFrame)
df = xpalm(meteo; vars= Dict("Scene" => (:lai,)), sink=DataFrame)
```
"""
function xpalm(meteo; vars=Dict("Scene" => (:lai,)), initiation_age=0, parameters=default_parameters(), sink=NamedTuple)
    p = Palm(initiation_age=initiation_age, parameters=parameters)
    models = main_models_definition(p)
    out = PlantSimEngine.run!(p.mtg, models, meteo, outputs=vars, executor=PlantSimEngine.SequentialEx(), check=false)
    return PlantSimEngine.outputs(out, sink)
end