class exports.WeatherView extends Backbone.Marionette.ItemView
  onBeforeRender:
    app.models.weather.fetch()
  model: app.models.weather
  template: require './templates/weather'
  onRender:
    console.log @model
