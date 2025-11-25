using System;
using NtpProje.Entities.Abstract;

namespace NtpProje.Entities.Concrete
{
    public class StatisticDTO : BaseDTO
    {
        // SQL: statistic_id
        public int Id { get; set; }

        // SQL: statistic_key (Örn: "project_count") - Kodda bunu kullanacağız
        public string Key { get; set; }

        // SQL: statistic_value (Örn: "150+")
        public string Value { get; set; }

        // SQL: statistic_label (Örn: "Tamamlanan Proje") - Ekranda bu yazacak
        public string Label { get; set; }

        // SQL: display_order
        public int DisplayOrder { get; set; }

        // SQL: is_active
        public bool IsActive { get; set; }
    }
}