using System.Collections.Generic;

namespace NtpProje.Business.Abstract
{
    public interface IBaseService<T> where T : class
    {
        // 1. Tüm kayıtları getir
        List<T> GetAll();

        // 2. ID'ye göre tek kayıt getir
        T GetById(int id);

        // 3. Yeni kayıt ekle
        bool Add(T dto);

        // 4. Kayıt güncelle
        bool Update(T dto);

        // 5. Kayıt sil
        bool Delete(int id);
    }
}

