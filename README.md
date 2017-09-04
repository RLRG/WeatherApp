# WeatherApp

This app was created to work on Clean Architecture & RxSwift.

## Objective and audience of the app
 The main functionality of the app is to display the current weather in the GPS location or in the city entered by the user.

## Build and install
### Requirements
* Xcode 8.3.3
* iOS 10.3 SDK
* Swift 3.1.
### Getting the code
In order to build, run and access the app, the first thing you have to do is to clone my repository:
```
git clone https://github.com/RLRG/WeatherApp.git
```
It is important to remark that I have used CocoaPods as the dependency manager of the project so that you will need to execute a ‘pod install’ command in the same path where the PodFile is located to download all the third-party frameworks:
```
pod install
```
### Running the app
Open `WeatherApp.xcworkspace` with XCode 8.3.3.

Before running it, note that there are two targets:
* WeatherAppLAB: When you run this target, in the search screen, you will see an UIButton at the bottom (DEBUG) in order to open an in-app debugger.
* WeatherApp: This target would be a simulation of the app if it was going to be submitted to the App Store.

## Resources
This paragraph includes all the resources used to create this app project, including frameworks, APIs and other information resources such as tutorials, documentation and so on.
### Third-party frameworks
| Framework | Description |
| --- | --- |
| [CocoaPods](https://github.com/CocoaPods/CocoaPods) | The Cocoa Dependency Manager. |
| [FLEX Debugger](https://github.com/Flipboard/FLEX) | An in-app debugger. |
| [SwiftLint](https://github.com/realm/SwiftLint) | A tool to enforce Swift style and conventions. |
| [Alamofire](https://github.com/Alamofire/Alamofire) | Elegant HTTP Networking in Swift. |
| [Travis CI](https://travis-ci.org/) | Continuous Integration used to build the project automatically. |
| [Realm](https://github.com/realm/realm-cocoa) | Mobile database used to persist data of the app. |
| Other | Other frameworks related to the ones already mentioned such as: RxAlamofire, ObjectMapper, AlamofireObjectMapper, RxRealm, QueryKit (see PodFile of the project) |
### APIs
| Framework | Description |
| --- | --- |
| [OpenWeather](https://openweathermap.org) | It is used to retrieve the information about the weather. |
### Other information resources
| Resource | Description |
| --- | --- |
| App icon and buttons | Icon made by [Freepik](http://www.freepik.com/) from www.flaticon.com and all the sizes of the icon were generated with https://makeappicon.com/ |

## Future work & Improvements
Among other things:
- Support of multi-language.
- About button which opens a new screen where some information is displayed: version of the app, attributions to mention all the frameworks used, ...
- Improve the results screen.
- Include an animation when the app is launching.
- Extend the model of the app with more useful information for the user.
- ...


## Feedback
As I am continuously learning, I would appreciate if you take a look at my code and you have recommendations to improve it in different ways. You can contact me at rodri.lopezromero@gmail.com to do so :smiley:

## License
The contents of this repository are covered under the [Apache License 2.0](https://choosealicense.com/licenses/apache-2.0/).
