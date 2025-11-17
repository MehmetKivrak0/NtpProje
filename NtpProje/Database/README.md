# NtpProje Veritabanı Kurulum Kılavuzu

## 📋 İçindekiler
- [Kurulum](#kurulum)
- [Tablolar](#tablolar)
- [Başlangıç Verileri](#başlangıç-verileri)
- [Notlar](#notlar)

---

## 🚀 Kurulum

### Adım 1: Veritabanını Oluştur
```sql
CREATE DATABASE NtpProjeDB;
GO
```

### Adım 2: SQL Script'i Çalıştır
1. SQL Server Management Studio (SSMS) açın
2. `NtpProjeDB_CreateTables.sql` dosyasını açın
3. Tüm script'i seçin ve çalıştırın (F5)

**VEYA**

Komut satırından:
```bash
sqlcmd -S localhost -d NtpProjeDB -i NtpProjeDB_CreateTables.sql
```

---

## 📊 Tablolar

### 1. **Users** - Kullanıcılar
- Admin ve normal kullanıcılar
- Email unique constraint var

### 2. **Categories** - Kategoriler
- Blog yazıları için kategoriler
- Slug unique constraint var

### 3. **Posts** - Blog Yazıları
- Blog içerikleri
- Users ve Categories ile ilişkili

### 4. **PostCategories** - Blog Kategorileri (Çoklu)
- Bir blog yazısı birden fazla kategoriye ait olabilir

### 5. **Comments** - Yorumlar
- Blog yazılarına yorumlar
- Yanıt (reply) desteği var (ParentCommentId)

### 6. **Projects** - Projeler
- Tamamlanan projeler
- Kategori, durum, yayın durumu bilgileri

### 7. **ProjectTechnologies** - Proje Teknolojileri
- Her projeye ait teknolojiler (ASP.NET, React, vb.)

### 8. **ProjectImages** - Proje Görselleri
- Proje galeri görselleri
- Ana görsel işaretleme (IsMain)

### 9. **Services** - Hizmetler
- Sunulan hizmetler (Web Geliştirme, Mobil, vb.)
- Icon ve açıklama bilgileri

### 10. **ServiceFeatures** - Hizmet Özellikleri
- Her hizmete ait özellikler

### 11. **TeamMembers** - Ekip Üyeleri
- Ekip bilgileri
- Sosyal medya linkleri

### 12. **ContactMessages** - İletişim Mesajları
- İletişim formundan gelen mesajlar
- Okundu/yanıtlandı durumu

### 13. **ProjectRequests** - Proje Teklifleri
- Proje teklif formundan gelen talepler
- Durum takibi (New, InReview, Quoted, vb.)

### 14. **Statistics** - İstatistikler
- Site istatistikleri (150+ Proje, 200+ Müşteri, vb.)

### 15. **Settings** - Ayarlar
- Site ayarları (Site adı, e-posta, telefon, vb.)

---

## 🌱 Başlangıç Verileri

Script çalıştırıldığında otomatik olarak eklenen veriler:

### Admin Kullanıcı
- **Email:** admin@gencbirey.com
- **Password:** admin123
- **Role:** Admin

### Kategoriler
- .NET
- Web Development
- Mobile Development
- Architecture
- DevOps
- AI
- Security
- Best Practices

### İstatistikler
- Tamamlanan Proje: 150+
- Mutlu Müşteri: 200+
- Müşteri Memnuniyeti: 95%
- Yıl Deneyim: 10+
- Ekip Üyesi: 50+
- Senior Developer: 15+
- Sertifikasyon: 20+
- Motivasyon: 100%

### Hizmetler
- Web Geliştirme
- Mobil Uygulama Geliştirme
- ERP Yazılımları
- E-Ticaret Çözümleri
- Özel Yazılım Geliştirme
- Cloud Çözümleri
- Yapay Zeka Entegrasyonu
- Yazılım Danışmanlığı

### Ayarlar
- SiteName: Genç Birey Yazılım
- SiteEmail: info@gencbirey.com
- SitePhone: +90 232 464 1 184
- SiteAddress: Kıbrıs Şehitleri Cd. No:48 K:6 - 601 / Alsancak - İzmir
- WorkingHours: Pazartesi - Cuma: 09:00 - 18:00

---

## ⚠️ Notlar

### 1. Şifre Güvenliği
**ÖNEMLİ:** Admin şifresini mutlaka değiştirin!
```sql
UPDATE Users 
SET Password = 'YENİ_ŞİFRELENMİŞ_ŞİFRE' 
WHERE Email = 'admin@gencbirey.com'
```

### 2. Connection String
Web.config dosyasında connection string'i kontrol edin:
```xml
<connectionStrings>
    <add name="NtpProjeDBConnectionString" 
         connectionString="Data Source=.;Initial Catalog=NtpProjeDB;Integrated Security=True;Trust Server Certificate=True" 
         providerName="System.Data.SqlClient" />
</connectionStrings>
```

### 3. Foreign Key İlişkileri
- Posts → Users (UserId)
- Posts → Categories (CategoryId)
- Comments → Posts (PostId)
- Comments → Users (UserId) - NULL olabilir
- ProjectTechnologies → Projects (ProjectId)
- ProjectImages → Projects (ProjectId)
- ServiceFeatures → Services (ServiceId)
- PostCategories → Posts (PostId)
- PostCategories → Categories (CategoryId)

### 4. Index'ler
Performans için önemli alanlarda index'ler oluşturuldu:
- Posts: Status, PublishDate, Slug
- Projects: IsPublished, Status, Slug
- ContactMessages: IsRead, CreatedDate
- ProjectRequests: Status, CreatedDate

### 5. Cascade Delete
Bazı ilişkilerde CASCADE DELETE aktif:
- PostCategories → Posts silinince kategoriler de silinir
- ProjectTechnologies → Project silinince teknolojiler de silinir
- ProjectImages → Project silinince görseller de silinir
- ServiceFeatures → Service silinince özellikler de silinir

---

## 🔧 Sorun Giderme

### Tablo zaten var hatası
Script IF NOT EXISTS kontrolü yapıyor, güvenle çalıştırabilirsiniz.

### Foreign key hatası
Önce ana tabloları (Users, Categories) oluşturduğundan emin olun.

### Index hatası
Index'ler de IF NOT EXISTS kontrolü yapıyor.

---

## 📝 Sonraki Adımlar

1. ✅ Veritabanı oluşturuldu
2. ⏳ DAL (Data Access Layer) sınıflarını doldur
3. ⏳ BLL (Business Logic Layer) sınıflarını doldur
4. ⏳ Sayfalarda Service kullanımına geç

---

**Oluşturulma Tarihi:** 2025
**Veritabanı Versiyonu:** 1.0


