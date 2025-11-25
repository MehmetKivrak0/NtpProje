using System;
using NtpProje.Entities.Abstract;

namespace NtpProje.Entities.Concrete
{
    public class CategoryDTO : BaseDTO
    {
        public int Id { get; set; }
        public string Name { get; set; }

        // SQL tablosunda 'description' olduðu için buraya da ekledim:
        public string Description { get; set; }
        public string Slug { get; set; }
    }
}