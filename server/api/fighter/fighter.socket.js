/**
 * Broadcast updates to client when the model changes
 */

'use strict';

var Fighter = require('./fighter.model');

exports.register = function(socket) {
  Fighter.schema.post('save', function (doc) {
    onSave(socket, doc);
  });
  Fighter.schema.post('remove', function (doc) {
    onRemove(socket, doc);
  });
}

function onSave(socket, doc, cb) {
  socket.emit('fighter:save', doc);
}

function onRemove(socket, doc, cb) {
  socket.emit('fighter:remove', doc);
}