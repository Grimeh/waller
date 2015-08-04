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

	grunt.loadNpmTasks 'grunt-contrib-coffee'

	grunt.registerTask 'default', ['coffee']
