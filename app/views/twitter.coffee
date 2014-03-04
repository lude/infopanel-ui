class exports.TwitterItemView extends Backbone.Marionette.ItemView
  tagName: 'tr'
  template: require './templates/twitter/item'
  modelEvents:
    'change:user': 'userChanged'
  userChanged: ->
    console.log 'user changed'
  onRender: ->
    # custom onRender function here
  onClose: ->
    # custom plugin cleanup here


class exports.TwitterView extends Backbone.Marionette.CompositeView
  itemView: exports.TwitterItemView
  itemViewContainer: 'tbody'
  template: require './templates/twitter/list'
  onRender: ->
    # initialize pagination plugin


