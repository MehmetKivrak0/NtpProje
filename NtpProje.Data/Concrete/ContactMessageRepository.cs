using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NtpProje.Data.Abstract;
using NtpProje.Data.DataModel;

namespace NtpProje.Data.Concrete
{
    public class ContactMessageRepository:IRepository<contact_message>
    {
      private readonly ınnovateyzlmDataContext _context = new ınnovateyzlmDataContext();
        public void Add(contact_message entity)
        {
            _context.contact_messages.InsertOnSubmit(entity);
            _context.SubmitChanges();
        }
        public void Delete(contact_message entity)
        {
            _context.contact_messages.DeleteOnSubmit(entity);
            _context.SubmitChanges();
        }
        public void Update(contact_message entity)
        {
            // LINQ to SQL takibi sayesinde sadece SubmitChanges yeterli
            _context.SubmitChanges();
        }
        public contact_message Get(int id)
        {
            return _context.contact_messages.FirstOrDefault(cm => cm.contact_message_id == id);
        }
        public contact_message Get(System.Linq.Expressions.Expression<Func<contact_message, bool>> filter)
        {
            return _context.contact_messages.FirstOrDefault(filter);
        }
        public List<contact_message> GetAll()
        {
            return _context.contact_messages.ToList();
        }
        public List<contact_message> GetAll(System.Linq.Expressions.Expression<Func<contact_message, bool>> filter)
        {
            return _context.contact_messages.Where(filter).ToList();
        }
    }
}
