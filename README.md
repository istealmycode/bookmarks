# Bookmarks App

## Table of Contents

- [Database Setup](#database-setup)
- [Install Dependencies](#install-dependencies)
- [To Start the App](#to-start-the-app)
- [To Do List](#to-do-list)

This is a basic Rails project that serves as a bookmark storage application.

## Database Setup

1. Make sure you have PostgreSQL installed on your system.
2. Update `config/database.yml` with your PostgreSQL username and password.
3. Run the following commands to create and migrate the database:

```bash
rails db:create
rails db:migrate
```
4. You can also seed the database with an initial user and bookmarks with:

```bash
rails db:seed
```

## Install Dependices 
```bash
bundle install
```

## To start the app

```bash
bin/dev
```

## To Do List
- Sorting
- Filtering
- Tag list
- Pagination
- Styling on devise views

