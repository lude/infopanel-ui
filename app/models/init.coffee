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
app.collections.twitter_feed = new TwitterChanges app.collections.twitter

