financeCn = null

module.exports =
  config:
    display:
      type: 'string'
      default: 'left'
      enum: ['left', 'right']
    format:
      description: 'Please refer to the documantation on https://github.com/7kfpun/atom-finance-cn. HTML elements are supported.'
      type: 'string'
      default: '<span style="color:white">{name}</span> ({type}): {price} ({updown})'
    refresh:
      description: 'In seconds, if zero seconds only refreshes when open/close windows or trigger refresh'
      type: 'integer'
      default: 30
      minimum: 10
    scroll:
      type: 'string'
      default: 'left'
      enum: ['left', 'right', 'fixed']
    scrollDelay:
      description: 'This specifies the number of milliseconds between each successive draw of the marquee text.'
      type: 'integer'
      default: 85
      minimum: 60
      maximum: 1000
    separator:
      type: 'string'
      default: ' | '
    watchlist:
      type: 'string'
      default: '0000001,1399001,1399300'

  activate: ->
    console.log 'finance-cn', 'activate'

  deactivate: ->
    financeCn?.destroy()
    financeCn = null

  consumeStatusBar: (statusBar) ->
    console.log 'consumeStatusBar'
    FinanceCNView = require './finance-cn-view'
    financeCn = new FinanceCNView()
    financeCn.initialize(statusBar)
    financeCn.attach()
