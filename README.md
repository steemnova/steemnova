# Quest of Galaxy - 2Moons engine-based browsergame

![](https://cuneros.app/uploads/2021-08/Ks0Jxh.png)


## The game

The open source browsergame framework is based on [2Moons](https://gitter.im/2MoonsGame/Lobby/).

Full source code is placed at [https://github.com/bastiedotorg/quest-of-galaxy](https://github.com/bastiedotorg/quest-of-galaxy) repository. It is fork of [jkroepke/2Moons](https://github.com/jkroepke/2Moons) for bootstrap5

## Repository structure

- [cache] - temporary cached server .tpl webpages
- [chat] - AJAX ingame client-side chat
- [includes]
  - game engine
  - configuration
  - administration
  - database scheme
  - external libraries
  - webpages functionality
- [install]
  - first installation
  - database creation
- [language] - translations: DE, EN, ES, FR, PL, PT, RU, TR
- [licenses] - open source license schemes
- [scripts] - client-side web browser .js scripts
- [styles] 
  - webpages .css templates
  - webpages .tpl templates
  - fonts
  - images
- [tests]


## Roadmap

1. migration to bootstrap 5
2. design improvements
3. integration of cuneros payment

## Local installation

- Clone the repo: `git clone https://github.com/steemnova/steemnova`
- Install components: `apt install apache2 php7.3 php7.3-gd php7.3-fpm php7.3-mysql php7.3-curl php-ds libapache2-mod mysql-server`
- Setup mysql: `create user USER identified by PASSWORD; create database DB; grant all privileges on DB.* to USER;`
- Set write privileges to dirs: `cache/`, `includes/`
- Run wizard: `127.0.0.1/install/install.php`

### If you run SteemNova on NGINX - Read nginx.md file!

## Screenshots

<p align="center">
<img src="https://user-images.githubusercontent.com/56807194/69483643-10b60100-0e2a-11ea-826f-d657bcceb40a.png">
  <i>In game screen</i>
</p>

## Copyright and license

Quest Galaxy is a fork of SteemNova.

SteemNova is a fork of Open Source Browsergame Framework [jkroepke/2Moons](https://github.com/jkroepke/2Moons) engine.

Code copyright 2009-2016 Jan-Otto Kröpke released under the MIT License.

Code copyright 2018 @steemnova released under the MIT License.

Code copyright 2018-2020 @IntinteDAO released under the MIT License. (f66f0bf9f2d502f9cc3932e7f05e4795b3622ce6)

**Code copyright 07.05.2020-2020 @IntinteDAO released under the AGPLv3 License.**
