/*
  Warnings:

  - You are about to drop the `Avaliation_range` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `cnae` to the `Skills` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Avaliation_range" DROP CONSTRAINT "Avaliation_range_userId_fkey";

-- AlterTable
ALTER TABLE "Skills" ADD COLUMN     "cnae" TEXT NOT NULL;

-- DropTable
DROP TABLE "Avaliation_range";

-- CreateTable
CREATE TABLE "AvaliationRange" (
    "id" SERIAL NOT NULL,
    "range" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "AvaliationRange_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "AvaliationRange" ADD CONSTRAINT "AvaliationRange_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
