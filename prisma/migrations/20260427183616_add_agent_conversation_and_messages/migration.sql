-- CreateTable
CREATE TABLE "agent_conversation" (
    "id" TEXT NOT NULL,
    "public_id" TEXT NOT NULL,
    "organization_id" TEXT NOT NULL,
    "agent_id" VARCHAR(128) NOT NULL,
    "provider_type" VARCHAR(32) NOT NULL,
    "mode" VARCHAR(16) NOT NULL DEFAULT 'embedded',
    "user_lang" VARCHAR(8) NOT NULL DEFAULT 'en',
    "status" VARCHAR(16) NOT NULL DEFAULT 'active',
    "cart_id" TEXT,
    "cart_metadata" JSONB NOT NULL DEFAULT '{}',
    "metadata" JSONB NOT NULL DEFAULT '{}',
    "next_seq" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "agent_conversation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "agent_message" (
    "id" TEXT NOT NULL,
    "conversation_id" TEXT NOT NULL,
    "seq" INTEGER NOT NULL,
    "role" VARCHAR(16) NOT NULL,
    "content" TEXT NOT NULL,
    "tool_call_id" TEXT,
    "tool_name" VARCHAR(128),
    "model" VARCHAR(128),
    "temperature" REAL,
    "max_tokens" INTEGER,
    "prompt_tokens" INTEGER,
    "completion_tokens" INTEGER,
    "total_tokens" INTEGER,
    "latency_ms" INTEGER,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "agent_message_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "agent_conversation_public_id_key" ON "agent_conversation"("public_id");

-- CreateIndex
CREATE INDEX "agent_conversation_organization_id_idx" ON "agent_conversation"("organization_id");

-- CreateIndex
CREATE INDEX "agent_conversation_agent_id_idx" ON "agent_conversation"("agent_id");

-- CreateIndex
CREATE INDEX "agent_message_conversation_id_seq_idx" ON "agent_message"("conversation_id", "seq");

-- CreateIndex
CREATE UNIQUE INDEX "agent_message_conversation_id_seq_key" ON "agent_message"("conversation_id", "seq");

-- AddForeignKey
ALTER TABLE "agent_conversation" ADD CONSTRAINT "agent_conversation_organization_id_fkey" FOREIGN KEY ("organization_id") REFERENCES "organization"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "agent_message" ADD CONSTRAINT "agent_message_conversation_id_fkey" FOREIGN KEY ("conversation_id") REFERENCES "agent_conversation"("id") ON DELETE CASCADE ON UPDATE CASCADE;
