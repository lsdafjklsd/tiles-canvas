React          = require 'react'
ImmRenderMixin = require 'react-immutable-render-mixin'
TileHalf       = require './half'
utils          = require '../utils'
ReactCanvas    = require 'react-canvas'
Surface        = ReactCanvas.Surface

{ partition } = utils

TileGrid = React.createClass
  mixins: [ImmRenderMixin]

  getImageURL: ->
    @refs.grid.getDOMNode().toDataURL()

  render: ->
    { data, width, height, actionHandler } = @props
    grid        = data.get 'grid'
    halfLength  = Math.round grid.count() / 2
    chunkedGrid = partition halfLength, grid

    tileHalves = chunkedGrid.map (half, i) ->
      offsetLength = chunkedGrid.get(i - 1).count() unless i is 0
      <TileHalf data={half} topOffset={offsetLength} actionHandler={actionHandler} key={i} id={i} />

    return (
      <Surface style={backgroundColor: 'white'}
               ref="grid"
               width={width}
               height={height}>{tileHalves.toJS()}</Surface>
    )

module.exports = TileGrid
