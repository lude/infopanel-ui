app.stateChart.addState 'Top',
  initialSubstate: 'Top > Initialize'

app.stateChart.addState 'Top > Initialize',
  enterState: ->
    {NavbarView} = require 'views/navbar'
    app.views.navbar = new NavbarView
      model: app.models.navbar
    app.layouts.main = require 'layouts/main'
    $("body").html app.layouts.main.render().$el
    app.layouts.main.navRegion.show app.views.navbar

