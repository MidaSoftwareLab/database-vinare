-- CreateTable
CREATE TABLE "org_configurations_dashboard" (
    "organization_id" TEXT NOT NULL,
    "dimensions_blob_uri" TEXT,
    "scraper_config_blob_uri" TEXT,
    "baselines_blob_uri" TEXT,
    "n_clusters" INTEGER NOT NULL DEFAULT 6,
    "last_extraction_at" TIMESTAMP(3),
    "last_evaluation_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "org_configurations_dashboard_pkey" PRIMARY KEY ("organization_id")
);

-- CreateTable
CREATE TABLE "feedback_record" (
    "id" TEXT NOT NULL,
    "organization_id" TEXT NOT NULL,
    "source" TEXT NOT NULL,
    "source_id" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "rating" DOUBLE PRECISION,
    "metadata" JSONB,
    "language" TEXT NOT NULL DEFAULT 'en',
    "content_hash" TEXT,
    "source_created_at" TIMESTAMP(3),
    "ingested_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "cluster_id" INTEGER,
    "persona_name" TEXT,
    "pca_x" DOUBLE PRECISION,
    "pca_y" DOUBLE PRECISION,
    "primary_intent" TEXT,
    "technicality" DOUBLE PRECISION,
    "buying_intent" DOUBLE PRECISION,
    "palate_profile" DOUBLE PRECISION,
    "occasion_logic" DOUBLE PRECISION,
    "evaluated_at" TIMESTAMP(3),

    CONSTRAINT "feedback_record_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "feedback_embedding" (
    "id" TEXT NOT NULL,
    "feedback_record_id" TEXT NOT NULL,
    "embedding" vector(3072),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "feedback_embedding_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "feedback_ml_profile" (
    "id" TEXT NOT NULL,
    "feedback_record_id" TEXT NOT NULL,
    "cluster_id" INTEGER,
    "persona_name" TEXT,
    "primary_intent" TEXT,
    "segmentation_status" TEXT NOT NULL,
    "segmentation_scope" TEXT NOT NULL,
    "exclusion_reason" TEXT,
    "naming_rationale" TEXT,
    "naming_confidence" DOUBLE PRECISION,
    "dominant_dimensions" JSONB,
    "dominant_poles" JSONB,
    "pca_x" DOUBLE PRECISION,
    "pca_y" DOUBLE PRECISION,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "feedback_ml_profile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "feedback_dimension_score" (
    "id" TEXT NOT NULL,
    "feedback_record_id" TEXT NOT NULL,
    "dimension_id" INTEGER NOT NULL,
    "dimension_key" TEXT NOT NULL,
    "dimension_name" TEXT NOT NULL,
    "raw_score" DOUBLE PRECISION,
    "normalized_score" DOUBLE PRECISION,
    "pole_1" TEXT NOT NULL,
    "pole_2" TEXT NOT NULL,
    "dominant_pole" TEXT,
    "is_neutral" BOOLEAN NOT NULL DEFAULT false,
    "ci_low" DOUBLE PRECISION,
    "ci_high" DOUBLE PRECISION,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "feedback_dimension_score_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "idx_feedback_record_org_id" ON "feedback_record"("organization_id");

-- CreateIndex
CREATE INDEX "idx_feedback_record_org_source" ON "feedback_record"("organization_id", "source");

-- CreateIndex
CREATE INDEX "idx_feedback_record_org_content_hash" ON "feedback_record"("organization_id", "content_hash");

-- CreateIndex
CREATE UNIQUE INDEX "feedback_record_organization_id_source_source_id_key" ON "feedback_record"("organization_id", "source", "source_id");

-- CreateIndex
CREATE UNIQUE INDEX "feedback_embedding_feedback_record_id_key" ON "feedback_embedding"("feedback_record_id");

-- CreateIndex
CREATE UNIQUE INDEX "feedback_ml_profile_feedback_record_id_key" ON "feedback_ml_profile"("feedback_record_id");

-- CreateIndex
CREATE INDEX "idx_feedback_ml_profile_persona" ON "feedback_ml_profile"("persona_name");

-- CreateIndex
CREATE INDEX "idx_feedback_ml_profile_seg_status" ON "feedback_ml_profile"("segmentation_status");

-- CreateIndex
CREATE INDEX "idx_feedback_dimension_score_dim_key" ON "feedback_dimension_score"("dimension_key");

-- CreateIndex
CREATE INDEX "idx_feedback_dimension_score_record_id" ON "feedback_dimension_score"("feedback_record_id");

-- CreateIndex
CREATE UNIQUE INDEX "feedback_dimension_score_feedback_record_id_dimension_key_key" ON "feedback_dimension_score"("feedback_record_id", "dimension_key");

-- AddForeignKey
ALTER TABLE "org_configurations_dashboard" ADD CONSTRAINT "org_configurations_dashboard_organization_id_fkey" FOREIGN KEY ("organization_id") REFERENCES "organization"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "feedback_record" ADD CONSTRAINT "feedback_record_organization_id_fkey" FOREIGN KEY ("organization_id") REFERENCES "organization"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "feedback_embedding" ADD CONSTRAINT "feedback_embedding_feedback_record_id_fkey" FOREIGN KEY ("feedback_record_id") REFERENCES "feedback_record"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "feedback_ml_profile" ADD CONSTRAINT "feedback_ml_profile_feedback_record_id_fkey" FOREIGN KEY ("feedback_record_id") REFERENCES "feedback_record"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "feedback_dimension_score" ADD CONSTRAINT "feedback_dimension_score_feedback_record_id_fkey" FOREIGN KEY ("feedback_record_id") REFERENCES "feedback_record"("id") ON DELETE CASCADE ON UPDATE CASCADE;
