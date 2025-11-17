using System;

namespace NtpProje.Entities.Abstract
{
    public abstract class BaseDTO
    {
        public DateTime created_date { get; set; } // küçük harf ve alt çizgi
        public DateTime? updated_date { get; set; }
        public bool is_active { get; set; }
    }
}

