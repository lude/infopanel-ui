class exports.Twitter extends Backbone.Model
  defaults:
    id: 0
    user: null
    userpic: null
    text: null
    created_at: null
    created_ago: null

  initialize: ->
    #convert from twitter time to momentjs
    @parseCreatedAt()
    @parseURLS()

  parseCreatedAt: ->
    if @get('created_at')
      @set 'created_ago', moment(@get 'created_at', "ddd MMM DD HH:mm:ss Z YYYY").fromNow()

  urlify: (text) ->
    urlRegex = /(https?:\/\/[^\s]+)/g
    text.replace urlRegex, (url) ->
      "<a href=\"" + url + "\">" + url + "</a>"

  parseURLS: ->
    if @get('text')
      @set 'text', @urlify(@get('text'))

  parse: (response) ->
    model = response
    {TwitterCollection} = require 'models/twitter'
    collection = new TwitterCollection
    collection.reset(response.items)
    model.items = collection
    return model

class exports.TwitterCollection extends Backbone.Collection

  url: app.config.apiPrefix + 'twitter'

  model : exports.Twitter

  parse: (response) ->
    if response.length == 0
      return []
    else
      return response


class exports.TwitterChanges extends Backbone.Collection

  model : exports.Twitter

  url: app.config.apiPrefix + 'twitter'

  initialize: (collection) =>

    @collection = collection
    @on 'change reset add remove', @processChanges

  changes: =>
    @fetch
      error: (collection, response) =>
        if response.status == 401
          @trigger 'error:unauthorized'

  processChanges: =>
    @each @processChange
    @collection.each @removeStale

  processChange: (twitter) =>
    existing = @collection.get twitter.id

    if existing
      existing.set twitter.attributes
    else
      @collection.add twitter

  removeStale: (twitter) =>
    current = @get twitter.id

    if not current
      console.log "removing twitter " + twitter.id
      @collection.remove twitter
