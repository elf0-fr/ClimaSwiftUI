
# ClimaSwiftUI

This project is a modern reimagining of the [sample code](https://github.com/appbrewery/Clima-iOS13) from “The Complete iOS Development Bootcamp”, rebuilt entirely using **SwiftUI**.

With this app, you can get the current weather conditions for any location you search for, or based on your current location.

Weather data is provided by [OpenWeather](https://openweathermap.org/api)

## Getting started

To run this project on your local machine, follow these steps:

### Requirements

- macOS with Xcode 16 or later installed.
- valid OpenWeather API key.

### Setup Instructions

1.	Clone the repository: 
    ```sh
    git clone https://github.com/elf0-fr/ClimaSwiftUI
    ```
2. Create an acount at [OpenWeather](https://home.openweathermap.org/users/sign_up) and generate your API key [here](https://home.openweathermap.org/api_keys).
3. Add a new Swift file at ClimaSwiftUI/Service/APIKey.swift with the following contents:
    ```swift
    let key = "YOUR_API_KEY_HERE"
    ```

## Roadmap

- [x] MVP: User can get weather conditions by searching for a place or using their current location.
- [ ] Widget: Add a configurable widget that displays weather for a selected location.
- [ ] Watch: User can get weather condition on their  Watch.

## License

This project is for educational purposes and is inspired by App Brewery’s bootcamp content.
If you use any portion of this code in your own work, attribution is appreciated.