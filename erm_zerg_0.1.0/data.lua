ErmZerg = {}

require "prototypes.enemy.zergling"
require "prototypes.enemy.mutalisk"
require "prototypes.enemy.hydralisk"
require "prototypes.enemy.ultralisk"
require "prototypes.enemy.devourer"
require "prototypes.enemy.guardian"
require "prototypes.enemy.overlord"
require "prototypes.enemy.lurker"
require "prototypes.enemy.drone"

for i=1,20 do
    ErmZerg.makeZergling(i)
    ErmZerg.makeHydralisk(i)
    ErmZerg.makeMutalisk(i)
    ErmZerg.makeUltralisk(i)
    ErmZerg.makeDevourer(i)
    ErmZerg.makeGuardian(i)
    ErmZerg.makeOverlord(i)
    ErmZerg.makeLurker(i)
    ErmZerg.makeDrone(i)
end

--Create a zerg force
--Add it to ERM

