var me = state.me;
var o = state.other;

function goToEnemy() {
    var xdist = me.x - o.x;
    var xdir = Math.sign(xdist);
    if (Math.abs(xdist) > 100) {
        if (xdir < 0)
            api.move('right')
        else if (xdir > 0)
            api.move('left')
    }
}

function runAndJump() {
    api.move('right');
    api.jump();
}

function attack() {
    api.attack();
    // api.say("HIYA");
}

goToEnemy();
attack();
