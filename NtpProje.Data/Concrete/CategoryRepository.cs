    using System;
using System.Collections.Generic;
using System.Linq;
using NtpProje.Data.Abstract;
using NtpProje.Data.DataModel; // Veritabaný tablolarý burada (category)

namespace NtpProje.Data.Concrete
{
    // DÜZELTME: Repository<CategoryDTO> DEÐÝL, Repository<category> (Küçük harfle veritabaný tablosu)
    public class CategoryRepository : IRepository<category>
    {
        // Veritabaný Baðlantýsý
        private readonly ýnnovateyzlmDataContext _context = new ýnnovateyzlmDataContext();

        // 1. GET ALL (Tümünü Getir)
        public List<category> GetAll()
        {
            return _context.categories.ToList();
        }

        // 2. GET BY ID (Tek Kayýt Getir)
        public category Get(int id)
        {
            // Veritabanýndaki ID sütununun adý 'category_id' ise:
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
            // sadece deðiþiklikleri kaydetmek yeterlidir.
            _context.SubmitChanges();
        }

        // 5. DELETE (Sil)
        public void Delete(category entity)
        {
            _context.categories.DeleteOnSubmit(entity);
            _context.SubmitChanges();
        }
    }
}