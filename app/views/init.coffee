{TwitterView} = require 'views/twitter'
app.views.twitter = new TwitterView(collection:app.collections.twitter)

{NewsView} = require 'views/news'
app.views.news = new NewsView(collection:app.collections.news)

{PathView} = require 'views/path'
app.views.path = new PathView(model:app.models.path)

{WeatherView} = require 'views/weather'
app.views.weather = new WeatherView(model:app.models.weather)

{NavbarView} = require 'views/navbar'
app.views.navbar = new NavbarView
