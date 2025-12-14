using System;
using System.Web;
using System.Web.Script.Serialization;
using NtpProje.Business.Concrete;
using NtpProje.Entities.Concrete;

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

                // ✅ DOĞRU: Business katmanı üzerinden işlem yapılıyor
                var categoryService = new CategoryService();
                var categoryDTO = new CategoryDTO
                {
                    Name = name,
                    Description = description ?? string.Empty
                };

                bool result = categoryService.Add(categoryDTO);
                
                if (result)
                {
                    context.Response.Write(new JavaScriptSerializer().Serialize(new { success = true, message = "Kategori başarıyla eklendi!" }));
                }
                else
                {
                    context.Response.Write(new JavaScriptSerializer().Serialize(new { success = false, message = "Kategori eklenirken bir hata oluştu!" }));
                }
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

