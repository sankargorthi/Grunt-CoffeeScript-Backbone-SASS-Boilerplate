# Load jQuery and Underscore first and then load Backbone as Backbone depends on jQuery
require ['jquery-1.9.1', 'underscore', 'handlebars'], ->
    # Load handlebars before loading any compiled templates.
    # FIXME: There is a bug in the handlebars library - it's supposed to load
    # dependencies in an array, but the call in the compiled template is a string
    require ['backbone', 'bootstrap', 'test', 'app.tmpl'], ->
        ###*
         * app will be the container for all collections and top level views
         *
        ###
        app = window.app = _.extend window.app || {},
            views: {},
            store: {}

        class App extends Backbone.View
            template: sm.tmpl['src/views/app.html']

            el: $ 'body'

            events:
                'click a': 'handleBtn'

            initialize: ->
                # _.bindAll @
                @render()

            render: ->
                @$el.append @template {}
                @$el.addClass 'grunt-coffee-boilerplate'

            handleBtn: (e) ->
                console.log 'clicked', new Date
                return false

        sm.views.app = new App 

        return
    return
