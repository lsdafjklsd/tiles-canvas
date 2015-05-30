Immutable         = require 'immutable'
pushOntoUndoStack = require('./history').pushOntoUndoStack

# TODO Explain
module.exports = (actionsMap, renderFn, mountNode) ->
  (state, fnName, args...) ->
    context =
      renderFn: renderFn
      mountNode: mountNode
    history  = state.get 'history'
    state    = state.set 'history', pushOntoUndoStack history, state
    newState = actionsMap[fnName].bind(context).apply null, [state].concat args
    renderFn mountNode, newState
