# UnsplashSwift

UnsplashSwift is a Swift framework to interact with the [Unsplash API](https://unsplash.com/developers).

__This framework is in heavy development and not ready for production yet.__

## Background

UnsplashSwift uses [Alamofire](https://github.com/Alamofire/Alamofire) as the backbone for API communication and OAuth authentication. The framework's architecture design is modeled heavily off of the way Dropbox implements their framework for Swift ([SwiffyDropbox](https://github.com/dropbox/SwiftyDropbox)).

- [API Documentation](https://unsplash.com/documentation)

## Features

- User Authorization
- Current User
- Users
- Photos
- Categories
- Collections
- Stats

## Requirements

- iOS 9.0+
- Xcode 7.2+

## Communication

- If you __found a bug__, open an issue.
- If you __have a feature request__, open an issue.
- If you __want to contribute__, submit a pull request.

## Getting Started

If you don't have an application ID and secret, follow the steps from the [Unsplash API](https://unsplash.com/developers) to register a new application. When you register a new application it will ask for a callback URL. Enter one in the following format:

```
unsplash-[YOUR_APP_ID]://token
```

## Installation

Right now there is no support for Cocoapods or Carthage (support will be added as the framework develops).

## Usage

### Set Up

To start using the framework first set up the Unsplash client in your application's AppDelegate file.

```swift
import UIKit
import UnsplashSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        Unsplash.setUpWithAppId("APP_ID", secret: "SECRET")

        return true
    }
}
```

__Note:__ Make sure to replace ```APP_ID``` and ```SECRET``` with the application ID and secret you received when you created an application with the [Unsplash API](https://unsplash.com/developers).

### User Authentication

#### Authorize user

To authorize a user, use ```authorizeFromController(controller:completion:)``` from the shared Unsplash client.

```swift
Unsplash.authorizeFromController(self, completion: { success, error in
    if success {
        print("linked to Unsplash!")
    } else {
        print(error!.localizedDescription)
    }
})
```

__Note:__ Authorizing a user is not always required to interact with the Unsplash API. For example, you can retrieve curated batches without having a user log in.

### Current User

#### Retrieve Profile

To retrieve the current user's profile, use ```profile()``` from the shared Unsplash client.

```swift
let client = Unsplash.client!
client.currentUser.profile().response({ response, error in
    if let user = response {
        print(user.username)
    } else {
      // Handle error.
    }
})
```

#### Update Profile

To update the current user's profile, use ```updateProfile(username:firstName:lastName:email:portfolioURL:location:bio:instagramUsername)``` from the shared Unsplash client.

```swift
let client = Unsplash.client!
client.currentUser.upateProfile(firstName: "FIRST_NAME").response({ response, error in
    if let user = response {
        print(user.username)
    } else {
      // Handle error.
    }
})
```

### Users

#### Retrieve User

To retrieve a user, use ```findUser(username:)``` from the shared Unsplash client.
```swift
let client = Unsplash.client!
client.users.findUser("USERNAME").response({ response, error in
    if let user = response {
        print(user.username)
    } else {
      // Handle error.
    }
})
```

#### Retrieve User's Photos

To retrieve the photos of a user, use ```photosForUser(username:)``` from the shared Unsplash client.
```swift
let client = Unsplash.client!
client.users.photosForUser("USERNAME").response({ response, error in
    if let result = response {
        print(result.photos)
    } else {
      // Handle error.
    }
})
```

#### Retrieve User's Likes

To retrieve the likes of a user, use ```likesForUser(username:page:perPage:)``` from the shared Unsplash client.
```swift
let client = Unsplash.client!
client.users.likesForUser("USERNAME").response({ response, error in
    if let result = response {
        print(result.photos)
    } else {
      // Handle error.
    }
})
```

### Photos

#### Retrieve Photos

To retrieve photos, use ```findPhotos(page:perPage:)``` from the Unsplash client.
```swift
let client = Unsplash.client!
client.photos.findPhotos(2, perPage:nil).response({ response, error in
    if let result = response {
        print(result.photos)
    } else {
      // Handle error.
    }
})
```

#### Search Photos

To search for photos, use ```search(query:categoryIds:page:perPage:)``` from the shared Unsplash client.
```swift
let client = Unsplash.client!
client.photos.search("cat").response({ response, error in
    if let result = response {
        print(result.photos)
    } else {
      // Handle error.
    }
})
```

#### Specific Photo

To retrieve a specific photo, use ```findPhoto(photoId:width:height:rect:)``` from the shared Unsplash client.
```swift
let client = Unsplash.client!
client.photos.findPhoto("PHOTO_ID").response({ response, error in
    if let photo = response {
        print(photo.id)
    } else {
      // Handle error.
    }
})
```

#### Random Photo

To retrieve a random photo, use ```random(query:categoryIds:featured:username:width:height:)``` from the shared Unsplash client.
```swift
let client = Unsplash.client!
client.photos.random().response({ response, error in
    if let photo = response {
        print(photo.id)
    } else {
      // Handle error.
    }
})
```

#### Upload Photo

To upload a photo, use ```uploadPhoto(photo:location:exif:)``` from the shared Unsplash client.
```swift
let image = UIImage(named: "cat.jpg")
let client = Unsplash.client!
client.photos.uploadPhoto(image).response({ response, error in
    if let photo = response {
        print(photo.id)
    } else {
      // Handle error.
    }
})
```

The ```photos``` property, of the UnsplashClient, contains other methods as well (_PhotosRoutes.swift_).

### Categories

#### All Categories

To retrieve all the categories, use ```all()``` from the Unsplash client.
```swift
let client = Unsplash.client!
client.categories.all().response({ response, error in
    if let result = response {
        print(result.categories)
    } else {
      // Handle error.
    }
})
```

#### Specific Category

To retrieve a specific curated batch, use ```findCategory(categoryId:)``` from the shared Unsplash client.
```swift
let client = Unsplash.client!
client.categories.findCategory(2).response({ response, error in
    if let category = response {
        print(category.title)
    } else {
      // Handle error.
    }
})
```

The ```categories``` property, of the UnsplashClient, contains other methods as well (_CategoriesRoutes.swift_).

### Collections

#### Retrieve Collections

To retrieve collections, use ```findCollections(page:perPage:)``` from the shared Unsplash client.
```swift
let client = Unsplash.client!
client.curatedBatches.findCollections().response({ response, error in
    if let result = response {
        print(result.collections)
    } else {
      // Handle error.
    }
})
```

#### Specific Collection

To retrieve a specific collection, use ```findCollection(collectionId:)``` from the shared Unsplash client.
```swift
let client = Unsplash.client!
client.collections.findCollection(1).response({ response, error in
    if let collection = response {
        print(collection)
    } else {
      // Handle error.
    }
})
```

#### Create Collection

To create a collection, use ```createCollection(title:description:isPrivate:)``` from the shared Unsplash client.
```swift
let client = Unsplash.client!
client.collections.createCollection("Cats").response({ response, error in
    if let collection = response {
        print(collection)
    } else {
      // Handle error.
    }
})
```

The ```collections``` property, of the UnsplashClient, contains other methods as well (_CollectionsRoutes.swift_).

### Stats

#### Total Downloads

To retrieve the total number of downloads, use ```totalDownloads()``` from the Unsplash client.
```swift
let client = Unsplash.client!
client.stats.totalDownloads().response({ response, error in
    if let stats = response {
        print(stats.photoDownloads)
        print(stats.batchDownloads)
    } else {
      // Handle error.
    }
})
```

## Unit Tests

UnsplashSwift includes a set of unit tests to run on the framework. These unit tests use the NSURLProtocol to mock all the API responses so that an app Id and secret are not necessary to run the tests.

## Contributors

- [Camden Fullmer](https://twitter.com/camdenfullmer)

## License

UnsplashSwift is released under the MIT license. See LICENSE for details.
