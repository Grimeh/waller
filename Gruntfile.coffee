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
			html:
				expand: true
				flatten: true
				src: 'html/*'
				dest: 'build/'
			fonts:
				files: [{ expand: true, src: ['fonts/*'], dest: 'build/', filter: 'isFile' }]
		sass:
			compile:
				files:
					'build/_common.css': 'sass/_common.scss'
					'build/style_index.css': 'sass/style_index.scss'
					'build/style_progress.css': 'sass/style_progress.scss'
		watch:
			files: ['coffee/*.coffee']
			tasks: ['default']

	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-copy'
	grunt.loadNpmTasks 'grunt-contrib-sass'
	grunt.loadNpmTasks 'grunt-contrib-watch'

	grunt.registerTask 'default', ['coffee', 'sass', 'copy']
