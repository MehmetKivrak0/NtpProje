using NtpProje.Entities;   // Adım 6'da yazdığımız User sınıfını bulabilmek için
using System.Data.Entity; // Yüklediğimiz EntityFramework'ü kullan

namespace NtpProje.DataAccess
{
    // ProjeContext sınıfı, DbContext'ten miras alarak "tercüman" olur.
    public class ProjeContext : DbContext
    {
        // Bu kod, Web.config'de "BaglantiCumlem" adında
        // bir veritabanı bağlantı yolu arayacağını söyler.
        public ProjeContext() : base("name=BaglantiCumlem")
        {
            // Migration'ları devre dışı bırak, veritabanı yoksa otomatik oluştur
            Database.SetInitializer(new CreateDatabaseIfNotExists<ProjeContext>());
        }

        // Adım 6'da oluşturduğun 'User' sınıfını, veritabanında
        // 'Users' adında bir tabloya (DbSet) dönüştür.
        public DbSet<User> Users { get; set; }

        // Gelecekte ekleyeceğin diğer sınıflar (örn: Post, Category)
        // buraya eklenecek.

        public DbSet<Post> Posts { get; set; }
        public DbSet<Category> Categories { get; set; }

        public DbSet<Project> Projects { get; set; }
        public DbSet<Service> Services { get; set; }
        public DbSet<TeamMember> TeamMembers { get; set; }

        public DbSet<Comment> Comments { get; set; }

    }
}