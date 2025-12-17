using System;
using NtpProje.Entities.Abstract;

namespace NtpProje.Entities.DTOs
{
    public class SettingDTO : BaseDTO
    {
        public int Id { get; set; }
        public string Key { get; set; }   // setting_key
        public string Value { get; set; } // setting_value
        public string Description { get; set; }
    }
}