# Quest of Galaxy - 2Moons engine-based browsergame for Steemians

![](https://steemitimages.com/DQmNhKvcRhp5THpijqS45M18MiDpg1Cvc78Sv9rKCiJi5NJ/image.png)


## The game

The open source browsergame framework is based on [2Moons](https://gitter.im/2MoonsGame/Lobby/).

Full source code is placed at [github.com/steemnova/steemnova](https://github.com/steemnova/steemnova) repository. It is fork of [jkroepke/2Moons](https://github.com/jkroepke/2Moons) for Steem community purposes. SteemNova repository is the center of the game. The opportunity was given to change the game code by Steemians, most probably [Utopians](https://utopian.io/) as a contribution. There are many things to modify starting from **graphics, languages, code improvements up to Steem integration and bughunting**.

<p align="center">
<img src="https://www.steem.center/images/archive/5/55/20160814202358%21Steem_Logo.png">
</p>


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

SteemNova expansion goes as follows:
1. ~~Reorganize github code. Specify README and LICENSE documentation~~. Fix any game issues if there will be any.
2. ~~Create SteemNova Board community on top of Steem blockchain~~. (https://chainbb.com/f/steemnova)
3. Game manual and tips & tricks for newbies.
4. ~~Specify detailed explanation how the reward system will work~~. (https://steemit.com/steemnova/@steemnova/steemnova-weekly-sbd-reward-scheme-for-members-of-the-best-alliances)
5. Announce bug bounties, artwork contests and utopian-io task requests for contributors (mobile UI, visual bugs etc.).
6. ~~Steem accounts integration.~~ (https://github.com/steemnova/steemnova/pull/67)
7. Fix all known bugs
8. Complete new design

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
