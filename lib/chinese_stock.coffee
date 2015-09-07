'use strict'
http = require('http')

chineseStock = (codes, cb) ->
  codes = codes.replace /[\s@#$%&*()\\，。]/g, ''

  get = (r) ->
    bd = ''
    r.on('data', (d) ->
      bd += d
      return
    ).on 'end', ->
      bd = bd.replace '_ntes_quote_callback(', ''
      bd = bd.replace ');', ''
      b = JSON.parse(bd)
      cb b
      return
    return

  http.get {
    host: 'api.money.126.net',
    path: '/data/feed/' + codes,
  }, get

  console.log 'Stock call'

module.exports = chineseStock
