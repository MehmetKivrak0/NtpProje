using System;
using System.Collections.Generic;

namespace NtpProje.Business.Abstract
{
    /// <summary>
    /// Generic Service Interface - Tüm business işlemleri için temel interface
    /// </summary>
    public interface IBaseService<T> where T : class
    {
        List<T> GetAll();
        T GetById(int id);
        void Add(T entity);
        void Update(T entity);
        void Delete(int id);
    }
}

