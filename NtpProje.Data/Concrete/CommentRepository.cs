using System;
using System.Collections.Generic;
using System.Linq;
using NtpProje.Data.Abstract;
using NtpProje.Data.DataModel; // Veritabaný tablolarý burada (comment)

namespace NtpProje.Data.Concrete
{
   
    public class CommentRepository : IRepository<comment>
    {
        // Veritabaný Baðlantýsý
        private readonly ýnnovateyzlmDataContext _context = new ýnnovateyzlmDataContext();

        // 1. GET ALL (Tümünü Getir)
        public List<comment> GetAll()
        {
            return _context.comments.ToList();
        }

        // 2. GET BY ID (Tek Kayýt Getir)
        public comment Get(int id)
        {
            // comment_id, veritabanýndaki ID sütununun adýdýr. Kontrol et!
            return _context.comments.FirstOrDefault(c => c.comment_id == id);
        }

        // 3. ADD (Ekle)
        public void Add(comment entity)
        {
            _context.comments.InsertOnSubmit(entity);
            _context.SubmitChanges();
        }

        // 4. UPDATE (Güncelle)
        public void Update(comment entity)
        {
            // LINQ to SQL'de nesne zaten takip ediliyorsa (track),
            // sadece deðiþiklikleri kaydetmek yeterlidir.
            _context.SubmitChanges();
        }

        // 5. DELETE (Sil)
        public void Delete(comment entity)
        {
            _context.comments.DeleteOnSubmit(entity);
            _context.SubmitChanges();
        }
    }
}