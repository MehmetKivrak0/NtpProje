using NtpProje.Data.Abstract;
using NtpProje.Data.DataModel;
using System.Linq;
using System.Collections.Generic;
using System.Linq.Expressions;
using System;
// ... diðer using'ler ...

namespace NtpProje.Data.Concrete
{
    public class PostRepository : IRepository<post>
    {
        private readonly ýnnovateyzlmDataContext _context = new ýnnovateyzlmDataContext();

        // ... (Add, Update, Delete metotlarý) ...

        // ** GET BY ID ** (Tek kayýt getirme)
        public post Get(int id)
        {
            return _context.posts.FirstOrDefault(p => p.post_id == id);
        }

        // ** GET BY FILTER ** (Tek kayýt getirme)
        public post Get(Expression<Func<post, bool>> filter)
        {
            return _context.posts.FirstOrDefault(filter);
        }

        // ** GET ALL ** (Tüm kayýtlarý getirme)
        public List<post> GetAll()
        {
            return _context.posts.ToList();
        }

        // ** GET ALL WITH FILTER ** (Filtreli liste getirme)
        public List<post> GetAll(Expression<Func<post, bool>> filter)
        {
            return _context.posts.Where(filter).ToList();
        }
    }
}