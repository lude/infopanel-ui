class Application extends Backbone.Marionette.Application

 initialize: ->

    apiPrefix = '/'

    # enable to view verbose console output
    window.DEBUG_MODE = yes

    # global application configuration and reference objects
    @addInitializer (options) =>

      @config = require 'config'

      @views = {}
      @models = {}
      @collections = {}
      @layouts = {}

      @intervals = @interval = {}

    @addInitializer (options) =>

      require 'models/init'

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
      
module.exports = new Application()
