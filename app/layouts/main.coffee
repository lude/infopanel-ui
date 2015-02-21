class MainLayout extends Marionette.LayoutView
  template: require './templates/main'

  regions:
    navbarRegion: '#navbar'
    leftRegion: '#left'
    rightTopRegion: '#righttop'
    rightBottomRegion: '#rightbottom'

module.exports = new MainLayout()
