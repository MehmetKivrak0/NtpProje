using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using NtpProje.Entities.Abstract;

namespace NtpProje.Data.Abstract
{
    // T : class -> T bir referans tipi olmalı
    // IEntity -> T'nin mutlaka Id property'si olmalı (IEntity implement etmeli)
    public interface IRepository<T> where T : class, IEntity
    {
        List<T> GetAll();
        T Get(int id);
        void Add(T entity);
        void Update(T entity);
        void Delete(T entity);
    }
}