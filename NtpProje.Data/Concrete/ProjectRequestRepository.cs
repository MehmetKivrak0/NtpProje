using NtpProje.Data.Abstract;
using NtpProje.Data.DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
// Diğer usingler

namespace NtpProje.Data.Concrete
{
    // Entity'nin tekil adı olan 'project_request' kullanılıyor
    public class ProjectRequestRepository : IRepository<project_request>
    {
        private readonly ınnovateyzlmDataContext _context = new ınnovateyzlmDataContext();

        public void Add(project_request entity)
        {
            _context.project_requests.InsertOnSubmit(entity);
            _context.SubmitChanges();
        }

        // DÜZELTME: Metot adı IRepository'ye uygun olarak büyük harfle başladı
        public void Delete(project_request entity)
        {
            _context.project_requests.DeleteOnSubmit(entity);
            _context.SubmitChanges();
        }

        public void Update(project_request entity)
        {
            // LINQ to SQL takibi sayesinde sadece SubmitChanges yeterli
            _context.SubmitChanges();
        }

        // DÜZELTME: Birincil anahtar alanı eklendi
        public project_request Get(int id)
        {
            return _context.project_requests.FirstOrDefault(pr => pr.project_request_id == id);
        }

        public project_request Get(Expression<Func<project_request, bool>> filter)
        {
            return _context.project_requests.FirstOrDefault(filter);
        }

        // DÜZELTME: Entity tipi 'project_request' olarak düzeltildi
        public List<project_request> GetAll()
        {
            return _context.project_requests.ToList();
        }

        // DÜZELTME: Entity tipi 'project_request' olarak düzeltildi
        public List<project_request> GetAll(Expression<Func<project_request, bool>> filter)
        {
            return _context.project_requests.Where(filter).ToList();
        }
    }
}