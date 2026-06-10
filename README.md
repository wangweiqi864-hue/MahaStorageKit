# MahaStorageKit

`MahaStorageKit` is a lightweight sandbox file utility extracted from `MHFileHandle` for private pod distribution.

## Structure

- `MahaStorageKit/Classes/MahaStorageManager.swift`: public file storage entrypoint
- `MahaStorageKit.podspec`: pod definition for private distribution

## Current Behavior

- Preserves the existing `/Mango/` sandbox root directory
- Creates the same default subdirectories on initialization
- Depends on `MHLog`

## Installation

This repository is prepared for private pod distribution through:

- Pod source repo: `https://github.com/wangweiqi864-hue/MaHaSpecs.git`
- Library repo: `https://github.com/wangweiqi864-hue/MahaStorageKit.git`

## Notes

- Prepared from `Maha_/LocalPods/MHFileHandle`
- The original app integration is intentionally untouched at this stage

## License

See `LICENSE`.
