[WebMethod]
public static Dictionary<string, int> GetAccountCounts()
{
    // Example: Replace with your actual data source
    return new Dictionary<string, int> {
        { "US", 120 },
        { "TR", 45 },
        { "DE", 30 }
    };
}