# cocos2d-swift-sharingHandler
A sample class that you can easily import into your cocos2d-Swift project to implement the `SLComposeViewController`, an iOS-native popup dialog that people can share your game from. 

## Usage
Import the file into your Source folder in your xCode project. There's no need to import any frameworks, at least with cocos2d implemented already.

You can call methods from this class by using `SharingHandler.sharedInstance.FUNCTION_NAME()`.

As a convenience, and since this is the main reason you'll want to add a sharing feature to your game in the first place, the `defaultURL` constant at the top of the class should be replaced with the URL to your game on the App Store—all sharing messages will automatically be appended with this URL.

Read the instructions below on how to implement the sharing service that you want:

#### Twitter
* The `postToTwitter(stringToPost: String, postWithScreenshot: Bool)` function will display a `SLComposeViewController` on top the current scene for sharing to Twitter. 
* `stringToPost` is the message you want to automatically add to the display when it is called. 
* `postWithScreenshot` determines whether or not you want to append a screenshot of the current scene to the end of your post.

#### Facebook
* The `postToFacebook(postWithScreenshot: Bool)` function will display a `SLComposeViewController` on top the current scene for sharing to Facebook. 
* `postWithScreenshot` determines whether or not you want to append a screenshot of the current scene to the end of your post.
* **Note:** Facebook recently changed their Platform Policy such that "pre-filling" the user message parameter with any content that the user didn't enter themselves is not allowed, which is why there is no `stringToPost` parameter here.
