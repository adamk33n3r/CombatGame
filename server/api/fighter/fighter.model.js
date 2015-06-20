'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema,
    ForeignKey = mongoose.Schema.Types.ObjectId;

var FighterSchema = new Schema({
    name: String,
    active: Boolean,
    ai: {
        type: ForeignKey,
        ref: 'AI'
    }
});

module.exports = mongoose.model('Fighter', FighterSchema);
