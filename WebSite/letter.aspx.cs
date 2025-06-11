using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.HtmlControls;

namespace WebSite
{
    public partial class letter : System.Web.UI.Page
    {
        protected HtmlGenericControl profilePic;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Email"] == null)
                {
                    Response.Redirect("giris.aspx");
                }
                else
                {
                    LoadProfilePicture();
                    LoadInbox();
                }
            }
        }

        private void LoadProfilePicture()
        {
            string email = Session["Email"]?.ToString();
            if (email == null)
            {
                Response.Redirect("giris.aspx");
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            string ProfilePic = "Images/profile.jpg"; // Default profile picture

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT ProfilePic FROM User_Info WHERE Email = @Email";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Email", email);
                    connection.Open();
                    object result = command.ExecuteScalar();
                    if (result != null && !string.IsNullOrEmpty(result.ToString()))
                    {
                        ProfilePic = result.ToString();
                    }
                }
            }

            profilePic.Style["background-image"] = $"url('{ProfilePic}')";
        }

        protected void SendButton_Click(object sender, EventArgs e)
        {
            string recipientUsername = recipient.Value;
            string letterContent = letterText.Value;

            try
            {
                // Get recipient email from database
                string recipientEmail = GetRecipientEmail(recipientUsername);

                if (string.IsNullOrEmpty(recipientEmail))
                {
                    Response.Write("Recipient not found.");
                    return;
                }

                // Save to database
                SaveLetterToDatabase(recipientEmail, letterContent);

                Response.Write("Letter sent successfully.");
            }
            catch (Exception ex)
            {
                Response.Write("An error occurred while sending the letter: " + ex.Message);
            }
        }

        private string GetRecipientEmail(string recipientUsername)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT Email FROM User_Info WHERE Username = @RecipientUsername";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@RecipientUsername", recipientUsername);

                    connection.Open();
                    object result = command.ExecuteScalar();
                    return result?.ToString();
                }
            }
        }

        private void SaveLetterToDatabase(string recipientEmail, string letterContent)
        {
            string senderUsername = GetCurrentUsername();
            string subject = "Letter";

            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Letters (RecipientEmail, LetterContent, SentDate, Sender, Subject) VALUES (@RecipientEmail, @LetterContent, @SentDate, @Sender, @Subject)";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@RecipientEmail", recipientEmail);
                    command.Parameters.AddWithValue("@LetterContent", letterContent);
                    command.Parameters.AddWithValue("@SentDate", DateTime.Now);
                    command.Parameters.AddWithValue("@Sender", senderUsername);
                    command.Parameters.AddWithValue("@Subject", subject);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        private void LoadInbox()
        {
            string currentUserEmail = GetCurrentUserEmail();

            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT Sender, Subject, SentDate, LetterContent FROM Letters WHERE RecipientEmail = @RecipientEmail ORDER BY SentDate DESC";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@RecipientEmail", currentUserEmail);

                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        inboxRepeater.DataSource = reader;
                        inboxRepeater.DataBind();
                    }
                }
            }
        }

        private string GetCurrentUserEmail()
        {
            return Session["Email"]?.ToString();
        }

        private string GetCurrentUsername()
        {
            return Session["Username"]?.ToString();
        }
    }
}
