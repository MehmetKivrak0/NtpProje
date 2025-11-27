using System;
using System.Web;
using System.Web.Script.Serialization;
using NtpProje.Business.Concrete;
using NtpProje.Entities.Concrete;
using NtpProje.Data.Concrete;
using NtpProje.Data.DataModel;

namespace NtpProje_Web.Admin
{
    public class AddQuickCategoryHandler : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "application/json";
            context.Response.AppendHeader("Access-Control-Allow-Origin", "*");

            try
            {
                // POST verilerini al
                string name = context.Request.Form["name"] ?? context.Request.QueryString["name"];
                string description = context.Request.Form["description"] ?? context.Request.QueryString["description"];

                if (string.IsNullOrEmpty(name))
                {
                    context.Response.Write(new JavaScriptSerializer().Serialize(new { success = false, message = "Kategori adı zorunludur!" }));
                    return;
                }

                // Doğrudan repository kullanarak kategori ekle
                var categoryRepository = new CategoryRepository();
                var categoryEntity = new category
                {
                    category_name = name,
                    description = description ?? string.Empty,
                    slug = name.ToLower()
                        .Replace(" ", "-")
                        .Replace("ı", "i").Replace("ğ", "g").Replace("ü", "u")
                        .Replace("ş", "s").Replace("ö", "o").Replace("ç", "c")
                        .Replace("İ", "i").Replace("Ğ", "g").Replace("Ü", "u")
                        .Replace("Ş", "s").Replace("Ö", "o").Replace("Ç", "c"),
                    is_active = true,
                    display_order = 0
                };

                categoryRepository.Add(categoryEntity);
                
                context.Response.Write(new JavaScriptSerializer().Serialize(new { success = true, message = "Kategori başarıyla eklendi!" }));
            }
            catch (Exception ex)
            {
                // Detaylı hata mesajı (geliştirme için)
                string errorMessage = ex.Message;
                if (ex.InnerException != null)
                {
                    errorMessage += " | Inner: " + ex.InnerException.Message;
                }
                errorMessage += " | Stack: " + ex.StackTrace;
                
                context.Response.Write(new JavaScriptSerializer().Serialize(new { 
                    success = false, 
                    message = errorMessage 
                }));
            }
        }

        public bool IsReusable
        {
            get { return false; }
        }
    }
}

