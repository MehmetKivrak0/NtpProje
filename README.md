# NtpProje - Kurumsal Web Sitesi ve Yönetim Paneli

## 📋 Proje Hakkında

**NtpProje**, modern web teknolojileri kullanılarak geliştirilmiş, kurumsal bir web sitesi ve yönetim paneli sistemidir. Proje, ASP.NET Web Forms teknolojisi ile geliştirilmiş olup, katmanlı mimari yapısı, design pattern'ler ve profesyonel yazılım geliştirme pratikleri kullanılmıştır.

### 🎯 Proje Amacı

- Kurumsal web sitesi yönetimi
- İçerik yönetim sistemi (CMS)
- Blog yazıları yönetimi
- Proje portföyü yönetimi
- Hizmet tanıtımı ve yönetimi
- Ekip üyeleri yönetimi
- İletişim mesajları yönetimi
- Raporlama ve istatistikler

---

## 🚀 Teknoloji Stack

### Backend
- **.NET Framework**: 4.7.2
- **ASP.NET Web Forms**: Web uygulaması framework'ü
- **C#**: Programlama dili
- **Entity Framework**: 6.5.1 (Veri erişim katmanı)
- **LINQ to SQL**: Veritabanı erişimi için

### Frontend
- **HTML5 / CSS3**: Modern web standartları
- **JavaScript / jQuery**: İstemci tarafı etkileşimler
- **Bootstrap**: Responsive tasarım (kısmen)
- **Chart.js**: Grafik ve istatistik görselleştirme
- **Font Awesome**: İkon kütüphanesi

### Veritabanı
- **Microsoft SQL Server**: Veritabanı yönetim sistemi
- **Stored Procedures**: Veritabanı seviyesinde iş mantığı
- **Views**: Karmaşık sorgular için görünümler

### Mimari
- **Katmanlı Mimari (Layered Architecture)**
- **Repository Pattern**: Veri erişim soyutlaması
- **Service Pattern**: İş mantığı katmanı
- **DTO Pattern**: Veri transfer nesneleri

---

## 📁 Proje Yapısı

```
NtpProje/
├── NtpProje/                    # Web Uygulaması (Presentation Layer)
│   ├── pages/                   # Sayfa dosyaları
│   │   ├── Admin/               # Admin paneli sayfaları
│   │   ├── blog.aspx            # Blog listesi
│   │   ├── projeler.aspx        # Proje listesi
│   │   ├── hizmetler.aspx       # Hizmet listesi
│   │   ├── ekip.aspx            # Ekip sayfası
│   │   └── iletisim.aspx        # İletişim sayfası
│   ├── adminsite/               # Admin site sayfaları
│   ├── css/                     # Stil dosyaları
│   ├── images/                  # Görseller
│   ├── scripts/                 # JavaScript dosyaları
│   ├── Services/                # Web servisleri
│   │   └── UserService.asmx     # SOAP Web Service
│   ├── Site.Master              # Ana master page
│   ├── Login.aspx               # Giriş sayfası
│   └── Web.config               # Uygulama yapılandırması
│
├── NtpProje.Entities/           # Entity ve DTO Katmanı
│   ├── Abstract/
│   │   └── BaseDTO.cs           # Temel DTO sınıfı
│   └── Concrete/
│       ├── UserDTO.cs
│       ├── PostDTO.cs
│       ├── ProjectDTO.cs
│       ├── ServiceDTO.cs
│       └── ...                   # Diğer DTO'lar
│
├── NtpProje.Data/                # Veri Erişim Katmanı
│   ├── Abstract/
│   │   └── IRepository.cs       # Repository interface
│   ├── Concrete/
│   │   ├── UserRepository.cs
│   │   ├── PostRepository.cs
│   │   ├── ProjectRepository.cs
│   │   └── ...                   # Diğer repository'ler
│   └── DataModel/                # LINQ to SQL model
│
├── NtpProje.Business/            # İş Mantığı Katmanı
│   ├── Abstract/
│   │   └── IBaseService.cs      # Service interface
│   └── Concrete/
│       ├── UserService.cs
│       ├── PostService.cs
│       ├── ProjectService.cs
│       └── ...                   # Diğer service'ler
│
└── Database/                     # Veritabanı Scriptleri
    ├── NtpProjeDB_CreateTables.sql
    ├── StoredProcedures_Views_Examples.sql
    └── Insert_ContactInfo_Settings.sql
```

---

## 🏗️ Mimari Yapı

### Katmanlı Mimari

Proje, **4 ana katmandan** oluşmaktadır:

1. **Presentation Layer (NtpProje)**
   - ASP.NET Web Forms sayfaları
   - Master Pages
   - User Controls
   - Web Services

2. **Business Layer (NtpProje.Business)**
   - İş mantığı kuralları
   - Service sınıfları
   - DTO mapping işlemleri

3. **Data Access Layer (NtpProje.Data)**
   - Repository pattern implementasyonu
   - Veritabanı erişim işlemleri
   - LINQ to SQL kullanımı

4. **Entity Layer (NtpProje.Entities)**
   - DTO (Data Transfer Object) sınıfları
   - Entity modelleri

### Design Patterns

#### 1. Repository Pattern
```csharp
public interface IRepository<T> where T : class
{
    List<T> GetAll();
    T Get(int id);
    void Add(T entity);
    void Update(T entity);
    void Delete(T entity);
}
```

#### 2. Service Pattern
```csharp
public interface IBaseService<T> where T : class
{
    List<T> GetAll();
    T GetById(int id);
    bool Add(T dto);
    bool Update(T dto);
    bool Delete(int id);
}
```

#### 3. DTO Pattern
- Entity'ler ve DTO'lar ayrılmış
- Veri transferi için optimize edilmiş nesneler
- Mapping işlemleri service katmanında yapılıyor

---

## 🗄️ Veritabanı Yapısı

### Ana Tablolar

1. **users** - Kullanıcılar (Admin ve normal kullanıcılar)
2. **categories** - Kategoriler (Blog kategorileri)
3. **posts** - Blog yazıları
4. **comments** - Yorumlar
5. **projects** - Projeler
6. **services** - Hizmetler
7. **team_members** - Ekip üyeleri
8. **contact_messages** - İletişim mesajları
9. **project_requests** - Proje teklifleri
10. **statistics** - İstatistikler
11. **settings** - Site ayarları

### Stored Procedures

- `sp_UserLogin` - Kullanıcı girişi
- `sp_CreateProject` - Proje oluşturma (Transaction ile)
- `sp_IncrementPostViewCount` - Görüntülenme sayısını artırma
- `sp_GetMonthlyStatistics` - Aylık istatistik raporu
- `sp_GetPopularContent` - Popüler içerikler
- `sp_RegisterUser` - Kullanıcı kaydı

### Views

- `vw_ProjectDetails` - Proje detayları
- `vw_BlogPostsWithAuthor` - Blog yazıları ve yazar bilgisi
- `vw_ActiveProjectsStats` - Aktif proje istatistikleri
- `vw_PublishedBlogPosts` - Yayınlanmış blog yazıları

---

## 🔧 Kurulum

### Gereksinimler

- Visual Studio 2017 veya üzeri
- SQL Server 2012 veya üzeri (veya LocalDB)
- .NET Framework 4.7.2
- IIS Express (Visual Studio ile birlikte gelir)

### Adım 1: Projeyi İndirin

```bash
git clone [repository-url]
cd NtpProje
```

### Adım 2: Veritabanını Oluşturun

1. SQL Server Management Studio (SSMS) açın
2. Yeni bir veritabanı oluşturun:
   ```sql
   CREATE DATABASE NtpProjeDB;
   ```
3. `Database/NtpProjeDB_CreateTables.sql` dosyasını çalıştırın
4. `Database/Insert_ContactInfo_Settings.sql` dosyasını çalıştırın (İletişim bilgileri için)

### Adım 3: Connection String'i Güncelleyin

`NtpProje/Web.config` dosyasında connection string'i güncelleyin:

```xml
<connectionStrings>
    <add name="BaglantiCumlem" 
         connectionString="Data Source=YOUR_SERVER;Initial Catalog=NtpProjeDB;Integrated Security=True" 
         providerName="System.Data.SqlClient" />
</connectionStrings>
```

### Adım 4: Projeyi Derleyin

1. Visual Studio'da `NtpProje.sln` dosyasını açın
2. Solution'ı derleyin (Build > Build Solution)
3. Projeyi çalıştırın (F5)

### Adım 5: İlk Giriş

- **URL**: `http://localhost:54509/Login.aspx`
- **Varsayılan Admin**:
  - Email: `admin@gencbirey.com`
  - Şifre: `admin123`

⚠️ **ÖNEMLİ**: İlk girişten sonra admin şifresini mutlaka değiştirin!

---

## 📱 Özellikler

### Kullanıcı Tarafı (Frontend)

#### Ana Sayfa
- Slider ve görsel galeri
- Hizmetler özeti
- Projeler özeti
- İstatistikler
- İletişim formu

#### Blog Sistemi
- Blog yazıları listesi
- Kategori filtreleme
- Blog detay sayfası
- Yorum sistemi
- Arama özelliği

#### Proje Portföyü
- Proje listesi
- Proje detay sayfası
- Teknoloji etiketleri
- Proje görselleri
- Kategori filtreleme

#### Hizmetler
- Hizmet listesi
- Hizmet detay sayfası
- Özellikler listesi
- İkon desteği

#### Ekip
- Ekip üyeleri listesi
- Profil bilgileri
- Sosyal medya linkleri

#### İletişim
- İletişim formu
- Proje teklif formu
- Google Maps entegrasyonu
- İletişim bilgileri (Veritabanından çekiliyor)

### Admin Paneli

#### Dashboard
- Genel istatistikler
- Son aktiviteler
- Grafikler ve metrikler
- Hızlı erişim menüleri

#### İçerik Yönetimi
- **Blog Yazıları**: Ekleme, düzenleme, silme, yayınlama
- **Projeler**: Proje yönetimi, teknoloji ekleme, görsel yükleme
- **Hizmetler**: Hizmet yönetimi, özellik ekleme
- **Ekip Üyeleri**: Ekip üyesi ekleme/düzenleme
- **Kategoriler**: Kategori yönetimi

#### İletişim Yönetimi
- İletişim mesajlarını görüntüleme
- Mesaj okundu işaretleme
- Mesaj silme
- Proje tekliflerini yönetme
- İletişim bilgilerini düzenleme (Adres, Telefon, Email, Çalışma Saatleri)

#### Raporlama
- Genel bakış raporları
- İçerik analizi
- Trafik analizi
- Etkileşim raporları
- Grafikler (Chart.js ile)

#### Ayarlar
- Site ayarları
- İletişim bilgileri
- Kullanıcı yönetimi

---

## 🔐 Güvenlik

### Authentication & Authorization
- Session tabanlı kimlik doğrulama
- Role-based access control (Admin/User)
- Master Page seviyesinde güvenlik kontrolü
- Admin sayfalarında otomatik yönlendirme

### Veri Güvenliği
- SQL Injection koruması (Parametreli sorgular)
- XSS koruması (ASP.NET built-in)
- CSRF koruması (ViewState)
- Şifre hashleme (Geliştirilebilir)

---

## 🌐 Web Servisleri

### SOAP Web Service

**Dosya**: `Services/UserService.asmx`

**Metodlar**:
- `GetUserById(int userId)` - Kullanıcı bilgisi getirme
- `GetAllUsers()` - Tüm kullanıcıları listeleme
- `RegisterUser(UserDTO user)` - Kullanıcı kaydı

**Kullanım Senaryoları**:
- Mobil uygulama entegrasyonu
- Farklı web siteleri arası veri paylaşımı
- Desktop uygulaması entegrasyonu
- AJAX ile dinamik içerik

**Test URL**: `http://localhost:54509/Services/UserService.asmx`

---

## 📊 Raporlama

### Rapor Türleri

1. **Genel Bakış**
   - Toplam ziyaretçi
   - Blog yazısı sayısı
   - Yorum sayısı
   - İletişim mesajları

2. **İçerik Analizi**
   - İçerik türü dağılımı
   - Aylık içerik üretimi
   - Yazar performansı
   - İçerik durumu

3. **Trafik Analizi**
   - Günlük ziyaretçi sayısı
   - Ziyaretçi kaynakları
   - Sayfa görüntüleme sayısı
   - Ortalama oturum süresi

4. **Etkileşim**
   - Yorum etkileşimi
   - Sosyal medya paylaşımları
   - E-posta bülteni aboneleri
   - İletişim formu dönüşümleri

### Grafikler
- Line Charts (Çizgi grafikler)
- Bar Charts (Sütun grafikler)
- Pie Charts (Pasta grafikler)
- Doughnut Charts (Halka grafikler)

---

## 🎨 Tasarım ve UI/UX

### Özellikler
- **Responsive Design**: Mobil, tablet ve desktop uyumlu
- **Modern UI**: Temiz ve kullanıcı dostu arayüz
- **Custom CSS**: Özel stil dosyaları
- **Icon Support**: Font Awesome ikonları
- **Image Gallery**: Fancybox ile görsel galeri

### CSS Dosyaları
- `base.css` - Temel stiller
- `genc_birey_stil.css` - Ana stil dosyası
- `admin.css` - Admin panel stilleri
- Sayfa özel CSS dosyaları (blog.css, projeler.css, vb.)

---

## 📝 Kod Standartları

### Naming Conventions
- **Sınıflar**: PascalCase (örn: `UserService`)
- **Metodlar**: PascalCase (örn: `GetAllUsers()`)
- **Değişkenler**: camelCase (örn: `userName`)
- **Private alanlar**: camelCase (örn: `_userService`)

### Kod Organizasyonu
- Her katman kendi klasöründe
- Interface'ler `Abstract` klasöründe
- Implementasyonlar `Concrete` klasöründe
- DTO'lar `Entities` projesinde

---

## 🧪 Test

### Test Senaryoları

1. **Kullanıcı Girişi**
   - Admin girişi
   - Normal kullanıcı girişi
   - Hatalı şifre kontrolü

2. **CRUD İşlemleri**
   - Blog yazısı ekleme/düzenleme/silme
   - Proje ekleme/düzenleme/silme
   - Hizmet yönetimi

3. **Form Validasyonları**
   - İletişim formu validasyonu
   - Proje teklif formu validasyonu
   - Zorunlu alan kontrolleri

---

## 🐛 Bilinen Sorunlar ve Çözümler

### Sorun 1: Connection String Hatası
**Hata**: "Cannot open database"
**Çözüm**: `Web.config` dosyasındaki connection string'i kontrol edin.

### Sorun 2: Master Page Property Hatası
**Hata**: "The name 'FooterAdres' does not exist"
**Çözüm**: Property'ler getter'da veritabanından çekiliyor, sorun çözülmüş durumda.

### Sorun 3: Image Upload Hatası
**Hata**: "Path is not valid"
**Çözüm**: `uploads` klasörünün yazma izinlerini kontrol edin.

---

## 🚀 Geliştirme Önerileri

### Kısa Vadeli
- [ ] Şifre hashleme (BCrypt veya SHA256)
- [ ] Email doğrulama sistemi
- [ ] Dosya yükleme güvenlik kontrolleri
- [ ] Logging sistemi

### Orta Vadeli
- [ ] Entity Framework CodeFirst migrations
- [ ] API geliştirme (REST API)
- [ ] Caching mekanizması
- [ ] Unit test yazımı

### Uzun Vadeli
- [ ] Microservices mimarisine geçiş
- [ ] Docker containerization
- [ ] CI/CD pipeline kurulumu
- [ ] Cloud deployment (Azure/AWS)

---

## 📚 Dokümantasyon

### Mevcut Dokümantasyonlar
- `PROJE_KAPSAMI_ANALIZI.md` - Proje kapsamı analizi
- `KALITIM_ACIKLAMA.md` - Kalıtım açıklamaları
- `STORED_PROCEDURE_VIEW_ACIKLAMA.md` - SP ve View açıklamaları
- `SOAP_WEB_SERVICE_ACIKLAMA.md` - Web servis açıklamaları
- `Database/README.md` - Veritabanı kurulum kılavuzu

---

## 👥 Katkıda Bulunanlar

- Proje Geliştirici: [İsim]
- Tasarım: [İsim]
- Test: [İsim]

---

## 📄 Lisans

Bu proje [Lisans Türü] altında lisanslanmıştır.

---

## 📞 İletişim

- **Email**: info@gencbirey.com
- **Telefon**: +90 232 464 1 184
- **Adres**: Kıbrıs Şehitleri Cd. No:48 K:6 - 601 / İzmir

---

## 🙏 Teşekkürler

- Entity Framework ekibine
- ASP.NET topluluğuna
- Tüm açık kaynak proje geliştiricilerine

---

**Son Güncelleme**: 2025  
**Versiyon**: 1.0.0  
**Durum**: Aktif Geliştirme

---

## 📖 Hızlı Başlangıç

```bash
# 1. Projeyi klonlayın
git clone [repository-url]

# 2. Veritabanını oluşturun
# SQL Server Management Studio'da NtpProjeDB_CreateTables.sql'i çalıştırın

# 3. Connection string'i güncelleyin
# Web.config dosyasını düzenleyin

# 4. Visual Studio'da açın ve çalıştırın
# NtpProje.sln dosyasını açın ve F5'e basın

# 5. Admin paneline giriş yapın
# http://localhost:54509/Login.aspx
# Email: admin@gencbirey.com
# Şifre: admin123
```

---

**Not**: Bu README dosyası projenin genel bir özetidir. Detaylı bilgi için ilgili dokümantasyon dosyalarına bakınız.

