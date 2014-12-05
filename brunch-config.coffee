exports.config =
  files:
    javascripts:
      joinTo:
        'js/app.js' : /^app/
        'js/vendor.js' : /^(vendor|bower_components)/

    stylesheets:
      joinTo:
        'css/app.css' : /^(app|vendor|bower_components)/

  plugins:
    jadePages:
      destination: (path) ->
        path.replace /^app[\/\\](.*)\.jade$/, "$1.html"
      jade:
        doctype: "html"
      htmlmin: false
