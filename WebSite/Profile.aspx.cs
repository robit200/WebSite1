using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebSite
{
    public partial class Profile : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProfile();
            }
        }

        private void LoadProfile()
        {
            string Username = User.Identity.Name;
            System.Diagnostics.Debug.WriteLine("User.Identity.Name: " + Username); // Debugging 
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT Username, Bio, ProfilePic FROM User_Info WHERE Username = @Username";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Username", Username);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.Read())
                {
                    profilename.InnerText = reader["Username"].ToString();
                    profilebio.InnerText = string.IsNullOrEmpty(reader["Bio"].ToString()) ? "So empty here" : reader["Bio"].ToString();
                    string ProfilePic = reader["ProfilePic"] != DBNull.Value ? reader["ProfilePic"].ToString() : "Images/profile.jpg";
                    profilepic.Style["background-image"] = $"url('{ProfilePic}')";
                }
                else
                {
                    profilename.InnerText = Username;
                    profilebio.InnerText = "So empty here";
                    profilepic.Style["background-image"] = "url('Images/profile.jpg')";
                }
                connection.Close();
            }
        }

        protected void EditButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("ProfileEdit.aspx");
        }
    }
}
