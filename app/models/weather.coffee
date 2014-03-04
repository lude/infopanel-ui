class exports.Weather extends Backbone.Model

  url: app.config.apiPrefix + 'forecastio'

  defaults:
    currently: null
    minutely: null
    hourly: null
    daily: null
    weekly: null
