using System.Data.Entity; // Yüklediğimiz EntityFramework'ü kullan
using NtpProje.Entities;   // Adım 6'da yazdığımız User sınıfını bulabilmek için

namespace NtpProje.DataAccess
{
    // ProjeContext sınıfı, DbContext'ten miras alarak "tercüman" olur.
    public class ProjeContext : DbContext
    {
        // Bu kod, Web.config'de "BaglantiCumlem" adında
        // bir veritabanı bağlantı yolu arayacağını söyler.
        public ProjeContext() : base("name=BaglantiCumlem")
        {
        }

        // Adım 6'da oluşturduğun 'User' sınıfını, veritabanında
        // 'Users' adında bir tabloya (DbSet) dönüştür.
        public DbSet<User> Users { get; set; }

        // Gelecekte ekleyeceğin diğer sınıflar (örn: Post, Category)
        // buraya eklenecek.
    }
}