using System;
using NtpProje.Entities.Abstract;

namespace NtpProje.Entities.DTOs
{
    public class ContactMessageDTO : BaseDTO
    {
        // SQL: contact_message_id
        public int Id { get; set; }

        // SQL: full_name
        public string NameSurname { get; set; }

        // SQL: email
        public string Email { get; set; }

        // SQL: phone_number
        public string Phone { get; set; }

        // SQL: subject
        public string Subject { get; set; }

        // SQL: message
        public string Message { get; set; }

        // SQL: is_read
        public bool IsRead { get; set; }

        // SQL: created_date
        public DateTime CreatedDate { get; set; }

        // SQL: ip_address
        public string IpAddress { get; set; }

        // --- EKSİK OLANLAR EKLENDİ ---
        // SQL: is_replied
        public bool IsReplied { get; set; }

        // SQL: reply_message
        public string ReplyMessage { get; set; }

        // SQL: reply_date
        public DateTime? ReplyDate { get; set; }
    }
}