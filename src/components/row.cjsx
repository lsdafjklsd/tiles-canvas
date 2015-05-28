React          = require 'react'
ImmRenderMixin = require 'react-immutable-render-mixin'
ReactCanvas    = require 'react-canvas'
Group          = ReactCanvas.Group
Tile           = require './tile'

TileRow = React.createClass
  mixins: [ImmRenderMixin]

  handleTileAction: (tile) ->
    @props.actionHandler @props.id, tile

  render: ->
    actionHandler = @handleTileAction
    offsetTop     = @props.topOffset or 0
    offsetLeft    = @props.leftOffset or 0
    top    = (@props.id * 17) + offsetTop
    tiles  = @props.data.map (tile, i) ->
      id   = tile.get('id') or tile.get 'backgroundColor'
      left = (i * 10) + offsetLeft
      <Tile top={top} left={left} key={id} data={tile} actionHandler={actionHandler} />
    return (
      <Group>
        {tiles.toJS()}
      </Group>
    )

module.exports = TileRow