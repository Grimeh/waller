module.exports = (grunt) ->
	grunt.initConfig
		coffee:
			compile:
				expand: true
				flatten: false
				cwd: 'coffee'
				src: ['**/*.coffee']
				dest: 'build/'
				ext: '.js'
		copy:
			json:
				src: 'conf.json'
				dest: 'build/conf.json'
			sass:
				src: 'html/index.html'
				dest: 'build/index.html'
		sass:
			compile:
				files:
					'build/style.css': 'sass/style.scss'
		watch:
			files: ['coffee/*.coffee']
			tasks: ['default']

	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-copy'
	grunt.loadNpmTasks 'grunt-contrib-sass'
	grunt.loadNpmTasks 'grunt-contrib-watch'

	grunt.registerTask 'default', ['coffee', 'sass', 'copy']
