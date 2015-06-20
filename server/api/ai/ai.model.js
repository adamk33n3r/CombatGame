'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var AISchema = new Schema({
    name: String,
    code: String
});

module.exports = mongoose.model('AI', AISchema);
