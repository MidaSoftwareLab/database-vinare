-- AlterEnum
ALTER TYPE "Permission" ADD VALUE 'agents';

-- CreateTable
CREATE TABLE "agent" (
    "id" TEXT NOT NULL,
    "organizationId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "systemPrompt" TEXT NOT NULL DEFAULT '',
    "language" TEXT NOT NULL DEFAULT 'it',
    "publicCode" TEXT NOT NULL,
    "providerType" TEXT NOT NULL,
    "storeUrl" TEXT NOT NULL,
    "storeName" TEXT,
    "storeCurrency" TEXT NOT NULL DEFAULT 'EUR',
    "storePolicy" TEXT,
    "encryptedCreds" TEXT NOT NULL,
    "allowedDomains" TEXT[],
    "ecommerceEnabled" BOOLEAN NOT NULL DEFAULT true,
    "scanCount" INTEGER NOT NULL DEFAULT 0,
    "lastScannedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "agent_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "agent_publicCode_key" ON "agent"("publicCode");

-- CreateIndex
CREATE INDEX "agent_organizationId_idx" ON "agent"("organizationId");

-- CreateIndex
CREATE UNIQUE INDEX "agent_organizationId_name_key" ON "agent"("organizationId", "name");

-- AddForeignKey
ALTER TABLE "agent" ADD CONSTRAINT "agent_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "organization"("id") ON DELETE CASCADE ON UPDATE CASCADE;
