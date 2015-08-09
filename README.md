# [Waller](https://github.com/Grimeh/Waller)
*Sync your favourite wallpapers from multiple sources*

## Setup
 1. Must have node and npm installed.
 2. Run `npm install --production` in the directory to download dependencies.
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
As requested, Windows users have some handy batch files for creating a desktop shortcut, if you'd rather run the script manually than use the scheduling. Just run `shortcut.bat` and a shortcut called *Waller* pointing to `run.bat` will appear on your desktop.

## License
The MIT License (MIT)

Copyright (c) 2015 Brandon Grimshaw

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
