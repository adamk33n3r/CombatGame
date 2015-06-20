var me = state.me;
var o = state.other;
var xdist = me.x - o.x;
var xdir = Math.sign(xdist);

if (state.dir == undefined) {
    if (Math.abs(xdist) < 150) { // Oh he's close
        if (xdir < 0) { // To my right
            state.dir = 'right';
        } else {
            state.dir = 'left';
        }
    }
}


function goToEnemy() {
    if (Math.abs(xdist) > 100) {
        if (xdir < 0)
            api.move('right');
        else if (xdir > 0)
            api.move('left');
    }
}

function runAndJump() {
    api.move('right');
    api.jump();
}

function attack() {
    api.attack();
    api.say("HIYA");
}

function runAway() {
    if (1200 - me.x < 10)
        state.dir = 'left'
    else if (me.x < 10)
        state.dir = 'right'

    api.move(state.dir);
}

runAway();

// goToEnemy();
// attack();
