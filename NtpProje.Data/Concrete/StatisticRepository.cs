using System;
using System.Collections.Generic;
using System.Linq;
using NtpProje.Data.Abstract;   // IRepository arayüzü için
using NtpProje.Data.DataModel;  // Veritabanı tablosu (statistic) için

namespace NtpProje.Data.Concrete
{
    // DÜZELTME 1: Sınıf 'public' olmalı.
    // DÜZELTME 2: Repository<statistic> sınıfından miras almalı.
    public class StatisticRepository : Repository<statistic>
    {
        // İçi boş kalabilir. 
        // Çünkü Ekleme, Silme, Güncelleme, Listeleme komutlarının hepsi
        // miras aldığımız "Repository<T>" sınıfında zaten yazılı.
    }
}