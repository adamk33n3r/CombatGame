'use strict';

var _ = require('lodash');
var Ai = require('./ai.model');

// Get list of ais
exports.index = function(req, res) {
  Ai.find(function (err, ais) {
    if(err) { return handleError(res, err); }
    return res.status(200).json(ais);
  });
};

// Get a single ai
exports.show = function(req, res) {
  Ai.findById(req.params.id, function (err, ai) {
    if(err) { return handleError(res, err); }
    if(!ai) { return res.status(404).send('Not Found'); }
    return res.json(ai);
  });
};

// Creates a new ai in the DB.
exports.create = function(req, res) {
  Ai.create(req.body, function(err, ai) {
    if(err) { return handleError(res, err); }
    return res.status(201).json(ai);
  });
};

// Updates an existing ai in the DB.
exports.update = function(req, res) {
  if(req.body._id) { delete req.body._id; }
  Ai.findById(req.params.id, function (err, ai) {
    if (err) { return handleError(res, err); }
    if(!ai) { return res.status(404).send('Not Found'); }
    var updated = _.merge(ai, req.body);
    updated.save(function (err) {
      if (err) { return handleError(res, err); }
      return res.status(200).json(ai);
    });
  });
};

// Deletes a ai from the DB.
exports.destroy = function(req, res) {
  Ai.findById(req.params.id, function (err, ai) {
    if(err) { return handleError(res, err); }
    if(!ai) { return res.status(404).send('Not Found'); }
    ai.remove(function(err) {
      if(err) { return handleError(res, err); }
      return res.status(204).send('No Content');
    });
  });
};

function handleError(res, err) {
  return res.status(500).send(err);
}