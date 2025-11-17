// =============================================
// C# KODUNDA VIEW KULLANIMI
// =============================================

using System;
using System.Data;
using System.Data.SqlClient;
using NtpProje.Data.Model;

// 1. VIEW KULLANIMI - LINQ ile
public void GetProjectDetails()
{
    using (var db = new ınnovateyazılımDataContext())
    {
        // View'ı normal tablo gibi kullanabilirsiniz
        // Ancak LINQ to SQL'de View'ı dbml'e eklemeniz gerekir
        
        // Alternatif: SQL ile direkt çağır
        var projects = db.ExecuteQuery<ProjectDTO>(
            "SELECT * FROM vw_ProjectDetails WHERE project_id = {0}", 
            1
        );
    }
}

// 2. VIEW KULLANIMI - ADO.NET ile
public DataTable GetBlogPostsWithAuthor()
{
    string connectionString = "Data Source=.;Initial Catalog=NtpProjeDB;Integrated Security=True";
    
    using (SqlConnection conn = new SqlConnection(connectionString))
    {
        conn.Open();
        string sql = "SELECT * FROM vw_BlogPostsWithAuthor ORDER BY publish_date DESC";
        
        using (SqlCommand cmd = new SqlCommand(sql, conn))
        {
            using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                return dt;
            }
        }
    }
}


// =============================================
// C# KODUNDA STORED PROCEDURE KULLANIMI
// =============================================

// 1. Kullanıcı Girişi - ADO.NET ile
public class UserLoginResult
{
    public int UserId { get; set; }
    public string FullName { get; set; }
    public string Role { get; set; }
    public bool Success { get; set; }
}

public UserLoginResult LoginUser(string email, string password)
{
    string connectionString = "Data Source=.;Initial Catalog=NtpProjeDB;Integrated Security=True";
    
    using (SqlConnection conn = new SqlConnection(connectionString))
    {
        conn.Open();
        
        using (SqlCommand cmd = new SqlCommand("sp_UserLogin", conn))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            
            // Parametreleri ekle
            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@Password", password);
            
            // Output parametreleri
            SqlParameter userIdParam = new SqlParameter("@UserId", SqlDbType.Int);
            userIdParam.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(userIdParam);
            
            SqlParameter fullNameParam = new SqlParameter("@FullName", SqlDbType.NVarChar, 100);
            fullNameParam.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(fullNameParam);
            
            SqlParameter roleParam = new SqlParameter("@Role", SqlDbType.NVarChar, 50);
            roleParam.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(roleParam);
            
            SqlParameter successParam = new SqlParameter("@Success", SqlDbType.Bit);
            successParam.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(successParam);
            
            // SP'yi çalıştır
            cmd.ExecuteNonQuery();
            
            // Sonuçları al
            return new UserLoginResult
            {
                UserId = userIdParam.Value != DBNull.Value ? (int)userIdParam.Value : 0,
                FullName = fullNameParam.Value != DBNull.Value ? fullNameParam.Value.ToString() : "",
                Role = roleParam.Value != DBNull.Value ? roleParam.Value.ToString() : "",
                Success = successParam.Value != DBNull.Value && (bool)successParam.Value
            };
        }
    }
}

// Login.aspx.cs'de kullanım:
protected void btnLogin_Click(object sender, EventArgs e)
{
    var result = LoginUser(txtEmail.Text, HashPassword(txtPassword.Text));
    
    if (result.Success)
    {
        Session["UserId"] = result.UserId;
        Session["FullName"] = result.FullName;
        Session["Role"] = result.Role;
        Response.Redirect("~/pages/Admin/admin_dashboard.aspx");
    }
    else
    {
        ltrMesaj.Text = "<div class='alert alert-danger'>Email veya şifre hatalı!</div>";
    }
}


// 2. Proje Oluşturma - ADO.NET ile
public int CreateProject(string projectName, string description, string technologies)
{
    string connectionString = "Data Source=.;Initial Catalog=NtpProjeDB;Integrated Security=True";
    
    using (SqlConnection conn = new SqlConnection(connectionString))
    {
        conn.Open();
        
        using (SqlCommand cmd = new SqlCommand("sp_CreateProject", conn))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            
            cmd.Parameters.AddWithValue("@ProjectName", projectName);
            cmd.Parameters.AddWithValue("@Description", description);
            cmd.Parameters.AddWithValue("@ShortDescription", description.Substring(0, Math.Min(500, description.Length)));
            cmd.Parameters.AddWithValue("@Category", "Web");
            cmd.Parameters.AddWithValue("@ClientName", "");
            cmd.Parameters.AddWithValue("@Technologies", technologies);
            
            SqlParameter projectIdParam = new SqlParameter("@ProjectId", SqlDbType.Int);
            projectIdParam.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(projectIdParam);
            
            cmd.ExecuteNonQuery();
            
            return projectIdParam.Value != DBNull.Value ? (int)projectIdParam.Value : 0;
        }
    }
}


// 3. Aylık İstatistik Raporu - ADO.NET ile
public DataTable GetMonthlyStatistics(DateTime startDate, DateTime endDate)
{
    string connectionString = "Data Source=.;Initial Catalog=NtpProjeDB;Integrated Security=True";
    
    using (SqlConnection conn = new SqlConnection(connectionString))
    {
        conn.Open();
        
        using (SqlCommand cmd = new SqlCommand("sp_GetMonthlyStatistics", conn))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@StartDate", startDate);
            cmd.Parameters.AddWithValue("@EndDate", endDate);
            
            using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                return dt;
            }
        }
    }
}

// Raporlar.aspx.cs'de kullanım:
private void LoadStatistics()
{
    DateTime startDate = DateTime.Now.AddMonths(-1);
    DateTime endDate = DateTime.Now;
    
    DataTable stats = GetMonthlyStatistics(startDate, endDate);
    
    // GridView'e bağla veya Label'lara yaz
    foreach (DataRow row in stats.Rows)
    {
        string contentType = row["content_type"].ToString();
        int totalCount = Convert.ToInt32(row["total_count"]);
        // ...
    }
}


// 4. En Popüler İçerikleri Getir - ADO.NET ile
public DataTable GetPopularContent(string contentType, int topCount = 10)
{
    string connectionString = "Data Source=.;Initial Catalog=NtpProjeDB;Integrated Security=True";
    
    using (SqlConnection conn = new SqlConnection(connectionString))
    {
        conn.Open();
        
        using (SqlCommand cmd = new SqlCommand("sp_GetPopularContent", conn))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ContentType", contentType);
            cmd.Parameters.AddWithValue("@TopCount", topCount);
            
            using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                return dt;
            }
        }
    }
}

// index.aspx.cs'de kullanım:
private void LoadPopularProjects()
{
    DataTable popularProjects = GetPopularContent("Projects", 6);
    
    // Repeater'a bağla
    rptProjeler.DataSource = popularProjects;
    rptProjeler.DataBind();
}


// 5. Kullanıcı Kayıt - ADO.NET ile
public class RegisterResult
{
    public int UserId { get; set; }
    public bool Success { get; set; }
    public string Message { get; set; }
}

public RegisterResult RegisterUser(string fullName, string email, string phone, string password)
{
    string connectionString = "Data Source=.;Initial Catalog=NtpProjeDB;Integrated Security=True";
    
    using (SqlConnection conn = new SqlConnection(connectionString))
    {
        conn.Open();
        
        using (SqlCommand cmd = new SqlCommand("sp_RegisterUser", conn))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            
            cmd.Parameters.AddWithValue("@FullName", fullName);
            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@PhoneNumber", phone);
            cmd.Parameters.AddWithValue("@Password", HashPassword(password));
            
            SqlParameter userIdParam = new SqlParameter("@UserId", SqlDbType.Int);
            userIdParam.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(userIdParam);
            
            SqlParameter successParam = new SqlParameter("@Success", SqlDbType.Bit);
            successParam.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(successParam);
            
            SqlParameter messageParam = new SqlParameter("@Message", SqlDbType.NVarChar, 200);
            messageParam.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(messageParam);
            
            cmd.ExecuteNonQuery();
            
            return new RegisterResult
            {
                UserId = userIdParam.Value != DBNull.Value ? (int)userIdParam.Value : 0,
                Success = successParam.Value != DBNull.Value && (bool)successParam.Value,
                Message = messageParam.Value != DBNull.Value ? messageParam.Value.ToString() : ""
            };
        }
    }
}

// Register.aspx.cs'de kullanım:
protected void btnRegister_Click(object sender, EventArgs e)
{
    var result = RegisterUser(
        txtFullName.Text,
        txtEmail.Text,
        txtPhoneNumber.Text,
        txtPassword.Text
    );
    
    if (result.Success)
    {
        ltrMesaj.Text = "<div class='alert alert-success'>" + result.Message + "</div>";
        // Formu temizle
        txtFullName.Text = "";
        txtEmail.Text = "";
        txtPhoneNumber.Text = "";
        txtPassword.Text = "";
    }
    else
    {
        ltrMesaj.Text = "<div class='alert alert-danger'>" + result.Message + "</div>";
    }
}


// =============================================
// YARDIMCI METODLAR
// =============================================

// Şifre hashleme (örnek - gerçek projede BCrypt veya SHA256 kullanın)
private string HashPassword(string password)
{
    // Örnek: Gerçek projede güvenli hash kullanın
    using (var sha256 = System.Security.Cryptography.SHA256.Create())
    {
        var hashedBytes = sha256.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
        return Convert.ToBase64String(hashedBytes);
    }
}


