console.log("HALP");
require.config({baseUrl: "assets/"});
require(['game/game'], function(game){
  game.start();
});