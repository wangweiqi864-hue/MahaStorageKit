# MahaStorageKit

`MahaStorageKit` is a lightweight sandbox file utility extracted from `MHFileHandle` for private pod distribution.

## Structure

- `MahaStorageKit/Classes/MahaStorageManager.swift`: public file storage entrypoint
- `MahaStorageKit.podspec`: pod definition for private distribution

## Current Behavior

- Uses `/Mango/` as the default sandbox root directory, but exposes a public configuration entry for the host app
- Creates the same default subdirectories on initialization
- Depends on `MahaLogCore`

## Configuration

```swift
MahaStorageManager.configure(rootDirectoryName: "/AppSandbox/")
```

## Installation

This repository is prepared for private pod distribution through:

- Pod source repo: `https://github.com/wangweiqi864-hue/MaHaSpecs.git`
- Library repo: `https://github.com/wangweiqi864-hue/MahaStorageKit.git`

## Notes

- Prepared from `Maha_/LocalPods/MHFileHandle`
- The original app integration is intentionally untouched at this stage

## License

See `LICENSE`.
