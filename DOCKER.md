## Launch docker
- docker compose up
OR
- docker compose up -d (for detached)

## Stop docker
- Control + C (macOS)
OR
- docker compose down

## Local admin connection URI for this project
```bash
$ mongodb://maghwyn:u80h98ARs8tZ73FsDAStl1NMH9tpORZOUrEoju4P@localhost:27017/?authSource=admin
```

## Use mongoDB compass
- Install mongoDB compass at https://www.mongodb.com/try/download/compass
- Access the database with the uri connection link.
- Create database called `horser-dev` with collection `users`
- Open mongosh terminal.

## Mongosh Terminal
- Run the following commands :
```bash
$ use horser-dev
$ db.createUser({
   user:"horser",
   pwd:"4z3ZqFb0jtdXC8dLhZU14J6V8LpjYyfWni1Ujsj0",
   roles:[{role:"dbOwner",db:"horser-dev"}]
})
$ db.getUsers() # Verify the user in database horser-dev
```

## Local user connection URI for this project
```
$ mongodb://horser:4z3ZqFb0jtdXC8dLhZU14J6V8LpjYyfWni1Ujsj0@localhost:27017/horser-dev
```

# DISCLAIMER
This project use a dotenv flutter library.
If you wish to use your own database connection, please create a .env file with :
```bash
MONGO_URI=
MONGO_DBNAME=
```
Otherwise, the project has a fallback and will connect to the local user URI.