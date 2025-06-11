using Google.Apis.Auth.OAuth2;
using Google.Cloud.Dialogflow.V2;
using Grpc.Auth;
using System;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

namespace WebSite
{
    public partial class main : Page
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
            if (Session["Email"] == null)
            {
                Response.Redirect("giris.aspx");
            }

            string connectionString = "Data Source=DESKTOP-62ES7HP;Initial Catalog=letterly;Integrated Security=True";
            string query = "SELECT Username, ProfilePic FROM User_Info WHERE Email = @Email";
            string defaultProfilePic = "Images/profile.jpg";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Email", Session["Email"]);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.Read())
                {
                    string Username = reader["Username"].ToString();
                    string profilePic = reader["ProfilePic"].ToString();

                    if (string.IsNullOrEmpty(profilePic))
                    {
                        profilePic = defaultProfilePic;
                    }

                    profilepic.Attributes["style"] = $"background-image: url('{profilePic}');";
                    profilename.InnerText = Username;
                }
                reader.Close();
            }
        }

        [System.Web.Services.WebMethod]
        public static string SendMessageToDialogflow(string message)
        {
            try
            {
                // JSON Kimlik Doğrulama
                var credentialPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "App_Data", "your_service_account_key.json");
                var credential = GoogleCredential.FromFile(credentialPath).CreateScoped(SessionsClient.DefaultScopes);
                var channel = new Grpc.Core.Channel(SessionsClient.DefaultEndpoint.ToString(), credential.ToChannelCredentials());

                var client = SessionsClient.Create();

                // Benzersiz bir oturum oluştur
                var sessionName = new SessionName("penpal-rfjo", Guid.NewGuid().ToString());

                // Mesajı işleme
                var queryInput = new QueryInput
                {
                    Text = new TextInput
                    {
                        Text = message,
                        LanguageCode = "tr, en" 
                    }
                };

                // Intent algılama
                var response = client.DetectIntent(sessionName, queryInput);
                return response.QueryResult.FulfillmentText; // Bot cevabı
            }
            catch (Exception ex)
            {
                // Hataları loglama
                return $"Error: {ex.Message}";
            }
        }

        protected void LogoutLink_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("giris.aspx");
        }
    }
}
