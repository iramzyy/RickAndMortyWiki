
# Rick N Morty Wiki

## <a name="intro"></a> Intro
Rick N Morty Wiki is an iOS application designed to demonstrate clean architecture principles practically. This app showcases various functionalities, and this documentation provides a detailed insight into its technical intricacies and design choices.


# Table of contents
- [Intro](#intro)
- [Quick Start](#quick-start)
    - [Prerequisites](#quick-start-prerequisites)
- [App Features](#features)
- [Used In the App](#used-in-app)
- [Design Kit](#design-system)
    - [Idea](#design-system-idea)
    - [Components](#design-system-components)
- [Core Layers](#core-layers)
    - [Core](#core-layers-core)
    - [Networking](#core-layers-network)
    - [Logger](#core-layers-logger)
    - [StorageKit](#core-layers-data)
- [App Architecture](#app-architecture)
- [Unit Testing](#unit-testing)
- [Screenshots](#screenshots)
- [Author](#author)

# <a name="quick-start"></a> Quick Start
This Quick Start guide will get you up with the app
## <a name="quick-start-prerequisites"></a> Prerequisites
- Xcode 15.1
- iOS 16.0

# <a name="features"></a> App Features
- Onboarding
- Characters List
- Character Details

# <a name="used-in-app"></a> Used In the App
- SwiftUI
- Combine
- DIContainer: Dependency Injection
- Coordinator, Repository, Builder, Factory, Singleton patterns ...etc


# <a name="design-system"></a> Design System
## <a name="design-system-idea"></a> The Idea
The reusability of the design is one of the most important concerns while we are building a scalable application that not only serves just a single application but also can serve multiple applications inside the organization, So, I created a Swift Package named "Design System", This package contains the common UI handling that can be shared with more than one app for more reusability.

The idea behind the built design system is to have a file for each application that contains the design system values per this application/theme, 
So, We have a base struct for the design system, Each application will have its values.

Initially, We have only the colors inside the design system, But we should handle all the variable tokens such as Typography, Padding, Sizing, Colors, ...etc

This package contains Extensions, Resources[Fonts/Assets], and Components.

## <a name="design-system-components"></a> Components
After the design analysis, I divided the design system components into two parts: 

- Basic Components: [PrimaryButton, RemoteImage,...etc]
- Product Components: The reusable views inside the app to be used in more than one screen CharacterCardView, CharacterStatusTag, OnboardingView,...etc]


# <a name="core-layers"></a> Core layers
I also built a Swift package for the core layers, These packages consists of packages for the core layers inside the app, Such as: 

## <a name="core-layers-core"></a> Core 
[Extensions, Utilities, Mappers, Typealias]

## <a name="core-layers-network"></a> Networking 
URLSession-based Network layer package, Remote Response Handler, Local Response Handler, Error Handler, ...etc

## <a name="core-layers-logger"></a> Logger
Initially, We had only the system logger engine that debug print the log messages, But it's open for extension and adding new engines

## <a name="core-layers-data"></a> Storage Kit
This package is built to persist many types of data with **save, update, and remove** options, Initially it is built with **UserDefaults** &  **Keychain**, is not used but will be used in futrue updates

# <a name="app-architecture"></a> App Architecture
This app is built using the  [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) guidelines and I separated the **Domain** and **Data** in separate Swift Packages to be reused inside the application, Giving us the required scalability level away from the presentation layer,
And, the **Presentation** layer is on the app side and separated by **module/feature/screen**

## Domain layer
The Domain layer consists of the **UseCases, RepoProtocols, And the Entities**
It also has the actual **UseCase Implementation**.

## Data layer
The Data layer consists of **DataSources, Endpoints, ReposImplementation, DTOs**. 

## Presentation Layer
The Presentation layer is an app-side containing the Modules, Features, and screens.
The presentation layer is built using the **MVVM With Coordinator** presentation architecture.

## How the App. & Layers communicating?
As we are separating the **domain and data** layers from the application and presentation layer, We need to handle the communication between the layers and the application side, We have the CoreData library that enables the application side to setup the data with the configuration and inject the dependencies that the data package need to run, We have the AppConfig and the APIConfig for this mission.

# <a name="unit-testing"></a> Unit Testing
I covered the **UseCases** with success and failure test cases
I'll update this project with the other test cases such as Repos, DataSources, ViewModels, and so on.



# <a name="screenshots"></a> Screenshots
| Launch Screen | Onboarding     | Characters List     | Character Details     |
| :-------- | :------- | :-------     | :-------     |
| <img src="/Screenshots/SplashScreen.png" width="200" height="400">        | <img src="/Screenshots/OnboardingScreen.png" width="200" height="400">       | <img src="/Screenshots/ListingScreen.png" width="200" height="400">       | <img src="/Screenshots/DetailsScreen.png" width="200" height="400">       |


# <a name="author"></a> Author
Created by 
- Ahmed Ramzy [LinkedIn](www.linkedin.com/in/iramzyy)

Please don't hesitate to ask any clarifying questions about the project if you have any.
