{Weather} = require 'models/weather'
app.models.weather = new Weather

{PathTrain} = require 'models/path'
app.models.path = new PathTrain

{NewsCollection} = require 'models/news'
app.collections.news = new NewsCollection

{NewsChanges} = require 'models/news'
app.collections.news_feed = new NewsChanges app.collections.news

{TwitterCollection} = require 'models/twitter'
app.collections.twitter = new TwitterCollection

{TwitterChanges} = require 'models/twitter'
app.collections.twitter_feed = new TwitterChanges

app.collections.news.fetch()
app.interval.news_refresh = setInterval =>
  app.collections.news_feed.changes()
, 600000

app.collections.twitter.fetch()
app.interval.twitter_refresh = setInterval =>
  app.collections.twitter_feed.changes()
, 600000

app.models.weather.fetch()
app.interval.weather_refresh = setInterval =>
  app.models.weather.fetch()
  app.views.weather.render()
, 600000

app.models.path.fetch()
app.interval.path_refresh = setInterval =>
  app.models.path.fetch()
  app.views.path.render()
, 1000

