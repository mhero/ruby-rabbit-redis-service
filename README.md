## Dependencies

* Ruby 3.2.0

## Apps info
 * Sinatra app runs in port 4567 (using this default config)

## Local Development
## Docker install

1. Install dependencies
```
https://www.docker.com/products/docker-desktop
```

2. Clone repository
3. cd into repository folder

4. Create env files
```
cd producer cp .env.example .env
cd ..
cd consumer cp .env.example .env
``

5. Run
```
docker-compose up
```

Optional

RabbitMQ dashboard

```
http://localhost:15672
```