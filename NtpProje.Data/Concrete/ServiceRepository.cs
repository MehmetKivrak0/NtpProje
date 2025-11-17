using NtpProje.Data.Abstract;
using NtpProje.Data.DataModel;
using System.Linq;
using System.Collections.Generic;
using System.Linq.Expressions;
using System;

namespace NtpProje.Data.Concrete
{
    // IRepository'yi 'service' Entity'si ile uyguluyoruz.
    public class ServiceRepository : IRepository<service>
    {
        private readonly ýnnovateyzlmDataContext _context = new ýnnovateyzlmDataContext();

        public void Add(service entity)
        {
            _context.services.InsertOnSubmit(entity);
            _context.SubmitChanges();
        }

        public void Update(service entity)
        {
            _context.SubmitChanges();
        }

        public void Delete(service entity)
        {
            _context.services.DeleteOnSubmit(entity);
            _context.SubmitChanges();
        }

        public service Get(int id)
        {
            return _context.services.FirstOrDefault(s => s.service_id == id);
        }

        public service Get(Expression<Func<service, bool>> filter)
        {
            return _context.services.FirstOrDefault(filter);
        }

        public List<service> GetAll()
        {
            return _context.services.ToList();
        }

        public List<service> GetAll(Expression<Func<service, bool>> filter)
        {
            return _context.services.Where(filter).ToList();
        }
    }
}