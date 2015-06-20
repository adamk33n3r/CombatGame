/**
 * Broadcast updates to client when the model changes
 */

'use strict';

var Ai = require('./ai.model');

exports.register = function(socket) {
  Ai.schema.post('save', function (doc) {
    onSave(socket, doc);
  });
  Ai.schema.post('remove', function (doc) {
    onRemove(socket, doc);
  });
}

function onSave(socket, doc, cb) {
  socket.emit('ai:save', doc);
}

function onRemove(socket, doc, cb) {
  socket.emit('ai:remove', doc);
}