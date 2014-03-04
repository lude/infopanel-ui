class exports.NewsItemView extends Backbone.Marionette.ItemView
  tagName: 'tr'
  template: require './templates/news/item'
  modelEvents:
    'change:user': 'userChanged'
  userChanged: ->
    console.log 'user changed'
  onRender: ->
    # custom onRender function here
  onClose: ->
    # custom plugin cleanup here


class exports.NewsView extends Backbone.Marionette.CompositeView
  itemView: exports.NewsItemView
  itemViewContainer: 'tbody'
  template: require './templates/news/list'
  onRender: ->
    # initialize pagination plugin


