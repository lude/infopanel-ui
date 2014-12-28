class MainLayout extends Marionette.LayoutView
  template: require './templates/main'

  regions:
    navbarRegion: '#navbar'
    leftRegion: '#left'
    middleRegion: '#middle'
    rightTopRegion: '#righttop'
    rightBottomRegion: '#rightbottom'

module.exports = new MainLayout()
