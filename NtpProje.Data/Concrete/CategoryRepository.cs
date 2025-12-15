using System;
using System.Collections.Generic;
using System.Linq;
using NtpProje.Data.Abstract;
using NtpProje.Data.DataModel; // Veritabanı tabloları burada (category)

namespace NtpProje.Data.Concrete
{
    // Repository<category> (küçük harfle veritabanı tablosu)
    public class CategoryRepository : IRepository<category>
    {
        // Veritabanı Bağlantısı
        private readonly ınnovateyzlmDataContext _context = new ınnovateyzlmDataContext();

        // 1. GET ALL (Tümünü Getir)
        public List<category> GetAll()
        {
            return _context.categories.ToList();
        }

        // 2. GET BY ID (Tek Kayıt Getir)
        public category Get(int id)
        {
            // Veritaban�ndaki ID s�tununun ad� 'category_id' ise:
            return _context.categories.FirstOrDefault(c => c.category_id == id);
        }

        // 3. ADD (Ekle)
        public void Add(category entity)
        {
            _context.categories.InsertOnSubmit(entity);
            _context.SubmitChanges();
        }

        // 4. UPDATE (Güncelle)
        public void Update(category entity)
        {
            // LINQ to SQL'de nesne zaten takip ediliyorsa (track),
            // sadece de�i�iklikleri kaydetmek yeterlidir.
            _context.SubmitChanges();
        }

        // 5. DELETE (Sil)
        public void Delete(category entity)
        {
            _context.categories.DeleteOnSubmit(entity);
            _context.SubmitChanges();
        }

        // 6. SLUG VAR MI? (Benzersizlik kontrolü)
        public bool SlugExists(string slug)
        {
            if (string.IsNullOrWhiteSpace(slug))
                return false;

            return _context.categories.Any(c => c.slug == slug);
        }
    }
}