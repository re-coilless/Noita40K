return function( hooman )
    local stress = pen.magic_storage( hooman, "stress", "value_float", nil, 0 )

    --apply strength boost
    --get max_force
    --save it as stress_force_memo
    --write updated value to stress_force
    --if stress_force does not match with current max_force, add delta to stress_force_memo
    
    --degrades linearly, is uncapped but above certain values degrades exponentially

    --check for threats (use threat calc func, threat value progressively increase stress up until some value, the higher the threat, the higher this value)
    --incoming damage (compare hp values)
    --continous gunfire (check for fresh hooman-shot projectiles nearby)
    --total incoming adrenaline value must always increase else the benefits of it will decay

    --apply shader effects
end