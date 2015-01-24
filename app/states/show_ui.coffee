app.stateChart.addState 'Show UI',
  substatesAreConcurrent: yes
  parentState: 'Top'

  enterState: ->
    app.layouts.main = require 'layouts/main'
    $("body").html app.layouts.main.render().$el

    {NavbarView} = require 'views/navbar'
    app.views.navbar = new NavbarView
    app.views.navbar.render ->
      app.layouts.main.navbarRegion.show app.views.navbar
    
