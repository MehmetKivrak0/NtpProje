using NtpProje.Data.Abstract;
using NtpProje.Data.DataModel;
using NtpProje.Entities.Concrete;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Runtime.InteropServices;
using System.Runtime.Remoting.Contexts;

namespace NtpProje.Data.Concrete
{
    public class UserRepository : IRepository<user>
    {
        private readonly ýnnovateyzlmDataContext _context = new ýnnovateyzlmDataContext();


        public void Add(user entity)
        {
            try
            {
                _context.users.InsertOnSubmit(entity);
                _context.SubmitChanges(); // Hata büyük ihtimalle bu satýrda oluþuyor
            }
            catch (Exception ex)
            {
                // Output penceresinde hatayý görmek için
                System.Diagnostics.Debug.WriteLine("VERÝTABANI KAYIT HATASI: " + ex.ToString());

                // Hata durumunda iþlemi geri al (isteðe baðlý ama önerilir)
                // _context.Transaction.Rollback(); 

                // Hatanýn Business katmanýna sýçramasý için tekrar fýrlat (throw)
                throw;
            }
        }

        public void Delete(user entity)
        {
            _context.users.DeleteOnSubmit(entity);
            _context.SubmitChanges();
        }

        public user Get(int id)
        {
            return _context.users.FirstOrDefault(u => u.user_id == id);
        }

        //GET ALL
        public List<user> GetAll()
        {
            return _context.users.ToList();
        }

        // GET ALL WITH FILTER 
        public List<user> GetAll(Expression<Func<user, bool>> filter)
        {
            return _context.users.Where(filter).ToList();
        }

        // Login ve E-posta kontrolü için kullanýlýr
        public user Get(Expression<Func<user,bool>> filter)
        {
            return _context.users.FirstOrDefault(filter);
        }

        // özel Metot Login Ýçin (UserServices'Den çaðrýlýr)
        public user GetByEmailAndPassword(string email ,string hashedPassword)
        {
            return _context.users.FirstOrDefault(u => u.email == email && u.password == hashedPassword);
        }

        // Update Metodu

        public void Update(user entity)
        {
            _context.SubmitChanges();
        }

    };






}

