'use strict';

var _ = require('lodash');
var Fighter = require('./fighter.model');

// Get list of fighters
exports.index = function(req, res) {
  Fighter.find(function (err, fighters) {
    if(err) { return handleError(res, err); }
    return res.status(200).json(fighters);
  });
};

// Get a single fighter
exports.show = function(req, res) {
  Fighter.findById(req.params.id, function (err, fighter) {
    if(err) { return handleError(res, err); }
    if(!fighter) { return res.status(404).send('Not Found'); }
    return res.json(fighter);
  });
};

// Creates a new fighter in the DB.
exports.create = function(req, res) {
  Fighter.create(req.body, function(err, fighter) {
    if(err) { return handleError(res, err); }
    return res.status(201).json(fighter);
  });
};

// Updates an existing fighter in the DB.
exports.update = function(req, res) {
  if(req.body._id) { delete req.body._id; }
  Fighter.findById(req.params.id, function (err, fighter) {
    if (err) { return handleError(res, err); }
    if(!fighter) { return res.status(404).send('Not Found'); }
    var updated = _.merge(fighter, req.body);
    updated.save(function (err) {
      if (err) { return handleError(res, err); }
      return res.status(200).json(fighter);
    });
  });
};

// Deletes a fighter from the DB.
exports.destroy = function(req, res) {
  Fighter.findById(req.params.id, function (err, fighter) {
    if(err) { return handleError(res, err); }
    if(!fighter) { return res.status(404).send('Not Found'); }
    fighter.remove(function(err) {
      if(err) { return handleError(res, err); }
      return res.status(204).send('No Content');
    });
  });
};

function handleError(res, err) {
  return res.status(500).send(err);
}