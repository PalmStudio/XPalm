struct Potential_AreaModel_BP{A,L} <: AbstractLeaf_Potential_AreaModel
    age_first_mature_leaf::A
    leaf_area_first_leaf::L
    leaf_area_mature_leaf::L
end

PlantSimEngine.inputs_(::Potential_AreaModel_BP) = (initiation_age=-Inf,)

PlantSimEngine.outputs_(::Potential_AreaModel_BP) = (
    potential_area=-Inf,
)

function PlantSimEngine.run!(m::Potential_AreaModel_BP, models, status, meteo, constants, extra=nothing)
    status.potential_area =
        age_relative_var(
            status.initiation_age,
            0,
            m.age_first_mature_leaf,
            m.leaf_area_first_leaf,
            m.leaf_area_mature_leaf
        )
end

function PlantSimEngine.run!(::Potential_AreaModel_BP, models, status, meteo, constants, mtg::MultiScaleTreeGraph.Node)
    status.potential_area = PlantMeteo.prev_value(status, :potential_area, default=status.potential_area)
end