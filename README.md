# Waller
*Sync your favourite wallpapers from multiple sources*

## Setup
 1. Must have node and npm installed.
 2. Run `npm install` in the directory to download dependencies.
 3. Done!

## Configuration
Edit `conf.json` and change the following parameters to suit your preferences:
 - savePath
 	You must set this to where you want your wallpapers saved to. Please ensure that the directory exists and can be written to by node.
 - likes
 	For each user whose likes you would like to download, put their **username** in this array.
 - time
 	Time in seconds you would like to update. Useful if using [forever](https://github.com/foreverjs/forever) or [pm2](https://github.com/Unitech/pm2). Delete the parameter if you do not want it to repeat.

## Usage
### General
For general usage `node build\main.js` will work just fine after configuration.

### Windows
For Windows users, there are some handy batch files for creating a desktop shortcut, if you'd rather run the script manually than use the scheduling. Just run `shortcut.bat` and a shortcut pointing to `run.bat` will appear on your desktop.
