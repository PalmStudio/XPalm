"""
RankLeafPruning(rank)

Function to remove leaf biomass and area when the phytomer has an harvested bunch or when the leaf reaches a treshold rank (below rank of harvested bunches) 

# Arguments
- `rank`: leaf rank treshold below whith the leaf is cutted

# Inputs
- `state`: phytomer state

# Outputs 
- `litter_leaf`: leaf biomass removed from the plantand going to the litter

"""

struct RankLeafPruning <: AbstractLeaf_PruningModel
    rank
end

PlantSimEngine.inputs_(::RankLeafPruning) = (rank_phytomers=[-9999], state_phytomers=["undetermined"], biomass=-Inf, leaf_area=-Inf, leaf_state="undetermined") # Coming from the phytomers
PlantSimEngine.outputs_(::RankLeafPruning) = (litter_leaf=-Inf,)

# Applied at the leaf scale:
function PlantSimEngine.run!(m::RankLeafPruning, models, status, meteo, constants, extra=nothing)
    # Get the index of the organ in the organ list:
    # (we added the index of the organ in the organ list as the index of the MTG)
    i = index(status.node)

    # The rank and state variables are given for the phytomer. We can retreive the phytomer of the 
    # leaf by using its index. If the phytomer has a higher rank than m.rank or it is harvested, then
    # we put the leaf as pruned and define its biomass as litter.
    if status.rank_phytomers[i] > m.rank || status.state_phytomers[i] == "Harvested"
        status.leaf_state = "Pruned"
        status.leaf_area = 0.0
        status.litter_leaf = status.biomass
        status.biomass = 0.0
    end
end