/*
  Warnings:

  - You are about to drop the column `createdAt` on the `Author` table. All the data in the column will be lost.
  - You are about to drop the column `dateOfBirth` on the `Author` table. All the data in the column will be lost.
  - You are about to drop the column `dateOfDeath` on the `Author` table. All the data in the column will be lost.
  - You are about to drop the column `familyName` on the `Author` table. All the data in the column will be lost.
  - You are about to drop the column `firstName` on the `Author` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `Author` table. All the data in the column will be lost.
  - You are about to drop the column `ISBN` on the `Book` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `Book` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `Book` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `Genre` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `Genre` table. All the data in the column will be lost.
  - You are about to drop the `_BookToGenre` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `date_of_birth` to the `Author` table without a default value. This is not possible if the table is not empty.
  - Added the required column `family_name` to the `Author` table without a default value. This is not possible if the table is not empty.
  - Added the required column `first_name` to the `Author` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `Author` table without a default value. This is not possible if the table is not empty.
  - Made the column `url` on table `Author` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `isbn` to the `Book` table without a default value. This is not possible if the table is not empty.
  - Made the column `summary` on table `Book` required. This step will fail if there are existing NULL values in that column.
  - Made the column `url` on table `Book` required. This step will fail if there are existing NULL values in that column.
  - Made the column `url` on table `Genre` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE `_BookToGenre` DROP FOREIGN KEY `_BookToGenre_A_fkey`;

-- DropForeignKey
ALTER TABLE `_BookToGenre` DROP FOREIGN KEY `_BookToGenre_B_fkey`;

-- DropIndex
DROP INDEX `Book_ISBN_key` ON `Book`;

-- DropIndex
DROP INDEX `Genre_name_key` ON `Genre`;

-- AlterTable
ALTER TABLE `Author` DROP COLUMN `createdAt`,
    DROP COLUMN `dateOfBirth`,
    DROP COLUMN `dateOfDeath`,
    DROP COLUMN `familyName`,
    DROP COLUMN `firstName`,
    DROP COLUMN `updatedAt`,
    ADD COLUMN `date_of_birth` DATETIME(3) NOT NULL,
    ADD COLUMN `date_of_death` DATETIME(3) NULL,
    ADD COLUMN `family_name` VARCHAR(191) NOT NULL,
    ADD COLUMN `first_name` VARCHAR(191) NOT NULL,
    ADD COLUMN `lifeSpan` VARCHAR(191) NULL,
    ADD COLUMN `name` VARCHAR(191) NOT NULL,
    MODIFY `url` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `Book` DROP COLUMN `ISBN`,
    DROP COLUMN `createdAt`,
    DROP COLUMN `updatedAt`,
    ADD COLUMN `isbn` VARCHAR(191) NOT NULL,
    MODIFY `summary` VARCHAR(191) NOT NULL,
    MODIFY `url` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `Genre` DROP COLUMN `createdAt`,
    DROP COLUMN `updatedAt`,
    MODIFY `url` VARCHAR(191) NOT NULL;

-- DropTable
DROP TABLE `_BookToGenre`;

-- CreateTable
CREATE TABLE `BookGenreMapping` (
    `bookId` INTEGER NOT NULL,
    `genreId` INTEGER NOT NULL,

    PRIMARY KEY (`bookId`, `genreId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `BookGenreMapping` ADD CONSTRAINT `BookGenreMapping_bookId_fkey` FOREIGN KEY (`bookId`) REFERENCES `Book`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `BookGenreMapping` ADD CONSTRAINT `BookGenreMapping_genreId_fkey` FOREIGN KEY (`genreId`) REFERENCES `Genre`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
