 # Business Katmanının Asıl Görevleri

## 📊 Görev Tablosu

| # | Görev Kategorisi | Açıklama | Kod Örneği | Hangi Service'te? |
|---|------------------|----------|------------|-------------------|
| **1** | **İş Kuralları Uygulama** | Domain mantığını ve iş kurallarını uygular | | |
| 1.1 | Email Tekrar Kontrolü | Aynı email ile 2. kullanıcı kaydedilemez | `if (_userRepository.Get(u => u.email == userDTO.Email) != null) return false;` | UserService |
| 1.2 | Aktif Kullanıcı Kontrolü | Sadece aktif kullanıcılar giriş yapabilir | `if (entity != null && (entity.is_active ?? false) == true)` | UserService |
| 1.3 | Varsayılan Değer Atama | Role yoksa varsayılan "User" atanır | `role = userDTO.Role ?? "User"` | UserService |
| 1.4 | Slug Otomatik Oluşturma | Kategori adından otomatik slug üretilir | `slug = dto.Name.ToLower().Replace(" ", "-").Replace("ı", "i")...` | CategoryService |
| 1.5 | Yayınlanmış İçerik Filtreleme | Sadece yayınlanmış postlar gösterilir | `.Where(p => p.status == "Published")` | PostService |
| 1.6 | Tarih Sıralama | Postlar yayın tarihine göre sıralanır | `.OrderByDescending(p => p.publish_date)` | PostService |
| 1.7 | Varsayılan Status | Post status yoksa "Draft" atanır | `status = dto.Status ?? "Draft"` | PostService |
| 1.8 | Fallback Mekanizması | View kullanılamazsa normal yönteme geçilir | `try { view } catch { normal method }` | ProjectService |
| **2** | **Veri Dönüşümü (Mapping)** | Entity ↔ DTO arasında dönüşüm yapar | | |
| 2.1 | Entity → DTO Dönüşümü | Veritabanı entity'sini DTO'ya çevirir | `new UserDTO { User_id = entity.user_id, ... }` | Tüm Service'ler |
| 2.2 | DTO → Entity Dönüşümü | DTO'yu veritabanı entity'sine çevirir | `new user { full_name = dto.Full_name, ... }` | Tüm Service'ler |
| 2.3 | İlişkisel Veri Birleştirme | Kategori ve yazar bilgilerini birleştirir | `categoryName = _categoryRepository.Get(...)` | PostService |
| 2.4 | Null Güvenliği | Null değerler için varsayılan değer atar | `ViewCount = entity.view_count ?? 0` | Tüm Service'ler |
| **3** | **İş Mantığı İşlemleri** | Özel iş mantığı uygular | | |
| 3.1 | Şifre Hashleme | Şifreleri hash'ler (güvenlik) | `var hashedPassword = HasPassword.HashPassword(...)` | UserService |
| 3.2 | Şifre Doğrulama | Girişte şifre kontrolü yapar | `HasPassword.VerifyPassword(...)` | UserService |
| 3.3 | Son Giriş Tarihi Güncelleme | Başarılı girişte tarih güncellenir | `entity.last_login_date = DateTime.Now` | UserService |
| 3.4 | Kategori ID Bulma | Kategori adından ID bulunur | `var matchedCategory = allCategories.FirstOrDefault(...)` | ProjectService |
| 3.5 | Otomatik Tarih Atama | Oluşturma tarihi otomatik atanır | `created_date = DateTime.Now` | Tüm Service'ler |
| 3.6 | Güncelleme Tarihi | Güncelleme tarihi otomatik atanır | `updated_date = DateTime.Now` | Tüm Service'ler |
| **4** | **Veri İşleme ve Filtreleme** | Verileri işler ve filtreler | | |
| 4.1 | Aktif Kayıt Filtreleme | Sadece aktif kayıtlar getirilir | `.Where(x => x.is_active == true)` | ServiceService (yorum) |
| 4.2 | Özel Metotlar | Domain'e özel işlemler | `GetPublishedPosts()` | PostService |
| 4.3 | View Kullanımı | Performans için view kullanımı | `GetProjectDetailsFromView()` | ProjectService |
| **5** | **Hata Yönetimi** | İşlemleri güvenli hale getirir | | |
| 5.1 | Try-Catch Kullanımı | Hataları yakalar ve yönetir | `try { ... } catch { return false; }` | Tüm Service'ler |
| 5.2 | Null Kontrolü | Entity null ise işlem yapılmaz | `if (entity == null) return false;` | Tüm Service'ler |
| 5.3 | Güvenli Fallback | Hata durumunda alternatif yöntem | `catch { normal method }` | ProjectService |

---

## 🎯 Özet: Business Katmanının Asıl Görevleri

### ✅ YAPTIĞI İŞLER (Asıl Görevler):
1. **İş Kuralları**: Domain mantığını uygular (email kontrolü, slug oluşturma, filtreleme)
2. **Veri Dönüşümü**: Entity ↔ DTO mapping
3. **İş Mantığı**: Şifre hashleme, tarih güncelleme, otomatik değer atama
4. **Veri İşleme**: Filtreleme, sıralama, birleştirme
5. **Hata Yönetimi**: Try-catch, null kontrolü, fallback mekanizmaları

### ❌ YAPMADIĞI İŞLER (Başka Katmanların Görevleri):
- ❌ **Veritabanına Bağlanma** → Data katmanı (Repository)
- ❌ **UI Gösterme** → Web katmanı (ASPX sayfaları)
- ❌ **Veri Modeli Tanımlama** → Entities katmanı (DTO'lar)

---

## 📝 Notlar

- Business katmanı **Repository'yi çağırır**, veritabanına direkt bağlanmaz
- Her service, kendi domain'i için **özel iş mantığı** içerir
- **DTO kullanımı** sayesinde veritabanı yapısından bağımsızdır
- **İş kuralları** değiştiğinde sadece Business katmanı güncellenir






