gen = (length) ->
  blog =
    date: new Date
    length: length
    players: []
  for i in [-1..1] by 2
    log = []
    arm = 0
    armDir = 1
    lleg = 0
    rleg = 0
    for ts in [0...length]
      log.push
        ts: ts
        info:
          health: 100-ts#-Math.random()*10
          pos:
            x: 100-.5+ts*5+(i+1)*150
            y: (if i<0 then 750 else 100)-.5+ts*5*i
          arm: arm
          legs:
            left: lleg
            right: rleg
        say: ""
      if arm == 30
        armDir = -1
      else if arm == 0
        armDir = 1
      arm += 2 * armDir
      lleg += .05 * armDir
      rleg += -.05 * armDir
    blog.players.push
      name: "p#{i}"
      color: Math.round Math.random()*0xFFFFFF
      log: log
  return JSON.stringify(blog, null, 2)

console.log gen 100
