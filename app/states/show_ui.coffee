app.stateChart.addState 'Show UI',
  substatesAreConcurrent: yes
  parentState: 'Top'

  enterState: ->
    app.layouts.main = require 'layouts/main'
    $("body").html app.layouts.main.render().$el

    {NavbarLayout} = require 'layouts/navbar'
    app.layouts.navbar = new NavbarLayout
    app.layouts.main.navbarRegion.show app.layouts.navbar
    
