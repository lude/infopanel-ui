exports.config =
  # See http://brunch.readthedocs.org/en/latest/config.html for documentation.
  paths:
    public: 'public'
  files:
    javascripts:
      defaultExtension: 'coffee'
      joinTo:
        'javascripts/app.js': /^app/
        'javascripts/vendor.js': /^bower_components/
        'test/javascripts/test.js': /^test(\/|\\)(?!vendor)/
        'test/javascripts/test-vendor.js': /^test(\/|\\)(?=vendor)/
      order:
        before: [
          'bower_components/jquery/dist/jquery.js',
          'bower_components/underscore/underscore.js',
          'bower_components/backbone/backbone.js'
        ]
    stylesheets:
      defaultExtension: 'sass'
      joinTo:
        'stylesheets/vendor.css': /^bower_components/
        'stylesheets/app.css': /^app/
      order:
        before: ['vendor/styles/bootstrap.scss']
    templates:
      defaultExtension: 'jade'
      joinTo: 'javascripts/app.js'
  framework: 'backbone'

