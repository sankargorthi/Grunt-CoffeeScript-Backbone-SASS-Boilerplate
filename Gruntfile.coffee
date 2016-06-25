module.exports = (grunt) ->

    # Handlebars gets loaded via the grunt contrib. This might break, but it works for now.
    hbs =
        'dist/js/handlebars.js': 'node_modules/grunt-contrib-handlebars/node_modules/handlebars/dist/handlebars.js'

    imageTypes = [
        '*.jpg'
        '*.jpeg'
        '*.gif'
        '*.png'
    ]

    grunt.initConfig
        pkg: grunt.file.readJSON 'package.json'

        coffee:
            compile:
                options:
                    bare: true
                expand: true
                cwd: 'src/'
                src: ['**/*.coffee']
                dest: 'dist/js/'
                ext: '.js'

        handlebars:
            compile:
                options:
                    namespace: 'sm.tmpl'
                    node: true
                    simple: true
                    min: true
                    root: 'sm'
                expand: true
                cwd: 'src/views'
                src: ['**/*.html']
                dest: 'dist/js'
                ext: '.tmpl.js'

        sass:
            # Compile bootstrap and responsive first as they need not be watched.
            init:
                options:
                    style: 'expanded'
                files: [
                    'dist/styles/bootstrap.css': 'src/sass/bootstrap/bootstrap.scss'
                    'dist/styles/responsive.css': 'src/sass/bootstrap/responsive.scss'
                ]

            # This will be used when watch triggers a re-compile of sass files
            main:
                options:
                    style: 'expanded'
                files: [
                    'dist/styles/core.css': 'src/sass/core.sass'
                ]

            dist:
                options:
                    style: 'compressed'
                    trace: true
                files: [
                    'dist/styles/core.css': 'src/sass/core.sass'
                    'dist/styles/bootstrap.css': 'src/sass/bootstrap/bootstrap.scss'
                    'dist/styles/responsive.css': 'src/sass/bootstrap/responsive.scss'
                ]

        copy:
            main:
                files: [
                    expand: true
                    cwd: 'lib/dev'
                    src: ['*.js']
                    dest: 'dist/js'
                    filter: 'isFile'
                ,
                    expand:true
                    cwd: 'img'
                    src: imageTypes
                    dest: 'dist/img'
                    filter: 'isFile'
                ,
                    expand: true
                    src: ['*.html']
                    dest: 'dist'
                    filter: 'isFile'
                ,
                    hbs
                ]

            dist:
                files: [
                    expand: true
                    cwd: 'lib'
                    src: ['*.js']
                    dest: 'dist/js'
                    filter: 'isFile'
                ,
                    expand:true
                    cwd: 'img'
                    src: imageTypes
                    dest: 'dist/img'
                    filter: 'isFile'
                ,
                    expand: true
                    src: ['*.html']
                    dest: 'dist'
                    filter: 'isFile'
                ,
                    hbs
                ]

        watch:
            js:
                files: ['src/**/*.coffee']
                tasks: ['coffee']
            tmpl:
                files: ['src/**/*.html']
                tasks: ['handlebars']
            style:
                files: [
                    '**/*.sass'
                    '**/*.scss'
                ]
                tasks: ['sass:main']

        clean: ['dist']


    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-handlebars'
    grunt.loadNpmTasks 'grunt-contrib-sass'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-clean'

    grunt.registerTask 'default', [
        'copy:main'
        'coffee'
        'handlebars'
        'sass:init'
        'sass:main'
    ]

    grunt.registerTask 'prod', [
        'clean'
        'copy:dist'
        'coffee'
        'handlebars'
        'sass:dist'
    ]

    # grunt.registerTask 'lint', [
    #
    # ]

    return
