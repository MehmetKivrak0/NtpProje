# Stored Procedure ve View - Ne İşe Yarar?

## 🎯 Temel Amaç

**Stored Procedure (SP)** ve **View**, veritabanında **hazır sorgular** saklamanızı sağlar. Karmaşık SQL sorgularını tekrar tekrar yazmak yerine, bir kez yazıp çağırırsınız.

---

## 📊 VIEW (Görünüm) - Ne İşe Yarar?

### Basit Açıklama:
**View = Sanal Tablo** - Birden fazla tablodan veri çekip tek bir tablo gibi gösterir.

### Örnek Senaryo:

#### ❌ View Olmadan:
```sql
-- Her seferinde bu uzun sorguyu yazmanız gerekir:
SELECT 
    p.project_id,
    p.project_name,
    p.description,
    COUNT(pt.technology_id) as teknoloji_sayisi,
    COUNT(pi.image_id) as resim_sayisi,
    u.full_name as olusturan_kullanici
FROM projects p
LEFT JOIN project_technologies pt ON p.project_id = pt.project_id
LEFT JOIN project_images pi ON p.project_id = pi.project_id
LEFT JOIN users u ON p.user_id = u.user_id
WHERE p.is_published = 1
GROUP BY p.project_id, p.project_name, p.description, u.full_name
```

#### ✅ View ile:
```sql
-- View oluştur:
CREATE VIEW vw_ProjectDetails AS
SELECT 
    p.project_id,
    p.project_name,
    p.description,
    COUNT(pt.technology_id) as teknoloji_sayisi,
    COUNT(pi.image_id) as resim_sayisi,
    u.full_name as olusturan_kullanici
FROM projects p
LEFT JOIN project_technologies pt ON p.project_id = pt.project_id
LEFT JOIN project_images pi ON p.project_id = pi.project_id
LEFT JOIN users u ON p.user_id = u.user_id
WHERE p.is_published = 1
GROUP BY p.project_id, p.project_name, p.description, u.full_name;

-- Artık sadece şunu yazarsınız:
SELECT * FROM vw_ProjectDetails;
```

### View Kullanım Senaryoları:

1. **Karmaşık JOIN'leri Basitleştirme**
   ```sql
   -- View: vw_BlogPostsWithAuthor
   SELECT * FROM vw_BlogPostsWithAuthor;
   ```

2. **Güvenlik (Sadece Gerekli Kolonları Gösterme)**
   ```sql
   -- View: vw_PublicUserInfo (şifre göstermez)
   SELECT * FROM vw_PublicUserInfo;
   ```

3. **Raporlama İçin Hazır Veri**
   ```sql
   -- View: vw_MonthlyStatistics
   SELECT * FROM vw_MonthlyStatistics WHERE month = '2024-01';
   ```

---

## ⚙️ STORED PROCEDURE (SP) - Ne İşe Yarar?

### Basit Açıklama:
**Stored Procedure = Veritabanında Saklanan Fonksiyon** - Karmaşık işlemleri tek komutla yapar.

### Örnek Senaryo:

#### ❌ SP Olmadan (C# Kodunda):
```csharp
// Her seferinde bu kodu yazmanız gerekir:
using (var db = new DataContext())
{
    var user = db.Users.FirstOrDefault(u => u.Email == email);
    if (user != null)
    {
        user.LastLoginDate = DateTime.Now;
        user.FailedLoginAttempts = 0;
        db.SubmitChanges();
    }
    else
    {
        // Hatalı giriş sayısını artır
        var failedUser = db.Users.FirstOrDefault(u => u.Email == email);
        if (failedUser != null)
        {
            failedUser.FailedLoginAttempts++;
            db.SubmitChanges();
        }
    }
}
```

#### ✅ SP ile:
```sql
-- Stored Procedure oluştur:
CREATE PROCEDURE sp_UserLogin
    @Email NVARCHAR(100),
    @Password NVARCHAR(255),
    @Success BIT OUTPUT
AS
BEGIN
    DECLARE @UserId INT
    
    SELECT @UserId = user_id 
    FROM users 
    WHERE email = @Email AND password = @Password AND is_active = 1
    
    IF @UserId IS NOT NULL
    BEGIN
        -- Başarılı giriş
        UPDATE users 
        SET last_login_date = GETDATE(), 
            failed_login_attempts = 0
        WHERE user_id = @UserId
        
        SET @Success = 1
    END
    ELSE
    BEGIN
        -- Hatalı giriş
        UPDATE users 
        SET failed_login_attempts = failed_login_attempts + 1
        WHERE email = @Email
        
        SET @Success = 0
    END
END

-- C# Kodunda sadece:
using (var cmd = new SqlCommand("sp_UserLogin", connection))
{
    cmd.CommandType = CommandType.StoredProcedure;
    cmd.Parameters.AddWithValue("@Email", email);
    cmd.Parameters.AddWithValue("@Password", password);
    cmd.Parameters.Add("@Success", SqlDbType.Bit).Direction = ParameterDirection.Output;
    cmd.ExecuteNonQuery();
    bool success = (bool)cmd.Parameters["@Success"].Value;
}
```

### Stored Procedure Kullanım Senaryoları:

1. **Karmaşık İşlemler (Transaction)**
   ```sql
   -- SP: sp_CreateProjectWithTechnologies
   -- Proje oluştur + Teknolojileri ekle + Resimleri ekle
   -- Hepsi tek işlemde (ya hepsi ya hiçbiri)
   ```

2. **Performans Optimizasyonu**
   ```sql
   -- SP: sp_GetPopularProjects
   -- Karmaşık hesaplamaları veritabanında yapar (daha hızlı)
   ```

3. **Güvenlik (SQL Injection Koruması)**
   ```sql
   -- SP: sp_GetUserByEmail
   -- Parametreli sorgu (güvenli)
   ```

4. **Raporlama**
   ```sql
   -- SP: sp_GetMonthlyReport
   -- Karmaşık rapor sorguları
   ```

---

## 🔄 View vs Stored Procedure

| Özellik | VIEW | STORED PROCEDURE |
|---------|------|------------------|
| **Ne Yapar?** | Veri gösterir (SELECT) | İşlem yapar (INSERT/UPDATE/DELETE) |
| **Parametre** | ❌ Yok | ✅ Var |
| **Karmaşık İşlem** | ❌ Sadece SELECT | ✅ Her şeyi yapabilir |
| **Kullanım** | `SELECT * FROM vw_Projects` | `EXEC sp_GetProjects` |

---

## 💡 Projenizde Pratik Örnekler

### 1. VIEW Örnekleri:

#### a) Blog Yazıları ve Yazar Bilgisi
```sql
CREATE VIEW vw_BlogPostsWithAuthor AS
SELECT 
    p.post_id,
    p.title,
    p.content,
    p.publish_date,
    u.full_name as author_name,
    u.email as author_email,
    c.category_name,
    (SELECT COUNT(*) FROM comments WHERE post_id = p.post_id) as comment_count
FROM posts p
INNER JOIN users u ON p.user_id = u.user_id
INNER JOIN categories c ON p.category_id = c.category_id
WHERE p.status = 'Published';

-- Kullanım:
SELECT * FROM vw_BlogPostsWithAuthor;
```

#### b) Proje İstatistikleri
```sql
CREATE VIEW vw_ProjectStatistics AS
SELECT 
    p.project_id,
    p.project_name,
    COUNT(DISTINCT pt.technology_id) as technology_count,
    COUNT(DISTINCT pi.image_id) as image_count,
    p.view_count,
    p.created_date
FROM projects p
LEFT JOIN project_technologies pt ON p.project_id = pt.project_id
LEFT JOIN project_images pi ON p.project_id = pi.project_id
GROUP BY p.project_id, p.project_name, p.view_count, p.created_date;

-- Kullanım:
SELECT * FROM vw_ProjectStatistics WHERE view_count > 100;
```

### 2. STORED PROCEDURE Örnekleri:

#### a) Kullanıcı Girişi
```sql
CREATE PROCEDURE sp_UserLogin
    @Email NVARCHAR(100),
    @Password NVARCHAR(255),
    @UserId INT OUTPUT,
    @Success BIT OUTPUT
AS
BEGIN
    SELECT @UserId = user_id 
    FROM users 
    WHERE email = @Email 
      AND password = @Password 
      AND is_active = 1
    
    IF @UserId IS NOT NULL
    BEGIN
        UPDATE users 
        SET last_login_date = GETDATE()
        WHERE user_id = @UserId
        
        SET @Success = 1
    END
    ELSE
    BEGIN
        SET @Success = 0
    END
END

-- Kullanım:
DECLARE @UserId INT, @Success BIT
EXEC sp_UserLogin 'ahmet@email.com', 'sifre123', @UserId OUTPUT, @Success OUTPUT
```

#### b) Proje Oluşturma (Transaction ile)
```sql
CREATE PROCEDURE sp_CreateProject
    @ProjectName NVARCHAR(200),
    @Description NVARCHAR(MAX),
    @Technologies NVARCHAR(MAX), -- JSON veya virgülle ayrılmış
    @ProjectId INT OUTPUT
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
        -- Proje oluştur
        INSERT INTO projects (project_name, description, created_date)
        VALUES (@ProjectName, @Description, GETDATE())
        
        SET @ProjectId = SCOPE_IDENTITY()
        
        -- Teknolojileri ekle (örnek: virgülle ayrılmış)
        -- Burada teknoloji parsing işlemi yapılır
        
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        THROW
    END CATCH
END
```

#### c) Raporlama
```sql
CREATE PROCEDURE sp_GetMonthlyReport
    @StartDate DATETIME,
    @EndDate DATETIME
AS
BEGIN
    SELECT 
        'Blog Posts' as content_type,
        COUNT(*) as count
    FROM posts
    WHERE created_date BETWEEN @StartDate AND @EndDate
    
    UNION ALL
    
    SELECT 
        'Projects' as content_type,
        COUNT(*) as count
    FROM projects
    WHERE created_date BETWEEN @StartDate AND @EndDate
    
    UNION ALL
    
    SELECT 
        'Comments' as content_type,
        COUNT(*) as count
    FROM comments
    WHERE comment_date BETWEEN @StartDate AND @EndDate
END

-- Kullanım:
EXEC sp_GetMonthlyReport '2024-01-01', '2024-01-31'
```

---

## ✅ Avantajları

### View Avantajları:
1. **Kod Tekrarını Önler** - Uzun sorguları tekrar yazmazsınız
2. **Basitlik** - Karmaşık JOIN'leri basitleştirir
3. **Güvenlik** - Sadece gerekli kolonları gösterir
4. **Performans** - Veritabanı optimize eder

### Stored Procedure Avantajları:
1. **Performans** - Veritabanında çalışır (daha hızlı)
2. **Güvenlik** - SQL Injection koruması
3. **Transaction** - Atomik işlemler (ya hepsi ya hiçbiri)
4. **Merkezi Yönetim** - Tüm iş mantığı tek yerde

---

## 🎓 Özet

### VIEW:
- **Ne:** Sanal tablo (sadece SELECT)
- **Ne Zaman:** Karmaşık sorguları basitleştirmek için
- **Örnek:** `SELECT * FROM vw_ProjectDetails`

### STORED PROCEDURE:
- **Ne:** Veritabanında saklanan fonksiyon
- **Ne Zaman:** Karmaşık işlemler, transaction, raporlama için
- **Örnek:** `EXEC sp_UserLogin @Email, @Password`

**Her ikisi de kod tekrarını önler ve performansı artırır!**


