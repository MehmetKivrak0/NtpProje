using NtpProje.Data.Abstract;
using NtpProje.Data.DataModel;
using NtpProje.Entities.DTOs;
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
        private readonly ınnovateyzlmDataContext _context = new ınnovateyzlmDataContext();


        public void Add(user entity)
        {
            try
            {
                _context.users.InsertOnSubmit(entity);
                _context.SubmitChanges(); 
            }
            catch (Exception ex)
            {
                // Output penceresinde hatay� g�rmek i�in
                System.Diagnostics.Debug.WriteLine("VER�TABANI KAYIT HATASI: " + ex.ToString());

                // Hata durumunda i�lemi geri al (iste�e ba�l� ama �nerilir)
                // _context.Transaction.Rollback(); 

                // Hatan�n Business katman�na s��ramas� i�in tekrar f�rlat (throw)
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

        // Login ve E-posta kontrol� i�in kullan�l�r
        public user Get(Expression<Func<user,bool>> filter)
        {
            return _context.users.FirstOrDefault(filter);
        }

        // �zel Metot Login ��in (UserServices'Den �a�r�l�r)
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

