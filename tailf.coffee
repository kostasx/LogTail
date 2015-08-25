notifier = require "node-notifier"
colors   = require "colors"
path     = require "path"

Tail = require("tail").Tail
tail = new Tail "/Applications/MAMP/logs/php_error.log"

tail.on "line", (data)->

    line = {}
    output = data.match(/(\[.*\])([A-Za-z0-9 ]+):(.*)/)
    line.date  = output[1].trim()
    line.type  = output[2].trim()
    line.error = output[3].trim()

    line.error = line.error.replace( /on line ([0-9]+)/, "on line $1".yellow )

    console.log line.date.gray, line.type.red  + " >>", line.error, "\n"

    notify line


notify = (line)->

    notifier.notify {
            title    : line.type
            subtitle : line.date
            message  : line.error
            sound    : "Submarine"                           # Mac: Basso, Blow, Bottle, Frog, Funk, Glass, Hero, Morse, Ping, Pop, Purr, Sosumi, Submarine, Tink
            wait     : true                                  # wait with callback until user action is taken on notification
            # open   : void 0                              # URL to open on click
            # icon   : path.join(__dirname, 'coulson.jpg') # absolute path (not balloons)
        }, (err,res)->
            # console.log "Notification Response"
            return

    notifier.on 'click', (notifierObject, options)->
        # Happens if `wait: true` and user clicks notification
        # Open StackOverflow search page based on error message # <-- TODO
        return

    notifier.on 'timeout', (notifierObject, options)-> 
        # Happens if `wait: true` and notification closes
        return