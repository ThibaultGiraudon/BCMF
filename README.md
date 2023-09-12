## Introduction

### Description

This is the BCMF (Basket Club Montbrison Feminin, Montbrison Women's Basketball Club) app, here you can find all the information about the club: 
- players' name, size, total scored of the season...
- all the match
- the pool ranking

I've created this app mainly has a challenge for the moment it is not planned to be published it on the Appstore.

### Features

- Navigation between different views.
- Fetching data from a database
- Authentification

### Improvements

- Upload the image in the database from the app
- Use a date picker when editing or adding match's dates

## Getting Started

### Prerequisites

Before running the program, make sure you have the following:

- Xcode installed on your macOS machine.
- Basic knowledge of Swift and SwiftUI.

### Installation

1. Clone this repository to your local machine using:

   ```bash
   git clone https://github.com/Thib1708/BCMF.git
   ```

2. Open the project in Xcode by double-clicking the `.xcodeproj` file.

### Usage

1. Build and run the program using Xcode.
2. Explore the different SwiftUI views and interactions.
3. Modify the code to experiment with SwiftUI features and customize the app to your needs.

## Project Structure

- **ContentView**: Entry point of the SwiftUI app.
- **Views**: Contains SwiftUI views.
- **Model**: Defines data models used in the app.
- **Assets**: Houses assets, such as images or other media files.

## License

This SwiftUI program is open-source and available under the [MIT License](LICENSE). You are free to use, modify, and distribute the code as per the terms of the license.

## Acknowledgments

Special thanks to the Swift and SwiftUI communities for their contributions and support:
- The PlayerListView and the PlayerDetailView inspiration come from this [Apple tutorial](https://developer.apple.com/tutorials/swiftui)
- I've learned all the CRUD function thanks to [Peter Friese](https://peterfriese.dev/posts/swiftui-firebase-fetch-data/)
- I've learned how to login and logout the app with Auth0 with [Joey deVilla](https://auth0.com/blog/get-started-ios-authentication-swift-swiftui-part-1-login-logout/)
