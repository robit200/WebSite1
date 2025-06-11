using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebSite
{
    public partial class giris1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            string email = Request.Form["email"];
            string password = Request.Form["password"];

            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT UserId, Username, ProfilePic, Email FROM User_Info WHERE Email = @Email AND Password = @Password";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Email", email);
                command.Parameters.AddWithValue("@Password", password);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    string UserId = reader["UserId"].ToString();
                    string Username = reader["Username"].ToString();
                    string ProfilePic = reader["ProfilePic"].ToString();
                    string Email = reader["Email"].ToString();

                    Session["UserId"] = UserId;
                    Session["Username"] = Username;
                    Session["ProfilePic"] = ProfilePic;
                    Session["Email"] = Email;

                    Response.Redirect("main.aspx");
                }
                else
                {
                    Response.Write("<script>alert('Wrong Email or Password');</script>");
                }
            }
        }
    }
}
