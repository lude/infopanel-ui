class exports.News extends Backbone.Model
  defaults:
    id: null
    author: null
    url: null
    created: 0
    created_ago: null
    subreddit: null
    score: 0
    title: null

  initialize: ->
    #convert from ut to momentjs
    @parseCreated()

    @on 'change:score', @parseScore
    @parseScore

  parseCreated: ->
    if @get('created')
      # something is fucky with this, moment doesn't understand UTC or something
      ds = moment.utc(@get('created'), 'X')
      @set 'created_ago', ds.local().fromNow()

  parseScore: ->
    # just a filler, maybe we want to convert scores to HR?
    if @get('score')
      scoreObj = 'filler'

  parse: (response) ->

    model = response
    {NewsCollection} = require 'models/news'
    collection = new NewsCollection
    collection.reset(response.items)
    model.items = collection
    return model

class exports.NewsCollection extends Backbone.Collection

  url: app.config.apiPrefix + 'redditnews'

  model : exports.News

  parse: (response) ->
    if response.length == 0
      return []
    else
      return response

class exports.NewsChanges extends Backbone.Collection

  model : exports.News

  url: app.config.apiPrefix + 'redditnews'

  initialize: (collection) =>

    @collection = collection
    @on 'change reset add remove', @processChanges

  changes: =>
    @fetch
      data:
        since: 0

  parse: (response) ->
    if response.length == 0
      return []
    else
      return response

  processChanges: =>
    console.log('processChanges called')
    @each @processChange
    @collection.each @removeStale

  processChange: (news) =>

    existing = @collection.get news.id

    if existing
      existing.set news.attributes
    else
      @collection.add news

  removeStale: (news) =>
    current = @get news.id

    if not current
      console.log "removing news " + news.id
      @collection.remove news
