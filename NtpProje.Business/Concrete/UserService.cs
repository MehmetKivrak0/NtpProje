using System.Linq;
using NtpProje.Business.Abstract;
using NtpProje.Data.Concrete;
using NtpProje.Entities.Concrete;
using System;
using System.Collections.Generic;
using NtpProje.Data.DataModel;
using System.Linq.Expressions;
using System.Runtime.Remoting.Messaging;

public static class HasPassword
{
    public static bool VerifyPassword(string enteredPassword, string storedPassword)
    {
        // Basit bir do��rulama i��lemi (ger&ccedil;ekte daha karma����k olmal��d��r)
        return enteredPassword == storedPassword;
    }

    public static string HashPassword(string password)
    {
        // Basit bir hashleme i��lemi (ger&ccedil;ekte daha karma����k olmal��d��r)
        return password; // Bu sadece bir yer tutucudur
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

        //Kayıt İşlemi
        public bool Register(UserDTO userDTO)
        {
            if (_userRepository.Get(u => u.email == userDTO.email)!= null)
            {
                return false; // Eposta Zaten Mevcut
            }

            var hashedPassword = HasPassword.HashPassword(userDTO.password);

            var newUserEntity = new Data.DataModel.user
            {
                full_name = userDTO.full_name,
                email = userDTO.email,
                password = hashedPassword,
                role = "User",
                is_active = true,
                created_date = DateTime.Now,
            };

            _userRepository.Add(newUserEntity);
            return true;
        }





        public UserDTO Login(string email, string stringPassword)
        {
            var entity = _userRepository.Get(u => u.email == email);
            if (entity != null && entity.is_active == true)
            {
               if(HasPassword.VerifyPassword(stringPassword, entity.password))
                {
                    entity.last_login_date = DateTime.Now;
                    _userRepository.Update(entity);
                    var userDTO = new UserDTO
                    {
                        user_id = entity.user_id,
                        full_name = entity.full_name,
                        email = entity.email,
                        role = entity.role,
                        is_active = entity.is_active.HasValue ? entity.is_active.Value :false,
                        last_login_date = entity.last_login_date
                    };

                    return userDTO;
                }
            }
            return null;
        }

        public bool Add(UserDTO dto)
        {
            // ... Register metodu zaten bu işi yapıyor, diğer IBaseService metotlarına bakın ...
            return Register(dto);
        }

        public bool Update(UserDTO dto)
        {
            // Entity'yi bul, DTO'dan gelen verilerle güncelle (Şifre hariç), Repository.Update() çağır
            throw new NotImplementedException();
        }

        public bool Delete(int id)
        {
            // Kullanıcıyı bul, Repository.Delete() çağır
            throw new NotImplementedException();
        }

        public UserDTO GetById(int id)
        {
            // Entity'yi bul, DTO'ya dönüştür ve döndür
            throw new NotImplementedException();
        }

        public List<UserDTO> GetAll()
        {
            // Tüm Entity'leri al, List<UserDTO>'ya dönüştür ve döndür
            throw new NotImplementedException();
        }



    }
}

