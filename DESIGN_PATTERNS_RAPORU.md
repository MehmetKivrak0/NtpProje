# 🎨 Design Patterns Kullanım Raporu - NtpProje

## 📋 Genel Bakış

Bu projede **6 farklı Design Pattern** kullanılmıştır. Her birinin kullanım yerleri ve örnekleri aşağıda detaylı olarak gösterilmiştir.

---

## 1. 📦 REPOSITORY PATTERN

### Açıklama
Veritabanı erişim mantığını soyutlar ve veri katmanını business katmanından ayırır.

### Kullanım Yerleri

#### **Interface Tanımı:**
```csharp
// 📁 NtpProje.Data/Abstract/IRepository.cs
public interface IRepository<T> where T : class
{
    List<T> GetAll();
    T Get(int id);
    void Add(T entity);
    void Update(T entity);
    void Delete(T entity);
}
```

#### **Generic Repository Implementation:**
```csharp
// 📁 NtpProje.Data/Concrete/Repository.cs
public class Repository<T> : IRepository<T> where T : class
{
    protected readonly ınnovateyzlmDataContext _context;
    protected readonly Table<T> _table;
    
    public List<T> GetAll() { ... }
    public void Add(T entity) { ... }
    public void Update(T entity) { ... }
    public void Delete(T entity) { ... }
}
```

#### **Concrete Repository Implementations:**
- ✅ `UserRepository : IRepository<user>` → `NtpProje.Data/Concrete/UserRepository.cs`
- ✅ `CategoryRepository : IRepository<category>` → `NtpProje.Data/Concrete/CategoryRepository.cs`
- ✅ `PostRepository : IRepository<post>` → `NtpProje.Data/Concrete/PostRepository.cs`
- ✅ `ProjectRepository : Repository<project>` → `NtpProje.Data/Concrete/ProjectRepository.cs`
- ✅ `CommentRepository : IRepository<comment>` → `NtpProje.Data/Concrete/CommentRepository.cs`
- ✅ `ServiceRepository : IRepository<service>` → `NtpProje.Data/Concrete/ServiceRepository.cs`
- ✅ `TeamMemberRepository : IRepository<team_member>` → `NtpProje.Data/Concrete/TeamMemberRepository.cs`
- ✅ `ContactMessageRepository : IRepository<contact_message>` → `NtpProje.Data/Concrete/ContactMessageRepository.cs`
- ✅ `ProjectRequestRepository : IRepository<project_request>` → `NtpProje.Data/Concrete/ProjectRequestRepository.cs`
- ✅ `StatisticRepository : Repository<statistic>` → `NtpProje.Data/Concrete/StatisticRepository.cs`
- ✅ `SettingRepository : Repository<setting>` → `NtpProje.Data/Concrete/SettingRepository.cs`

### Faydaları
- ✅ Veritabanı değişikliklerinden business katmanını korur
- ✅ Test edilebilirlik artar (Mock repository kullanılabilir)
- ✅ Kod tekrarını önler

---

## 2. 🏢 SERVICE LAYER PATTERN

### Açıklama
Business mantığını merkezi bir katmanda toplar ve iş kurallarını uygular.

### Kullanım Yerleri

#### **Interface Tanımı:**
```csharp
// 📁 NtpProje.Business/Abstract/IBaseService.cs
public interface IBaseService<T> where T : class
{
    List<T> GetAll();
    T GetById(int id);
    bool Add(T dto);
    bool Update(T dto);
    bool Delete(int id);
}
```

#### **Concrete Service Implementations:**
- ✅ `UserService : IBaseService<UserDTO>` → `NtpProje.Business/Concrete/UserService.cs`
- ✅ `CategoryService : IBaseService<CategoryDTO>` → `NtpProje.Business/Concrete/CategoryService.cs`
- ✅ `PostService : IBaseService<PostDTO>` → `NtpProje.Business/Concrete/PostService.cs`
- ✅ `ProjectService : IBaseService<ProjectDTO>` → `NtpProje.Business/Concrete/ProjectService.cs`
- ✅ `CommentService : IBaseService<CommentDTO>` → `NtpProje.Business/Concrete/CommentService.cs`
- ✅ `ServiceService : IBaseService<ServiceDTO>` → `NtpProje.Business/Concrete/ServiceService.cs`
- ✅ `TeamMemberService : IBaseService<TeamMemberDTO>` → `NtpProje.Business/Concrete/TeamMemberService.cs`
- ✅ `ContactMessageService : IBaseService<ContactMessageDTO>` → `NtpProje.Business/Concrete/ContactMessageService.cs`
- ✅ `ProjectRequestService : IBaseService<ProjectRequestDTO>` → `NtpProje.Business/Concrete/ProjectRequestService.cs`
- ✅ `StatisticService : IBaseService<StatisticDTO>` → `NtpProje.Business/Concrete/StatisticService.cs`

### Örnek Kullanım:
```csharp
// 📁 NtpProje.Business/Concrete/CategoryService.cs
public class CategoryService : IBaseService<CategoryDTO>
{
    private readonly CategoryRepository _categoryRepository;
    
    public CategoryService()
    {
        _categoryRepository = new CategoryRepository();
    }
    
    public List<CategoryDTO> GetAll() { ... }
    public CategoryDTO GetById(int id) { ... }
    public bool Add(CategoryDTO dto) { ... }
    public bool Update(CategoryDTO dto) { ... }
    public bool Delete(int id) { ... }
}
```

### Faydaları
- ✅ Business mantığı tek yerde toplanır
- ✅ Presentation katmanından business mantığı ayrılır
- ✅ Transaction yönetimi merkezi hale gelir

---

## 3. 📋 DATA TRANSFER OBJECT (DTO) PATTERN

### Açıklama
Katmanlar arası veri transferi için hafif nesneler kullanır.

### Kullanım Yerleri

#### **Base DTO:**
```csharp
// 📁 NtpProje.Entities/Abstract/BaseDTO.cs
public abstract class BaseDTO
{
    public DateTime Created_date { get; set; }
    public DateTime? Updated_date { get; set; }
    public bool Is_active { get; set; }
}
```

#### **Concrete DTO'lar:**
- ✅ `CategoryDTO : BaseDTO` → `NtpProje.Entities/Concrete/CategoryDTO.cs`
- ✅ `UserDTO : BaseDTO` → `NtpProje.Entities/Concrete/UserDTO.cs`
- ✅ `PostDTO : BaseDTO` → `NtpProje.Entities/Concrete/PostDTO.cs`
- ✅ `ProjectDTO : BaseDTO` → `NtpProje.Entities/Concrete/ProjectDTO.cs`
- ✅ `CommentDTO : BaseDTO` → `NtpProje.Entities/Concrete/CommentDTO.cs`
- ✅ `ServiceDTO : BaseDTO` → `NtpProje.Entities/Concrete/ServiceDTO.cs`
- ✅ `TeamMemberDTO : BaseDTO` → `NtpProje.Entities/Concrete/TeamMemberDTO.cs`
- ✅ `ContactMessageDTO : BaseDTO` → `NtpProje.Entities/Concrete/ContactMessageDTO.cs`
- ✅ `ProjectRequestDTO : BaseDTO` → `NtpProje.Entities/Concrete/ProjectRequestDTO.cs`
- ✅ `StatisticDTO : BaseDTO` → `NtpProje.Entities/Concrete/StatisticDTO.cs`
- ✅ `SettingDTO : BaseDTO` → `NtpProje.Entities/Concrete/SettingDTO.cs`

### Örnek Kullanım:
```csharp
// Service katmanında Entity → DTO dönüşümü
public List<CategoryDTO> GetAll()
{
    var entities = _categoryRepository.GetAll();
    var dtos = new List<CategoryDTO>();
    
    foreach (var entity in entities)
    {
        dtos.Add(new CategoryDTO
        {
            Id = entity.category_id,
            Name = entity.category_name,
            Description = entity.description
        });
    }
    return dtos;
}
```

### Faydaları
- ✅ Entity'ler presentation katmanına expose edilmez
- ✅ Network trafiği azalır (sadece gerekli veriler gönderilir)
- ✅ Versioning kolaylaşır

---

## 4. 🎯 TEMPLATE METHOD PATTERN

### Açıklama
Bir algoritmanın iskeletini tanımlar, bazı adımları alt sınıflara bırakır.

### Kullanım Yeri

```csharp
// 📁 NtpProje/pages/Admin/BaseAdminPage.cs
public abstract class BaseAdminPage : System.Web.UI.Page
{
    // Template Method - Algoritmanın iskeleti
    protected void Page_Load(object sender, EventArgs e)
    {
        // 1. Güvenlik kontrolü (Template Method)
        if (!CheckSecurity())
        {
            OnSecurityCheckFailed();
            return;
        }
        
        // 2. Base OnPageLoad çağrısı (Hook Method)
        OnPageLoad();
        
        // 3. İlk yüklemede OnPageLoadFirstTime çağrısı (Hook Method)
        if (!IsPostBack)
        {
            OnPageLoadFirstTime();
        }
    }
    
    // Hook Methods - Alt sınıflar override edebilir
    protected virtual void OnPageLoad() { }
    protected virtual void OnPageLoadFirstTime() { }
    protected virtual bool CheckSecurity() { return Session["AdminUser"] != null; }
    protected virtual void OnSecurityCheckFailed() { Response.Redirect("~/Login.aspx"); }
    protected virtual void ShowMessage(string message, string type) { }
}
```

### Kullanım Örneği:
```csharp
// 📁 NtpProje/pages/Admin/hizmetynt.aspx.cs
public partial class hizmetynt : BaseAdminPage
{
    // Template Method'daki hook metodları override ediyor
    protected override void OnPageLoadFirstTime()
    {
        CheckSuccessMessage();
        LoadServices();
    }
    
    protected override void ShowMessage(string message, string type)
    {
        if (lblMessage != null)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = "message-alert " + type + " visible";
        }
    }
}
```

### Faydaları
- ✅ Ortak algoritma yapısı korunur
- ✅ Kod tekrarı önlenir
- ✅ Esneklik sağlar (alt sınıflar kendi implementasyonlarını yapabilir)

---

## 5. 🔧 GENERIC REPOSITORY PATTERN

### Açıklama
Type-safe, generic bir repository yapısı sağlar.

### Kullanım Yeri

```csharp
// 📁 NtpProje.Data/Concrete/Repository.cs
public class Repository<T> : IRepository<T> where T : class
{
    protected readonly ınnovateyzlmDataContext _context;
    protected readonly Table<T> _table;
    
    public Repository()
    {
        _context = new ınnovateyzlmDataContext();
        _table = _context.GetTable<T>();
    }
    
    public List<T> GetAll() { return _table.ToList(); }
    public void Add(T entity) { _table.InsertOnSubmit(entity); _context.SubmitChanges(); }
    public void Update(T entity) { _context.SubmitChanges(); }
    public void Delete(T entity) { _table.DeleteOnSubmit(entity); _context.SubmitChanges(); }
}
```

### Kullanım Örnekleri:
```csharp
// 📁 NtpProje.Data/Concrete/ProjectRepository.cs
public class ProjectRepository : Repository<project>
{
    // Repository<project>'den miras aldığı metodlar:
    // ✅ GetAll() - otomatik var
    // ✅ Add() - otomatik var
    // ✅ Update() - otomatik var
    // ✅ Delete() - otomatik var
    
    // Kendi özel metodu:
    public List<ProjectDTO> GetProjectDetailsFromView() { ... }
}

// 📁 NtpProje.Data/Concrete/StatisticRepository.cs
public class StatisticRepository : Repository<statistic>
{
    // Temel CRUD işlemleri Repository<statistic>'den gelir
}
```

### Faydaları
- ✅ Type-safe kod
- ✅ Kod tekrarını önler
- ✅ Bakım kolaylığı

---

## 6. 💉 DEPENDENCY INJECTION (Kısmi - Constructor Injection)

### Açıklama
Bağımlılıkları constructor üzerinden enjekte eder (tam DI container yok, manuel injection var).

### Kullanım Yerleri

```csharp
// 📁 NtpProje.Business/Concrete/CategoryService.cs
public class CategoryService : IBaseService<CategoryDTO>
{
    // Dependency - Constructor'da inject ediliyor
    private readonly CategoryRepository _categoryRepository;
    
    // Constructor Injection
    public CategoryService()
    {
        _categoryRepository = new CategoryRepository(); // Manuel injection
    }
    
    // Metodlarda repository kullanılıyor
    public List<CategoryDTO> GetAll()
    {
        var entities = _categoryRepository.GetAll(); // Dependency kullanımı
        // ...
    }
}
```

### Diğer Örnekler:
- ✅ `UserService` → `UserRepository` inject ediyor
- ✅ `PostService` → `PostRepository`, `CategoryRepository`, `UserRepository` inject ediyor
- ✅ `ProjectService` → `ProjectRepository` inject ediyor
- ✅ Tüm Service sınıfları kendi Repository'lerini constructor'da inject ediyor

### Not:
⚠️ **Tam DI Container yok** (Unity, Ninject, Autofac gibi). Manuel constructor injection kullanılıyor. İleride bir DI container eklenebilir.

### Faydaları
- ✅ Loose coupling (gevşek bağlılık)
- ✅ Test edilebilirlik (Mock repository inject edilebilir)
- ✅ Dependency'ler açıkça görülür

---

## 📊 Pattern Kullanım Özeti

| Pattern | Kullanım Sayısı | Dosya Örnekleri |
|---------|----------------|-----------------|
| **Repository Pattern** | 11+ Repository | `UserRepository.cs`, `CategoryRepository.cs` |
| **Service Layer Pattern** | 10+ Service | `UserService.cs`, `CategoryService.cs` |
| **DTO Pattern** | 11+ DTO | `CategoryDTO.cs`, `UserDTO.cs` |
| **Template Method** | 1 Base Class | `BaseAdminPage.cs` |
| **Generic Repository** | 3+ Repository | `Repository<T>`, `ProjectRepository` |
| **Dependency Injection** | 10+ Service | Tüm Service sınıfları |

---

## 🏗️ Mimari Yapı

```
┌─────────────────────────────────────┐
│   Presentation Layer (ASP.NET)     │
│   - BaseAdminPage (Template Method)│
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│   Business Layer (Service Pattern)  │
│   - IBaseService<T>                 │
│   - UserService, CategoryService... │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│   Data Layer (Repository Pattern)   │
│   - IRepository<T>                   │
│   - Repository<T> (Generic)          │
│   - UserRepository, CategoryRepo... │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│   Entity Layer (DTO Pattern)        │
│   - BaseDTO                         │
│   - CategoryDTO, UserDTO...         │
└─────────────────────────────────────┘
```

---

## ✅ Sonuç

Projede **6 farklı Design Pattern** profesyonel bir şekilde kullanılmıştır:

1. ✅ **Repository Pattern** - Veri erişim soyutlaması
2. ✅ **Service Layer Pattern** - Business mantığı organizasyonu
3. ✅ **DTO Pattern** - Katmanlar arası veri transferi
4. ✅ **Template Method Pattern** - Ortak algoritma yapısı
5. ✅ **Generic Repository Pattern** - Type-safe, tekrar kullanılabilir kod
6. ✅ **Dependency Injection** - Loose coupling (kısmi, manuel)

Bu pattern'ler projeyi **maintainable** (bakımı kolay), **testable** (test edilebilir) ve **scalable** (ölçeklenebilir) hale getirmiştir.

---

**Oluşturulma Tarihi**: 2024  
**Proje**: NtpProje  
**Konu**: Design Patterns Kullanım Analizi

