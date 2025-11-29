-- =============================================
-- Kullanılmayan Tabloları Kaldırma Scripti
-- =============================================
-- Bu script, kodda kullanılmayan 4 tabloyu veritabanından kaldırır:
-- 1. post_categories
-- 2. project_images
-- 3. project_technologies
-- 4. service_features
-- =============================================

USE NtpProjeDB;
GO

-- Kullanılmayan tabloları kaldır
DROP TABLE IF EXISTS dbo.post_categories;
DROP TABLE IF EXISTS dbo.project_images;
DROP TABLE IF EXISTS dbo.project_technologies;
DROP TABLE IF EXISTS dbo.service_features;
GO
