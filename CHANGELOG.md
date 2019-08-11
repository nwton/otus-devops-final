# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Some info about this you can get from [latest version 1.0.0](https://keepachangelog.com/ru/1.0.0/)
And some info you can get from [older version 0.3.0](https://keepachangelog.com/ru/0.3.0/)

## [Unreleased]
### Added
- Move support for remote storage to separate folder and add
  notes about using in readme

### Changed

## [0.2.1] - 2019-07-08
### Added
- Add terraform role for gitlab host
- Add terraform role for firewall to crawler UI
- Add support for remote storage for tfstate files
- Add stage and prod environment in terraform

## [0.1.4] - 2019-07-08
### Added
- Add packer template to build image in GCP with docker-ce

### Changed
- Fixup links in changelog (from template to my own)

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

[Unreleased]: https://github.com/nwton/otus-devops-final/compare/v0.1.4...HEAD
[0.2.1]: https://github.com/nwton/otus-devops-final/compare/v0.1.4...v0.2.1
[0.1.4]: https://github.com/nwton/otus-devops-final/compare/v0.1.3...v0.1.4
[0.1.3]: https://github.com/nwton/otus-devops-final/compare/v0.1.2...v0.1.3
[0.1.2]: https://github.com/nwton/otus-devops-final/compare/v0.0.1...v0.1.2
[0.0.1]: https://github.com/nwton/otus-devops-final/releases/tag/v0.0.1
