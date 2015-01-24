class NavbarLayout extends Marionette.LayoutView
  template: require './templates/navbar'

  regions:
    greetingRegion: '#greeting'
    clockRegion: '#clock'

module.exports = new NavbarLayout()
