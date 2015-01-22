class Application extends Backbone.Marionette.Application

 initialize: ->

    apiPrefix = 'http://localhost:6543/'

    # enable to view verbose console output
    window.DEBUG_MODE = yes

    # global application configuration and reference objects
    @addInitializer (options) =>

      @config = require 'config'

      @views = {}
      @models = {}
      @collections = {}

      @intervals = @interval = {}

    @addInitializer (options) =>

      require 'models/init'
      require 'views/init'

    @addInitializer (options) =>
      #initialize state chart
      @stateChart = Stativus.createStatechart()
      require 'states/init'

    @startModule = (moduleName) =>

      currentApp = @module(moduleName)
      return yes if @currentApp is currentApp

      if @currentApp
        @currentApp.stop()

      @currentApp = currentApp
      currentApp.start()

    @commands.setHandler 'start:module', @startModule, @

    @on 'start', (options) =>

      #track app launch time
      @startedAt = new Date().getTime()
      #fire initial state
      @stateChart.initStates 'Top'
      #start tracking history
      Backbone.history.start()
      
      @mainLayout = require 'layouts/main'
      $("body").html(@mainLayout.render().$el)

      @mainLayout.navbarRegion.show(@views.navbar)
      @mainLayout.leftRegion.show(@views.weather)
      @mainLayout.middleRegion.show(@views.news)
      @mainLayout.rightTopRegion.show(@views.path)
      @mainLayout.rightBottomRegion.show(@views.twitter)

      Backbone.history.start()

module.exports = new Application()
