globals [sunlight next_screen? plant-clipboard max_zombies0 max_zombies1 max_zombies2 current_zombies game_over?]
turtles-own [damage toughness]
breed [seed_packets seed_packet]
breed [lawn_mowers lawn_mower]
lawn_mowers-own [activated?]
breed [zombies zombie]
breed [mummies mummy]
breed [m_coneheads m_conehead]
breed [m_bucketheads m_buckethead]
breed [suns sun]
breed [suns_from_sunflower sun_from_sunflower]
breed [projectiles projectile]
breed [plants plant]
plants-own [detection detection_c detection_b borntime]
breed [temps temp]
;---------------------------------------------------------------------------------------------------CODE--------------------------------------------------------------------------------------------------------------------------------------------------------------------
to setup
  ca
  reset-timer
  reset-ticks
  info_screen
end

to info_screen
  ask patch 130 166 [
    set plabel "Read descriptions of plants, then click green to continue"]
  ask patches with [pxcor >= 331 and pycor <= -191] [
    set pcolor green]
  sunflower_setup
  peashooter_setup
end

to sunflower_setup
  ask patch 3 76 [
    sprout-seed_packets 1 [
      set shape "sunflower_seed_packet"
      set size 100
      set color turquoise]
  ]
  ask patch 52 16 [
    set plabel "Sunflower"
  ]
  ask patch 52 8 [
    set plabel "Produces sun every 10 seconds"
  ]
  ask patch 52 0 [
    set plabel "Cost: 50"
  ]
  ask patch 52 -8 [
    set plabel "Damage: N/A"
  ]
end

to peashooter_setup
  ask patch 3 -81 [
    sprout-seed_packets 1 [
      set shape "peashooter_seed_packet"
      set size 100
      set color turquoise]
  ]
  ask patch 52 -141 [
    set plabel "Peashooter"
  ]
   ask patch 52 -149 [
    set plabel "Shoots peas every 3 seconds"
  ]
  ask patch 52 -157 [
    set plabel "Cost: 100"
  ]
  ask patch 52 -165 [
    set plabel "Damage: 20"
  ]
end



to go
  wait 0.01
  if mouse-down? [
    if [pcolor] of patch mouse-xcor mouse-ycor = green [
      set next_screen? true]
  ]
  setting
  collect_sun
  sunflowerGo
  peashooterGo
  peashooterPea
  zombieGo
  collisionDetection
  game_over
  victory
  every 1 [tick]
end

to setting
  if next_screen? = true [
    clear-turtles
    clear-patches
    reset-timer
    set sunlight 50
    import-drawing "ancient_egypt_lawn.JPG"
    lawn_mower_setup
    seed_packet_setup
    set next_screen? false
  ]
 if next_screen? = false [
  sunfall
  choosing_seed_packet
  planting_plants
  spawn_zombies
  lawnmowing
  ]
end

to game_over
  ask mummies [
    if xcor <= -131 [
      set game_over? true] ]
    ask m_coneheads [
    if xcor <= -131 [
      set game_over? true] ]
    ask m_bucketheads [
    if xcor <= -131 [
      set game_over? true] ]
  if game_over? = true [
    ca
    ask patch 0 0 [set plabel "GAME OVER"] ]
end

to lawn_mower_setup
  create-lawn_mowers 1 [set heading 90
                        set shape "lawn_mower"
                        set color blue
                        set size 80
                        setxy -120 72]
    create-lawn_mowers 1 [set heading 90
                        set shape "lawn_mower"
                        set color blue
                        set size 80
                        setxy -120 24]
    create-lawn_mowers 1 [set heading 90
                        set shape "lawn_mower"
                        set color blue
                        set size 80
                        setxy -120 -24]
    create-lawn_mowers 1 [set heading 90
                        set shape "lawn_mower"
                        set color blue
                        set size 80
                        setxy -120 -72]
    create-lawn_mowers 1 [set heading 90
                        set shape "lawn_mower"
                        set color blue
                        set size 80
                        setxy -120 -120]
end

to seed_packet_setup
  create-seed_packets 2 [set size 60 set color turquoise]
  ask seed_packet 5 [set shape "sunflower_seed_packet" setxy -320 0]
  ask seed_packet 6 [set shape "peashooter_seed_packet" setxy -240 0]
end

to sunfall
  if timer >= 5 [
    every 10 [ask one-of patches with [pycor = max-pycor and pxcor >= -79] [
    sprout-suns 1 [set size 50 set shape "sun"]
   ]
  ]
  ]
 every 1 [
   ask suns [
    set heading 180
    fd 41.6
    if ycor <= -210 [
        die]]]
end

to choosing_seed_packet
 if mouse-down? [
  create-temps 1 [set hidden? true setxy mouse-xcor mouse-ycor]
 ]
 ask temps [
    ask seed_packets with [shape = "sunflower_seed_packet"] in-radius 35 [
      set plant-clipboard "sunflower"
    ]
 ask temps [
   ask seed_packets with [shape = "peashooter_seed_packet"] in-radius 35 [
     set plant-clipboard "peashooter"
    ]
    ]
  ]
end

to planting_plants
 if mouse-down? and mouse-xcor <= 284 and mouse-xcor >= -68 and mouse-ycor >= -146 and mouse-ycor <= 84 [
   if plant-clipboard = "sunflower" and sunlight >= 50 [
 create-plants 1 [setxy (((floor (mouse-xcor / 42) * 42) + 22)) (((floor (mouse-ycor / 48) * 48) + 24)) set shape "sunflower" set size 60 set plant-clipboard "empty" set sunlight (sunlight - 50) set toughness 300]
    ]
   if plant-clipboard = "peashooter" and sunlight >= 100 [
 create-plants 1 [setxy (((floor (mouse-xcor / 42) * 42) + 24)) (((floor (mouse-ycor / 48) * 48) + 24)) set shape "peashooter" set size 45 set plant-clipboard "empty" set sunlight (sunlight - 100) set toughness 300]
    ]
  ]
end


to collect_sun
  if mouse-down? [
    create-temps 1 [set hidden? true setxy mouse-xcor mouse-ycor]
  ]
  ask temps [
    ask suns in-radius 25 [
      set sunlight (sunlight + 25)
      die
    ]
    die]
  if mouse-down? [
    create-temps 1 [set hidden? true setxy mouse-xcor mouse-ycor]
  ]
  ask temps [
    ask suns_from_sunflower in-radius 25 [
      set sunlight (sunlight + 25)
      die
      ]
      die
    ]
end

to lawnmowing
  ask lawn_mowers with [ycor = 72] [
    if (any? mummies in-radius 10) or (any? m_coneheads in-radius 10) or (any? m_bucketheads in-radius 10) [
      activate2]
    if activated? = True [
      activate2]
    if (any? mummies in-radius 10) or (any? m_coneheads in-radius 10) or (any? m_bucketheads in-radius 10) [
      ask mummies in-radius 10 [set hidden? true]
      ask m_coneheads in-radius 10 [set hidden? true]
      ask m_bucketheads in-radius 10 [set hidden? true] ]
    ask lawn_mowers with [ycor = 72] [if xcor >= 288 [set hidden? true]]
  ]
  ask lawn_mowers with [ycor = 24] [
    if (any? mummies in-radius 10) or (any? m_coneheads in-radius 10) or (any? m_bucketheads in-radius 10) [
      activate3]
    if activated? = True [
      activate3]
    if (any? mummies in-radius 10) or (any? m_coneheads in-radius 10) or (any? m_bucketheads in-radius 10) [
      ask mummies in-radius 10 [set hidden? true]
      ask m_coneheads in-radius 10 [set hidden? true]
      ask m_bucketheads in-radius 10 [set hidden? true] ] ]
  ask lawn_mowers with [ycor = 24] [if xcor >= 288 [set hidden? true]]
  ask lawn_mowers with [ycor = -24] [
    if (any? mummies in-radius 10) or (any? m_coneheads in-radius 10) or (any? m_bucketheads in-radius 10) [
      activate4]
    if activated? = True [
      activate4]
    if (any? mummies in-radius 10) or (any? m_coneheads in-radius 10) or (any? m_bucketheads in-radius 10) [
            ask mummies in-radius 10 [set hidden? true]
      ask m_coneheads in-radius 10 [set hidden? true]
      ask m_bucketheads in-radius 10 [set hidden? true] ] ]
  ask lawn_mowers with [ycor = -24] [if xcor >= 288 [die]]
  ask lawn_mowers with [ycor = -72] [
    if (any? mummies in-radius 10) or (any? m_coneheads in-radius 10) or (any? m_bucketheads in-radius 10) [
      activate5]
    if activated? = True [
      activate5]
    if (any? mummies in-radius 10) or (any? m_coneheads in-radius 10) or (any? m_bucketheads in-radius 10) [
            ask mummies in-radius 10 [set hidden? true]
      ask m_coneheads in-radius 10 [set hidden? true]
      ask m_bucketheads in-radius 10 [set hidden? true] ] ]
  ask lawn_mowers with [ycor = -72] [if xcor >= 288 [die]]
  ask lawn_mowers with [ycor = -120] [
    if (any? mummies in-radius 10) or (any? m_coneheads in-radius 10) or (any? m_bucketheads in-radius 10) [
      activate6]
    if activated? = True [
      activate6]
    if (any? mummies in-radius 10) or (any? m_coneheads in-radius 10) or (any? m_bucketheads in-radius 10) [
            ask mummies in-radius 10 [set hidden? true]
      ask m_coneheads in-radius 10 [set hidden? true]
      ask m_bucketheads in-radius 10 [set hidden? true] ] ]
  ask lawn_mowers with [ycor = -120] [if xcor >= 288 [die]]
end

to spawn_zombies
  if timer >= 15 and timer <= 135 [wave0]
  if timer > 135 and timer <= 255 [wave1]
  if timer > 255 and timer <= 375 [wave2]
  if timer > 375 [set game_over? false]
end

to victory
  if game_over? = false [
    ca
    ask patch 0 0 [set plabel "VICTORY"] ]
end

to wave0
  set max_zombies0 6
  if current_zombies < max_zombies0 [
   every ((random 3) + 20) [
      let zombiespawner random 5
        if zombiespawner = 0 [
         ask patches with [pxcor = max-pxcor and pycor = 72] [
          sprout-mummies 1 [set shape "mummy" set size 55 set heading 270 set color gray set current_zombies (current_zombies + 1) set toughness 200] ] ]
        if zombiespawner = 1 [
         ask patches with [pxcor = max-pxcor and pycor = 24] [
          sprout-mummies 1 [set shape "mummy" set size 55 set heading 270 set color gray set current_zombies (current_zombies + 1) set toughness 200] ] ]
        if  zombiespawner = 2 [
         ask patches with [pxcor = max-pxcor and pycor = -24] [
          sprout-mummies 1 [set shape "mummy" set size 55 set heading 270 set color gray set current_zombies (current_zombies + 1) set toughness 200] ] ]
        if  zombiespawner = 3 [
         ask patches with [pxcor = max-pxcor and pycor = -72] [
          sprout-mummies  1 [set shape "mummy" set size 55 set heading 270 set color gray set current_zombies (current_zombies + 1) set toughness 200] ] ]
        if  zombiespawner = 4 [
         ask patches with [pxcor = max-pxcor and pycor = -120] [
          sprout-mummies 1 [set shape "mummy" set size 55 set heading 270 set color gray set current_zombies (current_zombies + 1) set toughness 200] ] ]
    ]
  ]
end

to wave1
  set max_zombies1 7
  if current_zombies < max_zombies1 [
   every 20 [
      let zombiespawner random 5
        if zombiespawner = 0 [
         ask patches with [pxcor = max-pxcor and pycor = 72] [
          sprout-mummies 1 [set shape "mummy" set size 55 set heading 270 set color gray set toughness 200 set damage 50] ] ]
        if zombiespawner = 1 [
         ask patches with [pxcor = max-pxcor and pycor = 24] [
          sprout-mummies 1 [set shape "mummy" set size 55 set heading 270 set color gray set toughness 200 set damage 50] ] ]
        if  zombiespawner = 2 [
         ask patches with [pxcor = max-pxcor and pycor = -24] [
          sprout-mummies 1 [set shape "mummy" set size 55 set heading 270 set color gray set toughness 200 set damage 50] ] ]
        if  zombiespawner = 3 [
         ask patches with [pxcor = max-pxcor and pycor = -72] [
          sprout-mummies  1 [set shape "mummy" set size 55 set heading 270 set color gray set toughness 200 set damage 50] ] ]
        if  zombiespawner = 4 [
         ask patches with [pxcor = max-pxcor and pycor = -120] [
          sprout-mummies 1 [set shape "mummy" set size 55 set heading 270 set color gray set toughness 200 set damage 50] ] ]
    if random 100 < 15 [
        if any? mummies with [max-pxcor = xcor] [
         ask one-of mummies with [max-pxcor = xcor] [
          hatch-m_coneheads 1 [
            set shape "mummy_conehead" set size 55 set heading 270 set color gray set toughness 560 set damage 50]
            die ] ]
  ]
  ]
  ]
end

to wave2
  set max_zombies2 10
  if current_zombies < max_zombies2 [
   every 20 [
      let zombiespawner random 5
        if zombiespawner = 0 [
         ask patches with [pxcor = max-pxcor and pycor = 72] [
          sprout-mummies 1 [set shape "mummy" set size 55 set heading 270 set color gray set toughness 200 set damage 50] ] ]
        if zombiespawner = 1 [
         ask patches with [pxcor = max-pxcor and pycor = 24] [
          sprout-mummies 1 [set shape "mummy" set size 55 set heading 270 set color gray set toughness 200 set damage 50] ] ]
        if  zombiespawner = 2 [
         ask patches with [pxcor = max-pxcor and pycor = -24] [
          sprout-mummies 1 [set shape "mummy" set size 55 set heading 270 set color gray set toughness 200 set damage 50] ] ]
        if  zombiespawner = 3 [
         ask patches with [pxcor = max-pxcor and pycor = -72] [
          sprout-mummies 1 [set shape "mummy" set size 55 set heading 270 set color gray set toughness 200 set damage 50] ] ]
        if  zombiespawner = 4 [
         ask patches with [pxcor = max-pxcor and pycor = -120] [
          sprout-mummies 1 [set shape "mummy" set size 55 set heading 270 set color gray set toughness 200 set damage 50] ] ]
      if random 100 < 30 [
        if any? mummies with [max-pxcor = xcor] [
         ask one-of mummies with [max-pxcor = xcor] [
           hatch-m_coneheads 1 [
            set shape "mummy_conehead" set size 55 set heading 270 set color gray set toughness 560 set damage 50]
            die ] ] ]
     if random 100 < 15 [
        if any? m_coneheads with [max-pxcor = xcor] [
         ask one-of m_coneheads with [max-pxcor = xcor] [
            hatch-m_bucketheads 1 [
         set shape "mummy_buckethead" set size 55 set heading 270 set color gray set toughness 1300 set damage 50]
            die ]]]
  ]
  ]
end

to zombieGo
  every 1 [ask mummies [
      fd 4 ]]
  ask mummies [
    if toughness <= 0 [
      set current_zombies (current_zombies - 1)
      die]]
  every 1 [ask m_coneheads [
      fd 4 ]]
  ask m_coneheads [
    if toughness <= 0 [
      set current_zombies (current_zombies - 1)
      die]]
  every 1 [ask m_bucketheads [
      fd 4 ]]
  ask m_bucketheads [
    if toughness <= 0 [
      set current_zombies (current_zombies - 1)
      die]]
end

to sunflowerGo
 every 1 [ask plants with [shape = "sunflower"] [
    ifelse borntime = 0
     [set borntime ticks]
     [if ((ticks - borntime) mod 10) = 0 [
      hatch-suns_from_sunflower 1 [set shape "sun" set size 50 setxy (([xcor] of myself) + 20) [ycor] of myself]]
    ]
    ]
  ]
end

to peashooterGo
  ask plants with [shape = "peashooter" and ycor = 72] [
    ifelse (count mummies with [ycor = 72 and xcor <= 288]) > 0
      [set detection true]
    [set detection false]
  ]
  ask plants with [shape = "peashooter" and ycor = 24] [
    ifelse (count mummies with [ycor = 24 and xcor <= 288]) > 0
      [set detection true]
    [set detection false]
  ]
  ask plants with [shape = "peashooter" and ycor = -24] [
    ifelse (count mummies with [ycor = -24 and xcor <= 288]) > 0
      [set detection true]
    [set detection false]
  ]
  ask plants with [shape = "peashooter" and ycor = -72] [
    ifelse (count mummies with [ycor = -72 and xcor <= 288]) > 0
      [set detection true]
    [set detection false]
  ]
  ask plants with [shape = "peashooter" and ycor = -120] [
    ifelse (count mummies with [ycor = -120 and xcor <= 288]) > 0
      [set detection true]
    [set detection false]
  ]
  ;--------------
  ask plants with [shape = "peashooter" and ycor = 72] [
    ifelse (count m_coneheads with [ycor = 72 and xcor <= 288]) > 0
      [set detection_c true]
    [set detection_c false]
  ]
  ask plants with [shape = "peashooter" and ycor = 24] [
    ifelse (count m_coneheads with [ycor = 24 and xcor <= 288]) > 0
      [set detection_c true]
    [set detection_c false]
  ]
  ask plants with [shape = "peashooter" and ycor = -24] [
    ifelse (count m_coneheads with [ycor = -24 and xcor <= 288]) > 0
      [set detection_c true]
    [set detection_c false]
  ]
  ask plants with [shape = "peashooter" and ycor = -72] [
    ifelse (count m_coneheads with [ycor = -72 and xcor <= 288]) > 0
      [set detection_c true]
    [set detection_c false]
  ]
  ask plants with [shape = "peashooter" and ycor = -120] [
    ifelse (count m_coneheads with [ycor = -120 and xcor <= 288]) > 0
      [set detection_c true]
    [set detection_c false]
  ]
  ;---------------
  ask plants with [shape = "peashooter" and ycor = 72] [
    ifelse (count m_bucketheads with [ycor = 72 and xcor <= 288]) > 0
      [set detection_b true]
    [set detection_b false]
  ]
  ask plants with [shape = "peashooter" and ycor = 24] [
    ifelse (count m_bucketheads with [ycor = 24 and xcor <= 288]) > 0
      [set detection_b true]
    [set detection_b false]
  ]
  ask plants with [shape = "peashooter" and ycor = -24] [
    ifelse (count m_bucketheads with [ycor = -24 and xcor <= 288]) > 0
      [set detection_b true]
    [set detection_b false]
  ]
  ask plants with [shape = "peashooter" and ycor = -72] [
    ifelse (count m_bucketheads with [ycor = -72 and xcor <= 288]) > 0
      [set detection_b true]
    [set detection_b false]
  ]
  ask plants with [shape = "peashooter" and ycor = -120] [
    ifelse (count m_bucketheads with [ycor = -120 and xcor <= 288]) > 0
      [set detection_b true]
    [set detection_b false]
  ]
  every 3 [
    ask plants with [shape = "peashooter" and detection = true] [
        hatch-projectiles 1 [set shape "peashooter_projectile" set size 60 set heading 90 set damage 20]
  ] ]
  every 3 [
    ask plants with [shape = "peashooter" and detection_c = true] [
        hatch-projectiles 1 [set shape "peashooter_projectile" set size 60 set heading 90 set damage 20]
  ] ]
  every 3 [
    ask plants with [shape = "peashooter" and detection_b = true] [
        hatch-projectiles 1 [set shape "peashooter_projectile" set size 60 set heading 90 set damage 20]
      ]
]
end



to peashooterPea
  every 0.01 [ask projectiles with [shape = "peashooter_projectile"] [
    fd 1]]
  ask projectiles with [shape = "peashooter_projectile"] [if xcor >= 288 [die]]
end

to collisionDetection
  ask projectiles with [ycor = 72] [
    if (min-one-of mummies with [ycor = 72] [distance myself]) != nobody [
      if (abs ((xcor) - ([xcor] of min-one-of mummies with [ycor = 72] [distance myself]))) <= 2 [
        ask min-one-of mummies with [ycor = 72] [distance myself] [
          set toughness (toughness - [damage] of myself)]
        die
      ]
    ]
  ]
  ask projectiles with [ycor = 24] [
    if (min-one-of mummies with [ycor = 24] [distance myself]) != nobody [
      if (abs ((xcor) - ([xcor] of min-one-of mummies with [ycor = 24] [distance myself]))) <= 2 [
        ask min-one-of mummies with [ycor = 24] [distance myself] [
          set toughness (toughness - [damage] of myself)]
        die
      ]
    ]
  ]
  ask projectiles with [ycor = -24] [
    if (min-one-of mummies with [ycor = -24] [distance myself]) != nobody [
      if (abs ((xcor) - ([xcor] of min-one-of mummies with [ycor = -24] [distance myself]))) <= 2 [
        ask min-one-of mummies with [ycor = -24] [distance myself] [
          set toughness (toughness - [damage] of myself)]
        die
      ]
    ]
  ]
  ask projectiles with [ycor = -72] [
    if (min-one-of mummies with [ycor = -72] [distance myself]) != nobody [
      if (abs ((xcor) - ([xcor] of min-one-of mummies with [ycor = -72] [distance myself]))) <= 2 [
        ask min-one-of mummies with [ycor = -72] [distance myself] [
          set toughness (toughness - [damage] of myself)]
        die
      ]
    ]
  ]
  ask projectiles with [ycor = -120] [
    if (min-one-of mummies with [ycor = -120] [distance myself]) != nobody [
      if (abs ((xcor) - ([xcor] of min-one-of mummies with [ycor = -120] [distance myself]))) <= 2 [
        ask min-one-of mummies with [ycor = -120] [distance myself] [
          set toughness (toughness - [damage] of myself)]
        die
      ]
    ]
  ]
  ;-----------------------------------------------------------------------------------------------------------
  ask projectiles with [ycor = 72] [
    if (min-one-of m_coneheads with [ycor = 72] [distance myself]) != nobody [
      if (abs ((xcor) - ([xcor] of min-one-of m_coneheads with [ycor = 72] [distance myself]))) <= 2 [
        ask min-one-of m_coneheads with [ycor = 72] [distance myself] [
          set toughness (toughness - [damage] of myself)]
        die
      ]
    ]
  ]
  ask projectiles with [ycor = 24] [
    if (min-one-of m_coneheads with [ycor = 24] [distance myself]) != nobody [
      if (abs ((xcor) - ([xcor] of min-one-of m_coneheads with [ycor = 24] [distance myself]))) <= 2 [
        ask min-one-of m_coneheads with [ycor = 24] [distance myself] [
          set toughness (toughness - [damage] of myself)]
        die
      ]
    ]
  ]
  ask projectiles with [ycor = -24] [
    if (min-one-of m_coneheads with [ycor = -24] [distance myself]) != nobody [
      if (abs ((xcor) - ([xcor] of min-one-of m_coneheads with [ycor = -24] [distance myself]))) <= 2 [
        ask min-one-of m_coneheads with [ycor = -24] [distance myself] [
          set toughness (toughness - [damage] of myself)]
        die
      ]
    ]
  ]
  ask projectiles with [ycor = -72] [
    if (min-one-of m_coneheads with [ycor = -72] [distance myself]) != nobody [
      if (abs ((xcor) - ([xcor] of min-one-of m_coneheads with [ycor = -72] [distance myself]))) <= 2 [
        ask min-one-of m_coneheads with [ycor = -72] [distance myself] [
          set toughness (toughness - [damage] of myself)]
        die
      ]
    ]
  ]
  ask projectiles with [ycor = -120] [
    if (min-one-of m_coneheads with [ycor = -120] [distance myself]) != nobody [
      if (abs ((xcor) - ([xcor] of min-one-of m_coneheads with [ycor = -120] [distance myself]))) <= 2 [
        ask min-one-of m_coneheads with [ycor = -120] [distance myself] [
          set toughness (toughness - [damage] of myself)]
        die
      ]
    ]
  ]
  ;------------------------------------------------------------------------------------------------------------
  ask projectiles with [ycor = 72] [
    if (min-one-of m_bucketheads with [ycor = 72] [distance myself]) != nobody [
      if (abs ((xcor) - ([xcor] of min-one-of m_bucketheads with [ycor = 72] [distance myself]))) <= 2 [
        ask min-one-of m_bucketheads with [ycor = 72] [distance myself] [
          set toughness (toughness - [damage] of myself)]
        die
      ]
    ]
  ]
  ask projectiles with [ycor = 24] [
    if (min-one-of m_bucketheads with [ycor = 24] [distance myself]) != nobody [
      if (abs ((xcor) - ([xcor] of min-one-of m_bucketheads with [ycor = 24] [distance myself]))) <= 2 [
        ask min-one-of m_bucketheads with [ycor = 24] [distance myself] [
          set toughness (toughness - [damage] of myself)]
        die
      ]
    ]
  ]
  ask projectiles with [ycor = -24] [
    if (min-one-of m_bucketheads with [ycor = -24] [distance myself]) != nobody [
      if (abs ((xcor) - ([xcor] of min-one-of m_bucketheads with [ycor = -24] [distance myself]))) <= 2 [
        ask min-one-of m_bucketheads with [ycor = -24] [distance myself] [
          set toughness (toughness - [damage] of myself)]
        die
      ]
    ]
  ]
  ask projectiles with [ycor = -72] [
    if (min-one-of m_bucketheads with [ycor = -72] [distance myself]) != nobody [
      if (abs ((xcor) - ([xcor] of min-one-of m_bucketheads with [ycor = -72] [distance myself]))) <= 2 [
        ask min-one-of m_bucketheads with [ycor = -72] [distance myself] [
          set toughness (toughness - [damage] of myself)]
        die
      ]
    ]
  ]
  ask projectiles with [ycor = -120] [
    if (min-one-of m_bucketheads with [ycor = -120] [distance myself]) != nobody [
      if (abs ((xcor) - ([xcor] of min-one-of m_bucketheads with [ycor = -120] [distance myself]))) <= 2 [
        ask min-one-of m_bucketheads with [ycor = -120] [distance myself] [
          set toughness (toughness - [damage] of myself)]
        die
      ]
    ]
  ]
end



to activate2
  ask lawn_mowers with [ycor = 72] [
    set heading 90
    forward 1
    set activated? True
  ]
end

to activate3
  ask lawn_mowers with [ycor = 24] [
    set heading 90
    forward 1
    set activated? True
  ]
end

to activate4
  ask lawn_mowers with [ycor = -24] [
    set heading 90
    forward 1
    set activated? True
  ]
end

to activate5
  ask lawn_mowers with [ycor = -72] [
    set heading 90
    forward 1
    set activated? True
  ]
end

to activate6
  ask lawn_mowers with [ycor = -120] [
    set heading 90
    forward 1
    set activated? True
  ]
end
@#$#@#$#@
GRAPHICS-WINDOW
236
51
947
483
-1
-1
1.0
1
10
1
1
1
0
0
0
1
-351
351
-211
211
0
0
1
ticks
30.0

BUTTON
173
483
236
516
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
174
518
237
551
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
140
51
235
96
NIL
Sunlight
17
1
11

MONITOR
140
199
235
244
NIL
plant-clipboard
17
1
11

@#$#@#$#@
## CREATOR

Rickey Dong from Mr. DW's Period 9 Intro Class

## WHAT IS IT?

This NetLogo program is an adaptation of the game "Plants vs. Zombies." The player is taken to Ancient Egypt where they have to defend against zombified mummies from their home. There are three variants of the mummy: a regular mummy, a conehead mummy, and a buckethead mummy. The player has a selection of two plants between a sunflower and a peashooter. Both are necessary for the player's survival. If a single mummy breaches the player's home, the player loses. If the player can survive for approximately six minutes, the player wins.

## HOW IT WORKS

My design plan when putting this model together was by thinking about how it would be played out chronologically. I first created the info screen, which gave the descriptions of the two plants. Then, to move on the actual game, I created a corner of green patches, where if clicked upon, the global variable next_screen? will become true and the game will commence. However, because the go button was a forever button, I needed to make sure that the procedures that were only supposed to run once, ran once. So, I turned the next_screen? global variable to false after setting up all the one-time procedures, making sure they would never be activated again with a if false statement. Then, I created the lawnmowers and the seed packets after importing the image. One coding part that I learned from a senpai from the CS Dojo that I found interesting was creating a temporary turtle to click on the seed packet to select it. Because the seed packets were actually turtles, I couldn't manipulate the patches directly to select them, so a temporary turtle is created to check if it is in the radius of the seed packet to select it. After selecting it, the plant-clipboard global variable is set and the next tile the player chooses will plant the plant they chose. Because the lawn was a drawing from import-drawing, and the tiles were rectangles and not squares, I had to use a formula to get the approximate center of each tile, which I also learned from the same senpai. In the game, the sunflowers produced sun at different times depending on when they were planted. I wanted to recreate that, so with the help of a classmate, I learned that you can set a tick to be passed every second and use that along with the variable reporting when the sunflowers were planted to create the different producing times. The zombie spawning procedure was also difficult, but thanks to the help of a senpai, I learned that let can be used as a temporary "set" to randomize the spawn points. By far the hardest part was the collision check - did the pea hit the zombie? With the help from a senpai, I learned about the primitve NetLogo functions "min-one-of," "distance," and "myself."     

## HOW TO USE IT

First, press the setup button. Then press the go button. When YOU ARE 100% READY, click the green corner. Once you press that, the game starts and CANNOT BE STOPPED. If you attempt to pause the game by repressing the go button, the game will have issues and cause certain procedures that need to have a wait time to immediately execute again. Click on the seed packets to select something. After clicking a seed packet, the plant-clipboard will update to show what you are about to plant. Then click on a tile that you want to plant on, and it will plant as long as you have sufficient sun, and then the plant-clipboard will become "empty." If you don't have sufficient sun, nothing happens. Make sure to press down hard and make sure not to misclick. Survive for 375 seconds to win!

## THINGS TO NOTICE

When you click on a seed packet to select it, the plant-clipboard gets updated. You can change your mind by clicking on the other seed packet. But if you changed your mind and didn't want to plant something at all, you're gonna have to plant something, which is why you should take your time and choose carefully. 

When your plant-clipboard gets updated, but then you want to collect a sun that's on the lawn, it's going to both collect the sun and plant what you wanted to plant at the same time, so be careful. 

Also, make sure not to misclick when selecting a tile to plant on, because if you plant something on a tile that already has a plant, nothing is preventing you from doing that, so they just stack on top of each other. 


## EXTENDING THE MODEL

One feature that could be added to extend the model is when the zombies detect collision with a plant, they stop and eat them. But as of right now, they just waltz on right through them.  

Another feature that could be added is having a recharge time on the seed packets so you can't spam-plant something.


## CREDITS AND REFERENCES

Benjamin from the CS Dojo - helped me with creating a temporary turtle to select other turtles, detecting collision between the pea and the zombies, detecting when the peashooters saw the zombie across the lane, determining the formula to approximate the center of each tile

Vicky/Ruoshui from the CS Dojo - helped with the creation of random zombie spawning with the NetLogo primitive "let"

Leonard Ma from Period 9 Mr. DW's Intro Class - helped with the independent ticks pattern for the sunflowers so they could produce sun at their own speed

Erin from the CS Dojo - helped with the creation of the info screen

NetLogo documentation on: "myself" "min-one-of" "distance" "let" "every" 

The Plants vs. Zombies Wiki for the data
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

balloon
false
0
Circle -7500403 true true 73 0 152
Polygon -7500403 true true 219 104 205 133 185 165 174 190 165 210 165 225 150 225 147 119
Polygon -7500403 true true 79 103 95 133 115 165 126 190 135 210 135 225 150 225 154 120
Rectangle -6459832 true false 129 241 173 273
Line -16777216 false 135 225 135 240
Line -16777216 false 165 225 165 240
Line -16777216 false 150 225 150 240

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

cha-boof!
false
0
Polygon -2674135 true false 45 75 30 90 45 150 60 135 60 120 75 105 75 150 30 165 15 75 30 60 45 75
Polygon -2674135 true false 75 60 90 150 105 135 90 105 105 90 120 135 135 135 120 45 90 60 105 75 90 75 90 60 75 60
Polygon -2674135 true false 150 135 165 45 195 45 210 135 195 135 180 90 165 90 165 135 165 135 150 135
Polygon -16777216 true false 165 75 180 60 195 75 165 75
Polygon -2674135 true false 225 75 225 105 270 105 270 75 225 75
Polygon -2674135 true false 30 180 30 270 60 270 75 255 60 240 45 240 45 225 60 225 75 210 60 180 30 180
Polygon -16777216 true false 30 195 60 195 45 225 30 210
Polygon -16777216 true false 30 255 60 240 45 270 30 255
Polygon -2674135 true false 75 180 120 180 120 270 75 270 75 195
Polygon -2674135 true false 135 180 180 180 180 270 135 270 135 195
Rectangle -16777216 true false 90 195 105 255
Rectangle -16777216 true false 150 195 165 255
Polygon -2674135 true false 195 180 240 180 240 195 210 195 210 225 240 225 240 240 210 240 210 270 195 270 195 165
Polygon -2674135 true false 255 150 255 240 285 240 285 150 255 150
Circle -2674135 true false 249 249 42

cherry_bomb
false
0
Circle -2674135 true false 146 146 127
Circle -2674135 true false 29 149 152
Polygon -10899396 true false 90 180 90 150 105 120 105 105 120 90 120 75 135 60 150 60 135 75 135 90 120 105 120 120 105 135 105 180 105 180 90 180
Polygon -10899396 true false 180 150 150 135 150 120 135 105 150 90 150 75 150 60 165 60 165 75 165 90 150 105 165 120 165 135 195 150 180 150
Polygon -10899396 true false 120 60 105 60 105 45 90 30 105 15 135 15 150 0 165 0 180 0 210 0 225 0 210 30 210 45 195 60 195 60 150 60 135 60 135 60
Line -16777216 false 165 0 105 60
Line -16777216 false 150 180 90 225
Line -16777216 false 45 180 75 210
Polygon -16777216 false false 45 195 45 210 60 225 75 210 45 195
Polygon -16777216 false false 135 195 150 210 135 240 120 240 105 225 135 195
Polygon -16777216 false false 75 270 105 255 135 255 135 270 120 285 105 285 90 285 75 270
Rectangle -1 true false 105 255 135 270
Polygon -14835848 true false 60 210 60 210
Line -16777216 false 180 180 210 195
Line -16777216 false 240 195 255 165
Polygon -16777216 true false 180 180 180 210 195 210 210 210 210 195 180 180
Polygon -16777216 true false 240 195 255 210 270 195 255 165
Line -16777216 false 180 165 210 180
Line -16777216 false 225 180 240 150
Polygon -16777216 false false 240 210 210 240 195 255 225 255 255 240 255 225 240 210
Rectangle -1 true false 240 210 255 240

cherry_bomb_seed_packet
false
7
Rectangle -1 true false 1 1 301 300
Rectangle -14835848 true true 17 8 288 294
Circle -2674135 true false 116 146 127
Circle -2674135 true false -1 149 152
Polygon -10899396 true false 60 180 60 150 75 120 75 105 90 90 90 75 105 60 120 60 105 75 105 90 90 105 90 120 75 135 75 180 75 180 60 180
Polygon -10899396 true false 150 150 120 135 120 120 105 105 120 90 120 75 120 60 135 60 135 75 135 90 120 105 135 120 135 135 165 150 150 150
Polygon -10899396 true false 90 60 75 60 75 45 60 30 75 15 105 15 120 0 135 0 150 0 180 0 195 0 180 30 180 45 165 60 165 60 120 60 105 60 105 60
Line -16777216 false 165 2 105 62
Line -16777216 false 120 180 60 225
Line -16777216 false 15 180 45 210
Polygon -16777216 false false 15 195 15 210 30 225 45 210 15 195
Polygon -16777216 false false 105 195 120 210 105 240 90 240 75 225 105 195
Polygon -16777216 false false 45 270 75 255 105 255 105 270 90 285 75 285 60 285 45 270
Rectangle -1 true false 75 255 105 270
Polygon -14835848 true true 60 210 60 210
Line -16777216 false 162 173 192 188
Line -16777216 false 195 195 210 165
Polygon -16777216 true false 156 177 156 207 171 207 186 207 186 192 156 177
Polygon -16777216 true false 205 197 220 212 235 197 220 167
Line -16777216 false 142 163 172 178
Line -16777216 false 198 188 213 158
Polygon -16777216 false false 210 210 180 240 165 255 195 255 225 240 225 225 210 210
Rectangle -1 true false 210 210 225 240
Polygon -1 true false 289 294 289 162 183 295 290 295
Polygon -16777216 true false 179 239 190 262 212 242 204 278 176 284 176 297 235 300 236 276 220 276 223 238 223 225 214 220 177 235 183 239 181 242
Polygon -16777216 true false 244 221 221 225 226 251 252 262 250 278 237 278 236 302 264 296 271 253 244 238 244 231 256 226 254 214 240 222
Rectangle -16777216 true false 271 216 296 298
Rectangle -1 true false 276 226 291 288
Line -16777216 false 18 7 93 7
Line -16777216 false 200 7 275 7
Line -16777216 false 112 8 187 8
Line -16777216 false 286 17 285 72
Line -16777216 false 287 89 286 144
Line -16777216 false 287 163 249 207
Line -16777216 false 243 219 198 275
Line -16777216 false 174 293 110 293
Line -16777216 false 79 293 15 293
Line -16777216 false 17 287 17 273
Line -16777216 false 19 163 19 97
Line -16777216 false 18 73 18 13

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fireball_projectile
false
0
Circle -2674135 true false 91 90 130
Circle -16777216 true false 107 108 85
Circle -955883 true false 121 121 30
Polygon -2674135 true false 114 107 78 100 56 104 48 115 38 104 22 105 8 116 20 150 33 146 37 153 19 167 19 181 33 192 59 201 87 217 97 218 137 217 155 220 172 210 102 178 103 136 111 106
Polygon -955883 true false 102 117 53 115 49 123 28 113 20 126 24 137 39 138 50 150 41 165 23 171 42 184 63 191 86 201 109 208
Polygon -1 true false 87 126 66 130 36 123 26 131 52 140 59 157 45 168 37 174 68 186 90 191 100 193 99 161 93 139 85 128
Circle -1 false false 95 100 110
Circle -955883 false false 105 100 110

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

ice_peashooter
false
0
Circle -11221820 true false 60 0 178
Circle -11221820 true false 213 63 85
Circle -16777216 true false 225 75 60
Circle -16777216 true false 75 30 60
Circle -16777216 true false 150 15 60
Circle -1 true false 105 45 30
Circle -1 true false 180 30 30
Line -16777216 false 15 60 60 30
Line -16777216 false 60 30 75 30
Polygon -11221820 true false 105 165 90 180 165 210 195 195 180 165 105 165
Polygon -14835848 true false 140 198 132 225 142 244 154 274 161 291 142 296 126 278 109 232 123 193 139 198
Polygon -14835848 true false 139 251 166 235 195 245 147 277 172 258 210 292 192 302 150 295 144 283 122 303 86 296 89 277 129 267 146 278 125 271 99 273 84 263 65 256 87 243 118 251 141 250
Line -16777216 false 105 266 127 265
Line -16777216 false 110 280 128 274
Line -16777216 false 175 283 149 276
Line -16777216 false 171 252 140 268
Polygon -11221820 true false 75 30 60 15 60 45 75 60 75 30
Polygon -11221820 true false 75 75 60 30 30 30 30 60 75 75
Polygon -11221820 true false 75 75 45 60 15 75 45 90 75 75
Polygon -11221820 true false 75 60 45 90 45 105 60 90 75 75 60 60
Polygon -11221820 true false 60 90 30 120 45 135 45 120 75 105 60 90
Line -16777216 false 75 30 30 60
Line -16777216 false 45 60 45 90
Line -16777216 false 45 90 60 105

ice_peashooter_projectile
false
0
Circle -11221820 true false 108 108 85
Circle -1 true false 120 120 30

ice_peashooter_seed_packet
false
7
Rectangle -1 true false 1 1 302 302
Rectangle -14835848 true true 10 9 293 292
Circle -11221820 true false 58 13 152
Circle -11221820 true false 192 68 74
Circle -16777216 true false 207 80 52
Circle -16777216 true false 72 39 40
Circle -1 true false 87 49 18
Polygon -11221820 true false 99 159 84 165 149 187 165 181 158 162 98 158
Polygon -14835848 true true 126 180 124 195 134 214 146 244 142 244 128 253 118 248 101 202 114 170 127 178
Polygon -14835848 true true 133 238 160 222 189 232 141 264 166 245 204 279 186 289 144 282 138 270 116 290 80 283 83 264 123 254 140 265 119 258 93 260 78 250 59 243 81 230 112 238 135 237
Line -16777216 false 88 245 110 244
Line -16777216 false 98 270 116 264
Line -16777216 false 171 275 145 268
Line -16777216 false 166 231 135 247
Polygon -11221820 true false 65 44 55 33 54 54 69 69 69 39
Polygon -11221820 true false 66 71 51 48 33 47 36 63 72 82
Polygon -11221820 true false 61 74 41 59 21 73 41 89 71 74
Polygon -11221820 true false 60 60 30 90 30 105 45 90 60 75 45 60
Polygon -11221820 true false 49 79 35 98 33 109 38 105 64 91 53 75
Line -16777216 false 68 43 34 64
Line -16777216 false 38 58 38 88
Line -16777216 false 39 79 54 94
Circle -16777216 true false 141 30 40
Circle -1 true false 155 39 18
Polygon -16777216 false false 41 251
Polygon -16777216 false false 115 171 102 197 115 239 82 230 59 241 75 250 88 258 129 255 137 265 117 257 80 263 81 283 115 289 136 269 141 282 189 288 204 280 167 249 146 262 164 244 169 248 190 229 160 222 144 234 122 196 125 179 115 173
Polygon -1 true false 293 298 293 171 194 297 292 297
Polygon -16777216 true false 185 226 198 241 215 221 215 281 196 282 194 297 245 297 240 279 228 283 228 198 209 197 187 229
Polygon -16777216 true false 262 197 237 203 233 213 240 236 255 230 256 258 243 267 247 296 269 297 268 239 264 220 244 221 268 213
Rectangle -16777216 true false 273 198 295 297
Rectangle -1 true false 279 209 290 290
Polygon -11221820 true false 117 172 103 197 113 236 85 231 58 240 87 260 128 259 134 263 118 258 78 264 80 281 117 290 134 273 136 283 187 291 205 283 189 261 171 251 159 254 163 247 173 251 191 232 157 220 148 226 130 199 130 178 114 173
Line -16777216 false 12 10 76 10
Line -16777216 false 241 9 292 10
Line -16777216 false 165 9 229 9
Line -16777216 false 90 9 154 9
Line -16777216 false 292 21 291 82
Line -16777216 false 293 100 292 161
Line -16777216 false 284 183 249 225
Line -16777216 false 241 235 206 277
Line -16777216 false 185 292 122 292
Line -16777216 false 91 292 28 292
Line -16777216 false 9 283 10 221
Line -16777216 false 9 205 10 143
Line -16777216 false 9 122 10 60
Line -16777216 false 10 54 10 16

iceberg_lettuce
false
0
Polygon -16777216 true false 195 45 180 90 195 120 210 120 240 120 240 90 195 45
Polygon -11221820 true false 285 210 255 225 255 240 210 225 165 255 120 225 45 210 60 180 30 180 60 165 90 195 30 135 60 105 75 135 90 120 105 165 120 150 165 210 225 165 240 180 270 120 285 135 285 150 270 165 270 180 255 180 255 195 285 210 255 195 255 180 270 180 270 165 285 150 285 135 270 120 270 105 255 90 255 75 240 75 240 60 240 60 210 45 195 30 180 30 195 15 165 45 195 15 195 0 165 15 135 30 150 15 90 45 75 60 75 75 60 105
Polygon -11221820 true false 60 105 75 135 90 120 105 165 120 150 165 210 210 180 240 195 240 180 225 165 195 180 60 105
Polygon -11221820 true false 60 105 210 165 195 180 60 105
Polygon -11221820 true false 195 165 180 180 210 195 225 165 210 150
Polygon -16777216 true false 105 60 105 75 90 90 90 105 105 120 135 120 150 105 135 75 120 60 105 60
Circle -1 true false 105 75 30
Polygon -1 true false 60 180 30 180 60 165 270 210 285 210 255 225 255 240 210 225 165 255 120 225 45 210 60 180
Polygon -16777216 true false 225 75 240 90 225 120 210 120 195 105 180 90 195 60 195 45 195 45 210 60 225 75
Circle -1 true false 195 75 30
Polygon -16777216 true false 180 90 180 120 210 120 180 90
Polygon -16777216 true false 90 90 90 75 105 60 105 75 90 90

iceberg_lettuce_seed_packet
false
7
Rectangle -1 true false 0 0 300 300
Rectangle -14835848 true true 15 15 285 285
Polygon -11221820 true false 270 225 240 240 240 255 195 240 150 270 105 240 30 225 45 195 15 195 45 180 75 210 15 150 45 120 60 150 75 135 90 180 120 150 150 225 210 180 225 195 255 135 270 150 270 165 255 180 255 195 240 195 240 210 270 225 240 210 240 195 255 195 255 180 270 165 270 150 255 135 255 120 240 105 240 90 225 90 225 75 225 75 195 60 180 45 165 45 180 30 150 60 180 30 180 15 150 30 120 45 135 30 75 60 60 75 60 90 45 120
Polygon -11221820 true false 45 120 60 150 75 135 90 180 105 165 150 225 195 195 225 210 225 195 210 180 180 195 45 120
Polygon -11221820 true false 45 120 195 180 180 195 45 120
Polygon -11221820 true false 195 180 180 195 210 210 225 180 210 165
Polygon -16777216 true false 90 75 90 90 75 105 75 120 90 135 120 135 135 120 120 90 105 75 90 75
Circle -1 true false 90 90 30
Polygon -1 true false 45 195 15 195 45 180 255 225 270 225 240 240 240 255 195 240 150 270 105 240 30 225 45 195
Polygon -16777216 true false 210 90 225 105 210 135 195 135 180 120 165 105 180 75 180 60 180 60 195 75 210 90
Circle -1 true false 180 90 30
Polygon -16777216 true false 165 105 165 135 195 135 165 105
Polygon -16777216 true false 75 105 60 90 90 75 90 90 75 105
Polygon -1 true false 285 285 285 180 180 285 285 285
Rectangle -16777216 true false 236 210 281 285
Rectangle -1 true false 246 225 271 274
Line -16777216 false 285 28 285 94
Line -16777216 false 250 15 283 15
Line -16777216 false 175 15 241 15
Line -16777216 false 96 15 162 15
Line -16777216 false 17 15 83 15
Line -16777216 false 285 103 285 169
Line -16777216 false 284 181 228 237
Line -16777216 false 223 241 178 285
Line -16777216 false 103 284 169 284
Line -16777216 false 22 283 88 283
Line -16777216 false 14 210 14 276
Line -16777216 false 16 33 16 99
Line -16777216 false 15 128 15 194

lawn_mower
false
0
Circle -13345367 true false 116 131 67
Circle -7500403 true true 129 144 42
Circle -13345367 true false 206 131 67
Circle -7500403 true true 219 144 42
Polygon -7500403 true true 120 195 30 120 15 90 60 60 105 105 150 135 165 165 135 195 120 195
Polygon -16777216 true false 75 90 60 120 30 90 45 75 75 90
Polygon -16777216 true false 105 150 75 135 90 105 120 135 105 150
Polygon -2674135 true false 105 195 135 150 165 150 150 180 165 180 150 180 165 150 135 150 105 195
Polygon -2674135 true false 105 195 150 195 165 165 150 195 180 195 195 195 180 195 165 180 165 165 150 150 105 195 120 195 135 210 135 225 135 225 150 225 150 240 165 240 195 255 210 255 210 225 225 225 255 225 255 195 270 180 255 165 240 165 210 150 210 180 195 195
Circle -13345367 true false 86 191 67
Circle -13345367 true false 191 191 67
Circle -7500403 true true 99 204 42
Circle -7500403 true true 204 204 42
Polygon -16777216 true false 150 165 180 135 225 150 210 195 150 165 150 195 195 210 210 195 195 210
Polygon -16777216 true false 210 195 195 210 150 165 210 195
Polygon -7500403 true true 180 165 210 165 195 195 165 195 180 165
Polygon -7500403 true true 195 180 195 210 150 195 150 210 150 225 150 225 165 225 165 210 195 210 210 225 210 195 195 195
Polygon -7500403 true true 150 195 195 195 195 210 150 195
Polygon -2674135 true false 45 135 30 150 15 135 0 150 15 180 30 180 45 180 45 165 45 165 45 165 30 150 45 135 60 150 45 165 60 180 60 195 30 195 15 180
Polygon -2674135 true false 30 150 15 180 45 180 45 165 30 150

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

mummy
false
5
Polygon -7500403 true false 202 217 227 251 211 260 199 237 191 234 188 212 204 214
Polygon -7500403 true false 123 169 113 184 97 192 95 206 106 217 104 198 109 193 122 182 101 198 105 215 98 210 98 215 114 226 112 208 115 223 120 225 118 203
Circle -7500403 true false 95 20 120
Polygon -1 true false 152 -2 179 29 132 5 151 -3 193 12 206 42 218 51
Polygon -1 true false 156 0 216 45 173 28 154 0
Line -16777216 false 207 68 231 54
Line -16777216 false 223 55 244 68
Circle -1 true false 153 54 42
Circle -16777216 true false 170 65 14
Polygon -1 true false 104 33 133 0 224 49 199 74 104 33
Polygon -16777216 true false 144 85 148 99 152 98 150 85 145 84
Circle -16777216 true false 129 87 8
Circle -1 true false 101 52 36
Circle -16777216 true false 108 61 12
Line -16777216 false 107 49 94 39
Line -16777216 false 92 42 81 52
Polygon -2064490 true false 108 106 163 108 181 116 181 131 134 129 124 131 108 103
Rectangle -1 true false 117 108 126 113
Rectangle -1 true false 137 108 146 113
Polygon -2674135 true false 130 129 140 122 161 121 178 118 178 127 173 130 134 130
Rectangle -1 true false 171 125 179 131
Polygon -6459832 true false 209 105 227 119 235 129 237 145 232 172 230 187 230 202 219 203 212 196 195 196 190 179 190 168 192 182 180 179 180 179
Polygon -2674135 true false 204 112 188 130 161 142 145 142 145 152 143 161 146 175 146 191 154 201 160 192 161 184 163 175 176 180 182 173 201 131 204 115
Polygon -955883 true false 145 179 159 175 142 160 182 168 145 149 193 154 155 143 203 135 186 159 183 171 176 179 158 173 162 186 145 182
Line -16777216 false 202 137 216 113
Line -16777216 false 201 138 236 133
Line -16777216 false 198 146 236 158
Line -16777216 false 190 157 234 176
Line -16777216 false 185 171 229 193
Polygon -1 true false 131 133 124 166 115 181 123 188 134 192 145 180 145 142 130 134
Polygon -7500403 true false 120 217 126 222 123 206 133 223 135 212 130 190 122 188 116 214
Polygon -1 true false 225 199 225 216 228 229 219 226 199 221 187 211 187 206 196 192 229 200
Polygon -1 true false 231 249 207 262 201 263 199 285 224 292 237 283 231 268 231 250
Line -16777216 false 198 275 231 269
Polygon -1 true false 133 194 164 223 134 190
Polygon -1 true false 131 187 158 219 178 204 178 181 163 173 156 199 146 191 145 179 135 189
Polygon -1 true false 157 220 137 244 122 263 118 274 162 288
Polygon -1 true false 162 289 187 294 201 291 204 276 198 261 184 262 179 258 165 257 155 259 158 222 113 272 164 289
Polygon -7500403 true false 160 218 147 236 148 245 157 231 159 245 164 235 172 256 172 239 177 252 180 245 188 253 184 228 163 217 148 231
Polygon -1 true false 194 192 184 226 179 232 160 222 173 205 183 175 193 182
Line -16777216 false 128 8 201 67
Line -16777216 false 146 3 196 28
Polygon -1 true false 218 114 200 141 239 133 221 115
Polygon -1 true false 190 155 181 168 230 193 230 174 188 156
Line -6459832 false 127 156 147 162
Line -6459832 false 119 172 144 189
Line -16777216 false 157 190 228 212
Line -16777216 false 136 249 163 260
Line -16777216 false 123 266 208 283

mummy_buckethead
false
5
Polygon -7500403 true false 202 217 227 251 211 260 199 237 191 234 188 212 204 214
Polygon -7500403 true false 123 169 113 184 97 192 95 206 106 217 104 198 109 193 122 182 101 198 105 215 98 210 98 215 114 226 112 208 115 223 120 225 118 203
Circle -7500403 true false 95 20 120
Circle -1 true false 153 54 42
Circle -16777216 true false 170 65 14
Polygon -16777216 true false 144 85 148 99 152 98 150 85 145 84
Circle -16777216 true false 129 87 8
Circle -1 true false 101 52 36
Circle -16777216 true false 108 61 12
Line -16777216 false 92 42 81 52
Polygon -2064490 true false 108 106 163 108 181 116 181 131 134 129 124 131 108 103
Rectangle -1 true false 117 108 126 113
Rectangle -1 true false 137 108 146 113
Polygon -2674135 true false 130 129 140 122 161 121 178 118 178 127 173 130 134 130
Rectangle -1 true false 171 125 179 131
Polygon -6459832 true false 209 105 227 119 235 129 237 145 232 172 230 187 230 202 219 203 212 196 195 196 190 179 190 168 192 182 180 179 180 179
Polygon -2674135 true false 204 112 188 130 161 142 145 142 145 152 143 161 146 175 146 191 154 201 160 192 161 184 163 175 176 180 182 173 201 131 204 115
Polygon -955883 true false 145 179 159 175 142 160 182 168 145 149 193 154 155 143 203 135 186 159 183 171 176 179 158 173 162 186 145 182
Line -16777216 false 202 137 216 113
Line -16777216 false 201 138 236 133
Line -16777216 false 198 146 236 158
Line -16777216 false 190 157 234 176
Line -16777216 false 185 171 229 193
Polygon -1 true false 131 133 124 166 115 181 123 188 134 192 145 180 145 142 130 134
Polygon -7500403 true false 120 217 126 222 123 206 133 223 135 212 130 190 122 188 116 214
Polygon -1 true false 225 199 225 216 228 229 219 226 199 221 187 211 187 206 196 192 229 200
Polygon -1 true false 231 249 207 262 201 263 199 285 224 292 237 283 231 268 231 250
Line -16777216 false 198 275 231 269
Polygon -1 true false 133 194 164 223 134 190
Polygon -1 true false 131 187 158 219 178 204 178 181 163 173 156 199 146 191 145 179 135 189
Polygon -1 true false 157 220 137 244 122 263 118 274 162 288
Polygon -1 true false 162 289 187 294 201 291 204 276 198 261 184 262 179 258 165 257 155 259 158 222 113 272 164 289
Polygon -7500403 true false 160 218 147 236 148 245 157 231 159 245 164 235 172 256 172 239 177 252 180 245 188 253 184 228 163 217 148 231
Polygon -1 true false 194 192 184 226 179 232 160 222 173 205 183 175 193 182
Polygon -1 true false 218 114 200 141 239 133 221 115
Polygon -1 true false 190 155 181 168 230 193 230 174 188 156
Line -6459832 false 127 156 147 162
Line -6459832 false 119 172 144 189
Line -16777216 false 157 190 228 212
Line -16777216 false 136 249 163 260
Line -16777216 false 123 266 208 283
Polygon -1 true false 131 44 102 34 147 -1 227 16 206 58 130 44
Polygon -1184463 true false 106 31 208 52 200 64 100 38 107 32
Polygon -13791810 true false 109 30 125 20 132 35 143 23 150 40 165 27 171 44 187 32 192 48 210 34 210 53 108 31
Polygon -6459832 true false 133 13 217 31 222 24 140 4 135 11
Circle -1184463 true false 196 38 42
Circle -16777216 false false 204 46 28
Circle -16777216 true false 205 46 26

mummy_buckethead_eating
false
0
Polygon -6459832 true false 135 135 75 150 45 165 45 195 60 195 75 180 120 165 135 150 150 150 135 135
Polygon -7500403 true true 202 217 227 251 211 260 199 237 191 234 188 212 204 214
Circle -7500403 true true 95 20 120
Circle -1 true false 153 54 42
Circle -16777216 true false 170 65 14
Polygon -16777216 true false 144 85 148 99 152 98 150 85 145 84
Circle -16777216 true false 129 87 8
Circle -1 true false 101 52 36
Circle -16777216 true false 108 61 12
Line -16777216 false 92 42 81 52
Polygon -2064490 true false 108 106 163 108 181 116 181 131 134 129 124 131 108 103
Rectangle -1 true false 117 108 126 113
Rectangle -1 true false 137 108 146 113
Polygon -2674135 true false 130 129 140 122 161 121 178 118 178 127 173 130 134 130
Rectangle -1 true false 171 125 179 131
Polygon -6459832 true false 209 105 227 119 235 129 237 145 232 172 230 187 230 202 219 203 212 196 195 196 190 179 190 168 192 182 180 179 180 179
Polygon -2674135 true false 204 112 188 130 161 142 145 142 145 152 143 161 146 175 146 191 154 201 160 192 161 184 163 175 176 180 182 173 201 131 204 115
Polygon -955883 true false 145 179 159 175 142 160 182 168 145 149 193 154 155 143 203 135 186 159 183 171 176 179 158 173 162 186 145 182
Line -16777216 false 202 137 216 113
Line -16777216 false 201 138 236 133
Line -16777216 false 198 146 236 158
Line -16777216 false 190 157 234 176
Line -16777216 false 185 171 229 193
Polygon -1 true false 225 199 225 216 228 229 219 226 199 221 187 211 187 206 196 192 229 200
Polygon -1 true false 231 249 207 262 201 263 199 285 224 292 237 283 231 268 231 250
Line -16777216 false 198 275 231 269
Polygon -1 true false 133 194 164 223 134 190
Polygon -1 true false 131 187 158 219 178 204 178 181 163 173 156 199 146 191 145 179 135 189
Polygon -1 true false 157 220 137 244 122 263 118 274 162 288
Polygon -1 true false 162 289 187 294 201 291 204 276 198 261 184 262 179 258 165 257 155 259 158 222 113 272 164 289
Polygon -7500403 true true 160 172 135 150 148 145 157 159 150 135 150 120 165 120 172 151 180 135 180 145 195 135 184 162 163 173 135 165
Polygon -1 true false 194 198 184 164 179 158 160 168 173 185 183 215 193 208
Polygon -1 true false 218 114 200 141 239 133 221 115
Polygon -1 true false 190 155 181 168 230 193 230 174 188 156
Line -16777216 false 157 190 228 212
Line -16777216 false 136 249 163 260
Line -16777216 false 123 266 208 283
Polygon -7500403 true true 45 165 15 165 0 150 15 180 0 180 15 180 15 195 0 210 15 195 0 210 15 210 15 225 30 210 30 195 45 195 45 165
Line -16777216 false 120 135 135 165
Line -16777216 false 75 150 90 180
Line -16777216 false 90 150 105 180
Line -16777216 false 105 135 120 165
Polygon -1 true false 75 150 45 165 45 195 60 195 75 180 90 180 75 150
Polygon -1 true false 90 150 105 135 120 165 105 165 90 150
Polygon -1 true false 119 45 104 30 149 0 224 15 179 60 119 45
Polygon -1184463 true false 104 31 179 60 189 51 119 22 101 31
Polygon -13791810 true false 120 23 142 15 145 26 163 23 166 34 183 28 181 38 204 34 189 49 118 21
Polygon -6459832 true false 142 7 212 23 207 31 134 9 139 6
Circle -1184463 true false 182 39 44
Circle -16777216 true false 188 43 34

mummy_conehead
false
0
Polygon -7500403 true true 202 217 227 251 211 260 199 237 191 234 188 212 204 214
Polygon -7500403 true true 123 169 113 184 97 192 95 206 106 217 104 198 109 193 122 182 101 198 105 215 98 210 98 215 114 226 112 208 115 223 120 225 118 203
Circle -7500403 true true 95 20 120
Circle -1 true false 153 54 42
Circle -16777216 true false 170 65 14
Polygon -16777216 true false 144 85 148 99 152 98 150 85 145 84
Circle -16777216 true false 129 87 8
Circle -1 true false 101 52 36
Circle -16777216 true false 108 61 12
Polygon -2064490 true false 108 106 163 108 181 116 181 131 134 129 124 131 108 103
Rectangle -1 true false 117 108 126 113
Rectangle -1 true false 137 108 146 113
Polygon -2674135 true false 130 129 140 122 161 121 178 118 178 127 173 130 134 130
Rectangle -1 true false 171 125 179 131
Polygon -6459832 true false 209 105 227 119 235 129 237 145 232 172 230 187 230 202 219 203 212 196 195 196 190 179 190 168 192 182 180 179 180 179
Polygon -2674135 true false 204 112 188 130 161 142 145 142 145 152 143 161 146 175 146 191 154 201 160 192 161 184 163 175 176 180 182 173 201 131 204 115
Polygon -955883 true false 145 179 159 175 142 160 182 168 145 149 193 154 155 143 203 135 186 159 183 171 176 179 158 173 162 186 145 182
Line -16777216 false 202 137 216 113
Line -16777216 false 201 138 236 133
Line -16777216 false 198 146 236 158
Line -16777216 false 190 157 234 176
Line -16777216 false 185 171 229 193
Polygon -1 true false 131 133 124 166 115 181 123 188 134 192 145 180 145 142 130 134
Polygon -7500403 true true 120 217 126 222 123 206 133 223 135 212 130 190 122 188 116 214
Polygon -1 true false 225 199 225 216 228 229 219 226 199 221 187 211 187 206 196 192 229 200
Polygon -1 true false 231 249 207 262 201 263 199 285 224 292 237 283 231 268 231 250
Line -16777216 false 198 275 231 269
Polygon -1 true false 133 194 164 223 134 190
Polygon -1 true false 131 187 158 219 178 204 178 181 163 173 156 199 146 191 145 179 135 189
Polygon -1 true false 157 220 137 244 122 263 118 274 162 288
Polygon -1 true false 162 289 187 294 201 291 204 276 198 261 184 262 179 258 165 257 155 259 158 222 113 272 164 289
Polygon -7500403 true true 160 218 147 236 148 245 157 231 159 245 164 235 172 256 172 239 177 252 180 245 188 253 184 228 163 217 148 231
Polygon -1 true false 194 192 184 226 179 232 160 222 173 205 183 175 193 182
Polygon -1 true false 218 114 200 141 239 133 221 115
Polygon -1 true false 190 155 181 168 230 193 230 174 188 156
Line -6459832 false 127 156 147 162
Line -6459832 false 119 172 144 189
Line -16777216 false 157 190 228 212
Line -16777216 false 136 249 163 260
Line -16777216 false 123 266 208 283
Polygon -1 true false 99 42 204 57 204 42 129 27 99 42
Polygon -1 true false 97 53 206 70 206 60 103 43 95 54
Polygon -955883 true false 116 44 173 -1 184 53 180 33 220 34 210 67 88 42 105 16 137 27
Polygon -1184463 true false 165 18 171 25 161 35 157 43 175 44 174 56 149 51 128 47 132 33 144 38 153 33 154 26 150 19 160 5 171 7 174 13 168 20

mummy_conehead_eating
false
0
Polygon -6459832 true false 135 135 75 150 45 165 45 195 60 195 75 180 120 165 135 150 150 150 135 135
Polygon -7500403 true true 202 217 227 251 211 260 199 237 191 234 188 212 204 214
Circle -7500403 true true 95 20 120
Circle -1 true false 153 54 42
Circle -16777216 true false 170 65 14
Polygon -16777216 true false 144 85 148 99 152 98 150 85 145 84
Circle -16777216 true false 129 87 8
Circle -1 true false 101 52 36
Circle -16777216 true false 108 61 12
Line -16777216 false 92 42 81 52
Polygon -2064490 true false 108 106 163 108 181 116 181 131 134 129 124 131 108 103
Rectangle -1 true false 117 108 126 113
Rectangle -1 true false 137 108 146 113
Polygon -2674135 true false 130 129 140 122 161 121 178 118 178 127 173 130 134 130
Rectangle -1 true false 171 125 179 131
Polygon -6459832 true false 209 105 227 119 235 129 237 145 232 172 230 187 230 202 219 203 212 196 195 196 190 179 190 168 192 182 180 179 180 179
Polygon -2674135 true false 204 112 188 130 161 142 145 142 145 152 143 161 146 175 146 191 154 201 160 192 161 184 163 175 176 180 182 173 201 131 204 115
Polygon -955883 true false 145 179 159 175 142 160 182 168 145 149 193 154 155 143 203 135 186 159 183 171 176 179 158 173 162 186 145 182
Line -16777216 false 202 137 216 113
Line -16777216 false 201 138 236 133
Line -16777216 false 198 146 236 158
Line -16777216 false 190 157 234 176
Line -16777216 false 185 171 229 193
Polygon -1 true false 225 199 225 216 228 229 219 226 199 221 187 211 187 206 196 192 229 200
Polygon -1 true false 231 249 207 262 201 263 199 285 224 292 237 283 231 268 231 250
Line -16777216 false 198 275 231 269
Polygon -1 true false 133 194 164 223 134 190
Polygon -1 true false 131 187 158 219 178 204 178 181 163 173 156 199 146 191 145 179 135 189
Polygon -1 true false 157 220 137 244 122 263 118 274 162 288
Polygon -1 true false 162 289 187 294 201 291 204 276 198 261 184 262 179 258 165 257 155 259 158 222 113 272 164 289
Polygon -7500403 true true 160 172 135 150 148 145 157 159 150 135 150 120 165 120 172 151 180 135 180 145 195 135 184 162 163 173 135 165
Polygon -1 true false 194 198 184 164 179 158 160 168 173 185 183 215 193 208
Polygon -1 true false 218 114 200 141 239 133 221 115
Polygon -1 true false 190 155 181 168 230 193 230 174 188 156
Line -16777216 false 157 190 228 212
Line -16777216 false 136 249 163 260
Line -16777216 false 123 266 208 283
Polygon -7500403 true true 45 165 15 165 0 150 15 180 0 180 15 180 15 195 0 210 15 195 0 210 15 210 15 225 30 210 30 195 45 195 45 165
Line -16777216 false 120 135 135 165
Line -16777216 false 75 150 90 180
Line -16777216 false 90 150 105 180
Line -16777216 false 105 135 120 165
Polygon -1 true false 75 150 45 165 45 195 60 195 75 180 90 180 75 150
Polygon -1 true false 90 150 105 135 120 165 105 165 90 150
Polygon -1 true false 105 45 210 60 210 45 105 30 105 45
Polygon -955883 true false 124 39 173 4 189 49 210 51 210 64 94 43 98 31 126 38
Polygon -1184463 true false 163 19 155 21 143 25 146 32 152 34 137 46 162 45 173 48 173 38 164 30 173 27 173 20 164 19 161 19

mummy_eating
false
0
Polygon -6459832 true false 135 135 75 150 45 165 45 195 60 195 75 180 120 165 135 150 150 150 135 135
Polygon -7500403 true true 202 217 227 251 211 260 199 237 191 234 188 212 204 214
Circle -7500403 true true 95 20 120
Polygon -1 true false 152 -2 179 29 132 5 151 -3 193 12 206 42 218 51
Polygon -1 true false 156 0 216 45 173 28 154 0
Line -16777216 false 207 68 231 54
Line -16777216 false 223 55 244 68
Circle -1 true false 153 54 42
Circle -16777216 true false 170 65 14
Polygon -1 true false 104 33 133 0 224 49 199 74 104 33
Polygon -16777216 true false 144 85 148 99 152 98 150 85 145 84
Circle -16777216 true false 129 87 8
Circle -1 true false 101 52 36
Circle -16777216 true false 108 61 12
Line -16777216 false 107 49 94 39
Line -16777216 false 92 42 81 52
Polygon -2064490 true false 108 106 163 108 181 116 181 131 134 129 124 131 108 103
Rectangle -1 true false 117 108 126 113
Rectangle -1 true false 137 108 146 113
Polygon -2674135 true false 130 129 140 122 161 121 178 118 178 127 173 130 134 130
Rectangle -1 true false 171 125 179 131
Polygon -6459832 true false 209 105 227 119 235 129 237 145 232 172 230 187 230 202 219 203 212 196 195 196 190 179 190 168 192 182 180 179 180 179
Polygon -2674135 true false 204 112 188 130 161 142 145 142 145 152 143 161 146 175 146 191 154 201 160 192 161 184 163 175 176 180 182 173 201 131 204 115
Polygon -955883 true false 145 179 159 175 142 160 182 168 145 149 193 154 155 143 203 135 186 159 183 171 176 179 158 173 162 186 145 182
Line -16777216 false 202 137 216 113
Line -16777216 false 201 138 236 133
Line -16777216 false 198 146 236 158
Line -16777216 false 190 157 234 176
Line -16777216 false 185 171 229 193
Polygon -1 true false 225 199 225 216 228 229 219 226 199 221 187 211 187 206 196 192 229 200
Polygon -1 true false 231 249 207 262 201 263 199 285 224 292 237 283 231 268 231 250
Line -16777216 false 198 275 231 269
Polygon -1 true false 133 194 164 223 134 190
Polygon -1 true false 131 187 158 219 178 204 178 181 163 173 156 199 146 191 145 179 135 189
Polygon -1 true false 157 220 137 244 122 263 118 274 162 288
Polygon -1 true false 162 289 187 294 201 291 204 276 198 261 184 262 179 258 165 257 155 259 158 222 113 272 164 289
Polygon -7500403 true true 160 172 135 150 148 145 157 159 150 135 150 120 165 120 172 151 180 135 180 145 195 135 184 162 163 173 135 165
Polygon -1 true false 194 198 184 164 179 158 160 168 173 185 183 215 193 208
Line -16777216 false 128 8 201 67
Line -16777216 false 146 3 196 28
Polygon -1 true false 218 114 200 141 239 133 221 115
Polygon -1 true false 190 155 181 168 230 193 230 174 188 156
Line -16777216 false 157 190 228 212
Line -16777216 false 136 249 163 260
Line -16777216 false 123 266 208 283
Polygon -7500403 true true 45 165 15 165 0 150 15 180 0 180 15 180 15 195 0 210 15 195 0 210 15 210 15 225 30 210 30 195 45 195 45 165
Line -16777216 false 120 135 135 165
Line -16777216 false 75 150 90 180
Line -16777216 false 90 150 105 180
Line -16777216 false 105 135 120 165
Polygon -1 true false 75 150 45 165 45 195 60 195 75 180 90 180 75 150
Polygon -1 true false 90 150 105 135 120 165 105 165 90 150

oval
false
0
Line -16777216 false 135 225 135 240
Line -16777216 false 165 225 165 240
Line -16777216 false 150 225 150 240
Polygon -7500403 true true 75 135 90 120 105 120 120 120 210 120 225 135 225 165 210 180 90 180 75 165 75 135
Circle -7500403 true true 60 120 60
Circle -7500403 true true 180 120 60

peashooter
false
0
Circle -13840069 true false 60 0 178
Circle -13840069 true false 213 63 85
Circle -16777216 true false 225 75 60
Circle -16777216 true false 75 30 60
Circle -16777216 true false 150 15 60
Circle -1 true false 105 45 30
Circle -1 true false 180 30 30
Polygon -13840069 true false 90 30 60 15 45 15 30 30 15 45 15 60 15 60 45 60 60 45 75 45 90 30
Line -16777216 false 15 60 60 30
Line -16777216 false 60 30 75 30
Polygon -13840069 true false 105 165 90 180 165 210 195 195 180 165 105 165
Polygon -13840069 true false 140 198 132 225 142 244 154 274 161 291 142 296 126 278 109 232 123 193 139 198
Polygon -13840069 true false 139 251 166 235 195 245 147 277 172 258 210 292 192 302 150 295 144 283 122 303 86 296 89 277 129 267 146 278 125 271 99 273 84 263 65 256 87 243 118 251 141 250
Line -16777216 false 105 266 127 265
Line -16777216 false 110 280 128 274
Line -16777216 false 175 283 149 276
Line -16777216 false 171 252 140 268

peashooter_projectile
false
0
Circle -13840069 true false 108 108 85
Circle -1 true false 120 120 30

peashooter_seed_packet
false
7
Rectangle -1 true false 0 -3 302 304
Rectangle -14835848 true true 8 12 289 291
Circle -13840069 true false 46 22 130
Circle -13840069 true false 159 71 58
Circle -16777216 true false 175 82 36
Circle -16777216 true false 67 58 38
Circle -16777216 true false 127 58 38
Circle -1 true false 78 64 24
Circle -1 true false 139 63 24
Polygon -13840069 true false 53 62 40 61 26 60 10 60 5 69 6 81 7 82 18 80 40 75 55 75 64 62
Line -16777216 false 5 79 30 63
Line -16777216 false 29 63 44 63
Polygon -13840069 true false 85 146 75 157 127 170 149 161 141 143 84 147
Polygon -13840069 true false 117 163 117 174 127 193 139 223 136 230 123 234 111 227 94 181 103 157 118 161
Polygon -13840069 true false 137 230 153 225 177 233 145 256 170 237 192 265 185 276 153 269 142 262 122 273 91 273 87 256 127 246 144 257 123 250 97 252 82 242 63 235 85 222 116 230 139 229
Line -16777216 false 94 239 116 238
Line -16777216 false 112 262 130 256
Line -16777216 false 172 264 146 257
Line -16777216 false 158 229 127 245
Polygon -1 true false 290 292 291 174 181 291 294 291
Line -16777216 false 100 12 178 12
Line -16777216 false 196 12 274 12
Line -16777216 false 9 12 87 12
Line -16777216 false 233 231 285 180
Line -16777216 false 7 291 81 291
Line -16777216 false 9 203 9 281
Line -16777216 false 9 101 9 23
Line -16777216 false 288 31 288 109
Line -16777216 false 288 121 289 176
Line -16777216 false 9 114 9 192
Line -16777216 false 180 291 230 236
Line -16777216 false 172 291 88 291
Polygon -16777216 true false 209 226 195 237 203 246 217 234 213 280 186 279 187 290 237 293 237 277 220 277 227 224 220 217 200 236
Polygon -16777216 true false 249 293 244 292 241 224 264 222 268 292 251 292 248 292
Polygon -1 true false 251 247 253 283 260 279 258 237 249 239 253 258
Polygon -16777216 true false 277 293 272 292 269 224 292 222 296 292 279 292 276 292
Polygon -1 true false 279 246 281 282 288 278 286 236 277 238 281 257

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

potato_mine_armed
false
0
Polygon -6459832 true false 0 225 45 195 75 225 75 255 60 285 45 300 15 255 0 225 15 300 90 300 90 270 75 255 105 285 120 300 90 300 135 300 180 300 210 300 225 300 240 285 255 270 255 240 270 225 300 225 255 195 240 240 255 270 285 285 300 300 300 240 285 225
Rectangle -7500403 true true 135 90 165 165
Circle -6459832 true false 60 135 180
Circle -2674135 true false 103 13 92
Circle -1 true false 114 24 42
Circle -16777216 true false 105 165 60
Circle -16777216 true false 165 165 60
Circle -1 true false 135 180 30
Circle -1 true false 195 180 30
Line -16777216 false 150 255 150 285
Line -16777216 false 150 285 195 270
Line -16777216 false 195 240 195 270
Polygon -1 true false 150 270 150 285 195 270 195 255 150 270
Polygon -1 true false 150 270 195 255 195 240 150 255 150 270
Line -16777216 false 150 270 195 255
Line -16777216 false 195 240 150 255
Line -16777216 false 150 255 150 285
Polygon -6459832 true false 0 225 60 225 75 285 60 300 0 300 0 225
Polygon -6459832 true false 60 270 75 300 120 300 120 285 60 285
Polygon -6459832 true false 240 225 255 195 300 195 300 300 225 300 240 225
Line -16777216 false 150 270 120 255
Line -16777216 false 195 255 210 240

potato_mine_seed_packet
false
7
Rectangle -1 true false 0 0 300 300
Rectangle -14835848 true true 14 15 284 285
Rectangle -7500403 true false 90 90 120 165
Circle -6459832 true false 21 130 168
Circle -2674135 true false 58 13 92
Circle -1 true false 69 24 42
Circle -16777216 true false 60 165 60
Circle -16777216 true false 125 164 60
Circle -1 true false 90 180 30
Circle -1 true false 150 180 30
Line -16777216 false 150 240 150 270
Line -16777216 false 105 285 150 270
Line -16777216 false 150 240 150 270
Polygon -1 true false 105 270 105 285 150 270 150 255 105 270
Polygon -1 true false 105 270 150 255 150 240 105 255 105 270
Line -16777216 false 105 270 150 255
Line -16777216 false 150 240 105 255
Line -16777216 false 105 255 105 285
Line -16777216 false 105 270 75 255
Line -16777216 false 150 255 165 240
Polygon -1 true false 285 285 285 165 195 270 180 285 285 285
Polygon -16777216 true false 190 210 205 225 220 210 235 225 190 270 175 285 175 300 235 300 250 285 205 285 235 255 250 240 250 210 235 195 205 195 190 210
Polygon -16777216 true false 254 194 294 194 293 210 271 214 271 241 292 268 291 297 250 299 250 278 274 279 261 260 253 220 251 194
Line -16777216 false 215 15 279 14
Line -16777216 false 16 15 85 16
Line -16777216 false 125 16 210 15
Line -16777216 false 284 29 284 85
Line -16777216 false 284 101 284 157
Line -16777216 false 277 176 238 219
Line -16777216 false 229 229 190 272
Line -16777216 false 14 29 13 99
Line -16777216 false 14 122 13 192

potato_mine_unarmed
false
0
Circle -7500403 true true 105 90 90
Rectangle -7500403 true true 135 165 165 255
Circle -6459832 true false 26 161 67
Circle -6459832 true false -4 206 67
Circle -6459832 true false 236 206 67
Circle -6459832 true false 161 161 67
Circle -6459832 true false 71 161 67
Circle -6459832 true false -4 161 67
Circle -6459832 true false 251 161 67
Circle -6459832 true false 206 161 67
Circle -6459832 true false 41 206 67
Circle -6459832 true false 191 191 67
Circle -6459832 true false 146 206 67
Circle -6459832 true false 101 206 67

repeater
false
0
Circle -13840069 true false 60 0 178
Circle -13840069 true false 213 63 85
Circle -16777216 true false 225 75 60
Circle -16777216 true false 75 45 60
Circle -16777216 true false 150 45 60
Circle -1 true false 105 60 30
Circle -1 true false 180 60 30
Polygon -13840069 true false 90 30 60 15 45 15 30 30 15 45 15 60 15 60 45 60 60 45 75 45 90 30
Line -16777216 false 15 60 60 30
Line -16777216 false 60 30 75 30
Polygon -13840069 true false 105 165 90 180 165 210 195 195 180 165 105 165
Polygon -13840069 true false 140 198 132 225 142 244 154 274 161 291 142 296 126 278 109 232 123 193 139 198
Polygon -13840069 true false 139 251 166 235 195 245 147 277 172 258 210 292 192 302 150 295 144 283 122 303 86 296 89 277 129 267 146 278 125 271 99 273 84 263 65 256 87 243 118 251 141 250
Line -16777216 false 105 266 127 265
Line -16777216 false 110 280 128 274
Line -16777216 false 175 283 149 276
Line -16777216 false 171 252 140 268
Polygon -16777216 true false 105 15 90 30 135 60 135 30 105 15
Polygon -16777216 true false 180 15 195 30 150 60 150 30 180 15
Polygon -13840069 true false 60 60 75 60 60 90 30 105 0 90 30 75 30 60 60 60
Line -16777216 false 60 75 15 90
Polygon -13840069 true false 60 105 30 105 15 120 0 120 15 150 30 135 75 135 60 105
Line -16777216 false 60 120 15 135

repeater_seed_packet
false
7
Rectangle -1 true false 0 0 300 300
Rectangle -14835848 true true 8 11 288 291
Circle -13840069 true false 58 13 152
Circle -13840069 true false 193 70 66
Circle -16777216 true false 207 80 46
Circle -16777216 true false 77 55 44
Circle -16777216 true false 143 53 44
Circle -1 true false 159 64 24
Polygon -13840069 true false 90 30 60 15 45 15 30 30 15 45 15 60 15 60 45 60 60 45 75 45 90 30
Line -16777216 false 15 60 60 30
Line -16777216 false 60 30 75 30
Polygon -13840069 true false 101 165 83 172 146 188 171 178 165 156 103 157
Polygon -13840069 true false 128 179 125 198 135 217 147 247 154 264 135 269 119 251 102 205 114 176 128 179
Polygon -13840069 true false 131 232 158 216 187 226 139 258 164 239 202 273 184 283 142 276 136 264 114 284 78 277 81 258 121 248 138 259 117 252 91 254 76 244 57 237 79 224 110 232 133 231
Line -16777216 false 86 243 108 242
Line -14835848 true 94 270 112 264
Line -16777216 false 174 264 148 257
Line -16777216 false 167 225 136 241
Polygon -16777216 true false 90 30 75 30 120 60 120 45 90 30
Polygon -16777216 true false 170 24 170 39 140 54 140 39 170 24
Polygon -13840069 true false 60 60 75 60 60 90 30 105 0 90 30 75 30 60 60 60
Line -16777216 false 60 75 15 90
Polygon -13840069 true false 60 105 30 105 15 120 0 120 15 150 30 135 75 135 60 105
Line -16777216 false 60 120 15 135
Circle -1 true false 94 65 24
Polygon -1 true false 291 298 294 155 198 291 301 293
Polygon -16777216 true false 191 209 204 235 217 212 228 222 201 261 187 288 190 295 237 295 235 272 207 275 220 260 243 215 232 196 216 190 193 208
Rectangle -16777216 true false 244 193 269 295
Rectangle -16777216 true false 272 193 297 295
Rectangle -1 true false 251 209 264 282
Rectangle -1 true false 279 210 292 283
Line -16777216 false 7 12 82 12
Line -16777216 false 287 20 287 95
Line -16777216 false 207 12 282 12
Line -16777216 false 107 12 182 12
Line -16777216 false 287 106 287 167
Line -16777216 false 277 178 223 255
Line -16777216 false 180 290 103 289
Line -16777216 false 84 290 7 289
Line -16777216 false 9 284 9 206
Line -16777216 false 9 190 9 112
Line -16777216 false 7 102 7 24

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

spikeweed
false
0
Polygon -10899396 true false 30 240 15 225 30 210 45 195 45 180 75 165 105 150 135 150 165 150 195 150 225 165 270 180 285 210 285 255 255 255 285 270 240 270 240 300 180 285 150 285 135 285 105 285 75 300 60 285 15 300 30 270 0 270 30 240
Polygon -13840069 true false 60 195 45 150 90 180 60 195
Polygon -13840069 true false 240 270 300 240 270 270 240 270
Polygon -13840069 true false 255 240 285 195 285 240 255 240
Polygon -13840069 true false 135 165 150 120 165 165 135 165
Polygon -13840069 true false 30 225 0 210 60 210 30 225
Polygon -13840069 true false 270 210 285 165 240 195 270 210
Polygon -13840069 true false 105 180 90 135 135 165 105 180
Polygon -13840069 true false 180 135 165 180 210 150 180 135
Polygon -13840069 true false 210 165 255 150 225 195 210 165
Polygon -16777216 true false 225 240 195 225 165 255 195 270 210 270 225 240
Polygon -16777216 true false 75 240 105 225 135 255 105 270 90 270 75 240
Polygon -2674135 true false 105 225 90 255 105 270 120 255 105 225
Polygon -2674135 true false 195 225 180 255 195 270 210 255 195 225
Polygon -16777216 true false 240 240 195 210 150 255 165 255 180 240 195 225 225 240 240 240
Polygon -16777216 true false 60 240 105 210 150 255 135 255 120 240 105 225 75 240 60 240

spikeweed_seed_packet
false
7
Rectangle -1 true false 0 0 300 300
Rectangle -14835848 true true 15 15 285 285
Polygon -10899396 true false 30 210 15 195 30 180 45 165 45 150 75 135 105 120 135 120 165 120 195 120 225 135 270 150 285 180 285 225 255 225 285 240 240 240 240 270 180 255 150 255 135 255 105 255 75 270 60 255 15 270 30 240 0 240 30 210
Polygon -13840069 true false 60 165 45 120 90 150 60 165
Polygon -13840069 true false 225 240 285 210 255 240 225 240
Polygon -13840069 true false 255 210 285 165 285 210 255 210
Polygon -13840069 true false 135 135 150 90 165 135 135 135
Polygon -13840069 true false 30 195 0 180 60 180 30 195
Polygon -13840069 true false 270 180 285 135 240 165 270 180
Polygon -13840069 true false 105 150 90 105 135 135 105 150
Polygon -13840069 true false 180 105 165 150 210 120 180 105
Polygon -13840069 true false 210 135 255 120 225 165 210 135
Polygon -16777216 true false 225 210 195 195 165 225 195 240 210 240 225 210
Polygon -16777216 true false 75 210 105 195 135 225 105 240 90 240 75 210
Polygon -2674135 true false 105 195 90 225 105 240 120 225 105 195
Polygon -2674135 true false 195 195 180 225 195 240 210 225 195 195
Polygon -16777216 true false 240 210 195 180 150 225 165 225 180 210 195 195 225 210 240 210
Polygon -16777216 true false 60 210 105 180 150 225 135 225 120 210 105 195 75 210 60 210
Polygon -1 true false 285 285 285 180 195 285 285 285
Polygon -16777216 true false 200 237 209 261 222 234 221 276 203 277 201 293 242 292 239 273 228 277 228 228 222 216 204 235 200 237
Rectangle -16777216 true false 243 218 269 293
Rectangle -16777216 true false 271 218 297 293
Rectangle -1 true false 248 230 265 285
Rectangle -1 true false 275 230 292 285
Line -16777216 false 16 16 75 16
Line -16777216 false 229 15 282 16
Line -16777216 false 159 15 218 15
Line -16777216 false 88 16 147 16
Line -16777216 false 284 24 284 80
Line -16777216 false 16 23 16 79
Line -16777216 false 284 97 284 153
Line -16777216 false 16 227 16 283
Line -16777216 false 16 156 16 212
Line -16777216 false 16 89 16 145
Line -16777216 false 28 284 78 284
Line -16777216 false 88 285 138 285
Line -16777216 false 147 285 197 285
Line -16777216 false 200 279 225 248
Line -16777216 false 229 245 254 214
Line -16777216 false 258 210 283 179

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

sun
false
0
Circle -1184463 true false 75 75 150
Polygon -1184463 true false 285 150 225 120 225 180
Polygon -1184463 true false 150 15 120 75 180 75
Polygon -1184463 true false 150 285 120 225 180 225
Polygon -1184463 true false 15 150 75 120 75 180
Polygon -1184463 true false 75 180 120 225 60 240
Polygon -1184463 true false 75 120 120 75 60 60
Polygon -1184463 true false 180 75 225 120 240 60
Polygon -1184463 true false 225 180 180 225 240 240

sunflower
false
0
Circle -6459832 true false 90 90 120
Circle -16777216 true false 165 120 30
Line -16777216 false 120 180 180 180
Line -16777216 false 180 180 195 165
Line -16777216 false 120 180 105 165
Line -1184463 false 105 105 75 75
Line -1184463 false 225 195 210 210
Line -1184463 false 210 210 195 195
Line -1184463 false 195 195 195 225
Line -1184463 false 195 225 165 210
Line -1184463 false 165 210 135 225
Line -1184463 false 135 225 105 195
Line -1184463 false 105 195 75 210
Line -1184463 false 75 210 90 165
Line -1184463 false 90 165 60 135
Line -1184463 false 60 135 105 105
Circle -16777216 true false 105 120 30
Line -1184463 false 75 75 90 60
Line -1184463 false 90 60 135 90
Line -1184463 false 135 90 165 60
Line -1184463 false 165 60 195 105
Line -1184463 false 195 105 225 90
Line -1184463 false 225 90 225 120
Line -1184463 false 225 120 210 135
Line -1184463 false 210 135 225 165
Line -1184463 false 225 165 225 195
Polygon -14835848 true false 135 225 135 270 150 285 165 300
Polygon -14835848 true false 150 225 165 300 135 225 150 225
Polygon -14835848 true false 135 225
Polygon -14835848 true false 135 270 75 300 165 300 135 270
Polygon -14835848 true false 165 270 210 300 165 300 165 270 150 270 165 300
Polygon -14835848 true false 135 225 165 210 150 225
Polygon -14835848 true false 135 240 105 225 90 240 135 255 165 255 195 240 180 225 150 240 135 240
Polygon -1184463 true false 105 105 75 75 90 60 135 90 105 105
Polygon -1184463 true false 135 90 165 60 195 105 135 90
Polygon -1184463 true false 195 105 225 90 225 120 210 135 195 105
Polygon -1184463 true false 210 135 225 165 225 195 210 210 195 195 210 150
Polygon -1184463 true false 195 195 195 225 165 210 195 195
Polygon -1184463 true false 165 210 135 225 105 195 165 210
Polygon -1184463 true false 105 195 75 210 90 165 105 195
Polygon -1184463 true false 90 165 60 135 105 105 90 165

sunflower_seed_packet
false
7
Rectangle -1 true false 0 0 300 300
Rectangle -14835848 true true 15 16 285 286
Circle -6459832 true false 45 60 120
Circle -16777216 true false 120 90 30
Line -16777216 false 75 150 135 150
Line -16777216 false 135 150 150 135
Line -16777216 false 75 150 60 135
Circle -16777216 true false 60 90 30
Polygon -13840069 true false 105 195 105 240 120 255 135 270
Polygon -13840069 true false 120 195 135 270 105 195 120 195
Polygon -14835848 true true 135 225
Polygon -13840069 true false 105 240 45 270 135 270 105 240
Polygon -13840069 true false 120 240 165 270 120 270 120 240 105 240 120 270
Polygon -13840069 true false 90 195 120 180 120 195
Polygon -13840069 true false 105 210 75 195 60 210 105 225 135 225 165 210 150 195 120 210 105 210
Polygon -1184463 true false 60 75 30 45 45 30 90 60 60 75
Polygon -1184463 true false 90 60 120 30 150 75 90 60
Polygon -1184463 true false 150 75 180 60 180 90 165 105 150 75
Polygon -1184463 true false 165 105 180 135 180 165 165 180 150 165 165 120
Polygon -1184463 true false 150 165 150 195 120 180 150 165
Polygon -1184463 true false 120 180 90 195 60 165 120 180
Polygon -1184463 true false 60 165 30 180 45 135 60 165
Polygon -1184463 true false 45 135 15 105 60 75 45 135
Line -16777216 false 15 285 15 255
Line -16777216 false 15 285 45 285
Line -16777216 false 60 285 90 285
Line -16777216 false 30 15 60 15
Line -16777216 false 105 285 135 285
Line -16777216 false 150 285 180 285
Line -16777216 false 285 150 285 180
Line -16777216 false 285 135 285 105
Line -16777216 false 285 90 285 60
Line -16777216 false 285 15 285 45
Line -16777216 false 255 15 285 15
Line -16777216 false 210 15 240 15
Line -16777216 false 165 15 195 15
Line -16777216 false 120 15 150 15
Line -16777216 false 75 15 105 15
Line -16777216 false 15 105 15 75
Line -16777216 false 15 150 15 120
Line -16777216 false 15 195 15 165
Line -16777216 false 15 240 15 210
Line -16777216 false 15 60 15 30
Polygon -1 true false 181 285 286 285 286 180 181 285
Line -16777216 false 195 270 225 240
Line -16777216 false 240 225 270 195
Polygon -16777216 true false 248 202 203 202 203 247 224 258 224 274 201 289 234 287 248 277 248 247 218 232 218 232 248 232 248 217
Rectangle -16777216 true false 254 202 297 290
Rectangle -1 true false 263 218 290 276

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

torchwood
false
0
Polygon -6459832 true false 75 120 60 135 90 180 105 195 60 135 75 150 75 210 45 240 30 240 15 270 60 270 45 285 60 285 60 300 90 300 105 285 105 285 120 300 150 270 165 285 180 270 195 285 210 300 225 285 270 300 240 270 270 255 300 270 285 240 270 225 240 210 240 180 240 165 270 165 285 135 270 135 300 120 255 105 240 105 225 90 180 90 150 105 120 105 105 105 90 105 45 75 75 120
Polygon -2674135 true false 45 75 75 45 45 45 105 0 150 0 210 0 225 45 255 30 285 45 300 120 255 105 240 105 225 90 180 90 165 105 90 105 45 75
Polygon -955883 true false 75 75 105 30 75 30 135 15 195 15 210 45 225 60 255 45 285 90 255 90 225 75 135 75 120 90 75 75
Polygon -1 true false 90 105 105 75 90 60 120 60 150 45 165 60 195 60 240 60 300 120 255 105 240 105 225 90 180 90 165 105 90 105
Polygon -16777216 true false 90 150 120 120 165 150 195 150 255 120 270 150
Polygon -16777216 true false 105 150 105 165 120 195 150 195 165 150 105 150
Circle -2674135 true false 120 150 30
Polygon -16777216 true false 195 150 180 165 195 195 210 195 225 195 240 165 255 150 210 150
Circle -2674135 true false 195 150 30
Polygon -16777216 true false 240 210 165 210 120 210 90 195 75 225 75 240 90 255 120 270 150 255 225 255 285 240
Rectangle -1 true false 105 210 225 240
Rectangle -1 true false 120 240 240 255
Line -16777216 false 105 225 225 225
Line -16777216 false 120 240 240 240
Line -16777216 false 120 255 240 255
Polygon -2674135 true false 105 105 120 75 105 75 135 60 150 60 165 75 225 75 270 90 255 105 225 90 165 90 150 105 120 105

torchwood_seed_packet
false
7
Rectangle -1 true false -1 0 299 300
Rectangle -14835848 true true 15 15 285 285
Polygon -6459832 true false 45 105 30 120 60 165 75 180 30 120 45 135 45 195 15 225 30 225 15 240 45 240 15 270 30 270 45 270 60 285 75 270 75 270 90 285 120 255 135 270 150 255 165 270 180 285 195 270 225 270 210 255 255 270 255 240 255 225 240 210 210 195 210 165 210 150 240 150 255 120 240 120 270 105 225 90 210 90 195 75 150 75 120 90 90 90 75 90 60 90 15 60 45 105
Polygon -2674135 true false 30 75 60 45 30 45 75 15 120 15 180 15 180 60 225 45 255 45 255 105 225 90 210 90 195 75 150 75 135 90 60 90 30 75
Polygon -955883 true false 60 60 75 30 60 30 105 30 165 30 165 45 195 60 225 60 240 75 225 75 180 75 105 60 75 75 60 60
Polygon -1 true false 75 75 75 60 60 45 90 45 120 45 135 60 165 60 210 60 240 90 210 75 195 60 195 75 150 75 120 75 75 75
Polygon -16777216 true false 45 150 75 120 120 150 150 150 210 120 225 150
Polygon -16777216 true false 60 150 60 165 75 195 105 195 120 150 60 150
Circle -2674135 true false 90 150 30
Polygon -16777216 true false 165 150 150 165 165 195 180 195 195 195 210 165 225 150 180 150
Circle -2674135 true false 180 150 30
Polygon -16777216 true false 210 210 135 210 90 210 60 195 45 225 45 240 60 255 90 270 120 255 195 255 255 240
Rectangle -1 true false 75 210 195 240
Rectangle -1 true false 90 240 210 255
Line -16777216 false 75 225 195 225
Line -16777216 false 90 240 210 240
Line -16777216 false 90 255 210 255
Polygon -2674135 true false 75 75 75 60 60 75 90 60 105 60 120 60 180 60 210 75 195 75 180 75 120 75 105 90 90 75
Polygon -1 true false 285 285 285 165 180 285 285 285
Polygon -16777216 true false 205 225 213 243 221 227 218 271 196 273 196 290 251 293 247 267 233 271 232 211 222 201 206 221
Polygon -16777216 true false 234 205 261 207 267 208 265 291 253 292 255 222 233 220 235 209 237 204
Polygon -16777216 true false 293 205 267 212 268 232 282 238 285 262 269 275 269 292 294 290 296 260 288 227 277 222 278 219 290 217 293 205
Line -16777216 false 14 16 82 15
Line -16777216 false 284 20 285 88
Line -16777216 false 179 15 247 14
Line -16777216 false 97 15 165 14
Line -16777216 false 284 98 285 166
Line -16777216 false 280 170 229 229
Line -16777216 false 227 231 180 285
Line -16777216 false 167 285 106 284
Line -16777216 false 91 285 30 284
Line -16777216 false 15 275 15 222
Line -16777216 false 15 209 15 156
Line -16777216 false 15 142 15 89
Line -16777216 false 15 79 15 26

train
false
0
Rectangle -7500403 true true 30 105 240 150
Polygon -7500403 true true 240 105 270 30 180 30 210 105
Polygon -7500403 true true 195 180 270 180 300 210 195 210
Circle -7500403 true true 0 165 90
Circle -7500403 true true 240 225 30
Circle -7500403 true true 90 165 90
Circle -7500403 true true 195 225 30
Rectangle -7500403 true true 0 30 105 150
Rectangle -16777216 true false 30 60 75 105
Polygon -7500403 true true 195 180 165 150 240 150 240 180
Rectangle -7500403 true true 135 75 165 105
Rectangle -7500403 true true 225 120 255 150
Rectangle -16777216 true false 30 203 150 218

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wall-nut
false
0
Polygon -6459832 true false 179 258 130 251 98 225 83 171 73 106 81 72 104 34 133 19 171 16 192 30 215 72 219 103 224 160 216 200 185 258 181 258
Circle -1 true false 94 57 54
Circle -1 true false 160 62 44
Circle -16777216 true false 116 71 16
Circle -16777216 true false 170 71 14
Line -16777216 false 102 51 136 43
Line -16777216 false 168 41 195 52
Line -16777216 false 139 125 167 125
Line -16777216 false 154 141 166 137

wall-nut_hurt
false
0
Polygon -6459832 true false 105 240 90 195 75 150 90 135 75 105 75 90 75 75 90 60 90 45 90 45 105 15 120 30 135 15 150 15 165 30 180 30 195 30 210 45 210 75 210 75 210 90 210 120 225 135 225 165 225 180 225 195 225 195 210 195 210 210 210 225 195 225 195 240 180 240 180 240 180 255 180 270 135 255 120 240 120 240 105 240
Polygon -6459832 true false 179 258 130 251 98 225 83 171 73 106 81 72 104 34 133 19 171 16 192 30 215 72 219 103 224 160 216 200 185 258 181 258
Circle -1 true false 94 57 54
Circle -1 true false 160 62 44
Circle -16777216 true false 116 71 16
Circle -16777216 true false 170 71 14
Line -16777216 false 102 51 136 43
Line -16777216 false 168 41 195 52
Polygon -7500403 true true 105 240 90 210
Polygon -2674135 true false 120 120 180 120
Polygon -16777216 true false 129 127 186 122 185 139 134 146 129 129
Rectangle -1 true false 137 127 181 142
Line -16777216 false 136 133 141 132
Line -16777216 false 181 134 146 134

wall-nut_seed_packet
false
7
Polygon -1 true false 0 0 300 0 300 300 0 300 0 0
Rectangle -14835848 true true 13 14 283 284
Polygon -6459832 true false 149 273 100 266 68 240 53 186 43 121 51 87 74 49 103 34 141 31 162 45 185 87 189 118 194 175 186 215 155 273 151 273
Circle -1 true false 64 72 54
Circle -1 true false 130 77 44
Circle -16777216 true false 86 86 16
Circle -16777216 true false 140 86 14
Line -16777216 false 72 66 106 58
Line -16777216 false 138 56 165 67
Line -16777216 false 109 140 137 140
Line -16777216 false 124 156 136 152
Polygon -1 true false 285 285 285 150 180 285 285 285
Polygon -16777216 true false 240 195 195 195 195 225 225 240 210 270 195 270 180 285 240 285 255 240 225 225 210 210 240 210 240 195
Polygon -16777216 true false 255 195 285 195 285 285 255 285 255 195
Polygon -1 true false 270 210 270 270
Polygon -1 true false 261 211 276 211 277 274 264 273 263 215
Line -16777216 false 15 15 90 15
Line -16777216 false 195 15 270 15
Line -16777216 false 105 15 180 15
Line -16777216 false 282 23 282 98
Line -16777216 false 282 107 281 155
Line -16777216 false 272 167 227 222
Line -16777216 false 223 228 182 282
Line -16777216 false 105 283 165 282
Line -16777216 false 15 282 76 283
Line -16777216 false 14 269 14 199
Line -16777216 false 13 176 13 106
Line -16777216 false 12 95 12 25

wall-nut_severely_destroyed
false
0
Polygon -6459832 true false 105 240 105 180 75 150 90 135 75 105 75 90 75 75 90 60 90 45 90 45 105 45 120 30 105 45 150 75 165 135 180 30 195 45 210 60 210 75 210 75 210 90 210 120 225 135 225 165 210 195 225 195 225 195 210 195 210 210 210 225 195 225 195 240 180 240 180 240 180 255 150 195 150 210 120 240 120 240 105 240
Polygon -6459832 true false 179 258 130 251 98 225 105 150 73 106 90 90 104 34 135 30 165 30 210 75 215 72 219 103 210 165 195 180 185 258 181 258
Circle -1 true false 94 57 54
Circle -1 true false 160 62 44
Circle -16777216 true false 116 71 16
Circle -16777216 true false 170 71 14
Line -16777216 false 102 51 136 43
Line -16777216 false 168 41 195 52
Polygon -7500403 true true 105 240 90 210
Polygon -2674135 true false 120 120 180 120
Polygon -16777216 true false 120 150 135 120 165 120 180 150 120 150
Rectangle -1 true false 135 120 150 135
Rectangle -1 true false 150 120 165 135
Line -16777216 false 135 120 165 120

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270

yo
true
0
Polygon -2674135 true false 210 135 105 105 180 240 225 120 210 135
@#$#@#$#@
NetLogo 6.1.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
