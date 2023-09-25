# iOS-Common-Libraries
![Nordic](https://raw.githubusercontent.com/NordicPlayground/IOS-Common-Libraries/main/Logo_RGB_Horizontal_Transparent.png)

This is a Swift Package containing Swift code and Utilities/Assets, such as Colors, used by Nordic's iOS/Mac apps.

## Contents

### Utilities

- `Cache`: Need to use `NSCache` with a pure-Swift `struct`? This is what this is for. Also, it's just John Sundell's work in a library that we use.
- `BitField`: Alternative to an `enum` `Set` that allows us to store everything in a single CPU Register, both in memory and as a `Codable`. Heavily used by [nRF Connect for Mobile](https://apps.apple.com/es/app/nrf-connect-for-mobile/id1054362403).

### Extensions

- `Data`: There are helper functions here to handle bytes within a `Data` blob. Again, this is code used by [nRF Connect for Mobile](https://apps.apple.com/es/app/nrf-connect-for-mobile/id1054362403) to read individual bytes from advertised BLE `Data`. The are functions to format `Data` as `String` as well.

## In Use By

Here's a listing of the iOS/iPadOS/macOS Projects we at Nordic use this code in. Obviously since this is Open Source, you're free to use any of it as well. We're just highlighting here some of the products that have lead to the battle-testing of some of this code.

- `nRF Connect for Mobile`: [App Store](https://apps.apple.com/no/app/nrf-connect-for-mobile/id1054362403) [GitHub (not Open Source)](https://github.com/NordicSemiconductor/IOS-nRF-Connect)
- `nRF Toolbox`: [App Store](https://apps.apple.com/no/app/nrf-toolbox/id820906058) [GitHub](https://github.com/NordicSemiconductor/IOS-nRF-Toolbox)
- `nRF Edge Impulse`: [App Store](https://apps.apple.com/no/app/nrf-edge-impulse/id1557234087?l=nb) [GitHub](https://github.com/NordicSemiconductor/IOS-nRF-Edge-Impulse)
- `nRF Memfault`: [App Store](https://apps.apple.com/no/app/nrf-memfault/id1641119282) [GitHub](https://github.com/NordicSemiconductor/IOS-Memfault-Library)
