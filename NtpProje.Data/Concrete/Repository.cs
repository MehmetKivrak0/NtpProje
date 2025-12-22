using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Linq; // LINQ to SQL kütüphanesi
using NtpProje.Data.Abstract;
using NtpProje.Data.DataModel;
using NtpProje.Entities.Abstract;

namespace NtpProje.Data.Concrete
{
    // T : class -> T bir referans tipi olmalı
    // IEntity -> T'nin mutlaka Id property'si olmalı (generic çalışabilmek için)
    public class Repository<T> : IRepository<T> where T : class, IEntity
    {
        protected readonly ınnovateyzlmDataContext _context;
        protected readonly Table<T> _table; // DbSet yerine Table kullanılır

        public Repository()
        {
            _context = new ınnovateyzlmDataContext();
            _table = _context.GetTable<T>(); // Set<T> yerine GetTable<T> kullanılır
        }

        public List<T> GetAll()
        {
            return _table.ToList();
        }

        public T Get(int id)
        {
            // Artık T'nin Id property'si olduğunu biliyoruz!
            // IEntity sayesinde x.Id kullanabiliriz
            return _table.FirstOrDefault(x => x.Id == id);
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