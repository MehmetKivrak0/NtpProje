using System;

namespace NtpProje.Entities.Abstract
{
    public abstract class BaseDTO
    {
        public DateTime Created_date { get; set; } // küçük harf ve alt çizgi
        public DateTime? Updated_date { get; set; }
        public bool Is_active { get; set; }
    }
}

