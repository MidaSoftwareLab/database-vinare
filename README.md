# VinAre Central Database & Migrations

This repository contains the standalone database source of truth for the VinAre project.
To prevent migration conflicts between the Next.js frontend (`vinare-noda`) and the Python backend (`sommelier-virtuale`), this standalone repository handles the schema and docker DB.

## Getting Started

1. **Start the Database**
   ```bash
   npm run db:up
   ```
   This spins up a PostgreSQL + pgvector container mapped to port `5433` (to avoid conflicting with existing port `5432` DBs).

2. **Install Dependencies**
   ```bash
   npm install
   ```

3. **Apply Migrations**
   ```bash
   npm run migrate:dev
   ```
   This will apply all consolidated migrations to the local Docker database.

## Updating the Schema

If you need to make changes to the schema:
1. Update `prisma/schema.prisma` here.
2. Run `npm run migrate:dev` to create the migration file and apply it to the Docker DB.
3. Once the database is updated, go to your frontend (`vinare-noda`) and backend (`sommelier-virtuale`) and run:
   ```bash
   npx prisma generate
   ```
   *Make sure you have copied the updated schema.prisma to those repositories first before running generate!*

## Connecting your Apps

Update your `.env` files in both frontend and backend to point to this new database:

```env
# For local development with Docker
DATABASE_URL="postgresql://postgres:postgres@localhost:5433/sommelier"
POSTGRES_PRISMA_URL="postgresql://postgres:postgres@localhost:5433/sommelier"
```
