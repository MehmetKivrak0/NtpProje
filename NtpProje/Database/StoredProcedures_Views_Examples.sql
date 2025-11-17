-- =============================================
-- VIEW ÖRNEKLERİ
-- =============================================

-- 1. Proje Detayları View (Teknolojiler ve Resimler ile)
CREATE VIEW vw_ProjectDetails AS
SELECT 
    p.project_id,
    p.project_name,
    p.description,
    p.short_description,
    p.image_url,
    p.thumbnail_url,
    p.project_date,
    p.client_name,
    p.category,
    p.status,
    p.view_count,
    COUNT(DISTINCT pt.project_technology_id) as technology_count,
    COUNT(DISTINCT pi.project_image_id) as image_count,
    STRING_AGG(pt.technology_name, ', ') as technologies
FROM projects p
LEFT JOIN project_technologies pt ON p.project_id = pt.project_id
LEFT JOIN project_images pi ON p.project_id = pi.project_id
WHERE p.is_published = 1
GROUP BY 
    p.project_id, p.project_name, p.description, p.short_description,
    p.image_url, p.thumbnail_url, p.project_date, p.client_name,
    p.category, p.status, p.view_count;

-- Kullanım: SELECT * FROM vw_ProjectDetails WHERE project_id = 1;


-- 2. Blog Yazıları ve Yazar Bilgisi View
CREATE VIEW vw_BlogPostsWithAuthor AS
SELECT 
    p.post_id,
    p.title,
    p.slug,
    p.summary,
    p.content,
    p.image_url,
    p.publish_date,
    p.view_count,
    p.reading_time,
    p.status,
    u.user_id as author_id,
    u.full_name as author_name,
    u.email as author_email,
    c.category_id,
    c.category_name,
    (SELECT COUNT(*) FROM comments WHERE post_id = p.post_id AND is_approved = 1) as comment_count
FROM posts p
INNER JOIN users u ON p.user_id = u.user_id
INNER JOIN categories c ON p.category_id = c.category_id
WHERE p.status = 'Published';

-- Kullanım: SELECT * FROM vw_BlogPostsWithAuthor ORDER BY publish_date DESC;


-- 3. Aktif Projeler İstatistikleri View
CREATE VIEW vw_ActiveProjectsStats AS
SELECT 
    p.project_id,
    p.project_name,
    p.category,
    p.view_count,
    p.project_date,
    COUNT(DISTINCT pt.project_technology_id) as technology_count,
    COUNT(DISTINCT pi.project_image_id) as image_count,
    CASE 
        WHEN p.completion_date IS NOT NULL THEN 'Tamamlandı'
        ELSE 'Devam Ediyor'
    END as project_status
FROM projects p
LEFT JOIN project_technologies pt ON p.project_id = pt.project_id
LEFT JOIN project_images pi ON p.project_id = pi.project_id
WHERE p.is_published = 1 AND p.status = 'Active'
GROUP BY 
    p.project_id, p.project_name, p.category, 
    p.view_count, p.project_date, p.completion_date;

-- Kullanım: SELECT * FROM vw_ActiveProjectsStats ORDER BY view_count DESC;


-- 4. Yayınlanmış Blog Yazıları View (Kategoriler ile)
CREATE VIEW vw_PublishedBlogPosts AS
SELECT 
    p.post_id,
    p.title,
    p.slug,
    p.summary,
    p.image_url,
    p.publish_date,
    p.view_count,
    c.category_name,
    u.full_name as author_name,
    (SELECT COUNT(*) FROM comments cm WHERE cm.post_id = p.post_id AND cm.is_approved = 1) as approved_comments
FROM posts p
INNER JOIN categories c ON p.category_id = c.category_id
INNER JOIN users u ON p.user_id = u.user_id
WHERE p.status = 'Published'
ORDER BY p.publish_date DESC;

-- Kullanım: SELECT * FROM vw_PublishedBlogPosts;


-- =============================================
-- STORED PROCEDURE ÖRNEKLERİ
-- =============================================

-- 1. Kullanıcı Girişi Stored Procedure
CREATE PROCEDURE sp_UserLogin
    @Email NVARCHAR(100),
    @Password NVARCHAR(255),
    @UserId INT OUTPUT,
    @FullName NVARCHAR(100) OUTPUT,
    @Role NVARCHAR(50) OUTPUT,
    @Success BIT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        @UserId = user_id,
        @FullName = full_name,
        @Role = role
    FROM users
    WHERE email = @Email 
      AND password = @Password 
      AND is_active = 1;
    
    IF @UserId IS NOT NULL
    BEGIN
        -- Son giriş tarihini güncelle
        UPDATE users 
        SET last_login_date = GETDATE()
        WHERE user_id = @UserId;
        
        SET @Success = 1;
    END
    ELSE
    BEGIN
        SET @Success = 0;
        SET @UserId = NULL;
        SET @FullName = NULL;
        SET @Role = NULL;
    END
END

-- Kullanım:
-- DECLARE @UserId INT, @FullName NVARCHAR(100), @Role NVARCHAR(50), @Success BIT
-- EXEC sp_UserLogin 'ahmet@email.com', 'sifre123', @UserId OUTPUT, @FullName OUTPUT, @Role OUTPUT, @Success OUTPUT
-- SELECT @UserId, @FullName, @Role, @Success


-- 2. Proje Oluşturma Stored Procedure (Transaction ile)
CREATE PROCEDURE sp_CreateProject
    @ProjectName NVARCHAR(200),
    @Description NVARCHAR(MAX),
    @ShortDescription NVARCHAR(500),
    @Category NVARCHAR(100),
    @ClientName NVARCHAR(100),
    @Technologies NVARCHAR(MAX), -- Virgülle ayrılmış teknoloji isimleri
    @ProjectId INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRANSACTION;
    BEGIN TRY
        -- Proje oluştur
        INSERT INTO projects (
            project_name, 
            description, 
            short_description,
            category,
            client_name,
            project_date,
            status,
            is_published,
            created_date
        )
        VALUES (
            @ProjectName,
            @Description,
            @ShortDescription,
            @Category,
            @ClientName,
            GETDATE(),
            'Active',
            1,
            GETDATE()
        );
        
        SET @ProjectId = SCOPE_IDENTITY();
        
        -- Teknolojileri ekle (virgülle ayrılmış string'i parse et)
        IF @Technologies IS NOT NULL AND LEN(@Technologies) > 0
        BEGIN
            DECLARE @TechName NVARCHAR(100);
            DECLARE @TechList TABLE (TechName NVARCHAR(100));
            
            -- Virgülle ayrılmış teknolojileri tabloya ekle
            INSERT INTO @TechList (TechName)
            SELECT value FROM STRING_SPLIT(@Technologies, ',');
            
            -- Her teknolojiyi projeye ekle
            DECLARE tech_cursor CURSOR FOR
            SELECT TechName FROM @TechList;
            
            OPEN tech_cursor;
            FETCH NEXT FROM tech_cursor INTO @TechName;
            
            WHILE @@FETCH_STATUS = 0
            BEGIN
                INSERT INTO project_technologies (project_id, technology_name, display_order)
                VALUES (@ProjectId, LTRIM(RTRIM(@TechName)), 0);
                
                FETCH NEXT FROM tech_cursor INTO @TechName;
            END;
            
            CLOSE tech_cursor;
            DEALLOCATE tech_cursor;
        END;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END

-- Kullanım:
-- DECLARE @ProjectId INT
-- EXEC sp_CreateProject 
--     'Yeni Proje', 
--     'Proje açıklaması', 
--     'Kısa açıklama',
--     'Web',
--     'Müşteri Adı',
--     'ASP.NET, SQL Server, JavaScript',
--     @ProjectId OUTPUT
-- SELECT @ProjectId


-- 3. Blog Yazısı Görüntülenme Sayısını Artır
CREATE PROCEDURE sp_IncrementPostViewCount
    @PostId INT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE posts
    SET view_count = view_count + 1
    WHERE post_id = @PostId;
    
    SELECT view_count FROM posts WHERE post_id = @PostId;
END

-- Kullanım: EXEC sp_IncrementPostViewCount 1


-- 4. Aylık İstatistik Raporu
CREATE PROCEDURE sp_GetMonthlyStatistics
    @StartDate DATETIME,
    @EndDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        'Blog Posts' as content_type,
        COUNT(*) as total_count,
        SUM(CASE WHEN status = 'Published' THEN 1 ELSE 0 END) as published_count
    FROM posts
    WHERE created_date BETWEEN @StartDate AND @EndDate
    
    UNION ALL
    
    SELECT 
        'Projects' as content_type,
        COUNT(*) as total_count,
        SUM(CASE WHEN is_published = 1 THEN 1 ELSE 0 END) as published_count
    FROM projects
    WHERE created_date BETWEEN @StartDate AND @EndDate
    
    UNION ALL
    
    SELECT 
        'Comments' as content_type,
        COUNT(*) as total_count,
        SUM(CASE WHEN is_approved = 1 THEN 1 ELSE 0 END) as published_count
    FROM comments
    WHERE comment_date BETWEEN @StartDate AND @EndDate
    
    UNION ALL
    
    SELECT 
        'Contact Messages' as content_type,
        COUNT(*) as total_count,
        SUM(CASE WHEN is_read = 1 THEN 1 ELSE 0 END) as published_count
    FROM contact_messages
    WHERE created_date BETWEEN @StartDate AND @EndDate;
END

-- Kullanım: EXEC sp_GetMonthlyStatistics '2024-01-01', '2024-01-31'


-- 5. En Popüler İçerikleri Getir
CREATE PROCEDURE sp_GetPopularContent
    @ContentType NVARCHAR(50), -- 'Posts' veya 'Projects'
    @TopCount INT = 10
AS
BEGIN
    SET NOCOUNT ON;
    
    IF @ContentType = 'Posts'
    BEGIN
        SELECT TOP (@TopCount)
            post_id as id,
            title as name,
            view_count,
            publish_date as date
        FROM posts
        WHERE status = 'Published'
        ORDER BY view_count DESC, publish_date DESC;
    END
    ELSE IF @ContentType = 'Projects'
    BEGIN
        SELECT TOP (@TopCount)
            project_id as id,
            project_name as name,
            view_count,
            project_date as date
        FROM projects
        WHERE is_published = 1 AND status = 'Active'
        ORDER BY view_count DESC, project_date DESC;
    END
END

-- Kullanım: EXEC sp_GetPopularContent 'Posts', 5


-- 6. Kullanıcı Kayıt Stored Procedure
CREATE PROCEDURE sp_RegisterUser
    @FullName NVARCHAR(100),
    @Email NVARCHAR(100),
    @PhoneNumber NVARCHAR(20),
    @Password NVARCHAR(255),
    @UserId INT OUTPUT,
    @Success BIT OUTPUT,
    @Message NVARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Email kontrolü
    IF EXISTS (SELECT 1 FROM users WHERE email = @Email)
    BEGIN
        SET @Success = 0;
        SET @Message = 'Bu email adresi zaten kullanılıyor!';
        SET @UserId = NULL;
        RETURN;
    END;
    
    -- Kullanıcı oluştur
    BEGIN TRY
        INSERT INTO users (
            full_name,
            email,
            phone_number,
            password,
            role,
            is_active,
            created_date
        )
        VALUES (
            @FullName,
            @Email,
            @PhoneNumber,
            @Password,
            'User',
            1,
            GETDATE()
        );
        
        SET @UserId = SCOPE_IDENTITY();
        SET @Success = 1;
        SET @Message = 'Kayıt başarılı!';
    END TRY
    BEGIN CATCH
        SET @Success = 0;
        SET @Message = 'Kayıt sırasında hata oluştu: ' + ERROR_MESSAGE();
        SET @UserId = NULL;
    END CATCH
END

-- Kullanım:
-- DECLARE @UserId INT, @Success BIT, @Message NVARCHAR(200)
-- EXEC sp_RegisterUser 
--     'Ahmet Yılmaz', 
--     'ahmet@email.com', 
--     '0555 123 45 67',
--     'sifre123',
--     @UserId OUTPUT, 
--     @Success OUTPUT, 
--     @Message OUTPUT
-- SELECT @UserId, @Success, @Message


