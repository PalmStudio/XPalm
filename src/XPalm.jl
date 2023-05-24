module XPalm

import MultiScaleTreeGraph
import MultiScaleTreeGraph: NodeMTG, addchild!
import Dates
import PlantSimEngine
import PlantMeteo
import PlantSimEngine: @process
import Tables

# Palm structure:
include("plant/mtg/structs.jl")

# Import the processes:
include("light/0-process.jl")
include("soil/0-process.jl")
include("plant/plant_age/0-process.jl")
include("plant/roots/0-process.jl")
include("plant/phytomer/phytomer/0-process.jl")
include("plant/phytomer/leaves/0-process.jl")

# Import the models:
include("light/beer.jl")
include("plant/plant_age/palm_age_increment.jl")
include("plant/plant_age/initiation_age.jl")
include("soil/FTSW.jl")
include("soil/FTSW_BP.jl")
include("meteo/thermal_time.jl")
include("meteo/et0_BP.jl")
include("plant/roots/root_growth.jl")

include("plant/phytomer/phytomer/add_phytomer.jl")
include("plant/phytomer/leaves/phyllochron.jl")
include("plant/phytomer/leaves/potential_area.jl")
include("plant/phytomer/leaves/leaf_area.jl")
include("plant/phytomer/leaves/lai.jl")

include("plant/respiration/maintenance/maintenance_respiration.jl")
include("plant/respiration/maintenance/Q10.jl")
include("model_definition.jl")

include("age_modulation/age_modulation_linear.jl")
include("age_modulation/age_modulation_logistic.jl")


include("run.jl")

export Palm

# exports for prototyping
export FTSW, soil_init_default
export DailyDegreeDays
export RootGrowthFTSW
export ET0_BP
end