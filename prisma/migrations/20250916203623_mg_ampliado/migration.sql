/*
  Warnings:

  - You are about to drop the column `userId` on the `AvaliationRange` table. All the data in the column will be lost.
  - You are about to drop the column `authorId` on the `Feedback` table. All the data in the column will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `UserFollower` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `updatedAt` to the `AvaliationRange` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userIdCustomer` to the `AvaliationRange` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userIdService` to the `AvaliationRange` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userIdCustomer` to the `Feedback` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userIdService` to the `Feedback` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "AvaliationRange" DROP CONSTRAINT "AvaliationRange_userId_fkey";

-- DropForeignKey
ALTER TABLE "Feedback" DROP CONSTRAINT "Feedback_authorId_fkey";

-- DropForeignKey
ALTER TABLE "Skills" DROP CONSTRAINT "Skills_userId_fkey";

-- DropForeignKey
ALTER TABLE "UserFollower" DROP CONSTRAINT "UserFollower_followerId_fkey";

-- DropForeignKey
ALTER TABLE "UserFollower" DROP CONSTRAINT "UserFollower_followingId_fkey";

-- AlterTable
ALTER TABLE "AvaliationRange" DROP COLUMN "userId",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "userIdCustomer" INTEGER NOT NULL,
ADD COLUMN     "userIdService" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Feedback" DROP COLUMN "authorId",
ADD COLUMN     "userIdCustomer" INTEGER NOT NULL,
ADD COLUMN     "userIdService" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Skills" ALTER COLUMN "cnae" DROP NOT NULL;

-- DropTable
DROP TABLE "User";

-- DropTable
DROP TABLE "UserFollower";

-- CreateTable
CREATE TABLE "UserService" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "password" TEXT,
    "googleId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "location" JSONB,

    CONSTRAINT "UserService_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserCustomer" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "password" TEXT,
    "googleId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UserCustomer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserServiceData" (
    "id" SERIAL NOT NULL,
    "cnpj" TEXT,
    "cpf" TEXT,
    "phone" TEXT,
    "address" TEXT,
    "city" TEXT,
    "state" TEXT,
    "zip" TEXT,
    "district" TEXT,
    "country" TEXT,
    "website" TEXT,
    "companyName" TEXT,
    "email" TEXT,
    "description" TEXT,
    "userId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UserServiceData_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TrainingCourses" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "institution" TEXT NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3),
    "certificateUrl" TEXT,
    "userId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "TrainingCourses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Ratings" (
    "id" SERIAL NOT NULL,
    "score" INTEGER NOT NULL,
    "comment" TEXT,
    "userIdService" INTEGER NOT NULL,
    "userIdCustomer" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Ratings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Payments" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "status" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Payments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ServiceExecution" (
    "id" SERIAL NOT NULL,
    "serviceName" TEXT NOT NULL,
    "description" TEXT,
    "userIdService" INTEGER NOT NULL,
    "userIdCustomer" INTEGER NOT NULL,
    "status" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "executionDate" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ServiceExecution_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_SkillsToUserCustomer" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_SkillsToUserCustomer_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE UNIQUE INDEX "UserService_email_key" ON "UserService"("email");

-- CreateIndex
CREATE UNIQUE INDEX "UserService_googleId_key" ON "UserService"("googleId");

-- CreateIndex
CREATE UNIQUE INDEX "UserCustomer_email_key" ON "UserCustomer"("email");

-- CreateIndex
CREATE UNIQUE INDEX "UserCustomer_googleId_key" ON "UserCustomer"("googleId");

-- CreateIndex
CREATE UNIQUE INDEX "UserServiceData_cnpj_key" ON "UserServiceData"("cnpj");

-- CreateIndex
CREATE UNIQUE INDEX "UserServiceData_cpf_key" ON "UserServiceData"("cpf");

-- CreateIndex
CREATE UNIQUE INDEX "UserServiceData_userId_key" ON "UserServiceData"("userId");

-- CreateIndex
CREATE INDEX "_SkillsToUserCustomer_B_index" ON "_SkillsToUserCustomer"("B");

-- AddForeignKey
ALTER TABLE "Feedback" ADD CONSTRAINT "Feedback_userIdService_fkey" FOREIGN KEY ("userIdService") REFERENCES "UserService"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Feedback" ADD CONSTRAINT "Feedback_userIdCustomer_fkey" FOREIGN KEY ("userIdCustomer") REFERENCES "UserCustomer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Skills" ADD CONSTRAINT "Skills_userId_fkey" FOREIGN KEY ("userId") REFERENCES "UserService"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserServiceData" ADD CONSTRAINT "UserServiceData_userId_fkey" FOREIGN KEY ("userId") REFERENCES "UserService"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TrainingCourses" ADD CONSTRAINT "TrainingCourses_userId_fkey" FOREIGN KEY ("userId") REFERENCES "UserService"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AvaliationRange" ADD CONSTRAINT "AvaliationRange_userIdService_fkey" FOREIGN KEY ("userIdService") REFERENCES "UserService"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AvaliationRange" ADD CONSTRAINT "AvaliationRange_userIdCustomer_fkey" FOREIGN KEY ("userIdCustomer") REFERENCES "UserCustomer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ratings" ADD CONSTRAINT "Ratings_userIdService_fkey" FOREIGN KEY ("userIdService") REFERENCES "UserService"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ratings" ADD CONSTRAINT "Ratings_userIdCustomer_fkey" FOREIGN KEY ("userIdCustomer") REFERENCES "UserCustomer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Payments" ADD CONSTRAINT "Payments_userIdService_fkey" FOREIGN KEY ("userId") REFERENCES "UserService"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Payments" ADD CONSTRAINT "Payments_userIdCustomer_fkey" FOREIGN KEY ("userId") REFERENCES "UserCustomer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ServiceExecution" ADD CONSTRAINT "ServiceExecution_userIdService_fkey" FOREIGN KEY ("userIdService") REFERENCES "UserService"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ServiceExecution" ADD CONSTRAINT "ServiceExecution_userIdCustomer_fkey" FOREIGN KEY ("userIdCustomer") REFERENCES "UserCustomer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_SkillsToUserCustomer" ADD CONSTRAINT "_SkillsToUserCustomer_A_fkey" FOREIGN KEY ("A") REFERENCES "Skills"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_SkillsToUserCustomer" ADD CONSTRAINT "_SkillsToUserCustomer_B_fkey" FOREIGN KEY ("B") REFERENCES "UserCustomer"("id") ON DELETE CASCADE ON UPDATE CASCADE;
