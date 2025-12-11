-- =============================================
-- VIEW OLUŞTURMA - vw_ProjectDetails
-- =============================================
-- Bu View, proje detaylarını projects tablosundan getirir
-- Veritabanında çalıştırmanız gereken SQL script'i
-- Sadece mevcut tabloları kullanır (project_technologies ve project_images YOK)

-- ÖNCE: Eğer View zaten varsa sil
IF EXISTS (SELECT * FROM sys.views WHERE name = 'vw_ProjectDetails')
    DROP VIEW vw_ProjectDetails;
GO

-- VIEW OLUŞTUR (Sadece projects tablosunu kullanarak)
CREATE VIEW vw_ProjectDetails AS
SELECT 
    project_id,
    project_name,
    description,
    short_description,
    image_url,
    thumbnail_url,
    project_date,
    completion_date,
    client_name,
    category,
    status,
    view_count,
    is_published,
    created_date,
    updated_date,
    -- Teknoloji bilgisi için short_description kullanıyoruz (projects tablosunda zaten var)
    short_description as technologies,
    -- Teknoloji sayısı: short_description'da virgül varsa sayısını hesapla, yoksa 0
    CASE 
        WHEN short_description IS NOT NULL AND LEN(short_description) > 0 THEN
            (LEN(short_description) - LEN(REPLACE(short_description, ',', '')) + 1)
        ELSE 0
    END as technology_count,
    -- Resim sayısı: thumbnail_url varsa 1, image_url varsa +1, toplam max 2
    CASE 
        WHEN thumbnail_url IS NOT NULL AND image_url IS NOT NULL THEN 2
        WHEN thumbnail_url IS NOT NULL OR image_url IS NOT NULL THEN 1
        ELSE 0
    END as image_count
FROM projects
WHERE is_published = 1;

GO

-- TEST: View'ın çalışıp çalışmadığını kontrol et
-- SELECT * FROM vw_ProjectDetails;

