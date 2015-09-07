stock = require './chinese_stock'
properties = require './properties'
{CompositeDisposable} = require 'atom'
subscriptions = new CompositeDisposable


class FinanceCNView extends HTMLDivElement
  initialize: (@statusBar) ->

    subscriptions.add atom.commands.add 'atom-workspace', 'finance-cn:toggle': =>
      @toggle()
    subscriptions.add atom.commands.add 'atom-workspace', 'finance-cn:refresh': =>
      @build()

    @initElements()

    @observeDisplay = atom.config.observe 'finance-cn.display', (newValue, previous) =>
      @build()
    @observeFormat = atom.config.observe 'finance-cn.format', (newValue, previous) =>
      setTimeout (->
        format = atom.config.get('finance-cn.format')
        exps = format.match(/{[^}]*}/g)
        if exps
          for exp in exps
            exp = exp.replace /[{}]/g, ''
            if exp not in properties
              atom.notifications.addWarning exp + ' is a supported quote property provided by Money 163.',
                dismissable: false
                detail: 'Please refer to the documantation on https://github.com/7kfpun/atom-finance-cn.'
      ), 2000
      @build()
    @observeRefresh = atom.config.observe 'finance-cn.refresh', (newValue, previous) =>
      @build()
    @observeSeparator = atom.config.observe 'finance-cn.separator', (newValue, previous) =>
      @build()
    @observeScroll = atom.config.observe 'finance-cn.scroll', (newValue, previous) =>
      @updateElements()
      @build()
    @observeScrollDelay = atom.config.observe 'finance-cn.scrollDelay', (newValue, previous) =>
      @updateElements()
      @build()
    @observeWatchlist = atom.config.observe 'finance-cn.watchlist', (newValue, previous) =>
      @build()

  initElements: ->
    @classList.add('finance-cn-status', 'inline-block')
    @setAttribute 'id', 'finance-cn-status'
    @icon = document.createElement 'span'
    @icon.classList.add('icon', 'icon-graph', 'inline-block')
    @appendChild(@icon)

    scroll = atom.config.get('finance-cn.scroll')
    scrollDelay = atom.config.get('finance-cn.scrollDelay')
    if scroll != 'fixed'
      @finance = document.createElement 'marquee'
      @finance.setAttribute 'direction', scroll
      @finance.setAttribute 'scrollDelay', scrollDelay
    else
      @finance = document.createElement 'span'
    @appendChild(@finance)

    @price = document.createElement 'span'

  updateElements: ->
    scroll = atom.config.get('finance-cn.scroll')
    scrollDelay = atom.config.get('finance-cn.scrollDelay')
    if scroll == 'fixed'
      if @finance.nodeName != 'SPAN'
        @removeChild(@finance)
        @finance = document.createElement 'span'
        @finance.appendChild @price
        @appendChild(@finance)
    else
      @removeChild(@finance)
      @finance = document.createElement 'marquee'
      @finance.appendChild @price
      @appendChild(@finance)

      @finance.setAttribute 'direction', scroll
      @finance.setAttribute 'scrollDelay', scrollDelay

  attach: ->
    @build()
    # subscriptions.add atom.packages.once('activated', @attach)
    seconds = atom.config.get 'finance-cn.refresh'

    if seconds > 0
      setInterval (=>
        @build()
      ), seconds * 1000

  toggle: ->
    if @hasParent() then @detach() else @attach()

  hasParent: ->
    has = false
    bar = document.getElementsByTagName 'finance-cn-status'
    if bar != null
      if bar.item() != null
        has = true
    return has

  detach: ->
    bar = document.getElementsByTagName 'finance-cn-status'
    if bar != null
      if bar.item() != null
        el = bar[0]
        parent = el.parentNode
        if parent != null
          parent.removeChild el

  destroy: ->
    @tile?.destroy()
    @detach()

  build: =>
    watchlist = atom.config.get('finance-cn.watchlist')
    currency = atom.config.get('finance-cn.currency')
    separator = atom.config.get('finance-cn.separator')
    watchlist = watchlist.replace /[\s@#$%&*()\\，。]/g, ''
    quotes = watchlist.split ','

    stock watchlist, (coin) =>
      if Object.keys(coin).length == 0
        return

      watchlist = atom.config.get('finance-cn.watchlist')

      results = []
      for quote in quotes
        format = atom.config.get('finance-cn.format')  # '{name}({type}): {price} ({percent})'
        exps = format.match(/{[^}]*}/g)
        if exps
          for exp in exps
            exp = exp.replace /[{}]/g, ''
            if quote of coin
              format = format.replace exp, coin[quote][exp]
              console.log exp, coin[quote][exp]
        format = format.replace /[{}]/g, ''
        results.push(format)

      @price.innerHTML = results.join(separator)
      # @finance.appendChild @price

      if atom.config.get('finance-cn.display') == 'left'
        @tile = @statusBar.addLeftTile(priority: 110, item: this)
      else
        @tile = @statusBar.addRightTile(priority: 110, item: this)

      return

module.exports = document.registerElement('finance-cn-status', prototype: FinanceCNView.prototype)
