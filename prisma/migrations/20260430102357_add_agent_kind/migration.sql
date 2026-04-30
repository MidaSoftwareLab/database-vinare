/*
  Warnings:

  - A unique constraint covering the columns `[organizationId,kind]` on the table `agent` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateEnum
CREATE TYPE "AgentKind" AS ENUM ('ecommerce');

-- DropIndex
DROP INDEX "agent_organizationId_name_key";

-- AlterTable
ALTER TABLE "agent" ADD COLUMN     "kind" "AgentKind" NOT NULL DEFAULT 'ecommerce';

-- CreateIndex
CREATE UNIQUE INDEX "agent_organizationId_kind_key" ON "agent"("organizationId", "kind");
