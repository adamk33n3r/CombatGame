'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var MatchSchema = new Schema({
  name: String,
  info: String,
  active: Boolean
});

module.exports = mongoose.model('Match', MatchSchema);