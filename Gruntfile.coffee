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
			compile:
				src: 'conf.json'
				dest: 'build/conf.json'

	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-copy'

	grunt.registerTask 'default', ['coffee', 'copy']
