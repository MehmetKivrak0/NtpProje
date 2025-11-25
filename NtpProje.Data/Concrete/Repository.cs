using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Linq; // LINQ to SQL kütüphanesi
using NtpProje.Data.Abstract;
using NtpProje.Data.DataModel;

namespace NtpProje.Data.Concrete
{
    public class Repository<T> : IRepository<T> where T : class
    {
        // Context ismini senin mevcut yapına göre ayarladık
        protected readonly ınnovateyzlmDataContext _context;
        protected readonly Table<T> _table; // DbSet yerine Table kullanılır

        public Repository()
        {
            // Senin DataContext ismin
            _context = new ınnovateyzlmDataContext();
            _table = _context.GetTable<T>(); // Set<T> yerine GetTable<T> kullanılır
        }

        public List<T> GetAll()
        {
            return _table.ToList();
        }

        public T Get(int id)
        {
            // LINQ to SQL'de generic "Find" metodu yoktur.
            // Bu yüzden burayı biraz farklı halletmemiz lazım.
            // En güvenli yöntem, Service katmanında "GetAll().FirstOrDefault(...)" yapmaktır.
            // Ancak şimdilik hata vermemesi için null döndürüyorum veya
            // basitçe tablodaki ilk kaydı çekmeyi deneyebilirsin.

            // ÖNEMLİ: Generic yapıda ID kolonunun adını bilemeyiz.
            // Bu yüzden Get(int id) metodunu burada pas geçip, Service katmanında
            // _repository.GetAll().FirstOrDefault(x => x.Id == id) şeklinde kullanman daha doğru olur.

            throw new NotImplementedException("LINQ to SQL Generic yapıda ID ile çekme işlemi Service katmanında yapılmalıdır.");
        }

        public void Add(T entity)
        {
            _table.InsertOnSubmit(entity); // Add yerine InsertOnSubmit
            _context.SubmitChanges();      // SaveChanges yerine SubmitChanges
        }

        public void Update(T entity)
        {
            // LINQ to SQL'de nesne zaten takip ediliyorsa (track)
            // sadece SubmitChanges demek yeterlidir.
            _context.SubmitChanges();
        }

        public void Delete(T entity)
        {
            _table.DeleteOnSubmit(entity); // Remove yerine DeleteOnSubmit
            _context.SubmitChanges();
        }
    }
}