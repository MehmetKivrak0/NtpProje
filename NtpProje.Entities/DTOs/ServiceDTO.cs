using System;
using NtpProje.Entities.Abstract;

namespace NtpProje.Entities.DTOs
{
    public class ServiceDTO : BaseDTO
    {
        // SQL: service_id
        public int Id { get; set; }

        // SQL: service_name
        public string Name { get; set; }

        // SQL: slug
        public string Slug { get; set; }

        // SQL: description
        public string Description { get; set; }

        // SQL: short_description
        public string ShortDescription { get; set; }

        // SQL: icon
        public string Icon { get; set; }

        // SQL: icon_class
        public string IconClass { get; set; }

        // SQL: image_url
        public string ImageUrl { get; set; }

        // SQL: is_active
        public bool IsActive { get; set; }

        // SQL: display_order
        public int DisplayOrder { get; set; }

        // SQL: view_count
        public int ViewCount { get; set; }

        // Ek bilgiler (JSON formatında saklanacak)
        // Features: Özellikler listesi (Icon, Title, Description)
        public string Features { get; set; }

        // Technologies: Teknolojiler (Category, Items[])
        public string Technologies { get; set; }

        // ProcessSteps: Süreç adımları (Title, Description)
        public string ProcessSteps { get; set; }

        // HighlightFeatures: Öne çıkan özellikler (Title, Description)
        public string HighlightFeatures { get; set; }

        // WhyChooseUs: Neden bizi tercih etmelisiniz (Title, Description)
        public string WhyChooseUs { get; set; }
    }
}