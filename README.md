# php-nginx-docker

php development environment using docker

## Overview

- nginx: 1.15.7
- php: 7.3
- xdebug
- composer

## Usage

Install docker on your machine and use the following command.

**Build and run app**

```
docker-compose up -d
```

Enter http://localhost:3900 in a browser to see the application running.If you want to use another port, edit docker-compose.yaml.

Change the port on the left and don't change the right.

```
  nginx:
    image: nginx:1.15.7-alpine
    ports:
      - 4200:80 // don't change the :80
```

**Stop app**

```
docker-compose down
```

### PHP

You can develop in php folder. If you want to run arbitrary commands in php environment, do the following

```
docker-compose up -d
docker-compose exec php /bin/ash

/var/ww/html # enter any command. this environment is alpine linux on docker
```

exec command "php" is service name set in docker-compose.yaml.

## Xdebug + VSCode configuration

This repo have specified xdebug remote_port 9012 in php.ini. So the configuration of VSCode's launch.json is below

### Example

```json
// launch.json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Listen for XDebug",
      "type": "php",
      "request": "launch",
      "port": 9012,
      "pathMappings": {
        "/var/www/html": "${workspaceFolder}/php"
      }
    }
  ]
}
```

## PHP With Postgres

Add the database settings to docker-compose.yaml. An example is the following. Port 5439 is an arbitary number, and is used when connecting from outside docker(such as pgAdmin).

```yaml
db:
  image: postgres:11-alpine
  ports:
    - 5439:5432
  restart: always
  environment:
    POSTGRES_USER: admin
    POSTGRES_PASSWORD: admin
```

Example of connecting to database with PHP

```php
$db = new PDO(
  'pgsql:host=db;dbname=admin;',
  'admin',
  'admin'
);
```
