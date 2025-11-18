using System.Linq;
using NtpProje.Business.Abstract;
using NtpProje.Data.Concrete;
using NtpProje.Entities.Concrete;
using System;
using System.Collections.Generic;
using NtpProje.Data.DataModel;

public static class HasPassword
{
    public static bool VerifyPassword(string enteredPassword, string storedPassword)
    {
        // Güvenlik: Hashlenmiş şifreler karşılaştırılmalıdır.
        return enteredPassword == storedPassword;
    }

    public static string HashPassword(string password)
    {
        // Gerçek projede SHA256 veya BCrypt kullanılmalıdır.
        return password;
    }
}

namespace NtpProje.Business.Concrete
{
    public class UserService : IBaseService<UserDTO>
    {
        private readonly UserRepository _userRepository;

        public UserService()
        {
            _userRepository = new UserRepository();
        }

        // ***************************************************************
        // 1. ÖZEL İŞLEMLER (Register & Login)
        // ***************************************************************

        // Kayıt İşlemi
        public bool Register(UserDTO userDTO)
        {
            if (_userRepository.Get(u => u.email == userDTO.Email) != null)
            {
                return false; // Eposta Zaten Mevcut
            }

            var hashedPassword = HasPassword.HashPassword(userDTO.Password);

            var newUserEntity = new Data.DataModel.user // Entity tipi küçük harfle 'user'
            {
                // DTO (PascalCase) -> Entity (küçük harf)
                full_name = userDTO.Full_name,
                email = userDTO.Email,
                password = hashedPassword,
                role = userDTO.Role ?? "User", // Role yoksa varsayılan "User"
                is_active = userDTO.Is_active,
                created_date = DateTime.Now,
            };

            _userRepository.Add(newUserEntity);
            return true;
        }

        // Giriş İşlemi
        public UserDTO Login(string email, string stringPassword)
        {
            var entity = _userRepository.Get(u => u.email == email);

            if (entity != null && (entity.is_active ?? false) == true) // Null güvenliği
            {
                if (HasPassword.VerifyPassword(stringPassword, entity.password))
                {
                    entity.last_login_date = DateTime.Now;
                    _userRepository.Update(entity);

                    // Entity'den DTO'ya dönüşüm
                    return new UserDTO
                    {
                        User_id = entity.user_id,
                        Full_name = entity.full_name,
                        Email = entity.email,
                        Role = entity.role,
                        Is_active = entity.is_active ?? false,
                        Last_login_date = entity.last_login_date,
                        Created_date = entity.created_date ?? DateTime.MinValue,
                    };
                }
            }
            return null;
        }

        // ***************************************************************
        // 2. IBaseService Metotları (CRUD)
        // ***************************************************************

        // Add, Register metodunu çağırır.
        public bool Add(UserDTO dto) { return Register(dto); }

        public bool Update(UserDTO dto)
        {
            var entity = _userRepository.Get(dto.User_id);
            if (entity == null) return false;

            // Güncellenecek alanlar
            entity.full_name = dto.Full_name;
            entity.email = dto.Email;
            entity.role = dto.Role;
            entity.is_active = dto.Is_active;

            _userRepository.Update(entity);
            return true;
        }

        public bool Delete(int id)
        {
            var entity = _userRepository.Get(id);
            if (entity == null) return false;

            _userRepository.Delete(entity);
            return true;
        }

        public UserDTO GetById(int id)
        {
            var entity = _userRepository.Get(id);
            if (entity == null) return null;

            // Entity'den DTO'ya dönüşüm
            return new UserDTO
            {
                User_id = entity.user_id,
                Full_name = entity.full_name,
                Email = entity.email,
                Role = entity.role,
                Is_active = entity.is_active ?? false,
                Created_date = entity.created_date ?? DateTime.MinValue,
                Last_login_date = entity.last_login_date
            };
        }

        public List<UserDTO> GetAll()
        {
            var entities = _userRepository.GetAll();
            var dtos = new List<UserDTO>();

            foreach (var entity in entities)
            {
                dtos.Add(new UserDTO
                {
                    User_id = entity.user_id,
                    Full_name = entity.full_name,
                    Email = entity.email,
                    Role = entity.role,
                    Is_active = entity.is_active ?? false,
                    Created_date = entity.created_date ?? DateTime.MinValue,
                });
            }
            return dtos;
        }
    }
}