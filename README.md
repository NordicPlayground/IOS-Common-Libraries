<p align="center" width="100%">
    <img width="60%" src="https://raw.githubusercontent.com/NordicPlayground/IOS-Common-Libraries/main/Logo_RGB_Horizontal_Transparent.png">
</p>

# iOS-Common-Libraries

This is a Swift Package containing Swift code and Utilities/Assets, such as Colors, used by Nordic's iOS/Mac apps.

> [!IMPORTANT]  
> This repository contains APIs and Utilities used by ourselves. Ones that we find useful to extend to the community, because most of it we've learned through you, so we owe it back to you. That being said, this repository should not be considered public-facing API. We reserve the right to modify any of the components shared here to fit our uses.

## Contents

### Colors

The swatch of Nordic colors is available here for our own use. We're keeping to the [DRY Principle](https://wiki.c2.com/?DontRepeatYourself) of course, but the side-benefit of this is that updating the colors in one place, automagically updates all of our apps.

Additionally, there are helper items here. We have `struct RGB` and `RGBA` structures so that 8-bit colors can be stored as a `UInt32` and thus helping memory consumption.

### Utilities

- `Cache`: Need to use `NSCache` with a pure-Swift `struct`? This is what this is for. Also, it's just John Sundell's work in a library that we use.
- `BitField`: Alternative to an `enum` `Set` that allows us to store everything in a single CPU Register, both in memory and as a `Codable`.
- `NordicLog`: Apple added `OSLog` as the [performance-oriented logging API](https://developer.apple.com/documentation/os/oslog) for their platforms back in 2018. We've since adopted it in nRF Connect for Mobile, and extended its use accross all apps. And what we found is that, we kept re-implementing the same set of APIs for logging everywhere. So we picked one implementation, and moved it here so that we can use it everywhere. Additionally, it supports not only OSLog APIs but also [performance-logging APIs](https://developer.apple.com/documentation/os/logging/recording_performance_data), allowing us to measure calls for performance.

### Extensions

- `Data`: There are helper functions here to handle bytes within a `Data` blob. This is code used by [nRF Connect for Mobile](https://apps.apple.com/es/app/nrf-connect-for-mobile/id1054362403) to read individual bytes from advertised BLE `Data`. The are functions to format `Data` as `String` as well.

## In Use By

Here's a listing of the iOS/iPadOS/macOS Projects we at Nordic use this code in. Obviously since this is Open Source, you're free to use any of it as well. We're just highlighting here some of the products that have lead to the battle-testing of some of this code.

- `nRF Connect for Mobile`: [App Store](https://apps.apple.com/no/app/nrf-connect-for-mobile/id1054362403) [GitHub (not Open Source)](https://github.com/NordicSemiconductor/IOS-nRF-Connect)
- `nRF Toolbox`: [App Store](https://apps.apple.com/no/app/nrf-toolbox/id820906058) [GitHub](https://github.com/NordicSemiconductor/IOS-nRF-Toolbox)
- `nRF Edge Impulse`: [App Store](https://apps.apple.com/no/app/nrf-edge-impulse/id1557234087?l=nb) [GitHub](https://github.com/NordicSemiconductor/IOS-nRF-Edge-Impulse)
- `nRF Memfault`: [App Store](https://apps.apple.com/no/app/nrf-memfault/id1641119282) [GitHub](https://github.com/NordicSemiconductor/IOS-Memfault-Library)
