/*
  Warnings:

  - You are about to drop the column `avatarEmoji` on the `agent` table. All the data in the column will be lost.
  - You are about to drop the column `logoUrl` on the `agent` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "agent" DROP COLUMN "avatarEmoji",
DROP COLUMN "logoUrl";

-- AlterTable
ALTER TABLE "agent_message" ADD COLUMN     "actions" JSONB DEFAULT '[]';

-- AlterTable
ALTER TABLE "qr_code" ADD COLUMN     "agentId" TEXT;

-- CreateIndex
CREATE INDEX "qr_code_agentId_idx" ON "qr_code"("agentId");

-- AddForeignKey
ALTER TABLE "qr_code" ADD CONSTRAINT "qr_code_agentId_fkey" FOREIGN KEY ("agentId") REFERENCES "agent"("id") ON DELETE SET NULL ON UPDATE CASCADE;
