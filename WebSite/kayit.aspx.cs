using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite
{
    public partial class kayit : System.Web.UI.Page
    {
        protected global::System.Web.UI.WebControls.TextBox name;

        protected TextBox nameTextBox;
        protected TextBox surnameTextBox;
        protected TextBox emailTextBox;
        protected TextBox usernameTextBox;
        protected TextBox passwordTextBox;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SignUp_Click(object sender, EventArgs e)
        {
            bool hasError = false;

            if (string.IsNullOrWhiteSpace(nameTextBox.Text))
            {
                nameErrorLabel.Visible = true;
                hasError = true;
            }
            else
            {
                nameErrorLabel.Visible = false;
            }

            if (string.IsNullOrWhiteSpace(surnameTextBox.Text))
            {
                surnameErrorLabel.Visible = true;
                hasError = true;
            }
            else
            {
                surnameErrorLabel.Visible = false;
            }

            if (string.IsNullOrWhiteSpace(emailTextBox.Text))
            {
                emailErrorLabel.Visible = true;
                hasError = true;
            }
            else
            {
                emailErrorLabel.Visible = false;
            }

            if (string.IsNullOrWhiteSpace(usernameTextBox.Text))
            {
                usernameErrorLabel.Visible = true;
                hasError = true;
            }
            else
            {
                usernameErrorLabel.Visible = false;
            }

            if (string.IsNullOrWhiteSpace(passwordTextBox.Text))
            {
                passwordErrorLabel.Visible = true;
                hasError = true;
            }
            else
            {
                passwordErrorLabel.Visible = false;
            }

            if (hasError)
            {
                return;
            }

            string name = nameTextBox.Text;
            string surname = surnameTextBox.Text;
            string email = emailTextBox.Text;
            string username = usernameTextBox.Text;
            string password = passwordTextBox.Text;
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO User_Info (Name, Surname, Email, Username, Password) VALUES (@Name, @Surname, @Email, @Username, @Password)";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Name", name);
                    command.Parameters.AddWithValue("@Surname", surname);
                    command.Parameters.AddWithValue("@Email", email);
                    command.Parameters.AddWithValue("@Username", username);
                    command.Parameters.AddWithValue("@Password", password);
                    connection.Open();
                    command.ExecuteNonQuery();
                    connection.Close();
                }
            }
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Successfully registered! You are being redirected to the login page.'); window.location='giris.aspx';", true);
        }
    }
}
