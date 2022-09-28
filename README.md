# KVFileKit

## Goal

It is a wrapper around the Apple FileManager class for managing the file system in object format.

## Next step

- [ ] Unit tests
- [ ] CI
  - [ ] Build iOS sample
  - [ ] Build macOS sample
  - [ ] Launch unit tests
  - [ ] Build package
  - [ ] Swiftlint
- [ ] Implement device class
- [ ] Test on tvOS
- [ ] Add logger

## Dependencies

No dependency is necessary.

## How install it?

Nowaday we only support `Swift Package Manager`. You can use build-in UI tool for XCode with this search words: `Kelvas09/KVFileKit` or you can add it directyl with this following command :

```swift
.package(url: "https://github.com/Kelvas09/KVFileKit.git", from: "1.0.0")
```

## How use it?

### Getting started

It is very easy to get started with `KVFileKit`. To do so, you just have to create a new instance of the `FileSystem` class with an instance of the `FileManager` as parameter:

```swift
let fileManager = FileManager.default
let fileSystem = FileSystem(fileManager: fileManager)
```

### Recover your first file or directory

The `FileSystem` class allows to retrieve a file or a folder from its URL:

```swift
guard let directory = fileSystem.getDirectory(from: directoryUrl) else { return }

...
```

```swift
guard let file = fileSystem.getFile(from: directoryUrl) else { return }

...
```

In case the file or directory does not exist, you will get a nil return.

### Retrieve the tree structure via a URL

It is possible to retrieve the first level of the tree directly with the `FileSystem` class and a URL. To continue to go down the tree, you will need to see the `entries` property of each folder.

### Directories and files are stateless

The classes representing the directories and files do not have a state, so each time you ask for the tree structure or the reading of a file, it is done on the disk in order to avoid the changes done by another application.

### Create a file or directory

Each folder can create files and subfolders from a simple name :

```swift
guard let directory = fileSystem.getDirectory(from: directoryUrl) else { return }
do {
    try directory.createFile(with: "myFile", ext: "txt")
    try directory.createDirectory(with: "myDirectory")
} catch {
    print("Oops! Impossible to create file or folder")
}
```

## Samples

You can access to samples projects on folder `Samples`