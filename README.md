#  Clima
A beautiful, dark-mode enabled weather app. 

You'll be able to check the weather for the current location based on the GPS data from the iPhone as well as by searching for a city manually. 

## Learned while creating this app

* How to use vector images as image assets.
* Delegate Pattern.
* Swift protocols and extensions.
* Swift guard keyword.
* Swift computed properties.
* Swift closures and completion handlers.
* Using URLSession to network and make HTTP requests.
* Parsing JSON with the native Encodable and Decodable protocols.
* Using Grand Central Dispatch to fetch the main thread.
* Using Core Location to get the current location from the phone GPS.


### Remove multiple consecutive white spaces from a String

```swift

extension String {
    func condenseWhitespace() -> String {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
}

```

### Condition Codes

```swift

switch conditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
}
```

>Created as a companion project to The App Brewery's Complete App Development Bootcamp
