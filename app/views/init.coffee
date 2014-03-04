{TwitterView} = require 'views/twitter'
app.views.twitter = new TwitterView(collection:app.collections.twitter)

{NewsView} = require 'views/news'
app.views.news = new NewsView(collection:app.collections.news)

{PathView} = require 'views/path'
app.views.path = new PathView

{WeatherView} = require 'views/weather'
app.views.weather = new WeatherView

{NavbarView} = require 'views/navbar'
app.views.navbar = new NavbarView
