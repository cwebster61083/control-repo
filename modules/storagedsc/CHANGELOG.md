## [5.0.1] - 2020-08-03

### Changed

- Fixed build failures caused by changes in `ModuleBuilder` module v1.7.0
  by changing `CopyDirectories` to `CopyPaths` - Fixes [Issue #237](https://github.com/dsccommunity/StorageDsc/issues/237).
- Updated to use the common module _DscResource.Common_ - Fixes [Issue #234](https://github.com/dsccommunity/StorageDsc/issues/234).
- Pin `Pester` module to 4.10.1 because Pester 5.0 is missing code
  coverage - Fixes [Issue #238](https://github.com/dsccommunity/StorageDsc/issues/238).
- OpticalDiskDriveLetter:
  - Removed integration test that tests when a disk is not in the
    system as it is not a useful test, does not work correctly
    and is covered by unit tests - Fixes [Issue #240](https://github.com/dsccommunity/StorageDsc/issues/240).
- StorageDsc
  - Automatically publish documentation to GitHub Wiki - Fixes [Issue #241](https://github.com/dsccommunity/StorageDsc/issues/241).

### Fixed

- Disk:
  - Fix bug when multiple partitions with the same drive letter are
    reported by the disk subsystem - Fixes [Issue #210](https://github.com/dsccommunity/StorageDsc/issues/210).


