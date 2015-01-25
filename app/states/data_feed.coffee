app.stateChart.addState 'Data Feed',
  substatesAreConcurrent: yes
  parentState: 'Top'

  enterState: ->
    @sendEvent 'loadWeather'
    @sendEvent 'loadNews'
    @sendEvent 'loadTwitter'

  loadWeather: ->
    app.models.weather.once 'change', =>
      @sendEvent 'weatherLoaded'

    app.models.weather.fetch()

    # setup periodic collection update
    _updateWeather = ->
      app.intervals.weather_refresh = setTimeout =>
        app.models.weather.once 'change', ->
          _updateWeather()
        app.models.weather.fetch()
      , 600000

    _updateWeather()

  loadNews: ->
      app.collections.news.once 'sync', =>
        @sendEvent 'newsLoaded'

      app.collections.news.fetch()

    _updateNews = ->
      app.intervals.news_refresh = setTimeout =>
        app.collections.news_feed.once 'sync', ->
          app.views.news.render()
          _updateNews()
        app.collections.news_feed.changes()
      , 600000

    _updateNews()

  loadTwitter: ->
      app.collections.twitter.once 'sync', =>
        @sendEvent 'twitterLoaded'

      app.collections.twitter.fetch()

    _updateTwitter = ->
      app.intervals.twitter_refresh = setTimeout =>
        app.collections.twitter_feed.once 'sync', ->
          app.views.twitter.render()
          _updateTwitter()
        app.collections.twitter_feed.changes()
      , 600000

    _updateTwitter()

  weatherLoaded: ->
    {WeatherView} = require 'views/weather'
    app.views.weather = new WeatherView
      model: app.models.weather
    app.layouts.main.leftRegion.show app.views.weather
    
  newsLoaded: ->
    {NewsListView} = require 'views/news'
    app.views.news = new NewsListView
      collection: app.collections.news
    app.layouts.main.middleRegion.show app.views.news

  twitterLoaded: ->
    {TwitterView} = require 'views/twitter'
    app.views.twitter = new TwitterView
      collection: app.collections.twitter
    app.layouts.main.rightBottomRegion.show app.views.twitter
