Senate
=======

Senate is a brainstorming, idea management, and voting Rails app originally developed by btgeek <http://brad-thompson.com>. This repository is forked from <http://github.com/WLCSC/Senate>

How To
------

* edit Gemfile to install postgresql (pg) or sqlite3 (sqlite)
* bundle install
* edit/create config/database.yml from database.yml.sample.pg or .sqlite3
* edit/create config/app_config.yml
* bundle exec rake db:setup
* bundle exec rake adduser

Note that LDAP users don't exist until the first time they log in.
Log in as someone who you belongs to your admin group (or log in and then make yourself an admin through the console).  


All the exciting stuff happens inside Chambers.  In a chamber, you have Announcements (chamber specific news), discussion boards, Proposals (thumbs up/down idea discussion), Ballots (voting), Events (who's showing up to stuff) Titles (for certain users to get additional stuff after their name), and Permissions (controlling which users/groups can do what inside your chamber).



Copyright 2011, 2012 Brad Thompson 
Copyright 2013 (after fork from Brad Thompson's repository) J. Tooze

Distributed under the terms of the GNU General Public License

Senate is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Senate is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Senate.  If not, see <http://www.gnu.org/licenses/>.
