-- CreateEnum
CREATE TYPE "LauncherStyle" AS ENUM ('BUBBLE', 'PILL', 'BADGE_AVATAR');

-- CreateEnum
CREATE TYPE "LauncherPosition" AS ENUM ('BOTTOM_RIGHT', 'BOTTOM_LEFT', 'BOTTOM_CENTER');

-- AlterTable
ALTER TABLE "agent" ADD COLUMN     "avatarEmoji" TEXT DEFAULT '🍷',
ADD COLUMN     "avatarUrl" TEXT,
ADD COLUMN     "botName" TEXT,
ADD COLUMN     "launcherOffsetX" INTEGER NOT NULL DEFAULT 20,
ADD COLUMN     "launcherOffsetY" INTEGER NOT NULL DEFAULT 20,
ADD COLUMN     "launcherPosition" "LauncherPosition" NOT NULL DEFAULT 'BOTTOM_RIGHT',
ADD COLUMN     "launcherStyle" "LauncherStyle" NOT NULL DEFAULT 'BUBBLE',
ADD COLUMN     "onboardingEnabled" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "suggestionChips" JSONB,
ADD COLUMN     "teaserDelaySec" INTEGER NOT NULL DEFAULT 15,
ADD COLUMN     "teaserEnabled" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "teaserText" TEXT,
ADD COLUMN     "welcomeMessage" TEXT;
