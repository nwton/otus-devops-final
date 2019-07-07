# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Some info about this you can get from [latest version 1.0.0](https://keepachangelog.com/ru/1.0.0/)
And some info you can get from [older version 0.3.0](https://keepachangelog.com/ru/0.3.0/)

## [Unreleased]
### Added

### Changed

## [0.1.3] - 2019-07-07
### Added
- Add depends_on to mongodb and rabbitmq for crawler
  (if crawler run firstly, it fault)
- Add ENV for rabbitmq username and password
  (safety don't use default guest/guest)
- Parametrize in ENV for crawler URL and EXCLUDE_URL

### Changed
- Move ENV vars from build docker images to compose
- Change name of mongodb container
- Fixup links in changelog (from tamplate to my own)

## [0.1.2] - 2019-07-07
### Added
- Add docker-lab module (GCP and local)
- Readme for sources
- Setup application in docker container
- Add docker-compose playbook

### Changed
- Move source code of crawler and ui to folder src

## [0.0.1] - 2019-07-06
### Added
- Initial commit
- Get source code
  - <https://github.com/express42/search_engine_crawler/archive/master.zip>
  - <https://github.com/express42/search_engine_ui/archive/master.zip>

[Unreleased]: https://github.com/olivierlacan/keep-a-changelog/compare/v1.0.0...HEAD
[0.1.3]: https://github.com/olivierlacan/keep-a-changelog/compare/v0.1.2...v0.1.3
[0.1.2]: https://github.com/olivierlacan/keep-a-changelog/compare/v0.0.1...v0.1.2
[0.0.1]: https://github.com/olivierlacan/keep-a-changelog/releases/tag/v0.0.1
