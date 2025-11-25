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

        // --- EKSÝK OLAN METOTLAR (Hatalarý Çözen Kýsým) ---

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

        // NOT: Eðer IRepository arayüzünde "Expression" alan metotlar yoksa,
        // aþaðýdaki metotlarý silmen gerekebilir. Varsa kalabilirler.
        /*
        public post Get(Expression<Func<post, bool>> filter)
        {
            return _context.posts.FirstOrDefault(filter);
        }

        public List<post> GetAll(Expression<Func<post, bool>> filter)
        {
            return _context.posts.Where(filter).ToList();
        }
        */
    }
}