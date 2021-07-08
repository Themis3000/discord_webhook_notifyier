# discord_webhook_notifyier
A simple webhook notifier written for bash. This script is meant to be used in order to allow for easy notifications to be sent from an automated script or service. This script leverages discord embeds in order to make the messages look pretty.

### args refernce

Argument|Function
--------|--------
-s      | adds a timestamp to the bottom of the message
-t      | sets the title of the message
-c      | changes the color theme of the message
-a      | sets the author of the message
-x      | sets the thumbnail for the author of the message
-u      | sets the thumbnail for the message
-d      | sets a description
-f      | sets a field title. A field value must accompany the title. As many field title/body pairs can be made as you'd like
-v      | sets a field value. A field title must accompany the value. As many field title/body pairs can be made as you'd like
**-h**  | **the most important value. This sets your hook link so the message can be sent**
