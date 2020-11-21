<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;


public class Handler : IHttpHandler {
    public string exp;    
    public void ProcessRequest (HttpContext context) {
        System.Data.SqlClient.SqlDataReader rdr = null;
        System.Data.SqlClient.SqlConnection conn = null;
        System.Data.SqlClient.SqlCommand sqlcmd = null;

        try
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            conn = new System.Data.SqlClient.SqlConnection(connectionString);

            sqlcmd = new System.Data.SqlClient.SqlCommand("select PhotoContent from PhotoStore where PhotoID='" + context.Request.QueryString["id"] + "'", conn);
            conn.Open();
            rdr = sqlcmd.ExecuteReader();
            while (rdr.Read())
            {

                context.Response.ContentType = "image/jpeg";
                context.Response.BinaryWrite((byte[])rdr["PhotoContent"]);
                
            }
            if (rdr != null)
                rdr.Close();
        }
        catch (Exception ex)
        {
            exp = ex.ToString();
        }
            
        finally
        {
            if (conn != null)
                conn.Close();
        }
    
        
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}