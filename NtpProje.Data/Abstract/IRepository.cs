using System;
using System.Collections.Generic;
using System.Linq.Expressions;

namespace NtpProje.Data.Abstract
{
    // Burasý sadece kurallarý belirler (Interface)
    public interface IRepository<T> where T : class
    {
        List<T> GetAll();
        T Get(int id);
        void Add(T entity);
        void Update(T entity);
        void Delete(T entity);
    }
}