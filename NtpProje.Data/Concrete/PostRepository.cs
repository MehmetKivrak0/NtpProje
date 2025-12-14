using NtpProje.Data.Abstract;
using NtpProje.Data.DataModel;
using System.Linq;
using System.Collections.Generic;
using System.Linq.Expressions;
using System;

namespace NtpProje.Data.Concrete
{
    public class PostRepository : IRepository<post>
    {
        // Veritabaný Baðlantýsý
        private readonly ýnnovateyzlmDataContext _context = new ýnnovateyzlmDataContext();


        // 1. ADD (Ekleme)
        public void Add(post entity)
        {
            _context.posts.InsertOnSubmit(entity);
            _context.SubmitChanges();
        }

        // 2. UPDATE (Güncelleme)
        public void Update(post entity)
        {
            // LINQ to SQL'de nesne zaten takip ediliyorsa (track),
            // sadece deðiþiklikleri kaydetmek yeterlidir.
            _context.SubmitChanges();
        }

        // 3. DELETE (Silme)
        public void Delete(post entity)
        {
            // Silinecek nesneyi iþaretle
            _context.posts.DeleteOnSubmit(entity);
            _context.SubmitChanges();
        }

        // --- SENÝN YAZDIÐIN MEVCUT METOTLAR ---

        // GET BY ID (Tek kayýt getirme)
        public post Get(int id)
        {
            return _context.posts.FirstOrDefault(p => p.post_id == id);
        }

        // GET ALL (Tüm kayýtlarý getirme)
        public List<post> GetAll()
        {
            return _context.posts.ToList();
        }

       
    }
}