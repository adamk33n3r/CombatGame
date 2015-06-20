var me = state.me;
var o = state.other;

function goToEnemy() {
    var xdist = me.x - o.x;
    var xdir = Math.sign(xdist);
    if (xdir < 0)
        api.move('right')
    else if (xdir > 0)
        api.move('left')
    else
        api.yell()
}

function runAndJump() {
    api.move('right');
    api.jump();
}

runAndJump();
