using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace WebSite
{
    public partial class ProfileEdit : System.Web.UI.Page
    {
        protected HtmlGenericControl profilepicControl;
        protected HtmlGenericControl profilenameControl;
        protected System.Web.UI.WebControls.TextBox bioTextBox;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string ProfilePic = "Images/profile.jpg";
                string Username = Session["Username"] as string;

                if (!string.IsNullOrEmpty(Username))
                {
                    profilenameControl.InnerText = Username;
                    string bio = GetUserBio(Username);
                    this.bioTextBox.Text = string.IsNullOrEmpty(bio) ? "So empty here" : bio;
                }
                else
                {
                    Response.Redirect("giris.aspx");
                }
            }
        }

        private string GetUserBio(string username)
        {
            string bio = string.Empty;

            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT Bio FROM User_Info WHERE Username = @Username";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Username", username);

                try
                {
                    connection.Open();
                    object result = command.ExecuteScalar();
                    if (result != null)
                    {
                        bio = result.ToString();
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }

            return bio;
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            string username = HttpContext.Current.User.Identity.Name;

            string bio = this.bioTextBox.Text;
            if (bio == "So empty here")
            {
                bio = string.Empty;
            }
            UpdateUserBio(username, bio);

            Response.Redirect("Profile.aspx");
        }

        private void UpdateUserBio(string username, string bio)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "UPDATE User_Info SET Bio = @Bio WHERE Username = @Username";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Bio", bio);
                command.Parameters.AddWithValue("@Username", username);

                try
                {
                    connection.Open();
                    command.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }
        }
    }
}
